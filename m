Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F0268CDBD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 04:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjBGDzZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 22:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjBGDy7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:54:59 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2372C367DD;
        Mon,  6 Feb 2023 19:54:36 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v18-20020a17090ae99200b00230f079dcd9so155840pjy.1;
        Mon, 06 Feb 2023 19:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ry1CaivQA+WwrthTA1eQZVLr8NatvP0/+r4itTa9xSI=;
        b=d8wSKS8rryvPGCmpnm+JTRMWPuer7cSkE915+Di2vStTbeU6J9CDNia1+lKJ4TYA3F
         FsiWitNkJfkhpGOa3/TWuDlGJ7hoCRvKFsaLeSEyLWy+VFwkWBMOPjP4mVO3kj/AOfTO
         dfLEUy5AOnIeoq/t3PzsGy1O4+SOKsRbP2Qc+h7hnzcDq5zC5CAfuABjOF37wJlEDJcM
         ya4VnrJUlMRgeqVncACG8zioe9b0CpHOIXXUE+bnxasciMIEVb1ZOGebhvWfFVJbDsB2
         23LNzhzp8J/s/ZXPiEMPXWEev+Jh0Aw4avTPufwGWvkFmZUGBezycgI1BA0/H1w5bUhL
         KZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ry1CaivQA+WwrthTA1eQZVLr8NatvP0/+r4itTa9xSI=;
        b=xGB3rHNlRYepGokvUEsS4b/eGRzqwb0H467SsPab/BVcT/bNSXDxrXULExDxhlUjEE
         I5MbIMyZtstFDcgMN28qMaIlKjj4ek59PvEKsxaQ2Zjstnlf3JIDCXXZ39hwnxWYcIrd
         Wz9jCzERs+jhJ6pSWl2wpGcOL/cLpgDt0NiBc7QvfTC3THIcUh12t394/aBuaAF4BwAl
         TDmOg6De3p1uO/SBK3SPUxAVp9Miqxtz7iUZUj/m6Dh3Z/Tk5h1UREkkIkXk511MXZdL
         jnUqEThSI+209M8Pl/kIoI0gSAazwPRnRARpiBVe/je2pzYgd9KcsxN5LofVczA2qDCX
         fDTQ==
X-Gm-Message-State: AO0yUKUkyZAUOFyV2BHZ9GMKjB0skEIC6Gm+FNIhPiJ4juOS9SrsqTZU
        FvTyCSAcwUJ/EXZsVc+AXLk=
X-Google-Smtp-Source: AK7set/QqXM+8K/GIbrrktYGZ3tjkjRzSAAFgJgsQE9zms3ILrIsqCklz+JpkGNk5mJ2O3IEsKj7gw==
X-Received: by 2002:a17:902:e943:b0:198:adc4:229f with SMTP id b3-20020a170902e94300b00198adc4229fmr12287865pll.26.1675742075566;
        Mon, 06 Feb 2023 19:54:35 -0800 (PST)
Received: from strix-laptop.hitronhub.home ([123.110.9.95])
        by smtp.googlemail.com with ESMTPSA id q4-20020a170902b10400b0019682e27995sm7647655plr.223.2023.02.06.19.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 19:54:34 -0800 (PST)
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
Subject: [PATCH v4 10/14] mm/userfaultfd: Support COW PTE
Date:   Tue,  7 Feb 2023 11:51:35 +0800
Message-Id: <20230207035139.272707-11-shiyn.lin@gmail.com>
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

If uffd fills the zeropage or installs to COW-ed PTE, break it first.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 mm/userfaultfd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 0499907b6f1a..3f66aa3eb54f 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -70,6 +70,9 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	struct inode *inode;
 	pgoff_t offset, max_off;
 
+	if (break_cow_pte(dst_vma, dst_pmd, dst_addr))
+		return -ENOMEM;
+
 	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
 	_dst_pte = pte_mkdirty(_dst_pte);
 	if (page_in_cache && !vm_shared)
@@ -229,6 +232,9 @@ static int mfill_zeropage_pte(struct mm_struct *dst_mm,
 	pgoff_t offset, max_off;
 	struct inode *inode;
 
+	if (break_cow_pte(dst_vma, dst_pmd, dst_addr))
+		return -ENOMEM;
+
 	_dst_pte = pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr),
 					 dst_vma->vm_page_prot));
 	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
-- 
2.34.1

