Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736D86E568C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjDRBk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjDRBkz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:40:55 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ED45279
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:40:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f97aac3d0so147120457b3.15
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782053; x=1684374053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NfkPJzUlysoaTODKR2vMaar8Vfxo3RC8DMLPrNdWTm0=;
        b=egQ1giZWzQQU6IgqDiN0fqNaR+tCjtq8YtqkqBFfrhgCOHzoH5BL4EpM1SjL2V9YPT
         zw5vjo04SRS98y4aBh4IKDh/0Gc/NqpsqnvGnxUVTxf4LsjVKui23mBcXeJ9KXrvhZKA
         ZjR7hMSIiiecVTikf6jSWY5aIuy3zBgyY+o31s5RG669mrcwpbn4LneWBnlC4odlvOM6
         uVEg8sDa7KRWgPiubS+g6d2Di3xIboxV1D2Yox6S+/NnnYnYXgpHb/utSPyJALD1t4u2
         t3AZaYcWNjd484y99DBX0CWCj1HZ0+dTbwbIXfNH7ltNnMYthcViod3d8MoUwvFYMiDJ
         Wo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782053; x=1684374053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NfkPJzUlysoaTODKR2vMaar8Vfxo3RC8DMLPrNdWTm0=;
        b=AMKBLw2e6aR6ZhsS2Le79x2Tnx/DvZkXWeCQeDuTgMHU4vN+RXY9u2zo3rrw+Vfc6l
         i5etCG6yDkHx0fvyJtKPeqGg+ECpx34I4o2PWUSh3VeIoLJ5CUKbwB9DBxdPmULvx5zF
         sjdDfoFbfO2seYDzYPSkqeR30Jp4HY0xcAMSEHpGEXJqKA1R9xUWgtyniR840+A4VgZE
         6tnDFBV1Ia6vLB+aWs/ZBHuDVXDPZbnTHNaRDw5037xeB6JLaDEhU/yl9PP6Oal67Mt0
         Tz0uqLCsw4cOm+ALW9I18Vo99CkPh3vbZJV48GIwdadHO+WIAH00icefalKzI2kMKLz7
         i4GA==
X-Gm-Message-State: AAQBX9etPMv0eelZKmUh1n5Ra1klTsL0P6veKxT0awaojNw5zM3W2NzB
        mZUGkDBUPGZlgUT/U1YYMzdxZSaHMr0=
X-Google-Smtp-Source: AKy350YmlxhwmblENoNjk9kVV5cLsVBPE97MdbSgohua40Z5njEAKzoWuQFLyOxBvwVm7Hfg/W6OWPDkKZ4=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a81:af53:0:b0:549:14b0:84af with SMTP id
 x19-20020a81af53000000b0054914b084afmr10738506ywj.1.1681782053642; Mon, 17
 Apr 2023 18:40:53 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:01 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-2-drosen@google.com>
Subject: [RFC PATCH v3 01/37] bpf: verifier: Accept dynptr mem as mem in herlpers
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

This allows using memory retrieved from dynptrs with helper functions
that accept ARG_PTR_TO_MEM. For instance, results from bpf_dynptr_data
can be passed along to bpf_strncmp.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1e05355facdc..ebc638bfed87 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7128,12 +7128,16 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	 * ARG_PTR_TO_MEM + MAYBE_NULL is compatible with PTR_TO_MEM and PTR_TO_MEM + MAYBE_NULL,
 	 * but ARG_PTR_TO_MEM is compatible only with PTR_TO_MEM but NOT with PTR_TO_MEM + MAYBE_NULL
 	 *
+	 * ARG_PTR_TO_MEM is compatible with PTR_TO_MEM that is tagged with a dynptr type.
+	 *
 	 * Therefore we fold these flags depending on the arg_type before comparison.
 	 */
 	if (arg_type & MEM_RDONLY)
 		type &= ~MEM_RDONLY;
 	if (arg_type & PTR_MAYBE_NULL)
 		type &= ~PTR_MAYBE_NULL;
+	if (base_type(arg_type) == ARG_PTR_TO_MEM)
+		type &= ~DYNPTR_TYPE_FLAG_MASK;
 
 	if (meta->func_id == BPF_FUNC_kptr_xchg && type & MEM_ALLOC)
 		type &= ~MEM_ALLOC;
-- 
2.40.0.634.g4ca3ef3211-goog

