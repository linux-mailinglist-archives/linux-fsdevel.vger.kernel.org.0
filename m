Return-Path: <linux-fsdevel+bounces-38511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E849A03530
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0A618864F9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 02:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87C713B58C;
	Tue,  7 Jan 2025 02:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="gj95qiZq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (unknown [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9513714F70;
	Tue,  7 Jan 2025 02:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736217388; cv=none; b=dI1MFOSvL2tWJUirNdVDDpEc77XYYNx9qSNqbrVS52zPIsUlxXcun53/vYjDnPwuZsvkxcKvNwFjgwFXlFAg64cPJLMNiPQL8bgJhA8soxh8ACEbx4/nj9JkluqUH7cI0889hy/3EdRn3vNaZc/xKOPAMVWkHvVjTV3EZ0ljm7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736217388; c=relaxed/simple;
	bh=CDqAnD9uHq1NKxdwfwTGYZN078qQqK+x3dHMBgU/aZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D/+NxtsuKg4x+c3yy5wzbTBcw4zfdw747QSRShRGGcHO9avty0gewk5OyofX7TG9vrp5jyB5XaJTPLQ1VQey13iWejXXGnPBB6SkLTLyR3CLPcKvDjw2+y3HzCrkvTzbtl01RxGPNNDRjqcQ1gCC57qC9CdQPldil/OOFRvqNZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=gj95qiZq; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1736217385;
	bh=CDqAnD9uHq1NKxdwfwTGYZN078qQqK+x3dHMBgU/aZI=;
	h=From:To:Subject:Date:Message-Id:From;
	b=gj95qiZqlJDoxX1/dJ+9f1M1Faz+/nY9TYe5fAIkkmVQI3/k3TSSuErt0kLSF6g/s
	 FgkPsEyXgZ9z/YpSrbtguimmj2tJ+I+c7hA0HEiWBRL0MCFwN4L9TmZLso1R/HKpsK
	 R0FqwpWX0jdlPbolxz5G9Zy8RrO4S6ZL5Udwc70U=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id E63E512860B7;
	Mon, 06 Jan 2025 21:36:25 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id tnudKR2Yy4_Y; Mon,  6 Jan 2025 21:36:25 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 79B4F1281F72;
	Mon, 06 Jan 2025 21:36:25 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 0/6] convert efivarfs to manage object data correctly
Date: Mon,  6 Jan 2025 18:35:19 -0800
Message-Id: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com>
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
move responsibility for freeing the entry data to inode eviction which
both fixes the memory leak and also means we no longer need to iterate
over the variable list and free its entries in kill_sb.  Since the
variable list is now unused, patch 5 removes it and its helper
functions.

Patch 6 fixes the second bug by introducing a file_operations->release
method that checks to see if the inode size is zero when the file is
closed and removes it if it is.  Since all files must be at least 5 in
length we use a zero i_size as an indicator that either the variable
was removed on write or that it wasn't correctly created in the first
place.

v2: folded in feedback from Al Viro: check errors on lookup and delete
    zero length file on last close

James

---

James Bottomley (6):
  efivarfs: remove unused efi_varaible.Attributes and .kobj
  efivarfs: add helper to convert from UC16 name and GUID to utf8 name
  efivarfs: make variable_is_present use dcache lookup
  efivarfs: move freeing of variable entry into evict_inode
  efivarfs: remove unused efivarfs_list
  efivarfs: fix error on write to new variable leaving remnants

 fs/efivarfs/file.c     |  60 +++++++++++---
 fs/efivarfs/inode.c    |   5 --
 fs/efivarfs/internal.h |  19 ++---
 fs/efivarfs/super.c    |  68 +++++++++-------
 fs/efivarfs/vars.c     | 179 ++++++++++-------------------------------
 5 files changed, 136 insertions(+), 195 deletions(-)

-- 
2.35.3


