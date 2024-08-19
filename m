Return-Path: <linux-fsdevel+bounces-26228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8BB95634F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 07:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9531F21078
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 05:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB7815820F;
	Mon, 19 Aug 2024 05:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SPJQn2xV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1eIpcV9g";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SPJQn2xV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1eIpcV9g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7460156967;
	Mon, 19 Aug 2024 05:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724045879; cv=none; b=oGY11vlelF41LbD/1UMOIwjKgA7KSoD+64fgHZofRKRlQ765HkbRasMMAt4mcrA4/AFfz8nDLvby6FKJh9a/3l/VcCJy5eX2UUMz2tG61u1tElaCec9e3JqNRVoorU9YdZOP2ITmvtuXEyZLTQUXoaYWadgCQGhdH0elveUPBCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724045879; c=relaxed/simple;
	bh=4nKBNNShm/Zy8AJtJDRkBJ61w7mDnpp3OjLCPUfT3CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YW8hdDsxHOXP0APhKfoWAt4eCMFatx6HlKq2LeCNDfflZ99zKGbaxN7x5ea//LrtOEbf4q14S1IktJJ9Xct0P0QHj08/nQuoSLVPXfEM8Tvwc1iATuuU8zD83UogpkLHjbvNZjcfXMhsIx1Nph8SQlD1kP5SH9OBXvFTei3hw70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SPJQn2xV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1eIpcV9g; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SPJQn2xV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1eIpcV9g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1343922769;
	Mon, 19 Aug 2024 05:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724045875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9JNgMtsB3DfSQMS3FRXt3WVto7fWidDnNsmUjs1yl0=;
	b=SPJQn2xVBh4pJw5lRGQL2o0yTaA9BsyoR5nsozYTZAO6gyqi8cRBH7GEDotemHGyCzfeug
	C4DTN6i7CQm7ABY9gzHmh3zpVyc2CpEcUFFAwfZBHflR5nNNMG0UDiel4jPzdqjEir17iv
	PoxCq1aaHRCj3QrK3X2FcOoFZ4cHMeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724045875;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9JNgMtsB3DfSQMS3FRXt3WVto7fWidDnNsmUjs1yl0=;
	b=1eIpcV9gzG7qCXhTvbwsK3veLWz4/2Qzc8ZoACCLZkYw/obUIhHBGEq4Y24GPCOtzoievd
	i8ulhD6xT9287RBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724045875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9JNgMtsB3DfSQMS3FRXt3WVto7fWidDnNsmUjs1yl0=;
	b=SPJQn2xVBh4pJw5lRGQL2o0yTaA9BsyoR5nsozYTZAO6gyqi8cRBH7GEDotemHGyCzfeug
	C4DTN6i7CQm7ABY9gzHmh3zpVyc2CpEcUFFAwfZBHflR5nNNMG0UDiel4jPzdqjEir17iv
	PoxCq1aaHRCj3QrK3X2FcOoFZ4cHMeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724045875;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9JNgMtsB3DfSQMS3FRXt3WVto7fWidDnNsmUjs1yl0=;
	b=1eIpcV9gzG7qCXhTvbwsK3veLWz4/2Qzc8ZoACCLZkYw/obUIhHBGEq4Y24GPCOtzoievd
	i8ulhD6xT9287RBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECCCF1397F;
	Mon, 19 Aug 2024 05:37:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bEAyKDDawmYrYgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 19 Aug 2024 05:37:52 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 8/9] Improve and extend wake_up_var() interface.
Date: Mon, 19 Aug 2024 15:20:42 +1000
Message-ID: <20240819053605.11706-9-neilb@suse.de>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80

wake_up_var() is similar to wake_up_bit() and benefits from a richer
interface which includes barriers.

- wake_up_var() now has smp_mb__after_atomic() and should be used after
  the variable is changed atomically - including inside a locked region.
- wake_up_var_mb() now has smb_mb() and should be used after the variable
  has been changed non-atomically
- wake_up_var_relaxed() can be used when no barrier is needed, such as
  after atomic_dec_and_test.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 block/bdev.c              |  3 +-
 drivers/block/pktcdvd.c   |  3 +-
 fs/afs/cell.c             | 16 +++++------
 fs/netfs/fscache_cache.c  |  2 +-
 fs/netfs/fscache_cookie.c |  6 ----
 fs/netfs/fscache_volume.c |  2 +-
 fs/netfs/io.c             |  4 +--
 fs/nfs/dir.c              |  3 +-
 fs/nfs/nfs4state.c        |  2 +-
 fs/nfsd/nfs4state.c       |  2 +-
 fs/notify/mark.c          |  2 +-
 fs/super.c                | 20 +++++---------
 fs/xfs/xfs_buf.c          |  2 +-
 include/linux/mbcache.h   |  2 +-
 include/linux/wait_bit.h  | 58 +++++++++++++++++++++++++++++++++++++--
 kernel/events/core.c      |  6 ++--
 kernel/sched/core.c       |  2 +-
 kernel/sched/wait_bit.c   | 21 ++++++++++++--
 kernel/softirq.c          |  3 +-
 mm/memremap.c             |  2 +-
 security/landlock/fs.c    |  2 +-
 21 files changed, 108 insertions(+), 55 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index d804c91c651b..34ee3e155c18 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -561,8 +561,7 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
 	/* tell others that we're done */
 	BUG_ON(whole->bd_claiming != holder);
 	whole->bd_claiming = NULL;
-	smp_mb();
-	wake_up_var(&whole->bd_claiming);
+	wake_up_var_mb(&whole->bd_claiming);
 }
 
 /**
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 273fbe05d80f..e774057329c6 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1210,8 +1210,7 @@ static int pkt_handle_queue(struct pktcdvd_device *pd)
 	if (pd->congested &&
 	    pd->bio_queue_size <= pd->write_congestion_off) {
 		pd->congested = false;
-		smp_mb();
-		wake_up_var(&pd->congested);
+		wake_up_var_mb(&pd->congested);
 	}
 	spin_unlock(&pd->lock);
 
diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 422bcc26becc..726bf48094ce 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -478,7 +478,7 @@ static int afs_update_cell(struct afs_cell *cell)
 out_wake:
 	smp_store_release(&cell->dns_lookup_count,
 			  cell->dns_lookup_count + 1); /* vs source/status */
-	wake_up_var(&cell->dns_lookup_count);
+	wake_up_var_mb(&cell->dns_lookup_count);
 	_leave(" = %d", ret);
 	return ret;
 }
@@ -748,12 +748,12 @@ static void afs_manage_cell(struct afs_cell *cell)
 		if (cell->state == AFS_CELL_FAILED)
 			goto done;
 		smp_store_release(&cell->state, AFS_CELL_UNSET);
-		wake_up_var(&cell->state);
+		wake_up_var_mb(&cell->state);
 		goto again;
 
 	case AFS_CELL_UNSET:
 		smp_store_release(&cell->state, AFS_CELL_ACTIVATING);
-		wake_up_var(&cell->state);
+		wake_up_var_mb(&cell->state);
 		goto again;
 
 	case AFS_CELL_ACTIVATING:
@@ -762,7 +762,7 @@ static void afs_manage_cell(struct afs_cell *cell)
 			goto activation_failed;
 
 		smp_store_release(&cell->state, AFS_CELL_ACTIVE);
-		wake_up_var(&cell->state);
+		wake_up_var_mb(&cell->state);
 		goto again;
 
 	case AFS_CELL_ACTIVE:
@@ -775,7 +775,7 @@ static void afs_manage_cell(struct afs_cell *cell)
 			goto done;
 		}
 		smp_store_release(&cell->state, AFS_CELL_DEACTIVATING);
-		wake_up_var(&cell->state);
+		wake_up_var_mb(&cell->state);
 		goto again;
 
 	case AFS_CELL_DEACTIVATING:
@@ -783,7 +783,7 @@ static void afs_manage_cell(struct afs_cell *cell)
 			goto reverse_deactivation;
 		afs_deactivate_cell(net, cell);
 		smp_store_release(&cell->state, AFS_CELL_INACTIVE);
-		wake_up_var(&cell->state);
+		wake_up_var_mb(&cell->state);
 		goto again;
 
 	case AFS_CELL_REMOVED:
@@ -800,12 +800,12 @@ static void afs_manage_cell(struct afs_cell *cell)
 	afs_deactivate_cell(net, cell);
 
 	smp_store_release(&cell->state, AFS_CELL_FAILED); /* vs error */
-	wake_up_var(&cell->state);
+	wake_up_var_mb(&cell->state);
 	goto again;
 
 reverse_deactivation:
 	smp_store_release(&cell->state, AFS_CELL_ACTIVE);
-	wake_up_var(&cell->state);
+	wake_up_var_mb(&cell->state);
 	_leave(" [deact->act]");
 	return;
 
diff --git a/fs/netfs/fscache_cache.c b/fs/netfs/fscache_cache.c
index 9397ed39b0b4..83e6d25a5e0a 100644
--- a/fs/netfs/fscache_cache.c
+++ b/fs/netfs/fscache_cache.c
@@ -321,7 +321,7 @@ void fscache_end_cache_access(struct fscache_cache *cache, enum fscache_access_t
 	trace_fscache_access_cache(cache->debug_id, refcount_read(&cache->ref),
 				   n_accesses, why);
 	if (n_accesses == 0)
-		wake_up_var(&cache->n_accesses);
+		wake_up_var_relaxed(&cache->n_accesses);
 }
 
 /**
diff --git a/fs/netfs/fscache_cookie.c b/fs/netfs/fscache_cookie.c
index bce2492186d0..93c66938b164 100644
--- a/fs/netfs/fscache_cookie.c
+++ b/fs/netfs/fscache_cookie.c
@@ -191,12 +191,6 @@ bool fscache_begin_cookie_access(struct fscache_cookie *cookie,
 
 static inline void wake_up_cookie_state(struct fscache_cookie *cookie)
 {
-	/* Use a barrier to ensure that waiters see the state variable
-	 * change, as spin_unlock doesn't guarantee a barrier.
-	 *
-	 * See comments over wake_up_bit() and waitqueue_active().
-	 */
-	smp_mb();
 	wake_up_var(&cookie->state);
 }
 
diff --git a/fs/netfs/fscache_volume.c b/fs/netfs/fscache_volume.c
index cb75c07b5281..c6c43a87f56e 100644
--- a/fs/netfs/fscache_volume.c
+++ b/fs/netfs/fscache_volume.c
@@ -128,7 +128,7 @@ void fscache_end_volume_access(struct fscache_volume *volume,
 				    refcount_read(&volume->ref),
 				    n_accesses, why);
 	if (n_accesses == 0)
-		wake_up_var(&volume->n_accesses);
+		wake_up_var_relaxed(&volume->n_accesses);
 }
 EXPORT_SYMBOL(fscache_end_volume_access);
 
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index c93851b98368..ebae3cfcad20 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -181,7 +181,7 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_io_request *rreq)
 	if (atomic_dec_and_test(&rreq->nr_outstanding))
 		return true;
 
-	wake_up_var(&rreq->nr_outstanding);
+	wake_up_var_relaxed(&rreq->nr_outstanding);
 	return false;
 }
 
@@ -372,7 +372,7 @@ void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
 	if (u == 0)
 		netfs_rreq_terminated(rreq, was_async);
 	else if (u == 1)
-		wake_up_var(&rreq->nr_outstanding);
+		wake_up_var_relaxed(&rreq->nr_outstanding);
 
 	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
 	return;
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 4cb97ef41350..1d745f105095 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1837,9 +1837,8 @@ static void block_revalidate(struct dentry *dentry)
 
 static void unblock_revalidate(struct dentry *dentry)
 {
-	/* store_release ensures wait_var_event() sees the update */
 	smp_store_release(&dentry->d_fsdata, NULL);
-	wake_up_var(&dentry->d_fsdata);
+	wake_up_var_mb(&dentry->d_fsdata);
 }
 
 /*
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 877f682b45f2..d038409a9a9a 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1220,7 +1220,7 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
 		swapon = !test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE,
 					   &clp->cl_state);
 		if (!swapon) {
-			wake_up_var(&clp->cl_state);
+			wake_up_var_relaxed(&clp->cl_state);
 			return;
 		}
 	}
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a20c2c9d7d45..d156ac7637cf 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7478,8 +7478,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto put_stateid;
 
 	trace_nfsd_deleg_return(stateid);
-	wake_up_var(d_inode(cstate->current_fh.fh_dentry));
 	destroy_delegation(dp);
+	wake_up_var(d_inode(cstate->current_fh.fh_dentry));
 put_stateid:
 	nfs4_put_stid(&dp->dl_stid);
 out:
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 5e170e713088..ff3d84e9db4d 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -139,7 +139,7 @@ static void fsnotify_get_sb_watched_objects(struct super_block *sb)
 static void fsnotify_put_sb_watched_objects(struct super_block *sb)
 {
 	if (atomic_long_dec_and_test(fsnotify_sb_watched_objects(sb)))
-		wake_up_var(fsnotify_sb_watched_objects(sb));
+		wake_up_var_relaxed(fsnotify_sb_watched_objects(sb));
 }
 
 static void fsnotify_get_inode_ref(struct inode *inode)
diff --git a/fs/super.c b/fs/super.c
index 38d72a3cf6fc..96b9a682a7ca 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -158,13 +158,7 @@ static void super_wake(struct super_block *sb, unsigned int flag)
 	 * seeing SB_BORN sent.
 	 */
 	smp_store_release(&sb->s_flags, sb->s_flags | flag);
-	/*
-	 * Pairs with the barrier in prepare_to_wait_event() to make sure
-	 * ___wait_var_event() either sees SB_BORN set or
-	 * waitqueue_active() check in wake_up_var() sees the waiter.
-	 */
-	smp_mb();
-	wake_up_var(&sb->s_flags);
+	wake_up_var_mb(&sb->s_flags);
 }
 
 /*
@@ -2074,7 +2068,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 		/* Nothing to do really... */
 		WARN_ON_ONCE(freeze_inc(sb, who) > 1);
 		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
-		wake_up_var(&sb->s_writers.frozen);
+		wake_up_var_mb(&sb->s_writers.frozen);
 		super_unlock_excl(sb);
 		return 0;
 	}
@@ -2094,7 +2088,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 	if (ret) {
 		sb->s_writers.frozen = SB_UNFROZEN;
 		sb_freeze_unlock(sb, SB_FREEZE_PAGEFAULT);
-		wake_up_var(&sb->s_writers.frozen);
+		wake_up_var_mb(&sb->s_writers.frozen);
 		deactivate_locked_super(sb);
 		return ret;
 	}
@@ -2110,7 +2104,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 				"VFS:Filesystem freeze failed\n");
 			sb->s_writers.frozen = SB_UNFROZEN;
 			sb_freeze_unlock(sb, SB_FREEZE_FS);
-			wake_up_var(&sb->s_writers.frozen);
+			wake_up_var_mb(&sb->s_writers.frozen);
 			deactivate_locked_super(sb);
 			return ret;
 		}
@@ -2121,7 +2115,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 	 */
 	WARN_ON_ONCE(freeze_inc(sb, who) > 1);
 	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
-	wake_up_var(&sb->s_writers.frozen);
+	wake_up_var_mb(&sb->s_writers.frozen);
 	lockdep_sb_freeze_release(sb);
 	super_unlock_excl(sb);
 	return 0;
@@ -2150,7 +2144,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
 
 	if (sb_rdonly(sb)) {
 		sb->s_writers.frozen = SB_UNFROZEN;
-		wake_up_var(&sb->s_writers.frozen);
+		wake_up_var_mb(&sb->s_writers.frozen);
 		goto out_deactivate;
 	}
 
@@ -2167,7 +2161,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
 	}
 
 	sb->s_writers.frozen = SB_UNFROZEN;
-	wake_up_var(&sb->s_writers.frozen);
+	wake_up_var_mb(&sb->s_writers.frozen);
 	sb_freeze_unlock(sb, SB_FREEZE_FS);
 out_deactivate:
 	deactivate_locked_super(sb);
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index aa4dbda7b536..84355a859c86 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2137,7 +2137,7 @@ xfs_buf_list_del(
 	struct xfs_buf		*bp)
 {
 	list_del_init(&bp->b_list);
-	wake_up_var(&bp->b_list);
+	wake_up_var_mb(&bp->b_list);
 }
 
 /*
diff --git a/include/linux/mbcache.h b/include/linux/mbcache.h
index 97e64184767d..65cc6bc1baa6 100644
--- a/include/linux/mbcache.h
+++ b/include/linux/mbcache.h
@@ -52,7 +52,7 @@ static inline void mb_cache_entry_put(struct mb_cache *cache,
 
 	if (cnt > 0) {
 		if (cnt <= 2)
-			wake_up_var(&entry->e_refcnt);
+			wake_up_var_relaxed(&entry->e_refcnt);
 		return;
 	}
 	__mb_cache_entry_free(cache, entry);
diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 609c10fcd344..7cdd0ab34f21 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -236,7 +236,7 @@ wait_on_bit_lock_action(unsigned long *word, int bit, wait_bit_action_f *action,
 }
 
 extern void init_wait_var_entry(struct wait_bit_queue_entry *wbq_entry, void *var, int flags);
-extern void wake_up_var(void *var);
+extern void wake_up_var_relaxed(void *var);
 extern wait_queue_head_t *__var_waitqueue(void *p);
 
 #define ___wait_var_event(var, condition, state, exclusive, ret, cmd)	\
@@ -375,12 +375,66 @@ static inline void clear_and_wake_up_bit(int bit, void *word)
 	wake_up_bit(word, bit);
 }
 
+/**
+ * atomic_dec_and_wake_up_var - decrement a counts a wake any waiting on it.
+ *
+ * @var: the atomic_t variable being waited on.
+ *
+ * @var is decremented and if the value reaches zero, any code waiting
+ * in wake_var_event() for the variable will be woken.
+ */
 static inline bool atomic_dec_and_wake_up_var(atomic_t *var)
 {
 	if (!atomic_dec_and_test(var))
 		return false;
-	wake_up_var(var);
+	wake_up_var_relaxed(var);
 	return true;
 }
 
+/**
+ * wake_up_var_mb - wake up all waiters on a var
+ * @var: the address being waited on, a kernel virtual address
+ *
+ * There is a standard hashed waitqueue table for generic use.  This is
+ * the part of the hash-table's accessor API that wakes up waiters on an
+ * address.  For instance, if one were to have waiters on an address one
+ * would call wake_up_var_mb() after non-atomically modifying the
+ * variable
+ *
+ * This interface has a full barrier and so is safe to use anywhere.
+ * It is particular intended for use after the variable has been updated
+ * non-atmomically with simple assignment.  Where the variable is
+ * is updated atomically, the barrier used may be excessively costly.
+ *
+ * Note that it is often appropriate to use smp_store_release() to
+ * update the field in a structure that is being waited on.  This ensures
+ * dependant fields which have previously been set will have the new value
+ * visible by the time the update to the waited-on field is visible.
+ */
+static inline void wake_up_var_mb(void *var)
+{
+	smp_mb();
+	wake_up_var_relaxed(var);
+}
+
+/**
+ * wake_up_var - wake up all waiters on a var
+ * @var: the address being waited on, a kernel virtual address
+ *
+ * There is a standard hashed waitqueue table for generic use. This
+ * is the part of the hash-table's accessor API that wakes up waiters
+ * on a variable. Waiting in wait_var_event() can be worken by this.
+ *
+ * This interface should only be used after the variable has been updated
+ * atomically such as in a locked region which has been unlocked, or by
+ * atomic_set() or xchg() etc.
+ * If the variable has been updated non-atomically then wake_up_var_mb()
+ * should be used.
+ */
+static inline void wake_up_var(void *var)
+{
+	smp_mb__after_atomic();
+	wake_up_var_relaxed(var);
+}
+
 #endif /* _LINUX_WAIT_BIT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index aa3450bdc227..e00be2c7dae7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5451,8 +5451,7 @@ int perf_event_release_kernel(struct perf_event *event)
 			 * ctx while the child_mutex got released above, make sure to
 			 * notify about the preceding put_ctx().
 			 */
-			smp_mb(); /* pairs with wait_var_event() */
-			wake_up_var(var);
+			wake_up_var_mb(var);
 		}
 		goto again;
 	}
@@ -5468,8 +5467,7 @@ int perf_event_release_kernel(struct perf_event *event)
 		 * Wake any perf_event_free_task() waiting for this event to be
 		 * freed.
 		 */
-		smp_mb(); /* pairs with wait_var_event() */
-		wake_up_var(var);
+		wake_up_var_mb(var);
 	}
 
 no_ctx:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f3951e4a55e5..e4054f19bb25 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2898,7 +2898,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	wait_for_completion(&pending->done);
 
 	if (refcount_dec_and_test(&pending->refs))
-		wake_up_var(&pending->refs); /* No UaF, just an address */
+		wake_up_var_relaxed(&pending->refs); /* No UaF, just an address */
 
 	/*
 	 * Block the original owner of &pending until all subsequent callers
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 51d923bf207e..970a7874d785 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -187,11 +187,28 @@ void init_wait_var_entry(struct wait_bit_queue_entry *wbq_entry, void *var, int
 }
 EXPORT_SYMBOL(init_wait_var_entry);
 
-void wake_up_var(void *var)
+/**
+ * wake_up_var_relaxed - wake up all waiters on an address
+ * @word: the address being waited on, a kernel virtual address
+ *
+ * There is a standard hashed waitqueue table for generic use.  This is
+ * the part of the hash-table's accessor API that wakes up waiters on an
+ * address.  For instance, if one were to have waiters on an address one
+ * would call wake_up_bit() after updating a value at, or near, the
+ * address.
+ *
+ * In order for this to function properly, as it uses waitqueue_active()
+ * internally, some kind of memory barrier must be done prior to calling
+ * this. Typically this will be provided implicitly by an atomic function
+ * that returns value such as atomic_dec_return or test_and_clear_bit().
+ * If the bit is cleared without full ordering, an alternate interface
+ * such as wake_up_bit_sync() or wake_up_bit() should be used.
+ */
+void wake_up_var_relaxed(void *var)
 {
 	__wake_up_bit(__var_waitqueue(var), var, -1);
 }
-EXPORT_SYMBOL(wake_up_var);
+EXPORT_SYMBOL(wake_up_var_relaxed);
 
 __sched int bit_wait(struct wait_bit_key *word, int mode)
 {
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 02582017759a..a1f3bc234848 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -749,7 +749,7 @@ EXPORT_SYMBOL(__tasklet_hi_schedule);
 static bool tasklet_clear_sched(struct tasklet_struct *t)
 {
 	if (test_and_clear_bit(TASKLET_STATE_SCHED, &t->state)) {
-		wake_up_var(&t->state);
+		wake_up_var_relaxed(&t->state);
 		return true;
 	}
 
@@ -885,7 +885,6 @@ void tasklet_unlock(struct tasklet_struct *t)
 {
 	smp_mb__before_atomic();
 	clear_bit(TASKLET_STATE_RUN, &t->state);
-	smp_mb__after_atomic();
 	wake_up_var(&t->state);
 }
 EXPORT_SYMBOL_GPL(tasklet_unlock);
diff --git a/mm/memremap.c b/mm/memremap.c
index 40d4547ce514..c04c16230551 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -523,7 +523,7 @@ bool __put_devmap_managed_folio_refs(struct folio *folio, int refs)
 	 * stable because nobody holds a reference on the page.
 	 */
 	if (folio_ref_sub_return(folio, refs) == 1)
-		wake_up_var(&folio->_refcount);
+		wake_up_var_relaxed(&folio->_refcount);
 	return true;
 }
 EXPORT_SYMBOL(__put_devmap_managed_folio_refs);
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 7877a64cc6b8..0c971d64604e 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -82,7 +82,7 @@ static void release_inode(struct landlock_object *const object)
 
 	iput(inode);
 	if (atomic_long_dec_and_test(&landlock_superblock(sb)->inode_refs))
-		wake_up_var(&landlock_superblock(sb)->inode_refs);
+		wake_up_var_relaxed(&landlock_superblock(sb)->inode_refs);
 }
 
 static const struct landlock_object_underops landlock_fs_underops = {
-- 
2.44.0


