Return-Path: <linux-fsdevel+bounces-35648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B6D9D6AB5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 19:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D3B281A64
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 18:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFBA13B58D;
	Sat, 23 Nov 2024 18:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4/zPpNJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEB02AE90;
	Sat, 23 Nov 2024 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732385584; cv=none; b=clLQF4LgT9kk20Jw21JgUMHx3z2avLL81SqbWYgT1Yauex/JHKkiJskkQk5Fv6ulSM1bZVsfim1Or1v2BBxEA3GSSn7iOInjbb7OxyT6MxjvumyRcN8kYCI7ONN9vWDUoQ2+eOBK0VACZl+3GxeUY2aB3S9ADWstE7PLSlTdaXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732385584; c=relaxed/simple;
	bh=ByC/Z6r7l+hea8zqsjcZiQtqqoWRnkIS18YTDSe6o88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xf0KgYhpYL3IGbrCLgoGTIVfL1GX7f0H1gg1Te2kKL811pfHs/UqQ0dKyG6C/h3F2kDS45l7oIegvEyPo5kDfKCbx2EIJjuaX7mTw8MRQJHgWQfy6H0jA6QlazoaHtl7SWPABMO4hQwpq7bqswmIYTNtMv7+7WMP5z/0ggiMQBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4/zPpNJ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ee6edc47abso2382738a12.3;
        Sat, 23 Nov 2024 10:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732385582; x=1732990382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yi7/4Il6m4z1prw3HItGvYyciFoIT2EmfSe3QDrC7Gk=;
        b=G4/zPpNJKlSNuK873l43xZeedWtAChB+5jVLE/cqKoDdfOyHBraFbL/Ak81PeSlUwY
         a+W2Q3V4IVyQ3Onbdu16u6bpEsaRKrBtsySVMgkF3Pqvb6NA/NOQqbg6iO44iX/XFzca
         +IQ6p1s4av30kM8LKi/lHTsyL2vW9kT2+YJ04ZR4Tr620WJ68p6+Zx2KJ/hKIvlNV4C5
         nxco7zJ2D+hnhfxp7hgfciu+uc8LnV5cdKaBLGPSLm/I9KpRk5QLTddPfGtC3fyUmWTF
         6wJTofSsrxU4XfXxHRnqimeUFrTsLm1JbOpEjkT4DP7Duh2mPTZRLk/ZkhSGkVfQJgRs
         HOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732385582; x=1732990382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yi7/4Il6m4z1prw3HItGvYyciFoIT2EmfSe3QDrC7Gk=;
        b=Ux6yLdercpI5EuvSIUVkn9HYEBt3VoVBd8+gsu/X6vckAgDJUuQgSEIPLAuGSaOEzp
         pQnKx9lj1VtZ1c577fTAo71b9xGyr2mcw6nD0uaHOTC4EiGP3l963vWdNp+bY5vqBWKg
         cUkaclXy5jQvsgWJXSkSL/RSVCpDC4fGKlbobCHUSc1AUMIKFotjsnEVRkOITcRcae4a
         HzYOt7bzaMxKQFiBdfxA8bdDbAHqZXADrMdItCQO5PxlrfR2Xk0TRMJgViXDGIHFoL0u
         RNq2/3HrrqArCz00S95QZ27q4VYHB3hcc/LmcU3N81yspKjTHlhLotylOmPdAOD59dRS
         rCsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZjNCplmvqWunsPgSrWMR4xG9GpKaxL3+t9Ptg35pAsdbS4oywxg5BOt3hDybm0+dNYR1uq2rjEWFalILZ@vger.kernel.org, AJvYcCXZk+a7cmVvacw/NZRhWxBeYwbDOrRm0IavU+gEzS+4hl9Qak8TWzPA5C7X0msWVQzyg1/cpRPp+yMxUFwP@vger.kernel.org
X-Gm-Message-State: AOJu0YyvVoSFapU0HR2DL3/frmVd5rqEURF3dg9S+niJ5yQc8Dd6R/JY
	J+wqHwOj9m+GwCGifv0HqQucJHvcLnPXohMFOt6qiCKSS/WxsBkH
X-Gm-Gg: ASbGncvGQmKfazWZQ2lK1rR5ImtTjnuWbXgcpFThMTI6Bu+Dp1ZkjVef400tH1/07Tz
	ap0F080CqvOZk2EvOqMsmeLOrdo8lFLnCe2SNwqkYb9hpSW3LdQSIi8vJRlG4+emPzIa9Wj9Qxa
	7qh8qm1dLpcN2U5wa05zZNy7SoLKmpKsDBKNezDQvla3A/ds5CacgteFK0Tl8KfqvGma8dNi5eH
	EtGMKuTEZpDEUVYh8tTUXbY+7FudVhN8WoHchxUKdfUWmT2xzkrKz27ArQ0QeU2zQ==
X-Google-Smtp-Source: AGHT+IGVB/psrgXrHZ5x7kwrUPVWwcgPghBpElQMOKTK2PDbio6Qo4nr3pWgdKBTbACDka6k2gWrBg==
X-Received: by 2002:a05:6a21:78a8:b0:1db:e49a:d54a with SMTP id adf61e73a8af0-1e09e45744emr10208153637.19.1732385581909;
        Sat, 23 Nov 2024 10:13:01 -0800 (PST)
Received: from localhost.localdomain ([119.28.17.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724ec041406sm2321062b3a.79.2024.11.23.10.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 10:13:01 -0800 (PST)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: alexjlzheng@gmail.com
Cc: adobriyan@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	flyingpeng@tencent.com,
	jack@suse.cz,
	joel.granados@kernel.org,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcgrof@kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH 4/6] sysctl: ensure files_stat.max_files is not less than sysctl_nr_open
Date: Sun, 24 Nov 2024 02:12:56 +0800
Message-ID: <20241123181256.184004-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.41.1
In-Reply-To: <20241123180901.181825-1-alexjlzheng@tencent.com>
References: <20241123180901.181825-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce proc_doulongvec_maxfiles_minmax(), ensure the value of
files_stat.max_files is not less than sysctl_nr_open.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/file_table.c        |  2 +-
 include/linux/sysctl.h |  2 ++
 kernel/sysctl.c        | 17 +++++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index db3d3a9cb421..01faa9c2869e 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -119,7 +119,7 @@ static struct ctl_table fs_stat_sysctls[] = {
 		.data		= &files_stat.max_files,
 		.maxlen		= sizeof(files_stat.max_files),
 		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
+		.proc_handler	= proc_doulongvec_maxfiles_minmax,
 		.extra1		= SYSCTL_LONG_ZERO,
 		.extra2		= SYSCTL_LONG_MAX,
 	},
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index aa4c6d44aaa0..4ecf945de956 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -82,6 +82,8 @@ int proc_dointvec_userhz_jiffies(const struct ctl_table *, int, void *, size_t *
 int proc_dointvec_ms_jiffies(const struct ctl_table *, int, void *, size_t *,
 		loff_t *);
 int proc_doulongvec_minmax(const struct ctl_table *, int, void *, size_t *, loff_t *);
+int proc_doulongvec_maxfiles_minmax(const struct ctl_table *, int, void *,
+		size_t *, loff_t *);
 int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int, void *,
 		size_t *, loff_t *);
 int proc_do_large_bitmap(const struct ctl_table *, int, void *, size_t *, loff_t *);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 05b48b204ed4..5ee2bfc7fcbe 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1122,6 +1122,23 @@ int proc_doulongvec_minmax(const struct ctl_table *table, int write,
     return do_proc_doulongvec_minmax(table, write, buffer, lenp, ppos, 1l, 1l);
 }
 
+/*
+ * Used for 'sysctl -w fs.file-max', ensuring its value will not be less
+ * than sysctl_nr_open.
+ */
+int proc_doulongvec_maxfiles_minmax(const struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
+{
+	unsigned long *min = table->extra1;
+	unsigned long *max = table->extra2;
+	unsigned long nr_open = sysctl_nr_open;
+
+	if (write)
+		min = &nr_open;
+	return __do_proc_doulongvec_minmax(table->data, table, write,
+			buffer, lenp, ppos, 1l, 1l, min, max);
+}
+
 /**
  * proc_doulongvec_ms_jiffies_minmax - read a vector of millisecond values with min/max values
  * @table: the sysctl table
-- 
2.41.1


