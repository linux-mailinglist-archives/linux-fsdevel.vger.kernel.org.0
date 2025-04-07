Return-Path: <linux-fsdevel+bounces-45870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E75A7DFE9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 15:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59F1D18913CB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 13:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E922918787F;
	Mon,  7 Apr 2025 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jgp+uvVc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E625680;
	Mon,  7 Apr 2025 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033320; cv=none; b=FvA5jZ7nkrIpgkmmFjV2bA6gOXIzED8/BbFKfg6HXjZflM6Ypv6XMD/NPe8taSAn9rzW9SosbmpTE78i0RIMWJpviPchCTT3S7si2iFRaITog6/q7A9WVQoZzoa8ohXBv2l4BjAwu+7WiGVXOTY65EOUK9rO16N5Ni0TNEajmrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033320; c=relaxed/simple;
	bh=otSzXTWKIHy+tOHqwo4FBccunKR7bjeEX0rFPQBXGeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XClgWf7vzwn2TVd83zbyzfbbV4xkjQTkYvO5oE23z5epVMhq5tpH8YT7KJJmdWSHfPAzduGk4VI1t3NXC3aPUxRdLiSxCkht5b04JMP4nAtFqHNcxIkJCwzWDTnHpuXb2fyAZt1zZ0SzLIkpqb3tsVv2OOp0u66Va3TaMPxLcgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jgp+uvVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B9AC4CEDD;
	Mon,  7 Apr 2025 13:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744033320;
	bh=otSzXTWKIHy+tOHqwo4FBccunKR7bjeEX0rFPQBXGeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jgp+uvVcMbh44duVp6y/tBsJWAcHMw2tRcljemI85pXntoeQW66U8RwAQF0gNT343
	 9SUniWK6IVPDLB+UddeVxG0SWQQ6PuM0YTSds/2Xy+DdLjTMYszqvWQgFKTQRLmM52
	 dFk2LPD0YX0ifFgAjbuBFbD/sh6Yt4Zq4jgPUE4HH/k4yfcqrmtcjx8lTNQTCaN/++
	 JFCha3dRd+b9bxYSX3KHlAgj9RVrRxcDe9VRDbuWOG8OwhB89oFEcSfrbUTVlUEvT1
	 u/X4/hG2HuRaakM3pK0uIwzAyMdwpT91ine5472vhVaaL0CppOTsnZO/wt3woZDbTH
	 TZ8qpWe2cNQNg==
Date: Mon, 7 Apr 2025 15:41:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	Penglei Jiang <superman.xpt@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 0/9] fs: harden anon inodes
Message-ID: <20250407-uncool-entworfen-e9202b0f00b0@brauner>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
 <CAGudoHHbkbaeqTrNJZxCnpB_4zokQobWfK_AP4nU78B58e9Tow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHbkbaeqTrNJZxCnpB_4zokQobWfK_AP4nU78B58e9Tow@mail.gmail.com>

On Mon, Apr 07, 2025 at 12:19:45PM +0200, Mateusz Guzik wrote:
> On Mon, Apr 7, 2025 at 11:54 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > * Anonymous inodes currently don't come with a proper mode causing
> >   issues in the kernel when we want to add useful VFS debug assert. Fix
> >   that by giving them a proper mode and masking it off when we report it
> >   to userspace which relies on them not having any mode.
> >
> > * Anonymous inodes currently allow to change inode attributes because
> >   the VFS falls back to simple_setattr() if i_op->setattr isn't
> >   implemented. This means the ownership and mode for every single user
> >   of anon_inode_inode can be changed. Block that as it's either useless
> >   or actively harmful. If specific ownership is needed the respective
> >   subsystem should allocate anonymous inodes from their own private
> >   superblock.
> >
> > * Port pidfs to the new anon_inode_{g,s}etattr() helpers.
> >
> > * Add proper tests for anonymous inode behavior.
> >
> > The anonymous inode specific fixes should ideally be backported to all
> > LTS kernels.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> > Christian Brauner (9):
> >       anon_inode: use a proper mode internally
> >       pidfs: use anon_inode_getattr()
> >       anon_inode: explicitly block ->setattr()
> >       pidfs: use anon_inode_setattr()
> >       anon_inode: raise SB_I_NODEV and SB_I_NOEXEC
> >       selftests/filesystems: add first test for anonymous inodes
> >       selftests/filesystems: add second test for anonymous inodes
> >       selftests/filesystems: add third test for anonymous inodes
> >       selftests/filesystems: add fourth test for anonymous inodes
> >
> 
> I have two nits, past that LGTM
> 
> 1. I would add a comment explaining why S_IFREG in alloc_anon_inode()

        /*
         * Historically anonymous inodes didn't have a type at all and
         * userspace has come to rely on this. Internally they're just
         * regular files but S_IFREG is masked off when reporting
         * information to userspace.
         */

> 2. commit messages for selftests could spell out what's being added
> instead of being counted, it's all one-liners

I've replaced the count with chown(), chmod(), exec(), and open().

Thanks!

