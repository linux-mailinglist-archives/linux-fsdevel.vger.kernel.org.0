Return-Path: <linux-fsdevel+bounces-8741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C287183A917
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021B41C2148C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF496A01B;
	Wed, 24 Jan 2024 12:00:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E9365BC0;
	Wed, 24 Jan 2024 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097614; cv=none; b=S2IqMYN+WWqc4u2ka/1sxk2fCOcycoKeeac3gqT1Au9iG7a4XI4233PhMzZP7/pMlfWcP6IdBIe1dEd8BDQS55NMcnRLQqzcj3tWt997bplOnoQpHjnFAluJf1pCcSrRg1Np4ej4Aa4PZ6/IhnDM/KYNlnAym/TS3+fKzlMDlWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097614; c=relaxed/simple;
	bh=A0HNCh9MAJFiyY64P3s+ZnF2ZrT06e1PDF08t8YO27Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=njUqifyynp6vnjKTyWLx69qyTFRPVGIinTYV4Et3tybfSqnv9yPn/GNb40VTMkbQqSfQXkqQFsm9iDl9ta5EZGcQ4FBaveM1n8Hf6y7h6fKM4dele9tbS/j+PX4EAdq2H989asCr2bD9YRa8PgDJA4nIO9T0ivxbpCf4mBFgERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-96-65b0fbb71d9f
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
Subject: [PATCH v11 21/26] dept: Apply timeout consideration to dma fence wait
Date: Wed, 24 Jan 2024 20:59:32 +0900
Message-Id: <20240124115938.80132-22-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124115938.80132-1-byungchul@sk.com>
References: <20240124115938.80132-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHfc/lPcfV6jCDjkkUC+lGF8vqKSKMiA5EVgR9KKhGHtpom7GZ
	lyCynGUru9G0UsIba23q1lZppaKWlxXlylVLVNTsIs0L1iybXTajLw8/nj/P7/nyZ0nZQ3oW
	q9KmiDqtQi3HEkoyOLV4SVXQIS63d8XD5fPLIfAth4JCezkGT6UNQfndkwQMNG2Bt2N+BMHn
	bSTkmzwIinu7SLjb3I2g1nIKQ3v/NPAGhjG4TecwZJXaMbz8MkFAZ94VAmzObfDsUgkB9eOf
	KMgfwFCQn0WExmcCxs1WBsyZsdBnucHARG8cuLvf0FDbsRiu3+zEUFPrpqC5uo+A9oeFGLrL
	/9DwrLmVAs/lXBoqhkowfBkzk2AODDPwqr6IAIchJDr99TcNLbn1BJwuu0OA990jBHU5PQQ4
	y99geBzwE+Bymkj4easJQd+FQQayz48zUHDyAoJz2XkUtP1qocHQuQqCPwpxwjrhsX+YFAyu
	NKF2rIgSnpbwwoMbXYxgqOtghCLnUcFlWSSU1gwQQvFogBac1rNYcI5eYQTjoJcQhl68YITW
	a0FK6PfmEzti9kjWJ4lqVaqoW7bhgET5/X0WPtLOprc6fEwmsjFGxLI8F8+73XojipzEJ/d6
	UJgxN5/3+cbJMM/g5vKu3I+0EUlYkjszhbeMPMfhIIpL5PsfVTJhprhY/laVcZKl3Gq+zV6F
	/0nn8DZH/aQoMrSvuN5BhVnGreJ7rBeZsJTnsiL5lroK5t9BNN9g8VGXkLQIRViRTKVN1ShU
	6vilygytKn3pwWSNE4UaZT4+sbcajXp2NSKORfKp0gSrXZTRilR9hqYR8SwpnyH1RVeKMmmS
	IuOYqEverzuqFvWNKIal5DOlK8bSkmTcIUWKeFgUj4i6/ynBRs7KDP3VyHcs2Bht28nlvf6g
	juVc8rnSxJjYvLW9tyOiMhwS//3NNpOv7aqRq5tH9hhGlE2qrXG2g56E5Ha5tvrqkvQ73aqh
	19qykU/K6R3WtJrsM8MNwYIu//a4lREbN605dsKkKUvZneRaeHP7h305SnaBN/HpfGlURe7M
	2T/TGoJySq9UxC0idXrFX55lJ+hNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxNYRzHPc855zmnw7Wzq3HI2+7WWN5f4jfM/OcZ87bZbNh06Ex33cru
	JUJTbpIUsiUqltgtt6tu97KuXizFVd6KWq7kqjQ0qdCNlJfK/PPbZ9/vvp+/fgKjvcxNEfSR
	+1VjpGLQEZEVN640zysZtKsLf7VqIS1lIfj6kljILrIRqC8sQGC7FY+h88FaeNnfhWDwaR0D
	Gen1CK62vWHgltuLoCL/OIGGjvHQ6OshUJt+moD5WhGB55+GMLRcOI+hwLEBHp/LxVA58IGF
	jE4CWRlmPHw+YhiwWHmwxAVCe34mD0Nti6DW28RB9eVaDiqa58ClKy0EyitqWXC72jE0lGYT
	8Nr+cPDYXcNCfVoqBze7cwl86rcwYPH18PCiMgeDPWHYlvjtNwcPUysxJF4vxtD4qgzB3aRW
	DA5bE4FqXxcGpyOdgZ95DxC0n/nMw4mUAR6y4s8gOH3iAgt1vx5ykNASDIM/ssmalbS6q4eh
	Cc6DtKI/h6WPcmV6J/MNTxPuNvM0x3GAOvOD6LXyTkyvfvVx1GE9Rajj63meJn9uxLT72TOe
	1lwcZGlHYwbePHW7uCpUNeijVeOC1SFi2Pd3ZrKvQThUY/fwcaiAT0Z+giwtle/fbkUjTKRZ
	ssczwIywvzRTdqa+55KRKDDSybFyfu9TMlJMkDbKHWWFo2NWCpTzSpJHWSMtk+uKSsg/6Qy5
	wF45KvIbzm9eamZHWCsFy63Ws/w5JOagMVbkr4+MjlD0huD5pvCwmEj9ofl7oiIcaPhpLLFD
	aS7U17C2CkkC0o3TrLEWqVpOiTbFRFQhWWB0/hrP5EJVqwlVYg6rxqhdxgMG1VSFAgRWN0mz
	bpsaopX2KvvVcFXdpxr/t1jwmxKHnNM0mWjx+u4bnoDYHdO3rjfLb6fbEpcsvR872+WqEQ9v
	16Q8WeHK2wQHcVxV8OvFifdcEle4K2SH4SJDj7w8RjK9xe4toV9uiO5Vz3f3lcNcS8gc5DW3
	KeZjpX+ME53i7TvK0Z12T1tA9OtZ5uKgPuPy+KbAqEmhx8f39mQl6VhTmLIoiDGalL/cQIe1
	MAMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to dma fence wait.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/dma-buf/dma-fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 76dba11f0dab..95121cbcc6b5 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -784,7 +784,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 	cb.task = current;
 	list_add(&cb.base.node, &fence->cb_list);
 
-	sdt_might_sleep_start(NULL);
+	sdt_might_sleep_start_timeout(NULL, timeout);
 	while (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags) && ret > 0) {
 		if (intr)
 			__set_current_state(TASK_INTERRUPTIBLE);
@@ -888,7 +888,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 		}
 	}
 
-	sdt_might_sleep_start(NULL);
+	sdt_might_sleep_start_timeout(NULL, timeout);
 	while (ret > 0) {
 		if (intr)
 			set_current_state(TASK_INTERRUPTIBLE);
-- 
2.17.1


