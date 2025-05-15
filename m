Return-Path: <linux-fsdevel+bounces-49147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C137AB89B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 16:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1EF7A015FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 14:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44381F3FEB;
	Thu, 15 May 2025 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNH0ZKSx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FBA12CD8B;
	Thu, 15 May 2025 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320357; cv=none; b=iRhKYv2xlqUzYfsIWLKNFVsaOYj0HOXo+9Qw8KtiHuvakRUHvjj83MowZimQQ0s83DAWE0lY5GLgcCb+yNriuYrui0YokaotsNTTlq7chZO3MWQ1Ytp5MMa+73eR+a9AYLKxonxpZKYBFmYo4U8mSi99F5ZndRBuSFqwmdpcoOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320357; c=relaxed/simple;
	bh=MicSvrUtFd9+//i8Aaxp3rW0IgcwWjgWkS+/UoefRY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BPzpPCxc9r4CthqFw4J+9zJcV47UEnCsAE0cbkOENrSEsKxftJLeP5AFbjbl2YXfi0wWuKZsxZX5qzfBUjjXwbH9p2j7Ra8+GLCY/TQ5Z3kcKWM2dhD9I/xrQ+vh1i4kTyOhtO4VfVEdkSYHz1lKD1aJhlzHh62fcX7OiUt4P8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNH0ZKSx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22e7e5bce38so10103855ad.1;
        Thu, 15 May 2025 07:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747320354; x=1747925154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+9BgKkX9SLd7ggybw0HQJctOr0oJwAsMfcw1jaoumis=;
        b=TNH0ZKSxexsguMj9FLtoLNA2yK2aY38fDW1CiOTMqQunFAsSS3FMcNHm3+7uUUqyqu
         EJtBFxGziK+bwRK5zvEHEeEE/INhDVGp4tfENCPpauP+Jwej6lPy7yECzYAecagF+T/8
         u8ei/Yu0231VDEqLA0826XUCYOSMfmjcEFdLcNuEq3nLWStCylKoJ38Hg/Hjgh9r+8dI
         Kba1zIeqC9d+AtiueZT94DqK3HRb6sD3K8g7gYnxiWAMhCYzz+wTUs1AoZarcc+n+GOp
         gyEa5miV+z4sdGIZhY0KPFZ6yaZvs07+lMz3XSfYRiCgA+tY5u22HVnk/MfXHplMOxD7
         E8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747320354; x=1747925154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9BgKkX9SLd7ggybw0HQJctOr0oJwAsMfcw1jaoumis=;
        b=HyhDHUPGXwmiwl79BabIE+msVqJtxMqUC2k4wFU+HZPCDCDV7vAdodq0YHZS/yKL+s
         JLlMlHLdK1uW5GQTbGTRnbnTJfJD2Vyak+AQXNXsWuXSqjB8X9RUqEYKQ2Q6dGdNCqao
         0p9V3fsCeKT+XMCPr+5G0kncD+3ardCYjLw61bpK0Ishzb/cmVyXTNtk4R1EHESi42RS
         9TAfXJJLLK+LnWQNsOtEF/c7coAFzCYMZZpTmkm7Qk1W87/SZHAifdu95YKlxJ0cCerV
         lAo0bz/jJFTARRDwAtgRMMKLKXX5XkzhgqqvAHekuJ/LgK40PFZpbD+tR6oIXniPb5sm
         Cm1w==
X-Forwarded-Encrypted: i=1; AJvYcCVZJGZ4CAMUa0WzFonn6IWDCuCSW0jWPjfeNx0wngedWt1BqDxC9mmlce9yYgT1Omg8ZvGhsoDxlsxAvuju@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5eUaaKVuTBq6wp7ynaP4dVSck6EcbSfC40jeb22Ykxlmt4O3V
	ba+HjjqdhX7oknTEftGPxFZ0wF1Nd8Vge8vbEq1p72HWjzUoYww/8a1BDA==
X-Gm-Gg: ASbGncuEGSLE00xPKmgzBPvvYtRp/NNsXoYk1JQNyVjjblqjnrK2yoH0vggl5gBqI6M
	eQuLeE5FAao8DQPjnIyrj14ThBY6VGy1WaFJOQSpAc1/2w2pur5CDsD6wceu3rUcKddo2WDMVWt
	k9gJ+Hbs3kaHmEMFSrpgf9mFVj7kKd7nmTk2ZVbqjXtfCHWcM9Hxpemf626PSq6fPAe+jw0Y0XB
	VLIzNeeBrP85+tj7qYiGjQp3nQ9Ag+ZVepuqJ/tOjVReWFoR6XKiy5mAZWGJplcD+HyYFvsqFzW
	99vRpZpjljeGTCkepfQpbKr02ppfxizNIBxUojWEipJm8cm9d3f0gxKo
X-Google-Smtp-Source: AGHT+IEJpDG2r/O6PhthMvwsxQOzViW4RuejJc+gX6DNnIevynZHEcK64G3kGQYE/FAEtC8WHmhC9Q==
X-Received: by 2002:a17:902:e748:b0:22e:4cae:5958 with SMTP id d9443c01a7336-231980cf978mr80858405ad.18.1747320354089;
        Thu, 15 May 2025 07:45:54 -0700 (PDT)
Received: from dw-tp.in.ibm.com ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6e6a5sm3451a12.17.2025.05.15.07.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 07:45:53 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v4 0/7] ext4: Add multi-fsblock atomic write support with bigalloc
Date: Thu, 15 May 2025 20:15:32 +0530
Message-ID: <cover.1747289779.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds multi-fsblock atomic write support to ext4 using bigalloc. The major
chunk of the design changes are kept in Patch-4 & 5 which still needs to be
reviewed.

v3 -> v4:
=========
1. Added force txn commit in ext4_iomap_alloc(), in case we ended up allocating
   and converting unwritten to written conversion during allocation time. This
   happens when the underlying region has mixed mapping [1].
2. Addressed review comments from Darrick and Ojaswin.
3. Ran few data integrity tests on actual nvme device supporting atomic writes.

[v2]: https://lore.kernel.org/linux-ext4/cover.1746734745.git.ritesh.list@gmail.com/
[1]: https://lore.kernel.org/linux-ext4/87msbfyqcm.fsf@gmail.com/T/#m9f6607cc0e65e9fd29e675c5c15b3a03ff02110e

v2 -> v3:
=========
1. Improved error handling at several places.
2. Further fixed some worst case journal credits estimation.
3. Added better checks in the slow path allocation loop for atomic writes.

v3 testing so far:
===============
- This has survived "quick" & "auto" group testing with bigalloc on x86 and Power.
- We have also tested atomic write related tests using fio and some data integrity
  tests with sudden power off during writes on scsi_debug module.
  (Will clean up these tests and try to post them out soon!)

Appreciate any review comments / feedback!

v1 -> v2:
==========
1. Handled review comments from Ojaswin to optimize the ext4_map_block() calls
   in ext4_iomap_alloc().
2. Fixed the journal credits calculation for both:
	- during block allocation in ext4_iomap_alloc()
	- during dio completion in ->end_io callback.
   Earlier we were starting multiple txns in ->end_io callback for unwritten to
   written conversion. But since in case of atomic writes, we want a single jbd2
   txn, hence made the necessary changes there.
[v2]: https://lore.kernel.org/linux-ext4/cover.1745987268.git.ritesh.list@gmail.com/

Ritesh Harjani (IBM) (7):
  ext4: Document an edge case for overwrites
  ext4: Check if inode uses extents in ext4_inode_can_atomic_write()
  ext4: Make ext4_meta_trans_blocks() non-static for later use
  ext4: Add support for EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS
  ext4: Add multi-fsblock atomic write support with bigalloc
  ext4: Enable support for ext4 multi-fsblock atomic write using bigalloc
  ext4: Add atomic block write documentation

 .../filesystems/ext4/atomic_writes.rst        | 220 +++++++++++++
 Documentation/filesystems/ext4/overview.rst   |   1 +
 fs/ext4/ext4.h                                |  26 +-
 fs/ext4/extents.c                             |  99 ++++++
 fs/ext4/file.c                                |   7 +-
 fs/ext4/inode.c                               | 307 ++++++++++++++++--
 fs/ext4/super.c                               |   7 +-
 7 files changed, 642 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/filesystems/ext4/atomic_writes.rst

--
2.49.0


