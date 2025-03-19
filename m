Return-Path: <linux-fsdevel+bounces-44386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD06A6812F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 01:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D51D188EB92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 00:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86446C2C9;
	Wed, 19 Mar 2025 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gMn0Gk81"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD9B3594A
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 00:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343341; cv=none; b=QM2w4Ull6QyUBpHpqra5nI0VAnp/MOdqSjupsRMELyU25058EJhN8kwIRpVOTwSORjAo8lIbQbn4n8AxyFc4aRdBtLUu3pNOtVNwHnbd2KlB7O0FgtPX7Z5uGEZW7n2s2PcZkt8V3K54t/fHLhnxGDm4vB4SitNuIniDu4S8YyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343341; c=relaxed/simple;
	bh=zDwqRePv1ZFUDi9FjMPQDVKfJ1n1RRe7hhmBOVzyCME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AV3s3QOefeSE+8W9+UIF4LksIGAbyQdsE4QR/NcnKB/eNWUCwDyO0XQWVUyVyFyx79ERaDvgX5vKTiTQ7IYcy5zgcLNFgbwftKw/DMVRPILepYA9pLBIMcZho9M6kaZ1TzYbwpQgu+1ihvzjO86wKC8yObvcH9IWPJORoEAuhdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gMn0Gk81; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff6e91cff5so6065561a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 17:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343339; x=1742948139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx2MMZGi/yQrztop394w65c9xYaCiVDt+AK5Yt9ywsM=;
        b=gMn0Gk81p6q/vZ4LGycCtV8PrWqmKL2X2+1X7JUYuAk7MxmnWIJuOfblGJYKzH1qHS
         NHGtmlgyX/4nIO0x+NDViqz93DL2F52q8hztCpCwajF3yIzTdhN8LJJc8uSXOkRRSbyx
         r8JDzvsMP8tNb3e/DiHLdTjOx59RF5ciEg/mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343339; x=1742948139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jx2MMZGi/yQrztop394w65c9xYaCiVDt+AK5Yt9ywsM=;
        b=VLH3JotWfp//j100azSgLQNMbrHQNmcEl39qRbV/ZhDoUeWst2zCSS3dSL6G8O4c5Q
         XR349PVp7M4+i2/tCocggl7wQN9jpIWxg29v4N2+njVgeq2hDqhT5KvgAL3w+2GCHibt
         PcqtBdGgSjtjMErkQIQqf5kkCYV81fyUaA5t+K4MRf/CUhYaAgF0ZFQP/kL/RWWV5PiY
         Gx16xclZIJ6s7FLnZ03dLPqSrOVxFIrbigYX0k4p/5/qy7tx8nsEV2MqBBJQs8OEz456
         sH7Wrxce0Nuae9zz1QFXm4KZn3fCPdHV6RJB9N5Tg88wtNYj9E77GRQcPRRcKnTLSocb
         TRSg==
X-Forwarded-Encrypted: i=1; AJvYcCW2anohdElNfYmmbHJbEIxsh4prdcQ8d9atbq1tDXrA2VWqRKmAlbwchtrncSYNFEs8eplS+ooHUwDsUzVn@vger.kernel.org
X-Gm-Message-State: AOJu0YxYLf63ic3FHDCO0pXbW+LZnXyALeWTvtPGuqv0W6Z0uiFxUt8B
	1mvw9U8lLVdOlif/lqmQOUEc6FLCAoUOfnhXZxYbkyQF6sr8m2lgDdz2W0IfIeQ=
X-Gm-Gg: ASbGnct7R1nR0uEEBBVth1zEWThho1G28yv3qBgnKXrQyh5CKPbsXm7YzvD9adXzek3
	M4Y14fnfUlEz5w4Lv7b6BR9J8GaJx2+V+2nYqqfN9VxbPPficebYbDYx7b0bwc6iCvO3NGgLiMZ
	oqmnMe/fz6MBu8D72qJ2ky1jxVtNwXBLgfJcIL+loLuR8NdVXio99BmiZViubhalRbPOVoq8bjz
	4Ts0JBGtRN0nUg5a8NrH8p0uGJ4LeUHOEIyuAcssQD8oHERWWzLh9lvCMwmOYLzhcnzIRIvLYEa
	tzoNH7YJiAvhSKQk3iY+2Q0EWgNBOhaWcvQusyOlb5mMXbBOVeOO7dj6xaO+X8A=
X-Google-Smtp-Source: AGHT+IEnc6PYsekT6MewbYE2xz5zbksEbwPRypdKB1fVzKJg+O8NyDF3d1M1ZZ7rEg687HtSnDkx0Q==
X-Received: by 2002:a17:90b:2f44:b0:2ff:5357:1c7f with SMTP id 98e67ed59e1d1-301be204e8dmr956493a91.30.1742343339529;
        Tue, 18 Mar 2025 17:15:39 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:39 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kuba@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	mingo@redhat.com,
	arnd@arndb.de,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC -next 02/10] splice: Add helper that passes through splice_desc
Date: Wed, 19 Mar 2025 00:15:13 +0000
Message-ID: <20250319001521.53249-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319001521.53249-1-jdamato@fastly.com>
References: <20250319001521.53249-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add do_splice_from_sd which takes splice_desc as an argument. This
helper is just a wrapper around splice_write but will be extended. Use
the helper from existing splice code.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/splice.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 2898fa1e9e63..9575074a1296 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -941,6 +941,15 @@ static ssize_t do_splice_from(struct pipe_inode_info *pipe, struct file *out,
 	return out->f_op->splice_write(pipe, out, ppos, len, flags);
 }
 
+static ssize_t do_splice_from_sd(struct pipe_inode_info *pipe, struct file *out,
+				 struct splice_desc *sd)
+{
+	if (unlikely(!out->f_op->splice_write))
+		return warn_unsupported(out, "write");
+	return out->f_op->splice_write(pipe, out, sd->opos, sd->total_len,
+				       sd->flags);
+}
+
 /*
  * Indicate to the caller that there was a premature EOF when reading from the
  * source and the caller didn't indicate they would be sending more data after
@@ -1161,7 +1170,7 @@ static int direct_splice_actor(struct pipe_inode_info *pipe,
 	long ret;
 
 	file_start_write(file);
-	ret = do_splice_from(pipe, file, sd->opos, sd->total_len, sd->flags);
+	ret = do_splice_from_sd(pipe, file, sd);
 	file_end_write(file);
 	return ret;
 }
@@ -1171,7 +1180,7 @@ static int splice_file_range_actor(struct pipe_inode_info *pipe,
 {
 	struct file *file = sd->u.file;
 
-	return do_splice_from(pipe, file, sd->opos, sd->total_len, sd->flags);
+	return do_splice_from_sd(pipe, file, sd);
 }
 
 static void direct_file_splice_eof(struct splice_desc *sd)
-- 
2.43.0


