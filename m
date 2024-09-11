Return-Path: <linux-fsdevel+bounces-29093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BCF9752FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 14:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EE9EB23F4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 12:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3179218F2DF;
	Wed, 11 Sep 2024 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRKVGxEA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F08E78C91;
	Wed, 11 Sep 2024 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059443; cv=none; b=FelRiLPswb5wH4aHVo/5hddYxRpRaMhiHNaUNrBNPI+eFWIdDLxjcWaQ3L0qMl/ais9rikvSDHYKELHvEooss+Bmb98r4wiM69cwl8h1Bpaoq35xfTw/sxjNYUA3YN1cH7PiSHWbDfQ9E201rZhJX5taE5a1ZAKjiwK0AUzJ7fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059443; c=relaxed/simple;
	bh=2uYErux0xJpA/1T0iGbYw7XfHtCwaGO7/nNTe1OkPJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=otQ8X35+QbXMeP+vs1XSt639YG1iP+Us6kxkMvubeEchHezOrHz4ysLv2ZYhqvuFTyktQthuFgGag9jDz3Yq+lrQlH6eCX8F030fSjXaEym/XJiqycg8H8x51cCbv9H3c1s40Y/AF5eFb2YsMZ2ptEO1t/9+hBvFfrOtcUjD+3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRKVGxEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390ADC4CEC5;
	Wed, 11 Sep 2024 12:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726059443;
	bh=2uYErux0xJpA/1T0iGbYw7XfHtCwaGO7/nNTe1OkPJA=;
	h=From:Date:Subject:To:Cc:From;
	b=pRKVGxEAptXyU3NeSVIpmAyz+xD8R3IPS+7KC5UMLdMHj2Xl3kABfKNbbwYCNYBwB
	 4NhrUge5eV9zgVohPJyZYmA58Un2MKaS7mxcquU9VqaF8JNrrFcwP5boAFKHFN0EUS
	 SFdCBNEfb/oAywh2gQ1TfCEL/0EweCGOjK35+X9exgkBjqpblEjoARI/QNw/cSw5Z8
	 gZBdHg3juQumpwdEQW450oKm0m30jfdac2BoHl8yueEXqjjILYr1O2VoZoZcnt1CDL
	 fv+4Yzb47skmceF0ybQYv5QINiaiIbCefbo3uC2xw5/dMhlDB/v0SrFAqOlGFaYNkd
	 EYVeroRQctRFw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 11 Sep 2024 08:56:56 -0400
Subject: [PATCH] timekeeping: move multigrain ctime floor handling into
 timekeeper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-mgtime-v1-1-e4aedf1d0d15@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJeT4WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0MD3dz0kszcVN1UIxMTAxPLNKPE1EQloOKCotS0zAqwQdGxtbUAhnV
 0f1gAAAA=
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7291; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=2uYErux0xJpA/1T0iGbYw7XfHtCwaGO7/nNTe1OkPJA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm4ZOsii7eT3QY1Kwg7pBG9oAl1KmNlaliybRt2
 a9wvDkJrdSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuGTrAAKCRAADmhBGVaC
 FSh0EADMqI1KyXmZKYUO9IzGj3z5bKS2dZwn9V1wRQj2hQ3h7ISxen8D8yc5pVZ/soM6HrSfHdA
 hTqpFLwPNuRNXuCg7wjlUyWZsPCfOgb0Yfw9kyqr7ZdYRA6YsnWXTvhlvO7Ngq66f5W8DoT0j5o
 1tcQdZSxmlIxQhjMJAfigMgrqEtAzvrb2fn88JGCv7kvbeEUizGl2TYAmSn3CdMcedVWQH4rjAD
 Ug58F1CGBSlwdv5Fc9iu15LYnL7Kld46gSJWwhqSTwPttWsO0e5X5X70pBNbx+pC82/VhCl9mW1
 NOXQs6xwEdNyenRc+knq2ShGm6qndxagR8QK9SqFV59Wchdwb2yxwx+shfxlgR8tvj2LTNeF/3K
 IF4SmXHu5RiKM16NR9GdhZjLgAsnim+POwT4ZWHOPkmS7flPkVsoekHq/uj8wzEFqccrA254bGq
 EUg6ONhq5dBQSA0QN56Gtjftt+yHcd0CZiCHDRNJOMsAbm14A1DNaHGXPoqDMMtAzQMVNeYsJbP
 fd7rR5fJmQnq5//QvSE7gec1Zk29Gd80L3nC991J1CJZkNNx0we2YHEdjVbtP+tydyEc3rcQZ4z
 +OHZzJlo0l++4S5CVtleqpjQuhkTkEIXTODo1Wg/slCypT/Njlj4ZUqTV/enYueW9Z/z1ExYe+i
 TGjyhZ3J3NML93A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The kernel test robot reported a performance regression in some
will-it-scale tests due to the multigrain timestamp patches. The data
showed that coarse_ctime() was slowing down current_time(), which is
called frequently in the I/O path.

Add ktime_get_coarse_real_ts64_with_floor(), which returns either the
coarse time or the floor as a realtime value. This avoids some of the
conversion overhead of coarse_ctime(), and recovers some of the
performance in these tests.

The will-it-scale pipe1_threads microbenchmark shows these averages on
my test rig:

	v6.11-rc7:			83830660 (baseline)
	v6.11-rc7 + mgtime series:	77631748 (93% of baseline)
	v6.11-rc7 + mgtime + this:	81620228 (97% of baseline)

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202409091303.31b2b713-oliver.sang@intel.com
Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Arnd suggested moving this into the timekeeper when reviewing an earlier
version of this series, and that turns out to be better for performance.

I'm not sure how this should go in (if acceptable). The multigrain
timestamp patches that this would affect are in Christian's tree, so
that may be best if the timekeeper maintainers are OK with this
approach.
---
 fs/inode.c                  | 35 +++++++++--------------------------
 include/linux/timekeeping.h |  2 ++
 kernel/time/timekeeping.c   | 29 +++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 01f7df1973bd..47679a054472 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2255,25 +2255,6 @@ int file_remove_privs(struct file *file)
 }
 EXPORT_SYMBOL(file_remove_privs);
 
-/**
- * coarse_ctime - return the current coarse-grained time
- * @floor: current (monotonic) ctime_floor value
- *
- * Get the coarse-grained time, and then determine whether to
- * return it or the current floor value. Returns the later of the
- * floor and coarse grained timestamps, converted to realtime
- * clock value.
- */
-static ktime_t coarse_ctime(ktime_t floor)
-{
-	ktime_t coarse = ktime_get_coarse();
-
-	/* If coarse time is already newer, return that */
-	if (!ktime_after(floor, coarse))
-		return ktime_get_coarse_real();
-	return ktime_mono_to_real(floor);
-}
-
 /**
  * current_time - Return FS time (possibly fine-grained)
  * @inode: inode.
@@ -2285,10 +2266,10 @@ static ktime_t coarse_ctime(ktime_t floor)
 struct timespec64 current_time(struct inode *inode)
 {
 	ktime_t floor = atomic64_read(&ctime_floor);
-	ktime_t now = coarse_ctime(floor);
-	struct timespec64 now_ts = ktime_to_timespec64(now);
+	struct timespec64 now_ts;
 	u32 cns;
 
+	ktime_get_coarse_real_ts64_with_floor(&now_ts, floor);
 	if (!is_mgtime(inode))
 		goto out;
 
@@ -2745,7 +2726,7 @@ EXPORT_SYMBOL(timestamp_truncate);
  *
  * Set the inode's ctime to the current value for the inode. Returns the
  * current value that was assigned. If this is not a multigrain inode, then we
- * just set it to whatever the coarse_ctime is.
+ * set it to the later of the coarse time and floor value.
  *
  * If it is multigrain, then we first see if the coarse-grained timestamp is
  * distinct from what we have. If so, then we'll just use that. If we have to
@@ -2756,15 +2737,15 @@ EXPORT_SYMBOL(timestamp_truncate);
  */
 struct timespec64 inode_set_ctime_current(struct inode *inode)
 {
-	ktime_t now, floor = atomic64_read(&ctime_floor);
+	ktime_t floor = atomic64_read(&ctime_floor);
 	struct timespec64 now_ts;
 	u32 cns, cur;
 
-	now = coarse_ctime(floor);
+	ktime_get_coarse_real_ts64_with_floor(&now_ts, floor);
 
 	/* Just return that if this is not a multigrain fs */
 	if (!is_mgtime(inode)) {
-		now_ts = timestamp_truncate(ktime_to_timespec64(now), inode);
+		now_ts = timestamp_truncate(now_ts, inode);
 		inode_set_ctime_to_ts(inode, now_ts);
 		goto out;
 	}
@@ -2777,6 +2758,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 	cns = smp_load_acquire(&inode->i_ctime_nsec);
 	if (cns & I_CTIME_QUERIED) {
 		ktime_t ctime = ktime_set(inode->i_ctime_sec, cns & ~I_CTIME_QUERIED);
+		ktime_t now = timespec64_to_ktime(now_ts);
 
 		if (!ktime_after(now, ctime)) {
 			ktime_t old, fine;
@@ -2797,10 +2779,11 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 			else
 				fine = old;
 			now = ktime_mono_to_real(fine);
+			now_ts = ktime_to_timespec64(now);
 		}
 	}
 	mgtime_counter_inc(mg_ctime_updates);
-	now_ts = timestamp_truncate(ktime_to_timespec64(now), inode);
+	now_ts = timestamp_truncate(now_ts, inode);
 	cur = cns;
 
 	/* No need to cmpxchg if it's exactly the same */
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index fc12a9ba2c88..9b3c957ab260 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -44,6 +44,7 @@ extern void ktime_get_ts64(struct timespec64 *ts);
 extern void ktime_get_real_ts64(struct timespec64 *tv);
 extern void ktime_get_coarse_ts64(struct timespec64 *ts);
 extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
+extern void ktime_get_coarse_real_ts64_with_floor(struct timespec64 *ts, ktime_t floor);
 
 void getboottime64(struct timespec64 *ts);
 
@@ -68,6 +69,7 @@ enum tk_offsets {
 extern ktime_t ktime_get(void);
 extern ktime_t ktime_get_with_offset(enum tk_offsets offs);
 extern ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs);
+extern ktime_t ktime_get_coarse_with_floor_and_offset(enum tk_offsets offs, ktime_t floor);
 extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
 extern ktime_t ktime_get_raw(void);
 extern u32 ktime_get_resolution_ns(void);
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5391e4167d60..56b979471c6a 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2394,6 +2394,35 @@ void ktime_get_coarse_real_ts64(struct timespec64 *ts)
 }
 EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
 
+/**
+ * ktime_get_coarse_real_ts64_with_floor - get later of coarse grained time or floor
+ * @ts: timespec64 to be filled
+ * @floor: monotonic floor value
+ *
+ * Adjust @floor to realtime and compare that to the coarse time. Fill
+ * @ts with the later of the two.
+ */
+void ktime_get_coarse_real_ts64_with_floor(struct timespec64 *ts, ktime_t floor)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	unsigned int seq;
+	ktime_t f_real, offset, coarse;
+
+	WARN_ON(timekeeping_suspended);
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		*ts = tk_xtime(tk);
+		offset = *offsets[TK_OFFS_REAL];
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	coarse = timespec64_to_ktime(*ts);
+	f_real = ktime_add(floor, offset);
+	if (ktime_after(f_real, coarse))
+		*ts = ktime_to_timespec64(f_real);
+}
+EXPORT_SYMBOL_GPL(ktime_get_coarse_real_ts64_with_floor);
+
 void ktime_get_coarse_ts64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;

---
base-commit: 962e66693d6214b1d48f32f68ed002170a98f2c0
change-id: 20240910-mgtime-e244049f2aea

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


