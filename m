Return-Path: <linux-fsdevel+bounces-33257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C629B68AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 16:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692C91F256AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 15:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E8A216423;
	Wed, 30 Oct 2024 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgFyGQfQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37BF2144A9;
	Wed, 30 Oct 2024 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303905; cv=none; b=grvpFR5Utd67y2zZQ7hGLDXVsBpotRHpz/X8sMuq/KXbE7elSeoobZdQn1C3/VbhY6NcGBDZwo1K0NLtjO/lFeDlWTz+2t/J9fVpXACwKO3NmAu79Gb2s421UERzaBqzKfLJmkUP+EvVHmlAz2QBRpKm6yPnO2Ch38iw4wXEqXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303905; c=relaxed/simple;
	bh=LzN5+Qpd7fuL14+fAVQDSNU6E/uPPJd4jhyHUUHdrXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHWh66QC85zZh5Qbt331lRrsKhhHgw6CtTdH8uEDf9fuUbpm7rDYGX/c9wR21ECSLIMvP3F7b2UZdpjxgcg+2/UADVhKtYFTJfP/4F9HbCptkFgvriat2qg/LtnabNI1syf9lwg6ozdqQN5XSUP3piv8uH0cOJ3bYgnpsDq7j/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgFyGQfQ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ea6a4f287bso31057a12.3;
        Wed, 30 Oct 2024 08:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730303903; x=1730908703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGqbYAHXK4Jd6LmiaTB3lDHwM2K50OqruyDt1hmpDOc=;
        b=jgFyGQfQuNT3bYW3Rj1ew3UOSOKYaaVW9yBIyAH+FR1gDRZdyvMvj3i7pkRLqgmlbK
         +odCCjVEdzhdTLNP3Ycl0jyZRyJe2NrOgI8L1b1m/u0Dq1R0YYxzlMwktkVpTQtCfutc
         eaVHnu8EKvVGFrR4l2SyOLl0rnJDzTErMkJsJGpSi68mUb4iFfuGvunylR/HO9OiGSbk
         hThFewh3iT3W7fHpKd30kQVsw53Vwj6GhKetTAv4hrwPm3BcFQwatVdWh15LfPppQ8O5
         Wqf1IW93w3EijoGhl13ZT4NMtOY19GbtGopPGlNMoLtekoUsMCUzSw8fY4phbnGlqpml
         2VHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730303903; x=1730908703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGqbYAHXK4Jd6LmiaTB3lDHwM2K50OqruyDt1hmpDOc=;
        b=su7FjUi6MSnXcd+N2Hz9eLjiFKi376WH4RxRaAgNkpjim6GrrPcDPYvNrULl69mbWY
         u1L+DsOc04bUcNVYwUhuBY8AkvPFgJMBxnsA9WZdjwvT7tdHJLXpXpg3lojqoYr69Nx0
         68TPaVPXTtjtx4QAeuhlLc545Ma02UZWUYOhAKal1JHDkzdwx5bQacDMoDBwTJBAOmFb
         LK/aEgllqkBGJQvuF3+mfOftPQ/4V4NYU4/yn7DZAkGEjxHLedy1NzRDZ57nfiBt/2py
         FP3w+8esqT7DWuqnSvQzb1K2NLj/E8djv6uHHOZdSKa1j2K3zw2k4mkRDCXBoxZbk6NH
         VawA==
X-Forwarded-Encrypted: i=1; AJvYcCViTmr0ApLpfZvuwrXxYcBBBZPjdU3bA2vmtOmsVEwa8fwwmIwMm19tXufUdZ1oVN0528h1ryuy172basSj@vger.kernel.org, AJvYcCWIVN9hp6eXz9YYvHMO119/R7g83LiVZCKv5rLxs/v7RTCiZrCIFIHg1Y5LHlYENaWj4qPuq2Br791R@vger.kernel.org, AJvYcCXIxx5h4MQgToiK+xn2FgzcOtE5t/rnP8x/buhpjoZe5S5DpqKtao217Erq4ILNQjyuWRd4B9HUqrZejMaX@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpa4NVrMWm8DWGpvqIDqlnzRq/RxmWKNkQLDmN++6NNvTDh0nu
	ifJt6mp2hh1IApmfC/lVU//EW/37M+fYnDKz5MqaYV314yYGq3WD/CCQDA==
X-Google-Smtp-Source: AGHT+IERpMAKdiB7Q+yEULyTmcaK7Y2OEMDYKNAg4w67ROuwPqoJMrUWG93TXtbM1zJgoABdgJmOjQ==
X-Received: by 2002:a05:6a20:d528:b0:1d9:f95:9f97 with SMTP id adf61e73a8af0-1d9a83c22b1mr19163886637.16.1730303902714;
        Wed, 30 Oct 2024 08:58:22 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([203.81.241.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc89f2d5bsm9407519a12.57.2024.10.30.08.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:58:22 -0700 (PDT)
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
Subject: [PATCH v3 4/4] ext4: Do not fallback to buffered-io for DIO atomic write
Date: Wed, 30 Oct 2024 21:27:41 +0530
Message-ID: <3c6f41ebed5ca2a669fb05ccc38e8530d0e3e220.1730286164.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1730286164.git.ritesh.list@gmail.com>
References: <cover.1730286164.git.ritesh.list@gmail.com>
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
otherwise. We should not fallback to buffered-io in case of DIO atomic
write requests.
Let's also catch if this ever happens by adding some WARN_ON_ONCE before
buffered-io handling for direct-io atomic writes.

More details of the discussion [1].

[1]: https://lore.kernel.org/linux-xfs/cover.1729825985.git.ritesh.list@gmail.com/T/#m9dbecc11bed713ed0d7a486432c56b105b555f04

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/file.c  |  7 +++++++
 fs/ext4/inode.c | 14 +++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 8116bd78910b..61787a37e9d4 100644
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
index fcdee27b9aa2..26b3c84d7f64 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3449,12 +3449,16 @@ static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
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
+	 * For atomic writes we will simply fail the I/O request if we coudn't
+	 * write anything. For non-atomic writes, any blocks that may have been
+	 * allocated in preparation for the direct I/O will be reused during
+	 * buffered I/O.
 	 */
-	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written == 0)
+	if (!(flags & IOMAP_ATOMIC) && (flags & (IOMAP_WRITE | IOMAP_DIRECT))
+			&& written == 0)
 		return -ENOTBLK;
 
 	return 0;
-- 
2.46.0


