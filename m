Return-Path: <linux-fsdevel+bounces-2823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7C37EB37B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F3E1F24CA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 15:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B54041755;
	Tue, 14 Nov 2023 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="E+0fInP0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4AC41227;
	Tue, 14 Nov 2023 15:26:14 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A1B93;
	Tue, 14 Nov 2023 07:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iksz4wvrrAe3MrzMi4Syux0ALWcXSqTNlCCEFGxtMiA=; b=E+0fInP01H8oXGNYXwy2zIWHxc
	QnhFlc5yYUp9Gj19CLutDX/Au7blOKcbuaAZ7vAhDJWKiShkJeEvm3bpxRx9XkHieoHf5n7CgRceH
	kOPPBN74RUaRwfYDzraLB9x1tCS4X1UP7l9kG8EyQT9hLTm7QdqdjF+FhKjwMtTiEpVZMlFgRamP8
	pB/pFd64pY7g7lCRRplbmdzN3LuDOn/EPI/Tm+1JgvefXPFdOWUcD0mya1zBWbWPbkahqGpR705Bt
	tt50Lb2viJo9DeQ3VTcEUlBST4ypo+zS5jxZxyf73x8l7k0pWWMIfTtQ/KHokXSSZ+vtm7qnShBFO
	L+LzMFpA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r2vIf-00Fizn-1h;
	Tue, 14 Nov 2023 15:26:01 +0000
Date: Tue, 14 Nov 2023 15:26:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ian Kent <raven@themaw.net>
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com,
	autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] autofs: fix null deref in autofs_fill_super
Message-ID: <20231114152601.GS1957730@ZenIV>
References: <000000000000ae5995060a125650@google.com>
 <tencent_3744B76B9760E6DA33798369C96563B2C405@qq.com>
 <4fcf49456c32087f5306e84c4a8df5b2bd9f4146.camel@themaw.net>
 <20231114044110.GR1957730@ZenIV>
 <e2654c2c-947a-60e5-7b86-9a13590f6211@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2654c2c-947a-60e5-7b86-9a13590f6211@themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 14, 2023 at 04:30:25PM +0800, Ian Kent wrote:

> I'll prepare a patch, the main thing that I was concerned about was
> 
> whether the cause really was NULL root_inode but Edward more or less
> 
> tested that.

One thing: that was a massaged copy of the variant in my local tree, so
this

> > 		managed_dentry_set_managed(s->s_root);

might be worth an explanation; mainline has __managed_dentry_set_managed()
here, and yes, it is safe since nothing can access it yet, but... it's
not worth skipping on spin_lock/spin_unlock for ->d_flags update here.

