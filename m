Return-Path: <linux-fsdevel+bounces-53654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7E6AF5A39
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 15:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FA147AFB77
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 13:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D0127A477;
	Wed,  2 Jul 2025 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISemkQsk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09BD2652BD;
	Wed,  2 Jul 2025 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751464433; cv=none; b=IvY4Cep4jAdPbw0ia2kj2DVFbJqANiAFBxxJLW/V/nuMaun8XUAZg4BcBa6DjGPeGAdB3pIb5qcDZbhCIE5ceuer6Qxsbd2iUZ2xbkKUvwWTKE+nXceDpyRyvS4CIHIgk2e4D2rQthtnVvCxqTmDWeyz1euRURE+AOd/Cj6QMgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751464433; c=relaxed/simple;
	bh=oL5ROgMkCNu3a/za1C5UVisYMIlOPy2PoMgM8u/9u5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eQE26aPw/VB0kyO9Q9aa/7i5Q8T9jqnvHwkKHodwjF0V7LUqJWIEseEbcnhgIKv2imTEuZ+hFxloD/LRzxo6WC5r7moQKYezOrUXADzevoSmL6TupPaQEmSl+jPJe7gIafoepuZ4CUqASj45934iJcnqo9IAYhmt1sFISqZBQW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISemkQsk; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so7435920b3a.0;
        Wed, 02 Jul 2025 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751464431; x=1752069231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZDvTF9WG0Sc0wOYg/V56v6aDtZy6k2fKHx6MlmQhok=;
        b=ISemkQskYYERDqsm1ksklgeIPgEpEVRSj54uApu8AJNxg9UuqhMPcNYLlKTCp8OXq9
         5EdV5CS9zoyoD5h60YmhooziOM7k0WEmFrJZ7GW4r34FPAviRkDb48Y/381edFii0SaS
         UzQePhwjPJJr9iPXDE5w8P4nPJKASxDj6BTIwm389T7n5Q8oXnGGUQF/rLCImZcAzaOV
         356Rlo8/GWfLF+JR2NPJV2zqY08uwGRTl3icGRxGFI2hTdToIlRGXdgACVI3BFF/xf/O
         JnYVw62Ok2YQTfUOvvuyelCs8mE+UXEK6gkpjXg+159X484g+RrWVEC1EWkODhYVgWw5
         zfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751464431; x=1752069231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZDvTF9WG0Sc0wOYg/V56v6aDtZy6k2fKHx6MlmQhok=;
        b=Q/8MPw3WEhLfpEhTtgnyPudv5nCoDCBbUXeMBu3fAaFlS7ZKCBoV0me+22i4ln6mIk
         veW/L0LYX/GAB5SkhApfdfSaXOR9wuMWhoE6GLAiFDpuVkKFiUKld3+LTPSMiBw+Tohb
         5DVKQD02uByzIVDHibqL4JVwm8SNGH24l52vDj0ce4rVtTQo/iZepugl6o30HGOAREW2
         Npsds/UFIRZ2jH3inbefhcG+tD7zz61uIj90yOZ6CxJIlevrJliN5nzjL37+G9U5sKec
         1aVbCwg7D2g8+ueWT9iBnhN8eq+6OPfPfJBUhDHxoVWfXBXlVFSzdKhjkNlEh1jqw38s
         yBVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5HZgX+OmfUQ0pCRXAmtSHHwPfHcLZXwjWnN53B1dPA09+9GIM1ZAWdmy0ik6cNoXE/ZsiG5Ic04oC/Vpo@vger.kernel.org, AJvYcCWTqFlHHTMVhGNiDa+NqkWVZPQP3Wd63R86l7mROSeTILrcrDt/qJuQdp39qMTyuebTRqPeeIoyfa+z2yvl@vger.kernel.org
X-Gm-Message-State: AOJu0YxbNLnfSf7js6G7ivKNrQKqeiUbSA+RRaGrmLwAzyaOCJ4CH8iu
	dSNisRvvfCgBpLDp8+F9fL9f4jh2O7KdplEdA23n66EnTk1xFsfpo3Vk
X-Gm-Gg: ASbGncvm/Yb2b02Eb7vWT7LvXF5VmSV4ia9U+qDEE1Q/8CTcFpL1P1HCbsWzhJaGKS2
	/4jcTT9YbfpqYwDLtHkjjAnuyTvf/bpF7hn2btTsJReMzuQFUe/e1kBJ3N1kpsIsnu/Usc+WeQA
	r+6oY4wZK1jUey6VI+GkeR3ens+2CxExGqeRjwnxf2JMpuRGVcNmykVVUN4FIv96ebUe5xc7ftP
	fFcIOAyrVGpDDL8ov1ZIsdwvbJ700f969OZi8Y5XwFNdwOIS50shidHne/TnbxeYQqARSnOSvJG
	QSbwYBHKbp+NFEERdk7+7hDtGqbydO/ghgQlyiKiq+3Ews2GYpQ4HPC4jUwYNDF6z8mbm1Jg6T6
	k
X-Google-Smtp-Source: AGHT+IFY/fMo+EcugOFY0yLHK6w4ow8m13WDFJmbyFs8qEuuD7i0KEMYSTC3rgcjlAP/Ax5lXWr8rw==
X-Received: by 2002:a05:6a21:4ccc:b0:21a:ed12:bdf9 with SMTP id adf61e73a8af0-222d7df6094mr5135889637.17.1751464431135;
        Wed, 02 Jul 2025 06:53:51 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e3214d9esm12910305a12.71.2025.07.02.06.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 06:53:50 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	andrii@kernel.org,
	osalvador@suse.de,
	Liam.Howlett@Oracle.com,
	surenb@google.com,
	christophe.leroy@csgroup.eu,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzbot+6246a83e7bd9f8a3e239@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH next] mm/maps: move kmalloc() call location in do_procmap_query() out of RCU critical section
Date: Wed,  2 Jul 2025 22:53:32 +0900
Message-ID: <20250702135332.291866-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In do_procmap_query(), we are allocating name_buf as much as name_buf_sz
with kmalloc().

However, due to the previous commit eff061546ca5 
("mm/maps: execute PROCMAP_QUERY ioctl under per-vma locks"),
the location of kmalloc() is located inside the RCU critical section.

This causes might_sleep_if() to be called inside the RCU critical section,
so we need to move the call location of kmalloc() outside the RCU critical
section to prevent this.

Reported-by: syzbot+6246a83e7bd9f8a3e239@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6246a83e7bd9f8a3e239
Fixes: eff061546ca5 ("mm/maps: execute PROCMAP_QUERY ioctl under per-vma locks")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/proc/task_mmu.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f3659046efb7..42b0224c6ac9 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -595,6 +595,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf = NULL;
 	__u64 usize;
 	int err;
+	size_t name_buf_sz;
 
 	if (copy_from_user(&usize, (void __user *)uarg, sizeof(usize)))
 		return -EFAULT;
@@ -621,12 +622,18 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	if (!mm || !mmget_not_zero(mm))
 		return -ESRCH;
 
-	err = query_vma_setup(priv);
-	if (err) {
+	name_buf_sz = min_t(size_t, PATH_MAX, karg.vma_name_size);
+
+	name_buf = kmalloc(name_buf_sz, GFP_KERNEL);
+	if (!name_buf) {
 		mmput(mm);
-		return err;
+		return -ENOMEM;
 	}
 
+	err = query_vma_setup(priv);
+	if (err)
+		goto fail_vma_setup;
+
 	vma = query_matching_vma(priv, karg.query_addr, karg.query_flags);
 	if (IS_ERR(vma)) {
 		err = PTR_ERR(vma);
@@ -679,20 +686,12 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	}
 
 	if (karg.vma_name_size) {
-		size_t name_buf_sz = min_t(size_t, PATH_MAX, karg.vma_name_size);
 		const struct path *path;
 		const char *name_fmt;
 		size_t name_sz = 0;
 
 		get_vma_name(vma, &path, &name, &name_fmt);
 
-		if (path || name_fmt || name) {
-			name_buf = kmalloc(name_buf_sz, GFP_KERNEL);
-			if (!name_buf) {
-				err = -ENOMEM;
-				goto out;
-			}
-		}
 		if (path) {
 			name = d_path(path, name_buf, name_buf_sz);
 			if (IS_ERR(name)) {
@@ -733,6 +732,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 
 out:
 	query_vma_teardown(priv);
+fail_vma_setup:
 	mmput(mm);
 	kfree(name_buf);
 	return err;
--

