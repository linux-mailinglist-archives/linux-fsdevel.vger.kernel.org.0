Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51E66E25A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjDNO0z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjDNO01 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:26:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E88C144;
        Fri, 14 Apr 2023 07:25:54 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id kh6so16856994plb.0;
        Fri, 14 Apr 2023 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681482353; x=1684074353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tVFETdIXCOfqp++FbGXI8ZTRFNtRU4kz7mKWpQ0TKQ=;
        b=V/L9mGM5vRCilsgFuug2qDo+tf+mz8X3NMe4ExWTkIzgp5PoriAleb9ABHiqBVuzoB
         llo+kuyF6EvctKAWOk7/AgctLIF5nzoIZG8o22MemV1Trqr4GMU4SWQjs7lk4AFfxWZs
         fEFh+J5+1k4h11tgMkVGCwcojSc3VhOk+jlEQkXDF+LG7ADIDJS5DzduuXdI5BA3XzGA
         o5xxBjrwCkRjOkZx09CVQJsh7Y3tKhqCo7zRr9YQVNfXI9o2wXUwtf+xHKgwJyn/eUFx
         DbBL8+08eqWZGvXOjPhYZPEEOFvmlvTmXp2I+hQAV+uqiFqt7yhXiTpblR0eG92ZfVyg
         zMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482353; x=1684074353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tVFETdIXCOfqp++FbGXI8ZTRFNtRU4kz7mKWpQ0TKQ=;
        b=eAPdAV+Kwf65yINl2J7xlqvEhtlEmrmfgl7zcXjoRNq2ut85AxNxMm/B/qpkDvURqm
         n70T0uvgHehhjQlbGgd2nc6usPdIBPLDOV9eDSPQEcHCxzYPMpeSyb462HDPLjw55tiB
         VfBz7Bpl29QVEqOFgKivBwIXpIDP2rP1ZrZ6ref+UTVbZfXu6c2r026gBa8mXYDn4FSM
         farVAKNMoiyvdclGlusE/lb2fi9HxisBp85pcMWutEb/R3ST/3yoLfISEeuLm3GifoPy
         iaW4XTT6bMm/5F+N+ZEl/i8KUkHDD/pCEyrqUVBZ1YFJeHOWGRo272+Pa8Y8q7IvMCoq
         +Ceg==
X-Gm-Message-State: AAQBX9c+2cqRwF/sZoOKMFhddEReArpFrc2jGHH1sqGiSi5VW4vwSqu+
        AMB0DmU8oSQYNN259RbfwXA=
X-Google-Smtp-Source: AKy350bY4APGkMEn5jnT3hrPcgD0IFpWnxPux4TPQ74b4zdNFtZk3bMgcaFkmd5oasXe2ggPZ2CL0Q==
X-Received: by 2002:a17:903:22ce:b0:1a5:f:a7c7 with SMTP id y14-20020a17090322ce00b001a5000fa7c7mr3342685plg.0.1681482353510;
        Fri, 14 Apr 2023 07:25:53 -0700 (PDT)
Received: from strix-laptop.. (2001-b011-20e0-1499-8303-7502-d3d7-e13b.dynamic-ip6.hinet.net. [2001:b011:20e0:1499:8303:7502:d3d7:e13b])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm2952386pjt.22.2023.04.14.07.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:25:53 -0700 (PDT)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>, Barry Song <baohua@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Steven Barrett <steven@liquorix.net>,
        Juergen Gross <jgross@suse.com>, Peter Xu <peterx@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alex Sierra <alex.sierra@amd.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Li kunyu <kunyu@nfschina.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Chih-En Lin <shiyn.lin@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Gladkov <legion@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
Subject: [PATCH v5 10/17] mm/gup: Trigger break COW PTE before calling follow_pfn_pte()
Date:   Fri, 14 Apr 2023 22:23:34 +0800
Message-Id: <20230414142341.354556-11-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414142341.354556-1-shiyn.lin@gmail.com>
References: <20230414142341.354556-1-shiyn.lin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index eab18ba045db..325424c02ca6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -544,7 +544,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
 			 (FOLL_PIN | FOLL_GET)))
 		return ERR_PTR(-EINVAL);
-	if (unlikely(pmd_bad(*pmd)))
+	/* COW-ed PTE has write protection which can trigger pmd_bad(). */
+	if (unlikely(pmd_write(*pmd) && pmd_bad(*pmd)))
 		return no_page_table(vma, flags);
 
 	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
@@ -587,6 +588,11 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
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

