Return-Path: <linux-fsdevel+bounces-48276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EB6AACC80
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 19:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882CA5056FD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 17:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241B32857C9;
	Tue,  6 May 2025 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="b0P9HVbl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114A920B806;
	Tue,  6 May 2025 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746553868; cv=none; b=O445Wwy5Y5PiluPR8k9zRLjft0Jspt2h5SnOhtuQaZt83vLn+nJi5dkZ4/nfv57KJP6c3zwE2kXs7xCyKV78rWjebM38txtG0QrfIiz22TXqO7qyO83OPUg9Tp43LZGjtAjSlKXJyzo7Aqq0dbPlPGdpu9Rdp3uuw6gzDD1pB78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746553868; c=relaxed/simple;
	bh=tNHkYVaPLR66Jwo6P/hAd7RGYTFoS8PrUrPK82+TRfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYsW/85O3CFNNRnOV5i+Mqs8plpTj/Bgku27A0wkKt9dbosFKBHmOG8JJEOEfFIpwg97AROnCSJNhovDV3v8BQGk9AcPkluFZjRY7c5I8P2HcSsq+JBbcte1fNNAGtPsGeOg5581u0saTDanFgH6ZCE5+vhID9avISTj8tnclzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=b0P9HVbl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2btRWPwA9on4qXX8cdT3XjkC1igfIwg9iKd03qmtBNE=; b=b0P9HVblelra/46iw7YxdEPuLb
	DkqILc4752tu274SXheDygaSKYnxoFdPXkPvr88onFSIXKpxHZmFSD2ci3SBNjHiEOQMq2bw/hXmk
	nvIlxs+QGyRmuXn/FbN+A5zvYnSLBOXyNpk2OvFpldJUjVwGEFiVpEymMxVuS9O3ssWmkCym53gZU
	VnnBSVakpZJOt+ThOrYLLpj76064phvIct6YorBIlqO+f4hig+QYcoc7dfD061+/JRvP2WYhR778G
	njldhSlH/UsSgNAS1tuyDf7c5sjpTKoLK8rNfpl/L5GgTzs69GYSKQWI/FylHTbCAdnfClKhgO3G1
	7Nl6/d8w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCMRc-0000000Brin-0Hnf;
	Tue, 06 May 2025 17:51:04 +0000
Date: Tue, 6 May 2025 18:51:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Klara Modin <klarasmodin@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <20250506175104.GO2023217@ZenIV>
References: <20250505030345.GD2023217@ZenIV>
 <3qdz7ntes5ufac7ldgfsrnvotk4izalmtdf7opqox5mk3kpxus@gabtxt27uwah>
 <20250506172539.GN2023217@ZenIV>
 <j2tom2y6562wa7r6wjsxwgc25t3uoine45ills367o4y2booxr@3jdyomwkvt6w>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j2tom2y6562wa7r6wjsxwgc25t3uoine45ills367o4y2booxr@3jdyomwkvt6w>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 06, 2025 at 07:47:29PM +0200, Klara Modin wrote:
> On 2025-05-06 18:25:39 +0100, Al Viro wrote:
> > On Tue, May 06, 2025 at 03:36:03PM +0200, Klara Modin wrote:
> > 
> > >   25:	49 8b 44 24 60       	mov    0x60(%r12),%rax
> > 	rax = fc->root
> > >   2a:*	48 8b 78 68          	mov    0x68(%rax),%rdi		<-- trapping instruction
> > 	rdi = rax->d_sb, hitting rax == 0
> > 
> > > > -	mnt = fc_mount(dup_fc);
> > > > -	if (IS_ERR(mnt)) {
> > > > -		put_fs_context(dup_fc);
> > > > -		return PTR_ERR(mnt);
> > > > +	ret = vfs_get_tree(dup_fc);
> > > > +	if (!ret) {
> > > > +		ret = btrfs_reconfigure_for_mount(dup_fc);
> > > > +		up_write(&fc->root->d_sb->s_umount);
> > 
> > ... here.  D'oh...  Should be dup_fc, obviously - fc->root hadn't been
> > set yet.  Make that line
> > 		up_write(&dup_fc->root->d_sb->s_umount);
> > and see if it helps.  Sorry about the braino...
> 
> Thanks, that fixes the oops for me.
> 
> Though now I hit another issue which I don't know if it's related or
> not. I'm using an overlay mount with squashfs as lower and btrfs as
> upper. The mount fails with invalid argument and I see this in the log:
> 
> overlayfs: failed to clone upperpath

Seeing that you already have a kernel with that thing reverted, could
you check if the problem exists there?

