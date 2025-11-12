Return-Path: <linux-fsdevel+bounces-68021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB72BC5124B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 09:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B2D189610F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 08:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02CD2F616C;
	Wed, 12 Nov 2025 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rubrik.com header.i=@rubrik.com header.b="cHFNdT2O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926E02874F1
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936702; cv=none; b=BJRn8G7uleJCYjmUNl6e8CmuaJuzHjPWamNmJ+9I9+m0Z2KMtuOKV2dM4LUBezScLe5pAnXiBpczBg5EuyUrOs8VL2BMw1ZJyOrZ+cSNoa+XtdEdN1McfFTD3OxHvnYe/rKiBEMKqYV/dFa23K0gW5bxEVFwp3Aova8jIDV/eUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936702; c=relaxed/simple;
	bh=5UpHKq4dl//0/rHYIuOcgSUxDBwbJTxv7jVWBZWT4kI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gXVNyn5BONv11Vo+q6d69rwdXy+cq5tMaZm0gIs2cj0LjsX4lok03lXsZ1aGCYoTgnfZ9ML2paIBHw+MGc3LFfCewg3m6UlDLJ6a4o1hXKSOFGN0dMOAIu9SXTHkh7Z5in4MesdKyGqzN/UUmCTq0xMt5S9xRUvQmr8MIHipwMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rubrik.com; spf=fail smtp.mailfrom=rubrik.com; dkim=pass (2048-bit key) header.d=rubrik.com header.i=@rubrik.com header.b=cHFNdT2O; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rubrik.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=rubrik.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b0246b27b2so780243b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 00:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google; t=1762936700; x=1763541500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YZ1VJ7I2ZxNrlRYdtIHnYVmLUo2i7Z5ixmuc3Jgjeu8=;
        b=cHFNdT2OficBBnbiswoWkPByyqZ53qPPsJz/tY+cdYm3+mxi121HyNguWRFDa14XcC
         mjN2mCSNxKJfxYd4C89nquHJkXguc+tr/rmB/iEPPWV1WbGbYJTOH+Aaqz0Ufu56pTzr
         Zw/F9LSSMmkqQ6i6U2JTKqAriLdpqeekSXZtbczBS6ad5GvyY/h2zncW/H2NhQn4DdEV
         WPnYdfA+3wHUrKFBMK59ONyp327BjtdYFpnb5ahqE9j+sFdhqV1m66MMn53c7I0JJDd1
         aYmlcilrTaT1S7mzonQcL4Lvdme0c0yxJKckkRlczxpeOcLK9jeUQlbJIZ0L6id0h5Jv
         RJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762936700; x=1763541500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZ1VJ7I2ZxNrlRYdtIHnYVmLUo2i7Z5ixmuc3Jgjeu8=;
        b=qUpP7S7fDxPnHAmxGnuttutbSOV2iMxPZ+q/junmOE0BNKERPzOePISx+MVUupRINm
         lg7NKVAxz4XnBF2GZYz0fDwZjzNOhWWJ/b624poTHgXL8Q2HoEDaoLPZXh7Z4NYml6Dw
         WJy97wJlsqs5G8TRExlnmoLjVJp4nTIlk204507vqIXsv2Mv5y69xzM7wbxJRqmNnH5o
         KrTi1PnNkLueWMslsOya+zC0wlXJzyywZfYMKupqbq6pFtWOeo/Hj53EqBCI1Od2MUQf
         7pVBjNXuAtibQiDQFN+jtv4q/dWYWnwY8Ae0LNP0/KgjSLGVncbTyLULUjGc+g+YEJ13
         IViA==
X-Gm-Message-State: AOJu0YycAIFpkmiIgWuhzeWNJpDxxwBE0C/AhuM+V+n+K/UUNuiPyXO2
	LnPUHcV9riz8J9VuopKZhFZrSWC3ZTL6C0cWaTpuAGw+NnZrXcdAy5I60/JyKeni1wI=
X-Gm-Gg: ASbGnctEl22xy5kLHb5Corc+6b9ptyNeeC1m+GsdPjtYzfh4hlNncCeV+4m/d53G+ZW
	w6bRm7P3rrYQ+nOmDroySjyPr65+ktaeBReqOjz3KuUjmO31JyuMELQ7iLOQTAkSv7sgkH5GY4A
	SM+EvxpSiZr70hI1qSCM9PLPdTDyBqaLNXbObAKvkJJHDQcQeLGxC1sJgMOtORc5rgmJMSNrDhV
	DYCY1pSfnLwDSbgpafejTuLuiCAufx3JL1xrFrhgKNAW+cWiHZTv+yF1fiFuU4kpw5FEMzX2KVN
	MEQuhkeudVmcGpCAfoi5J6Yz6pGXR5oCqBzZ16Znr1qmU9jkNYmMglOe7fzrM0vH33LOtkfW21z
	Owy8jqX7YL+YFtBAE/92ocAcwSMMekPvTBtH6zvs1uJcimJfI/+Nug8bgE7GBBnAI1CFjNEzZuL
	Y2Cqz1tk6eAnsX+vWRowwhhAGR2dvyxqR4VN7VWnP/
X-Google-Smtp-Source: AGHT+IFH7Z6IfWQ0t9Fhxqb4PbJoXiptsBNoPe+9xKSYSYPpaDUkVJwMZ7pvqB8xzKjxzFVP75NLiA==
X-Received: by 2002:a05:6a00:4f8c:b0:77f:4b9b:8c34 with SMTP id d2e1a72fcca58-7b7a5f60d7amr2722022b3a.31.1762936699795;
        Wed, 12 Nov 2025 00:38:19 -0800 (PST)
Received: from abhishek-angale-l01.colo.rubrik.com ([104.171.196.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc868fdbsm17468543b3a.55.2025.11.12.00.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 00:38:19 -0800 (PST)
From: Abhishek Angale <abhishek.angale@rubrik.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	neilb@suse.de,
	abhishek.angale@rubrik.com
Subject: [PATCH] fuse: Wait on congestion for async readahead
Date: Wed, 12 Nov 2025 08:37:16 +0000
Message-Id: <20251112083716.1759678-1-abhishek.angale@rubrik.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 670d21c6e17f ("fuse: remove reliance on bdi congestion")
introduced a FUSE-specific solution for limiting number of background
requests outstanding. Unlike previous bdi congestion, this algorithm
actually works and limits the number of outstanding background requests
based on the congestion threshold. As a result, some workloads such as
buffered sequential reads over FUSE got slower (from ~1.3 GB/s to
~1.05 GB/s). The fio command to reproduce is:

fio --filename=/<fuse mountpoint>/file.250g --rw=read --bs=4K \
    --numjobs=32 --ioengine=libaio --iodepth=4 \
    --offset_increment=1G --size=1G

This happens because FUSE sends requests up to the congestion 
threshold and throttles any further async readahead until the
number of background requests drops below the threshold. By the time
this happens, the congestion has eased and the disk is idle.

To fix this problem and make FUSE react faster to eased congestion,
block waiting for congestion to resolve instead of aborting async
readahead. This improves the buffered sequential read throughput back to
1.3 GB/s.

This approach is inspired by the fix made for NFS writeback in commit
2f1f31042ef0 ("nfs: Block on write congestion").

Signed-off-by: Abhishek Angale <abhishek.angale@rubrik.com>
---
 fs/fuse/dev.c    |  2 ++
 fs/fuse/file.c   | 14 ++++++++++----
 fs/fuse/fuse_i.h |  3 +++
 fs/fuse/inode.c  |  1 +
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index f316a9ef9ff8..f9e5fb64a74b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -496,6 +496,8 @@ void fuse_request_end(struct fuse_req *req)
 
 		fc->num_background--;
 		fc->active_background--;
+		if (fc->num_background < fc->congestion_threshold)
+			wake_up_all(&fc->bg_congestion_wait);
 		flush_bg_queue(fc);
 		spin_unlock(&fc->bg_lock);
 	} else {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f1ef77a0be05..cb800e13c88d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -963,12 +963,18 @@ static void fuse_readahead(struct readahead_control *rac)
 		unsigned int pages = 0;
 
 		if (fc->num_background >= fc->congestion_threshold &&
-		    rac->ra->async_size >= readahead_count(rac))
+		    rac->ra->async_size >= readahead_count(rac)) {
 			/*
-			 * Congested and only async pages left, so skip the
-			 * rest.
+			 * Congested and only async pages left, wait
+			 * until congestion eases.
 			 */
-			break;
+			int err;
+
+			err = wait_event_killable(fc->bg_congestion_wait,
+					fc->num_background < fc->congestion_threshold);
+			if (err)
+				break;
+		}
 
 		ia = fuse_io_alloc(NULL, cur_pages);
 		if (!ia)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c2f2a48156d6..4fcdc84c0f8d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -708,6 +708,9 @@ struct fuse_conn {
 	/** waitq for blocked connection */
 	wait_queue_head_t blocked_waitq;
 
+	/** waitq for async readaheads until congestion eases */
+	wait_queue_head_t bg_congestion_wait;
+
 	/** Connection established, cleared on umount, connection
 	    abort and device release */
 	unsigned connected;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 6fcfa15da868..10aa77dda176 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -978,6 +978,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	atomic_set(&fc->dev_count, 1);
 	atomic_set(&fc->epoch, 1);
 	init_waitqueue_head(&fc->blocked_waitq);
+	init_waitqueue_head(&fc->bg_congestion_wait);
 	fuse_iqueue_init(&fc->iq, fiq_ops, fiq_priv);
 	INIT_LIST_HEAD(&fc->bg_queue);
 	INIT_LIST_HEAD(&fc->entry);
-- 
2.34.1


