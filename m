Return-Path: <linux-fsdevel+bounces-33435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBF69B8B7F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 07:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8669F283B8A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 06:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1352715278E;
	Fri,  1 Nov 2024 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh8Hy4mu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B24C1714BC;
	Fri,  1 Nov 2024 06:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730443896; cv=none; b=Li9OmYdE/yWogxSLt2BwBeZ92ST1BsvVl79IZ1q6XEiJujlc3WFYwDtlNszwdr2JHt3QO6extIHjvFuWCMOYG0WedKy1818q3AhXkYA26rRDXF/mg+NOqKA7lPSK3hbQDeQ5FGbtoFKDUgSRV1TDii+s2OQxnc5rYimuxuwue+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730443896; c=relaxed/simple;
	bh=vNVkQK5HqfJrI3jmXZheJg3/RyjZh6GM0HcqoIQ82F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LA8PzZwf5MAF27mEK0RVvKr7Jd2er9HwaYv4iBzzG3J0cDGofId8QmE7LeAV2LNLIa21vPTiN8oRbnNGScPWEELTU/v4FCtJDbd8807c26LH//dazifGPJQe33x+HBBFvaPfjTR2WhVjM5pVe9Eqt+dyI/PgJfGn8aZSCJ7xfSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh8Hy4mu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-72097a5ca74so1413551b3a.3;
        Thu, 31 Oct 2024 23:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730443893; x=1731048693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUpTv9wExUvhBAoK2KqfAK7bifpKgEoP/EE1D/quHOg=;
        b=Vh8Hy4muNlikvzTXLpFdVd/s36l9a9K0r0DA8+jT3qF+Uv3udU0kp3vcTASMQl2C2z
         MHKZOe++dG3jbC/2guuh5PuGponwwB3s9xNth5GmAiPEIFa1E/ALfmte6bwF/gn+Yixt
         1Yr9zdgQs7Z9q6GfNoSLzWl6SE0K/vUGaXkmiI8FNb/gCy0m0iPFoxRDGLZm0CEeBELa
         au8q9BlAOuCpONcei/YGI2qm3OmH16AptBzKKGkO6txDC/I6yhcxEFa0yzEy3G/mIaHK
         SSX2ujbKSGvgDJ9jiBc8qigU8KBTvCJjMMxXOvOy9QFTuFWtAFsyI0Hnd4aWgooaGIyb
         p8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730443893; x=1731048693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUpTv9wExUvhBAoK2KqfAK7bifpKgEoP/EE1D/quHOg=;
        b=gjg1ZWRXCYsADtdLOppmV1tbInyHbIGT4NLrheQ7GZMeIKLmBH2Y9+g/ZkAKvbv9bW
         4sZjT+eDu5TToxAuVaI81D2oE/R+nPSw2fy0sSgmUEltu2W0Y2z+xL529tLVtdMROisF
         0wCtrYQn5TY676PrKw8JsABKMivcaGsgjLTfjtoC8XQN5Lgib/vIjnq+mEOZDFoBC1No
         7CMiXbyAEbpbsZmzB9xPvf4R2NFg+REUc47gxkhNfUTkCqd87A/Vp3lOpKzeSrGDDtSa
         SQSFcKT8VWsqByoHX99ZRjbdWSkcGg5YMfp8KwdX0i4m3N3kyBkZ1MvNWVWxy91F9VWp
         jQiA==
X-Forwarded-Encrypted: i=1; AJvYcCUYGT5sFqRJ4jBE817WEYVS70Gfp9bm6jGSMz2lJoRDNzGo41z6rrdR7DPf9CguBrjtM8ncYrWsXWs8Rdkx@vger.kernel.org, AJvYcCVciixpy+/hJgRZVy8/w9pXGWq3Mw4FQJzJI6EL+g1wsKVXgkIrF9PlvAJM1YXThQISlSYnb5l8G0Ay@vger.kernel.org, AJvYcCXkP/EHxvlRFeS95Z+w177pI001p8+mSIwoSf1qXsG2uGj5zWPRdAODcNkIOsXoz1kHE5FmDi37YPAEGjyK@vger.kernel.org
X-Gm-Message-State: AOJu0YwA1vgGvls5aVDfjYwP3yPXWFmvcY9P5FsC4FYvXD3dw5Ph/R6Y
	YzH5gtv5NcOb7NH/n/6TOP2/PZSQBCefOuv/c3JRVUPUbB0ymsCnMgGDbw==
X-Google-Smtp-Source: AGHT+IE+097sdf1GgBu/8uA6WnV5QerdwqvqfQxsQzKml4gDXHjiNGW58zC9ifhtYUrq4e/xLiKiZQ==
X-Received: by 2002:a05:6a00:1817:b0:71d:f7ea:89f6 with SMTP id d2e1a72fcca58-720c99b5ca0mr3797240b3a.18.1730443892738;
        Thu, 31 Oct 2024 23:51:32 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([203.81.243.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8971sm2196209b3a.12.2024.10.31.23.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 23:51:32 -0700 (PDT)
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
Subject: [PATCH v4 4/4] ext4: Do not fallback to buffered-io for DIO atomic write
Date: Fri,  1 Nov 2024 12:20:54 +0530
Message-ID: <78fb5c40dde4847dc32af09e668a6f81fa251137.1730437365.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1730437365.git.ritesh.list@gmail.com>
References: <cover.1730437365.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atomic writes is currently only supported for single fsblock and only
for direct-io. We should not return -ENOTBLK for atomic writes since we
want the atomic write request to either complete fully or fail
otherwise. Hence, we should never fallback to buffered-io in case of
DIO atomic write requests.
Let's also catch if this ever happens by adding some WARN_ON_ONCE before
buffered-io handling for direct-io atomic writes. More details of the
discussion [1].

While at it let's add an inline helper ext4_want_directio_fallback() which
simplifies the logic checks and inherently fixes condition on when to return
-ENOTBLK which otherwise was always returning true for any write or directio in
ext4_iomap_end(). It was ok since ext4 only supports direct-io via iomap.

[1]: https://lore.kernel.org/linux-xfs/cover.1729825985.git.ritesh.list@gmail.com/T/#m9dbecc11bed713ed0d7a486432c56b105b555f04
Suggested-by: Darrick J. Wong <djwong@kernel.org> # inline helper
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/file.c  |  7 +++++++
 fs/ext4/inode.c | 27 ++++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 96d936f5584b..a7de03e47db0 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -599,6 +599,13 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ssize_t err;
 		loff_t endbyte;

+		/*
+		 * There is no support for atomic writes on buffered-io yet,
+		 * we should never fallback to buffered-io for DIO atomic
+		 * writes.
+		 */
+		WARN_ON_ONCE(iocb->ki_flags & IOCB_ATOMIC);
+
 		offset = iocb->ki_pos;
 		err = ext4_buffered_write_iter(iocb, from);
 		if (err < 0)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3e827cfa762e..5b9eeb74ce47 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3444,17 +3444,34 @@ static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
 	return ret;
 }

+static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
+{
+	/* must be a directio to fall back to buffered */
+	if ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) !=
+		    (IOMAP_WRITE | IOMAP_DIRECT))
+		return false;
+
+	/* atomic writes are all-or-nothing */
+	if (flags & IOMAP_ATOMIC)
+		return false;
+
+	/* can only try again if we wrote nothing */
+	return written == 0;
+}
+
 static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
 			  ssize_t written, unsigned flags, struct iomap *iomap)
 {
 	/*
 	 * Check to see whether an error occurred while writing out the data to
-	 * the allocated blocks. If so, return the magic error code so that we
-	 * fallback to buffered I/O and attempt to complete the remainder of
-	 * the I/O. Any blocks that may have been allocated in preparation for
-	 * the direct I/O will be reused during buffered I/O.
+	 * the allocated blocks. If so, return the magic error code for
+	 * non-atomic write so that we fallback to buffered I/O and attempt to
+	 * complete the remainder of the I/O.
+	 * For non-atomic writes, any blocks that may have been
+	 * allocated in preparation for the direct I/O will be reused during
+	 * buffered I/O. For atomic write, we never fallback to buffered-io.
 	 */
-	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written == 0)
+	if (ext4_want_directio_fallback(flags, written))
 		return -ENOTBLK;

 	return 0;
--
2.46.0


