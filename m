Return-Path: <linux-fsdevel+bounces-48289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC37EAACE19
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 21:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA121C23C1C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 19:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6BF1A42C4;
	Tue,  6 May 2025 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="A+OBLBkc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BED172614;
	Tue,  6 May 2025 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746559990; cv=none; b=Mn1dUAp+xWXYZ1Thvl93tcMTxR7olb+TkYHHQ2hwy0n7IJlVQmRTGx8+Ze3DF4gG3yA6rs93mlKbELXU3kx/IWVYmSrzuWnjKAL1EttM6+/zxLHOVzB6x6kiiYGmjvujERMGEPbYqDtjYYWZ197caNaSV/N9heUetXr5uGEA2A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746559990; c=relaxed/simple;
	bh=cS1lffRJwPiwXub8seclbRGiFPpLapcTUzx7Y1VKIdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TA5j7Uw1WuFdj/EIH6aR1vJZRcHKY9EaY+rAPGJkrfE76iS8v6DZOq55Wy4bWs0hUTjiaZIFVAm2vduCaThRMgE3UyuiwMGkKWhZqb/58HhgUd8eiYFVK+JlCdQRzRCKrgN4lf8ekqqU8X6n0v34OkMtnhaMpNvl4KjYWWdFi34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=A+OBLBkc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wE/3baADwzaiLD3PHNklC2Tn5A4xQFZ4WAopD0vuzz8=; b=A+OBLBkcHQrwMgy0AqMRgbNyXC
	wEJwYPbWpcyAr1d06OD7SApKcqKyUrD6p8XgEEZuTa6tnxlxJXWxFoG/IHRRq36RQ/ZU2p2jRxE9l
	wAmBpPcyQl1Pw6OkjRHkKEEiLtDWZZyRWUnd5xoSLWmu5p0qznR3z687sLkuElkSRpcDu3CfSG4NF
	jaX4EXKLFCqM6jHlQm0hhk8sYcVweO2I5El4N00ddixYF5PkI7lfWecSrXZ2GtAck4ksVvMd9HfZr
	QHHaMA2O4VnTNs0L1O8vNkJig26LXxD974nHCf2Wzb1X7Mw38hbnrjxL6mpwv76wnSHcPVbubvNvf
	WLRH6sbQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCO2L-0000000CLU4-3ben;
	Tue, 06 May 2025 19:33:05 +0000
Date: Tue, 6 May 2025 20:33:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Klara Modin <klarasmodin@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <20250506193305.GR2023217@ZenIV>
References: <20250505030345.GD2023217@ZenIV>
 <3qdz7ntes5ufac7ldgfsrnvotk4izalmtdf7opqox5mk3kpxus@gabtxt27uwah>
 <20250506172539.GN2023217@ZenIV>
 <j2tom2y6562wa7r6wjsxwgc25t3uoine45ills367o4y2booxr@3jdyomwkvt6w>
 <20250506175104.GO2023217@ZenIV>
 <4pg5rjsoxzxjgcx2wzucw2wr7uvaxws423stdlv75t2udfkash@jff3ci54z35u>
 <20250506181604.GP2023217@ZenIV>
 <usokd3dnditdgjf772khf76rwjczn3qfd2qtxgxyvmqxpf5wmb@yfb66jhpnwtd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <usokd3dnditdgjf772khf76rwjczn3qfd2qtxgxyvmqxpf5wmb@yfb66jhpnwtd>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 06, 2025 at 08:58:59PM +0200, Klara Modin wrote:
> > OK, let's try to see what clone_private_mount() is unhappy about...
> > Could you try the following on top of -next + braino fix and see
> > what shows up?  Another interesting thing, assuming you can get
> > to shell after overlayfs mount failure, would be /proc/self/mountinfo
> > contents and stat(1) output for upper path of your overlayfs mount...
> 
> 	ret = vfs_get_tree(dup_fc);
> 	if (!ret) {
> 		ret = btrfs_reconfigure_for_mount(dup_fc);
> 		up_write(&dup_fc->root->d_sb->s_umount);
> 	}
> 	if (!ret)
> 		mnt = vfs_create_mount(fc);
> 	else
> 		mnt = ERR_PTR(ret);
> 	put_fs_context(dup_fc);
> 
> 
> I tried replacing fc with dup_fc in vfs_create_mount and it seems to
> work.

*blink*

OK, I'm a blind idiot - blind for not seeing the braino duplication,
idiot for not thinking to check if the same thing has happened
more than once.

Kudos for catching that.  I still wonder what the hell got passed
to overlayfs, though - vfs_create_mount() should've hit
        if (!fc->root)
		return ERR_PTR(-EINVAL);
since fc->root definitely was NULL there.  So we should've gotten
a failing btrfs mount; fine, but that does not explain the form
of breakage you are seeing on the overlayfs side...  Actually...
is that mount attempted while still on initramfs?  Because if
it is, we are running into a separate clone_private_mount()
bug.

There's nothing to prohibit an overlayfs mount with writable layer
being a subtree of initramfs; odd, but nothing inherently wrong
with that setup.  And prior to that clone_private_mount() change
it used to be fine; we would get a private mount with root
pointing to subtree of initramfs and went on to use that.

We used to require the original mount to be in our namespace;
Christian's change added "... or root of anon namespace".
The order of checks went wrong, though.  We check for "is
it an absolute root" *first* and treat that as a discriminator
between the new and old cases.  It should be the other way
round - "is it in our namespace" should take precedence.

IOW,
	if (!check_mount(...)) { // if it's not ours...
		// ... it should be root...
		if (mnt_has_parent(...))
			fail
		// ... of anon namespace...
		if (!is_mounted(...) || !is_anon_ns(...))
			fail
		// ... and create no namespace loops -
		// or no hidden references to namespaces, period
		if (mnt_ns_loop(...)) // or, perhaps, if (mnt_ns_from_dentry(...))
			fail
	}
Anyway, that's a separate issue.

