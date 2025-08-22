Return-Path: <linux-fsdevel+bounces-58722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719EAB30A23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 02:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4A31D066BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3F71DF748;
	Fri, 22 Aug 2025 00:11:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976E31547EE;
	Fri, 22 Aug 2025 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755821487; cv=none; b=J83HXfqVgwVE3atOoI6KVL27ngtCTyEz3QcIB82JQaZEGQBtsVQvIbAVLUZmhPfmx2XtyddrXhgoCUjgRvZh6GT8aSTqMUj34sXPC8W8yLvblBd4KXkMdM0B7pmM7GuRCOHGNzwLPDzf9MdD+GfSWuZmUY6glvyTn0KOg4Sw0Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755821487; c=relaxed/simple;
	bh=U36K3UL1GafSRzKJ9JZcwd/7oz3VTvOqPFQHpnLbMZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jkBa7Dob7lynA9Lkf+M12zlEeWlIJM9lwXdop3g6HfATBsLJjQo9Zj/rm9V8T0bgPc8BWn4/pgPYG3uwNzqsT/UOtOAsXBrwI7EOqx82YbA6kU6lpJymydfKRYeQuNaWs+R/F0A+UI26HjRVt7wwewxkosJ7WWqGbyupTOIY+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1upFN7-006naX-6B;
	Fri, 22 Aug 2025 00:11:11 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 00/16] VFS: prepare for changes to directory locking
Date: Fri, 22 Aug 2025 10:00:18 +1000
Message-ID: <20250822000818.1086550-1-neil@brown.name>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a partial revised set of patches based on review comments.
Apart from the first five which received generally positive review and
could possibly land now, they focus only on centralising the locking of
directories for dirops, and only focus on create/remove, leaving rename
for later.

Each time an interface is introduced, many new uses are included.
overlayfs, smb/server, and ecryptfs (at least) will also make use of
these interface, but that requires large patches which would distract
from the introduction.

I haven't included the change to vfs_mkdir() to have it unlock the
directory.  Consequently there is a different "unlock" interface that
must be used after vfs_mkdir() calls (end_dirop_mkdir()).  If we
eventually make that change to vfs_mkdir(), end_dirop_mkdir() can be
discarded.

[peterz added for this intro and patch 03]

Thanks,
NeilBrown

 [PATCH v2 01/16] VFS: discard err2 in filename_create()
 [PATCH v2 02/16] VFS: unify old_mnt_idmap and new_mnt_idmap in
 [PATCH v2 03/16] Introduce wake_up_key()
 [PATCH v2 04/16] VFS: use global wait-queue table for
 [PATCH v2 05/16] VFS: use d_alloc_parallel() in
 [PATCH v2 06/16] VFS: introduce start_dirop()
 [PATCH v2 07/16] VFS: introduce end_dirop() and end_dirop_mkdir()
 [PATCH v2 08/16] VFS: implement simple_start_creating() with
 [PATCH v2 09/16] VFS: introduce simple_end_creating() and
 [PATCH v2 10/16] Use simple_start_creating() in various places.
 [PATCH v2 11/16] VFS/nfsd/cachefiles: add start_creating() and
 [PATCH v2 12/16] nfsd: move name lookup out of nfsd4_list_rec_dir()
 [PATCH v2 13/16] VFS/nfsd/cachefiles: introduce start_removing()
 [PATCH v2 14/16] VFS: introduce start_creating_noperm() and
 [PATCH v2 15/16] VFS: introduce start_removing_dentry()
 [PATCH v2 16/16] VFS: add start_creating_killable() and

