Return-Path: <linux-fsdevel+bounces-30917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D13D98FAFC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 01:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB11D1F2379A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 23:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247BD1D1738;
	Thu,  3 Oct 2024 23:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VisZmV5o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A74C1D14E9
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 23:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999140; cv=none; b=EBEk3J4HNcENoz8H5qRL29f1ya8HjlhBkbg5iONE1Il78QTCeiB2YCS2VAmrwgVh9kc7umwa21ZEAqYBEjbGet0FvzSehbIi0MeWX4+BZOAUEq5ZnThweDnRLhHt6UC8sB/Gs3pojbehjkzgZF/fEt1aooF1ZxX8Uaf5BEYg/AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999140; c=relaxed/simple;
	bh=cSs+GRZOMnsCVx97hTZ1lWn1sHutaKo1dfGx5a4Eq8c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VTGg7+U7ZK2wn+3MN6NnODWY1Mql5yRrKN0bFGmQbTvw5pD+Ij2akqWIEzw0BrB7H+9aSvJGl3GTzgIz/ehS+oBCb3oWk0icRhmTdik5S66uR3/fLBph7g9EOSAWtsG8vxHtPfE6c2rcrSLer4Gs4v5GGLdOSpaAi/1jLLfhWSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VisZmV5o; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=S/nFxxifb917xcZnpvkULZvud0qZ2rP3DhocmZZzUn4=; b=VisZmV5od1IdhIoWpO5gOHePDq
	GmES0uZnzqDLh/TJucFYjtotPDniJ+btvU/cMN0onGgdMNmMUE9FZ07oMTiIGtjf17z29tFRxVJ9f
	fI9T4uGp0vgY7lnbLzIDAFGEVgRwv3YcB0c3/gXt40MxEthcAJ7uH1AykL+d05j4Emr/P194GnubG
	ZMxAe/cdNnoAeZkdySQPSaoVqRua5BIfRog2E9ALYStMg/GKY2OWb0KiXPufXx9jBE2k8fCggdHSO
	qp3AwHeWa/YcwXhXG9RkcQg53q3loG2ohjXdOPGbZzjXqb6/U8F1m22qIKme2SVZ7q7bxq4+gDfjV
	mRtR/fOA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swVVm-00000000cR6-32QZ;
	Thu, 03 Oct 2024 23:45:34 +0000
Date: Fri, 4 Oct 2024 00:45:34 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [RFC][PATCHES] struct fderr
Message-ID: <20241003234534.GM4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	overlayfs uses struct fd for the things where it does not quite
fit.  There we want not "file reference or nothing" - it's "file reference
or an error".  For pointers we can do that by use of ERR_PTR(); strictly
speaking, that's an abuse of C pointers, but the kernel does make sure
that the uppermost page worth of virtual addresses never gets mapped
and no architecture we care about has those as trap representations.
It might be possible to use the same trick for struct fd; however, for
most of the regular struct fd users that would be a pointless headache -
it would pessimize the code generation for no real benefit.  I considered
a possibility of using represenation of ERR_PTR(-EBADF) for empty struct
fd, but that's far from being consistent among the struct fd users and
that ends up with bad code generation even for the users that want to
treat empty as "fail with -EBADF".

	It's better to introduce a separate type, say, struct fderr.
Representable values:
	* borrowed file reference (address of struct file instance)
	* cloned file reference (address of struct file instance)
	* error (a small negative integer).

	With sane constructors we get rid of the field-by-field mess in
ovl_real_fdget{,_meta}() and have them serve as initializers, always
returning a valid struct fderr value.

	That results in mostly sane code; however, there are several
places where we run into an unpleasant problem - the intended scope
is nested inside inode_lock()/inode_unlock(), with problematic gotos.

	Possible solutions:
1) turn inode_lock() into guard-based thing.  No, with the side of
"fuck, no".  guard() has its uses, but
	* the area covered by it should be _very_ easy to see
	* it should not be mixed with gotos, now *OR* later, so
any subsequent changes in the area should remember not to use those.
	* it should never fall into hands of Markus-level entities.
inode_lock fails all those; guard-based variant _will_ be abstracted
away by well-meaning folks, and it will start spreading.  And existing
users are often long, have non-trivial amounts of goto-based cleanups
in them and lifetimes of the objects involved are not particularly
easy to convert to __cleanup-based variants (to put it very mildly).

We might eventually need to reconsider that, but for now the only sane
policy is "no guard-based variants of VFS locks".

2) turn the scopes into explicit compound statements.

3) take them into helper functions.

The series (in viro/vfs.git #work.fderr) tries both (2) and (3) (the
latter as incremental to the former); I would like to hear opinions
on the relative attractiveness of those variants, first and foremost
from overlayfs folks.  If (3) is preferred, the last two commits of
that branch will be collapsed together; if not - the last commit
simply gets dropped.

Please, review.  Individual patches are in followups.

Changes since the last time it had been posted:
	* s/fd_error/fd_err/, to avoid a conflict
	* s/FD_ERR/FDERR_ERR/, to have constructor names consistent
	* add a followup converting the problematic scopes into
helper calls.

Al Viro (3):
      introduce struct fderr, convert overlayfs uses to that
      experimental: convert fs/overlayfs/file.c to CLASS(...)
      [experimental] another way to deal with scopes for overlayfs real_fd-under-inode_lock

 fs/overlayfs/file.c  | 211 +++++++++++++++++++++++----------------------------
 include/linux/file.h |  37 +++++++--
 2 files changed, 128 insertions(+), 120 deletions(-)

1/3) introduce struct fderr, convert overlayfs uses to that

Similar to struct fd; unlike struct fd, it can represent
error values.

Accessors:

* fd_empty(f):	true if f represents an error
* fd_file(f):	just as for struct fd it yields a pointer to
		struct file if fd_empty(f) is false.  If
		fd_empty(f) is true, fd_file(f) is guaranteed
		_not_ to be an address of any object (IS_ERR()
		will be true in that case)
* fd_err(f):	if f represents an error, returns that error,
		otherwise the return value is junk.

Constructors:

* ERR_FDERR(-E...):	an instance encoding given error [ERR_FDERR, perhaps?]
* BORROWED_FDERR(file):	if file points to a struct file instance,
			return a struct fderr representing that file
			reference with no flags set.
			if file is an ERR_PTR(-E...), return a struct
			fderr representing that error.
			file MUST NOT be NULL.
* CLONED_FDERR(file):	similar, but in case when file points to
			a struct file instance, set FDPUT_FPUT in flags.

Same destructor as for struct fd; I'm not entirely convinced that
playing with _Generic is a good idea here, but for now let's go
that way...

2/3) experimental: convert fs/overlayfs/file.c to CLASS(...)

There are four places where we end up adding an extra scope
covering just the range from constructor to destructor;
not sure if that's the best way to handle that.

The functions in question are ovl_write_iter(), ovl_splice_write(),
ovl_fadvise() and ovl_copyfile().

I still don't like the way we have to deal with the scopes, but...
use of guard() for inode_lock()/inode_unlock() is a gutter too deep,
as far as I'm concerned.

3/3) [experimental] another way to deal with scopes for overlayfs real_fd-under-inode_lock

Takes the 4 scopes mentioned in the previous commit into helper
functions.  To be folded into the previous if both go in.

