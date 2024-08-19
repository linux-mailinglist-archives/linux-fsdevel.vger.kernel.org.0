Return-Path: <linux-fsdevel+bounces-26227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3634095634D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 07:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88A54B209D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 05:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA08314C592;
	Mon, 19 Aug 2024 05:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yIaVhTVt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TF1mk5dp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yIaVhTVt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TF1mk5dp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB2D1581EE;
	Mon, 19 Aug 2024 05:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724045870; cv=none; b=aHLrsxwcKGj4wjfrC9sa0jFRBhIzhOo2VPkc+GTMq9U9alVxiycxT+Yip4npPIzR2Lrrtk+o8sXsO87IS3FuxfZgp9XBee+59bFtU+3aUfZ21QdMCFFnHZdn96ej2NqLJo74mQl/BflGAuvsACGe2oA3hR+BD01AMbbn2UjZTH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724045870; c=relaxed/simple;
	bh=Is4wxIOpBSRra7CUQRveDThrHZPsTHBKvd7gFVIuZyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qs14Z5kUD7WtjUF47xQCwacxhkMczeqYrFnZyr7UH/9iXLJLHS76VHC/TYR5BeQwDdvD0eab8pLxiT6Y+SB0Dm/mrmgpiMxfi0gCvaQzhCHpTDYe9YmWYkd9XPt/CwBnblCbDnqvhL/C/ZP6xE3bTefVfGGuVTcjhyVW8hE9SrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yIaVhTVt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TF1mk5dp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yIaVhTVt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TF1mk5dp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 549D71FE4D;
	Mon, 19 Aug 2024 05:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724045865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hEDckMyDAZKdlR6hnBly1GqRipWwWuQ5aYQzNdMiy4=;
	b=yIaVhTVt5n0qxTc3rdAaeSKqpTi2BijMTS+QERfbpkrnV5rW0yCLhXyK8yTVca3JPACyvk
	ki/lQqJz7ysvDj2zSknUWag7XQ88/xwyIg/hPpiz1+Yq6/s4gQY4QK0uFEzdLCLvZqY+w2
	asZxBLpvWegQqEAxk5aQO9EgHehSis4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724045865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hEDckMyDAZKdlR6hnBly1GqRipWwWuQ5aYQzNdMiy4=;
	b=TF1mk5dp2ZdAZ35k0ctGeS9MwddYu0Q/UHhvSeBzQ/Gf3i3pkAtx3XmIghhKWa/W9VlZ5t
	4d+aOA9yTCXGHWBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yIaVhTVt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TF1mk5dp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724045865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hEDckMyDAZKdlR6hnBly1GqRipWwWuQ5aYQzNdMiy4=;
	b=yIaVhTVt5n0qxTc3rdAaeSKqpTi2BijMTS+QERfbpkrnV5rW0yCLhXyK8yTVca3JPACyvk
	ki/lQqJz7ysvDj2zSknUWag7XQ88/xwyIg/hPpiz1+Yq6/s4gQY4QK0uFEzdLCLvZqY+w2
	asZxBLpvWegQqEAxk5aQO9EgHehSis4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724045865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hEDckMyDAZKdlR6hnBly1GqRipWwWuQ5aYQzNdMiy4=;
	b=TF1mk5dp2ZdAZ35k0ctGeS9MwddYu0Q/UHhvSeBzQ/Gf3i3pkAtx3XmIghhKWa/W9VlZ5t
	4d+aOA9yTCXGHWBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B3161397F;
	Mon, 19 Aug 2024 05:37:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4WBrOCbawmYkYgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 19 Aug 2024 05:37:42 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/9] Improve and expand wake_up_bit() interface.
Date: Mon, 19 Aug 2024 15:20:41 +1000
Message-ID: <20240819053605.11706-8-neilb@suse.de>
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
X-Rspamd-Queue-Id: 549D71FE4D
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

wake_up_bit() is a fragile interface.  It requires a preceding barrier
in most cased but often this barrier is forgotten by developers.

There are three cases:
1/ in the common case the relevant bit has been cleared by an atomic
   operation such as clear_bit().  In this case smp_mb__after_atomic()
   is needed.  This patch changes wake_up_bit() to include this barrier
   so that in the common case it works correctly.

2/ If the bit has been cleared by a non-atomic operation such as a
   simple bit mask and assignment, then a full barrier - smp_mb() -
   is needed.  A new interface wake_up_bit_mb() is provided which
   provided this barrier and documents the expected use case.

3/ If a fully ordered operation such as test_and_clear_bit() is used to
   clear the bit then no barrier is needed.  A new interface
   wake_up_bit_relaxed() is added which provides for this possibility.
   It is exactly the old wake_up_bit() function.

This patch also removes all explicit barriers from before wake_up_bit(),
changing some into wake_up_bit_mb() as required.

It also changes some to wake_up_bit_relaxed() as well as removing the
barrier - in cases where the barrier was never needed.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/bluetooth/btintel.h                 |  2 +-
 drivers/bluetooth/btmtk.c                   |  9 ++--
 drivers/bluetooth/btmtksdio.c               |  8 ++--
 drivers/bluetooth/btmtkuart.c               |  8 ++--
 drivers/bluetooth/hci_intel.c               |  8 ++--
 drivers/bluetooth/hci_mrvl.c                |  2 -
 drivers/md/dm-bufio.c                       |  4 --
 drivers/md/dm-snap.c                        |  1 -
 drivers/md/dm-zoned-metadata.c              |  2 -
 drivers/md/dm-zoned-reclaim.c               |  1 -
 drivers/md/dm.c                             |  1 -
 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c |  3 --
 fs/btrfs/extent_io.c                        |  2 -
 fs/buffer.c                                 |  1 -
 fs/ceph/dir.c                               |  2 +-
 fs/ceph/file.c                              |  4 +-
 fs/dcache.c                                 |  3 +-
 fs/ext4/fast_commit.c                       |  6 +--
 fs/fs-writeback.c                           |  4 +-
 fs/gfs2/glock.c                             |  2 -
 fs/gfs2/lock_dlm.c                          |  2 -
 fs/gfs2/recovery.c                          |  1 -
 fs/gfs2/sys.c                               |  1 -
 fs/gfs2/util.c                              |  1 -
 fs/inode.c                                  |  8 ++--
 fs/jbd2/commit.c                            |  7 +---
 fs/nfs/inode.c                              |  1 -
 fs/nfs/pagelist.c                           |  2 -
 fs/nfs/pnfs.c                               |  5 +--
 fs/nfsd/nfs4recover.c                       |  1 -
 fs/orangefs/file.c                          |  1 -
 fs/smb/client/inode.c                       |  1 -
 fs/smb/server/oplock.c                      |  2 -
 include/linux/wait_bit.h                    | 46 +++++++++++++++++++--
 kernel/sched/wait_bit.c                     | 13 +++---
 kernel/signal.c                             |  3 +-
 mm/ksm.c                                    |  1 -
 net/bluetooth/hci_event.c                   |  5 +--
 net/sunrpc/sched.c                          |  1 -
 security/keys/key.c                         |  4 +-
 40 files changed, 80 insertions(+), 99 deletions(-)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index aa70e4c27416..1271ded14f9a 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -202,7 +202,7 @@ struct btintel_data {
 #define btintel_wake_up_flag(hdev, nr)					\
 	do {								\
 		struct btintel_data *intel = hci_get_priv((hdev));	\
-		wake_up_bit(intel->flags, (nr));			\
+		wake_up_bit_relaxed(intel->flags, (nr));		\
 	} while (0)
 
 #define btintel_get_flag(hdev)						\
diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 2b7c80043aa2..3bbb566bb1c0 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -482,12 +482,9 @@ static void btmtk_usb_wmt_recv(struct urb *urb)
 		}
 
 		if (test_and_clear_bit(BTMTK_TX_WAIT_VND_EVT,
-				       &data->flags)) {
-			/* Barrier to sync with other CPUs */
-			smp_mb__after_atomic();
-			wake_up_bit(&data->flags,
-				    BTMTK_TX_WAIT_VND_EVT);
-		}
+				       &data->flags))
+			wake_up_bit_relaxed(&data->flags,
+					    BTMTK_TX_WAIT_VND_EVT);
 		kfree(urb->setup_packet);
 		return;
 	} else if (urb->status == -ENOENT) {
diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 39d6898497a4..3fd84ae746c4 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -401,11 +401,9 @@ static int btmtksdio_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (evt == HCI_EV_WMT) {
 		if (test_and_clear_bit(BTMTKSDIO_TX_WAIT_VND_EVT,
-				       &bdev->tx_state)) {
-			/* Barrier to sync with other CPUs */
-			smp_mb__after_atomic();
-			wake_up_bit(&bdev->tx_state, BTMTKSDIO_TX_WAIT_VND_EVT);
-		}
+				       &bdev->tx_state))
+			wake_up_bit_relaxed(&bdev->tx_state,
+					    BTMTKSDIO_TX_WAIT_VND_EVT);
 	}
 
 	return 0;
diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index aa87c3e78871..b02b56d7d1b0 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -211,11 +211,9 @@ static int btmtkuart_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (hdr->evt == HCI_EV_WMT) {
 		if (test_and_clear_bit(BTMTKUART_TX_WAIT_VND_EVT,
-				       &bdev->tx_state)) {
-			/* Barrier to sync with other CPUs */
-			smp_mb__after_atomic();
-			wake_up_bit(&bdev->tx_state, BTMTKUART_TX_WAIT_VND_EVT);
-		}
+				       &bdev->tx_state))
+			wake_up_bit_relaxed(&bdev->tx_state,
+					    BTMTKUART_TX_WAIT_VND_EVT);
 	}
 
 	return 0;
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 999ccd5bb4f2..06ab03df9a7a 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -887,7 +887,7 @@ static int intel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 
 		if (test_and_clear_bit(STATE_DOWNLOADING, &intel->flags) &&
 		    test_bit(STATE_FIRMWARE_LOADED, &intel->flags))
-			wake_up_bit(&intel->flags, STATE_DOWNLOADING);
+			wake_up_bit_relaxed(&intel->flags, STATE_DOWNLOADING);
 
 	/* When switching to the operational firmware the device
 	 * sends a vendor specific event indicating that the bootup
@@ -896,7 +896,7 @@ static int intel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 	} else if (skb->len == 9 && hdr->evt == 0xff && hdr->plen == 0x07 &&
 		   skb->data[2] == 0x02) {
 		if (test_and_clear_bit(STATE_BOOTING, &intel->flags))
-			wake_up_bit(&intel->flags, STATE_BOOTING);
+			wake_up_bit_relaxed(&intel->flags, STATE_BOOTING);
 	}
 recv:
 	return hci_recv_frame(hdev, skb);
@@ -934,12 +934,12 @@ static int intel_recv_lpm(struct hci_dev *hdev, struct sk_buff *skb)
 	case LPM_OP_SUSPEND_ACK:
 		set_bit(STATE_SUSPENDED, &intel->flags);
 		if (test_and_clear_bit(STATE_LPM_TRANSACTION, &intel->flags))
-			wake_up_bit(&intel->flags, STATE_LPM_TRANSACTION);
+			wake_up_bit_relaxed(&intel->flags, STATE_LPM_TRANSACTION);
 		break;
 	case LPM_OP_RESUME_ACK:
 		clear_bit(STATE_SUSPENDED, &intel->flags);
 		if (test_and_clear_bit(STATE_LPM_TRANSACTION, &intel->flags))
-			wake_up_bit(&intel->flags, STATE_LPM_TRANSACTION);
+			wake_up_bit_relaxed(&intel->flags, STATE_LPM_TRANSACTION);
 		break;
 	default:
 		bt_dev_err(hdev, "Unknown LPM opcode (%02x)", lpm->opcode);
diff --git a/drivers/bluetooth/hci_mrvl.c b/drivers/bluetooth/hci_mrvl.c
index e08222395772..5486cf78a99b 100644
--- a/drivers/bluetooth/hci_mrvl.c
+++ b/drivers/bluetooth/hci_mrvl.c
@@ -184,7 +184,6 @@ static int mrvl_recv_fw_req(struct hci_dev *hdev, struct sk_buff *skb)
 	mrvl->tx_len = le16_to_cpu(pkt->lhs);
 
 	clear_bit(STATE_FW_REQ_PENDING, &mrvl->flags);
-	smp_mb__after_atomic();
 	wake_up_bit(&mrvl->flags, STATE_FW_REQ_PENDING);
 
 done:
@@ -219,7 +218,6 @@ static int mrvl_recv_chip_ver(struct hci_dev *hdev, struct sk_buff *skb)
 	bt_dev_info(hdev, "Controller id = %x, rev = %x", mrvl->id, mrvl->rev);
 
 	clear_bit(STATE_CHIP_VER_PENDING, &mrvl->flags);
-	smp_mb__after_atomic();
 	wake_up_bit(&mrvl->flags, STATE_CHIP_VER_PENDING);
 
 done:
diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 098bf526136c..14b4d7cabbd6 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1432,8 +1432,6 @@ static void write_endio(struct dm_buffer *b, blk_status_t status)
 
 	smp_mb__before_atomic();
 	clear_bit(B_WRITING, &b->state);
-	smp_mb__after_atomic();
-
 	wake_up_bit(&b->state, B_WRITING);
 }
 
@@ -1843,8 +1841,6 @@ static void read_endio(struct dm_buffer *b, blk_status_t status)
 
 	smp_mb__before_atomic();
 	clear_bit(B_READING, &b->state);
-	smp_mb__after_atomic();
-
 	wake_up_bit(&b->state, B_READING);
 }
 
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index f40c18da4000..1549ab975021 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -921,7 +921,6 @@ static int init_hash_tables(struct dm_snapshot *s)
 static void merge_shutdown(struct dm_snapshot *s)
 {
 	clear_bit_unlock(RUNNING_MERGE, &s->state_bits);
-	smp_mb__after_atomic();
 	wake_up_bit(&s->state_bits, RUNNING_MERGE);
 }
 
diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index 8156881a31de..7ea225ce418f 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -525,7 +525,6 @@ static void dmz_mblock_bio_end_io(struct bio *bio)
 		flag = DMZ_META_READING;
 
 	clear_bit_unlock(flag, &mblk->state);
-	smp_mb__after_atomic();
 	wake_up_bit(&mblk->state, flag);
 
 	bio_put(bio);
@@ -1917,7 +1916,6 @@ void dmz_unlock_zone_reclaim(struct dm_zone *zone)
 	WARN_ON(!dmz_in_reclaim(zone));
 
 	clear_bit_unlock(DMZ_RECLAIM, &zone->flags);
-	smp_mb__after_atomic();
 	wake_up_bit(&zone->flags, DMZ_RECLAIM);
 }
 
diff --git a/drivers/md/dm-zoned-reclaim.c b/drivers/md/dm-zoned-reclaim.c
index d58db9a27e6c..9a7dadbb8eb7 100644
--- a/drivers/md/dm-zoned-reclaim.c
+++ b/drivers/md/dm-zoned-reclaim.c
@@ -107,7 +107,6 @@ static void dmz_reclaim_kcopy_end(int read_err, unsigned long write_err,
 		zrc->kc_err = 0;
 
 	clear_bit_unlock(DMZ_RECLAIM_KCOPY, &zrc->flags);
-	smp_mb__after_atomic();
 	wake_up_bit(&zrc->flags, DMZ_RECLAIM_KCOPY);
 }
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 97fab2087df8..3fd19d478f62 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -3154,7 +3154,6 @@ static void __dm_internal_resume(struct mapped_device *md)
 	}
 done:
 	clear_bit(DMF_SUSPENDED_INTERNALLY, &md->flags);
-	smp_mb__after_atomic();
 	wake_up_bit(&md->flags, DMF_SUSPENDED_INTERNALLY);
 }
 
diff --git a/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c b/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
index f1c79f351ec8..7df6b0791ebd 100644
--- a/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
+++ b/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
@@ -376,7 +376,6 @@ static int dvb_usb_stop_feed(struct dvb_demux_feed *dvbdmxfeed)
 
 	/* clear 'streaming' status bit */
 	clear_bit(ADAP_STREAMING, &adap->state_bits);
-	smp_mb__after_atomic();
 	wake_up_bit(&adap->state_bits, ADAP_STREAMING);
 skip_feed_stop:
 
@@ -581,7 +580,6 @@ static int dvb_usb_fe_init(struct dvb_frontend *fe)
 err:
 	if (!adap->suspend_resume_active) {
 		clear_bit(ADAP_INIT, &adap->state_bits);
-		smp_mb__after_atomic();
 		wake_up_bit(&adap->state_bits, ADAP_INIT);
 	}
 
@@ -621,7 +619,6 @@ static int dvb_usb_fe_sleep(struct dvb_frontend *fe)
 	if (!adap->suspend_resume_active) {
 		adap->active_fe = -1;
 		clear_bit(ADAP_SLEEP, &adap->state_bits);
-		smp_mb__after_atomic();
 		wake_up_bit(&adap->state_bits, ADAP_SLEEP);
 	}
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index aa7f8148cd0d..0b9cb4c87adf 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1762,7 +1762,6 @@ static void end_bbio_meta_write(struct btrfs_bio *bbio)
 	}
 
 	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
-	smp_mb__after_atomic();
 	wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
 
 	bio_put(&bbio->bio);
@@ -3506,7 +3505,6 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 static void clear_extent_buffer_reading(struct extent_buffer *eb)
 {
 	clear_bit(EXTENT_BUFFER_READING, &eb->bflags);
-	smp_mb__after_atomic();
 	wake_up_bit(&eb->bflags, EXTENT_BUFFER_READING);
 }
 
diff --git a/fs/buffer.c b/fs/buffer.c
index e55ad471c530..2932618c88e4 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -75,7 +75,6 @@ EXPORT_SYMBOL(__lock_buffer);
 void unlock_buffer(struct buffer_head *bh)
 {
 	clear_bit_unlock(BH_Lock, &bh->b_state);
-	smp_mb__after_atomic();
 	wake_up_bit(&bh->b_state, BH_Lock);
 }
 EXPORT_SYMBOL(unlock_buffer);
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 18c72b305858..20d02142b059 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1254,7 +1254,7 @@ static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
 
 	spin_lock(&dentry->d_lock);
 	di->flags &= ~CEPH_DENTRY_ASYNC_UNLINK;
-	wake_up_bit(&di->flags, CEPH_DENTRY_ASYNC_UNLINK_BIT);
+	wake_up_bit_mb(&di->flags, CEPH_DENTRY_ASYNC_UNLINK_BIT);
 	spin_unlock(&dentry->d_lock);
 
 	synchronize_rcu();
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 4b8d59ebda00..d779780abea5 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -581,7 +581,7 @@ static void wake_async_create_waiters(struct inode *inode,
 	spin_lock(&ci->i_ceph_lock);
 	if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE) {
 		ci->i_ceph_flags &= ~CEPH_I_ASYNC_CREATE;
-		wake_up_bit(&ci->i_ceph_flags, CEPH_ASYNC_CREATE_BIT);
+		wake_up_bit_mb(&ci->i_ceph_flags, CEPH_ASYNC_CREATE_BIT);
 
 		if (ci->i_ceph_flags & CEPH_I_ASYNC_CHECK_CAPS) {
 			ci->i_ceph_flags &= ~CEPH_I_ASYNC_CHECK_CAPS;
@@ -766,7 +766,7 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 
 	spin_lock(&dentry->d_lock);
 	di->flags &= ~CEPH_DENTRY_ASYNC_CREATE;
-	wake_up_bit(&di->flags, CEPH_DENTRY_ASYNC_CREATE_BIT);
+	wake_up_bit_mb(&di->flags, CEPH_DENTRY_ASYNC_CREATE_BIT);
 	spin_unlock(&dentry->d_lock);
 
 	return ret;
diff --git a/fs/dcache.c b/fs/dcache.c
index 3d8daaecb6d1..8f63de904d7c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1908,8 +1908,7 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
 	__d_instantiate(entry, inode);
 	WARN_ON(!(inode->i_state & I_NEW));
 	inode->i_state &= ~I_NEW & ~I_CREATING;
-	smp_mb();
-	wake_up_bit(&inode->i_state, __I_NEW);
+	wake_up_bit_mb(&inode->i_state, __I_NEW);
 	spin_unlock(&inode->i_lock);
 }
 EXPORT_SYMBOL(d_instantiate_new);
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 3926a05eceee..03d94f5fc8c8 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1290,12 +1290,10 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 				       EXT4_STATE_FC_COMMITTING);
 		if (tid_geq(tid, iter->i_sync_tid))
 			ext4_fc_reset_inode(&iter->vfs_inode);
-		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
-		smp_mb();
 #if (BITS_PER_LONG < 64)
-		wake_up_bit(&iter->i_state_flags, EXT4_STATE_FC_COMMITTING);
+		wake_up_bit_mb(&iter->i_state_flags, EXT4_STATE_FC_COMMITTING);
 #else
-		wake_up_bit(&iter->i_flags, EXT4_STATE_FC_COMMITTING);
+		wake_up_bit_mb(&iter->i_flags, EXT4_STATE_FC_COMMITTING);
 #endif
 	}
 
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index b865a3fa52f3..0f6646d67a73 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1384,9 +1384,7 @@ static void inode_sync_complete(struct inode *inode)
 	inode->i_state &= ~I_SYNC;
 	/* If inode is clean an unused, put it into LRU now... */
 	inode_add_lru(inode);
-	/* Waiters must see I_SYNC cleared before being woken up */
-	smp_mb();
-	wake_up_bit(&inode->i_state, __I_SYNC);
+	wake_up_bit_mb(&inode->i_state, __I_SYNC);
 }
 
 static bool inode_dirtied_after(struct inode *inode, unsigned long t)
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 12a769077ea0..e1afe9aa7c2a 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -380,7 +380,6 @@ static inline bool may_grant(struct gfs2_glock *gl,
 static void gfs2_holder_wake(struct gfs2_holder *gh)
 {
 	clear_bit(HIF_WAIT, &gh->gh_iflags);
-	smp_mb__after_atomic();
 	wake_up_bit(&gh->gh_iflags, HIF_WAIT);
 	if (gh->gh_flags & GL_ASYNC) {
 		struct gfs2_sbd *sdp = gh->gh_gl->gl_name.ln_sbd;
@@ -576,7 +575,6 @@ static void gfs2_demote_wake(struct gfs2_glock *gl)
 {
 	gl->gl_demote_state = LM_ST_EXCLUSIVE;
 	clear_bit(GLF_DEMOTE, &gl->gl_flags);
-	smp_mb__after_atomic();
 	wake_up_bit(&gl->gl_flags, GLF_DEMOTE);
 }
 
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index fa5134df985f..921b26b96192 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -1224,7 +1224,6 @@ static void gdlm_recover_done(void *arg, struct dlm_slot *slots, int num_slots,
 		queue_delayed_work(gfs2_control_wq, &sdp->sd_control_work, 0);
 
 	clear_bit(DFL_DLM_RECOVERY, &ls->ls_recover_flags);
-	smp_mb__after_atomic();
 	wake_up_bit(&ls->ls_recover_flags, DFL_DLM_RECOVERY);
 	spin_unlock(&ls->ls_recover_spin);
 }
@@ -1366,7 +1365,6 @@ static int gdlm_mount(struct gfs2_sbd *sdp, const char *table)
 
 	ls->ls_first = !!test_bit(DFL_FIRST_MOUNT, &ls->ls_recover_flags);
 	clear_bit(SDF_NOJOURNALID, &sdp->sd_flags);
-	smp_mb__after_atomic();
 	wake_up_bit(&sdp->sd_flags, SDF_NOJOURNALID);
 	return 0;
 
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index f4fe7039f725..e70cf003d524 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -558,7 +558,6 @@ void gfs2_recover_func(struct work_struct *work)
 	gfs2_recovery_done(sdp, jd->jd_jid, LM_RD_GAVEUP);
 done:
 	clear_bit(JDF_RECOVERY, &jd->jd_flags);
-	smp_mb__after_atomic();
 	wake_up_bit(&jd->jd_flags, JDF_RECOVERY);
 }
 
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index ecc699f8d9fc..738337e35724 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -587,7 +587,6 @@ static ssize_t jid_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 		rv = jid = -EINVAL;
 	sdp->sd_lockstruct.ls_jid = jid;
 	clear_bit(SDF_NOJOURNALID, &sdp->sd_flags);
-	smp_mb__after_atomic();
 	wake_up_bit(&sdp->sd_flags, SDF_NOJOURNALID);
 out:
 	spin_unlock(&sdp->sd_jindex_spin);
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 13be8d1d228b..2818f3891498 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -353,7 +353,6 @@ int gfs2_withdraw(struct gfs2_sbd *sdp)
 		fs_err(sdp, "File system withdrawn\n");
 		dump_stack();
 		clear_bit(SDF_WITHDRAW_IN_PROG, &sdp->sd_flags);
-		smp_mb__after_atomic();
 		wake_up_bit(&sdp->sd_flags, SDF_WITHDRAW_IN_PROG);
 	}
 
diff --git a/fs/inode.c b/fs/inode.c
index 91bb2f80fa03..f5f35b701196 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -687,7 +687,7 @@ static void evict(struct inode *inode)
 	 * used as an indicator whether blocking on it is safe.
 	 */
 	spin_lock(&inode->i_lock);
-	wake_up_bit(&inode->i_state, __I_NEW);
+	wake_up_bit_relaxed(&inode->i_state, __I_NEW);
 	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
 	spin_unlock(&inode->i_lock);
 
@@ -1095,8 +1095,7 @@ void unlock_new_inode(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_NEW));
 	inode->i_state &= ~I_NEW & ~I_CREATING;
-	smp_mb();
-	wake_up_bit(&inode->i_state, __I_NEW);
+	wake_up_bit_mb(&inode->i_state, __I_NEW);
 	spin_unlock(&inode->i_lock);
 }
 EXPORT_SYMBOL(unlock_new_inode);
@@ -1107,8 +1106,7 @@ void discard_new_inode(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_NEW));
 	inode->i_state &= ~I_NEW;
-	smp_mb();
-	wake_up_bit(&inode->i_state, __I_NEW);
+	wake_up_bit_mb(&inode->i_state, __I_NEW);
 	spin_unlock(&inode->i_lock);
 	iput(inode);
 }
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 4305a1ac808a..55ba3f62fbe3 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -40,7 +40,6 @@ static void journal_end_buffer_io_sync(struct buffer_head *bh, int uptodate)
 		clear_buffer_uptodate(bh);
 	if (orig_bh) {
 		clear_bit_unlock(BH_Shadow, &orig_bh->b_state);
-		smp_mb__after_atomic();
 		wake_up_bit(&orig_bh->b_state, BH_Shadow);
 	}
 	unlock_buffer(bh);
@@ -230,8 +229,7 @@ static int journal_submit_data_buffers(journal_t *journal,
 		spin_lock(&journal->j_list_lock);
 		J_ASSERT(jinode->i_transaction == commit_transaction);
 		jinode->i_flags &= ~JI_COMMIT_RUNNING;
-		smp_mb();
-		wake_up_bit(&jinode->i_flags, __JI_COMMIT_RUNNING);
+		wake_up_bit_mb(&jinode->i_flags, __JI_COMMIT_RUNNING);
 	}
 	spin_unlock(&journal->j_list_lock);
 	return ret;
@@ -273,8 +271,7 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
 		cond_resched();
 		spin_lock(&journal->j_list_lock);
 		jinode->i_flags &= ~JI_COMMIT_RUNNING;
-		smp_mb();
-		wake_up_bit(&jinode->i_flags, __JI_COMMIT_RUNNING);
+		wake_up_bit_mb(&jinode->i_flags, __JI_COMMIT_RUNNING);
 	}
 
 	/* Now refile inode to proper lists */
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b4914a11c3c2..19d175446899 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1429,7 +1429,6 @@ int nfs_clear_invalid_mapping(struct address_space *mapping)
 	trace_nfs_invalidate_mapping_exit(inode, ret);
 
 	clear_bit_unlock(NFS_INO_INVALIDATING, bitlock);
-	smp_mb__after_atomic();
 	wake_up_bit(bitlock, NFS_INO_INVALIDATING);
 out:
 	return ret;
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 8ae767578cd9..9f45c08d2e79 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -215,7 +215,6 @@ void
 nfs_page_clear_headlock(struct nfs_page *req)
 {
 	clear_bit_unlock(PG_HEADLOCK, &req->wb_flags);
-	smp_mb__after_atomic();
 	if (!test_bit(PG_CONTENDED1, &req->wb_flags))
 		return;
 	wake_up_bit(&req->wb_flags, PG_HEADLOCK);
@@ -520,7 +519,6 @@ nfs_create_subreq(struct nfs_page *req,
 void nfs_unlock_request(struct nfs_page *req)
 {
 	clear_bit_unlock(PG_BUSY, &req->wb_flags);
-	smp_mb__after_atomic();
 	if (!test_bit(PG_CONTENDED2, &req->wb_flags))
 		return;
 	wake_up_bit(&req->wb_flags, PG_BUSY);
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index aa698481bec8..877fc154eb2b 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -388,7 +388,6 @@ static void pnfs_clear_layoutreturn_waitbit(struct pnfs_layout_hdr *lo)
 {
 	clear_bit_unlock(NFS_LAYOUT_RETURN, &lo->plh_flags);
 	clear_bit(NFS_LAYOUT_RETURN_LOCK, &lo->plh_flags);
-	smp_mb__after_atomic();
 	wake_up_bit(&lo->plh_flags, NFS_LAYOUT_RETURN);
 	rpc_wake_up(&NFS_SERVER(lo->plh_inode)->roc_rpcwaitq);
 }
@@ -2044,7 +2043,7 @@ static void nfs_layoutget_end(struct pnfs_layout_hdr *lo)
 {
 	if (atomic_dec_and_test(&lo->plh_outstanding) &&
 	    test_and_clear_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags))
-		wake_up_bit(&lo->plh_flags, NFS_LAYOUT_DRAIN);
+		wake_up_bit_relaxed(&lo->plh_flags, NFS_LAYOUT_DRAIN);
 }
 
 static bool pnfs_is_first_layoutget(struct pnfs_layout_hdr *lo)
@@ -2057,7 +2056,6 @@ static void pnfs_clear_first_layoutget(struct pnfs_layout_hdr *lo)
 	unsigned long *bitlock = &lo->plh_flags;
 
 	clear_bit_unlock(NFS_LAYOUT_FIRST_LAYOUTGET, bitlock);
-	smp_mb__after_atomic();
 	wake_up_bit(bitlock, NFS_LAYOUT_FIRST_LAYOUTGET);
 }
 
@@ -3230,7 +3228,6 @@ static void pnfs_clear_layoutcommitting(struct inode *inode)
 	unsigned long *bitlock = &NFS_I(inode)->flags;
 
 	clear_bit_unlock(NFS_INO_LAYOUTCOMMITTING, bitlock);
-	smp_mb__after_atomic();
 	wake_up_bit(bitlock, NFS_INO_LAYOUTCOMMITTING);
 }
 
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 67d8673a9391..3e1a434bc649 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -1897,7 +1897,6 @@ nfsd4_cltrack_upcall_unlock(struct nfs4_client *clp)
 {
 	smp_mb__before_atomic();
 	clear_bit(NFSD4_CLIENT_UPCALL_LOCK, &clp->cl_flags);
-	smp_mb__after_atomic();
 	wake_up_bit(&clp->cl_flags, NFSD4_CLIENT_UPCALL_LOCK);
 }
 
diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index d68372241b30..d620b56a1002 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -314,7 +314,6 @@ int orangefs_revalidate_mapping(struct inode *inode)
 	    orangefs_cache_timeout_msecs*HZ/1000;
 
 	clear_bit(1, bitlock);
-	smp_mb__after_atomic();
 	wake_up_bit(bitlock, 1);
 
 	return ret;
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index dd0afa23734c..8da74f15cc95 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2511,7 +2511,6 @@ cifs_revalidate_mapping(struct inode *inode)
 
 skip_invalidate:
 	clear_bit_unlock(CIFS_INO_LOCK, flags);
-	smp_mb__after_atomic();
 	wake_up_bit(flags, CIFS_INO_LOCK);
 
 	return rc;
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index a8f52c4ebbda..b039b242df46 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -594,8 +594,6 @@ static void wait_for_break_ack(struct oplock_info *opinfo)
 static void wake_up_oplock_break(struct oplock_info *opinfo)
 {
 	clear_bit_unlock(0, &opinfo->pending_break);
-	/* memory barrier is needed for wake_up_bit() */
-	smp_mb__after_atomic();
 	wake_up_bit(&opinfo->pending_break, 0);
 }
 
diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 178ed8bed91c..609c10fcd344 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -26,7 +26,7 @@ typedef int wait_bit_action_f(struct wait_bit_key *key, int mode);
 void __wake_up_bit(struct wait_queue_head *wq_head, void *word, int bit);
 int __wait_on_bit(struct wait_queue_head *wq_head, struct wait_bit_queue_entry *wbq_entry, wait_bit_action_f *action, unsigned int mode);
 int __wait_on_bit_lock(struct wait_queue_head *wq_head, struct wait_bit_queue_entry *wbq_entry, wait_bit_action_f *action, unsigned int mode);
-void wake_up_bit(void *word, int bit);
+void wake_up_bit_relaxed(void *word, int bit);
 int out_of_line_wait_on_bit(void *word, int, wait_bit_action_f *action, unsigned int mode);
 int out_of_line_wait_on_bit_timeout(void *word, int, wait_bit_action_f *action, unsigned int mode, unsigned long timeout);
 int out_of_line_wait_on_bit_lock(void *word, int, wait_bit_action_f *action, unsigned int mode);
@@ -318,6 +318,48 @@ do {									\
 	__ret;								\
 })
 
+/**
+ * wake_up_bit - wake up waiters on a bit
+ * @word: the word being waited on, a kernel virtual address
+ * @bit: the bit of the word being waited on
+ *
+ * There is a standard hashed waitqueue table for generic use. This
+ * is the part of the hash-table's accessor API that wakes up waiters
+ * on a bit. For instance, if one were to have waiters on a bitflag,
+ * one would call wake_up_bit() after atomically clearing the bit.
+ *
+ * This interface should only be use when the bit is cleared atomically,
+ * such as with clear_bit(), atomic_andnot(), code inside a locked
+ * region (with this interface called after the unlock).  If this
+ * bit is cleared non-atomically, wake_up_bit_mb() should be used.
+ */
+static inline void wake_up_bit(void *word, int bit)
+{
+	smp_mb__after_atomic();
+	wake_up_bit_relaxed(word, bit);
+}
+
+/**
+ * wake_up_bit_mb - wake up waiters on a bit with full barrier
+ * @word: the word being waited on, a kernel virtual address
+ * @bit: the bit of the word being waited on
+ *
+ * There is a standard hashed waitqueue table for generic use. This
+ * is the part of the hash-table's accessor API that wakes up waiters
+ * on a bit. For instance, if one were to have waiters on a bitflag,
+ * one would call wake_up_bit() after non-atomically clearing the bit.
+ *
+ * This interface has a full barrier and so is safe to use anywhere.
+ * It is particular intended for use after the bit has been cleared
+ * (or set) non-atmomically with simple assignment.  Where the bit
+ * it cleared atomically, the barrier used may be excessively.
+ */
+static inline void wake_up_bit_mb(void *word, int bit)
+{
+	smp_mb();
+	wake_up_bit_relaxed(word, bit);
+}
+
 /**
  * clear_and_wake_up_bit - clear a bit and wake up anyone waiting on that bit
  *
@@ -330,8 +372,6 @@ do {									\
 static inline void clear_and_wake_up_bit(int bit, void *word)
 {
 	clear_bit_unlock(bit, word);
-	/* See wake_up_bit() for which memory barrier you need to use. */
-	smp_mb__after_atomic();
 	wake_up_bit(word, bit);
 }
 
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 134d7112ef71..51d923bf207e 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -128,7 +128,7 @@ void __wake_up_bit(struct wait_queue_head *wq_head, void *word, int bit)
 EXPORT_SYMBOL(__wake_up_bit);
 
 /**
- * wake_up_bit - wake up a waiter on a bit
+ * wake_up_bit_relaxed - wake up waiters on a bit
  * @word: the word being waited on, a kernel virtual address
  * @bit: the bit of the word being waited on
  *
@@ -139,16 +139,15 @@ EXPORT_SYMBOL(__wake_up_bit);
  *
  * In order for this to function properly, as it uses waitqueue_active()
  * internally, some kind of memory barrier must be done prior to calling
- * this. Typically, this will be smp_mb__after_atomic(), but in some
- * cases where bitflags are manipulated non-atomically under a lock, one
- * may need to use a less regular barrier, such fs/inode.c's smp_mb(),
- * because spin_unlock() does not guarantee a memory barrier.
+ * this. Typically this will be provided implicitly by test_and_clear_bit().
+ * If the bit is cleared without full ordering, an alternate interface
+ * such as wake_up_bit_mb() or wake_up_bit() should be used.
  */
-void wake_up_bit(void *word, int bit)
+void wake_up_bit_relaxed(void *word, int bit)
 {
 	__wake_up_bit(bit_waitqueue(word, bit), word, bit);
 }
-EXPORT_SYMBOL(wake_up_bit);
+EXPORT_SYMBOL(wake_up_bit_relaxed);
 
 wait_queue_head_t *__var_waitqueue(void *p)
 {
diff --git a/kernel/signal.c b/kernel/signal.c
index 60c737e423a1..1c3d51027cd0 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -306,8 +306,7 @@ void task_clear_jobctl_trapping(struct task_struct *task)
 {
 	if (unlikely(task->jobctl & JOBCTL_TRAPPING)) {
 		task->jobctl &= ~JOBCTL_TRAPPING;
-		smp_mb();	/* advised by wake_up_bit() */
-		wake_up_bit(&task->jobctl, JOBCTL_TRAPPING_BIT);
+		wake_up_bit_mb(&task->jobctl, JOBCTL_TRAPPING_BIT);
 	}
 }
 
diff --git a/mm/ksm.c b/mm/ksm.c
index 14d9e53b1ec2..edc55ba641fb 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3267,7 +3267,6 @@ static int ksm_memory_callback(struct notifier_block *self,
 		ksm_run &= ~KSM_RUN_OFFLINE;
 		mutex_unlock(&ksm_thread_mutex);
 
-		smp_mb();	/* wake_up_bit advises this */
 		wake_up_bit(&ksm_run, ilog2(KSM_RUN_OFFLINE));
 		break;
 	}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d0c118c47f6c..226b37017d56 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -105,7 +105,6 @@ static u8 hci_cc_inquiry_cancel(struct hci_dev *hdev, void *data,
 		return rp->status;
 
 	clear_bit(HCI_INQUIRY, &hdev->flags);
-	smp_mb__after_atomic(); /* wake_up_bit advises about this barrier */
 	wake_up_bit(&hdev->flags, HCI_INQUIRY);
 
 	hci_dev_lock(hdev);
@@ -2972,9 +2971,7 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, void *data,
 
 	if (!test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
 		return;
-
-	smp_mb__after_atomic(); /* wake_up_bit advises about this barrier */
-	wake_up_bit(&hdev->flags, HCI_INQUIRY);
+	wake_up_bit_relaxed(&hdev->flags, HCI_INQUIRY);
 
 	if (!hci_dev_test_flag(hdev, HCI_MGMT))
 		return;
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index cef623ea1506..1f64652cb629 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -370,7 +370,6 @@ static void rpc_make_runnable(struct workqueue_struct *wq,
 		INIT_WORK(&task->u.tk_work, rpc_async_schedule);
 		queue_work(wq, &task->u.tk_work);
 	} else {
-		smp_mb__after_atomic();
 		wake_up_bit(&task->tk_runstate, RPC_TASK_QUEUED);
 	}
 }
diff --git a/security/keys/key.c b/security/keys/key.c
index 3d7d185019d3..8f7380935eb5 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -474,7 +474,7 @@ static int __key_instantiate_and_link(struct key *key,
 
 	/* wake up anyone waiting for a key to be constructed */
 	if (awaken)
-		wake_up_bit(&key->flags, KEY_FLAG_USER_CONSTRUCT);
+		wake_up_bit_relaxed(&key->flags, KEY_FLAG_USER_CONSTRUCT);
 
 	return ret;
 }
@@ -629,7 +629,7 @@ int key_reject_and_link(struct key *key,
 
 	/* wake up anyone waiting for a key to be constructed */
 	if (awaken)
-		wake_up_bit(&key->flags, KEY_FLAG_USER_CONSTRUCT);
+		wake_up_bit_relaxed(&key->flags, KEY_FLAG_USER_CONSTRUCT);
 
 	return ret == 0 ? link_ret : ret;
 }
-- 
2.44.0


