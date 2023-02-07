Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D731E68CDB8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 04:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjBGDzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 22:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjBGDyn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:54:43 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1946E30EB2;
        Mon,  6 Feb 2023 19:54:12 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id mi9so13686179pjb.4;
        Mon, 06 Feb 2023 19:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hQ1wmYZNKbh6ubCaoCPj3vqYdMi+xiWWNvAtSowi2o=;
        b=K3GuS1yr0W6ph4124TteyvhSGbqph5dx0QX3w7vlsuPsCGZd4P2k77PsEPK5l23VHX
         cnagCyQEot5lD/H6hr+2gBVCvcYfQ0ICQ9bE7IBhyljYwAPPH9yPWzykEWWXSQi/tKOn
         nCkcQkwOnXlnCWQEGRnFKRjqvmk71mRAtOOapfPlKfPfn1q6YlVNo03Qnb+xloHM6ksC
         EfuX664vNfN+VFLbGjTsKWXaPEAjC3aBdSuZ9yKkw6OByEoHab18DU31F0Fl+qY0BhYo
         yL7TRMdYVWaab9Zrd0OXD5QlFZ01/W9XPxuILrCxR2+aBD0NCdQo/ULQ1o4Lc1HGZnnr
         nrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hQ1wmYZNKbh6ubCaoCPj3vqYdMi+xiWWNvAtSowi2o=;
        b=PqIDTHWl+zoS0tPtxRZCz52CE6XqG+RQrRvH9b/lOnh6dnTANZHI354Pt7cuqCtRbY
         Cq1WPhXKtYqRoUcN5eN1xDk8TaI10TemTNNrFTIfkmIlDIUbg0NuPnC2of3Hqa8CqgUh
         dVLiGufkml7YVJSoLesFMDUafbzoreGNlAzRP8i0HfXPcycfppZbUfrKNWaR2fUDX4fq
         bJAqCb82gYopdYdvv8qrljgQtEuSYlypmsrQtaX7d68E1V/CjJLXgLgYEeq2FmN9vwhM
         H3XUdWffVQOBmHxFlQh8esqPyRAkWrYiIEsNkUpUNCSKVe0/XkCfWzOZimP1SdUOSp6S
         H34g==
X-Gm-Message-State: AO0yUKXsMq5M76/gvrTNsxDz9Y3mUjztzcB4ml2/9kF5Mm+PKMi68Xob
        lJl6HX1yxvkkTw5cZ4DetnI=
X-Google-Smtp-Source: AK7set8BweMlzypQiVTtVVURVr8ilTYE/9HKHHuKVpdwfa5VakEqT0QFlksWW1Ae0vdg/3Bbk6hC7g==
X-Received: by 2002:a17:902:f0ca:b0:199:9fa:7553 with SMTP id v10-20020a170902f0ca00b0019909fa7553mr1395163pla.17.1675742051331;
        Mon, 06 Feb 2023 19:54:11 -0800 (PST)
Received: from strix-laptop.hitronhub.home ([123.110.9.95])
        by smtp.googlemail.com with ESMTPSA id q4-20020a170902b10400b0019682e27995sm7647655plr.223.2023.02.06.19.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 19:54:10 -0800 (PST)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>, Barry Song <baohua@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Yu Zhao <yuzhao@google.com>, Juergen Gross <jgross@suse.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Li kunyu <kunyu@nfschina.com>,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        Barret Rhoden <brho@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexey Gladkov <legion@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Chih-En Lin <shiyn.lin@gmail.com>
Subject: [PATCH v4 08/14] mm/gup: Trigger break COW PTE before calling follow_pfn_pte()
Date:   Tue,  7 Feb 2023 11:51:33 +0800
Message-Id: <20230207035139.272707-9-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207035139.272707-1-shiyn.lin@gmail.com>
References: <20230207035139.272707-1-shiyn.lin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In most of cases, GUP will not modify the page table, excluding
follow_pfn_pte(). To deal with COW PTE, Trigger the break COW
PTE fault before calling follow_pfn_pte().

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 mm/gup.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index f45a3a5be53a..e702c0800105 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -545,7 +545,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
 			 (FOLL_PIN | FOLL_GET)))
 		return ERR_PTR(-EINVAL);
-	if (unlikely(pmd_bad(*pmd)))
+	/* COW-ed PTE has write protection which can trigger pmd_bad(). */
+	if (unlikely(pmd_write(*pmd) && pmd_bad(*pmd)))
 		return no_page_table(vma, flags);
 
 	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
@@ -588,6 +589,11 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		if (is_zero_pfn(pte_pfn(pte))) {
 			page = pte_page(pte);
 		} else {
+			if (test_bit(MMF_COW_PTE, &mm->flags) &&
+			    !pmd_write(*pmd)) {
+				page = ERR_PTR(-EMLINK);
+				goto out;
+			}
 			ret = follow_pfn_pte(vma, address, ptep, flags);
 			page = ERR_PTR(ret);
 			goto out;
-- 
2.34.1

