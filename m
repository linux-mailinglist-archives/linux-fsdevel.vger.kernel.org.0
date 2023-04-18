Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0DA6E56FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjDRBog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjDRBna (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:43:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC28C1B4
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:42:10 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f8d4f1ca1so155877667b3.20
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782110; x=1684374110;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zWwdeYSbe2MZzb6+0YuKWkWzO0OIunr3DIdjLXb+QPs=;
        b=bvVRAayaKb3f4XHecCOw1fq1zrxbTJlfu+X0j4JJ+ODZZ8s343yV2zF5V5cJPVfBrx
         vO1QktBuUoSHL08PHmb741zrbYTtLR44mlVkerlNbRbCJGYvY5rfLmHur4kpmRZXckp/
         5Xt5y4R3xULWEw01wuUy+z/jQtalviK0udMiGXZVR4o34gUJMO46tjSd9TtEsLa3oC0C
         Qs9ggxL4witMvtnXFhB17F+6dIIHcCSX5M76pppw2FB4zNzSuRHvs30bGFNla01g3E11
         K2LsOQQ7l/LXtTgEgSoMdbEAFkvDtok6PTyc3QsDYVhsfSDu4Pfk86mtQUxZrOSNJ97d
         ihKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782110; x=1684374110;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWwdeYSbe2MZzb6+0YuKWkWzO0OIunr3DIdjLXb+QPs=;
        b=Y1oS0V0djnTCrOOInkOvAY0UJYRKALBlxDaujgnFvIXVjWqlTcy0vUSiybO5OBMh4L
         PF/Oyo+gVcDztpI25kTb5WIEZIHcMQ3eivGytxCXUStOA21TPWFYgrWMqeGUbRPkubCK
         ZbqtBgVi0SSSmj3fmMxokS2mXLnT2RHJCYLBGSnVsU7JB7R5Dj4Hy2PcEek2LpFMYgs2
         c5XUQkNQcmlr8M5KJ7FMAFLXrKaEDISGy2sSn7nzdxUcEr+iMbxRPXvYh3GffUZ1M4bL
         Imb6lYHpX3yCIsm42TyExRyOo1nh6JjFBZ7GlUdhqhyTudAi8Fy2/H74P0ssQ7GIq2Bc
         /O1Q==
X-Gm-Message-State: AAQBX9fAQdBQSJ7zoxviA9XVjnmPRzNm3PBAaizFu8ZJwtGBfQ+cBr0e
        ZWO0ZOrXAaIbttUituuBa3jGOlmZ3xo=
X-Google-Smtp-Source: AKy350aIiy0yEVjIhRUwhKZEZY7qdBZhQoYfVQEj5j3ErV9/GTclD1JkHLmadrVOBoXwbliIvZF/mWfRLJ4=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a0d:ec02:0:b0:54c:2723:560d with SMTP id
 q2-20020a0dec02000000b0054c2723560dmr10855123ywn.3.1681782110238; Mon, 17 Apr
 2023 18:41:50 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:26 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-27-drosen@google.com>
Subject: [RFC PATCH v3 26/37] bpf: Increase struct_op limits
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
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

Fuse bpf goes a bit past the '64' limit here, although in reality, this
limit seems to be more like 37. After 37, we start overrunning the
safety checks while setting up the trampoline.

This simply doubles some of these values. This will have the same issue,
as we'll run out of space way before hitting the 128 limit, but for now
that unblocks fuse-bpf.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 include/linux/bpf.h         | 2 +-
 kernel/bpf/bpf_struct_ops.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 18b592fde896..c006f823e634 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1537,7 +1537,7 @@ struct bpf_link_primer {
 struct bpf_struct_ops_value;
 struct btf_member;
 
-#define BPF_STRUCT_OPS_MAX_NR_MEMBERS 64
+#define BPF_STRUCT_OPS_MAX_NR_MEMBERS 128
 struct bpf_struct_ops {
 	const struct bpf_verifier_ops *verifier_ops;
 	int (*init)(struct btf *btf);
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index d3f0a4825fa6..deb9eecaf1e4 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -417,7 +417,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	udata = &uvalue->data;
 	kdata = &kvalue->data;
 	image = st_map->image;
-	image_end = st_map->image + PAGE_SIZE;
+	image_end = st_map->image + 2 * PAGE_SIZE;
 
 	for_each_member(i, t, member) {
 		const struct btf_type *mtype, *ptype;
@@ -688,7 +688,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	st_map->links =
 		bpf_map_area_alloc(btf_type_vlen(t) * sizeof(struct bpf_links *),
 				   NUMA_NO_NODE);
-	st_map->image = bpf_jit_alloc_exec(PAGE_SIZE);
+	st_map->image = bpf_jit_alloc_exec(2 * PAGE_SIZE);
 	if (!st_map->uvalue || !st_map->links || !st_map->image) {
 		__bpf_struct_ops_map_free(map);
 		return ERR_PTR(-ENOMEM);
-- 
2.40.0.634.g4ca3ef3211-goog

