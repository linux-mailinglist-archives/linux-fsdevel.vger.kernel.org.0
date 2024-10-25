Return-Path: <linux-fsdevel+bounces-32847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AB69AF864
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 05:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4D95B21B9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 03:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226D218C342;
	Fri, 25 Oct 2024 03:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCJzK91l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA15118C323;
	Fri, 25 Oct 2024 03:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827986; cv=none; b=hoKAV9r7Jv7T8j1W/Hx5ONPlVOxRD1/oE2VusWdseJEE50Y5xaJZ7a6A3vL8YLyeV0rhEZBAYCrNlzxjqI3uefl1VL/Ge+iM/Ysid2hYKhalS2gn4eMQdzkdt3trKL3uOHG/Vm3kz7xV9ybo0lxIoS8ezr//6GXcfWaSXClO/tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827986; c=relaxed/simple;
	bh=7njsC75dLsWIK9qESLdPiLocC7EO9gCvzxffObpwHmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiRj4+3OP77PZcrjARAmFcrqyjeedD03W4dXjKYlDtZJaJNb0bP4wB3YWBTeuQq9v12Qh/lltj5gXhwkk3fh2f7s7thujSTBkmUr6gkWK4a5+t89H8rx0Qf0uYzgIhkYjBCn3jXo2tJUw5fyOC6JDIJwJ+0WrCaNbML5ddcQB4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCJzK91l; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e56df894d4so1229320a91.3;
        Thu, 24 Oct 2024 20:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729827983; x=1730432783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cduxLudvcfBef+EgChYG/ixsnBTuOQS7aur2v1V1W24=;
        b=gCJzK91lpeEMIcMKhKeimD7jchhLQufAOHG+zMZV+DPlBB7/SSzE6pU8kDJkU+azEE
         fm3iplmFMCpOMAJKbua/6Decm7DADEUkj2C98kGuW63PEWSMmBbxn8fHCze1/jmWKZXo
         9Ndz+ab6py5vj2CTlwSnU2iAm+RqBky7Sn3j1dJNQiTmDqD6caINYV48FZdaDse9WQnf
         wizTqLv/YYePiaJFO9p5dkP8CFJbM6jal7blfKY2uuBzp4/k4RRcDryQ0M3Aew0rwOL0
         bFz7wKggFmVik5Yf83dNMeHoQaKcAy4xhEYo1OP9t43zn0WRRQKlrDe33aEZzZKohR4U
         NEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729827983; x=1730432783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cduxLudvcfBef+EgChYG/ixsnBTuOQS7aur2v1V1W24=;
        b=Njhi5GqvAE10Giqv5jjrlFdfZTb26bfqTy4K6lnTvNLPI1Xd/jUGLx/fXe1FBXUKz6
         c92D5xK5v9M1mPrBGllTcRzEIOiCfdedL9FJ8xrBXqc5uDXum6POFceZhlRZxCzzNBuB
         G19MIRkAWxboNObuHWVrpy9EJ/pCgSUGPbDCv/uQuUTGhBthg9JcMcK3Wt1+t1HxahXs
         MlE6ZfcmKfgxxkj377E1Skfej9q8vo3WW6XIYr0o04fwaJ5ZAOEW0IOOGbrPpezcOVyl
         biL6QeoZB/eri1rlSFhomr8dUuLesAi9LDjiNIkahhyUhOwjTknopfJKXfwK7IkSsBTz
         wAew==
X-Forwarded-Encrypted: i=1; AJvYcCUkcZ7Hhp2BEpqX6IEfQPOVno8NCm5d5XHV3zlX0FgSdxD1xz5/Qf+WCiimVLm5WylUlRyobZh0n0Y4@vger.kernel.org, AJvYcCWSNowk21b5jt5RjF51twET/xy4gC4r03Sw4zL1Ml1OySNfdKlpu7qkTjIoaj7gEuVK6jDQOYMBIn1Zp3pr@vger.kernel.org, AJvYcCX+ezzbiPD6qTKb4VG+/Gq43UcIkwXHc2qUob0BfrNySIjG0K5ZFN8uNFX99LGjRusjKNCUI/gya1OjBvMz@vger.kernel.org
X-Gm-Message-State: AOJu0YxbIkzOTWY3VfUX0gvZwxPH8Ot9jfHxWLlvY+YkgKMYqNV12H6X
	LgZduZPD9tr7cavqGDoZCnTxjGOrbyg1LkZNvHCZ3vZ8yn7NdNJglY3/+A==
X-Google-Smtp-Source: AGHT+IEjH24CFA3MuF5TEhAscE+jXi9wvl+LVofCfeMk2E5MSUa/RSa+YoJgyuc7YA/+/aO2sLq8Kw==
X-Received: by 2002:a17:90b:120d:b0:2e2:b6ef:1611 with SMTP id 98e67ed59e1d1-2e76b60aed0mr8926834a91.18.1729827983075;
        Thu, 24 Oct 2024 20:46:23 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.85.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5df40265fsm3463176a91.0.2024.10.24.20.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:46:22 -0700 (PDT)
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
Subject: [PATCH 4/6] ext4: Warn if we ever fallback to buffered-io for DIO atomic writes
Date: Fri, 25 Oct 2024 09:15:53 +0530
Message-ID: <7c4779f1f0c8ead30f660a2cfbdf4d7cc08e405a.1729825985.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1729825985.git.ritesh.list@gmail.com>
References: <cover.1729825985.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iomap will not return -ENOTBLK in case of dio atomic writes. But let's
also add a WARN_ON_ONCE and return -EIO as a safety net.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/file.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index f9516121a036..af6ebd0ac0d6 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -576,8 +576,16 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		iomap_ops = &ext4_iomap_overwrite_ops;
 	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
 			   dio_flags, NULL, 0);
-	if (ret == -ENOTBLK)
+	if (ret == -ENOTBLK) {
 		ret = 0;
+		/*
+		 * iomap will never return -ENOTBLK if write fails for atomic
+		 * write. But let's just add a safety net.
+		 */
+		if (WARN_ON_ONCE(iocb->ki_flags & IOCB_ATOMIC))
+			ret = -EIO;
+	}
+
 	if (extend) {
 		/*
 		 * We always perform extending DIO write synchronously so by
-- 
2.46.0


