Return-Path: <linux-fsdevel+bounces-3560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F197F67DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 20:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74B5BB2138A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 19:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576444D12A;
	Thu, 23 Nov 2023 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="a2QncgnU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7820D9A;
	Thu, 23 Nov 2023 11:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dqAMuOipmlmjkedrTMrMYw6IQ27y72GpypxSjNpVMec=; b=a2QncgnUb6QJ1Lg5GgMVA+2T3/
	fbNoKVoUugUVzcl9emA543J3GMHcNhnm+oCBdO+j36w8Ysf6RcjIRGYk8ImVYrVP6NTpC6pPk8Yfy
	ne4FO/7UHfFZQh3ZdS9FUageGdGYES9sh/7udHCFJmQ3qeUssJW+M1jt/WbkzSDuJZw74EONPufr0
	8qecS/s8O3lCDY2qu9K8GlNYUNsehkx8PmzntcsDJvtos+abYityUdLWCHM/tjdfSSBaPldfUHiNj
	iG0QoeEfxs2RnQinORy9UydAqRtMS5T2sMUKNxto2pYOktOZqlUdoEBPaQgQS3JpvIF5AyZX5Xa/i
	WfrihlkQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6FlP-002EPf-1m;
	Thu, 23 Nov 2023 19:53:27 +0000
Date: Thu, 23 Nov 2023 19:53:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
Message-ID: <20231123195327.GP38156@ZenIV>
References: <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner>
 <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121022734.GC38156@ZenIV>
 <20231122211901.GJ38156@ZenIV>
 <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <20231123171255.GN38156@ZenIV>
 <20231123182426.GO38156@ZenIV>
 <87bkbki91c.fsf@>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkbki91c.fsf@>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 23, 2023 at 02:06:39PM -0500, Gabriel Krisman Bertazi wrote:

> > A paragraph above you've said that it's not constant over the entire
> > filesystem.
> 
> The same ->d_op is used by every dentry in the filesystem if the superblock
> has the casefold bit enabled, regardless of whether a specific inode is
> casefolded or not. See generic_set_encrypted_ci_d_ops in my tree. It is
> called unconditionally by ext4_lookup and only checks the superblock:
> 
> void generic_set_encrypted_ci_d_ops(struct dentry *dentry)
> {
>         if (dentry->d_sb->s_encoding) {
> 		d_set_d_op(dentry, &generic_encrypted_ci_dentry_ops);
> 		return;
> 	}
>         ...
> 
> What I meant was that this used to be set once at sb->s_d_op, and
> propagated during dentry allocation.  Therefore, the propagation to the
> alias would happen inside __d_alloc.  Once we enabled fscrypt and
> casefold to work together, sb->s_d_op is NULL

Why?  That's what I don't understand - if you really want it for
all dentries on that filesystem, that's what ->s_d_op is for.
If it is not, you have that problem, no matter which way you flip ->d_op
value.

> and we always set the same
> handler for every dentry during lookup.

Not every dentry goes through lookup - see upthread for details.

> > Look, it's really simple - any setup work of that sort done in ->lookup()
> > is either misplaced, or should be somehow transferred over to the alias
> > if one gets picked.
> >
> > As for d_obtain_alias()... AFAICS, it's far more limited in what information
> > it could access.  It knows the inode, but it has no idea about the parent
> > to be.
> 
> Since it has the inode, d_obtain_alias has the superblock.  I think that's all
> we need for generic_set_encrypted_ci_d_ops.

Huh?  If it really depends only upon the superblock, just set it in ->s_d_op
when you set the superblock up.

Again, whatever setup you do for dentry in ->lookup(), you either
	* have a filesystem that never picks an existing directory alias
(e.g. doesn't allow open-by-fhandle or has a very unusual implementation
of related methods, like e.g. shmem), or
	* have that setup misplaced, in part that applies to all dentries out
there (->s_d_op for universal ->d_op value, ->d_init() for uniform allocation
of objects hanging from ->d_fsdata and other things like that), or
	* need to figure out how to transfer the result to alias (manually
after d_splice_alias(), if races do not matter or using a new method explicitly
for that), or
	* lose that state for aliases.

