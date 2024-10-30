Return-Path: <linux-fsdevel+bounces-33255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E849B689E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 16:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC751F251F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953452144CF;
	Wed, 30 Oct 2024 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUMBPh9/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347992144A9;
	Wed, 30 Oct 2024 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303895; cv=none; b=YgHTqqQN50IQBDpzAvWV4aaE9yF4gs6sI/kDCVFQuPfkzVejBAJ5hmXhgfrXgM7uBzGMNan2G1KXex9F1OjzD6pyUQH8IrmxN6rSgFThIem3qnpp6/6kzD2tCrIwintRNgGS58MUF8o9RkE/Kt909GMoX3Y8w61dAyxzoKIesj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303895; c=relaxed/simple;
	bh=jtHSk3Bdf7QEVK6brq3Guj2iz2HsAL8mfJaVXrdn3YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+v79cjmORzbjEStyVjdhJxrQQXtTE9/itogcicdKjm5x69mB0GKV2nAk83Hb5JET8U9D/KA3jyG14W5A9lLL93Jl/+Yps58HmC9Z9+tADjn4XrlBRH89MDw3WFAr5hJLUGVBnx8z6yrNpQAN1sBAbka2SVs+l7F+OeDh0NNxgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUMBPh9/; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso32957a12.2;
        Wed, 30 Oct 2024 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730303892; x=1730908692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEjmZvZuZCYGHLblrXah7vS9Oj6EM5ySVORIRl0DI0M=;
        b=ZUMBPh9/8YqXTabK0BK/YaXPNBSFxRZQ+LmoBVxAoN6xHiBFh7DE6zaJ7trCLnmsIq
         Bq5J8NlOhF9WMGg1BDCK5kJkckOq5Tbw1w3WtcDFT+kQMP2OG2jRPSjrs98lUqUEQlEJ
         kDv/uAlIJ3kytisAzrVn0uQ9YRpIKiSGX8ab0Ws6NpQ269uzi22uAF+gj+BJaVQRNg3H
         GgRlsHkeybQU2rILNJ/x5avz/N9X28bkvA2DslQhXMfqPA+LgxhDxeknYTawIojH1Xbr
         UyNwXtR11BVGNs1QWs8oLqqskKpLResbbDWRteaQtk4p8vP1nvZw296jvyc+5fP6EBt8
         yFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730303892; x=1730908692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEjmZvZuZCYGHLblrXah7vS9Oj6EM5ySVORIRl0DI0M=;
        b=AMnsLHxuHmSSIjRiSNCfN9kIwm3IEpglD8/LYHGEish0GzIqXIfSS/u+QSTnJrne3F
         /JmpkgDpUEpmCRWIb4pTTzwWc6j5hh1/7E6P0q6MpZwHtyhmakGzNHOflogM9gpJ/cuO
         T4QtUU/VrP5tant0dDNVcLeVn59KIFtbMplKF/oLw14P3yCuGOlUgi4zjFa+m+NLgy3G
         FGMpIhyC27bXEwtQeuXMpVBZCOvS/buZqmmmZSBGcYwUlsAhobBx70i7hH8Rd5yra9GS
         5lMX5PoKq3hy6pUeXXRY0ubKHxrnoIAKm5bRaSO+rN8/ttOZXtqla32ctIPrzwfK4XcN
         Q0yA==
X-Forwarded-Encrypted: i=1; AJvYcCWDRwx4UQpKDE8x4IYVl02gqcSfJkXDV5d9nTQkeJ5vTiTCX5ZpWC6FUB/ACF4CeArZ0qsWesy9s2vPWKHX@vger.kernel.org, AJvYcCWnW2z5kdb/IdE+I/FaX/vQpWeW/OPFrW1vByR3Xgf7b/7rTY3+ym1PC/+duiJXvoitnF6N7H/jFLs/BRKf@vger.kernel.org, AJvYcCXFhDUepjrEmTO+rTYztxKZhofgup8wiUEE2EYhrspGxKhc199G0bC3NH/0IpraKSwPZ92K49y7aUy3@vger.kernel.org
X-Gm-Message-State: AOJu0YzhTzM/I4lidwcNfEAp60K+EGhJk/LShRgwkTbx1pJtbM5iKPri
	WXrXJZqrOOERwCjwXdIAXuwTeTdy0l/8ZMinMVZs/PyzI6cBQi2SmCwdeg==
X-Google-Smtp-Source: AGHT+IFEla8dSlLTzR+Z7uqPoCGGg3twqAEwqUIkBJ6jIt9bVpE2kVwAltPEVZ8rw70v1jdIHTIWLA==
X-Received: by 2002:a05:6a21:394c:b0:1d8:a49b:ee71 with SMTP id adf61e73a8af0-1d9a840a378mr22285292637.29.1730303891944;
        Wed, 30 Oct 2024 08:58:11 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([203.81.241.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc89f2d5bsm9407519a12.57.2024.10.30.08.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:58:11 -0700 (PDT)
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
Subject: [PATCH v3 2/4] ext4: Check for atomic writes support in write iter
Date: Wed, 30 Oct 2024 21:27:39 +0530
Message-ID: <dc9529514a5c2d1ad5e44d649697764831bbaa32.1730286164.git.ritesh.list@gmail.com>
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

Let's validate the given constraints for atomic write request.
Otherwise it will fail with -EINVAL. Currently atomic write is only
supported on DIO, so for buffered-io it will return -EOPNOTSUPP.

Reviewed-by: John Garry <john.g.garry@oracle.com>
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


