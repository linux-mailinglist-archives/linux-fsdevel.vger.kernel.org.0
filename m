Return-Path: <linux-fsdevel+bounces-8737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3F683A90A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D265B29DDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D719679FE;
	Wed, 24 Jan 2024 12:00:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B89651B4;
	Wed, 24 Jan 2024 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097613; cv=none; b=nzP06r1SMvG9N3s2bN4pW7E/IV5DR2W6uVDdqTqgyXwo/Z1RL4QOVCsYJ07X2c9KH1CtcWPv0TC7vwH4eZZM2kkRnzv3pM7ZBfu9zeqp10rOaC8GX4xgu3/gUNFOPof4flwB3snioY2tlsM5vSYXPZfjBLoFRJrhcE67feWS5b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097613; c=relaxed/simple;
	bh=TSPxdh3H9mjhA/wDLLlJUz6YZTY7hYg5ulgpaHBJJSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rOIsM/71uUjetYmoCoQKnWY2JxuXZQnf0JkZA8WpsiPMxkmffANMf+veXKOc7FZcRDkuXIBk/DeAK4JHn7d5HKbmiiIpxVf3LgYHUHpzbLTvffT/4UkBtIAvuFm/nbrWmBI0KT8rQQ7f90wT1CpPGGYODXz8FE0/AKLmMnKTkiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-55-65b0fbb68577
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	42.hyeyoo@gmail.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	hdanton@sina.com,
	her0gyugyu@gmail.com
Subject: [PATCH v11 17/26] dept: Apply timeout consideration to wait_for_completion()/complete()
Date: Wed, 24 Jan 2024 20:59:28 +0900
Message-Id: <20240124115938.80132-18-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124115938.80132-1-byungchul@sk.com>
References: <20240124115938.80132-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0zMcRjH+3y+P+84++4wX8VwkywrP+bH48eMjfmOhY2/+EM3fem4O+2i
	kw3h9EslbTmltbrs3K5LdWdz6JJrlTQ5aSRJP25I5TiuyeVHhX+evfZ+nue154+HJeT3qVBW
	pT0u6rRKtYKWktLhqaVRd4JV4rL+B1K4krUMAt/SSSiqtNHguVWOwHb7HIaBhm3wcmQIQfDJ
	UwKM+R4Epb1vCLjd2I3AZTlPw3PvNGgP+Ghozr9Ew4WyShqeDY5h6Lqah6HcHgMtuSYMdaPv
	STAO0HDdeAGPlw8YRs1WBswp4dBnKWRgrHc5NHe/oMDVuQQKirtoqHE1k9Do7MPw/F4RDd22
	3xS0ND4iwXMlm4KKTyYaBkfMBJgDPgba6kowVBnGRalff1HQlF2HIfVGNYb2V/cR1Kb3YLDb
	XtBQHxjC4LDnE/DjZgOCvpxhBi5mjTJw/VwOgksXr5Lw9GcTBYauVRD8XkRvWifUD/kIweDQ
	C66RElJ4bOKFu4VvGMFQ28kIJfYTgsMSKZTVDGCh1B+gBLs1gxbs/jxGyBxux8Kn1lZGeHQt
	SArediPeHbZPuiFOVKuSRN3SjbHSeFtbAZNQLD3pyHiGU1APm4kkLM+t5D3eeuY/l3ls9ATT
	XATf0TFKTPAMbj7vyH5HZSIpS3BpU3jL5yeTQ9O5WL6h3jnJJBfO56S6Jhdk3Gq+9ss99Fc6
	jy+vqpvMJeN5RUEnOcFybhXfY73MTEh5Lk3C15x3/rtiNv/Q0kHmIlkJCrEiuUqbpFGq1Cuj
	45O1qpPRB49p7Gj8pcynx/Y7kd+zx404FimmyjZZK0U5pUxKTNa4Ec8Sihmyjtm3RLksTpl8
	StQdO6A7oRYT3SiMJRWzZCtG9HFy7rDyuHhUFBNE3f8uZiWhKSjC9H14occZsyCkf592h+lL
	cZHPOXAmqikrc9fcvRnFeWuJCM3O8tiWiN2a0hC3aM+W6Be36fsPtXpkwZictu3Rg/5XRxcs
	jhzqPeXzZq3P4Mb6mDW1izaHu9+Gna2o3p+eoJ97JNebOsc80+A3Vn+8MceyV701qnNPaHTh
	lrTX6xVkYrxyeSShS1T+AVmDrvVOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+//P1dXitKxOFpgjKYzKKOOt7PKh8iAkEYTQ1ZGHXF6SLTWL
	aOa0WmkqqVkaXmKNubxsItOcDZemSWU5zERFzS6SaRc3MjVToy8PP57nfZ9PD0vICigvVhlz
	TlTFKKLktISUhOxIXl89USH6ZzX7Q+ZNf3CNXSMhv9xEQ1tZKQJTVRKGocYgeOseRjDx4hUB
	udltCIr6ewioaupFYDNcoaF9cCE4XaM0tGTfoCG5pJyG118mMXTnZGEoNR+A1oxiDPbxTyTk
	DtFwLzcZz8hnDON6IwN6jS8MGO4yMNm/CVp6OyhwFLRQYOtaB3n3u2mos7WQ0GQdwNBem09D
	r2magtamZhLaMtMoeDRSTMMXt54AvWuUgTf2QgwV2pm21J9/KHiWZseQ+qASg/PdYwT11/ow
	mE0dNDhcwxgs5mwCfj9sRDCQ/pWBlJvjDNxLSkdwIyWHhFdTzyjQdgfAxK98es8OwTE8Sgha
	S4JgcxeSwvNiXqi528MI2vouRig0xwkWg59QUjeEhaIfLkowG6/TgvlHFiPovjqxMPLyJSM0
	35kghUFnLj648ogkMFyMUsaLqo27wiQRpjd5TOx9yXnL9ddYg/pYHfJgeW4LX9JmomeZ5tbw
	nZ3jxCx7cqt4S9pHSockLMFdnc8bvr2YO1rMhfGNDusck5wvn55qm3uQclv5+u+16F+pN19a
	YZ/zPWb8R3ld5CzLuAC+z3iLyUCSQjTPiDyVMfHRCmVUwAZ1ZERijPL8hlNno81oZjT6S5OZ
	VjTWHtSAOBbJF0j3GMtFGaWIVydGNyCeJeSe0s7lZaJMGq5IvCCqzp5UxUWJ6ga0giXly6TB
	oWKYjDutOCdGimKsqPqfYtbDS4OarEuTccK+xuDProt47+/NzvbF07EjdzqO9aqf9CcssYeX
	H9B8uLzIe9vHnsDK4E9TPkWJfiFO9swJc3Z1RqxV0xPk3r19dYHWc3tHfPplnUGj2/nU2/jO
	58np/Vyg44yx7P38iLUeu46GHr6U4u0TrL7t7g6Zd9x6YXNWzqGawOm9clIdodjkR6jUir/I
	npxQMAMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to wait_for_completion()/complete().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/completion.h | 4 ++--
 kernel/sched/completion.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index bd2c207481d6..3200b741de28 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -41,9 +41,9 @@ do {							\
  */
 #define init_completion_map(x, m) init_completion(x)
 
-static inline void complete_acquire(struct completion *x)
+static inline void complete_acquire(struct completion *x, long timeout)
 {
-	sdt_might_sleep_start(&x->dmap);
+	sdt_might_sleep_start_timeout(&x->dmap, timeout);
 }
 
 static inline void complete_release(struct completion *x)
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 3561ab533dd4..499b1fee9dc1 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -110,7 +110,7 @@ __wait_for_common(struct completion *x,
 {
 	might_sleep();
 
-	complete_acquire(x);
+	complete_acquire(x, timeout);
 
 	raw_spin_lock_irq(&x->wait.lock);
 	timeout = do_wait_for_common(x, action, timeout, state);
-- 
2.17.1


