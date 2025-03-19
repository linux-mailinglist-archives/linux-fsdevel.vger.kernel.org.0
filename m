Return-Path: <linux-fsdevel+bounces-44402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06BFA68392
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 04:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA0667ABC89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 03:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C7624EF65;
	Wed, 19 Mar 2025 03:16:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22F020D4F7;
	Wed, 19 Mar 2025 03:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742354169; cv=none; b=dM9Dq4KME6e11hY1amOHaNY3yGdVBxhtPepKK3wCx1rhA8QNIo6vzUzlvyzrsiErM77pHTW1vJZAcWM6KAAT3L7AYatAPPO3/POZQomAlAahbEVDG2ufuNv2hF8ebynnRr/jg3GxmwMCRad9vTxKGs7Nn1QTPBqV1hOqifmaBRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742354169; c=relaxed/simple;
	bh=XDyl/InuyBklka32/8zOUc02s3WLVFULLm9/bUqNIMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rskigl0KEL8wUO84Sj7SNu70GkPkDf5E+NquejNHHHzlitKPNvzy4ma/KOAuFvVVEm3/a1YQ90fDdhqV6LBgM+uCnjibelBqMfqIfr8oqe8+GbUlsNk4S+O+ZabXPVQcgFI9iYsSUy5qv44inzn1doGnynnU30d9CCBB3ZX+E/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1tujuM-00G6oe-Rj;
	Wed, 19 Mar 2025 03:15:54 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/6 RFC v2] tidy up various VFS lookup functions
Date: Wed, 19 Mar 2025 14:01:31 +1100
Message-ID: <20250319031545.2999807-1-neil@brown.name>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This a revised version of a previous posting.  I have dropped the change
to some lookup functions to pass a vfsmount.  I have also dropped the
changes to nfsd and cachefiles which passed a mnt_idmap other than
&nop_mnt_idmap.  Those modules now explicitly pass &nop_mnt_idmap to
some lookup functions where previously that was implicit.

============== Revised cover letter.

VFS has some functions with names containing "lookup_one_len" and others
without the "_len".  This difference has nothing to do with "len".  This
is an historical accident but can be confusing.

The functions without "_len" take a "mnt_idmap" pointer.  This is found
in the "vfsmount" and that is an important question when choosing which
to use: do you have a vfsmount, or are you "inside" the filesystem.  A
related question is "is permission checking relevant here?".

nfsd and cachefiles *do* have a vfsmount but *don't* use the non-_len
functions.  They pass nop_mnt_idmap and refuse to work on filesystems
which have any other idmap.

This series changes nfsd and cachefile to use the lookup_one family of
functions and to explictily pass &nop_mnt_idmap which is consistent with
all other vfs interfaces used where &nop_mnt_idmap is explicitly passed.

The remaining uses of the "_one" functions do not require permission
checks so these are renamed to be "_noperm" and the permission checking
is removed.

This series also changes these lookup function to take a qstr instead of
separate name and len.  In many cases this simplifies the call.

I haven't included changes to afs because there are patches in vfs.all
which make a lot of changes to lookup in afs.  I think (if they are seen
as a good idea) these patches should aim to land after the afs patches
and any further fixup in afs can happen then.

These patches are based on vfs-6.15.async.dir as they touch mkdir
related code.  There is a small conflict with the recently posted patch
to remove locking from try_lookup_one_len() calls.

Thanks,
NeilBrown

 [PATCH 1/6] VFS: improve interface for lookup_one functions
 [PATCH 2/6] nfsd: Use lookup_one() rather than lookup_one_len()
 [PATCH 3/6] cachefiles: Use lookup_one() rather than lookup_one_len()
 [PATCH 4/6] VFS: rename lookup_one_len family to lookup_noperm and
 [PATCH 5/6] Use try_lookup_noperm() instead of d_hash_and_lookup()
 [PATCH 6/6] VFS: change lookup_one_common and lookup_noperm_common to

