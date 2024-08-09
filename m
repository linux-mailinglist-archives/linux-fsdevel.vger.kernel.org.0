Return-Path: <linux-fsdevel+bounces-25494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF68C94C7AC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 02:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12C91C22B8A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 00:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10DD4437;
	Fri,  9 Aug 2024 00:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kx8/sIZp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576822905;
	Fri,  9 Aug 2024 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723164072; cv=none; b=S6VJKxd10TE8MgwwmUQrkSp6o4uQ+k5Ghm2ZLcPoLhXbInYI0bQAsZWGZnEYu3EqDhqpnEKu97K84mF8+ikTpDpGUsDH+g1CnSAqxVh8GotnjUuUkfh/rV0DCY6IsmcCFxL3JIRqSLc4m1yFGVxWjUvJ109AEu1lCknrbjK+6r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723164072; c=relaxed/simple;
	bh=FGrnrr/6DYUCmaixaG6t5/NFv/UZKdElNOMkbHpxn3Y=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cWPr4rCkUMTjz1aZNPSz+jrgfs+xvPDppU40XFFXsDSkUQXeWkiMFOpWCa4arddNHVoxfSM9iipmuIGcSISKbKERSfsKgq1+w4ZRAgh7tYLTefZKWzKz+XKauCsgFN+iHJqncF43RDwzZyp5P9ohT90Hb8UE/FCWPuRZ6WjK49o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kx8/sIZp; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d5eec95a74so904297eaf.1;
        Thu, 08 Aug 2024 17:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723164069; x=1723768869; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47tFDCUc6tXdpmSpkydMhn345YMpNq+/67xmcx53pO8=;
        b=Kx8/sIZpmZpdn1xuOCnGqX5AHiuv3E9zAbEJwpH+lyryeRE8x0yw2IpyuX0dSOCRzD
         KuhWaYODp2NzgpLNDAz48D2be9YF56q5DdMi2BklZsLVL24oWBS2Ufb9YeanJNGCQVAi
         gpATXNwu3L4bit+lQ6A6eBij+5fs2fa9sJKVHkscCuXiigwbMTwAFz+lr76MtU89caVK
         UlkMfR3u7MUHh2tBsT2LXx/bnq2kkOYkwlFNIc8L+7BDBaJ0G5mlzIUgzRDfVaUdSMLz
         EFMtTODB1N9WDkfxatg71H6WzDCLr34m8zsUSS/1WhwYFBeiiO59cZfvdAAwl8zV/pgf
         Lgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723164069; x=1723768869;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47tFDCUc6tXdpmSpkydMhn345YMpNq+/67xmcx53pO8=;
        b=jOKEtLK6Fv/XyAbBcDgzL6IpTzQIzLyQVn4beTdYa/0BbnSYQ4JO81uH0s4fwPFsgO
         F9nQeszxnE+8iT0eJOamMaCgrlqZ8U8qkOLzfwqbw5f73u356dquNQMt3/fL5hdUPDyV
         2tI8r7mlnVHEOfj9hpC0PIcExT/AuVs5Ytcl8E5KAE0L8h4owDlRtJMM8noepXKlhc3M
         reKidQcyN2dvSB08ePCTmT/bH1zylTHdnPYXznP2MkQhatj0LgIxTOPnPxnTvTDdJzxT
         7zbNB6YxhXBXSDCeApgwso4Vp5Uhr/F8tt7qURiDU1fyVz+YUihfon5ZdIaVzX+679uY
         Tshw==
X-Forwarded-Encrypted: i=1; AJvYcCXw2VYPCvcuJjVW72+VNprvEyoxw9DMvN9X4NosX8aaWtFg1qk9pmfdXsAwMU0qhOENECTkmBIjON6tczCFXF5yEfPTdpFmso+VfYEY5oQps0NuVBOd/0vkbkvN6TIA/5e3tL+9Px5UA7x/8Q==
X-Gm-Message-State: AOJu0YyBteRej8xp0fLx6DItaWhL72fLhtF4rmUjIpRkJX7XFjJVHH6y
	VAn1tXBjHt54EZhx2JGDVzHpHLE1NtWslxaXN26La2TPcxkk91Hp
X-Google-Smtp-Source: AGHT+IFhIItUWWpk89Z4/39Ud304fq3N5qoG9HxVrrwiXghvj575kpBn/nstK7/CoFpyXqSjSvA38Q==
X-Received: by 2002:a05:6358:6f06:b0:1ad:14ec:9ff7 with SMTP id e5c5f4694b2df-1b15cf882b4mr432011155d.16.1723164069185;
        Thu, 08 Aug 2024 17:41:09 -0700 (PDT)
Received: from localhost.localdomain ([180.69.210.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7b76346b394sm8779613a12.23.2024.08.08.17.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 17:41:08 -0700 (PDT)
From: JaeJoon Jung <rgbi3307@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <levinsasha928@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: JaeJoon Jung <rgbi3307@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	maple-tree@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3] lib/htree: Added get_cycles() to measure execution time
Date: Fri,  9 Aug 2024 09:40:48 +0900
Message-Id: <20240809004048.19511-1-rgbi3307@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Added get_cycles() to measure execution time during insert, find, and erase operations.
Added check_latency() in the lib/test_xarray.c and the lib/test_maple_tree.c
Added likely/unlikely to improve if conditional code.

check_latency() measures latency using get_cycles()
with 1M indices(nr) on XArray and Maple Tree.
The output of this can be used to make the performance comparison table like this:
The numerical unit is cycle.

performance	insert	find	erase
------------------------------------------------
XArray		9	6	16
Maple Tree	11	7	27
Hash Tree	6	2	12
------------------------------------------------

Full source of Hash Tree is also available in the following github link:
https://github.com/kernel-bz/htree.git

Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
---
 lib/htree-test.c      | 90 +++++++++++++++++++++++++++----------------
 lib/htree.c           | 26 ++++++-------
 lib/test_maple_tree.c | 32 +++++++++++++++
 lib/test_xarray.c     | 31 +++++++++++++++
 4 files changed, 132 insertions(+), 47 deletions(-)

diff --git a/lib/htree-test.c b/lib/htree-test.c
index 5bf862706ce2..07c6a144a1be 100644
--- a/lib/htree-test.c
+++ b/lib/htree-test.c
@@ -10,6 +10,7 @@
 #include <linux/moduleparam.h>
 #include <linux/random.h>
 #include <linux/sched.h>
+#include <asm/timex.h>
 
 #include <linux/htree.h>
 
@@ -44,8 +45,8 @@
 */
 
 
-/*
 #define HTREE_DEBUG_INFO
+/*
 #define HTREE_DEBUG_DETAIL
 */
 
@@ -277,7 +278,7 @@ static void htree_debug_hdata(struct htree_state *hts, struct hash_tree *hcurr,
 		"htf_freed",
 	};
 
-	if (!hcurr)
+	if (unlikely(!hcurr))
 		return;
 
 	dept = hts->dept;
@@ -331,7 +332,7 @@ static void __htree_debug_walks_all(struct htree_state *hts,
 
 	for (k = 0; k < anum; k++) {
 		ncnt = ht_ncnt_get(htree[k].next);
-		if (ncnt > 0) {
+		if (likely(ncnt > 0)) {
 			bits = ht_bits_from_depth(hts->sbit, hts->dept);
 			pr_ht_debug("d:%u b:%u [%u] %p (%u): ",
 				    hts->dept, bits, k, &htree[k], ncnt);
@@ -407,14 +408,14 @@ static void __htree_erase_all_lock(struct htree_state *hts,
 
 	for (k = 0; k < anum; k++) {
 		ncnt = ht_ncnt_get(htree[k].next);
-		if (ncnt > 0) {
+		if (likely(ncnt > 0)) {
 			bits = ht_bits_from_depth(hts->sbit, hts->dept);
 			hlist_for_each_entry_safe(pos, tmp,
 						  &htree[k].head, hnode) {
 				hlist_del(&pos->hnode);
 				udata = hlist_entry_safe(pos, 
 						struct data_struct, hdata);
-				if (udata) {
+				if (likely(udata)) {
 					kfree(udata);
 					(*erased)++;
 				}
@@ -478,17 +479,20 @@ static u64 _htree_insert_range(struct htree_state *hts, struct htree_root *root,
 {
 	u64 index;
 	u64 loop = 0, ins = 0, era = 0;
+	cycles_t time1, time2;
+	u64 latency;
 	struct data_struct *udata;
 	struct htree_data *rdata;
 
 	pr_ht_info("[++++) inserting: [s:%llu ... e:%llu] (g:%llu)\n",
 		   start, end, gap);
+	time1 = get_cycles();
 	for (index = start; index <= end; index += gap) {
 		udata = _htree_data_alloc(index);
 		rdata = ht_insert_lock(hts, root, &udata->hdata, req);
 		if (req == htf_erase && rdata) {
 			udata = hlist_entry_safe(rdata, struct data_struct, hdata);
-			if (udata && rdata->index == index) {
+			if (likely((udata && rdata->index == index))) {
 				kfree(udata);
 				era++;
 			}
@@ -498,8 +502,10 @@ static u64 _htree_insert_range(struct htree_state *hts, struct htree_root *root,
 		if (!(loop % HTREE_TEST_SCHED_CNT))
 			schedule();
 	}
-	pr_ht_info("(++++] done: loop:%llu, inserted:%llu, same erased:%llu\n\n",
-		   loop, ins, era);
+	time2 = get_cycles();
+	latency = div_u64(time2 - time1, loop);
+	pr_ht_info("(++++] done: loop:%llu, inserted:%llu, same erased:%llu, \
+latency:%llu cycles\n\n", loop, ins, era, latency);
 
 	return ins - era;
 }
@@ -517,16 +523,19 @@ static u64 _htree_find_range(struct htree_state *hts, struct htree_root *root,
 {
 	u64 index;
 	u64 loop = 0, found = 0;
+	cycles_t time1, time2;
+	u64 latency;
 	struct data_struct *udata;
 	struct htree_data *rdata;
 
 	pr_ht_info("[****) finding: [s:%llu ... e:%llu] (g:%llu)\n",
 		   start, end, gap);
+	time1 = get_cycles();
 	for (index = start; index <= end; index += gap) {
 		rdata = ht_find(hts, htree_first_rcu(root), index);
 		if (rdata) {
 			udata = hlist_entry_safe(rdata, struct data_struct, hdata);
-			if (udata && rdata->index == index) {
+			if (likely(udata && rdata->index == index)) {
 				pr_ht_find("*todo: find:<%llu> %c %c %c\n",
 				index, udata->a, (char)udata->b, (char)udata->c);
 				found++;
@@ -537,8 +546,10 @@ static u64 _htree_find_range(struct htree_state *hts, struct htree_root *root,
 		if (!(loop % HTREE_TEST_SCHED_CNT))
 			schedule();
 	}
-	pr_ht_info("(****] done: loop:%llu, found:%llu, diff:%llu\n\n",
-		   loop, found, loop - found);
+	time2 = get_cycles();
+	latency = div_u64(time2 - time1, loop);
+	pr_ht_info("(****] done: loop:%llu, found:%llu, diff:%llu, \
+latency:%llu cycles\n\n", loop, found, loop - found, latency);
 	return found;
 }
 
@@ -555,18 +566,21 @@ static u64 _htree_erase_range(struct htree_state *hts, struct htree_root *root,
 {
 	u64 index;
 	u64 loop = 0, erased = 0;
+	cycles_t time1, time2;
+	u64 latency;
 	struct hash_tree *htree;
 	struct data_struct *udata;
 	struct htree_data *rdata;
 
 	pr_ht_info("[----) erasing: [s:%llu ... e:%llu] (g:%llu)\n",
 		   start, end, gap);
+	time1 = get_cycles();
 	for (index = start; index <= end; index += gap) {
 		htree = htree_first_rcu(root);
 		rdata = ht_erase_lock(hts, root, index);
 		if (rdata) {
 			udata = hlist_entry_safe(rdata, struct data_struct, hdata);
-			if (udata && rdata->index == index) {
+			if (likely(udata && rdata->index == index)) {
 				pr_ht_erase("*todo: erase:<%llu> %c %c %c\n",
 				index, udata->a, (char)udata->b, (char)udata->c);
 				kfree(udata);
@@ -582,8 +596,10 @@ static u64 _htree_erase_range(struct htree_state *hts, struct htree_root *root,
 		if (!(loop % HTREE_TEST_SCHED_CNT))
 			schedule();
 	}
-	pr_ht_info("(----] done: loop:%llu, erased:%llu, diff:%llu\n\n",
-		   loop, erased, loop - erased);
+	time2 = get_cycles();
+	latency = div_u64(time2 - time1, loop);
+	pr_ht_info("(----] done: loop:%llu, erased:%llu, diff:%llu, \
+latency:%llu cycles\n\n", loop, erased, loop - erased, latency);
 	return erased;
 }
 
@@ -600,18 +616,21 @@ static u64 _htree_update_range(struct htree_state *hts, struct htree_root *root,
 {
 	u64 index;
 	u64 loop = 0, updated = 0;
+	cycles_t time1, time2;
+	u64 latency;
 	struct hash_tree *htree;
 	struct data_struct *udata;
 	struct htree_data *rdata;
 
 	pr_ht_info("[####) updating: [s:%llu ... e:%llu] (g:%llu)\n",
 		   start, end, gap);
+	time1 = get_cycles();
 	for (index = start; index <= end; index += gap) {
 		htree = htree_first_rcu(root);
 		rdata = ht_find(hts, htree, index);
 		if (rdata) {
 			udata = hlist_entry_safe(rdata, struct data_struct, hdata);
-			if (udata && rdata->index == index) {
+			if (likely(udata && rdata->index == index)) {
 				pr_ht_update("*todo: update:<%llu> %c %c %c ",
 				index, udata->a, (char)udata->b, (char)udata->c);
 				/* todo: update user defined data */
@@ -633,8 +652,11 @@ static u64 _htree_update_range(struct htree_state *hts, struct htree_root *root,
 		if (!(loop % HTREE_TEST_SCHED_CNT))
 			schedule();
 	}
-	pr_ht_info("(####] done: loop:%llu, updated:%llu, diff:%llu\n\n",
-		   loop, updated, loop - updated);
+	time2 = get_cycles();
+	latency = div_u64(time2 - time1, loop);
+	pr_ht_info("(####] done: loop:%llu, updated:%llu, diff:%llu, \
+latency: %llu cycles\n\n",
+		   loop, updated, loop - updated, latency);
 
 	return updated;
 }
@@ -651,7 +673,7 @@ static void _htree_statis(struct htree_state *hts, struct htree_root *root)
 
 	ht_statis(hts, htree_first_rcu(root), &acnt, &dcnt);
 
-	if (hts->dcnt == dcnt && hts->acnt == acnt) {
+	if (likely(hts->dcnt == dcnt && hts->acnt == acnt)) {
 		pr_ht_info("[ OK ] statist: acnt:%d, dcnt:%llu ", acnt, dcnt);
 	} else {
 		pr_ht_info("[FAIL] statist: acnt:%d(%d), dcnt:%llu(%llu)\n",
@@ -676,7 +698,7 @@ static void _htree_statis_info(struct htree_state *hts, struct htree_root *root)
 	u64 dsum = (sizd * hts->dcnt) >> 10;
 	u64 smem = hsum + dsum;
 
-	if (hts->asum == 0)
+	if (unlikely(hts->asum == 0))
 		_htree_statis(hts, root);
 
 	pr_ht_stat("------------------------------------------\n");
@@ -711,7 +733,7 @@ static void _htree_get_most_index(struct htree_state *hts, struct htree_root *ro
 	struct htree_data *hdata;
 
 	hdata = ht_most_index(hts, htree_first_rcu(root));
-	if (hdata) {
+	if (likely(hdata)) {
 		if (hts->sort == HTREE_FLAG_ASCD) {
 			pr_ht_stat("[MOST] smallest index:%llu\n\n", hdata->index);
 		} else {
@@ -730,13 +752,13 @@ static void _htree_remove_all(struct htree_state *hts, struct htree_root *root)
 {
 	/* remove all udata */
 	hts->dcnt -= htree_erase_all_lock(hts, root);
-	if (hts->dcnt != 0) {
+	if (unlikely(hts->dcnt != 0)) {
 		pr_ht_warn("[WARN] erase remained acnt:%d, dcnt:%llu\n\n",
 			   hts->acnt, hts->dcnt);
 	}
 
 	/* remove all hash trees */
-	if (ht_destroy_lock(hts, root) == htf_ok) {
+	if (likely(ht_destroy_lock(hts, root) == htf_ok)) {
 		pr_ht_stat("[ OK ] destroy remained acnt:%d, dcnt:%llu\n\n",
 			   hts->acnt, hts->dcnt);
 	} else {
@@ -761,7 +783,7 @@ static u64 _htree_test_index_loop(struct htree_state *hts, u64 start, u64 end)
 	u64 inserted, found, erased, updated;
 	u64 dcnt, slice;
 
-	if (start > end)
+	if (unlikely(start > end))
 		return 0;
 	slice = (end - start) / 10 + 2;
 
@@ -769,7 +791,7 @@ static u64 _htree_test_index_loop(struct htree_state *hts, u64 start, u64 end)
 	htree_root_alloc(hts, &ht_root);
 
 	inserted = _htree_insert_range(hts, &ht_root, start, end, 1, htf_ins);
-	if (inserted != hts->dcnt) {
+	if (unlikely(inserted != hts->dcnt)) {
 		pr_ht_err("[FAIL] inserted:%llu, dcnt:%llu, diff:%lld\n\n",
 			  inserted, hts->dcnt, inserted - hts->dcnt);
 	}
@@ -778,7 +800,7 @@ static u64 _htree_test_index_loop(struct htree_state *hts, u64 start, u64 end)
 
 	erased = _htree_erase_range(hts, &ht_root, start, end, slice);
 	found = _htree_find_range(hts, &ht_root, start, end, slice);
-	if (found) {
+	if (unlikely(found)) {
 		pr_ht_err("[FAIL] erased:%llu, found:%llu, diff:%lld\n\n",
 			  erased, found, erased - found);
 	}
@@ -787,7 +809,7 @@ static u64 _htree_test_index_loop(struct htree_state *hts, u64 start, u64 end)
 
 	inserted = _htree_insert_range(hts, &ht_root, start, end, slice, htf_ins);
 	updated = _htree_update_range(hts, &ht_root, start, end, slice);
-	if (inserted != updated) {
+	if (unlikely(inserted != updated)) {
 		pr_ht_err("[FAIL] inserted:%llu, updated:%llu, diff:%lld\n\n",
 			  inserted, updated, inserted - updated);
 	}
@@ -916,7 +938,7 @@ static void _htree_test_idx_random(u8 idx_type, u8 sort_type, u64 maxnr)
 
 		udata = _htree_data_alloc(index);
 		rdata = ht_insert_lock(hts, &ht_root, &udata->hdata, htf_ins);
-		if (!rdata)
+		if (likely(!rdata))
 			inserted++;
 		loop++;
 		if (!(loop % HTREE_TEST_SCHED_CNT))
@@ -926,7 +948,7 @@ static void _htree_test_idx_random(u8 idx_type, u8 sort_type, u64 maxnr)
 	_htree_statis(hts, &ht_root);
 
 	rdata = ht_find(hts, htree_first_rcu(&ht_root), check_idx);
-	if (!rdata) {
+	if (unlikely(!rdata)) {
 		pr_ht_err("[FAIL] NOT found check index:%llu\n\n", check_idx);
 	}
 
@@ -939,7 +961,7 @@ static void _htree_test_idx_random(u8 idx_type, u8 sort_type, u64 maxnr)
 		rdata = ht_erase_lock(hts, &ht_root, index);
 		if (rdata) {
 			udata = hlist_entry_safe(rdata, struct data_struct, hdata);
-			if (udata && rdata->index == index) {
+			if (likely(udata && rdata->index == index)) {
 				pr_ht_erase("*todo: erase:<%llu> %c %c %c\n",
 				index, udata->a, (char)udata->b, (char)udata->c);
 				kfree(udata);
@@ -954,7 +976,7 @@ static void _htree_test_idx_random(u8 idx_type, u8 sort_type, u64 maxnr)
 	_htree_statis(hts, &ht_root);
 
 	rdata = ht_find(hts, htree_first_rcu(&ht_root), check_idx);
-	if (!rdata) {
+	if (unlikely(!rdata)) {
 		pr_ht_info("[INFO] check index:%llu (erased)\n\n", check_idx);
 	}
 
@@ -1006,7 +1028,7 @@ static void _htree_test_index_same(u8 idx_type, u8 sort_type, u64 maxnr)
 
 	pr_ht_stat("[loop) %llu: new index inserting(htf_ins)\n\n", maxnr);
 	inserted = _htree_insert_range(hts, &ht_root, 0, maxnr, gap - 1, htf_ins);
-	if (inserted != hts->dcnt) {
+	if (unlikely(inserted != hts->dcnt)) {
 		pr_ht_err("[FAIL] inserted:%llu, dcnt:%llu, diff:%lld\n\n",
 			  inserted, hts->dcnt, inserted - hts->dcnt);
 	}
@@ -1015,20 +1037,20 @@ static void _htree_test_index_same(u8 idx_type, u8 sort_type, u64 maxnr)
 
 	pr_ht_stat("[loop) %llu: SAME index inserting(htf_erase)\n\n", maxnr);
 	inserted = _htree_insert_range(hts, &ht_root, 1, maxnr, gap, htf_erase);
-	if (inserted != 0) {
+	if (unlikely(inserted != 0)) {
 		pr_ht_err("[FAIL] inserted:%llu, dcnt:%llu, diff:%lld\n\n",
 			  inserted, hts->dcnt, inserted - hts->dcnt);
 	}
 
 	pr_ht_stat("[loop) %llu: SAME index inserting(htf_ins)\n\n", maxnr);
 	inserted = _htree_insert_range(hts, &ht_root, 1, maxnr, gap, htf_ins);
-	if (inserted != (maxnr / gap)) {
+	if (unlikely(inserted != (maxnr / gap))) {
 		pr_ht_err("[FAIL] inserted:%llu, dcnt:%llu, diff:%lld\n\n",
 			  inserted, hts->dcnt, inserted - hts->dcnt);
 	}
 
 	found = _htree_find_range(hts, &ht_root, 0, maxnr, gap - 1);
-	if (found != (hts->dcnt - inserted)) {
+	if (unlikely(found != (hts->dcnt - inserted))) {
 		pr_ht_err("[FAIL] dcnt:%llu, inserted:%llu, found:%llu\n\n",
 			  hts->dcnt, inserted, found);
 	}
diff --git a/lib/htree.c b/lib/htree.c
index 1fcdb8d69730..54e5e6c5f5d1 100644
--- a/lib/htree.c
+++ b/lib/htree.c
@@ -114,7 +114,7 @@ static enum ht_flags __ht_find(struct htree_state *hts, struct hash_tree *htree,
 _retry:
 	*rtree = htree;
 	ncnt = ht_ncnt_get(htree[hts->hkey].next);
-	if (ncnt == 0)
+	if (unlikely(ncnt == 0))
 		goto _next_step;
 
 	hlist_for_each_entry(pos, &htree[hts->hkey].head, hnode) {
@@ -180,7 +180,7 @@ struct htree_data *ht_find(struct htree_state *hts,
 	struct htree_data *rdata = NULL;
 	struct hash_tree *rtree;
 
-	if (!htree)
+	if (unlikely(!htree))
 		return NULL;
 
 	if (_ht_find(hts, htree, index, &rdata, &rtree) == htf_find)
@@ -232,7 +232,7 @@ static void _ht_move_to_next(struct htree_state *hts, struct htree_data *sdata,
 	}
 
 	ncnt = ht_ncnt_get(ntree[hkey].next);
-	if (ncnt == 0) {
+	if (unlikely(ncnt == 0)) {
 		htree_add_head(ntree, &edata->hnode, hkey);
 		goto _next;
 	}
@@ -292,7 +292,7 @@ static void _ht_insert(struct htree_state *hts, struct hash_tree *htree,
 	hts->hkey = ht_get_hkey(index, hts->dept, bits, hts->idxt);
 	ncnt = ht_ncnt_get(htree[hts->hkey].next);
 
-	if (ncnt == 0) {
+	if (unlikely(ncnt == 0)) {
 		htree_add_head(htree, &hdata->hnode, hts->hkey);
 		goto _finish;
 	}
@@ -348,7 +348,7 @@ struct htree_data *ht_insert(struct htree_state *hts, struct hash_tree *htree,
 	struct hash_tree *rtree = NULL;
 	enum ht_flags htf;
 
-	if (!htree)
+	if (unlikely(!htree))
 		return NULL;
 
 	htf = _ht_find(hts, htree, hdata->index, &rdata, &rtree);
@@ -379,7 +379,7 @@ static enum ht_flags ___ht_erase(struct htree_state *hts,
 		if (htree[k].next)
 			break;
 
-	if (k == anum) {
+	if (unlikely(k == anum)) {
 		kfree(htree);
 		hts->acnt--;
 		hts->dept--;
@@ -408,7 +408,7 @@ static int __ht_erase(struct htree_state *hts, struct hash_tree *htree,
 	ncnt = ht_ncnt_get(htree[key].next);
 	bits = ht_bits_from_depth(hts->sbit, hts->dept);
 
-	if (ncnt == 0)
+	if (unlikely(ncnt == 0))
 		goto _next_step;
 
 	hlist_for_each_entry_safe(pos, tmp, &htree[key].head, hnode) {
@@ -429,7 +429,7 @@ static int __ht_erase(struct htree_state *hts, struct hash_tree *htree,
 		}
 	}
 
-	if (ncnt == 0)
+	if (unlikely(ncnt == 0))
 		ret = ___ht_erase(hts, htree, bits);
 
 	if (ret > htf_none)	/* erased or freed */
@@ -444,7 +444,7 @@ static int __ht_erase(struct htree_state *hts, struct hash_tree *htree,
 		/* must be recursive call */
 		ret = __ht_erase(hts, _next, rdata, index);
 
-		if (ret == htf_freed) {
+		if (unlikely(ret == htf_freed)) {
 			WRITE_ONCE(htree[key].next, ht_ncnt_set(NULL, ncnt));
 			ret = htf_erase;
 		}
@@ -484,7 +484,7 @@ struct htree_data *ht_erase(struct htree_state *hts,
 {
 	struct htree_data *rdata = NULL;
 
-	if (!htree)
+	if (unlikely(!htree))
 		return NULL;
 
 	if (_ht_erase(hts, htree, &rdata, index) == htf_erase)
@@ -558,7 +558,7 @@ enum ht_flags ht_destroy_lock(struct htree_state *hts, struct htree_root *root)
 		return htf_ok;
 
 	htree = htree_first_rcu(root);
-	if (!htree)
+	if (unlikely(!htree))
 		return htf_none;
 
 	hts->dept = 0;
@@ -598,7 +598,7 @@ static void __ht_statis(struct htree_state *hts,
 
 	for (k = 0; k < anum; k++) {
 		ncnt = ht_ncnt_get(htree[k].next);
-		if (ncnt > 0) {
+		if (likely(ncnt > 0)) {
 			(*dcnt) += ncnt;
 		}
 		_next = ht_ncnt_pointer(htree[k].next);
@@ -631,7 +631,7 @@ void ht_statis(struct htree_state *hts,
 	hts->dept = 0;
 	hts->dmax = 0;
 
-	if (!htree)
+	if (unlikely(!htree))
 		return;
 
 	__ht_statis(hts, htree, acnt, dcnt);
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 31561e0e1a0d..dbc332d15e9d 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -10,6 +10,7 @@
 #include <linux/maple_tree.h>
 #include <linux/module.h>
 #include <linux/rwsem.h>
+#include <asm/timex.h>
 
 #define MTREE_ALLOC_MAX 0x2000000000000Ul
 #define CONFIG_MAPLE_SEARCH
@@ -3638,6 +3639,34 @@ static noinline void __init alloc_cyclic_testing(struct maple_tree *mt)
 	MT_BUG_ON(mt, ret != 1);
 }
 
+static noinline void check_latency(struct maple_tree *mt)
+{
+        MA_STATE(mas, mt, 25203307, 25203307);
+        cycles_t time1, time2;
+        void *val;
+        unsigned long i, cnt = 1 << 20;
+
+        for (i = 0; i < cnt; i++)
+                mtree_store(mt, i, xa_mk_value(i), GFP_KERNEL);
+
+        pr_info("\n*check_latency(): index nr:%lu\n", cnt);
+
+        time1 = get_cycles();
+        mtree_store(mt, cnt, xa_mk_value(cnt), GFP_KERNEL);
+        time2 = get_cycles();
+        pr_info("mtree_store(): latency:%lu cycles\n", time2 - time1);
+
+        time1 = get_cycles();
+        val = mas_find(&mas, ULONG_MAX);
+        time2 = get_cycles();
+        pr_info("mas_find(): latency:%lu cycles\n", time2 - time1);
+
+        time1 = get_cycles();
+        mtree_erase(mt, cnt);
+        time2 = get_cycles();
+        pr_info("mtree_erase(): latency:%lu cycles\n", time2 - time1);
+}
+
 static DEFINE_MTREE(tree);
 static int __init maple_tree_seed(void)
 {
@@ -3923,6 +3952,9 @@ static int __init maple_tree_seed(void)
 	alloc_cyclic_testing(&tree);
 	mtree_destroy(&tree);
 
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+        check_latency(&tree);
+        mtree_destroy(&tree);
 
 #if defined(BENCH)
 skip:
diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index d5c5cbba33ed..02fa3c95428d 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -8,6 +8,7 @@
 
 #include <linux/xarray.h>
 #include <linux/module.h>
+#include <asm/timex.h>
 
 static unsigned int tests_run;
 static unsigned int tests_passed;
@@ -2125,6 +2126,34 @@ static noinline void check_destroy(struct xarray *xa)
 #endif
 }
 
+static noinline void check_latency(struct xarray *xa)
+{
+        unsigned long i, index;
+        unsigned long cnt = 1 << 20;
+        cycles_t time1, time2;
+
+        for (i = 0; i < cnt; i++)
+                xa_store(xa, i, xa_mk_index(i), GFP_KERNEL);
+
+        pr_info("\n*check_latency: index nr:%lu\n", cnt);
+        index = 25203307;
+
+        time1 = get_cycles();
+        xa_store(xa, index, xa_mk_index(index), GFP_KERNEL);
+        time2 = get_cycles();
+        pr_info("xa_store(): latency: %lu cycles\n", time2 - time1);
+
+        time1 = get_cycles();
+        xa_find(xa, &index, ULONG_MAX, XA_PRESENT);
+        time2 = get_cycles();
+        pr_info("xa_find(): latency: %lu cycles\n", time2 - time1);
+
+        time1 = get_cycles();
+        xa_erase(xa, index);
+        time2 = get_cycles();
+        pr_info("xa_erase(): latency: %lu cycles\n", time2 - time1);
+}
+
 static DEFINE_XARRAY(array);
 
 static int xarray_checks(void)
@@ -2162,6 +2191,8 @@ static int xarray_checks(void)
 	check_workingset(&array, 64);
 	check_workingset(&array, 4096);
 
+	check_latency(&array);
+
 	printk("XArray: %u of %u tests passed\n", tests_passed, tests_run);
 	return (tests_run == tests_passed) ? 0 : -EINVAL;
 }
-- 
2.17.1


