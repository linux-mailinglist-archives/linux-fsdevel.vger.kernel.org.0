Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB7E6867BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 14:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjBAN6h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 08:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjBAN6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:58:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A8C769E;
        Wed,  1 Feb 2023 05:58:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E60E617B0;
        Wed,  1 Feb 2023 13:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1C7C4339B;
        Wed,  1 Feb 2023 13:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675259889;
        bh=ut4TSVh/smk46JzyD72UAqn8UMJWTZ29FILHTx+yUwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JnHy4CCnRASBpAW99dtJkbPX2oqBQQXDvGScvJq3o+/FaodL245/D9NJYxQNfNUsZ
         CMfE08ZZyQxrXuSMX6uO4lScYcc/QgQO6IdbezuEiloYTYdTdeMjt/DHZ2tJVA2nro
         lM9RoLjYSHdt9TmUMwqAm/Jx30Kz6WwRjHo/AuFSjgOjBt0zv5V5lx9CuomjQ881Pv
         eYXBR/aNwaA5hZTHvCZ/bRuaC72f8SSsEJPVdQGeMITJheap/wLUx3bYuvBMl9MFhH
         ye62SNud97XMHzIXR5+WUMVs3uW1p8/qPvccJ8q++3h1uCmOiECCYxs54/JclrE3nt
         NOavObpiK6Nlw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH RFC 2/5] bpf: Use file object build id in stackmap
Date:   Wed,  1 Feb 2023 14:57:34 +0100
Message-Id: <20230201135737.800527-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201135737.800527-1-jolsa@kernel.org>
References: <20230201135737.800527-1-jolsa@kernel.org>
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

Use build id from file object in stackmap if it's available.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index aecea7451b61..944cb260a42c 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -156,7 +156,15 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 			goto build_id_valid;
 		}
 		vma = find_vma(current->mm, ips[i]);
+#ifdef CONFIG_FILE_BUILD_ID
+		if (vma && vma->vm_file && vma->vm_file->f_bid) {
+			memcpy(id_offs[i].build_id,
+			       vma->vm_file->f_bid->data,
+			       vma->vm_file->f_bid->sz);
+		} else {
+#else
 		if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
+#endif
 			/* per entry fall back to ips */
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
 			id_offs[i].ip = ips[i];
-- 
2.39.1

