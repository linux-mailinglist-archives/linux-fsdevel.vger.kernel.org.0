Return-Path: <linux-fsdevel+bounces-12245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A6485D4C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2701C2331C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB8A5916A;
	Wed, 21 Feb 2024 09:50:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4AF4CE09;
	Wed, 21 Feb 2024 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509008; cv=none; b=P9hvdRxKaDXOb6jqxE8QYNuQqDb6OooL0heXoJ+eCdfnk8jospJMatp0cFTE/UqD3J83+9W+sJ9s7efU4hzVi0gu2LcxOAeYe07vM9GVMDmTVBJJcsGLby+3v3i4HHItpAS2/vQycI8c5D8inhBHhbkpOggESCEGkcleyfHzApU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509008; c=relaxed/simple;
	bh=oVu1M/z+Be6zJoonqEicwRg8jn1j0IbzUk3u5AE/er0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NqDX74gbpAmTGBHmBfU3tKrYJ9h8DmGNjzsvyw1F/gEM1MKUsAk07YlOgazSiGnrzVY2QbNBwA7oyo14eKdO5gRJrbVAMpIkqAMyS0edYML1uDKxjkvJC7FLNjtOUKhI5slk2qgZ47P/IR2SEwpPcJovo22eQkj78zasNHJq02A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-c8-65d5c73a9c46
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
Subject: [PATCH v12 20/27] dept: Apply timeout consideration to hashed-waitqueue wait
Date: Wed, 21 Feb 2024 18:49:26 +0900
Message-Id: <20240221094933.36348-21-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240221094933.36348-1-byungchul@sk.com>
References: <20240221094933.36348-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHfZ5773NvqzV3ncue4cxMg4644WRRd6JuMS7Lni9GEqMfxpLZ
	wVXqSjFFQFymKFUYClEUitKQFl3t2k6wSNANkJfx6kTEKmiQCDNsjUUULVkH6lqmX07++f3P
	+X06Eqe9LMRIBtNuxWzSG3VEzavH5zni13beUlZ090tw/OgKCD0r4MFW7SXQd96DwHvxAIZA
	+5cwMBVEMH3tOgfW0j4EjpF7HFzsGEbQ6DpI4OaD+eAPTRDoLj1CIO9MNYEbD2cwDJWVYPD4
	NsLVY1UYmsN/8WANEKiw5uHI+BtD2OkWwZm7BEZdp0WYGUmA7uHbAjTe/QBOVQ4RaGjs5qHj
	0iiGm7/aCAx7XwpwtaOLh77jRQL88qiKwMMpJwfO0IQI/c12DDWWiOjw0xcCdBY1Yzh89gIG
	/53fEDQV3Mfg894m0BYKYqj1lXLw77l2BKPF4yIcOhoWoeJAMYIjh8p4uP68UwDL0CqY/sdG
	1q9hbcEJjllqs1njlJ1nPVWUXT59T2SWprsis/syWa1rGTvTEMDMMRkSmM/9I2G+yRKRFY77
	MXvU2yuyrvJpnj3wW3Hiwq/U61IUoyFLMX/02TZ16h951WhXsbjn8VARzkUjQiFSSVReSW1/
	tvCFSJrNlv7YKCby+3RwMMxF8wJ5Ma0tGousqyVOzp9LXY+vkWjxpryF2p94uOgtLy+hAT+N
	Yo28mt5xnnulf496appnPaoI/7kiOMu18ip660YdF3VS+YSK5hU85f8/eIe2uAb5Y0hjR3Pc
	SGswZaXpDcaVy1NzTIY9y5PT03wo8lDOH2aSLqHJvs2tSJaQbp4mtd6vaAV9VkZOWiuiEqdb
	oOGzI0iTos/Zq5jTvzFnGpWMVrRQ4nVvaz6eyk7Ryjv0u5XvFGWXYn7dYkkVk4u+/9RT5o3z
	frh0zLjP1v5FZn5v08jOxOfJ+zYqxoG4E8FPdOOZ8a6lWkdxUqwqvMG1iVS6P4/9OtAz92TM
	hSsnBxLsJVsX1ySbNG11yeUF+w0vW+53teoS3lqbT2Lc8Yv66xvgjbp3v/09nY119DieaSup
	daytsry+yjSx/SeyvkHHZ6TqE5Zx5gz9f66TceRMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0wTaRiF/b6Z+Waodp1gXUc00VSNiQaFCOR1JcToj36aqJvNGrOaKHWZ
	SGO5bIsVNGbRFkUUBBNEpbspoJUFFHdws3jBVIhgQZFLkYtIBA1KLOKFoly8tCb+OTl5znvO
	r1dgggu5EMGQmCKbEvVGLVGxqs1rrKE/NXTIYac+hELeyTDwjWayYK+sINBypRxBxbXDGIbu
	6qBzzItg8sFDBgryWxAU9T9h4Fp9H4Ka0iME2p//AB7fCAF3/gkC1pJKAq2vpjD0njmNoVzZ
	BE25xRhc4y9YKBgiUFhgxX55iWHcWcaDM30JDJSe52GqPxzcfY84qPvLzUFNz3I493cvgVs1
	bhbqqwcwtN+wE+ir+MJBU/09Flrysjm4/LqYwKsxJwNO3wgPbS4Hhqs2/9rR9585aMh2YTh6
	4V8Mnu6bCG5nPsWgVDwiUOfzYqhS8hmYuHQXwUDOMA8ZJ8d5KDycg+BExhkWHn5q4MDWGwmT
	H+1k7Rpa5x1hqK1qP60Zc7C0sVii188/4antdg9PHco+WlW6jJbcGsK06J2Po0rZcUKVd6d5
	mjXswfR1czNP752dZOlzTwH+ef52VXScbDRYZNPKmFhV/H1rJUrO4VPf9GbjdNTPZSFBkMQI
	yda2OAsFCURcKnV1jTMBrxEXSlXZg/4TlcCIx6ZLpW8ekEAwS9wqOd6WM4EuKy6RhjxSAKvF
	KKnbeYkLeElcIJVfdX3bCfLzfwq933iwGCl1tP7H5CKVA00rQxpDoiVBbzBGrjDvjU9LNKSu
	+D0pQUH+l3EemsqrRqPtulokCkg7Qx3/v0cO5vQWc1pCLZIERqtRs/v9SB2nTzsgm5J2mfYZ
	ZXMtmiew2jnqjdvk2GBxjz5F3ivLybLpe4qFoJB0FKMjus2NMy2zm35Li149Gffj7MGJInLQ
	qGjDOmy6PyLnouHdMZpjW1q9M6Ontf6ZFCpHbGjbsm5byGInRiW+Z3ZjR9uz5L5fXyZVj/ZE
	5NzZOWdR86rBI9aJYkvu9Lcl13d1I1j/y8WpszvSXc1RnS/yNbmpmSmPYzPoF3e/Yo/SsuZ4
	ffgyxmTWfwW0t9IeLgMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to hashed-waitqueue wait, assuming an input 'ret' in
___wait_var_event() macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait_bit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index fe89282c3e96..3ef450d9a7c5 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -247,7 +247,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 	struct wait_bit_queue_entry __wbq_entry;			\
 	long __ret = ret; /* explicit shadow */				\
 									\
-	sdt_might_sleep_start(NULL);					\
+	sdt_might_sleep_start_timeout(NULL, __ret);			\
 	init_wait_var_entry(&__wbq_entry, var,				\
 			    exclusive ? WQ_FLAG_EXCLUSIVE : 0);		\
 	for (;;) {							\
-- 
2.17.1


