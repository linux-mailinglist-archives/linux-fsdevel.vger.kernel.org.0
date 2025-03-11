Return-Path: <linux-fsdevel+bounces-43698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF3FA5BF6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 12:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BDD1899C3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 11:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954642566CE;
	Tue, 11 Mar 2025 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbFPMhhX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B1C254B1B
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693324; cv=none; b=kMuQCjfPx2qakLQFPep7F7Q4N7aVC+tFbTFHWtePe6T/T6MkDByqMPdRo6V3cqoAONHjmbRFipoorPye6g4pnTFSoArmdcYkqNJMJOjOL5Kp49k+j55O5iTfK1vMdMSHXemQ8IVNuxZxotjnQL7g1krXb9HJIkSCt83Yn5hHKaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693324; c=relaxed/simple;
	bh=BBxOOGa0e/TjU3macJ1B64w40/0lMtH0exwdv8IsIqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PVUa7QiBqQRLHS0RQiTUKZPUoj9HMvC3t07Sr+LUiNhNjF/3qg9hy0jqtos5cyX8E0HZ4S+68X93ijmk5xRGJ2YNyIpxvmOZKeEEAMk7eoARx2Af+wWCv5w8+0RPCb/yg/0/dRThc6zWXklLXmfdNNClHahgvgIFDasozGIv5oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbFPMhhX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso22819145e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 04:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741693320; x=1742298120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LWiYFXrKdxrv5GZCsPLgeGjiJIUrbXXnL2aZByYV4A=;
        b=mbFPMhhXSXzxo6ziBY2X49Tn6bee+Jrl2NQmJ5wEAG8eATzz97gLW5Ol12McXrlgyz
         lAqrcCUV4d0IAE62h6myiMnfXDs1CDLo0CWcfA/qISLM+KmClegAKpZP+6IJAJWt4KEQ
         Dni9SPjz87B5+vy2OiPoMi8x6MapEQSUhZuv3UszSfxtHGhtxxGcRPoBjhwqH9IZwMmG
         LguJvsPF2UrAnVctNy37WmbzRp8oJthL6rPs/dz0JXc8tYlJqmuMQoTQBjoU9cUtqoH4
         4VFM06KBg+hYmC6gwefzbIXPY5a9g1xXU8h610zaVDdSoqt6T1mAH84GjUtVj9YCeozA
         lylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741693320; x=1742298120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LWiYFXrKdxrv5GZCsPLgeGjiJIUrbXXnL2aZByYV4A=;
        b=npNNCNNagTjx27ZSEexS/6nL1CvcTmcmZ7b2sMo5pZXMmuQTilhvsU19JJj2F8i5+Q
         71iELyMUI0aej+CRQufvhWrKfkmrxwFWSxtswpix2MiDzzCCCUPK5PPP2YMh4yz8bfPw
         i/MebfC0/EoSOQnpro76G4P0nSRW9HWAiOvNFz36yu48ic8rQsV3IAUZVCLs37pytUIG
         ouNbuBoEitm59dpJGwTArAEfulhVk5g3ce0IE56sNhykSi2bifFTuzfOLf84DGE6ErE+
         QOftlQAWRF0n07iBc/EMxs3wSziJTdQuUSKHTr5mFZYXhHx8Xoe8pMtvjWi/jYfn9Gv/
         SfZA==
X-Forwarded-Encrypted: i=1; AJvYcCXz3Yl+L8EsRUTQNptVBo8is7ou/hXdxuRTqLNjQQkJDfPh75hHSlq91sYJuEucnXiMC8n/8N4uwbL/ca54@vger.kernel.org
X-Gm-Message-State: AOJu0YxO+g2kG2eHwxlGCwPt5Lbxd3vxajB7Pcbnfvf4Y3tn6HVwhYmu
	ru42aRkx2gPlBu1BAYPdIMV/nnU2Jd5fPlql0rlqWwyNhF2THQrwHf2GcyRd
X-Gm-Gg: ASbGnct1wSqQYTPlqC8QNA1UGYhPKgtj4ikqU3Yo4tYMllhV+zVy1VaPwcwsV+Ie+3U
	Dxil5IMIRdWIVNPW0Y3TlBKtdMC6zz0VNM+5+XtUSb8rDGlQcyLgCrpjJTnsogFDp8aTU6lzwi2
	+JceGFZLuT5fKPmvfGyS0+WwLnBO7FXpL1qsxjvjjk9iRR+lEVH0T+vDKyiNmYNbEW7K9S3JViB
	oj9N9/62O4aRZBilAG1BuET9Zm8n5OTsdffZ62Qyxl+fPdbAovA4hheHC8ClMbCWwGPqJC0Ayvq
	HeHc9G/IrOtHDMxp1uego+dPH4B6ds2QL+fHDdKY9tiA+5mFvndSyihbYQ8WlGeSPMWZdIkfDkJ
	xoPocl5nixe3XD/ADhb717cllpzdI81yXfj+ul4VFPA==
X-Google-Smtp-Source: AGHT+IHRrNckHtWKqXE2GcoA18nuJrHyK6Stltvj6KwcLJLRRhBJUiuKccsdZPhjhYRh+tf6mS/xhg==
X-Received: by 2002:a05:600c:45d1:b0:439:6118:c188 with SMTP id 5b1f17b1804b1-43c5a62a276mr114232015e9.19.1741693319941;
        Tue, 11 Mar 2025 04:41:59 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cea8076fcsm111297525e9.15.2025.03.11.04.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 04:41:58 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] fsnotify: add pre-content hooks on mmap()
Date: Tue, 11 Mar 2025 12:41:52 +0100
Message-Id: <20250311114153.1763176-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311114153.1763176-1-amir73il@gmail.com>
References: <20250311114153.1763176-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pre-content hooks in page faults introduces potential deadlock of HSM
handler in userspace with filesystem freezing.

The requirement with pre-content event is that for every accessed file
range an event covering at least this range will be generated at least
once before the file data is accesses.

In preparation to disabling pre-content event hooks on page faults,
change those hooks to always use the mask MAY_ACCESS and add pre-content
hooks at mmap() variants for the entire mmaped range, so HSM can fill
content when user requests to map a portion of the file.

Note that exec() variant also calls vm_mmap_pgoff() internally to map
code sections, so pre-content hooks are also generated in this case.

Link: https://lore.kernel.org/linux-fsdevel/7ehxrhbvehlrjwvrduoxsao5k3x4aw275patsb3krkwuq573yv@o2hskrfawbnc/
Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 mm/filemap.c |  3 +--
 mm/mmap.c    | 12 ++++++++++++
 mm/util.c    |  7 +++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 2974691fdfad2..f85d288209b44 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3350,7 +3350,6 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
 vm_fault_t filemap_fsnotify_fault(struct vm_fault *vmf)
 {
 	struct file *fpin = NULL;
-	int mask = (vmf->flags & FAULT_FLAG_WRITE) ? MAY_WRITE : MAY_ACCESS;
 	loff_t pos = vmf->pgoff >> PAGE_SHIFT;
 	size_t count = PAGE_SIZE;
 	int err;
@@ -3370,7 +3369,7 @@ vm_fault_t filemap_fsnotify_fault(struct vm_fault *vmf)
 	if (!fpin)
 		return VM_FAULT_SIGBUS;
 
-	err = fsnotify_file_area_perm(fpin, mask, &pos, count);
+	err = fsnotify_file_area_perm(fpin, MAY_ACCESS, &pos, count);
 	fput(fpin);
 	if (err)
 		return VM_FAULT_SIGBUS;
diff --git a/mm/mmap.c b/mm/mmap.c
index cda01071c7b1f..70318936fd588 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -48,6 +48,7 @@
 #include <linux/sched/mm.h>
 #include <linux/ksm.h>
 #include <linux/memfd.h>
+#include <linux/fsnotify.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -1151,6 +1152,17 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 		return ret;
 	}
 
+	if (file && unlikely(FMODE_FSNOTIFY_HSM(file->f_mode))) {
+		int mask = (prot & PROT_WRITE) ? MAY_WRITE : MAY_READ;
+		loff_t pos = pgoff >> PAGE_SHIFT;
+
+		ret = fsnotify_file_area_perm(file, mask, &pos, size);
+		if (ret) {
+			fput(file);
+			return ret;
+		}
+	}
+
 	ret = -EINVAL;
 
 	/* OK security check passed, take write lock + let it rip. */
diff --git a/mm/util.c b/mm/util.c
index b6b9684a14388..2dddeabac6098 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -23,6 +23,7 @@
 #include <linux/processor.h>
 #include <linux/sizes.h>
 #include <linux/compat.h>
+#include <linux/fsnotify.h>
 
 #include <linux/uaccess.h>
 
@@ -569,6 +570,12 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 	LIST_HEAD(uf);
 
 	ret = security_mmap_file(file, prot, flag);
+	if (!ret && file && unlikely(FMODE_FSNOTIFY_HSM(file->f_mode))) {
+		int mask = (prot & PROT_WRITE) ? MAY_WRITE : MAY_READ;
+		loff_t pos = pgoff >> PAGE_SHIFT;
+
+		ret = fsnotify_file_area_perm(file, mask, &pos, len);
+	}
 	if (!ret) {
 		if (mmap_write_lock_killable(mm))
 			return -EINTR;
-- 
2.34.1


