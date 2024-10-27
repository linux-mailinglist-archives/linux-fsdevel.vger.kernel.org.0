Return-Path: <linux-fsdevel+bounces-33025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D489B1F9F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 19:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BCAF1C20917
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 18:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2ED17C20F;
	Sun, 27 Oct 2024 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWcCzE7l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3731CABA;
	Sun, 27 Oct 2024 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730053067; cv=none; b=Va61NKv0wFAhM8kfCECXRWnk0fzn67eby6ihLuonwHopzkyfQ+B+jlo+idWaXpdQ31x41JwPYCJe8ttr+RhU3og/uNxKKwXK/hrdKxvgYebvlxTZYpMuWQhGXd7n7DtGaB/gI1lS3+3O/2tTMXUUq9Sq1gserCGb+QX97RDdHlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730053067; c=relaxed/simple;
	bh=JFlQrGW5Kiln+gI7MwHs5I9AObJ/vKjD9R82Vb3d8Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KxCjN5fAti6f3KXRoS2dKlTSV7zCRNHsgM3mJlNEnfzRFNIciKjMFOARQoOQqx3p6OPtk6D0ptdbTg8lNDhF0ZQdzG9fWYP+n5kPmQtb88sjJjKkdozoQOsEYk/G12MD3tJT7x41eNKZMa+bsrC3eWdVSBUMorVyH/MnscRs+qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWcCzE7l; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso2465826a12.0;
        Sun, 27 Oct 2024 11:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730053064; x=1730657864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fbROS/32wVZiqFGULlsnbCBos7mXuZbpO2StaqIBuZc=;
        b=jWcCzE7lzTROwku3oxyJUWL/hT90ylA6GW6ifoC3uklrMpGzJWis+SVANKaucvCIXB
         PjOATu9AwUfhTLdbq/H9tSs4Q3cdks4rszejG/ZFK/oM/77SvMFE3zxpxBhZ9f4r2Azy
         NF2bgCUrv+PyPtehPvusI6m6OAUapC1ArRQL70I/6RUv6PDdebMW6JeMxEvC5Dv0knml
         AtF4KMBnH42OWUEwH1sNbSV9Nt2WRogMKLN8rpL20VWHPdlDmwQOyKU/JVzSQbWv/rPv
         NetFm0qgUQDy8Kp3N4a+ADEuf7wyA96OrpcJ1UojOwav6RZ2IMFa6I6GZ6EcR2i71ZWC
         bLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730053064; x=1730657864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbROS/32wVZiqFGULlsnbCBos7mXuZbpO2StaqIBuZc=;
        b=tHQ/eCu67W40we6dmtYMR+E5VUSLli/tkoIO1UcfAIgv5vTAmTTKK0T2ABiStUtibK
         9ZdvW+e5y02gLFepPsOKuqmfFRiCsW2VDkt5HM+f+5S5VEPCC6WCiYRRtljmCw0I6XVm
         JSE50zE0MbMdqyurQnstRb0aCz/QLDqoDHnf9a97+8j79bgVMUBoObjtltmqVfAoyzqv
         ixX33bcyDmzNZ5gKauE9P9NpaQV6ixGpYQ30aFr9whejEOpAjKmHddmTiCxp6q1nsV9j
         YxooAOelIHnsLUd3V6f9eSnZEuJqICwcS9msj7K2UkeN5/G8Okatf+19ra/IQlHrth0C
         /Yuw==
X-Forwarded-Encrypted: i=1; AJvYcCUfn/POBIlsm3xni9S0j3FIP2Vrv2uqtu9xHHH0+/Tz3UWl8qseMw8pIcXixHoV/Q4uxaqSs7pSCnmG@vger.kernel.org, AJvYcCXr9cwtynz/Y/+z3o+PgkNEYXPCpFIh4PaGTOeFhc5H6Eq8r7l4tlLvZUa506kujim8jQBciGOENzwzgS21@vger.kernel.org, AJvYcCXtF7i8dZqnK2hMM8YdWyB2Qww2Xm+UEhqoMcgnfnka0P2qxPEZFcvu+khUyBf8V75tD/JlxUC9jc59zJDV@vger.kernel.org
X-Gm-Message-State: AOJu0YyEgvqng2+6jWU70FxrR3BfEkjHxiMW1vp0D5BttepQAXrEy90v
	GNxUpkPLnpvqXmauRFbAKoKwY5r63yMjAOIsbaWgyjoBH3ft4+VquiP/zQ==
X-Google-Smtp-Source: AGHT+IGqKc7XzG5Y1jemXF1kEpQPJDdOiVQZNRawe4QRj+kQmmBnZJddHwPneluvpoX6q6jZ3qTQ2A==
X-Received: by 2002:a05:6a21:31c8:b0:1d9:1fac:7257 with SMTP id adf61e73a8af0-1d9a84b8c48mr8279224637.32.1730053063982;
        Sun, 27 Oct 2024 11:17:43 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.83.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc867d0c1sm4306492a12.33.2024.10.27.11.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 11:17:43 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v2 0/4] ext4: Add atomic writes support for DIO
Date: Sun, 27 Oct 2024 23:47:24 +0530
Message-ID: <cover.1729944406.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of atomic write enablement on ext4 for DIO. I have split this series
as discussed in v1 [1], so this only enables atomic writes to a single fsblock.
That means for now this gets only enabled on bs < ps systems on ext4.
Enablement of atomic writes for bigalloc (multi-fsblock support) is still
under discussion and may require general consensus within the filesystem
community [1].

This series adds the base feature support to enable atomic writes in
direct-io path for ext4. We advertise the minimum and the maximum atomic
write unit sizes via statx on a regular file.

This series allows users to utilize atomic write support using -
1. on bs < ps systems via - mkfs.ext4 -F -b 16384 /dev/sda

This can then be utilized using -
	xfs_io -fdc "pwrite -V 1 -A -b16k 0 16k" /mnt/f1

This is built on top of John's DIO atomic write series for XFS [2].
The VFS and block layer enablement for atomic writes were merged already.


[1]: https://lore.kernel.org/linux-ext4/87jzdvmqfz.fsf@gmail.com
[2]: https://lore.kernel.org/linux-xfs/20241019125113.369994-1-john.g.garry@oracle.com/


Changelogs:
===========
PATCH -> PATCH v2:
- addressed review comments from John and Darrick.
- renamed ext4_sb_info variables names: fs_awu* -> s_awu*
- [PATCH]: https://lore.kernel.org/linux-ext4/cover.1729825985.git.ritesh.list@gmail.com/

RFC -> PATCH:
- Dropped RFC tag
- Last RFC was posted a while ago but back then a lot of VFS and block layer
  interfaces were still not merged. Those are now merged, thanks to John and
  everyone else.
- [RFC] - https://lore.kernel.org/linux-ext4/cover.1709356594.git.ritesh.list@gmail.com/


Ritesh Harjani (IBM) (4):
  ext4: Add statx support for atomic writes
  ext4: Check for atomic writes support in write iter
  ext4: Support setting FMODE_CAN_ATOMIC_WRITE
  ext4: Do not fallback to buffered-io for DIO atomic write

 fs/ext4/ext4.h  |  9 +++++++++
 fs/ext4/file.c  | 29 ++++++++++++++++++++++++++++-
 fs/ext4/inode.c | 14 ++++++++++++++
 fs/ext4/super.c | 31 +++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 1 deletion(-)

--
2.46.0


