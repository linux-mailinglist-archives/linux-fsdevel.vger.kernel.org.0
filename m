Return-Path: <linux-fsdevel+bounces-32925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7EF9B0D04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 20:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2291C22B7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 18:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7952618F2F6;
	Fri, 25 Oct 2024 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im6NQyhj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2833F20C33B;
	Fri, 25 Oct 2024 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880304; cv=none; b=ZECZNA0w7bccmKlrXUspv3ZkEkIiIUqIAwLODqN/TRQlIIo1G9q1FpQ8Zacva+5d1PvhLD/TfAYRYRlQKX6ZP5WOsjgmcdh9fXo/fPS3tttWS4Cd1IM5od4OW9cQjCmqMLQDf0/H9ZB/N3pUIGY9IxyL/5WSmwntxKE80vTFihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880304; c=relaxed/simple;
	bh=v1hwuTl+8BCRTxe3Http9QiPRGIkrWefuEMHvq/QQz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F2mgvv+5p9duDzMoVcvhsXRxGtWuJSEtUYwjclyyxHKR13Qlo5bdoWBVpLWJAvEmBjFbJlo1XDLxTgw5IMSutl8FclVVU0w40jKb+cPMo8oEo5mA98/M9un2wPkeheRbPmkfKDbhUIOFSr083gLXN+BD4m8JpHsp/Q+T9bDy1qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Im6NQyhj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c803787abso18439235ad.0;
        Fri, 25 Oct 2024 11:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729880301; x=1730485101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+TOwZYNTv5eHUs8Bo46zVa+EwDHeJm+uvq59kPi1xAI=;
        b=Im6NQyhjz1wbkG+HF7foFSed2lHv4a9VD4G6kWh5n7jQw8BDa1Y/CqAHfduQPZ40KV
         yh0GGIHXuLfWRHNPdYf+us7cq6xPrTjpxFT9+WvqRe8sesfrTdBHKiFLOI3OeMCTppcJ
         41/HrIeHVvX9xAIwOeb1zpIcc/EkM1ARTBc9cl+bmbh6Q1ZAEVjIk/lIR50ono4sdfX0
         k8oUg+vzMqqqly7rNv8yUohKPJippJDXFlRIonYemIXt+2KqHtfB6s6DtWZ6BWwn4WXE
         JjJbj7sPw/5E2UqsEViSzaL68OtddWvi5NejTYGizCEbpP6SlUeLpB4XCzC0p+oqJDFc
         WH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729880301; x=1730485101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TOwZYNTv5eHUs8Bo46zVa+EwDHeJm+uvq59kPi1xAI=;
        b=jUXvaePgdubel9YlahirKxpfVWLe00NXclfszgMC1BfjvY/ZCAdRUEzOqfXslrjh6O
         tNOPpGzBNTNWsVaepDYXv4Vu7rZe/dYza7j2kTi+ueoNFI3dsaxkUp7p7SmUcBwMVleb
         VFULkVOOOgDOTvE0hVnqQDdxzqzBOaeCYMf7eRrdpZvyU1wo1SiSCK831MbwudFd0+3x
         W/GVQ66cjk2rNux3RHOXQ15VYJw3qXPZRk4Pg2oZfLrW/eYkLWZADA5cgQ4Iaem99lPb
         YX2unK/zc+9EDaL6GOe5x6d/vzYeudM37IgmPV+1Bi4+PuqtYjBFfrWXXCfmQGupJSOb
         nh+g==
X-Forwarded-Encrypted: i=1; AJvYcCWHkrs2xBQMn2ivVfQlO9OrxUUhTSsmVaCV69f0hkAYGjJBx1D45Vb9fxjjuaMXVkTtjiS21LnMS+I76Oyq@vger.kernel.org, AJvYcCWSk7TOOYCrKhtNMmcf6EIVE8O9tzyO6fbFFKcT7Im4T8gaYUV0mSbwnubZQz4AyQH3GxpkJwFjT31kiwGS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxf+QMnPxswzjgKuXHqLzappCBP2r4x8jHX5wvXHXQYh2s1JA1
	lMDS6+ptdUH5yhyK4CE8E8grzhs/SeR0VJyYvJNpQR6NolrakODmrzRMZw==
X-Google-Smtp-Source: AGHT+IGqdSuUo6Y6p7vHrxoGHchv3M7RNYWw0iN3cE1ZEsKpKIitnUBkviTKhO00d+TcjuMNK9CqVw==
X-Received: by 2002:a17:902:ced2:b0:205:8a8b:bd2a with SMTP id d9443c01a7336-20fb8a04b12mr108551195ad.22.1729880301408;
        Fri, 25 Oct 2024 11:18:21 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.85.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8a6f4ddsm1388763a12.91.2024.10.25.11.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 11:18:20 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>,
	Carlos Maiolino <cem@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH] xfs: Do not fallback to buffered-io for DIO atomic write
Date: Fri, 25 Oct 2024 23:48:05 +0530
Message-ID: <627c14b7987a3ab91d9bff31b99d86167d56f476.1729879630.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iomap can return -ENOTBLK if pagecache invalidation fails.
Let's make sure if -ENOTBLK is ever returned for atomic
writes than we fail the write request (-EIO) instead of
fallback to buffered-io.

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---

This should be on top of John's atomic write series [1].
[1]: https://lore.kernel.org/linux-xfs/20241019125113.369994-1-john.g.garry@oracle.com/

 fs/xfs/xfs_file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index ca47cae5a40a..b819a9273511 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -876,6 +876,14 @@ xfs_file_write_iter(
 		ret = xfs_file_dio_write(iocb, from);
 		if (ret != -ENOTBLK)
 			return ret;
+		/*
+		 * iomap can return -ENOTBLK if pagecache invalidation fails.
+		 * Let's make sure if -ENOTBLK is ever returned for atomic
+		 * writes than we fail the write request instead of fallback
+		 * to buffered-io.
+		 */
+		if (iocb->ki_flags & IOCB_ATOMIC)
+			return -EIO;
 	}

 	return xfs_file_buffered_write(iocb, from);
--
2.39.5


