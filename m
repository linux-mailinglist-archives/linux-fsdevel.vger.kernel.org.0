Return-Path: <linux-fsdevel+bounces-32845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5150C9AF85B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 05:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65B51F22388
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 03:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E08F18DF79;
	Fri, 25 Oct 2024 03:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jko3EvRd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7BE18CC17;
	Fri, 25 Oct 2024 03:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827978; cv=none; b=g8Hz/v1e4SGo3XAC6MLVp4Mux/URVqTHLxMk1enIc3HsfR4YK/y63HePpgMXm4+ZADs8FMGRlOg3XBKA9z1FwpgYzhPeisSqTwRAjqzWPseDq9HuIiZBb+dn0UgvmgOkT46YIGX1edwzekPxGZug4/hIPZQkPs1U5PtrmieyHi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827978; c=relaxed/simple;
	bh=XyQDkox2MNNQIUWJcrRwxKGQOX+v3b2r2qve2e5EU6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCbnx7D2ConmhHxCFrKjXFM72gr5JGnsPBbc+qh+YP53i0yBKIBHOjyg2OmABQWb55xsGInBg3PfUsOFd4BsZqO9j/RkKxY/Bdj2oyc85wN/WqCk+rrElTcku5Iha4q5w2MkB05m24FVARU6lZb7LzTtyVhiJQfrFbyLxE/S0j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jko3EvRd; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2e8c8915eso1189008a91.3;
        Thu, 24 Oct 2024 20:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729827975; x=1730432775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVU94oDYUdmKWru5SiVzYI7iG6i76KSCiLJO+AKPsq0=;
        b=jko3EvRduHL2C9f9pE3rNgVyahVW9GuPpmBChuK9GPNxKSSVfjZtfIY67H+YzK5r/S
         nO0ZS6+rcBUris4vcPNEeezJJgz9ejQySwG791+Is6kG4tSEM1SC2DacWMewom6C7Gzs
         +8aYKa7MymeKRStr5BDSl0aVmLQf9gjquo0K7EuytiANlRLiLMl2iCdxzFwewS9I6QmA
         Ein9nFuPNeHEBnfGcOppmeyUxHVbqWgfZUimT3zgaRFm2Rs3A8WhGAjifroXIGWDGaxA
         DfjGTg9SAv2wnOhD4gk3QNvA3IQMiau6P/GavfC8wC2dzA4Htukefc7aOuK+WUmRYBHZ
         C1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729827975; x=1730432775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVU94oDYUdmKWru5SiVzYI7iG6i76KSCiLJO+AKPsq0=;
        b=AFnHL4pPT5SntghcKPR+NGFG5SLFI22DqFt/+/EkMny+urJ3jLOAzxUslNjGOVJtsc
         600UIqipqg/9C7nDYUTbOhSWOFT68BEtA0JN5pUiKONoFEfXPshWD3ROemPQnHjytfZY
         j3xpwCXFCaSblF7DT2FJPcwA2snaafqFuDOp9qyLS4Ig91tM0Rk9OF59RvSsyS/8MryW
         tj+xVyZIJZeBDt2KsT1/c1d2jeacVhaJNf3KI37quH5/MedhgnhOdUdzjHrWjObPMSvs
         ZYA5+CpE6YRb3cgraI881VokaKt8tOJ6KBhUNfDA7coENuu9MMNvK+x9TVlZaZy08tTN
         NEzg==
X-Forwarded-Encrypted: i=1; AJvYcCVBCHQHx1yITAdnOzo6uB/+gVq2NFKmtFnEgQdbz04X68fVy1NGu+REDaKRDMQDm9F+j8CgI6ivKbk11Mhc@vger.kernel.org, AJvYcCW6C8T+o7sPwhIaomM+5NVwb5dhkcFABCi+HiPp20GanrNGhZYExweKG9luyJgpFrmgGveWU9jrA0PsK1hw@vger.kernel.org, AJvYcCWjvKJZeMZdBBvnmn0FWMwjNLq5c3mf1vwymn2FrdDo8hzxj0CBBxT2+IWKoMWFf0tOr4mKuPKNayPm@vger.kernel.org
X-Gm-Message-State: AOJu0YzbD7mlkjTDHTBTr+lVpMn8Lhh5dno452/ZQH4Z8/8ZH/2069+u
	QhwhudEXtHZJTnkui6Fa1MuR+/lFQFLoVl97W8wISFcnLuqJz8YxDy80CQ==
X-Google-Smtp-Source: AGHT+IGqOWaUl4lVz3uchUPFtaT+KvqbvQ9YtJGxEE2y8Thqyp7fXT75Mw97YNUWj0FXvt/BEpbLdA==
X-Received: by 2002:a17:90a:a597:b0:2e2:ef25:ed35 with SMTP id 98e67ed59e1d1-2e76b1f9cc9mr9194949a91.0.1729827975078;
        Thu, 24 Oct 2024 20:46:15 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.85.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5df40265fsm3463176a91.0.2024.10.24.20.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:46:14 -0700 (PDT)
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
Subject: [PATCH 2/6] ext4: Check for atomic writes support in write iter
Date: Fri, 25 Oct 2024 09:15:51 +0530
Message-ID: <319766d2fd03bd47f773d320577f263f68ba67a1.1729825985.git.ritesh.list@gmail.com>
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

Let's validate using generic_atomic_write_valid() in
ext4_file_write_iter() if the write request has IOCB_ATOMIC set.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/file.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index f14aed14b9cf..b06c5d34bbd2 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -692,6 +692,20 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (IS_DAX(inode))
 		return ext4_dax_write_iter(iocb, from);
 #endif
+
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		size_t len = iov_iter_count(from);
+		int ret;
+
+		if (!IS_ALIGNED(len, EXT4_SB(inode->i_sb)->fs_awu_min) ||
+			len > EXT4_SB(inode->i_sb)->fs_awu_max)
+			return -EINVAL;
+
+		ret = generic_atomic_write_valid(iocb, from);
+		if (ret)
+			return ret;
+	}
+
 	if (iocb->ki_flags & IOCB_DIRECT)
 		return ext4_dio_write_iter(iocb, from);
 	else
-- 
2.46.0


