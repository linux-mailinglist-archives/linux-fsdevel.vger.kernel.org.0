Return-Path: <linux-fsdevel+bounces-71571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2132CC820D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 15:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66BB63100E85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 14:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B1D3659E6;
	Wed, 17 Dec 2025 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rubrik.com header.i=@rubrik.com header.b="TG/2wG/a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD5E3624DA
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979921; cv=none; b=o8x/BpcJ6UBwgESG8Sd0D6m3+KCXPrR5MlySGEF5caUNbEtEaF9sfwcZ2GtP75WXk3Y4c/6CqeKUq9W5dSEYzOuwKbCqJWrdqPCO4W0530R4Ma54/NxWlYAbgGM2eqBugjuX1pOq7cFcykUgXIwJ3RxOFScw6dgMB94z2ilynIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979921; c=relaxed/simple;
	bh=qItl9sa8L7SQrARv/XZpguTXl9gIuAhKcjlR2tO0zos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V4Pc0CyB5kyBDWllCi4iAi1WKLgIHNAjdgQ5dzc9Z4EbfWKLzzofWpypn6iC3mBpgYk5LCN7ZEY+/DQJaMdJBrw7p2onlGNWLuAf3FibYXGGxbekvK7yaiPh3+lcviUi2afVoj6v+6D0CRV5OZf7foGiGQnSVHvAE9SZz+191vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rubrik.com; spf=fail smtp.mailfrom=rubrik.com; dkim=pass (2048-bit key) header.d=rubrik.com header.i=@rubrik.com header.b=TG/2wG/a; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rubrik.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=rubrik.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-bfe88eeaa65so3938760a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 05:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google; t=1765979918; x=1766584718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptwtt+7iwc8IzS1v+59q7h4HdRyFJdDj1rau74ncEYA=;
        b=TG/2wG/aypzuv4W8kVqukeqMv5iGKxmv59WezElkMKtZCJQW1uzHYxXpLj4bVmDqUz
         sa//C1KLpeyHod09RWyVK2Wvl7Own3L427YAcRmqVPFe1qGdSuGpAsfBzWFoKYHchGaN
         zn3pagDD4ESmEbT6J6CIDmrhYpQ24ZWuxJsaMrtB/VfU7uQoqd5UUlKi8UqGVmJdVly+
         /35Spp79Qv1UPHuyjFAtyxvJBR4aXuQBOrEbziLQpUxRlGPdlEjHvv3aMYzyo2PkiVwn
         2fKJihzSFYGi69SNi/0f4h6tFN+7sXirFLZcUne7NspsdHBl+qx7xi20Nt1td+AiVqFH
         XDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979918; x=1766584718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ptwtt+7iwc8IzS1v+59q7h4HdRyFJdDj1rau74ncEYA=;
        b=abUMF3t4iQvg2IH+nK013GY2zuGMu9lGIIpoair4pvGPKXOX61RHwlIoMpMv0gKbFA
         aHaUq3WoAiGUlBijOKjNcM4fNhKxjdd4qvGmBLaD8rSwWdfQiBWJFgWlozbfbFl7VrXP
         EN8vyyilTY9dnDjBcydRRHH2dbm7qIuFX6fti90pAer/q+4/n/mh47exuKgjbaXgHyw3
         6Ggyc/EfklArluSXJquiD2tsuWait7Ptf/4MtMgPI/MDGneFDch/oRkfAw4Utz3Y05Z9
         CAAgCfnJ00yxyuEnU8KEpKlpTvIUD5d4qpA9GIGgxSgp93zJZumiHxF5Or9kePm/eSH4
         l8vw==
X-Forwarded-Encrypted: i=1; AJvYcCXK9mt5+vErxvjheccdUQ+oU6yel/wkitb49pZgqODfD/byGKMbELzOxDciyIK9AaDeo/TARkEuHm0iNPyW@vger.kernel.org
X-Gm-Message-State: AOJu0YzbuPQvqtQxwuo0X1YaYsa/bd9va/hwOdzn8zxJTY7eJH0E+mJD
	MhaaRLANxC3lAbJe85yCImaW2MAxW1suDFeES7l8EYnrhc7HnLhCv+Tu5qizXforSXA=
X-Gm-Gg: AY/fxX4lG4w8HI9ypSh+51XVWsk3WdyaRhBHE9WzMj3poSE5EkwGrTCP9JdaqhcqQdC
	nvjsv3C0YQkrFjf1gUOnB5ler5NaMoN3S5p4VQbi++UlPNZUJLUF4XVdrUjYtk8/elJKAYBhnW3
	8UfGpXXvTJKMotjGaLMRI9lGHfAYfMHznZ+k3Ji/a5dSUJ/vPbtF9GrSMwuO1Es4/PGlZjO7xhA
	wHnEL/aUD6v+oLf8yxbb9Qope8yF3Cjkkfs45X9w1OXUMt/yHIuIS5mUjlfyKpwVKsIi1GQIghj
	eZN0v48Ox1n/c/4YLT+3vqrD/kH1IeMgYFBNqkmOqdC+NXXH9p+wBJu8ARg2qRKDu62rYHClZo/
	ZH7T7Trx5D67PfPDZKiVHHAWAwkfE5cSchCvp3q9NBimwkPH4/l1m0mqfOvh5oEEBNAcGDYtP4l
	wHXM5IBSdBsC+NT6gRwHwblPKhirUFuJmD+9XNUwKXCnH/hfDzP3fegb4llciiaw==
X-Google-Smtp-Source: AGHT+IG2GTFFPr/xCWj5OLgUX/YtW6Xiixe5o8MmTCvNgbsVR0iM522+YPUx4bg3FtgQAgp1aiIbUw==
X-Received: by 2002:a05:7022:2485:b0:11b:9386:a37b with SMTP id a92af1059eb24-11f34c48e76mr17484864c88.42.1765979917564;
        Wed, 17 Dec 2025 05:58:37 -0800 (PST)
Received: from abhishek-angale-l01.colo.rubrik.com ([104.171.196.13])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e30b799sm61526865c88.17.2025.12.17.05.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 05:58:37 -0800 (PST)
From: Abhishek Angale <abhishek.angale@rubrik.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jan Kara <jack@suse.cz>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	NeilBrown <neilb@ownmail.net>,
	linux-fsdevel@vger.kernel.org,
	Abhishek Angale <abhishek.angale@rubrik.com>
Subject: [PATCH v2 1/1] fuse: wait on congestion for async readahead
Date: Wed, 17 Dec 2025 13:56:46 +0000
Message-Id: <20251217135646.3512805-2-abhishek.angale@rubrik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217135646.3512805-1-abhishek.angale@rubrik.com>
References: <20251112083716.1759678-1-abhishek.angale@rubrik.com>
 <20251217135646.3512805-1-abhishek.angale@rubrik.com>
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
index 6d59cbc877c6..b4befe21165f 100644
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
index 6014d588845c..0cfcd27e7991 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -975,12 +975,18 @@ static void fuse_readahead(struct readahead_control *rac)
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
index 026c6c0de3f4..008ac2fa6a76 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -722,6 +722,9 @@ struct fuse_conn {
 	/** waitq for blocked connection */
 	wait_queue_head_t blocked_waitq;
 
+	/** waitq for async readaheads until congestion eases */
+	wait_queue_head_t bg_congestion_wait;
+
 	/** Connection established, cleared on umount, connection
 	    abort and device release */
 	unsigned connected;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 21e04c394a80..973f70064e89 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -979,6 +979,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	atomic_set(&fc->epoch, 1);
 	INIT_WORK(&fc->epoch_work, fuse_epoch_work);
 	init_waitqueue_head(&fc->blocked_waitq);
+	init_waitqueue_head(&fc->bg_congestion_wait);
 	fuse_iqueue_init(&fc->iq, fiq_ops, fiq_priv);
 	INIT_LIST_HEAD(&fc->bg_queue);
 	INIT_LIST_HEAD(&fc->entry);
-- 
2.34.1


