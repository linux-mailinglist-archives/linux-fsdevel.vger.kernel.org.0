Return-Path: <linux-fsdevel+bounces-2493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC55F7E640C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852C52812D0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D9C6AA7;
	Thu,  9 Nov 2023 06:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mK0CLoLo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A702582;
	Thu,  9 Nov 2023 06:55:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECE42704;
	Wed,  8 Nov 2023 22:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DSW2C9vVblA5qyfFf6Ad8TPAqUMUuRB8COUKYsKtrBc=; b=mK0CLoLo+ZE9prfKIeexNL+/0F
	y+xe3JrBGdCqu3dArHQJsi+/0u1oYeKctGWbEhES2hDuPZK1wSsi7LBSSLlVLLp0gjOA0/uuoS5oD
	lBUHdyGA3h6rME2qNmQYV2FeYp5YgTr0RR2JxlxxnrgDx/GkNyExDjA1AaX30VVFedo3cQddJsLXC
	G1SWFYN1/oDo45HuFGdSigvLkozbKt1yO5NyV96Z7xF5MIecbls8HE4v5FivTDHfN7ykaSMfEEfzY
	65geAGL/UOfVswksuCuayvp8DDJm/9aNC8wKXyFGO5tBWRb+7zS40iqFUqJ6g4mweqMUjOHCrK1Qf
	fgigZMfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0yxE-005RvC-2q;
	Thu, 09 Nov 2023 06:55:52 +0000
Date: Wed, 8 Nov 2023 22:55:52 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUyCeCW+BdkiaTLW@infradead.org>
References: <ZUjcI1SE+a2t8n1v@infradead.org>
 <20231106-unser-fiskus-9d1eba9fc64c@brauner>
 <ZUker5S8sZXnsvOl@infradead.org>
 <20231106224210.GA3812457@perftesting>
 <20231107-leiden-drinnen-913c37d86f37@brauner>
 <ZUs+MkCMkTPs4EtQ@infradead.org>
 <20231108-zertreten-disqualifikation-bd170f2e8afb@brauner>
 <ZUuWSVgRT3k/hanT@infradead.org>
 <20231108-atemwege-polterabend-694ca7612cf8@brauner>
 <20231108-herleiten-bezwangen-ffb2821f539e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108-herleiten-bezwangen-ffb2821f539e@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 08, 2023 at 05:20:06PM +0100, Christian Brauner wrote:
> This would also allow tools that want to to detect when they're crossing
> into a new subvolume - be it on btrfs or bcachefs - and take appropriate
> measures deciding what they want to do just relying on statx() without
> any additional system calls.

How?  If they want to only rely on Posix and not just he historical
unix/linux behavior they need to compare st_dev for the inode and it's
parent to see if it the Posix concept of a mount point (not to be
confused with the Linux concept of a mountpoint apparently) because
that allows the file system to use a new inode number namespace.


