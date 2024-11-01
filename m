Return-Path: <linux-fsdevel+bounces-33433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B77F9B8B78
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 07:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171641F238EF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 06:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE98A15DBAE;
	Fri,  1 Nov 2024 06:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAEB13Ls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7807C159583;
	Fri,  1 Nov 2024 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730443886; cv=none; b=nW9CGPK+PEfIVPaJZm0BiT0SqC9m9S5Azw0By6nj6uSCEKwANBN74XM3AQXkqu8Fl8YORUY7Vq4X9FrJvs6ZvJKBhGcIgTFpWqmvnuCmF0TY4ntbh/IeV/0P3s1YHq+gvuYuTVxuF9xS7oRIOtsW6DtgUKGKAdTGZRxo+pHdfgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730443886; c=relaxed/simple;
	bh=hGvkUyhcQGnwiS/hGGptwrLsDFEWCTYbhDinuGUy2Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8SKWmhU7oG1/jhKzKB46PVdEbgK0ayih9WFE2CeAFeTFrQjhcSZP76HfdTVlPJWOgoJuAcJwE28tBw3fexu1a/2etzlsHAV3JR9b10f1340cdE40M0PV1+45Od3u8FpEXZWPPteQSZPKNNCRLUuMtNCKFgHpoq7IWytXWpGJ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAEB13Ls; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-72070d341e5so1514741b3a.1;
        Thu, 31 Oct 2024 23:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730443883; x=1731048683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4m95drDy3WKTcNebz6Rmv1HMtAg3PdxEM0SnqJC05to=;
        b=QAEB13LsYls/xIB3iM31dknhVxRl492rskEc7xKXD97oj2v8qYOnBKAU8GKSSUYEJl
         X7WhM5FTsn8byQg7WywO/Uch70LFQeQalxA1iGqxAO8mmVZb12Wws+a9/pHgZBFf34YH
         4/h8+XPCy3F5yF+VZA/EDrmBeGHMKViYCOGdOCZaSjZOcPHAteC9C5Dgqs2ELj1VRfnj
         jkNl4gGLkolbsW1AtvO5ic2pwsI89t5HY7PGJ15TY0a4eWbH+dfTPSCZZs1n5sgKa3gR
         LHaQDQ7NvKP8w7V+WnvxggqE+PnjpxEhjSDP5LPtZ6p1ctjqzaiwXTO8XmJCRlt2actI
         lQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730443883; x=1731048683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4m95drDy3WKTcNebz6Rmv1HMtAg3PdxEM0SnqJC05to=;
        b=tsBr97W74V5UNLQmFX/LNuFO1N4pAqAw1W4RE+XgYJJoZpocuDad76RIiAy5HEgnH2
         yMEFM1DsgkuTXFiuvLlZ/krNYagfMLIACoRo0LiUrnN4ZXp2w5/tETFc5oibl2KjBGUs
         cCTwDv/L1qw13RN00VNe0xlD9bYHwxcozID4EZtKVvVmjASKq2zHpGB5+2kC9/EbTHd5
         PZECH790g4XoZeD11bTyWdcUiaEB0xloN+BO9WRPvKwW32jGw1gDLwoG+Bn0LDZ704WU
         AsLpi5J6/o6/jiY/ywQOIUfRogO3tW0M4sLk1iaAJsuIlxdDH/z/CPiIwLi9cYn0eAWf
         o6lg==
X-Forwarded-Encrypted: i=1; AJvYcCUGFjb7nmT71FrsJvNHQrC2jDvNb3KoKUmmmLCA6fcAJQQ6+GDobHchUTgo/FQxQcg05d3cpzkd/fHf@vger.kernel.org, AJvYcCVpyW1A/IooTrrCck3rLwuQinOaGp+wTc0rbQ0l5vYSmZm/lgVvuLXk8FpDuH5f/9QOBo6sJau20/lPUHYl@vger.kernel.org, AJvYcCWYIEBk1qnpfsR7HnfFKiWssCODIgTh9PZFheQAIKdPuPLoEOVNYFxgQmN+fMxabFGW+AHKnumrrDQp5hDX@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu9OzIrs1d9OAjy/gtj16fHhcfeEY9FOiL+ecQTDYs6wc3xIuY
	JJG5xRNFH7mp14vpx8DLssdFVWiE0ZJmfOwhiz/9r9IIjdDagXf7JtIRMw==
X-Google-Smtp-Source: AGHT+IGO9V8DDq+6aDg1Ap7nZ8qTZYy+ILppgxnOCcguh9dqMJOYU0c6JOYuhapMAJ0Dj0o8WXccgg==
X-Received: by 2002:a05:6a20:6d06:b0:1d9:db56:39bf with SMTP id adf61e73a8af0-1db91e8271dmr6092387637.49.1730443883166;
        Thu, 31 Oct 2024 23:51:23 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([203.81.243.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8971sm2196209b3a.12.2024.10.31.23.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 23:51:22 -0700 (PDT)
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
Subject: [PATCH v4 2/4] ext4: Check for atomic writes support in write iter
Date: Fri,  1 Nov 2024 12:20:52 +0530
Message-ID: <ad2255a2fb9a4f5a30e4265ca94b6361db8ee76a.1730437365.git.ritesh.list@gmail.com>
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

Let's validate the given constraints for atomic write request.
Otherwise it will fail with -EINVAL. Currently atomic write is only
supported on DIO, so for buffered-io it will return -EOPNOTSUPP.

Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/file.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index f14aed14b9cf..a7b9b9751a3f 100644
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
+		if (len < EXT4_SB(inode->i_sb)->s_awu_min ||
+		    len > EXT4_SB(inode->i_sb)->s_awu_max)
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


