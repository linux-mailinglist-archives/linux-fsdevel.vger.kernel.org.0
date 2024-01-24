Return-Path: <linux-fsdevel+bounces-8730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F03A883A8DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78C828D1DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F365D64CCB;
	Wed, 24 Jan 2024 12:00:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E0C62802;
	Wed, 24 Jan 2024 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097607; cv=none; b=oKYeckXJmqxy94LMdwSDImHoi0JeadpkXaIQR/bXW0ksjw4qtiFoG/lKqmGY8C/yD+cwazVXKaluoRkJPVWoIfpZyKv8HkK6wbLUnbrbM9pI0ibeRM74oQzt+iQIHkOPaANCWnysjdJm2jsSMtS4zUAnu3stFKyyDg1hJXEHO7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097607; c=relaxed/simple;
	bh=MruAYr/ze2aZU4Q6DDtEFdBspBpkL05uqzvhsrQG5Gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=e50MRHDFJ5tHy8sS9UFyU6fZzdvcQ5vVjTbgAS6aDNnFMG9UR/T5DqkNp78mS6cPTgQoLex9MiIzMOhx9W3UY4opWkoSKTaGYQ4hvtI6UhmuHzo37uI1zxWTJI2thlTjxv8ZoJIiKv2+82nMo2qYerW1xRfMlngixSlx8BEeewI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-e5-65b0fbb562db
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
Subject: [PATCH v11 10/26] dept: Apply sdt_might_sleep_{start,end}() to hashed-waitqueue wait
Date: Wed, 24 Jan 2024 20:59:21 +0900
Message-Id: <20240124115938.80132-11-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124115938.80132-1-byungchul@sk.com>
References: <20240124115938.80132-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfb+/x7scvx3ml+Zhh9kYYmWfhfiLn43N1h82z7fuN3fTxS5F
	nhaKlChWp8TqcM51PfjlIeraFVKeOrpxUkkzOT0qF9cTV+afz957v/d+ff55s4TyETWD1UUf
	EA3R6igVLSflXRPzF98fKhGDeypkkHEuGLw/k0nILbbR4CwqQGC7ewKD5+l6eD/QiWDoVT0B
	xkwngvzPzQTcrWlBYLecpKHhyyRweXtoqMtMpeHU9WIa3nQMY2jKuoihQNoEL9JNGBy+dhKM
	HhquGE9h//mGwWe2MmBOmA9tlhwGhj8vg7qWdxTYGxdB9rUmGirsdSTUlLVhaHiUS0OL7Q8F
	L2pqSXBmpFFQ2G2ioWPATIDZ28PAW0cehpJEP+h0/ygFz9IcGE7fuIPB9aEcQWVyKwbJ9o6G
	x95ODKVSJgGDt54iaDvfxUDSOR8DV06cR5CalEVC/cgzChKbQmHody69Nkx43NlDCImlBwX7
	QB4pPDfxwsOcZkZIrGxkhDwpVii1LBSuV3iwkN/npQTJepYWpL6LjJDS5cJC9+vXjFB7eYgU
	vriMeHPQVvkqjRilixMNS8N3y7XtzRnUfjd7aOTJQyYBuekUJGN5LoTPrneR//XPS2XMmKa5
	Bbzb7SPG9FRuDl+a9pVKQXKW4M4E8JbeV+PlKdwOfniw1x+wLMnN56UHkWO2glvB11b3M/+Y
	s/mCEsc4R+b3C7Mbx38puVC+1XqBGWPy3BkZn3zvN/WvEMhXWdxkOlLkoQlWpNRFx+nVuqiQ
	Jdr4aN2hJZH79BLyL8p8bHhbGepzRlQjjkWqiYq11mJRSanjYuL11YhnCdVUhTuwSFQqNOr4
	w6Jh3y5DbJQYU42CWFI1XbF84KBGye1RHxD3iuJ+0fA/xaxsRgKa1hj762XHpqsvu5NVETtn
	ObTHNSurnDM9Sa1PtH+Cqm6q1m1P/ZjTP3dmRN/tHVgduTvkqG3noEIbVr46SLPcOXtj/acj
	vgCtqWG0MnDyBZdng1HaMDo9OP1kQLnpWnNWmH1eiqu9bM2q7529ehRekn87HelHZoUunZQZ
	/mOddu4WFRmjVS9bSBhi1H8BjlB7+k0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzHfb/Pzy7HsxOelB87jGWpRvYhzMbmmWFpMxvz41bPdKuL3VVk
	TFSkhGM5FLvKzrku5YkJXUtxdRlFt5xWLc2ciBpdnK64mH8+e+393vv114clFMXULFadkipq
	U1TJSlpGyrbGZIXfH60SI8fzIkB/NhI8w7kkFFdaaWi7U47Aeu8Ehv5nG+HNyACC0RetBBgK
	2xCUvOsm4J69B4HNfJKG9vdTwOkZpMFRmE9DVlklDa8++zB0Xb6IoVzaAs8vlGKo97pJMPTT
	UGTIwv7zEYPXZGHAlLkQ+szXGPC9iwJHTwcFjdcdFNg6l8DVG1001NocJNhr+jC0Pyqmocf6
	m4Ln9mYS2vQFFFR8LaXh84iJAJNnkIHX9UYMVdl+26nv4xQ0FdRjOHXzLgbn28cI6nJ7MUjW
	DhoaPQMYqqVCAn7deoag79wXBnLOehkoOnEOQX7OZRJax5ooyO6KhtGfxfS6GKFxYJAQsqsP
	CbYRIym0lPLCw2vdjJBd18kIRilNqDaHCWW1/Vgo+eahBMlyhhakbxcZIe+LEwtfX75khOYr
	o6Tw3mnAsaE7ZasTxGR1uqiNWLtPluju1lMHXezhsacPmUzkovNQAMtzy/nhSzXMBNPcIt7l
	8hITHMTN46sLPlB5SMYS3OlA3jz04u9gGreb9/0a8hcsS3ILeelB/EQs51bwzQ3fmX/OuXx5
	Vf1fT4A/r7jaSU6wgovmey3nmQtIZkSTLChInZKuUamTo5fqkhIzUtSHl8Yf0EjI/zOmYz59
	DRpu39iAOBYpJ8vXWSpFBaVK12VoGhDPEsoguSv4jqiQJ6gyjojaA3u1acmirgGFsKRypnzT
	DnGfgtuvShWTRPGgqP3fYjZgViZa9gPHbn069bZ3s/mGOmRanP1tXXzZ4O8FgVxu+PzF20Lt
	wYs1T2IebVpZ07IhJMlnmr3d/SYubE5FkDQv9cgi6+NPzlWKWGO+YX9dU5xU4bC7o/Ql0Zpd
	RbdsbseC9YEoVbb3dMDQk/T2oyuOqwa2KIMDZ2iq7s4ndxX9HFkzvXGPktQlqqLCCK1O9Qdg
	X4soLwMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Makes Dept able to track dependencies by hashed-waitqueue waits.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait_bit.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 7725b7579b78..fe89282c3e96 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -6,6 +6,7 @@
  * Linux wait-bit related types and methods:
  */
 #include <linux/wait.h>
+#include <linux/dept_sdt.h>
 
 struct wait_bit_key {
 	void			*flags;
@@ -246,6 +247,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 	struct wait_bit_queue_entry __wbq_entry;			\
 	long __ret = ret; /* explicit shadow */				\
 									\
+	sdt_might_sleep_start(NULL);					\
 	init_wait_var_entry(&__wbq_entry, var,				\
 			    exclusive ? WQ_FLAG_EXCLUSIVE : 0);		\
 	for (;;) {							\
@@ -263,6 +265,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 		cmd;							\
 	}								\
 	finish_wait(__wq_head, &__wbq_entry.wq_entry);			\
+	sdt_might_sleep_end();						\
 __out:	__ret;								\
 })
 
-- 
2.17.1


