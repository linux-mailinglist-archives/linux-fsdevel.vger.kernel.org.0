Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15DC6E25AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjDNO1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjDNO05 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:26:57 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAABC67C;
        Fri, 14 Apr 2023 07:26:22 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n17so2477808pln.8;
        Fri, 14 Apr 2023 07:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681482381; x=1684074381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+iY0A30eFtwWyAFuM9+7ULnwLRWOt6NuM4HbKIdcyM=;
        b=S2PKrNk1rZmPzQjBe3Gp+FFrEA22A/oUwM6sgobCibmvZRzzgfVW7JPEF+Hf3GnoxJ
         fHQcvhd9v59UQ1RIMxTKJOv6V2IEI0h0UOs0dMB4wnSFcNEEpf95lM8ucoB6BxZjZFxI
         udsEfh/4nvAcVf9KQ+QZOFe2VYrZduHzu/gfKqOe7ncI8sWohb1RPGhFtgjg4G7iFdLn
         Vr/JMp0xB6omRyLoRvwI5VOL/iAqvrXB2RKnW7egxBBMPA79pSBcBl5zDOVT8i7bT3e9
         b9aVWyD9IEmV6XDaA7HGppl3Zooko4m+CP0CgCsLcjbGZU0/OMex6COYA0MDeCh15YyY
         42VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482381; x=1684074381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+iY0A30eFtwWyAFuM9+7ULnwLRWOt6NuM4HbKIdcyM=;
        b=FQe6nB+HKByGSO/iGi2q5snFR3MRx7Eb01wLbG0pWnF9Bxo9tESkQb6K1KpHkaGa3J
         nNWeoeIPlZnuloqFojUGlNz5pZO8qXSQz7cIkPZQ34kAPZKz8khGOLNasY+RJeNlwGGh
         58tDk2LtLNY4E5PRX1O3/mGgfiGIlTuKf3Nhlp9ZbQ5M9nL9gmdWa6j18A3HISQ3XVpT
         ZmeGntc6uhg+gm1UbvwJTQkVzed89NYbsH+2U9RZ5HDA6v+n7xOnONnkjYCdsBKEIiDS
         LUOV6760Mr87wLzRogkeLWGA9e1s7cROQAHVbcq3uDcngcNmbT9Buc/Ued0P2BizGdVg
         3UcQ==
X-Gm-Message-State: AAQBX9defm2cCH4UNVOqxE2KTWm3dvfNqul5I5JkaSfBnSGxXVNWkRMU
        lwkqJ9HwsePWorVdvPAzCSc=
X-Google-Smtp-Source: AKy350aafhYfAjSh+STiWo4YJpjj7PBy7VIF4XlJ5Jf/VkGdL3OLdg6xCGiKRr6Dx+sTOHgJ0Jz+NQ==
X-Received: by 2002:a17:90a:a392:b0:246:9517:30b6 with SMTP id x18-20020a17090aa39200b00246951730b6mr11193557pjp.4.1681482381349;
        Fri, 14 Apr 2023 07:26:21 -0700 (PDT)
Received: from strix-laptop.. (2001-b011-20e0-1499-8303-7502-d3d7-e13b.dynamic-ip6.hinet.net. [2001:b011:20e0:1499:8303:7502:d3d7:e13b])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm2952386pjt.22.2023.04.14.07.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:26:20 -0700 (PDT)
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
Subject: [PATCH v5 13/17] mm/migrate_device: Support COW PTE
Date:   Fri, 14 Apr 2023 22:23:37 +0800
Message-Id: <20230414142341.354556-14-shiyn.lin@gmail.com>
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

Break COW PTE before collecting the pages in COW-ed PTE.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 mm/migrate_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index d30c9de60b0d..340a8c39ee3b 100644
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

