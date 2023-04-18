Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE036E5697
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjDRBlR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjDRBlO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:41:14 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861B15FC4
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:40:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f8b46f399so159459197b3.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782058; x=1684374058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XBLJQNnM/sLgs4vCqBW41kO32Rg1yqnQ90D80Go8URk=;
        b=SnlbZJLk5Z7OPvXPJ7Etlra3omvGygVLH4yu2u9bDq4nCNczqjAQAtQj22wZ5lGEym
         a2kgjgQG7BqI5HdR0cpPUsEdGAS9YmKkxAht+4KyhF01JzBn+Q5S7f6M6omvM0kkv6X/
         evFfdOnXQGFj9+0aeZ9WMkNy0KSNFXRwAthNf6y5bZ8rWO/w27CqQ5dQ154gW44ArDBX
         LVcYLjt6nZT7hh2nhtXt7Y7pRN6WJB/9+wNxQ55m08D8GmFVYpj4xvYPc2V9ZA197fka
         hn+T6Z4cpwohIn0+D00N0XUIWGvmcKaMk9jEbjb1w7J1OC1OpxepDIj+esRwnqQA0EyG
         F+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782058; x=1684374058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBLJQNnM/sLgs4vCqBW41kO32Rg1yqnQ90D80Go8URk=;
        b=TvNsh4UcG1Y1QV/vePJmG8ulEql+p45kn8jiXQZ1SuvTv/cY3mvArmT1ofD2lkOUYk
         EtaboQxzEVIdERTqHoOyjQ8IQoBWOGuBFHxzcCYSZKjX7yAReu6vflx7Pny0JerMnYG7
         wfirHHhlhyGkbmyZxGJkUs+4r1ZlRd8S+DfRMr32nsnC6rVZ7lHEAxNXXmwIMs4DSFm+
         Q+K/lly6Gcb16YVDsFC2+zYnkWRddKNclZ6G0L2lA29qjmqX97/x6u3p7kDM9Dn0e6My
         btt17qQxgC/kNLdm9VEFu+tJZIYSkkoYBuydQVx5x6I/rOsAVm13HdRAPWVhQk9AkR3b
         HvEA==
X-Gm-Message-State: AAQBX9fG84dfEvc5Ukq01JKnn5+/VnJqseX5IZWpmjmFtMq160E5TqKE
        vN66TColrLNY51wJMzyRCMkLqhn8Q+w=
X-Google-Smtp-Source: AKy350aqzaT5PLfkv6k+7JDnNf8qfXfskwThdpbUGB15DarKosOyvH1tWqog8UU17iAVxBXL9PBghU8UzVE=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a25:d7d3:0:b0:b6d:80ab:8bb6 with SMTP id
 o202-20020a25d7d3000000b00b6d80ab8bb6mr11010336ybg.1.1681782057858; Mon, 17
 Apr 2023 18:40:57 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:03 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-4-drosen@google.com>
Subject: [RFC PATCH v3 03/37] selftests/bpf: Test allowing NULL buffer in
 dynptr slice
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

bpf_dynptr_slice(_rw) no longer requires a buffer for verification. If the
buffer is needed, but not present, the function will return NULL.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c |  1 +
 .../selftests/bpf/progs/dynptr_success.c      | 21 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index d176c34a7d2e..db22cad32657 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -20,6 +20,7 @@ static struct {
 	{"test_ringbuf", SETUP_SYSCALL_SLEEP},
 	{"test_skb_readonly", SETUP_SKB_PROG},
 	{"test_dynptr_skb_data", SETUP_SKB_PROG},
+	{"test_dynptr_skb_nobuff", SETUP_SKB_PROG},
 };
 
 static void verify_success(const char *prog_name, enum test_setup_type setup_type)
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index b2fa6c47ecc0..a059ed8d4590 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -207,3 +207,24 @@ int test_dynptr_skb_data(struct __sk_buff *skb)
 
 	return 1;
 }
+
+SEC("?cgroup_skb/egress")
+int test_dynptr_skb_no_buff(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	__u64 *data;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr)) {
+		err = 1;
+		return 1;
+	}
+
+	/* This should return NULL. SKB may require a buffer */
+	data = bpf_dynptr_slice(&ptr, 0, NULL, 1);
+	if (data) {
+		err = 2;
+		return 1;
+	}
+
+	return 1;
+}
-- 
2.40.0.634.g4ca3ef3211-goog

