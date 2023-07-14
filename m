Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6009F753543
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 10:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbjGNIok (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 04:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbjGNIog (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:44:36 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311A12701
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 01:44:31 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230714084428epoutp0184618052c0e80faae5248d35103caae3~xr3jRJjFw2633726337epoutp01X
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 08:44:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230714084428epoutp0184618052c0e80faae5248d35103caae3~xr3jRJjFw2633726337epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689324268;
        bh=jCixhGitxuy0+wkzMAMbT5vldcqoFl060dWpDRTxXbo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=CG5KrflUPVyfhKkC9girhV90nGtSbZf3gTXkxSn5lvRwN6ttoX/LWe3q/rVQ3/wBb
         03YvbrwBylj3i3QJ4fzLTmaGfkqSp+UYdclEzPHAn0aW3Vld0xQ1iAr0Il3NHKIyt7
         hmAV9jbz+nKF+vwn70RAVTuFrioIXLCgM7mPgz7E=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230714084428epcas1p388583486e99e57700ebbcd52982ba721~xr3isUJ6h2998429984epcas1p3d;
        Fri, 14 Jul 2023 08:44:28 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.241]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4R2Q574wvqz4x9Pw; Fri, 14 Jul
        2023 08:44:27 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.21.27561.BEA01B46; Fri, 14 Jul 2023 17:44:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230714084427epcas1p2ce3efb1524c8efae6038d1940149ae54~xr3hwMja21505315053epcas1p24;
        Fri, 14 Jul 2023 08:44:27 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230714084427epsmtrp2df9ffff115b17eb733eba2aab52f7856~xr3hvkQr21755817558epsmtrp2G;
        Fri, 14 Jul 2023 08:44:27 +0000 (GMT)
X-AuditID: b6c32a37-98ffc70000006ba9-b8-64b10aeb39e8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.F3.64355.AEA01B46; Fri, 14 Jul 2023 17:44:26 +0900 (KST)
Received: from u20pb1-0435.tn.corp.samsungelectronics.net (unknown
        [10.91.133.14]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230714084426epsmtip22100f33b3ded7defa2ed6b8737f85b32~xr3hnAqrj0524405244epsmtip2n;
        Fri, 14 Jul 2023 08:44:26 +0000 (GMT)
From:   Sungjong Seo <sj1557.seo@samsung.com>
To:     linkinjeon@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sungjong Seo <sj1557.seo@samsung.com>, stable@vger.kernel.org,
        syzbot+1741a5d9b79989c10bdc@syzkaller.appspotmail.com
Subject: [PATCH] exfat: release s_lock before calling dir_emit()
Date:   Fri, 14 Jul 2023 17:43:54 +0900
Message-Id: <20230714084354.1959951-1-sj1557.seo@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRmVeSWpSXmKPExsWy7bCmru5rro0pBk+XKFtMnLaU2WLP3pMs
        Fpd3zWGz2PLvCKvFgo2PGC1ev5FxYPPYtKqTzaNvyypGj5lv1Tw+b5ILYIlqYLRJLErOyCxL
        VUjNS85PycxLt1UKDXHTtVBSyMgvLrFVijY0NNIzNDDXMzIy0jM1irUyMlVSyEvMTbVVqtCF
        6lVSKEouAKrNrSwGGpCTqgcV1ytOzUtxyMovBblXrzgxt7g0L10vOT9XSaEsMacUaISSfsI3
        xowdm2czFuxVrLj/yLCB8YNUFyMnh4SAicTxRw8Zuxi5OIQEdjBKXD2ygBkkISTwiVGiezc3
        RALIPr91BlsXIwdYx7eVchDxnYwSs5YeYYRoaGeS6PvLAWKzCWhLLG9axgxSLyIgKbH2fipI
        PTNI/enWyUwgNcICDhKvvi8DW8YioCrx9u1edhCbV8BWYn7/dGaI6+QlZl76DhUXlDg58wkL
        iM0MFG/eOpsZZKiEwDZ2iTOrLjFDHOcicX1iHESvsMSr41vYIWwpic/v9rJB1HczShz/+I4F
        IjGDUWJJhwOEbS/R3NoM9iSzgKbE+l36EGFFiZ2/5zJC7OWTePe1hxUiLihx+lo31FpeiY42
        IYiwisT3DztZYNZe+XGVCcL2kDi9cjUbJKhiJR4c/cQ0gVFhFpLPZiH5bBbCEQsYmVcxiqUW
        FOempxYbFhgjR/AmRnDq1DLfwTjt7Qe9Q4xMHIyHGCU4mJVEeFW2rUsR4k1JrKxKLcqPLyrN
        SS0+xJgMDOuJzFKiyfnA5J1XEm9oZmZpYWlkYmhsZmhIWNjE0sDEzMjEwtjS2ExJnPfWs94U
        IYH0xJLU7NTUgtQimC1MHJxSDUzCRg9eHAjlf8uwqtxyYtGqr9plxyY2vhA4eepTVve+byJH
        09gn/Dl64BJve5bRetemnfUJ+zWzfVoylpocub1N69h068uHtaYHMp5z2vJubmyC4/dbsX93
        fs9NeLzs/OraLxOzzl1dte9q68Tvj9WX1km+/sEssinGfW19y7rrOw9fWLrI90/nilO/q8/r
        SIu+mWglGFl8suioYJ5Pdpt0sNj5yDVJ6+S+Wa2+Pv0fa0Cc4qurap37xH9tDEna1rFoUfGp
        B56rdC2DHFSjvmQdTnc+q9Ww5uzMcK0DydcLJrgzTpkk9+5kz+M519kXnlPeuWBpvdq8/OLJ
        +xsiX/5hTjblD3/IIl//+9S2VrYpLUosxRmJhlrMRcWJALvTxCVUBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsWy7bCSvO5rro0pBht4LSZOW8pssWfvSRaL
        y7vmsFls+XeE1WLBxkeMFq/fyDiweWxa1cnm0bdlFaPHzLdqHp83yQWwRHHZpKTmZJalFunb
        JXBl7Ng8m7Fgr2LF/UeGDYwfpLoYOTgkBEwkvq2U62Lk4hAS2M4osXLGEVaIuJTEwX2aEKaw
        xOHDxRAlrUwSZ1fPY+xi5ORgE9CWWN60jBmkRkRAUmLt/VSQMLPAXkaJK3eEQWxhAQeJV99B
        Sjg5WARUJd6+3csOYvMK2ErM758OFpcQkJeYeek7VFxQ4uTMJywQc+QlmrfOZp7AyDcLSWoW
        ktQCRqZVjKKpBcW56bnJBYZ6xYm5xaV56XrJ+bmbGMGhpxW0g3HZ+r96hxiZOBgPMUpwMCuJ
        8KpsW5cixJuSWFmVWpQfX1Sak1p8iFGag0VJnFc5pzNFSCA9sSQ1OzW1ILUIJsvEwSnVwJRz
        tsMzZMdbkd+Fs9j983mn3+Zdd8BlxvWjp3mXZdj/WztxdryQencY/3bWtGUeVvvUruluPfxS
        uTlHuqC+8PWHgiNXqo+sTv8qpLR1f1JV06G5LrMqPVZf2qJY+6zc826ZtYjubh69Xe6vy//q
        XBXgXFuuKtxQXtAdck3g4xnW/6b713CVSb0+/uzi39L450r1uw/cPPuUfWFoV/PbSzedrtkm
        GxtlnDCdE3D9r0T0x42lbTq2ERw5pv/SQ3R+mclH8d03sj+Wdl7v68yHoptsecTlC+7ezj71
        lm3Oc4HfybX/+jsvLorVKY5tLO24vv3c5nP72RVMRHaUX7v/IHr3BF/hC/Kf01NmdXSqlymx
        FGckGmoxFxUnAgA7QcB6rAIAAA==
X-CMS-MailID: 20230714084427epcas1p2ce3efb1524c8efae6038d1940149ae54
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230714084427epcas1p2ce3efb1524c8efae6038d1940149ae54
References: <CGME20230714084427epcas1p2ce3efb1524c8efae6038d1940149ae54@epcas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a potential deadlock reported by syzbot as below:

======================================================
WARNING: possible circular locking dependency detected
6.4.0-next-20230707-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor330/5073 is trying to acquire lock:
ffff8880218527a0 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock_killable include/linux/mmap_lock.h:151 [inline]
ffff8880218527a0 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:5293 [inline]
ffff8880218527a0 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x369/0x510 mm/memory.c:5344
but task is already holding lock:
ffff888019f760e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_iterate+0x117/0xb50 fs/exfat/dir.c:232

which lock already depends on the new lock.

Chain exists of:
  &mm->mmap_lock --> mapping.invalidate_lock#3 --> &sbi->s_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->s_lock);
                               lock(mapping.invalidate_lock#3);
                               lock(&sbi->s_lock);
  rlock(&mm->mmap_lock);

Let's try to avoid above potential deadlock condition by moving dir_emit*()
out of sbi->s_lock coverage.

Fixes: ca06197382bd ("exfat: add directory operations")
Cc: stable@vger.kernel.org #v5.7+
Reported-by: syzbot+1741a5d9b79989c10bdc@syzkaller.appspotmail.com
Link: https://lore.kernel.org/lkml/00000000000078ee7e060066270b@google.com/T/#u
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/dir.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 957574180a5e..4e3743341ce7 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -214,7 +214,10 @@ static void exfat_free_namebuf(struct exfat_dentry_namebuf *nb)
 	exfat_init_namebuf(nb);
 }
 
-/* skip iterating emit_dots when dir is empty */
+/*
+ * Before calling dir_emit*(), sbi->s_lock should be released
+ * because page fault can occur in dir_emit*().
+ */
 #define ITER_POS_FILLED_DOTS    (2)
 static int exfat_iterate(struct file *file, struct dir_context *ctx)
 {
@@ -229,11 +232,10 @@ static int exfat_iterate(struct file *file, struct dir_context *ctx)
 	int err = 0, fake_offset = 0;
 
 	exfat_init_namebuf(nb);
-	mutex_lock(&EXFAT_SB(sb)->s_lock);
 
 	cpos = ctx->pos;
 	if (!dir_emit_dots(file, ctx))
-		goto unlock;
+		goto out;
 
 	if (ctx->pos == ITER_POS_FILLED_DOTS) {
 		cpos = 0;
@@ -245,16 +247,18 @@ static int exfat_iterate(struct file *file, struct dir_context *ctx)
 	/* name buffer should be allocated before use */
 	err = exfat_alloc_namebuf(nb);
 	if (err)
-		goto unlock;
+		goto out;
 get_new:
+	mutex_lock(&EXFAT_SB(sb)->s_lock);
+
 	if (ei->flags == ALLOC_NO_FAT_CHAIN && cpos >= i_size_read(inode))
 		goto end_of_dir;
 
 	err = exfat_readdir(inode, &cpos, &de);
 	if (err) {
 		/*
-		 * At least we tried to read a sector.  Move cpos to next sector
-		 * position (should be aligned).
+		 * At least we tried to read a sector.
+		 * Move cpos to next sector position (should be aligned).
 		 */
 		if (err == -EIO) {
 			cpos += 1 << (sb->s_blocksize_bits);
@@ -277,16 +281,10 @@ static int exfat_iterate(struct file *file, struct dir_context *ctx)
 		inum = iunique(sb, EXFAT_ROOT_INO);
 	}
 
-	/*
-	 * Before calling dir_emit(), sb_lock should be released.
-	 * Because page fault can occur in dir_emit() when the size
-	 * of buffer given from user is larger than one page size.
-	 */
 	mutex_unlock(&EXFAT_SB(sb)->s_lock);
 	if (!dir_emit(ctx, nb->lfn, strlen(nb->lfn), inum,
 			(de.attr & ATTR_SUBDIR) ? DT_DIR : DT_REG))
-		goto out_unlocked;
-	mutex_lock(&EXFAT_SB(sb)->s_lock);
+		goto out;
 	ctx->pos = cpos;
 	goto get_new;
 
@@ -294,9 +292,8 @@ static int exfat_iterate(struct file *file, struct dir_context *ctx)
 	if (!cpos && fake_offset)
 		cpos = ITER_POS_FILLED_DOTS;
 	ctx->pos = cpos;
-unlock:
 	mutex_unlock(&EXFAT_SB(sb)->s_lock);
-out_unlocked:
+out:
 	/*
 	 * To improve performance, free namebuf after unlock sb_lock.
 	 * If namebuf is not allocated, this function do nothing
-- 
2.25.1

