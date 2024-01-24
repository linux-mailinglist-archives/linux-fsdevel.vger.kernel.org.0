Return-Path: <linux-fsdevel+bounces-8720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACCE83A8A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7091C250EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B06D612C0;
	Wed, 24 Jan 2024 12:00:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA7B60DD7;
	Wed, 24 Jan 2024 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097601; cv=none; b=LFFLGPSlqiLCq3KdlOeEed6BebJ+crXSlhTzPW9e1h2LORu2W2MzrUAJs+9nDOJbCMSu/dVqhqdkEmkSDe+y5z/RB4CugMslbmApfGVtWnvikSElOisJlHJgu15/qkKl53t+MD5ObJqywTdYOlFwoYoUuXMP8Ngw7jwyi0FzuVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097601; c=relaxed/simple;
	bh=3z6wcnzZigmy1AnwKW6EWYXgb3eqsvFGY6rKaYlxPHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ekfg+IvEPUpwhPYg7+kM8VobWCLZ2ApkQAVSaIDG77RoExaAbqcl1Y7bsXFYC4rZk0eqXLSpGOzgGFkcJO9nqwi2Lr7PTZnsj0WDv12MErKEu3ud6XQzu0C4Oe8k7iI8fy3g50hLbf+tg5L3dLv40t9nKWuoEPIeonfa86LZkow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-51-65b0fbb4aca7
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
Subject: [PATCH v11 01/26] llist: Move llist_{head,node} definition to types.h
Date: Wed, 24 Jan 2024 20:59:12 +0900
Message-Id: <20240124115938.80132-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124115938.80132-1-byungchul@sk.com>
References: <20240124115938.80132-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSW0wTaRTH/b6Z+WboUjMpGkd8QBurCcYLBs1xo4ZkH3Z40JhojJFEbWSU
	slxMy3WzRkQEF0RBU1CsWkBrU6Bgi9EVSipqoRKhYsN2CSASd5EVRMGycvHSsvpy8ss5//xy
	Hv4cpWhiwjlNSpqkTVEnKYmMlo2FVq5tnG2QNkx4NkLp2Q3g/3CGBkN9LQGPtQZBbeNJDCOP
	f4Y/p0YRzD7toqBc70FQ+bKfgkbXAAKHOZfA81cLwesfJ+DWFxE4VV1P4NmbOQx9ZRcw1Nh2
	QEdJFQbn9DAN5SMErpSfwoHxGsO0ycKCKUcFQ+YKFuZeRoF7oIcBR+8auHytj0Czw02D694Q
	huf3DQQGar8w0OFqp8FTWsxA3dsqAm+mTBSY/OMsdDuNGBryAqL8yc8MtBU7MeTfuI3B+1cT
	gpYzgxhstT0EHvpHMdhtegpmbj1GMHRujIXTZ6dZuHLyHIKi02U0dH1qYyCvbxPMfjSQmB/F
	h6PjlJhnzxQdU0ZafFIliH9U9LNiXksvKxpt6aLdHClWN49gsXLCz4g2y+9EtE1cYMXCMS8W
	33Z2smL7pVlafOUtx7uW7ZdtjZeSNBmSdv32Q7KE/M5r7LGrsizjzTskB7VwhSiEE/ho4WJu
	G/OdHXWTJMiEXy34fNNUkBfxywV78T+BjIyj+IIfBPO7p/OhMH6n4Cgax0GmeZXwb1c3HWQ5
	v0m47rLS/0sjhJoG57wohN8s1F3und8rAplBy3k2KBX4ghDB0lH47YulwgOzjy5BciNaYEEK
	TUpGslqTFL0uITtFk7XucGqyDQUqZTo+F3cPTXh2tyKeQ8pQeYylXlIw6gxddnIrEjhKuUju
	W2qVFPJ4dfavkjb1oDY9SdK1omUcrVwi3ziVGa/gj6rTpF8k6Zik/X7FXEh4DtI7dKuGS1Kl
	9d7ImYN3PL7f7qpLa6L3xR7ZfTdu8knEgm5jxEwmdaDf2h2amL1yr8OZ82BP2QmDyur2Vxxe
	kS6b+Xz/aGxsXHJ4+DYhNO3D4iXmT6rzBTsMivd2fWOYzrXlp7+JL4I9kFgRo1S5Xz/72Hyo
	57+hR++LTuxvejGcu0ZJ6xLUUZGUVqf+Ctduq0FOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzH+36f5/k+T8fZ08k8YmM3ZCEZtY9l1j94Zqtl/vBjpBsP3frB
	7kgZW7mEcgiJujjhtOunp5Afl1up5EelQlrdqjVEydTFuURl/vnstff7vddfH45S5TI+nDbu
	gKSL08SoiYJWhAUblpa7S6UAxzUfyDgdAM7hkzSYSgoJNBUXICgsT8bQV7Me3o30I3C/aqQg
	K7MJwfXuTgrKax0IbPnHCLT0ToNW5yCB+sx0AoYbJQRefxnF0HHpPIYCORRenMvDYHd9pCGr
	j0BOlgGPn08YXBYrC5akBdCTn83CaPdyqHe8ZaA6t54BW/tiuHK1g8BjWz0NtRU9GFoemgg4
	Cv8w8KL2GQ1NGUYGir7mEfgyYqHA4hxkodluxlCaMm5LHRpjoM5ox5B68w6G1vePEFSe7MIg
	F74lUO3sx1AmZ1Lw63YNgp4zAywcP+1iISf5DIL045doaPxdx0BKRyC4f5pISLBY3T9IiSll
	h0TbiJkWn+cJ4oPsTlZMqWxnRbN8UCzL9xNvPO7D4vXvTkaUraeIKH8/z4ppA61Y/NrQwIrP
	Lrtpsbc1C4fP2aZYvVuK0cZLumVrIhVRqQ1X2f25igTzrbskCVVyaciTE/iVgq1oiEww4X2F
	tjYXNcHe/DyhzPiBSUMKjuJPTBHyv72aHE3nwwRb+iCeYJpfIHxubKYnWMkHCtdqi+l/0rlC
	Qal9UuTJBwlFV9onc9X4pst6lj2HFGbkYUXe2rj4WI02JtBfHx2VGKdN8N+1L1ZG409jOTqa
	UYGGW9ZXIZ5D6qnKEGuJpGI08frE2CokcJTaW9k2q1hSKXdrEg9Lun07dQdjJH0Vms3R6pnK
	DZulSBW/V3NAipak/ZLuf4s5T58k9HLh/HivwPA39oiho3cNQyjNfmes87066GlzQrR84fKn
	JxH3N9VVrPJrCl203fUwOfuHh3H0jdc9khS5TnZEtPfO2KHBz71ClbZ5Fz1ig/3pnYt7jKYj
	4dPdYSh0OGjJqoB3vw3JAVNC9qz1tW+92d218VjQFm2fqeh1dk7NqUVjK9S0Pkqz3I/S6TV/
	AentXzAwAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

llist_head and llist_node can be used by very primitives. For example,
Dept for tracking dependency uses llist things in its header. To avoid
header dependency, move those to types.h.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/llist.h | 8 --------
 include/linux/types.h | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index 2c982ff7475a..3ac071857612 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -53,14 +53,6 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 
-struct llist_head {
-	struct llist_node *first;
-};
-
-struct llist_node {
-	struct llist_node *next;
-};
-
 #define LLIST_HEAD_INIT(name)	{ NULL }
 #define LLIST_HEAD(name)	struct llist_head name = LLIST_HEAD_INIT(name)
 
diff --git a/include/linux/types.h b/include/linux/types.h
index 253168bb3fe1..10d94b7f9e5d 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -199,6 +199,14 @@ struct hlist_node {
 	struct hlist_node *next, **pprev;
 };
 
+struct llist_head {
+	struct llist_node *first;
+};
+
+struct llist_node {
+	struct llist_node *next;
+};
+
 struct ustat {
 	__kernel_daddr_t	f_tfree;
 #ifdef CONFIG_ARCH_32BIT_USTAT_F_TINODE
-- 
2.17.1


