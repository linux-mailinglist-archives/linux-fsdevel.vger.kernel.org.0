Return-Path: <linux-fsdevel+bounces-2878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7E47EBA9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 01:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2161F250B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 00:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C799621;
	Wed, 15 Nov 2023 00:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YvyxGb2h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A814E181;
	Wed, 15 Nov 2023 00:35:35 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B5DC2;
	Tue, 14 Nov 2023 16:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j6H43ceFH+uSiYPqAdZsKlJaFqzhz6+CW2Ahj89Kc+s=; b=YvyxGb2hvJdkrl3jGj+xejtca0
	PdtQGqbhlPXciTcKj+2aFcyQTcHh7sGZAn6pZs4ZqkLfo0lwUT8Iep8ZTr9Wvl7rXdxs0XODv22cn
	1qS1jQz1qGwHDVU3PZT9rz+Sz1wrVTKBCy3mVZlE4ubl2fMCeAtRscVxI+xyyAdRCm/NvLcyycNFQ
	ya8qLR8SMD3o4RIWuuEljSxF1U04Yk4K/eSRwKKFni2qHOluqwyAjf8x6GYOOxfsMcjMu84zRa5dz
	oSPn6WRHhnr/HoRRTP7ncFbcO1gC0m4F39PaOTOJ7BF8zQNsmmZMm1LhDrYs6hZJ++gAqvBWsb9HK
	5Mc2yIJQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r33sN-00FtHQ-2K;
	Wed, 15 Nov 2023 00:35:27 +0000
Date: Wed, 15 Nov 2023 00:35:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ian Kent <raven@themaw.net>
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com,
	autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] autofs: fix null deref in autofs_fill_super
Message-ID: <20231115003527.GW1957730@ZenIV>
References: <000000000000ae5995060a125650@google.com>
 <tencent_3744B76B9760E6DA33798369C96563B2C405@qq.com>
 <4fcf49456c32087f5306e84c4a8df5b2bd9f4146.camel@themaw.net>
 <20231114044110.GR1957730@ZenIV>
 <e2654c2c-947a-60e5-7b86-9a13590f6211@themaw.net>
 <20231114152601.GS1957730@ZenIV>
 <7b982b5e-ecad-1b55-7388-faf759b65cfe@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b982b5e-ecad-1b55-7388-faf759b65cfe@themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 15, 2023 at 08:18:33AM +0800, Ian Kent wrote:

> I guess that including the locking is not going to make much difference.
> 
> I don't remember now but it was probably done because there may be many
> 
> mounts (potentially several thousand) being done and I wanted to get rid
> 
> of anything that wasn't needed.

Seeing that lock in question is not going to be contended... ;-)

Seriously, though - the fewer complications we have in the locking rules,
the better.

Al, currently going through audit of ->d_name/->d_parent uses and cursing
at the 600-odd places left to look through...

