Return-Path: <linux-fsdevel+bounces-37274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EDF9F05E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 09:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384FA161A50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 08:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B809519D8AD;
	Fri, 13 Dec 2024 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="X0EAtGz4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0F2187355
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734076829; cv=none; b=AnxYHLg5HoInnNKCt32ywTp68b4YA/wSCUQu/gyb8YiN+n2zoJdKbmtdfyqt/Hr5MrrQD3Goiv4m66O8Tj8UUgEMdduD7psxQHNCcuNSm9/QhMHxD+4D+fOwg5F+FaVDHge3QOgJI5udVQanrLLN4Oa+n4PINE9SLIuLpi00yHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734076829; c=relaxed/simple;
	bh=HsyROFVHhX4p8Qwi5AcSs6rIFbPe3oyKad0CkpzJ46E=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HWASV3j6bD/umK/oKtkxqud0FqthjXVBgHSpNe2Ec8Oi7tPopM89KiVn0SdxctSUV9rfL1PoeWZtgxDn6UYoAlVjlrZ6JjSvdJm5ou99+4S2CjxtfMaTtX20H/iaco26+DFrLUwxCUl33U/vT7V9jC0STid9Kh5ZO9F/D7ct1AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=X0EAtGz4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=tsrj4zho8JwNZX+pRnCF9aur9kC5PNEBs2H3+TJzP+c=; b=X0EAtGz4mKtSE+CWsdRC+WzjjZ
	uvvvSLlouRJzg+YxIXnc0kPc55pHS3GxoLrqUixpH8tM/s/IBdu7CMib8euntNuyqVSuT3YwirHLD
	1w7zY61khjzhX9uFCC1FWj3Sxya69SzZN33G5cdPEOtC+XdNxxAPuImdlUwyhJUGd9D2n7AnLjirC
	jVfOpF6082JJ0RndOtCUvZ6yctV2YsmOSpPvmZqrKvD3gXQvVIQHB6PTjhMMONZLE25lP0oaTyBQ2
	9n3CveUl10Hz1qydqpJlTBQbRHeMsNvx1MtTyY5ZahLVnbyBlrW48a39NjfOl1pktqizb7g+DZ4R2
	jpjII8+w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tM0b1-00000007rBd-3MoL
	for linux-fsdevel@vger.kernel.org;
	Fri, 13 Dec 2024 08:00:23 +0000
Date: Fri, 13 Dec 2024 08:00:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Subject: [RFC] d_name/d_parent stability rules
Message-ID: <20241213080023.GI3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

FWIW, I went through the tree again, trying to prove the locking
rules for dentry->d_name and dentry->d_parent.  It took about 5 hours
and left me seriously wondering about the toolchain assistance
possible in that area - repeating that kind of audit every once
in a while is _not_ pleasant.

Anyway, results:

* only positive dentries can be moved.

* all changes are under write_seqlock(&rename_lock)

* they are also under write_seqcount_begin(&dentry->d_seq)

* ->d_lock is held on all dentries involved (dentry itself, its old
parent, its new parent)

* if dentry used to be attached, ->s_vfs_rename_mutex is held over
any ->d_parent change

* all changes are under ->i_rwsem of parent directory's inode (held at
least shared)

* if ->d_parent is changed, ->i_rwsem is held both for old and for new
parent directories (again, at least shared)

* the difference between weak and strong locking environments (parent(s)
held shared and exclusive resp.) is interesting - name/parent changes under
weak environment _mostly_ happen to directories.  That happens when lookup
finds a subdirectory that has a preexisting alias elsewhere - either due
to rename done on server in case of remote filesystem or due to corrupted
fs image.  There are filesystems where it can't happen at all (e.g. anything
with tree entirely in dcache), but filesystem being read-only is *not*
enough to guarantee it won't happen - for corrupted isofs image it is possible.

* there's a rare case when weak-environment renames can happen to non-directories:
vfat and exfat lookups finding a differently capitalized alias with the same
parent will rename it.  Parent is held only shared in that case and the object
is a non-directory.

For an example of the way that plays out, consider e.g. d_exact_alias().
We rely upon the aliases not being able to move while we are looking
through them.  The (sole) caller is holding the parent of our dentry
locked (possibly shared), the inode is a not a directory *and* it's
not on vfat or exfat (nfs, actually).  It means that all moves of its
aliases will be in strong environment.  We are holding the parent of our
dentry shared, so while ->d_parent of aliases is not stable, result of its
comparison with our ->d_parent is, so the logics that skips aliases with
the wrong parent is safe.  Aliases with the right parent are guaranteed
to have ->d_name and ->d_parent stable, so d_exact_alias() doesn't need
to bother with ->d_lock on aliases for name comparisons.

In case it's not obvious, I'm not fond of that one, especially since the
proof that parent is held at least shared is not pleasant: the call tree
is
_nfs4_open_and_get_state()
        <- _nfs4_do_open()
                <- nfs4_do_open()
                        <- nfs4_atomic_open()
                                == nfs_rpc_ops:open_context
                                        <- nfs_atomic_open()
                                                == ->atomic_open
                                        <- nfs4_file_open()
                                                == ->open
                        <- nfs4_proc_create()
                                == nfs_rpc_ops:create
                                        <- nfs_do_create()
                                                <- nfs_create()
                                                        == ->create
                                                <- nfs_atomic_open_v23(), with O_CREAT
                                                        == ->atomic_open
and while both ->create() and ->atomic_open() do have the parent held
at least shared, ->open() does *not*.  But in case of ->open() we
are guaranteed that dentry had been positive to start with, and the
call of d_exact_alias() in _nfs4_open_get_state() can happen only
if dentry is negative.  Since positive dentry can be made negative
only by the holder of the sole reference to it and since we are
holding a reference and do *not* hit it with d_delete(), it can't
become negative on that codepath and thus d_exact_alias() call in
there is guaranteed to have the parent held at least shared.

IMO that's awful.  Granted, this is one of the... highlights of that
code audit (the other one is in ceph, with its call graph from hell),
but...

I don't know what can be done to make those audits automated.
A part of that can be helped by making d_name const, aliasing it
with non-const struct qstr member - that, at least, helps with
proving that ->d_name is not modified outside of __d_move();
doing that manually is seriously time-consuming (grep and you'll
see).  But that's obviously a nasal daemon country.  Alternatively,
we could define d_name(dentry) returning const struct qstr *, and
have that used instead of direct accesses to ->d_name.  Conversion
will be a lot of noise, but it doesn't have to be done as a single
commit...

What we really need is some way to express invariants like
"->mkdir(_, dir, dentry, _) has dir held exclusive and
dentry->d_parent->d_inode == dir".  That's one area where things
like Rust could be useful - having the locking warranties expressed
via type system would be nice, but then the things like "call of
d_exact_alias() in _nfs4_open_and_get_state(opendata, _) happens only
with opendata->dentry->d_parent->d_inode held at least shared" are
probably beyond any help - having type system do an equivalent of
proof above is not realistic ;-/

