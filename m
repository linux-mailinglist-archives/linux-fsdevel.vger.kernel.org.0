Return-Path: <linux-fsdevel+bounces-74709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NJJBBbSb2mgMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:05:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 979344A00A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82B3282DC36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564F345BD5E;
	Tue, 20 Jan 2026 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDx649EN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0608145349B
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934748; cv=none; b=gzi/Jtp1dpSKhiQPsKY2cO212YySvamncnuRo7xfPFxq10P1vdDDTJ52CGKSluZJfLfxPUJGeX/eBVDOB5BuncyW59ZaOBqBJOjDIMmUijg62RzhwnlF8as1GsO0vs6ItfLc0ya0A7hp4ZZGIFq9w0e3NVRbJPozLl6m1gWa9qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934748; c=relaxed/simple;
	bh=GmkD2bpDD1RmZF/vBctcSaU7rAoj2KjBKS6/K+ZOnEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MYs/CiAKRSv/p521CyWJ0eZz0VVXqagvzxP9hpRWhSRLxx7R8anBD++6yhn++ZKzrTSo9KuREhVSGuDL0UFtGtugydgdvZ6jb5SHe5DMbkPGMF20HD2ynKAXqehrb1QUoKSjhqzcu3WQHJV60aesnnMY9KHLSD7vclcXeB6eIlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDx649EN; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b86f69bbe60so895490066b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 10:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768934744; x=1769539544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tnCwlIOyKj3zWftLUKboWMpzvvZ/YNE4NZ10A6cUY+0=;
        b=FDx649ENdP7GKyZTFn33kaajjS4A87xkHi00aXSUSm/RO4y5g2iPsyrxdU3YbvUH1L
         IGS6oHQRG/C16+ZrfZIDBw3l7e6sm3KWk8JBckEAjHE1PINxvL7OAeL//zqQj7JTBFLy
         Io2SOHqhQQIEGTZCsuEktKtkjZa/QidXCcJ1XaqBeMMG/f3CxJ7UuwvA7kRlZLeSTFZS
         hwAdpIpeoquD7XXIFdW0StLMwCPowaqoetbYLQa78J3k51UYPT5OhWIcXVcRNg74su5b
         FxzsBHxhYIdHDNja0uffQJ6Y/b+ATqGKz/wjgTWA0qWKEpfh9fKJwhj/k8svjRyuW7/P
         +PrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768934744; x=1769539544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnCwlIOyKj3zWftLUKboWMpzvvZ/YNE4NZ10A6cUY+0=;
        b=A6GPYXJULWGBtpqShx21Ji3uD1Yj6M7NNNJHZEKIZ9ICqInFnxGNYXElIRZPAdEc6u
         8ypYNAavF1I+/wVTgB35KYEcn3/VRAutf49NXXRiGPL/hf7c14G/zdjq+dm05IhYFg3M
         CzhH/NEMGU9wjYCLbmrXtvNH1YligPXTJrWGGG4KXg0E44SX9n6qkP76veXqn2DKj7Ya
         LZOsL/tM66+jRxBHX/TzqL/sIIKxYPczYWZiP/9ViUkKQWR5hEKGOKj9PY5qNjuLin9Y
         V2pW8YNyHXxjJKnnhhEulm/nI3bCWV0mxYVv+zuMVk+WnRUxkA7houDWheRK41RDn1YT
         nCIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcXaYz/tJY5fXwHeKyLuFFtguHDZHVxgvIdfw8CE/K/uD5tWlsf0HvOiKsEyoKXnmRhFG/dY3oHpumvb++@vger.kernel.org
X-Gm-Message-State: AOJu0YzrWunbIwhbK0p7akPPm1+4bNa+mYMiJtm/frPDUHGPGKMmP1X/
	ELaq/FD7YHPVfAN1TjHRq+VahmX8EwfdpJgNmMTpNH2TKBwCpkfSqAPf
X-Gm-Gg: AZuq6aJ2Ehjuf7gIdeOq+fKSWy3Tty2TtVdERM6/DyreFTgP9bLy02c4dxAldPQ6FIl
	dZgvvmnXEFwNDDJkc4ILWunGqzn6aBELWTHRxcEIFpeio8dNjRmMxl2X7vNFiHJAKaRkyhA2gWN
	G9BD8nQvCFxjBYnDu3vFTT3F9rAjvqPOLRko5cy2cGmYRQnjzueNPRhlb9ZHLhJdB6g2VY5WvcT
	O5Meg5sF37uRk4j3CkmQst6ygHpakv4EbLr0Ul84LJc+hukmacd+IgUPjjAsKzqULSDbbF/DKGP
	N2PtAgtHu0Pa547FpPcHZO6YlaWvzUhjHK+5VNOFse3j+n2FRXK+VV+487BQsoJR/4PIm8yWECB
	rqYPQxKo5Kej6Y+D8k/kKC9lDPBpZu4SmC1JkvJE8J/RYTiH0zX5lO370SGie6K6khkdWJoBC7y
	7fBkLxOAcA9qgZdG5ER+VbT6K01cDToiKoG1YZ5m8Gv2kV/BEki3Su2CaYWI0VXQ==
X-Received: by 2002:a17:907:c19:b0:b87:1741:a494 with SMTP id a640c23a62f3a-b87968f5a60mr1169454666b.17.1768934743861;
        Tue, 20 Jan 2026 10:45:43 -0800 (PST)
Received: from f.. (cst-prg-85-136.cust.vodafone.cz. [46.135.85.136])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658029e060asm2016399a12.21.2026.01.20.10.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:45:43 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] pidfs: implement ino allocation without the pidmap lock
Date: Tue, 20 Jan 2026 19:45:39 +0100
Message-ID: <20260120184539.1480930-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-74709-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,suse.cz,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 979344A00A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This paves the way for scalable PID allocation later.

The 32 bit variant merely takes a spinlock for simplicity, the 64 bit
variant uses a scalable scheme.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

this patch assumes the rb -> rhashtable conversion landed

i booted the 32 bit code on the 64 bit kernel, i take it its fine

I'm slightly worried about error handling. It seems pid->pidfs_hash.next
= NULL is supposed to sort it out.

Given that ino of 0 is not legal, I think it should be used as a
sentinel value for presence in the table instead.

so something like:

alloc_pid:
pid->ino = 0;
....

then:

void pidfs_remove_pid(struct pid *pid)
{
        if (unlikely(!pid->ino))
                return;
        rhashtable_remove_fast(&pidfs_ino_ht, &pid->pidfs_hash,
                               pidfs_ino_ht_params);
}

 fs/pidfs.c   | 107 +++++++++++++++++++++++++++++++++++----------------
 kernel/pid.c |   3 +-
 2 files changed, 74 insertions(+), 36 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 3da5e8e0a76b..46b46a484d45 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -65,7 +65,39 @@ static const struct rhashtable_params pidfs_ino_ht_params = {
 	.automatic_shrinking	= true,
 };
 
+/*
+ * inode number handling
+ *
+ * On 64 bit nothing special happens. The 64bit number assigned
+ * to struct pid is the inode number.
+ *
+ * On 32 bit the 64 bit number assigned to struct pid is split
+ * into two 32 bit numbers. The lower 32 bits are used as the
+ * inode number and the upper 32 bits are used as the inode
+ * generation number.
+ *
+ * On 32 bit pidfs_ino() will return the lower 32 bit. When
+ * pidfs_ino() returns zero a wrap around happened. When a
+ * wraparound happens the 64 bit number will be incremented by 2
+ * so inode numbering starts at 2 again.
+ *
+ * On 64 bit comparing two pidfds is as simple as comparing
+ * inode numbers.
+ *
+ * When a wraparound happens on 32 bit multiple pidfds with the
+ * same inode number are likely to exist (This isn't a problem
+ * since before pidfs pidfds used the anonymous inode meaning
+ * all pidfds had the same inode number.). Userspace can
+ * reconstruct the 64 bit identifier by retrieving both the
+ * inode number and the inode generation number to compare or
+ * use file handles.
+ */
+
 #if BITS_PER_LONG == 32
+
+DEFINE_SPINLOCK(pidfs_ino_lock);
+static u64 pidfs_ino_nr = 2;
+
 static inline unsigned long pidfs_ino(u64 ino)
 {
 	return lower_32_bits(ino);
@@ -77,6 +109,18 @@ static inline u32 pidfs_gen(u64 ino)
 	return upper_32_bits(ino);
 }
 
+static inline u64 pidfs_alloc_ino(void)
+{
+	u64 ino;
+
+	spin_lock(&pidfs_ino_lock);
+	if (pidfs_ino(pidfs_ino_nr) == 0)
+		pidfs_ino_nr += 2;
+	ino = pidfs_ino_nr++;
+	spin_unlock(&pidfs_ino_lock);
+	return ino;
+}
+
 #else
 
 /* On 64 bit simply return ino. */
@@ -90,53 +134,48 @@ static inline u32 pidfs_gen(u64 ino)
 {
 	return 0;
 }
-#endif
 
 /*
- * Allocate inode number and initialize pidfs fields.
- * Called with pidmap_lock held.
+ * A patched up copy of get_next_ino(). Uses 64 bit, does not do overflow checks
+ * and guarantees ino of at least 2.
  */
-void pidfs_prepare_pid(struct pid *pid)
+#define LAST_INO_BATCH 1024
+static DEFINE_PER_CPU(u64, pidfs_last_ino);
+
+static u64 pidfs_alloc_ino(void)
 {
-	static u64 pidfs_ino_nr = 2;
+	u64 *p = &get_cpu_var(pidfs_last_ino);
+	u64 res = *p;
+
+#ifdef CONFIG_SMP
+	if (unlikely((res & (LAST_INO_BATCH-1)) == 0)) {
+		static atomic64_t pidfs_shared_last_ino = ATOMIC_INIT(2);
+		u64 next = atomic64_add_return(LAST_INO_BATCH, &pidfs_shared_last_ino);
+		res = next - LAST_INO_BATCH;
+	}
+#endif
 
-	/*
-	 * On 64 bit nothing special happens. The 64bit number assigned
-	 * to struct pid is the inode number.
-	 *
-	 * On 32 bit the 64 bit number assigned to struct pid is split
-	 * into two 32 bit numbers. The lower 32 bits are used as the
-	 * inode number and the upper 32 bits are used as the inode
-	 * generation number.
-	 *
-	 * On 32 bit pidfs_ino() will return the lower 32 bit. When
-	 * pidfs_ino() returns zero a wrap around happened. When a
-	 * wraparound happens the 64 bit number will be incremented by 2
-	 * so inode numbering starts at 2 again.
-	 *
-	 * On 64 bit comparing two pidfds is as simple as comparing
-	 * inode numbers.
-	 *
-	 * When a wraparound happens on 32 bit multiple pidfds with the
-	 * same inode number are likely to exist (This isn't a problem
-	 * since before pidfs pidfds used the anonymous inode meaning
-	 * all pidfds had the same inode number.). Userspace can
-	 * reconstruct the 64 bit identifier by retrieving both the
-	 * inode number and the inode generation number to compare or
-	 * use file handles.
-	 */
-	if (pidfs_ino(pidfs_ino_nr) == 0)
-		pidfs_ino_nr += 2;
+	res++;
+	*p = res;
+	put_cpu_var(pidfs_last_ino);
+	return res;
+}
+
+#endif
 
-	pid->ino = pidfs_ino_nr;
+/*
+ * Initialize pidfs fields.
+ */
+void pidfs_prepare_pid(struct pid *pid)
+{
 	pid->pidfs_hash.next = NULL;
 	pid->stashed = NULL;
 	pid->attr = NULL;
-	pidfs_ino_nr++;
 }
 
 int pidfs_add_pid(struct pid *pid)
 {
+	pid->ino = pidfs_alloc_ino();
 	return rhashtable_insert_fast(&pidfs_ino_ht, &pid->pidfs_hash,
 				      pidfs_ino_ht_params);
 }
diff --git a/kernel/pid.c b/kernel/pid.c
index 06356e40ac00..72c9372b84b8 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -198,6 +198,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
 		INIT_HLIST_HEAD(&pid->tasks[type]);
 	init_waitqueue_head(&pid->wait_pidfd);
 	INIT_HLIST_HEAD(&pid->inodes);
+	pidfs_prepare_pid(pid);
 
 	/*
 	 * 2. perm check checkpoint_restore_ns_capable()
@@ -314,8 +315,6 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
 	retval = -ENOMEM;
 	if (unlikely(!(ns->pid_allocated & PIDNS_ADDING)))
 		goto out_free;
-	pidfs_prepare_pid(pid);
-
 	for (upid = pid->numbers + ns->level; upid >= pid->numbers; --upid) {
 		/* Make the PID visible to find_pid_ns. */
 		idr_replace(&upid->ns->idr, pid, upid->nr);
-- 
2.48.1


