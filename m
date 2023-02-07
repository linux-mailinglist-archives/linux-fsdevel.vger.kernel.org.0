Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BEB68CDC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 04:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjBGD4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 22:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjBGDzs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:55:48 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4103400C;
        Mon,  6 Feb 2023 19:55:19 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d6-20020a17090ae28600b00230aa72904fso5367971pjz.5;
        Mon, 06 Feb 2023 19:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5f9S6gTvBUR31ijZ1v0NXA88nU2gIARJhf8qkOYPpE=;
        b=V+9ehS3dUBnDSP754pQJilYnGgspDpamE6axHxsiTDW2FqvQddaZhtzoXahpcQNnWp
         slKt5OTaFYOnKxD33z7ajrAhO1f5bVaGT6RR4HraIXtm6VzkCVcF66mE5C+d2tMbbaFD
         +cjxflw1/Gp+nt43vddDQxJgK3gDExiSvTg3IjBGeNMZxBToZEebfadplSSmscanOrCX
         /FVxoHCFHfslQW1BnfnGGO9BAkv0ye+18mfO6F3hwnyawTP5HH9TkMKxOmk1OXHPn3gD
         mOqbNky7E02Ec3UOsJc8CO1ricLUh6qtCIFx31yJFispY8zifcyFXGLJSYwBocGdS5P2
         vjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5f9S6gTvBUR31ijZ1v0NXA88nU2gIARJhf8qkOYPpE=;
        b=uY1nFzDCT0mv6GiWxdclJC97kN2mg34z1MrXzH4I9dThRjOiV3hlOCv9/QMMPqesc/
         iTOk/F+FTDdkmd+wWgH19rnx3Ouq37c3PXAnErhBk72nzdVW1CIWTiYQKEX4kK+65SCl
         7xtjl3pHnD6WjLOOoemaZ8s4RTZxsizJTMIHeZU8ZcHfexjKJOn6z516o//z0s+IJ9ue
         jyrOs67yUcbvCIUprfE6ClYBsfhiU6bDgTmhtUX82UVmBaNJ4STjv8KAe3Xxj1S470CT
         5UA9optixKF/+7IdYjlFrUCjI8Fvhjt7F4/xYASwlA7xs0Ps/AZAi0IgiYAyDUvs7ciD
         daww==
X-Gm-Message-State: AO0yUKU2lgeh/WtU8NQnKK24B/uXPiDsG8xF5OZPFkKwFxhC1hTbVrrN
        p7UgkWf73rE0TUgZwbv83eA=
X-Google-Smtp-Source: AK7set9eFrjrbQaBrX68nI/egeQC5azfC6+Rad48+JSCqX5K0OjrQy1a9sYzZUEJN+SmZpiFte9d5g==
X-Received: by 2002:a17:903:1250:b0:196:f82:14b7 with SMTP id u16-20020a170903125000b001960f8214b7mr1531757plh.37.1675742113998;
        Mon, 06 Feb 2023 19:55:13 -0800 (PST)
Received: from strix-laptop.hitronhub.home ([123.110.9.95])
        by smtp.googlemail.com with ESMTPSA id q4-20020a170902b10400b0019682e27995sm7647655plr.223.2023.02.06.19.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 19:55:13 -0800 (PST)
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
Subject: [PATCH v4 13/14] events/uprobes: Break COW PTE before replacing page
Date:   Tue,  7 Feb 2023 11:51:38 +0800
Message-Id: <20230207035139.272707-14-shiyn.lin@gmail.com>
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

Break COW PTE if we want to replace the page which
resides in COW-ed PTE.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index d9e357b7e17c..2956a53da01a 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -157,7 +157,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 	struct folio *old_folio = page_folio(old_page);
 	struct folio *new_folio;
 	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_FOLIO_VMA_WALK(pvmw, old_folio, vma, addr, 0);
+	DEFINE_FOLIO_VMA_WALK(pvmw, old_folio, vma, addr, PVMW_BREAK_COW_PTE);
 	int err;
 	struct mmu_notifier_range range;
 
-- 
2.34.1

