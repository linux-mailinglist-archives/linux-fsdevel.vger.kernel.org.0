Return-Path: <linux-fsdevel+bounces-54394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5CAAFF46F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 00:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED251C4737A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 22:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971C124467A;
	Wed,  9 Jul 2025 22:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEYguPYA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06D5801
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 22:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752099060; cv=none; b=OBiSfjM+6VYBiYaRP9l0VXPOU+3Zju4NIfxqMtLAQ5Tj+nWB/OfwStbGhA4DDtBsQ+G24tcDVj6fYQ9358x1MSTRo4cuYo+H25fz4leY1RgmAM/a7opflPS1PeEreMOwIpPhtW7ByTabd8owfK3NiNV/icezMcNlBfz9N88Q55k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752099060; c=relaxed/simple;
	bh=nULHYjX1W5eiGu8qdupjd/JRBoZOql9PAKMTs4lmsIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tyhjEA6W86iaLuQE2BmA+dnA/KkREujUievwlT8JTGCrdBkmgPmaoWLlQPF6OqV0w6HqxtwH82rl2+ErM9gOTU+OYzGjvl21jMARit32MV3aavJcJpRJ5C6ktEIQnPPNsVKfmUozHVSGP0ma6cL1zDOW18R9HUCxqBVD9R35/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEYguPYA; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so474353a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 15:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752099058; x=1752703858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fn8hgossccLU9KZ2m+rsG2cDY8iLwi+mA3X82SYrXCk=;
        b=ZEYguPYAO9WUQGnkZcxVFQVFNlZp4Wpn7COXAddReXuAvIxMbcmmxFy43KHoUg+s/h
         fLvyQuAJDsz4ZOSP1eLt3KdfTeG6+pHS2d/N1MDUdNOIYTqGSobZtR+TvC2NmntV4+CV
         d+8/MduU6Kr6Wt6z7DOw05srlsVjsuVPWzH2bdcFsqrbPB6+nV4LfOc8A54k7UquCS/6
         rj2co+14Ad/hOAUQEJ50pafb42ulX+M/X2HXszhzO0Ppunk+uZxRdrkgR6EfrIB9Tx31
         w2D/2sfd1MJZ8VNbSen8BNloJbCluYsYmhiI+YyBaqN9lgk5LkzxePFUYfsgodWQ0kRP
         c3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752099058; x=1752703858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fn8hgossccLU9KZ2m+rsG2cDY8iLwi+mA3X82SYrXCk=;
        b=KLUiV0ldGCwsjowv52COlDd5OUPVE8O0VXWpUX5HXHsczFXS2dAc5jkg2mJ6uUIihW
         0nqiQZnH8KP0MFkUQAXHhg827XVFTP3rV/49E78XEqMOPSBUQq53SvrNHXYeiGji6F9b
         ME90ZjbgSDqu/IpcSiO/9gi8wftITPGXOekXv5JoSL8ZTzp8CosS3YvPDejA18bg5IFQ
         fExSenUEKKXSsD/SvUblSiLQwe0ROUEbFPtCk9fQ0XQsK5+YXGEYg+QDfs0KUCL1ypdK
         8rBk1xKbGgkmisM0ZlGcbdTD2SXVyDu8iBDrJg3gHwd+6l1FzoMl2K7YCOTfqGtP4FIx
         /OkQ==
X-Gm-Message-State: AOJu0YzSjXmiOqVQ57UwPAnDHO2RDnVlwo6sDpXO/SDG/DPXalnC9LSQ
	J3NZghZnHNWIK6PjHDrysipct8eWmCsCVeikbLb7AtVnB6TfWhbHkMpTKkzX8A==
X-Gm-Gg: ASbGnctPvN1+klB5bwJARQqE2+3mFcBmvBVAZNUlgJp020v6HQV7Ti0SLqjDvoqoNI7
	/W/eGQ+HvE0/P6sbAD6JFEOhglwuKVWxOBAeovJ30ZSTZmaa2QA/haQKV1DSXKZib787LH0V6Bi
	khTLLsIp67e/F8gRmYxITebl5fnJ65MrrSau5+4hBa9c9ka6vF3OEgvM2qHEh/cj+OkjWSSYVRb
	Sw2chv+XHyvzGmc+7iu2V9Jf7CA9cOGf8VymHwIQqiJght1tVjRBVxbikHClnBrokOLqFKEo1mT
	YVkb5MDMU0lrlG6qZKw+FZDcqA0+Y1zy+u8gMRFR5lTq+l7hgLT7i+H2hHQ1W17UKkQLWg0=
X-Google-Smtp-Source: AGHT+IGvmm4Vcohh5zFx0K4CRa7uPQiz4MkOKJRXMJnwZtKo12Yx5EuPWWCzdMAbLLsN17hcJGh7TA==
X-Received: by 2002:a17:90b:3508:b0:311:c970:c9c0 with SMTP id 98e67ed59e1d1-31c3f002473mr275891a91.22.1752099057246;
        Wed, 09 Jul 2025 15:10:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de434200csm1817195ad.175.2025.07.09.15.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:10:56 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	kernel-team@meta.com
Subject: [PATCH v4 0/5] fuse: use iomap for buffered writes + writeback
Date: Wed,  9 Jul 2025 15:10:18 -0700
Message-ID: <20250709221023.2252033-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds fuse iomap support for buffered writes and dirty folio
writeback. This is needed so that granular uptodate and dirty tracking can
be used in fuse when large folios are enabled. This has two big advantages.
For writes, instead of the entire folio needing to be read into the page
cache, only the relevant portions need to be. For writeback, only the
dirty portions need to be written back instead of the entire folio.

This patchset is on top of Christoph's iomap patchset [1] which is in his git
tree git://git.infradead.org/users/hch/misc.git iomap-writeback-refactor.

The changes in this patchset can be found in this git tree, 
https://github.com/joannekoong/linux/commits/fuse_iomap/

Please note that this patchset does not enable large folios yet. That will be
sent out in a separate future patchset.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20250708135132.3347932-1-hch@lst.de/


Changeset
-------
v3 -> v4:
* Get rid of writethrough goto (Miklos)
* Move iomap_start_folio_write call to after error check (Darrick)
* Tidy up args for fuse_writepage_need_send() (me)
v3:
https://lore.kernel.org/linux-fsdevel/20250624022135.832899-1-joannelkoong@gmail.com/

v2 -> v3:
* Fix up fuse patches to use iomap APIs from Christoph's patches
* Drop CONFIG_BLOCK patches
* Add patch to use iomap for invalidation and partial uptodateness check
* Add patch for refactoring fuse writeback to use iomap_writepage_ctx inode
v2:
https://lore.kernel.org/linux-fsdevel/20250613214642.2903225-1-joannelkoong@gmail.com/

v1 -> v2:
* Drop IOMAP_IN_MEM type and just use IOMAP_MAPPED for fuse
* Separate out new helper functions added to iomap into separate commits
* Update iomap documentation
* Clean up iomap_writeback_dirty_folio() locking logic w/ christoph's
  recommendation 
* Refactor ->map_blocks() to generic ->writeback_folio()
* Refactor ->submit_ioend() to generic ->writeback_complete()
* Add patch for changing 'count' to 'async_writeback'
* Rebase commits onto linux branch instead of fuse branch
v1:
https://lore.kernel.org/linux-fsdevel/20250606233803.1421259-1-joannelkoong@gmail.com/


Joanne Koong (5):
  fuse: use iomap for buffered writes
  fuse: use iomap for writeback
  fuse: use iomap for folio laundering
  fuse: hook into iomap for invalidating and checking partial
    uptodateness
  fuse: refactor writeback to use iomap_writepage_ctx inode

 fs/fuse/Kconfig |   1 +
 fs/fuse/file.c  | 339 +++++++++++++++++++++---------------------------
 2 files changed, 148 insertions(+), 192 deletions(-)

-- 
2.47.1


