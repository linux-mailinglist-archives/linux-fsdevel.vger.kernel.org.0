Return-Path: <linux-fsdevel+bounces-8739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735FE83A90B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB0B1C21097
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB8C67A04;
	Wed, 24 Jan 2024 12:00:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DA3657BF;
	Wed, 24 Jan 2024 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097613; cv=none; b=cPzn0w8jT5mgLIxIQQHzN/EA/b6dEpOD9kb/XvJCR2m/2QG8EFHZBf9TdjDftoKOXW7qtezoki8whxp1YcrjhbC0X/UdPcd9zoWEp0Lx1YGbDJQyY2hRkKMBUHIzSsBWOcXdS+Mhk2WXuCehuvsMB/2CRLXQkqMdSqnXr7y6zqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097613; c=relaxed/simple;
	bh=RHlJ2GxVpEp+l17KtAmYPgKdeN+t8Sb6ly9lphI8Ui8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=t1CaZ0VZPxyLZV0mWq6qayofJdK2A8Ph4Y3WvpBA57muh9bsOG2YWH/wU8STvQ7YToUBTpzzcYezdPEpDu1JxxHelypMPP6HOJsTIDbacFsPNUK5rIw2yXhezzbFkDOwAxq003ecghVtksRBKSNX4bBm1SH7FuurishqqAcnsfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-75-65b0fbb74679
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
Subject: [PATCH v11 19/26] dept: Apply timeout consideration to waitqueue wait
Date: Wed, 24 Jan 2024 20:59:30 +0900
Message-Id: <20240124115938.80132-20-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124115938.80132-1-byungchul@sk.com>
References: <20240124115938.80132-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSWUxTeRTG/d+91Zpr3a5iHK0xxl2M6FEZ48Mk839RSdSYqFEbuUojVFIU
	xC1VKjpVGGWmRZYQFlOaslpwLSUIAVoRrYK1VkDElQBC0BJrQYQaX05++c75vu/lcKTcRs/m
	VOpjokatjFYwUkraNylv+Z1Aubjqv+7FcO3KKvB9vURBdlkxA67SIgTFlecI6K7/G14M9SII
	ND8hId3gQpD3pp2EyoYOBHbzeQZa3k2GVl8/A07DZQaSCsoYeNozTECbMY2AIusWaLqaT0CN
	/yMF6d0MZKUnEWPjEwF+k4UFk3YhdJkzWRh+EwrODjcNdu9SyMhpY6DK7qSg4W4XAS33sxno
	KB6loanBQYHrWgoNJZ/zGegZMpFg8vWz8Kwml4By3VhQ8pcfNDSm1BCQfOMmAa0vbQiqL3US
	YC12M1Dn6yWgwmog4XthPYKu1D4WLlzxs5B1LhXB5QtGCp6MNNKgawuDwLdsZvMGXNfbT2Jd
	RQK2D+VS+GG+gO9ltrNYV+1lca71OK4wL8EFVd0Ezhv00dhq+YfB1sE0Fuv7Wgn8+fFjFjuu
	Byj8rjWdiAjZLQ2PFKNV8aJm5aYD0qi8agcZe4s9ceOiF2mRjtEjCSfwa4RCbRH6zc5XDdQ4
	M/wiwePxk+M8jZ8nVKR8oPVIypH8xYmCeaA5aJ7KbxXO17UHjyh+oWCrGgmyjF8r+JMesL9C
	/xCKymuCumRML8nwBgvkfJjQafmXHQ8V+CSJ0NjUQ/4yzBIemD3UVSTLRRMsSK5Sx8coVdFr
	VkQlqlUnVhw8GmNFYy9lOjO85y4adG2vRTyHFJNkmy1lopxWxsclxtQigSMV02SeWaWiXBap
	TDwpao7u1xyPFuNqUQhHKWbKVg8lRMr5w8pj4hFRjBU1v7cEJ5mtRf/v97zP/BQ+s/m1y1E4
	VX974rJw59zOucY/Yx3mb5ZbUeWrfclqfcF6b4F718BGNxXmcp9aqn1kIKcvkJzcOxphrKqf
	rgwZeH52RkA2EpogO5jaUmaWzE+YY4N5Wwz2HTvfpmVVnxVGX1VyXdtt2pxCT07E6b+meLcd
	wmv3rUs1Kqi4KGXoElITp/wJkO8o2E4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTcRTG+//f21wtXpbQmxXFIAK7Q8ahRVhf+tNFi4jALznqJZc6Y8ul
	Xch03TQtK7OLlbemzKU2i6ymLceWq7xbmamZdNM0zZw15ypb9OXw4znneZ4vR0LJrzFBErVm
	n6jVqGIUrJSWhilTFt3zlotLB8YwZJ5eCu6RkzTklJlZaCwtQWC+cxRDr2MdvBrtR+Cta6Ag
	O6sRQd67TgruOLsQVBUns9Dyfiq0ugdZcGWlsZBSUMZC05dxDB0Xz2EosWyCZ2fzMdg8n2jI
	7mXhanYKnhifMXiMJg6MSfOgp/gKB+PvloGr6yUD9msuBqraF8Dl6x0sWKtcNDgrezC0PMhh
	ocv8m4FnzloaGjPTGbj1NZ+FL6NGCozuQQ6abbkYyg0Tace//2LgSboNw/HC2xhaXz9EUH2y
	G4PF/JIFu7sfQ4Uli4KxIgeCnowBDo6d9nBw9WgGgrRjF2lo8D1hwNARAt6fOWyoktj7Byli
	qNhPqkZzafI0XyD3r3RyxFDdzpFcSzypKA4mBdZeTPKG3QyxmE6xxDJ8jiOpA62YfK2v50jt
	JS9N3rdm482zIqSrdokxar2oXbI6UhqVV11L7b3LJRSeaEdJyMCmogCJwC8XXG+c9F9m+flC
	W5uH+suB/FyhIv0jk4qkEoo/MVkoHqrzG6bxYUKyvdN/RPPzhIdWn59l/ArBk/KY+xc6Rygp
	t/n1gAn91uV2f4GcDxG6TWe4s0iaiyaZUKBao49VqWNCFuuioxI16oTFO+NiLWjiaYyHxzMr
	0UjLuhrES5BiiizUVCbKGZVelxhbgwQJpQiUtc0oFeWyXarEA6I2boc2PkbU1aCZEloxXbZ+
	uxgp53er9onRorhX1P7fYklAUBLaObi26L5t+MaWlj5fuG/ojONTyZBMWXkkP6Pj7edtallG
	Ibsw1BG2JnxL04YPnReYtsY961XfMvFGpzU8ubnOATeUmpuzX5zn7ButeuPdIG8cqVw5O2Qs
	LKJuZM6hH2AOHikd46W67b/7lI+2Hl4z7OsOOLgh7TkX2SvVP06OVtC6KNWyYEqrU/0BL/Mk
	kDADAAA=
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
index ebeb4678859f..e5e3fb2981f4 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -304,7 +304,7 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
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


