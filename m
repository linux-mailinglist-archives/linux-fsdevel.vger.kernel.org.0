Return-Path: <linux-fsdevel+bounces-35225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C329D2B10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 17:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1091F227D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 16:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E348A1D04A9;
	Tue, 19 Nov 2024 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="I2Q1tjxc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F286F1CC179;
	Tue, 19 Nov 2024 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034214; cv=none; b=dyAC2iPsFO4JhmrEEgxGDn43srlD+PJa63e14BsCXYoc8Ov2vpGAh1TgnZllDkWGYygFtyeRi743HqdtiqXoLxKRRGfor9Vdvo3/pdlgzHpk+mZi/kmfOTXk/bLk5sH17gmaY1aChWrgVEcqhFb5LGojRHKQ74HM3ZBWnz0owQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034214; c=relaxed/simple;
	bh=g9yNBvgNUYNnnRHq1dncCijrNAkTmtMpv8j3uVO8LnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQ5l0q5etGgYepTJ3KzcjWOdNbQ5mKjSLCvmqU/8b7y+JysWgjacG2Ojq8L0fWXs8m4ItKzlL0pA51O7fRchYwatiog1RDMINTOxFM/2X9PzQaEHT8stMHCYFWWuhcrsCtrDUzq3MBz94QkVv0cQl5ZFbWBu2EKNzyRIJlhyryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=I2Q1tjxc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HH/dehGAT46J2MVPiKsByUYBR/gJNE/h33s8HK3S7g8=; b=I2Q1tjxcnIrb9p/Xt2Qi62mkjG
	yHvDSnOpovFZ7G24D3VjpV9idwNmsqOUGTrhx7BJe06jefJ+hvuK2cONmdZ/7gTpM0xVGVbxHq1L0
	ndv50rfdJPHBGBD2A9CKtFw0SovbeG47MPGOjXuSG3SPlDQeJveBVXnklrQ14iJdzcgGV1crIVkii
	rb/JFmb5dP8SPCmRfjgJvSvfJpHA1reao7doL4BlysP25NjOFmiZb94JW/kofl4LuKJY/gf1iIPpO
	7lyHJUmcHWHP/Sp70scCygcf7OrG5XZNOl87aptBH7S9SKIagw71tIZfwR+B31QhXZfJX/saNQJAE
	ERSL4YHw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDRDb-0000000H0dk-3qJI;
	Tue, 19 Nov 2024 16:36:47 +0000
Date: Tue, 19 Nov 2024 16:36:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: almaz.alexandrovich@paragon-software.com, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] fs: improve the check of whether i_link has been set
Message-ID: <20241119163647.GJ3387508@ZenIV>
References: <20241116023241.GZ3387508@ZenIV>
 <20241119112945.767118-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119112945.767118-1-lizhi.xu@windriver.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 19, 2024 at 07:29:45PM +0800, Lizhi Xu wrote:
> syzbot reported a null-ptr-deref in pick_link. [1]
> 
> First, i_link and i_dir_seq are in the same union, they share the same memory
> address, and i_dir_seq will be updated during the execution of walk_component,
> which makes the value of i_link equal to i_dir_seq.
> In this case, setting i_dir_seq is triggered by move_mount, and the calltrace
> is as follows:
> move_mount()->
>   user_path_at()->
>     filename_lookup()->
>       path_lookupat()->
>         lookup_last()->
>           walk_component()->
>             __lookup_slow()->
>               ntfs_lookup()->
>                 d_splice_alias()->
>                   __d_add()->
>                     end_dir_add()
> 
> In pick_link(), the simple "if (!i_link)" is used to determine whether i_link
> has been set, which is not rigorous enough.
> 
> On the other hand, the mode value of the symlink inode becomes REG because
> attr_set_size() fails to set the attribute and calls ntfs_bad_inode().
> By confirming that the i_link pointer value is valid, the null-ptr-deref
> problem in pick_link can be avoided.

So basically your theory is that make_bad_inode() is called on a live directory
inode (already reachable from dcache and remaining there), whereas the sucker
somehow gets a new dentry alias which looks like a symlink.  Right?

NAK on the "mitigation", just in case anyone decides to pick that - no matter
how we deal with the problem, sprinkling virt_addr_valid() is *NOT* a solution.

