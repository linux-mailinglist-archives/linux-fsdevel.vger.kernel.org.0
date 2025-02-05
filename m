Return-Path: <linux-fsdevel+bounces-40865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C397CA27FEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 01:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383B03A5A15
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 00:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2EEBE5E;
	Wed,  5 Feb 2025 00:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="tF/DPe51"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FD312B94
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 00:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738713811; cv=none; b=oS7APQWuL7GC5irKvJQ93zOjgiOQoEP/YGTcfN6H6+nUUR4o+H3b/M0Bi897yY5bPCh1VzQn56wMew0OG5mWSW68v3hryKCAIqztBC2G6kKqb/gG9J2gNxsUEmRYFx66ZYWE3nQVzwKrzz1CdDnUhOruB7jvXk+gTmPowWdV/bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738713811; c=relaxed/simple;
	bh=W48Xmw8pBWO8C8BKhGVAmSx5PQbZVc9PLaufu+t+O+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKHYl7I2NyWBhmf6lZZQ0o5g9X7g3164U2ejBQWI9MLvrntuqAIJ3rB1/o1sVhNFDa4pKJWI242+uD3xjTpeaouOy/AOj4VxsxlaVWhDpsx3eEmnK+xwoipC2rqAB3gNyCeLECR+ChP4UgX4U1h5ULJ8y0KvRdlWDmWG9O67knI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=tF/DPe51; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-71e2764aa46so3719495a34.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 16:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1738713808; x=1739318608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mwe/Wt31zfGjltQoyH9VPBmv6gjaT8PZg5nxto4F+xs=;
        b=tF/DPe51lFNid7i7BT65onMJa+gjqU8HxQvM3DXrbh2vwE1AM4mj6oApvKyu3S0GNG
         6VDgIP+5+v23avsUi7PfuFO3Mx1rxKlC1gOpSo1iB0z5z6vt8wR1htmOk8QC/Q1nPNsH
         RDHVd0p7T5gRgxpKgKfN4DwDD1j4qSeyrq7yOci5Q4rQgx2TYOsSUNBF/QFaaWsLGYuL
         AxDmaWx1LBTXETqcf3Hp87SZ0pnYmXDL4tiqmvjEaiPiYwWANJTxT5acaBFOAhOwqK9Q
         s+0RT5B1gvVm6L9V1oxzaP0kBaclcZuAouR76qVuHs3cem4Gfn+6Lx0O0K2s51b6m7so
         IVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738713808; x=1739318608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mwe/Wt31zfGjltQoyH9VPBmv6gjaT8PZg5nxto4F+xs=;
        b=c6TAEoSOhPiWHYimfnrctLfU1UFohnS3SL8flGp6iVfxQXSWR/ubMSy0P2es90NSp/
         wVEVpExKDBw3j1zFLdrsxw/GOlni/CVSqk3pkB8fMZ8yWdZvicxAVb6b4sXccapVrDkq
         a2ec1ER34AOT33vggZdTgfIZkhTF585vqs5uwUZvG2carg7fuAgAloXSpNvRYZqrri5F
         eYIPRzmGNqVuEJ7rFHJeyV9/Vz0WC5f8YcFv4Z/LXfsK1AfnFH/RrfUeO19WQ2nXjWR/
         OQFAfCNIEdJ6oSLekkJu1DWh44z5GKBrwp9KhvtkucbR1Qpm2tO3NV8L0e+8RSEr6tT6
         EOYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnto+idu5AOB56W9QbjbaDhPxyvcPrkxguBmwPgrsWmi0De3PSbk7pUkEmDkROmbTdQ5BwxXmP5exkd4yi@vger.kernel.org
X-Gm-Message-State: AOJu0YzTRBPf4bg0rcHhmHKc3ooreFu6oPrnd3QELD7H/zlLhfpuftSn
	UfN2ViyGnhmNbi0OBliAZXHMTziEVUcFOHu68qgjI3rqVKPCPziWc8ID70aRBCI=
X-Gm-Gg: ASbGnctLKcGeKjYe4sGSf55lcxLRZsr3zpX9t8x5gYsFc+cTguA3VmH5Aesn1ebGwJ4
	NIMOSEA2s945Z+Zmh7ntDw1821OKXBf6Cx/bfnRQIdA2tgyUTRUCKZnrp7wm+9wslh5gWpB0LRg
	6oOI0OZ4Ya85iwzUKVAmQ8w42SrqBlZJc43Rds959VRUzLkKk4FviyXsDNVpMFyIVP5t1Ly1emW
	zUkH9PHVwAhVbPlew/8I778JXUDTxd2Z1zg+ZCvML4iEp4GsX4vjz438hJpahMgtsi9n9/MY29b
	rXsBMzCkIbLxbJrUSm+CRf0m80he1zH7
X-Google-Smtp-Source: AGHT+IG98kDtic+2XHpEl/g96Nv8uptV0EUsUG1kiyVydWgRNd330QjlALIk+EE7jcMLs9A/WPdTMA==
X-Received: by 2002:a05:6830:dc7:b0:71d:fa78:a5ee with SMTP id 46e09a7af769-726a416bf5dmr668735a34.11.1738713808481;
        Tue, 04 Feb 2025 16:03:28 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:d53:ebfc:fe83:43f5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726617eb64csm3666413a34.37.2025.02.04.16.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:03:27 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	dhowells@redhat.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [RFC PATCH 4/4] ceph: fix generic/421 test failure
Date: Tue,  4 Feb 2025 16:02:49 -0800
Message-ID: <20250205000249.123054-5-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205000249.123054-1-slava@dubeyko.com>
References: <20250205000249.123054-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The generic/421 fails to finish because of the issue:

Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.894678] INFO: task kworker/u48:0:11 blocked for more than 122 seconds.
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.895403] Not tainted 6.13.0-rc5+ #1
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.895867] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.896633] task:kworker/u48:0 state:D stack:0 pid:11 tgid:11 ppid:2 flags:0x00004000
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.896641] Workqueue: writeback wb_workfn (flush-ceph-24)
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897614] Call Trace:
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897620] <TASK>
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897629] __schedule+0x443/0x16b0
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897637] schedule+0x2b/0x140
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897640] io_schedule+0x4c/0x80
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897643] folio_wait_bit_common+0x11b/0x310
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897646] ? _raw_spin_unlock_irq+0xe/0x50
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897652] ? __pfx_wake_page_function+0x10/0x10
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897655] __folio_lock+0x17/0x30
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897658] ceph_writepages_start+0xca9/0x1fb0
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897663] ? fsnotify_remove_queued_event+0x2f/0x40
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897668] do_writepages+0xd2/0x240
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897672] __writeback_single_inode+0x44/0x350
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897675] writeback_sb_inodes+0x25c/0x550
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897680] wb_writeback+0x89/0x310
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897683] ? finish_task_switch.isra.0+0x97/0x310
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897687] wb_workfn+0xb5/0x410
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897689] process_one_work+0x188/0x3d0
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897692] worker_thread+0x2b5/0x3c0
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897694] ? __pfx_worker_thread+0x10/0x10
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897696] kthread+0xe1/0x120
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897699] ? __pfx_kthread+0x10/0x10
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897701] ret_from_fork+0x43/0x70
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897705] ? __pfx_kthread+0x10/0x10
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897707] ret_from_fork_asm+0x1a/0x30
Jan 3 14:25:27 ceph-testing-0001 kernel: [ 369.897711] </TASK>

There are several issues here:
(1) ceph_kill_sb() doesn't wait ending of flushing
all dirty folios/pages because of racy nature of
mdsc->stopping_blockers. As a result, mdsc->stopping
becomes CEPH_MDSC_STOPPING_FLUSHED too early.
(2) The ceph_inc_osd_stopping_blocker(fsc->mdsc) fails
to increment mdsc->stopping_blockers. Finally,
already locked folios/pages are never been unlocked
and the logic tries to lock the same page second time.
(3) The folio_batch with found dirty pages by
filemap_get_folios_tag() is not processed properly.
And this is why some number of dirty pages simply never
processed and we have dirty folios/pages after unmount
anyway.

This patch fixes the issues by means of:
(1) introducing dirty_folios counter and flush_end_wq
waiting queue in struct ceph_mds_client;
(2) ceph_dirty_folio() increments the dirty_folios
counter;
(3) writepages_finish() decrements the dirty_folios
counter and wake up all waiters on the queue
if dirty_folios counter is equal or lesser than zero;
(4) adding in ceph_kill_sb() method the logic of
checking the value of dirty_folios counter and
waiting if it is bigger than zero;
(5) adding ceph_inc_osd_stopping_blocker() call in the
beginning of the ceph_writepages_start() and
ceph_dec_osd_stopping_blocker() at the end of
the ceph_writepages_start() with the goal to resolve
the racy nature of mdsc->stopping_blockers.

sudo ./check generic/421
FSTYP         -- ceph
PLATFORM      -- Linux/x86_64 ceph-testing-0001 6.13.0+ #137 SMP PREEMPT_DYNAMIC Mon Feb  3 20:30:08 UTC 2025
MKFS_OPTIONS  -- 127.0.0.1:40551:/scratch
MOUNT_OPTIONS -- -o name=fs,secret=<secret>,ms_mode=crc,nowsync,copyfrom 127.0.0.1:40551:/scratch /mnt/scratch

generic/421 7s ...  4s
Ran: generic/421
Passed all 1 tests

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/addr.c       | 20 +++++++++++++++++++-
 fs/ceph/mds_client.c |  2 ++
 fs/ceph/mds_client.h |  3 +++
 fs/ceph/super.c      | 11 +++++++++++
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 02d20c000dc5..d82ce4867fca 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -82,6 +82,7 @@ static bool ceph_dirty_folio(struct address_space *mapping, struct folio *folio)
 {
 	struct inode *inode = mapping->host;
 	struct ceph_client *cl = ceph_inode_to_client(inode);
+	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct ceph_inode_info *ci;
 	struct ceph_snap_context *snapc;
 
@@ -92,6 +93,8 @@ static bool ceph_dirty_folio(struct address_space *mapping, struct folio *folio)
 		return false;
 	}
 
+	atomic64_inc(&mdsc->dirty_folios);
+
 	ci = ceph_inode(inode);
 
 	/* dirty the head */
@@ -894,6 +897,7 @@ static void writepages_finish(struct ceph_osd_request *req)
 	struct ceph_snap_context *snapc = req->r_snapc;
 	struct address_space *mapping = inode->i_mapping;
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	unsigned int len = 0;
 	bool remove_page;
 
@@ -949,6 +953,12 @@ static void writepages_finish(struct ceph_osd_request *req)
 
 			ceph_put_snap_context(detach_page_private(page));
 			end_page_writeback(page);
+
+			if (atomic64_dec_return(&mdsc->dirty_folios) <= 0) {
+				wake_up_all(&mdsc->flush_end_wq);
+				WARN_ON(atomic64_read(&mdsc->dirty_folios) < 0);
+			}
+
 			doutc(cl, "unlocking %p\n", page);
 
 			if (remove_page)
@@ -1660,13 +1670,18 @@ static int ceph_writepages_start(struct address_space *mapping,
 
 	ceph_init_writeback_ctl(mapping, wbc, &ceph_wbc);
 
+	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
+		rc = -EIO;
+		goto out;
+	}
+
 retry:
 	rc = ceph_define_writeback_range(mapping, wbc, &ceph_wbc);
 	if (rc == -ENODATA) {
 		/* hmm, why does writepages get called when there
 		   is no dirty data? */
 		rc = 0;
-		goto out;
+		goto dec_osd_stopping_blocker;
 	}
 
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
@@ -1756,6 +1771,9 @@ static int ceph_writepages_start(struct address_space *mapping,
 	if (wbc->range_cyclic || (ceph_wbc.range_whole && wbc->nr_to_write > 0))
 		mapping->writeback_index = ceph_wbc.index;
 
+dec_osd_stopping_blocker:
+	ceph_dec_osd_stopping_blocker(fsc->mdsc);
+
 out:
 	ceph_put_snap_context(ceph_wbc.last_snapc);
 	doutc(cl, "%llx.%llx dend - startone, rc = %d\n", ceph_vinop(inode),
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 54b3421501e9..230e0c3f341f 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -5489,6 +5489,8 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	spin_lock_init(&mdsc->stopping_lock);
 	atomic_set(&mdsc->stopping_blockers, 0);
 	init_completion(&mdsc->stopping_waiter);
+	atomic64_set(&mdsc->dirty_folios, 0);
+	init_waitqueue_head(&mdsc->flush_end_wq);
 	init_waitqueue_head(&mdsc->session_close_wq);
 	INIT_LIST_HEAD(&mdsc->waiting_for_map);
 	mdsc->quotarealms_inodes = RB_ROOT;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 7c9fee9e80d4..3e2a6fa7c19a 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -458,6 +458,9 @@ struct ceph_mds_client {
 	atomic_t                stopping_blockers;
 	struct completion	stopping_waiter;
 
+	atomic64_t		dirty_folios;
+	wait_queue_head_t	flush_end_wq;
+
 	atomic64_t		quotarealms_count; /* # realms with quota */
 	/*
 	 * We keep a list of inodes we don't see in the mountpoint but that we
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 4344e1f11806..f3951253e393 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1563,6 +1563,17 @@ static void ceph_kill_sb(struct super_block *s)
 	 */
 	sync_filesystem(s);
 
+	if (atomic64_read(&mdsc->dirty_folios) > 0) {
+		wait_queue_head_t *wq = &mdsc->flush_end_wq;
+		long timeleft = wait_event_killable_timeout(*wq,
+					atomic64_read(&mdsc->dirty_folios) <= 0,
+					fsc->client->options->mount_timeout);
+		if (!timeleft) /* timed out */
+			pr_warn_client(cl, "umount timed out, %ld\n", timeleft);
+		else if (timeleft < 0) /* killed */
+			pr_warn_client(cl, "umount was killed, %ld\n", timeleft);
+	}
+
 	spin_lock(&mdsc->stopping_lock);
 	mdsc->stopping = CEPH_MDSC_STOPPING_FLUSHING;
 	wait = !!atomic_read(&mdsc->stopping_blockers);
-- 
2.48.0


