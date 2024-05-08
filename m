Return-Path: <linux-fsdevel+bounces-19069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5808B8BFA8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 12:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD641F24958
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFEE127B75;
	Wed,  8 May 2024 10:03:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2E57E588;
	Wed,  8 May 2024 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162585; cv=none; b=hy4XGl52FTPgeidmnmQ+PrQP9yFq6+UggeoZQcVBHwfd3B1MlItHxRXrc64mGW2fmSfDrdeeylX+uGo5IrcQGISyj7vWIY/DUgN+7jNPAX82Cn0u0QGX6fWYryRhO/VRGyax7hxxQLP67jaKDi/vRTAu4fzVedsMvmnZz5dVlpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162585; c=relaxed/simple;
	bh=saWe6a3fhc64UJRxzIxNtK20F4aE3vpbQLNILPOmhGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IoD3HyTsBZbRbHCkA4tfzYJU4feReT7F2fqbIOiSIZdWJlv9plS30yi6Nb+MRLEBgpaXmV39JgmtrOjcRS3dHM6CvwkVHJDGI/urF8ZXlxy6ZJjWBGgwYd2t+OgAvEb+hVw9U/WQOVsC9EnAi0BUTqgxmeUkvS2ecOLXeLeOb0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-48-663b4a3a9bc8
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
Subject: [PATCH v14 19/28] dept: Apply timeout consideration to waitqueue wait
Date: Wed,  8 May 2024 18:47:16 +0900
Message-Id: <20240508094726.35754-20-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508094726.35754-1-byungchul@sk.com>
References: <20240508094726.35754-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+/3u3b3X4eS2gm4aPUYRGJlG2ulBVFJdoidB0ENs6bUNn8xX
	FoG6ZeZaWGGWWajVXG69NnuoadPwscRHbZSaSa2HSVPDmriUalr9c/jw/R4+nD8OQ0grRf6M
	MiFFUCXI42SUmBQP+pYuXbN1TUywts4Xzp0JBvePXBKK75oo6LxjRGCqzMIw0LgFXo+6EIy3
	dRBQWNCJoPT9WwIqm/oQ1BqyKbB/9AOHe5gCW4GWAvX1uxS8+DqBoffieQxG83ZozS/DYPX0
	k1A4QMGVQjX2ji8YPPoKGvSZi8BpKKJh4n0I2PpeiaC2ZwlcvtZLwZNaGwlNj50Y7NXFFPSZ
	fougtamFhM5zOhHcHiqj4OuongC9e5iGl9YSDPc0XlHO918iaNZZMeTcuI/B0V2DoC73HQaz
	6RUFz9wuDBZzAQE/yxsROM8O0nDyjIeGK1lnEWhPXiRB0xsK42PF1PpV/DPXMMFrLOl87WgJ
	yT8v4/iqorc0r6nrofkScypvMQTy158MYL50xC3izRWnKd48cp7m8wYdmB9qb6f5lkvjJP/R
	UYh3+e8Xr40W4pRpgmrZukNixaduG0p6QB99d+ESmYk0VB7yYTh2BafO/UH+55f5ZVNMsYu5
	ri4PMckz2fmcRfdZNMkE6xJzN9o35yGGmcHu4Frteydjkl3E3bd9mFJK2DBOq3tI/FXO44z3
	rFPs4827+4fQJEvZUK5GXUTnIbF3Z4zhPPbyfzfM5uoNXWQ+kpSgaRVIqkxIi5cr41YEKTIS
	lEeDohLjzcj7S/oTEwceo5HOPQ2IZZDMV2KdtTpGKpKnJWfENyCOIWQzJY2nVsZIJdHyjGOC
	KjFSlRonJDegAIaUzZIsH02PlrJH5ClCrCAkCar/LWZ8/DNRepSxYUH2wgv7dgfEluvYjQaD
	Q3az6pE6TDvWXf3z+AfFpuYw99XIb6uxyUjW35lev0tm1fo9twdSL/yDZxwOF6daWiWRro6I
	W85p2ZmKncbDkZv95iwu2n+tIygrpAaOHK+TbhvvDwh/+vpNRODcg4+utm1w7tgbcay+uqbZ
	GRwhI5MV8pBAQpUs/wOQQqMTRwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRzGe99zznuOo9VhGR2SKEajG12srH8ZUQR1CIpAKqgPufKYI52x
	mWUXsDYrXctL6cqslsWSzS5uWSubiKK5JFtOKkUl7aLWdGDNMqVyRV8efjwP/D49HKUoYqZz
	Gm2apNOqk5VERsu2xhoWrt4cm7gkcH0p5J9bAqFvZ2kouVdOwHfXgaD8wUkM/fWb4M1wAMHo
	i5cUWAp9CG50d1LwoKELgafsFAH/h0nQGgoS8BaaCBhu3iPw6ssYho6iAgwO5xZoyivFUDPS
	S4Oln8AViwGPRx+GEZudBVumCnrKilkY644Gb9drBuquehnwtC+Ay9c6CDz1eGlocPdg8D8p
	IdBV/puBpoZGGnz5ZgbuDJYS+DJso8AWCrLQUmPFcN84bjv99RcDz8w1GE7fqsDQ2laFoPrs
	OwzO8tcE6kIBDC5nIQU/b9cj6Dk/wELWuREWrpw8j8CUVUSDsSMGRn+UkHWrxbpAkBKNrsOi
	Z9hKi89LBfFxcScrGqvbWdHqPCS6yuaLN5/2Y/HGUIgRnfZsIjqHClgxZ6AVi4PNzazYeGmU
	Fj+0WvC2qF2yNQlSsiZd0i1eGy9L+tjmRQcr2SPvLlyiM5GR5KAITuCXCy15pXSYCT9HePt2
	hApzJD9LcJk/MWGm+IBMuNW8MQdx3BR+q9Dk3xGuaV4lVHjf/9XI+RWCyfyQ+qecKTju1/zl
	iPG+rXcQhVnBxwhVhmI2D8msaIIdRWq06SlqTXLMIv2BpAyt5siifakpTjT+FtuJsXw3+ubf
	VIt4Diknyn0kNlHBqNP1GSm1SOAoZaS8/szKRIU8QZ1xVNKl7tEdSpb0tSiKo5XT5Jt3SvEK
	fr86TTogSQcl3f8VcxHTM5GKy+qz9q7/mW6pjI+zvnhkPtbpru5WOUh2x8vZHndFmmP7blPu
	ZBP7farheyhbtzNKlRulDzhbqrRNmcaqPubysDRUEhOyB32LUVzBhHlDM1ZVuk6k+YuPb/B3
	R7cvu7BDTV9MqMyde3hv4+PUbPu2mX0De/Vfg49wXNvnX24lrU9SR8+ndHr1H7XhvnMpAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to waitqueue wait, assuming an input 'ret' in
___wait_event() macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 3177550a1b42..0bc7720273c8 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -303,7 +303,7 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 	struct wait_queue_entry __wq_entry;					\
 	long __ret = ret;	/* explicit shadow */				\
 										\
-	sdt_might_sleep_start(NULL);						\
+	sdt_might_sleep_start_timeout(NULL, __ret);				\
 	init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);	\
 	for (;;) {								\
 		long __int = prepare_to_wait_event(&wq_head, &__wq_entry, state);\
-- 
2.17.1


