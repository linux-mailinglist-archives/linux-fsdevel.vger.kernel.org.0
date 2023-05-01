Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E74C6F33D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 18:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjEAQzh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 12:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjEAQza (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 12:55:30 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36A4170C
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 09:55:12 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-51b67183546so1423995a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 09:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960112; x=1685552112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OgbhlQnm6N3CIqx+6EXURMMvow4S1KQvuNCpohSnl08=;
        b=ym8bWqOddRKLLCHNc+7Y2IQs+szb6DlXVMA8aGLldE3slVUGdWc6AeUaj2cctynpb7
         /42bu00/rNI9NmOjux118bETqQ9xSRBpI0DlCMlMXfD5dyA5fGqmz9wEGRomBF9wE3qi
         RRE1kSFRttrNPJ5gUqGivtomoZ/CkHpvdtT+8kMIwh52/Lg8aqiW8D9XXtWx1rDhFoLd
         bIJ0Jt1xQTF7bUEViJLE2KzQyVYsdDW/+ihFxINfhU+/Rq1Q5G2PY50HQQ7ppVzde88x
         xSaqGzF/rOMvs2lVTYEukIGUCSWj1ys72INhoG28un8pv0+7d++N9bkCwOHBDc2Mepzd
         xe8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960112; x=1685552112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OgbhlQnm6N3CIqx+6EXURMMvow4S1KQvuNCpohSnl08=;
        b=L4c5bP1LprlQktWDbC2IoIbPkL/u2RNhrX4dlanmn4x+qJzXBPBngAalbfjHEpyPl9
         CFX8/nKpvLYgD6m6FiIBS0NT9QwVY9ewB/UzR2jGUQDRdx/fiAxKlv+hVyaEoPWDanq4
         4c3jYJToWYvxUiqPLRp+eGEUmpPO4vyGIzBNztSU0VnVYRQc7pNwQ/yPZge4OMshFl/E
         S9FZEUctDLVEz7t0KE63RIzeGG5beliCrQO+/e5ac31BIiGTdfL3nt9SgnhWSZuTvgnF
         6vUuEcWP2MlCvDjQaQ8HrsPSPMhgCyGEJZpwyUGs6EHUFmoObwWmObvwhSGoOpft+ksC
         1E8A==
X-Gm-Message-State: AC+VfDyRD0WPfrQGFug0uHODQ/KHvQUl5SyNh01TbdiHQoGn06KBwkq/
        nMsCFZWrPpjj+vozu3xNrzi+gpz54pw=
X-Google-Smtp-Source: ACHHUZ5b/dFHDo+PuE3NWONWxlaUnbiu4qgjE2QFFJKcdOrghbUOD/toAldYYzf7QRUKjILKXa170Oj8yTI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a63:24f:0:b0:520:60ac:fb30 with SMTP id
 76-20020a63024f000000b0052060acfb30mr3551005pgc.1.1682960112196; Mon, 01 May
 2023 09:55:12 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:12 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-3-surenb@google.com>
Subject: [PATCH 02/40] scripts/kallysms: Always include __start and __stop symbols
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@linux.dev>

These symbols are used to denote section boundaries: by always including
them we can unify loading sections from modules with loading built-in
sections, which leads to some significant cleanup.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 scripts/kallsyms.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 0d2db41177b2..7b7dbeb5bd6e 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -203,6 +203,11 @@ static int symbol_in_range(const struct sym_entry *s,
 	return 0;
 }
 
+static bool string_starts_with(const char *s, const char *prefix)
+{
+	return strncmp(s, prefix, strlen(prefix)) == 0;
+}
+
 static int symbol_valid(const struct sym_entry *s)
 {
 	const char *name = sym_name(s);
@@ -210,6 +215,14 @@ static int symbol_valid(const struct sym_entry *s)
 	/* if --all-symbols is not specified, then symbols outside the text
 	 * and inittext sections are discarded */
 	if (!all_symbols) {
+		/*
+		 * Symbols starting with __start and __stop are used to denote
+		 * section boundaries, and should always be included:
+		 */
+		if (string_starts_with(name, "__start_") ||
+		    string_starts_with(name, "__stop_"))
+			return 1;
+
 		if (symbol_in_range(s, text_ranges,
 				    ARRAY_SIZE(text_ranges)) == 0)
 			return 0;
-- 
2.40.1.495.gc816e09b53d-goog

