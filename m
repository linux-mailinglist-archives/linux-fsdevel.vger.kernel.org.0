Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4896BD6A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 18:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjCPRDU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 13:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjCPRDL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:03:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CFCE6FFF;
        Thu, 16 Mar 2023 10:02:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 927D6620B5;
        Thu, 16 Mar 2023 17:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B142AC4339E;
        Thu, 16 Mar 2023 17:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678986168;
        bh=2rdENgg7fzhoKYPinTYmZkVwba8MoExnAAxutCEQK3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iqjfspNDqGz3klTZPT2+BpffWd9f4W6SLqgKqRFii0Qw4uBg0XdMAi+nls+GHm3dP
         t3EdFLYjAWxF/k0NhZwvPKEpRPiSt/sBefMLuZVCBpQQ/phZzHSKTTxgVN5tQN7nS0
         +bF0J6oeBdA9BMVGZF72vgksl6td2ylD9b340n7jBfC2iB/AUqxhi1sYyMQb/MS7mB
         6FTBsJwAG11kA6/pox2tkaZx1afavULyHXdBh9QmzYTCvrqBJjZtouKIfhTzrvlQ5I
         4GsgMcdAxFBgxi3hL3OZ5O9QstrOLNsRV4iCd7w5//E6F0GNwJ7LHtIWx5ndQiJ9iA
         T+NEcJP1lLfdg==
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
        Namhyung Kim <namhyung@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCHv3 bpf-next 4/9] bpf: Switch BUILD_ID_SIZE_MAX to enum
Date:   Thu, 16 Mar 2023 18:01:44 +0100
Message-Id: <20230316170149.4106586-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316170149.4106586-1-jolsa@kernel.org>
References: <20230316170149.4106586-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switching BUILD_ID_SIZE_MAX to enum, so we expose it to BPF
programs through vmlinux.h.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/buildid.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index b8b2e00420d6..316971c634fe 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -5,7 +5,9 @@
 #include <linux/mm_types.h>
 #include <linux/slab.h>
 
-#define BUILD_ID_SIZE_MAX 20
+enum {
+	BUILD_ID_SIZE_MAX = 20
+};
 
 struct build_id {
 	u32 sz;
-- 
2.39.2

