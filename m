Return-Path: <linux-fsdevel+bounces-32843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C6F9AF853
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 05:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3B91F22B3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 03:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23FC18C02E;
	Fri, 25 Oct 2024 03:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="homTtz1q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6838523B0;
	Fri, 25 Oct 2024 03:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827970; cv=none; b=LZtRUdnuWqlB68Ml22l2Y1HZy0i+Hxtk/Gmf0wE2Y0PLUECQ9sQRXJXDD9EYPy5J8jFEbQUv9GJfkETOCgmNKYX6EWFqoO41cUNP/o+vVuowbH5RPO7mWUcbRlIExqG36uQVuYfdp7ozF3F8o9g9Ct2kDHZz4v6E+Ja68zWJCks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827970; c=relaxed/simple;
	bh=IpSDviff1S3+091J4xvIHrzHFLBNwc8q7usHNs+O0Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a8eRz8re/OX1G+M/UMwUo9WlceXyrQJu3IZXIDrBK+UDk1obd3UmVWfdFY2SwvJVl+XyzK6c6olqBQAJJNjzA+FzKIH95u1UyX8OHhEyqM/7bbpiJ0osrSiBDopPjLP4Qid8GsWFFg8LioKDKGRjr8DRidbMFaq1YkfzzmTjcJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=homTtz1q; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea9739647bso1058974a12.0;
        Thu, 24 Oct 2024 20:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729827967; x=1730432767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s/Cmq2CEq+3uxXR5Vbe4rzkkmedKYgo3PQp1L/DKxjY=;
        b=homTtz1qbGlY18BFDOGq43gsrffZERSDc0CEFxibTrmPJM8ml2+CtFVNQUrjXHvS05
         8vV3//6ktAyevTvR2AtXWqY6RDzecUtOAUKfFCpRFtpy8HRmNiTsp2shmASXD17ZPEAS
         SP4kEQZPrrBTUaM0tBzGLx9V2ni3zjrx/sh/N+s5j2hLpVT0X7z7CN8w3Fd3vsnqAVDt
         8xHvInLIZBWAbUNSm/mHsS9P0cAB6uzkmOyjgZi8WqTqpmW0TevMw1JR4l11y4P1Asct
         Z7D7L2+Q3dBBhLn7v5COTDeyyDX3nJE/ftWt5Tdn9OwfVY83iAX/9wqwY8odzha3iyWc
         Jl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729827967; x=1730432767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/Cmq2CEq+3uxXR5Vbe4rzkkmedKYgo3PQp1L/DKxjY=;
        b=uz9PMWvLR0mSrrUWyj7eP1mec+D5CCmv5IsULsYogZqZd6W1AiljuGfLjOUtUw3RJG
         Z68z9+eyANFt9wRJDvsZ0eFYDXcVvM7rfuGoMPqlaIjtnDBsHqlcJbkLbHaNh6N00RO8
         A3kkQHamFxkGhWiZOEgvt8H2ikbvAWuqWPHF9AbJIc27RbOBnCSj2pBF/XLA06TO61jv
         jGFJT8zsY1JqZBI06y1T3YFprXXh632U8XP26AK6fLcHk7dKs1pIm8adSUHwWDx0wfv5
         MJI0/dYUz5RWmQSypwaNNCr58EOr8KY6nK7xDBGdzLkiVB+Rb9HRDt83UIhGEybrqHzb
         It2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVncdXwp0nggoxqEeydawQPozWtYGZgrG6dXjp3Um1s7fj84zRlPE5l/FFPwgQrWNFJfjMPYY6k56U5VdqM@vger.kernel.org, AJvYcCW+jiBntODavN2O+t6LtPMdyth8QGgHPomM9dIfW2OOMCCPMjr7AAhPJeAqjUIpTZi4a0KISqn95WLU@vger.kernel.org, AJvYcCXvjQ9fLUDjg0F8rHRyeOh6I11KZtCh0K990wa3uea9cC3L/X9UfiedQC26Ggg0jwOfVEo00ywkm5bpjIPE@vger.kernel.org
X-Gm-Message-State: AOJu0YzkogV/btVyXiHgtlCqhx8u/wbICUjz5cZ3bB4y7RaZVor8Fz5b
	3e675nuyyXluYMPjvhck8woDcv3Jhya1v2ZnDHDbQjX+OcxipT7nTcDKNg==
X-Google-Smtp-Source: AGHT+IGX0smSJ6X3tJWPAEU44ev3GBgQVSNg/eJRYX7tN2JSEy/lPJC2mpLw4jCaABJJ5/DxtFsMlA==
X-Received: by 2002:a05:6a21:3a96:b0:1d9:3b81:cdd3 with SMTP id adf61e73a8af0-1d9898ff76fmr5252861637.1.1729827967180;
        Thu, 24 Oct 2024 20:46:07 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.85.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5df40265fsm3463176a91.0.2024.10.24.20.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:46:06 -0700 (PDT)
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
Subject: [PATCH 0/6] ext4: Add atomic write support for DIO
Date: Fri, 25 Oct 2024 09:15:49 +0530
Message-ID: <cover.1729825985.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds the base feature support to enable atomic writes in
direct-io path for ext4. We advertise the minimum and the maximum atomic
write unit sizes via statx on a regular file.

This series allows users to utilize atomic write support using -
1. on bs < ps systems via - mkfs.ext4 -F -b 16384 /dev/sda
2. on bs = ps systems via bigalloc - mkfs.ext4 -O bigalloc -F -b 4096 -C 65536 /dev/sda

This can then be utilized using -
	xfs_io -fdc "pwrite -V 1 -A -b16k 0 16k" /mnt/f1

This is built on top of John's DIO atomic write series for XFS [1].
The VFS and block layer enablement for atomic writes were merged already.

[1]: https://lore.kernel.org/linux-xfs/20241019125113.369994-1-john.g.garry@oracle.com/

RFC -> PATCH:
- Dropped RFC tag
- Last RFC was posted a while ago but back then a lot of VFS and block layer
  interfaces were still not merged. Those are now merged, thanks to John and
  everyone else.
- [RFC] - https://lore.kernel.org/linux-ext4/cover.1709356594.git.ritesh.list@gmail.com/

Ritesh Harjani (IBM) (6):
  ext4: Add statx support for atomic writes
  ext4: Check for atomic writes support in write iter
  ext4: Support setting FMODE_CAN_ATOMIC_WRITE
  ext4: Warn if we ever fallback to buffered-io for DIO atomic writes
  iomap: Lift blocksize restriction on atomic writes
  ext4: Add atomic write support for bigalloc

 fs/ext4/ext4.h       | 14 +++++++++++++-
 fs/ext4/file.c       | 27 ++++++++++++++++++++++++++-
 fs/ext4/inode.c      | 27 +++++++++++++++++++++++++++
 fs/ext4/super.c      | 37 +++++++++++++++++++++++++++++++++++++
 fs/iomap/direct-io.c |  2 +-
 5 files changed, 104 insertions(+), 3 deletions(-)

--
2.46.0


