Return-Path: <linux-fsdevel+bounces-55567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D92B0BF53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 10:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE23189D3AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 08:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC04288CA7;
	Mon, 21 Jul 2025 08:45:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B132A28726D;
	Mon, 21 Jul 2025 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753087539; cv=none; b=m6ogK/k44g7RkANT5OWfd5eskTd8GF1ot024sVwp4cYSsOWChzsPsHKYO02xBC+9y34Gi4oz5M7rVExSZRI64QoXp6DxGbKdFcayIut7O5S8IF7qjn+AY30gAUIeEMwWmNBeKiGIZb/vYaFkf6AFofH/6j5pN4EQvpF0gnUAgFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753087539; c=relaxed/simple;
	bh=tVhz7aa+gDULlGGs3PX3fYP2uhmioG7/Jx/wlcvS6dA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aJyKgrKtRRltpo70v4o6nTQjs6lLlq9JBUiRAb6qO2t4vIZoLeQ1qnX6DM9jMjywTvnUyl0l8/1VM4KxVq4LWsw0k1khtYEUBGnvYe4pUVY89iNcX1tXk7W+YiMZ38FEV75mWodyiF0Y06jKR0bmlPsaUmGDL0EKL3ec8XdY2zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1udm9F-002pfn-BK;
	Mon, 21 Jul 2025 08:45:27 +0000
From: NeilBrown <neil@brown.name>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7 RFC] New APIs for name lookup and lock for directory operations
Date: Mon, 21 Jul 2025 17:59:56 +1000
Message-ID: <20250721084412.370258-1-neil@brown.name>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

 these patches (against vfs.all) primarily introduce new APIs for
 preparing dentries for create, remove, rename.  The goal is to
 centralise knowledge of how we do locking (currently by locking the
 directory) so that we can eventually change the mechanism (e.g.  to
 locking just the dentry).

 Naming is difficult and I've changed my mind several times. :-)

 The basic approach is to return a dentry which can be passed to
 vfs_create(), vfs_unlink() etc, and subsequently to release that
 dentry.  The closest analogue to this in the VFS is kern_path_create()
 which is paired with done_path_create(), though there is also
 kern_path_locked() which is paired with explicit inode_unlock() and
 dput().  So my current approach uses "done_" for finishing up.

 I have:
   dentry_lookup() dentry_lookup_noperm() dentry_lookup_hashed()
   dentry_lookup_killable()
 paired with
   done_dentry_lookup()

 and also
   rename_lookup() rename_lookup_noperm() rename_lookup_hashed()
 paired with
   done_rename_lookup()
 (these take a "struct renamedata *" to which some qstrs are added.

 There is also "dentry_lock_in()" which is used instead of
 dentry_lookup() when you already have the dentry and want to lock it.
 So you "lock" it "in" a given parent.  I'm not very proud of this name,
 but I don't want to use "dentry_lock" as I want to save that for
 low-level locking primitives.

 There is also done_dentry_lookup_return() which doesn't dput() the
 dentry but returns it instread.  In about 1/6 of places where I need
 done_dentry_lookup() the code makes use of the dentry afterwards.  Only
 in half the places where done_dentry_lookup_return() is used is the
 returned value immediately returned by the calling function.  I could
 do a dget() before done_dentry_lookup(), but that looks awkward and I
 think having the _return version is justified.  I'm happy to hear other
 opinions.

 In order for this dentry-focussed API to work we need to have the
 dentry to unlock.  vfs_rmdir() currently consumes the dentry on
 failure, so we don't have it unless we clumsily keep a copy.  So an
 early patch changes vfs_rmdir() to both consume the dentry and drop the
 lock on failure.

 After these new APIs are refined, agreed, and applied I will have a
 collection of patches to roll them out throughout the kernel.  Then we
 can start/continue discussing a new approach to locking which allows
 directory operations to proceed in parallel.

 If you want a sneak peek at some of this future work - for context
 mostly - my current devel code is at https://github.com/neilbrown/linux.git
 in a branch "pdirops".  Be warned that a lot of the later code is under
 development, is known to be wrong, and doesn't even compile.  Not today
 anyway.  The rolling out of the new APIs is fairly mature though.

 Please review and suggest better names, or tell me that my choices are adequate.
 And find the bugs in the code too :-)

 I haven't cc:ed the maintains of the non-VFS code that the patches
 touch.  I can do that once the approach and names have been approved.

Thanks,
NeilBrown


 [PATCH 1/7] VFS: unify old_mnt_idmap and new_mnt_idmap in renamedata
 [PATCH 2/7] VFS: introduce done_dentry_lookup()
 [PATCH 3/7] VFS: Change vfs_mkdir() to unlock on failure.
 [PATCH 4/7] VFS: introduce dentry_lookup() and friends
 [PATCH 5/7] VFS: add dentry_lookup_killable()
 [PATCH 6/7] VFS: add rename_lookup()
 [PATCH 7/7] VFS: introduce dentry_lock_in()

