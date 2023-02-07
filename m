Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE39968CDBF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 04:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjBGDzr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 22:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjBGDzX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:55:23 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDD632E47;
        Mon,  6 Feb 2023 19:54:54 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id z1so14356465plg.6;
        Mon, 06 Feb 2023 19:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0O7Up3wzI+qFoE2erzvpvdWol4kWXujLVpSiPg8jt0=;
        b=ImenKRKpVIE1w2d+yNyhMy/Bmoy2fYt1Y3bh919Fjcuemc/XCNtsmCp6Ll9Fjga3qj
         MBQ891tsWYncJYGiA9yY+OJ7jFg0MgK00ncTozVcs2/dyXQHdd7seoN6utATFCOAJK1T
         IiYZU7TCWwqybJQlhE9DooQMCwYh6apQ+x6vbO4EgOACpRO57yoAgcWf6z2VtdBw9St2
         QebOO3GI3l0z/X8pJUTf0yvmUEKZJvQhTHv4gfIxbNLOjkIfYX5JJFiGN88ORHgE2etN
         18rbyA/7Udt4wGqu16BfkrtXkHAV2APrs2IzJYpcNK9y7FxS/WAwzyJ16edRaBK0feb3
         gOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0O7Up3wzI+qFoE2erzvpvdWol4kWXujLVpSiPg8jt0=;
        b=4XNJQV1dJh/+Q1GXablXm/+DYbRlJWTmj/iHXkiPHlVZVHYibWXy57SARRTRxWikY3
         giWw/Xfm24UO9yx2Yjxt6CSVLdT0gNMHaghx6+5NmJMiawqtXgtN9ame8wcR+7bI85i9
         8VuS8UthOgFEtyFLWJHlLUxsoaZ3+T6zah6TXo7/KJeqciqEkrRwefcMzsEo22A9YNE+
         Bb5G1YDSduIczI7dvi0A5jX6B9ACQvcNRFyzXhXmoFTOT47gKMeZo9zHZRlNhKif4J+r
         qHYRhAEaVoBGdgCyicj8vb3aPi138pgkCfpkeqoFK41pqapU6AqGDFtNEiy9wHottVSz
         oCQg==
X-Gm-Message-State: AO0yUKW5DPvwUuHPiQI4vzl5EoZgx7swHDF0WGPpN8V5aKtWJbXzQLCl
        ZL5ELiQoWsO9fJW0VigaAoA=
X-Google-Smtp-Source: AK7set+R6CsRkpduFz4IpgNhrZUmOyLBgEIAcun1eMlrmSOR5DRWSRb+PFgTaXgU2+DZBiANGWjHgw==
X-Received: by 2002:a17:902:f693:b0:199:1996:71ed with SMTP id l19-20020a170902f69300b00199199671edmr1724364plg.24.1675742088707;
        Mon, 06 Feb 2023 19:54:48 -0800 (PST)
Received: from strix-laptop.hitronhub.home ([123.110.9.95])
        by smtp.googlemail.com with ESMTPSA id q4-20020a170902b10400b0019682e27995sm7647655plr.223.2023.02.06.19.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 19:54:47 -0800 (PST)
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
Subject: [PATCH v4 11/14] mm/migrate_device: Support COW PTE
Date:   Tue,  7 Feb 2023 11:51:36 +0800
Message-Id: <20230207035139.272707-12-shiyn.lin@gmail.com>
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

Break COW PTE before collecting the pages in COW-ed PTE.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 mm/migrate_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 721b2365dbca..2930e591e8fc 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -106,6 +106,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 		}
 	}
 
+	if (break_cow_pte_range(vma, start, end))
+		return migrate_vma_collect_skip(start, end, walk);
 	if (unlikely(pmd_bad(*pmdp)))
 		return migrate_vma_collect_skip(start, end, walk);
 
-- 
2.34.1

