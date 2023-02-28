Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80C86A55DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 10:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjB1JdS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 04:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjB1JdP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:33:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6AA1FF6;
        Tue, 28 Feb 2023 01:33:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 725F2B80E12;
        Tue, 28 Feb 2023 09:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3D7C433EF;
        Tue, 28 Feb 2023 09:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677576785;
        bh=QJB3wPU2HWgjAFGuMz7NkbXXZcNkRHN6drkDJ+SyIYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m6kPxmfUjqBPyP1zjk/AUvq0/knP93c2G+bJV20AAk00Bn5Qy1ceLoPdeWzhhd66V
         C9PoDgaO8rIzmIHx+zhN6nkA+kRPYAwGKfC1VDZEgYNjMAhQbGB0eypPdGJFHD2N2y
         vaePjn5SoDDn0dEkIf75C8Pfa7RvzbalnvALHj9mvgHJy8WdgTPhm9JEmabCzuuo/k
         fDGJm19tk2+IfAuCsGapu6TbdLHo4eP/EqBsqwW6qqkL/Lc0+Fv/y1RTxYHDh8tlHE
         GkDspDLRDbIm19taZ2SguntVqk7d/0F/NViAB3I+CONr1oBs9FaKr8W63nBjkqhJNr
         LtdzQ20YTBC/w==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH RFC v2 bpf-next 4/9] libbpf: Allow to resolve binary path in current directory
Date:   Tue, 28 Feb 2023 10:32:01 +0100
Message-Id: <20230228093206.821563-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228093206.821563-1-jolsa@kernel.org>
References: <20230228093206.821563-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Try to resolve uprobe/usdt binary path also in current directory,
it's used in the test code in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 05c4db355f28..f72115e8b7f9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10727,17 +10727,19 @@ static const char *arch_specific_lib_paths(void)
 /* Get full path to program/shared library. */
 static int resolve_full_path(const char *file, char *result, size_t result_sz)
 {
-	const char *search_paths[3] = {};
+	const char *search_paths[4] = {};
 	int i, perm;
 
 	if (str_has_sfx(file, ".so") || strstr(file, ".so.")) {
 		search_paths[0] = getenv("LD_LIBRARY_PATH");
 		search_paths[1] = "/usr/lib64:/usr/lib";
 		search_paths[2] = arch_specific_lib_paths();
+		search_paths[3] = ".";
 		perm = R_OK;
 	} else {
 		search_paths[0] = getenv("PATH");
 		search_paths[1] = "/usr/bin:/usr/sbin";
+		search_paths[2] = ".";
 		perm = R_OK | X_OK;
 	}
 
-- 
2.39.2

