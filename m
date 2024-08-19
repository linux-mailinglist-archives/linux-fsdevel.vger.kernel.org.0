Return-Path: <linux-fsdevel+bounces-26229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535D9956355
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 07:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0A4280BE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 05:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F30C158A09;
	Mon, 19 Aug 2024 05:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cyW+ylun";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ecqubo8w";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jstv69pC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gFd3u0A4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB0158557;
	Mon, 19 Aug 2024 05:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724045894; cv=none; b=iWJBqaTJuHagtcdrFIbfONjPy77lFTwDe9uFgT2/OpqhDIa536OD/V/YZQ7HN6NJndSZgeYbi0VyMDfyR7+eQ4hDA3UW+NrzMVJI1otX9vW9K5A0m8aEADIRIfMUVUTkajR6BaBEG8n3FAv2RpexJKSUmK0KSOrt7NVh1yDLjo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724045894; c=relaxed/simple;
	bh=Mkn51CfIQxQAKGu3tWe2cTGbMVHsAG703b8hYQaH/Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzHK9M5IazrC/fJt9iISt2Rtdyzf23pPjfLTnWuheJOrXezNn23/nHMUKcQPnMiRSTkjQTpetr5+jVQkyz5l3Z8wjLic3vHWhFgr7lcExzvCRo7ci8UIsYeewWvqJ50FUXdNIV6bNL8Xl6XYzJv/knHs6rMOxme9OV7rQGq2akU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cyW+ylun; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ecqubo8w; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jstv69pC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gFd3u0A4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B23AF1FE4D;
	Mon, 19 Aug 2024 05:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724045889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1sSa9sFcPG9BRViQCBnAEG724foW8s0r30NOms/fu8=;
	b=cyW+ylunNJqGRvXRA/8/ngg2tdb/Mf7z02lswseip4du4f/M5JoSc8AW2AW+RcVWDBHEJT
	/03/fsLcLD2NeNRkLQ1Jkk1MIrtLeXaks0gFur6PTaVLChkdahfw75a0Bpb5Q1ElRC9Bcg
	sMbPoxwHfu8lJFA6iQEcTr3ePF8ZT7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724045889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1sSa9sFcPG9BRViQCBnAEG724foW8s0r30NOms/fu8=;
	b=Ecqubo8w8uWuZ8hu2wDtjSZ594vD55+9FiOO2k0t6ixmlUI3q3l4TK+3J0Fo37xeZEsI8e
	HdozKeMifi7IeLAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Jstv69pC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gFd3u0A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724045888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1sSa9sFcPG9BRViQCBnAEG724foW8s0r30NOms/fu8=;
	b=Jstv69pCOEFiNd1rzBcNcZ/joRBZt63I5oY5nS2V+grzQH8SFDef0EFxBb9LZ7YDEUoqXA
	ocuUZwjxNSrnjYF8V+02bfobfpWqQmXvadKhk1VMOxAhvdrbl1rz/U7HBmFPAeVe4c6NIZ
	3CMJSlC6RIW6cuA6cEqhfWrPHW1zRCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724045888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1sSa9sFcPG9BRViQCBnAEG724foW8s0r30NOms/fu8=;
	b=gFd3u0A4EJb7umTGSmtcBCicUX6ycb/WdZPGYa5KiS+xvVlAifkZ2YB6ffakjoPIDkmgDI
	1VRdQ4vw4SiwhZDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9568E1397F;
	Mon, 19 Aug 2024 05:38:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uqaqEj7awmY3YgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 19 Aug 2024 05:38:06 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 9/9] Use clear_and_wake_up_bit() where appropriate.
Date: Mon, 19 Aug 2024 15:20:43 +1000
Message-ID: <20240819053605.11706-10-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240819053605.11706-1-neilb@suse.de>
References: <20240819053605.11706-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B23AF1FE4D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -5.01

clear_and_wake_up_bit() contains 2 memory barriers - one before the bit
is cleared so that changes implied by the cleared bit are visible, and
another before the the lockless waitqueue_active() test in
wake_up_bit(), to ensure the cleared bit is visible in a waiter
immediately after a waiter is added to the waitqueue.

This function is open-coded in many places, some of which omit one or
both of the barriers.

For consistency, this patch changes all reasonable candidates to use
clear_and_wake_up_bit() directly.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/bluetooth/hci_mrvl.c                |  6 ++----
 drivers/md/dm-bufio.c                       |  8 ++------
 drivers/md/dm-snap.c                        |  3 +--
 drivers/md/dm-zoned-metadata.c              |  6 ++----
 drivers/md/dm-zoned-reclaim.c               |  3 +--
 drivers/md/dm.c                             |  3 +--
 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c | 12 ++++--------
 fs/afs/server.c                             |  3 +--
 fs/afs/vl_probe.c                           |  3 +--
 fs/afs/volume.c                             |  3 +--
 fs/bcachefs/buckets.h                       |  3 +--
 fs/btrfs/extent_io.c                        |  6 ++----
 fs/buffer.c                                 |  3 +--
 fs/gfs2/glock.c                             |  6 ++----
 fs/gfs2/glops.c                             |  6 ++----
 fs/gfs2/lock_dlm.c                          |  6 ++----
 fs/gfs2/recovery.c                          |  3 +--
 fs/gfs2/sys.c                               |  3 +--
 fs/gfs2/util.c                              |  3 +--
 fs/jbd2/commit.c                            |  6 ++----
 fs/netfs/fscache_volume.c                   |  3 +--
 fs/netfs/io.c                               |  3 +--
 fs/netfs/write_collect.c                    |  9 +++------
 fs/nfs/inode.c                              |  3 +--
 fs/nfs/pnfs.c                               |  6 ++----
 fs/nfsd/nfs4recover.c                       |  4 +---
 fs/nfsd/nfs4state.c                         |  3 +--
 fs/orangefs/file.c                          |  3 +--
 fs/smb/client/connect.c                     |  3 +--
 fs/smb/client/inode.c                       |  3 +--
 fs/smb/client/misc.c                        | 14 ++++++--------
 fs/smb/server/oplock.c                      |  3 +--
 net/bluetooth/hci_event.c                   |  3 +--
 security/keys/gc.c                          |  3 +--
 34 files changed, 53 insertions(+), 105 deletions(-)

diff --git a/drivers/bluetooth/hci_mrvl.c b/drivers/bluetooth/hci_mrvl.c
index 5486cf78a99b..130bfe8f86d2 100644
--- a/drivers/bluetooth/hci_mrvl.c
+++ b/drivers/bluetooth/hci_mrvl.c
@@ -183,8 +183,7 @@ static int mrvl_recv_fw_req(struct hci_dev *hdev, struct sk_buff *skb)
 
 	mrvl->tx_len = le16_to_cpu(pkt->lhs);
 
-	clear_bit(STATE_FW_REQ_PENDING, &mrvl->flags);
-	wake_up_bit(&mrvl->flags, STATE_FW_REQ_PENDING);
+	clear_and_wake_up_bit(STATE_FW_REQ_PENDING, &mrvl->flags);
 
 done:
 	kfree_skb(skb);
@@ -217,8 +216,7 @@ static int mrvl_recv_chip_ver(struct hci_dev *hdev, struct sk_buff *skb)
 
 	bt_dev_info(hdev, "Controller id = %x, rev = %x", mrvl->id, mrvl->rev);
 
-	clear_bit(STATE_CHIP_VER_PENDING, &mrvl->flags);
-	wake_up_bit(&mrvl->flags, STATE_CHIP_VER_PENDING);
+	clear_and_wake_up_bit(STATE_CHIP_VER_PENDING, &mrvl->flags);
 
 done:
 	kfree_skb(skb);
diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 14b4d7cabbd6..45696f9e814a 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1430,9 +1430,7 @@ static void write_endio(struct dm_buffer *b, blk_status_t status)
 
 	BUG_ON(!test_bit(B_WRITING, &b->state));
 
-	smp_mb__before_atomic();
-	clear_bit(B_WRITING, &b->state);
-	wake_up_bit(&b->state, B_WRITING);
+	clear_and_wake_up_bit(B_WRITING, &b->state);
 }
 
 /*
@@ -1839,9 +1837,7 @@ static void read_endio(struct dm_buffer *b, blk_status_t status)
 
 	BUG_ON(!test_bit(B_READING, &b->state));
 
-	smp_mb__before_atomic();
-	clear_bit(B_READING, &b->state);
-	wake_up_bit(&b->state, B_READING);
+	clear_and_wake_up_bit(B_READING, &b->state);
 }
 
 /*
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 1549ab975021..4be3426a79ed 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -920,8 +920,7 @@ static int init_hash_tables(struct dm_snapshot *s)
 
 static void merge_shutdown(struct dm_snapshot *s)
 {
-	clear_bit_unlock(RUNNING_MERGE, &s->state_bits);
-	wake_up_bit(&s->state_bits, RUNNING_MERGE);
+	clear_and_wake_up_bit(RUNNING_MERGE, &s->state_bits);
 }
 
 static struct bio *__release_queued_bios_after_merge(struct dm_snapshot *s)
diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index 7ea225ce418f..61df3079899a 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -524,8 +524,7 @@ static void dmz_mblock_bio_end_io(struct bio *bio)
 	else
 		flag = DMZ_META_READING;
 
-	clear_bit_unlock(flag, &mblk->state);
-	wake_up_bit(&mblk->state, flag);
+	clear_and_wake_up_bit(flag, &mblk->state);
 
 	bio_put(bio);
 }
@@ -1915,8 +1914,7 @@ void dmz_unlock_zone_reclaim(struct dm_zone *zone)
 	WARN_ON(dmz_is_active(zone));
 	WARN_ON(!dmz_in_reclaim(zone));
 
-	clear_bit_unlock(DMZ_RECLAIM, &zone->flags);
-	wake_up_bit(&zone->flags, DMZ_RECLAIM);
+	clear_and_wake_up_bit(DMZ_RECLAIM, &zone->flags);
 }
 
 /*
diff --git a/drivers/md/dm-zoned-reclaim.c b/drivers/md/dm-zoned-reclaim.c
index 9a7dadbb8eb7..12b9606357ec 100644
--- a/drivers/md/dm-zoned-reclaim.c
+++ b/drivers/md/dm-zoned-reclaim.c
@@ -106,8 +106,7 @@ static void dmz_reclaim_kcopy_end(int read_err, unsigned long write_err,
 	else
 		zrc->kc_err = 0;
 
-	clear_bit_unlock(DMZ_RECLAIM_KCOPY, &zrc->flags);
-	wake_up_bit(&zrc->flags, DMZ_RECLAIM_KCOPY);
+	clear_and_wake_up_bit(DMZ_RECLAIM_KCOPY, &zrc->flags);
 }
 
 /*
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 3fd19d478f62..f453e6d78971 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -3153,8 +3153,7 @@ static void __dm_internal_resume(struct mapped_device *md)
 		set_bit(DMF_SUSPENDED, &md->flags);
 	}
 done:
-	clear_bit(DMF_SUSPENDED_INTERNALLY, &md->flags);
-	wake_up_bit(&md->flags, DMF_SUSPENDED_INTERNALLY);
+	clear_and_wake_up_bit(DMF_SUSPENDED_INTERNALLY, &md->flags);
 }
 
 void dm_internal_suspend_noflush(struct mapped_device *md)
diff --git a/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c b/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
index 7df6b0791ebd..4f9347ec0f43 100644
--- a/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
+++ b/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
@@ -375,8 +375,7 @@ static int dvb_usb_stop_feed(struct dvb_demux_feed *dvbdmxfeed)
 	usb_urb_killv2(&adap->stream);
 
 	/* clear 'streaming' status bit */
-	clear_bit(ADAP_STREAMING, &adap->state_bits);
-	wake_up_bit(&adap->state_bits, ADAP_STREAMING);
+	clear_and_wake_up_bit(ADAP_STREAMING, &adap->state_bits);
 skip_feed_stop:
 
 	if (ret)
@@ -578,10 +577,8 @@ static int dvb_usb_fe_init(struct dvb_frontend *fe)
 			goto err;
 	}
 err:
-	if (!adap->suspend_resume_active) {
-		clear_bit(ADAP_INIT, &adap->state_bits);
-		wake_up_bit(&adap->state_bits, ADAP_INIT);
-	}
+	if (!adap->suspend_resume_active)
+		clear_and_wake_up_bit(ADAP_INIT, &adap->state_bits);
 
 	dev_dbg(&d->udev->dev, "%s: ret=%d\n", __func__, ret);
 	return ret;
@@ -618,8 +615,7 @@ static int dvb_usb_fe_sleep(struct dvb_frontend *fe)
 err:
 	if (!adap->suspend_resume_active) {
 		adap->active_fe = -1;
-		clear_bit(ADAP_SLEEP, &adap->state_bits);
-		wake_up_bit(&adap->state_bits, ADAP_SLEEP);
+		clear_and_wake_up_bit(ADAP_SLEEP, &adap->state_bits);
 	}
 
 	dev_dbg(&d->udev->dev, "%s: ret=%d\n", __func__, ret);
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 038f9d0ae3af..8dc3c60f8f81 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -688,8 +688,7 @@ bool afs_check_server_record(struct afs_operation *op, struct afs_server *server
 	if (!test_and_set_bit_lock(AFS_SERVER_FL_UPDATING, &server->flags)) {
 		clear_bit(AFS_SERVER_FL_NEEDS_UPDATE, &server->flags);
 		success = afs_update_server_record(op, server, key);
-		clear_bit_unlock(AFS_SERVER_FL_UPDATING, &server->flags);
-		wake_up_bit(&server->flags, AFS_SERVER_FL_UPDATING);
+		clear_and_wake_up_bit(AFS_SERVER_FL_UPDATING, &server->flags);
 		_leave(" = %d", success);
 		return success;
 	}
diff --git a/fs/afs/vl_probe.c b/fs/afs/vl_probe.c
index 3d2e0c925460..9850e028c44b 100644
--- a/fs/afs/vl_probe.c
+++ b/fs/afs/vl_probe.c
@@ -22,8 +22,7 @@ static void afs_finished_vl_probe(struct afs_vlserver *server)
 		clear_bit(AFS_VLSERVER_FL_RESPONDING, &server->flags);
 	}
 
-	clear_bit_unlock(AFS_VLSERVER_FL_PROBING, &server->flags);
-	wake_up_bit(&server->flags, AFS_VLSERVER_FL_PROBING);
+	clear_and_wake_up_bit(AFS_VLSERVER_FL_PROBING, &server->flags);
 }
 
 /*
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index af3a3f57c1b3..601b425cf093 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -439,9 +439,8 @@ int afs_check_volume_status(struct afs_volume *volume, struct afs_operation *op)
 		ret = afs_update_volume_status(volume, op->key);
 		if (ret < 0)
 			set_bit(AFS_VOLUME_NEEDS_UPDATE, &volume->flags);
-		clear_bit_unlock(AFS_VOLUME_WAIT, &volume->flags);
 		clear_bit_unlock(AFS_VOLUME_UPDATING, &volume->flags);
-		wake_up_bit(&volume->flags, AFS_VOLUME_WAIT);
+		clear_and_wake_up_bit(AFS_VOLUME_WAIT, &volume->flags);
 		_leave(" = %d", ret);
 		return ret;
 	}
diff --git a/fs/bcachefs/buckets.h b/fs/bcachefs/buckets.h
index edbdffd508fc..5c7cfee3707b 100644
--- a/fs/bcachefs/buckets.h
+++ b/fs/bcachefs/buckets.h
@@ -70,8 +70,7 @@ static inline void bucket_unlock(struct bucket *b)
 {
 	BUILD_BUG_ON(!((union ulong_byte_assert) { .ulong = 1UL << BUCKET_LOCK_BITNR }).byte);
 
-	clear_bit_unlock(BUCKET_LOCK_BITNR, (void *) &b->lock);
-	wake_up_bit((void *) &b->lock, BUCKET_LOCK_BITNR);
+	clear_and_wake_up_bit(BUCKET_LOCK_BITNR, (void *) &b->lock);
 }
 
 static inline void bucket_lock(struct bucket *b)
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0b9cb4c87adf..ab70f92f41bf 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1761,8 +1761,7 @@ static void end_bbio_meta_write(struct btrfs_bio *bbio)
 		bio_offset += len;
 	}
 
-	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
-	wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
+	clear_and_wake_up_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
 
 	bio_put(&bbio->bio);
 }
@@ -3504,8 +3503,7 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 
 static void clear_extent_buffer_reading(struct extent_buffer *eb)
 {
-	clear_bit(EXTENT_BUFFER_READING, &eb->bflags);
-	wake_up_bit(&eb->bflags, EXTENT_BUFFER_READING);
+	clear_and_wake_up_bit(EXTENT_BUFFER_READING, &eb->bflags);
 }
 
 static void end_bbio_meta_read(struct btrfs_bio *bbio)
diff --git a/fs/buffer.c b/fs/buffer.c
index 2932618c88e4..2b55fad8bfc9 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -74,8 +74,7 @@ EXPORT_SYMBOL(__lock_buffer);
 
 void unlock_buffer(struct buffer_head *bh)
 {
-	clear_bit_unlock(BH_Lock, &bh->b_state);
-	wake_up_bit(&bh->b_state, BH_Lock);
+	clear_and_wake_up_bit(BH_Lock, &bh->b_state);
 }
 EXPORT_SYMBOL(unlock_buffer);
 
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index e1afe9aa7c2a..6b310a02c66d 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -379,8 +379,7 @@ static inline bool may_grant(struct gfs2_glock *gl,
 
 static void gfs2_holder_wake(struct gfs2_holder *gh)
 {
-	clear_bit(HIF_WAIT, &gh->gh_iflags);
-	wake_up_bit(&gh->gh_iflags, HIF_WAIT);
+	clear_and_wake_up_bit(HIF_WAIT, &gh->gh_iflags);
 	if (gh->gh_flags & GL_ASYNC) {
 		struct gfs2_sbd *sdp = gh->gh_gl->gl_name.ln_sbd;
 
@@ -574,8 +573,7 @@ static void gfs2_set_demote(struct gfs2_glock *gl)
 static void gfs2_demote_wake(struct gfs2_glock *gl)
 {
 	gl->gl_demote_state = LM_ST_EXCLUSIVE;
-	clear_bit(GLF_DEMOTE, &gl->gl_flags);
-	wake_up_bit(&gl->gl_flags, GLF_DEMOTE);
+	clear_and_wake_up_bit(GLF_DEMOTE, &gl->gl_flags);
 }
 
 /**
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 95d8081681dc..2c8bc1dce8d1 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -276,8 +276,7 @@ static void gfs2_clear_glop_pending(struct gfs2_inode *ip)
 	if (!ip)
 		return;
 
-	clear_bit_unlock(GIF_GLOP_PENDING, &ip->i_flags);
-	wake_up_bit(&ip->i_flags, GIF_GLOP_PENDING);
+	clear_and_wake_up_bit(GIF_GLOP_PENDING, &ip->i_flags);
 }
 
 /**
@@ -644,8 +643,7 @@ static void inode_go_unlocked(struct gfs2_glock *gl)
 	 * to NULL by this point in its lifecycle. */
 	if (!test_bit(GLF_UNLOCKED, &gl->gl_flags))
 		return;
-	clear_bit_unlock(GLF_UNLOCKED, &gl->gl_flags);
-	wake_up_bit(&gl->gl_flags, GLF_UNLOCKED);
+	clear_and_wake_up_bit(GLF_UNLOCKED, &gl->gl_flags);
 }
 
 /**
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 921b26b96192..d5ac3751f66d 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -1223,8 +1223,7 @@ static void gdlm_recover_done(void *arg, struct dlm_slot *slots, int num_slots,
 	if (!test_bit(DFL_UNMOUNT, &ls->ls_recover_flags))
 		queue_delayed_work(gfs2_control_wq, &sdp->sd_control_work, 0);
 
-	clear_bit(DFL_DLM_RECOVERY, &ls->ls_recover_flags);
-	wake_up_bit(&ls->ls_recover_flags, DFL_DLM_RECOVERY);
+	clear_and_wake_up_bit(DFL_DLM_RECOVERY, &ls->ls_recover_flags);
 	spin_unlock(&ls->ls_recover_spin);
 }
 
@@ -1364,8 +1363,7 @@ static int gdlm_mount(struct gfs2_sbd *sdp, const char *table)
 	}
 
 	ls->ls_first = !!test_bit(DFL_FIRST_MOUNT, &ls->ls_recover_flags);
-	clear_bit(SDF_NOJOURNALID, &sdp->sd_flags);
-	wake_up_bit(&sdp->sd_flags, SDF_NOJOURNALID);
+	clear_and_wake_up_bit(SDF_NOJOURNALID, &sdp->sd_flags);
 	return 0;
 
 fail_release:
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index e70cf003d524..c162d46903ae 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -557,8 +557,7 @@ void gfs2_recover_func(struct work_struct *work)
 	jd->jd_recover_error = error;
 	gfs2_recovery_done(sdp, jd->jd_jid, LM_RD_GAVEUP);
 done:
-	clear_bit(JDF_RECOVERY, &jd->jd_flags);
-	wake_up_bit(&jd->jd_flags, JDF_RECOVERY);
+	clear_and_wake_up_bit(JDF_RECOVERY, &jd->jd_flags);
 }
 
 int gfs2_recover_journal(struct gfs2_jdesc *jd, bool wait)
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index 738337e35724..0c998c92cb6d 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -586,8 +586,7 @@ static ssize_t jid_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 	if (sdp->sd_args.ar_spectator && jid > 0)
 		rv = jid = -EINVAL;
 	sdp->sd_lockstruct.ls_jid = jid;
-	clear_bit(SDF_NOJOURNALID, &sdp->sd_flags);
-	wake_up_bit(&sdp->sd_flags, SDF_NOJOURNALID);
+	clear_and_wake_up_bit(SDF_NOJOURNALID, &sdp->sd_flags);
 out:
 	spin_unlock(&sdp->sd_jindex_spin);
 	return rv ? rv : len;
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 2818f3891498..111aba955084 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -352,8 +352,7 @@ int gfs2_withdraw(struct gfs2_sbd *sdp)
 		}
 		fs_err(sdp, "File system withdrawn\n");
 		dump_stack();
-		clear_bit(SDF_WITHDRAW_IN_PROG, &sdp->sd_flags);
-		wake_up_bit(&sdp->sd_flags, SDF_WITHDRAW_IN_PROG);
+		clear_and_wake_up_bit(SDF_WITHDRAW_IN_PROG, &sdp->sd_flags);
 	}
 
 	if (sdp->sd_args.ar_errors == GFS2_ERRORS_PANIC)
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 55ba3f62fbe3..f4bf090b59e9 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -38,10 +38,8 @@ static void journal_end_buffer_io_sync(struct buffer_head *bh, int uptodate)
 		set_buffer_uptodate(bh);
 	else
 		clear_buffer_uptodate(bh);
-	if (orig_bh) {
-		clear_bit_unlock(BH_Shadow, &orig_bh->b_state);
-		wake_up_bit(&orig_bh->b_state, BH_Shadow);
-	}
+	if (orig_bh)
+		clear_and_wake_up_bit(BH_Shadow, &orig_bh->b_state);
 	unlock_buffer(bh);
 }
 
diff --git a/fs/netfs/fscache_volume.c b/fs/netfs/fscache_volume.c
index c6c43a87f56e..7b8aacf48172 100644
--- a/fs/netfs/fscache_volume.c
+++ b/fs/netfs/fscache_volume.c
@@ -322,8 +322,7 @@ void fscache_create_volume(struct fscache_volume *volume, bool wait)
 	}
 	return;
 no_wait:
-	clear_bit_unlock(FSCACHE_VOLUME_CREATING, &volume->flags);
-	wake_up_bit(&volume->flags, FSCACHE_VOLUME_CREATING);
+	clear_and_wake_up_bit(FSCACHE_VOLUME_CREATING, &volume->flags);
 }
 
 /*
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index ebae3cfcad20..4782ffd75fa5 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -272,8 +272,7 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
 		netfs_rreq_assess_dio(rreq);
 
 	trace_netfs_rreq(rreq, netfs_rreq_trace_wake_ip);
-	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
-	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
+	clear_and_wake_up_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 
 	netfs_rreq_completed(rreq, was_async);
 }
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 426cf87aaf2e..2b8c2c8d802a 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -582,8 +582,7 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 		goto need_retry;
 	if ((notes & MADE_PROGRESS) && test_bit(NETFS_RREQ_PAUSE, &wreq->flags)) {
 		trace_netfs_rreq(wreq, netfs_rreq_trace_unpause);
-		clear_bit_unlock(NETFS_RREQ_PAUSE, &wreq->flags);
-		wake_up_bit(&wreq->flags, NETFS_RREQ_PAUSE);
+		clear_and_wake_up_bit(NETFS_RREQ_PAUSE, &wreq->flags);
 	}
 
 	if (notes & NEED_REASSESS) {
@@ -686,8 +685,7 @@ void netfs_write_collection_worker(struct work_struct *work)
 
 	_debug("finished");
 	trace_netfs_rreq(wreq, netfs_rreq_trace_wake_ip);
-	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &wreq->flags);
-	wake_up_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS);
+	clear_and_wake_up_bit(NETFS_RREQ_IN_PROGRESS, &wreq->flags);
 
 	if (wreq->iocb) {
 		size_t written = min(wreq->transferred, wreq->len);
@@ -795,8 +793,7 @@ void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error,
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
 
-	clear_bit_unlock(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
-	wake_up_bit(&subreq->flags, NETFS_SREQ_IN_PROGRESS);
+	clear_and_wake_up_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 
 	/* If we are at the head of the queue, wake up the collector,
 	 * transferring a ref to it if we were the ones to do so.
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 19d175446899..34b9e5366983 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1428,8 +1428,7 @@ int nfs_clear_invalid_mapping(struct address_space *mapping)
 	ret = nfs_invalidate_mapping(inode, mapping);
 	trace_nfs_invalidate_mapping_exit(inode, ret);
 
-	clear_bit_unlock(NFS_INO_INVALIDATING, bitlock);
-	wake_up_bit(bitlock, NFS_INO_INVALIDATING);
+	clear_and_wake_up_bit(NFS_INO_INVALIDATING, bitlock);
 out:
 	return ret;
 }
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 877fc154eb2b..4254de655d5e 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2055,8 +2055,7 @@ static void pnfs_clear_first_layoutget(struct pnfs_layout_hdr *lo)
 {
 	unsigned long *bitlock = &lo->plh_flags;
 
-	clear_bit_unlock(NFS_LAYOUT_FIRST_LAYOUTGET, bitlock);
-	wake_up_bit(bitlock, NFS_LAYOUT_FIRST_LAYOUTGET);
+	clear_and_wake_up_bit(NFS_LAYOUT_FIRST_LAYOUTGET, bitlock);
 }
 
 static void _add_to_server_list(struct pnfs_layout_hdr *lo,
@@ -3227,8 +3226,7 @@ static void pnfs_clear_layoutcommitting(struct inode *inode)
 {
 	unsigned long *bitlock = &NFS_I(inode)->flags;
 
-	clear_bit_unlock(NFS_INO_LAYOUTCOMMITTING, bitlock);
-	wake_up_bit(bitlock, NFS_INO_LAYOUTCOMMITTING);
+	clear_and_wake_up_bit(NFS_INO_LAYOUTCOMMITTING, bitlock);
 }
 
 /*
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 3e1a434bc649..0d25ad5eeae3 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -1895,9 +1895,7 @@ nfsd4_cltrack_upcall_lock(struct nfs4_client *clp)
 static void
 nfsd4_cltrack_upcall_unlock(struct nfs4_client *clp)
 {
-	smp_mb__before_atomic();
-	clear_bit(NFSD4_CLIENT_UPCALL_LOCK, &clp->cl_flags);
-	wake_up_bit(&clp->cl_flags, NFSD4_CLIENT_UPCALL_LOCK);
+	clear_and_wake_up_bit(NFSD4_CLIENT_UPCALL_LOCK, &clp->cl_flags);
 }
 
 static void
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d156ac7637cf..bd948cca34b6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3076,8 +3076,7 @@ nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
 			container_of(ncf, struct nfs4_delegation, dl_cb_fattr);
 
 	nfs4_put_stid(&dp->dl_stid);
-	clear_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags);
-	wake_up_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY);
+	clear_and_wake_up_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags);
 }
 
 static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index d620b56a1002..c03bd14c1bc7 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -313,8 +313,7 @@ int orangefs_revalidate_mapping(struct inode *inode)
 	orangefs_inode->mapping_time = jiffies +
 	    orangefs_cache_timeout_msecs*HZ/1000;
 
-	clear_bit(1, bitlock);
-	wake_up_bit(bitlock, 1);
+	clear_and_wake_up_bit(1, bitlock);
 
 	return ret;
 }
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index d2307162a2de..ff30d11f8e45 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -4257,8 +4257,7 @@ cifs_sb_tlink(struct cifs_sb_info *cifs_sb)
 	}
 
 	tlink->tl_tcon = cifs_construct_tcon(cifs_sb, fsuid);
-	clear_bit(TCON_LINK_PENDING, &tlink->tl_flags);
-	wake_up_bit(&tlink->tl_flags, TCON_LINK_PENDING);
+	clear_and_wake_up_bit(TCON_LINK_PENDING, &tlink->tl_flags);
 
 	if (IS_ERR(tlink->tl_tcon)) {
 		cifs_put_tlink(tlink);
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 8da74f15cc95..fd0e3d1e49cb 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2510,8 +2510,7 @@ cifs_revalidate_mapping(struct inode *inode)
 	}
 
 skip_invalidate:
-	clear_bit_unlock(CIFS_INO_LOCK, flags);
-	wake_up_bit(flags, CIFS_INO_LOCK);
+	clear_and_wake_up_bit(CIFS_INO_LOCK, flags);
 
 	return rc;
 }
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index c6f11e6f9eb9..455d50102d93 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -594,8 +594,8 @@ int cifs_get_writer(struct cifsInodeInfo *cinode)
 	if (test_bit(CIFS_INODE_PENDING_OPLOCK_BREAK, &cinode->flags)) {
 		cinode->writers--;
 		if (cinode->writers == 0) {
-			clear_bit(CIFS_INODE_PENDING_WRITERS, &cinode->flags);
-			wake_up_bit(&cinode->flags, CIFS_INODE_PENDING_WRITERS);
+			clear_and_wake_up_bit(CIFS_INODE_PENDING_WRITERS,
+					      &cinode->flags);
 		}
 		spin_unlock(&cinode->writers_lock);
 		goto start;
@@ -608,10 +608,9 @@ void cifs_put_writer(struct cifsInodeInfo *cinode)
 {
 	spin_lock(&cinode->writers_lock);
 	cinode->writers--;
-	if (cinode->writers == 0) {
-		clear_bit(CIFS_INODE_PENDING_WRITERS, &cinode->flags);
-		wake_up_bit(&cinode->flags, CIFS_INODE_PENDING_WRITERS);
-	}
+	if (cinode->writers == 0)
+		clear_and_wake_up_bit(CIFS_INODE_PENDING_WRITERS,
+				      &cinode->flags);
 	spin_unlock(&cinode->writers_lock);
 }
 
@@ -640,8 +639,7 @@ void cifs_queue_oplock_break(struct cifsFileInfo *cfile)
 
 void cifs_done_oplock_break(struct cifsInodeInfo *cinode)
 {
-	clear_bit(CIFS_INODE_PENDING_OPLOCK_BREAK, &cinode->flags);
-	wake_up_bit(&cinode->flags, CIFS_INODE_PENDING_OPLOCK_BREAK);
+	clear_and_wake_up_bit(CIFS_INODE_PENDING_OPLOCK_BREAK, &cinode->flags);
 }
 
 bool
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index b039b242df46..40adc1d42f96 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -593,8 +593,7 @@ static void wait_for_break_ack(struct oplock_info *opinfo)
 
 static void wake_up_oplock_break(struct oplock_info *opinfo)
 {
-	clear_bit_unlock(0, &opinfo->pending_break);
-	wake_up_bit(&opinfo->pending_break, 0);
+	clear_and_wake_up_bit(0, &opinfo->pending_break);
 }
 
 static int oplock_break_pending(struct oplock_info *opinfo, int req_op_level)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 226b37017d56..91f65d9ac82f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -104,8 +104,7 @@ static u8 hci_cc_inquiry_cancel(struct hci_dev *hdev, void *data,
 	if (rp->status)
 		return rp->status;
 
-	clear_bit(HCI_INQUIRY, &hdev->flags);
-	wake_up_bit(&hdev->flags, HCI_INQUIRY);
+	clear_and_wake_up_bit(HCI_INQUIRY, &hdev->flags);
 
 	hci_dev_lock(hdev);
 	/* Set discovery state to stopped if we're not doing LE active
diff --git a/security/keys/gc.c b/security/keys/gc.c
index 7d687b0962b1..0033f8546fa9 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -317,8 +317,7 @@ static void key_garbage_collector(struct work_struct *work)
 	if (unlikely(gc_state & KEY_GC_REAPING_DEAD_3)) {
 		kdebug("dead wake");
 		smp_mb();
-		clear_bit(KEY_GC_REAPING_KEYTYPE, &key_gc_flags);
-		wake_up_bit(&key_gc_flags, KEY_GC_REAPING_KEYTYPE);
+		clear_and_wake_up_bit(KEY_GC_REAPING_KEYTYPE, &key_gc_flags);
 	}
 
 	if (gc_state & KEY_GC_REAP_AGAIN)
-- 
2.44.0


