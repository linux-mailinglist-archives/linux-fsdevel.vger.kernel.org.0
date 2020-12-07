Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0AD2D0F79
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgLGLf0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgLGLfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:35:25 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63C7C061A4F;
        Mon,  7 Dec 2020 03:34:44 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 131so9600683pfb.9;
        Mon, 07 Dec 2020 03:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PsVgOpQIgSKKX9sKyFMtyV6DCXy6X7BZeXZh0AyMkHE=;
        b=QMmaSsp/kPkYAOoJQsM9EoXqVH9lanjFe06YoMyS63YE92kVOJCcMfFXgEA7yjn87P
         y28+hU0OuDWvBX7SY2rxnQlWNrE6D+KzZK9M4ko1y+IRrfeYC8ZoXYQ5j/FHutEdRnUA
         CFnWcAyRmrIXQyQXqs6RE+G5CKAhGupvDHeYaQpkizYK/LR7w2A0MDaQ4i13inwSb1f4
         eMV/GFBnZ9S+DZABkEr6AOMkeB8HeEP6uKXvczuBshAKSC1DzmYlsaa6DQXz6YZzMVS5
         wqQYorLHoqsJF9fPQ4cEzpX39pO4YzMWouHhku6ju81R+o5U+fSNpP/dEc35m36/1jNg
         h5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PsVgOpQIgSKKX9sKyFMtyV6DCXy6X7BZeXZh0AyMkHE=;
        b=SkbDFoSSJul67cdFkum1nIGzKzra0pYFXPX5CvbicepGJqTO/LUgryv0srH3CfsTkJ
         03rYXVSabe6c3UN4vdAO9b81+hnVEGIONvQLt2qvNSplyQrV+s8eHAy4qxurrxMD3FUl
         iweDGmK0oaMAyKGrfGUH+WnxKNzF7nbWnGxvUzokuCLP6mBCht29ZQFlJpblLiWOKYj7
         d2tgqZobVrD7EPusGsKhpY9O32LeXmZ0xqq2vCBFCjdW1b0f1lF58SWFPZV3MZdxtifA
         PHlNhLddj7Cl3v3u1IPK0/yrFRIZDj4ucOHtyqV7aaBolVyLIvagM8fdGCWJYEwTOOP1
         GkeQ==
X-Gm-Message-State: AOAM5334Ic4Wt9FENMjvCOs7mAxy0Lm+N2tYvsk3EIAySto1uwecgb+W
        xyatGRLORSu4EG+wSrZbiF0=
X-Google-Smtp-Source: ABdhPJynrUsQxj48xNiMU/huEKvcNjt/ObGmP+cORAqqJJ7WrkW6MqDOQEZH+sv1gpYZpKvKfsdZ0g==
X-Received: by 2002:a62:6d06:0:b029:19d:9728:2b71 with SMTP id i6-20020a626d060000b029019d97282b71mr15195431pfc.69.1607340884475;
        Mon, 07 Dec 2020 03:34:44 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.34.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:34:44 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [RFC V2 19/37] mm: gup_huge_pmd() for dmem huge pmd
Date:   Mon,  7 Dec 2020 19:31:12 +0800
Message-Id: <1a8eaaf72af4bd98c8fa1a90d36a64612f7c14b0.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Add pmd_special() check in gup_huge_pmd() to support dmem huge pmd.
GUP will return zero if enconter dmem page, and we could handle it
outside GUP routine.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 mm/gup.c      | 6 +++++-
 mm/pagewalk.c | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ad1aede..47c8197 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2470,6 +2470,10 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	if (!pmd_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
+	/* Bypass dmem huge pmd. It will be handled in outside routine. */
+	if (pmd_special(orig))
+		return 0;
+
 	if (pmd_devmap(orig)) {
 		if (unlikely(flags & FOLL_LONGTERM))
 			return 0;
@@ -2572,7 +2576,7 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
 			return 0;
 
 		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd) ||
-			     pmd_devmap(pmd))) {
+			     pmd_devmap(pmd) || pmd_special(pmd))) {
 			/*
 			 * NUMA hinting faults need to be handled in the GUP
 			 * slowpath for accounting purposes and so that they
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index e81640d..e7c4575 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -71,7 +71,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 	do {
 again:
 		next = pmd_addr_end(addr, end);
-		if (pmd_none(*pmd) || (!walk->vma && !walk->no_vma)) {
+		if (pmd_none(*pmd) || (!walk->vma && !walk->no_vma) || pmd_special(*pmd)) {
 			if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
 			if (err)
-- 
1.8.3.1

