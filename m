Return-Path: <linux-fsdevel+bounces-59659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9BEB3C0E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 18:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E17E7B3852
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 16:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93313314DD;
	Fri, 29 Aug 2025 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eTyqQyD8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39415320389
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485443; cv=none; b=JB5MNxpBhM3Fqtl/GnhyK4IKpBLoOzYOqUdqlReNg+vv6P08ccTAiCr5Ki0StxAL1yxdFNkwgvXWj2+1qwoyrlPvXeDVWZ/Sy6fRu+WhrA0qoL6fUMaITCxoUaxh/t2Tzl+k9PanLmsMaz6Iqd9AXo3wUn9l2jc60hU3c1//ZF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485443; c=relaxed/simple;
	bh=mzlowcnqzm55fUnaamcXA7RMtnrPA2uIV5dHg5Mr4mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qhb+O4N4QmaUC092DAhMrhfyTczmotB2PCUDZEXJZibQwZHx8IIaOAY/dtAn+MBbCWXXg9xyFWxI98FDbpAlS3pnnV75hkiWqMonfqEK3HLNEbQFb9e5zZX+9SQTOsvcbyuYM+zYL2qV6UsUhVH9/bV3VctqE7ZTqfa1aHXC56k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eTyqQyD8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zpFPRuEg2nLGPmlB2Ux2WbODPUM/dvS7PSjEeguC13U=; b=eTyqQyD8Kksltv0TE+jhHotdWr
	I1VLiQeX5e2ok2FkF/mN88X15lcBiaekBvn/aOsCDe7sUDqJFj0EWR8ZXdaVgPAxx0OY43YjCqac4
	ezT9LKXZ2B6FTOuobb2gFpN6QwS5jfwz0pApkdI7ERbx5UdnVRVei1vYjpowXRKWTfas/TufnjPty
	Ab/pZWZ6yXjj2+hTr4hJa6ymKqE7IrxGdE0IkKA+TBSgUOW6MDtlmUsCNJVfP76nL7pU6q1V/Yqv1
	vieGaaqi/deFXrYBxrjE/0xFMj3ZiEh/X8uZKXIEeRXYDq6bF/qMXeITJtLE5gDIj98mPqB1BY/f1
	83eWuVag==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us26H-0000000Bv4I-0mgd;
	Fri, 29 Aug 2025 16:37:17 +0000
Date: Fri, 29 Aug 2025 17:37:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, jack@suse.cz
Subject: Re: [60/63] setup_mnt(): primitive for connecting a mount to
 filesystem
Message-ID: <20250829163717.GD39973@ZenIV>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-61-viro@zeniv.linux.org.uk>
 <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
 <20250829001109.GB39973@ZenIV>
 <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com>
 <20250829060306.GC39973@ZenIV>
 <20250829060522.GB659926@ZenIV>
 <20250829-achthundert-kollabieren-ee721905a753@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829-achthundert-kollabieren-ee721905a753@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Aug 29, 2025 at 11:59:55AM +0200, Christian Brauner wrote:
> On Fri, Aug 29, 2025 at 07:05:22AM +0100, Al Viro wrote:
> > Take the identical logics in vfs_create_mount() and clone_mnt() into
> > a new helper that takes an empty struct mount and attaches it to
> > given dentry (sub)tree.
> > 
> > Should be called once in the lifetime of every mount, prior to making
> > it visible in any data structures.
> > 
> > After that point ->mnt_root and ->mnt_sb never change; ->mnt_root
> > is a counting reference to dentry and ->mnt_sb - an active reference
> > to superblock.
> > 
> > Mount remains associated with that dentry tree all the way until
> > the call of cleanup_mnt(), when the refcount eventually drops
> > to zero.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> 
> Is this supposed to be the v3? I'm confused what I need to be looking
> at since it's a reply to v2 and some earlier review comments...

It would be in v3, but I didn't feel like sending another 63-patch
mailbomb for the sake of these 4 changed commits (well, and a cosmetical
change in #33, with matching modification in #35, ending with both
being cleaner - with the same resulting tree after #35).

These 4 do repace #59..#62 in v3.

