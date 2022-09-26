Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E73D5EB572
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiIZXTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiIZXSv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:18:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE52AD5772
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y5-20020a25bb85000000b006af8f244604so7016250ybg.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=qYUtbvLwl6swUO4hiS1oZSstWOFuOepYRxZkpZ1kfLs=;
        b=QAl5gMZ5lQEKrESQ6jWH98yw4KTtq0tGTjXXQeVj0ewtzidIWSgsl7rU4HLZd2LKSD
         0bHBIwLrqNvpXMJeccATvuLpBYxAfEHQqiywa9TxD1jVin+Oc+IZjGlz1oDXFe3wASbV
         3bugHwwyoW+CZmxia551z3VE1h+37eUAb+1mSkU5ENP26OohnCGnsaIhmgnDBkIi7osy
         NkEhfmcfel4lnh2SCrDApyUHNf7L3qumisQaEy8Z+VoC19x4IHl4ADnh7KHOGMp2iq3o
         +H6/pSVsQ4aMcuYQ1KC7YvLpCR0wrmnUz5F0TqZPqECiC5T6gf+Tqx+OapL6GecynrcA
         Tp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=qYUtbvLwl6swUO4hiS1oZSstWOFuOepYRxZkpZ1kfLs=;
        b=3L7y9tjAgQjK1XNXsyjA4L3Wq7QPKrX/jro5mdtYI7Nrt2N+hF7DgVZzDdqBN1TfFk
         21Kh/ofq6iXK94MVsFKVKzV08kBp6NGaZThHMyOZ7tnu1PPKTc266Zzgf7HDIGU1HXKt
         URH+KbN2WPr20WV7r1Ypi4lvMXPEuFP6OHv9Oo+SFpd82WbAtMKLCZtaTRSDYycG0aWU
         6sPx5f8sLnpxJG+NqopXthrfdEhpBRsVSEdfMSiK9DI+RCncXxVHviLVKnT+Q9bY41r8
         TB4163lewSVvvaDFOF4Klx7wlOP5kB6KE0BpCBgy9YJ//l0tW8CYVdbeKS2086ogzpi0
         TTkQ==
X-Gm-Message-State: ACrzQf2l+pXvKjUuJY+pHXUlidGhvurHiTBtJ/fcTXs7mb41kHzdEi/M
        uneUaA1aW/eEkFguE1mRe6xuNNMAyyE=
X-Google-Smtp-Source: AMsMyM5K/9sGBw/frw91uQfR+I9ZQ4Q/SrmJEv/FiSInEBM+D5awUrUn9RU7H0V04IGCygyZf5E9jfZ/sI4=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a81:758a:0:b0:345:450b:6668 with SMTP id
 q132-20020a81758a000000b00345450b6668mr22170393ywc.316.1664234325229; Mon, 26
 Sep 2022 16:18:45 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:02 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-7-drosen@google.com>
Subject: [PATCH 06/26] bpf: Export bpf_prog_fops
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fuse-bpf requires access tp bpf_prog_f_ops to confirm the fd it was
given is in fact a bpf program.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 kernel/bpf/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 27760627370d..2000b6029e6a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2160,6 +2160,7 @@ const struct file_operations bpf_prog_fops = {
 	.read		= bpf_dummy_read,
 	.write		= bpf_dummy_write,
 };
+EXPORT_SYMBOL_GPL(bpf_prog_fops);
 
 int bpf_prog_new_fd(struct bpf_prog *prog)
 {
-- 
2.37.3.998.g577e59143f-goog

