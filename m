Return-Path: <linux-fsdevel+bounces-75270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBqfJVlkc2mivQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:06:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA1A758B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C15B73024194
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7D0310777;
	Fri, 23 Jan 2026 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHJsr1pY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13382D0605;
	Fri, 23 Jan 2026 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170002; cv=none; b=F58BjS+4yKxhwBvvGw9m01vvWEOKV82okJm9ki2/ZwD2HTHbodbPz+rmZO+X8VPvtwJ61Tq1crJsRgBi1UPh/l7/fkwPkPINeAM6RGRQWS1EXgPRH2xzH2T4DPb8EuHcHS+mRu+jmhQLTaBV6Uc9RBLwV/xvYSFo5C3EJrrsPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170002; c=relaxed/simple;
	bh=VB+Ve9b28+fVttCUEDRsY+ZD5+7XwSHytjU4rD/FQ6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csUK7e4GOB8fVLoRLPvxzAjyLiZpnDfOp/IXzVCTNVMWlSd3YT2GI+Gp8iG+1p6V+JaSNUPiU17+4up70MdLdP2GweoyibzREkmTxLAaHqIlHN7E6ul9rVI5n2p6Br6HbVqadNkBhnbkcxAPoAClIguObazSHTfTu71bY+X/cpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHJsr1pY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E70C4CEF1;
	Fri, 23 Jan 2026 12:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769170001;
	bh=VB+Ve9b28+fVttCUEDRsY+ZD5+7XwSHytjU4rD/FQ6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jHJsr1pYfVHUOtjepve8m2Kk+xT1gto4p/BsZKWT3toAkcWnXMkcahovQoQEiP3GQ
	 7AGGOJMzSotRVcL82qLGH/yejLyH5xgtieN2GPAJ6+4AHQPM57cqRRSJyhtIY9mQzu
	 0pqhcJHhdHU1RuuIvvQ5dRuJkqenlvmBCCnrFaRZV7MHKDFoLJaXi+3rEKm0wrsGnv
	 TbdZh9802RVA9XFfd+zHLBVoUhC1+iUlaAW7VFE0GaY5zASAIuqJBQMxYwceWkc4zh
	 5u76ExubA7S6LsQHNrewXRGj6QVRfc/ueauBaCsp0AY796+MZ55Iu8EZmeaWpr0UTM
	 pWwQT4NQZbX5w==
Date: Fri, 23 Jan 2026 13:06:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] pidfs: implement ino allocation without the pidmap lock
Message-ID: <20260123-entledigen-kippt-045f9e533397@brauner>
References: <20260120184539.1480930-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260120184539.1480930-1-mjguzik@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-75270-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 0EA1A758B3
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 07:45:39PM +0100, Mateusz Guzik wrote:
> This paves the way for scalable PID allocation later.
> 
> The 32 bit variant merely takes a spinlock for simplicity, the 64 bit
> variant uses a scalable scheme.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> this patch assumes the rb -> rhashtable conversion landed
> 
> i booted the 32 bit code on the 64 bit kernel, i take it its fine
> 
> I'm slightly worried about error handling. It seems pid->pidfs_hash.next
> = NULL is supposed to sort it out.

r
> 
> Given that ino of 0 is not legal, I think it should be used as a
> sentinel value for presence in the table instead.
> 
> so something like:
> 
> alloc_pid:
> pid->ino = 0;
> ....
> 
> then:
> 
> void pidfs_remove_pid(struct pid *pid)
> {
>         if (unlikely(!pid->ino))
>                 return;
>         rhashtable_remove_fast(&pidfs_ino_ht, &pid->pidfs_hash,
>                                pidfs_ino_ht_params);
> }

All fine, but we should probably just use DEFINE_COOKIE() and accept
that numbering starts at 1 for 64-bit. Does the below look good to you
too?

From aaaa5cbb6e6920854aaee0ed59382d71614e785e Mon Sep 17 00:00:00 2001
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 20 Jan 2026 19:45:39 +0100
Subject: [PATCH] pidfs: implement ino allocation without the pidmap lock

This paves the way for scalable PID allocation later.

The 32 bit variant merely takes a spinlock for simplicity, the 64 bit
variant uses a scalable scheme.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
Link: https://patch.msgid.link/20260120184539.1480930-1-mjguzik@gmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c   | 115 ++++++++++++++++++++++++++++++++++-----------------
 kernel/pid.c |   3 +-
 2 files changed, 78 insertions(+), 40 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index ee0e36dd29d2..3e7e7bdda780 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -23,6 +23,7 @@
 #include <linux/coredump.h>
 #include <linux/rhashtable.h>
 #include <linux/xattr.h>
+#include <linux/cookie.h>
 
 #include "internal.h"
 #include "mount.h"
@@ -65,7 +66,39 @@ static const struct rhashtable_params pidfs_ino_ht_params = {
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
@@ -77,6 +110,18 @@ static inline u32 pidfs_gen(u64 ino)
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
@@ -90,61 +135,55 @@ static inline u32 pidfs_gen(u64 ino)
 {
 	return 0;
 }
+
+DEFINE_COOKIE(pidfs_ino_cookie);
+
+static u64 pidfs_alloc_ino(void)
+{
+	u64 ino;
+
+	preempt_disable();
+	ino = gen_cookie_next(&pidfs_ino_cookie);
+	preempt_enable();
+
+	VFS_WARN_ON_ONCE(ino < 1);
+	return ino;
+}
+
 #endif
 
 /*
- * Allocate inode number and initialize pidfs fields.
- * Called with pidmap_lock held.
+ * Initialize pidfs fields.
  */
 void pidfs_prepare_pid(struct pid *pid)
 {
-	static u64 pidfs_ino_nr = 2;
-
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
-
-	pid->ino = pidfs_ino_nr;
 	pid->pidfs_hash.next = NULL;
 	pid->stashed = NULL;
 	pid->attr = NULL;
-	pidfs_ino_nr++;
 }
 
 int pidfs_add_pid(struct pid *pid)
 {
-	return rhashtable_insert_fast(&pidfs_ino_ht, &pid->pidfs_hash,
-				      pidfs_ino_ht_params);
+	int ret;
+
+	pid->ino = pidfs_alloc_ino();
+	ret = rhashtable_insert_fast(&pidfs_ino_ht, &pid->pidfs_hash,
+				     pidfs_ino_ht_params);
+	/*
+	 * This is fine. The pid will not have a task attached to it so
+	 * no pidfd can be created for it. So we can unset the inode
+	 * number.
+	 */
+	if (unlikely(ret))
+		pid->ino = 0;
+	return ret;
 }
 
 void pidfs_remove_pid(struct pid *pid)
 {
-	rhashtable_remove_fast(&pidfs_ino_ht, &pid->pidfs_hash,
-			       pidfs_ino_ht_params);
+	if (likely(pid->ino))
+		rhashtable_remove_fast(&pidfs_ino_ht, &pid->pidfs_hash,
+				       pidfs_ino_ht_params);
 }
 
 void pidfs_free_pid(struct pid *pid)
diff --git a/kernel/pid.c b/kernel/pid.c
index 6077da774652..dfa545a97c00 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -198,6 +198,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
 		INIT_HLIST_HEAD(&pid->tasks[type]);
 	init_waitqueue_head(&pid->wait_pidfd);
 	INIT_HLIST_HEAD(&pid->inodes);
+	pidfs_prepare_pid(pid);
 
 	/*
 	 * 2. perm check checkpoint_restore_ns_capable()
@@ -313,8 +314,6 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
 	retval = -ENOMEM;
 	if (unlikely(!(ns->pid_allocated & PIDNS_ADDING)))
 		goto out_free;
-	pidfs_prepare_pid(pid);
-
 	for (upid = pid->numbers + ns->level; upid >= pid->numbers; --upid) {
 		/* Make the PID visible to find_pid_ns. */
 		idr_replace(&upid->ns->idr, pid, upid->nr);
-- 
2.47.3


