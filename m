Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA7868CDC1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 04:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjBGD4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 22:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjBGDzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:55:38 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD3D36085;
        Mon,  6 Feb 2023 19:55:04 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id r8so14392125pls.2;
        Mon, 06 Feb 2023 19:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGNZN7JF47hId+X1vWc4gO+CAnb7F699DIDoXCQvWIQ=;
        b=He5wcuqr4hD23UoQdl/Nr/rdm7mAo2tCpalq7z2P/0kqi8YkB1XHHhit04yx01Heqx
         uj+2dlN/JAI96jychr3QIhsyd9kSFSO7NeXfoWKaLaTDEgkQ88WbJnumitBCs0kuUsEX
         VrVi4V1juGiLFUM1OR/YViXfiIufa++K8TUR4d+HHSll48ldd6R3+eU/J/c3KBlfKqbR
         etU6Gr78SWNrgiDFXUUDKrN2i+79d2SWmJuUa2fp5mud5XBatO7GoFbHb6WaTtclLROM
         Oxka7aHoBT761ENxnS0JiopOA4gqvMxvp5M3XfWbp4xZYDG+T6TpuvZb56g9puFlhd4a
         PfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGNZN7JF47hId+X1vWc4gO+CAnb7F699DIDoXCQvWIQ=;
        b=CUxyRhkUMSeGeSKqVbA983wXk13b/ugOSWG375PLZYKZXCNl1a5gD/+DD1gg8fYnYI
         /+OAyySVu/bzzmPamULgV+Utnya+Si5Mh4A0cmKxUF28oNodXchUdAVgUJhRFD2jjdqd
         ISZkxTHlHG1V//bbHZEYpIBdoUPSdC5g8UIpGAoAUuw9gmMcAiN3ca6WIhadHfMRljyC
         X8QASJVdvvGhVR9VfOfyVm/W/rs/E0stqgG+35iaK4krCpUL+8VfwHWxct9IHjZMnD01
         X2bRWuQXaFjPc6Gqj9LBVJi6GP6aDq14h9f7ulMLA4zhRxXzLQetvA3kcK0EtVLs209L
         lO8A==
X-Gm-Message-State: AO0yUKXkRNZ9y5GA36GCNEnRd+dPdaHTQKx6Oew1ReNYjfRquiKZREeJ
        BzrnqShKDCcNari1Jgqcznc=
X-Google-Smtp-Source: AK7set9PzL+wwdl/6GfLYROSoXvgwz12xEdsCVdNMrSCXNtZY2YzeGDIDot3x0eVBNWHM/hCwnCTvA==
X-Received: by 2002:a17:902:c40f:b0:196:e8e:cd28 with SMTP id k15-20020a170902c40f00b001960e8ecd28mr1567847plk.15.1675742100941;
        Mon, 06 Feb 2023 19:55:00 -0800 (PST)
Received: from strix-laptop.hitronhub.home ([123.110.9.95])
        by smtp.googlemail.com with ESMTPSA id q4-20020a170902b10400b0019682e27995sm7647655plr.223.2023.02.06.19.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 19:55:00 -0800 (PST)
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
Subject: [PATCH v4 12/14] fs/proc: Support COW PTE with clear_refs_write
Date:   Tue,  7 Feb 2023 11:51:37 +0800
Message-Id: <20230207035139.272707-13-shiyn.lin@gmail.com>
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

Before clearing the entry in COW-ed PTE, break COW PTE first.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 fs/proc/task_mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index af1c49ae11b1..94958422aede 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1196,6 +1196,11 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 
+	/* Only break COW when we modify the soft-dirty bit. */
+	if (cp->type == CLEAR_REFS_SOFT_DIRTY &&
+	    break_cow_pte(vma, pmd, addr))
+		return 0;
+
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
 		ptent = *pte;
-- 
2.34.1

