Return-Path: <linux-fsdevel+bounces-50942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 964F4AD1587
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 01:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCC967A20C9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 23:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ED125D1F3;
	Sun,  8 Jun 2025 23:10:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014042AE6D;
	Sun,  8 Jun 2025 23:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749424212; cv=none; b=KMl2p8ka/CniLNHbaygEdQw76t5PC9+wiL1ZjyBMHb9UJd3E18sRK3VCZWhD6DVK7zxQMYGmeTY+RoWQZU/9GradBQ36Tg3UpkpaKMGocFt10h9PEuNgthylWErbSl0xBLgcYXvBbBSjyVjFxaEA8kJzKXJcTQNuDjRuZhWypFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749424212; c=relaxed/simple;
	bh=Afuue44CwgF//wFbdoNXEChynbl6KEZWKopL/hySyt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AUJjZ9/nJDEJ44n8oD6sL2naHAZtI+oowQZyNLZrxPnlmdiuCx81uF5i3UfV9+Zuj2dIp3bJ/m45hEfWuQcXboaJNwkT3hDMA88Wg4s/Iv5N8qj2MMGYsbc1esGBLgUbu89LDoFjhm8XePVoWHi4zvqbaCT8j6jGOsYV5Qfi9QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOP9O-005veo-5K;
	Sun, 08 Jun 2025 23:10:02 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	David Howells <dhowells@redhat.com>,
	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Carlos Maiolino <cem@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	coda@cs.cmu.edu,
	codalist@coda.cs.cmu.edu,
	linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev,
	ecryptfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Minor cleanup preparation for some dir-locking API changes
Date: Mon,  9 Jun 2025 09:09:32 +1000
Message-ID: <20250608230952.20539-1-neil@brown.name>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following 5 patches provide further cleanup that serves as
preparation for some dir-locking API changes that I want to make.  The
most interesting is the last which makes another change to vfs_mkdir().
As well as returning the dentry or consuming it on failure (a recent
change) it now also unlocks on failure.  This will be needed when we
transition to locking just the dentry, not the whole directory.

This leaves some rather clumsy code in overlayfs.  Overlayfs sometimes
takes a rename lock (two directories) and then possibly does a
vfs_mkdir() in one of those directories.  When that fails we now need to
unlock only the other directory.

I hope to go through overlayfs to narrow the directory locking so each
lock only covers a single operation (possibly including a lookup first).
That should remove the clumsiness and will also be needed for the
proposed API change.

As well as the cleanups here I have a few for smb/server.  I will send
those separately as they deserve careful review by the smb team and I
don't want them to be buried in this patch set.

After these, and the mentioned overlayfs changes, I have a series which
adds a collection of APIs with names like "lookup_and_lock()" which
combine the locking and the lookup, and then a set which changes all
code which currently locks a directory for name-based operations to
instead use the new look_and_lock() interfaces.  This will mean that the
changes to directory locking can be done in one central place.

After that there are a few more cleanups to stop filesystems from usng
d_drop() in the middle of name operations (at the end is OK, but not in
the middle) and then the core patches for this work which introduce an
alternate way to provide all the locking that the VFS needs for name
operations without taking i_rw_sem.  Filesystems can then opt into using
only this locking and to not depend on i_rw_sem.  This allows create and
remove of different names is the same directory to continue concurrently
with each other and with renames.  Renames are also concurrent though
cross-directory renames block some other cross-directory renames in the
same part of the tree.

Note that i_rw_sem will still be used for the target of rmdir, and will
still be held as a shared lock by readdir() so that we never try reading
in a directory being removed.  It might still be used (shared) for
lookups for the same reason, though I haven't completely settled my
design there yet.

Thanks,
NeilBrown

 [PATCH 1/5] VFS: merge lookup_one_qstr_excl_raw() back into
 [PATCH 2/5] VFS: Minor fixes for porting.rst
 [PATCH 3/5] coda: use iterate_dir() in coda_readdir()
 [PATCH 4/5] exportfs: use lookup_one_unlocked()
 [PATCH 5/5] Change vfs_mkdir() to unlock on failure.

