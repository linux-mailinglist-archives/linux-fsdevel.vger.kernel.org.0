Return-Path: <linux-fsdevel+bounces-39613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D33A1627A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 16:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCB33A60EC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 15:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627C01DF727;
	Sun, 19 Jan 2025 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="lx61AqHT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686A54315F;
	Sun, 19 Jan 2025 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737299539; cv=none; b=W3aVJRa5/CnbCc2hPoj48StJMzYgmSlzQSNh0AM+722O7pOklVIkf8iY5igO10uGYbvvPZaHexvoRG1DDqxMSm3vNBcVw+LKy9xEDV2EfMtLMJyW47i4VAO01MHXr9s43j6gsBeGLbxwJ2tZ7Xq5TbusvO1pKmjFA+l5Sph+en8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737299539; c=relaxed/simple;
	bh=ZUKTe1U3p8BIcaMVl9RS2gXHRf3p4XsvCYS3eZQDJnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cohiTHPkvkezZsNzPj1wPSvmY/8TPicY4jx1ecrNCSfbYKGb9gC81waouLDAAF0bBELcwj7lMM0eOSUrnErISjDCc2BM0EH4utOCtg2P5q4aeTI6PaMwAPrTEOxEUVEIZIJkOjU8QQ/OG7oUDbgCaUugHFlign/hMpAaUtR/2vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=lx61AqHT; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737299537;
	bh=ZUKTe1U3p8BIcaMVl9RS2gXHRf3p4XsvCYS3eZQDJnQ=;
	h=From:To:Subject:Date:Message-Id:From;
	b=lx61AqHTQgFtIkoq5JZ8gATCRQhJfQ/laFc1VP/e/n1HSVtQh4gg+1B+m88P4TnqG
	 FSZVKdWT75F/ctobLZII18p0I9Ryt8hZPPJlKgHlFP64Xfjiz+MJ2+Mp9yF3JH5R25
	 qETNk0TOVXOw5niIA01XNY0XCqE1kid364WidblM=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9B390128056F;
	Sun, 19 Jan 2025 10:12:17 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 2y1pN2HHcDJ9; Sun, 19 Jan 2025 10:12:17 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id AE70512804E8;
	Sun, 19 Jan 2025 10:12:16 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v3 0/8] convert efivarfs to manage object data correctly
Date: Sun, 19 Jan 2025 10:12:06 -0500
Message-Id: <20250119151214.23562-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've added fsdevel because I'm hopping some kind vfs person will check
the shift from efivarfs managing its own data to its data being
managed as part of the vfs object lifetimes.  The following paragraph
should describe all you need to know about the unusual features of the
filesystem.

efivarfs is a filesystem projecting the current state of the UEFI
variable store and allowing updates via write.  Because EFI variables
contain both contents and a set of attributes, which can't be mapped
to filesystem data, the u32 attribute is prepended to the output of
the file and, since UEFI variables can't be empty, this makes every
file at least 5 characters long.  EFI variables can be removed either
by doing an unlink (easy) or by doing a conventional write update that
reduces the content to zero size, which means any write update can
potentially remove the file.

Currently efivarfs has two bugs: it leaks memory and if a create is
attempted that results in an error in the write, it creates a zero
length file remnant that doesn't represent an EFI variable (i.e. the
state reflection of the EFI variable store goes out of sync).

The code uses inode->i_private to point to additionaly allocated
information but tries to maintain a global list of the shadowed
varibles for internal tracking.  Forgetting to kfree() entries in this
list when they are deleted is the source of the memory leak.

I've tried to make the patches as easily reviewable by non-EFI people
as possible, so some possible cleanups (like consolidating or removing
the efi lock handling and possibly removing the additional entry
allocation entirely in favour of simply converting the dentry name to
the variable name and guid) are left for later.

The first patch removes some unused fields in the entry; patches 2-3
eliminate the list search for duplication (some EFI variable stores
have buggy iterators) and replaces it with a dcache lookup.  Patch 4
move responsibility for freeing the entry data to
inode_alloc/inode_free which both fixes the memory leak and also means
we no longer need to iterate over the variable list and free its
entries in kill_sb.  Since the variable list is now unused, patch 5
removes it and its helper functions.

Patch 6 fixes the second bug by introducing a file_operations->release
method that checks to see if the inode size is zero when the file is
closed and removes it if it is.  Since all files must be at least 5 in
length we use a zero i_size as an indicator that either the variable
was removed on write or that it wasn't correctly created in the first
place.

Patch 7 fixes the old self tests which check for zero length files
on incorrect variable creation (these are now removed).

Patch 8 adds a new set of self tests for multi threaded variable
updates checking for the new behaviour.

v2: folded in feedback from Al Viro: check errors on lookup and delete
    zero length file on last close

v3: convert to alloc/free instead of evict and use a boolean in
    efivar_entry under the inode lock to indicate removal and add
    additional selftests

James

---

James Bottomley (8):
  efivarfs: remove unused efi_varaible.Attributes and .kobj
  efivarfs: add helper to convert from UC16 name and GUID to utf8 name
  efivarfs: make variable_is_present use dcache lookup
  efivarfs: move variable lifetime management into the inodes
  efivarfs: remove unused efivarfs_list
  efivarfs: fix error on write to new variable leaving remnants
  selftests/efivarfs: fix tests for failed write removal
  selftests/efivarfs: add concurrent update tests

 fs/efivarfs/file.c                           |  59 +++++-
 fs/efivarfs/inode.c                          |  41 ++---
 fs/efivarfs/internal.h                       |  26 +--
 fs/efivarfs/super.c                          | 106 ++++++-----
 fs/efivarfs/vars.c                           | 179 +++++--------------
 tools/testing/selftests/efivarfs/efivarfs.sh | 125 ++++++++++++-
 6 files changed, 300 insertions(+), 236 deletions(-)

-- 
2.35.3


