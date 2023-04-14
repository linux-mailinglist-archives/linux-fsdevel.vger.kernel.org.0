Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4B56E25AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjDNO10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjDNO0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:26:52 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9931FC654;
        Fri, 14 Apr 2023 07:26:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso21823683pjs.0;
        Fri, 14 Apr 2023 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681482372; x=1684074372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cn0v+6+8REt3te6+W7jwtjVuTBBAk2uf1jUodunRRdQ=;
        b=qi9wgiyeY0KQmKmVHmk3pZf/Hi4Vp8dgW2DPgrhsj8Xwtx2FZitjvpQoSol6ANk7d2
         1nwO8VT1YJy8uPXgkX9/FutEPVh31MHIZQlLhkDNLiI0vwdWENXTb4dgDqyvIrfKzMOX
         JI0CKwQjE52y7/H+kjVfplDq/+2Hs/lKXVITRsXKPy/05LnN2D+n76SDHQsW1vaTbWXK
         90b5glPmafEggiq/JPPsEci/7YhvLEKLpSuc5jH4zplAtjPos9DlUXXyGmXSv706vknt
         tp2hKzs3UcLFWOqwvzyG5LStOAqXtz7Uhjar9GOjeCsp/OqcZ426jrQ99KPeGXiVL2Px
         Rr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482372; x=1684074372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cn0v+6+8REt3te6+W7jwtjVuTBBAk2uf1jUodunRRdQ=;
        b=a5r9lvniXCC+LJw1c5qkHrnC1TXiRzFIkSJxTBEUMELzyHNl2TQPjTbArM6piz6tDQ
         K9w/IEzS2M47lwUGxsP9OGAPLP8GzH/fvqJIEuX7g5roWIIj2ZZ70KLNwOQjmgIvYmNX
         0XUU9pyYmejUZjfn+a4C/KoRKg/EsGuxuT4MxiJp3RayiGJiVYTWOaHS867keY4K8FjI
         1LTTN5mmsMdba8lNzzPix9ZKNHwzseup8/e6bt+nr0vj+FRlHfUzADitgWyCADI3AmM3
         aCl5rIRPDNdJZDLosyQt4PH9iCQAZm2v9otYViiZT4/Y3DwxqHY5MtO0BB/J58NY4Hc6
         /2ZQ==
X-Gm-Message-State: AAQBX9dpn5UcRyYJo6HNuf4QY3BsLPmnhEF/1IbkjAWMBSF7nk/2Lle9
        h11EK/sf2vLz16v+0FJyzCQ=
X-Google-Smtp-Source: AKy350YNu6dj+98meByV/+r5D+K99Oh4Y9jClRwMRsz3Jwt8ozybPOvGDsiGKENsPm95AhWUU5y+EQ==
X-Received: by 2002:a17:90a:a392:b0:246:9517:30b6 with SMTP id x18-20020a17090aa39200b00246951730b6mr11192974pjp.4.1681482372086;
        Fri, 14 Apr 2023 07:26:12 -0700 (PDT)
Received: from strix-laptop.. (2001-b011-20e0-1499-8303-7502-d3d7-e13b.dynamic-ip6.hinet.net. [2001:b011:20e0:1499:8303:7502:d3d7:e13b])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm2952386pjt.22.2023.04.14.07.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:26:11 -0700 (PDT)
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
Subject: [PATCH v5 12/17] mm/userfaultfd: Support COW PTE
Date:   Fri, 14 Apr 2023 22:23:36 +0800
Message-Id: <20230414142341.354556-13-shiyn.lin@gmail.com>
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

If uffd fills the zeropage or installs to COW-ed PTE, break it first.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 mm/userfaultfd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 53c3d916ff66..f5e0a97d6a3d 100644
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
@@ -215,6 +218,9 @@ static int mfill_zeropage_pte(struct mm_struct *dst_mm,
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

