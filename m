Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B493D5EB57D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiIZXTx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiIZXTB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:19:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90F5D079B
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f3-20020a056902038300b00696588a0e87so7065435ybs.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=yTzbWKA3zPzjeiF937oMd+mrfs7eDa6MeIt8WxC7alo=;
        b=XxZSKP++rmDEAheWrfuIcNVJDlRhi31eGx0fW/AOn5FDJiyfDd+KgpYtrxZGtTn1pS
         ZiQc3KZZ/mFoH0nvvq42krCSaNA5K0wB6LWVwQYjuohdPjz3SAKJx8OWbQiHlTLDR4op
         fTUgoDz3gtxmVWXUwjq5WRsr8D/1BdtErlFd6nhr9WE9yUhKxTpaZ0S0wWMW2NRFw/a8
         yG1+UPwahz0d+H2fEBJSi1+mITB6N/sKxcDqKrJJOxT9sqiCbt9Wb4XvDmF/ibvKB3Iv
         l3++DdWpVDYnp7K+b5pilBcFlSteae6kc5L5UjGtRiHa3hXh/a9tRX/EZs6635gDwc8M
         j4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=yTzbWKA3zPzjeiF937oMd+mrfs7eDa6MeIt8WxC7alo=;
        b=ioZiDE3V8BlWhtysYPL9WNoweyvqovryyZn+q7Lw+Tm/n/pnV0ZXwzsPbIwfzKN3Ns
         Uc073TfjrXIPN4T8rXLfgJKd5Ta1M+gA97Vi4cjpOtlhlBbmTKeoIAr+gXUn7vPnuPUO
         T7s/EBdtvu91rHr1i/PfpUQcmwvwsoTHGUgUz6dpVWyGAtHb2duOWmBeGRdd4eneZb1A
         SY1u/1SOBs/n1Aphc+wQgfqBC5PGu0NyzAKiRmtIaJYWWAB+faajBvPHn7wADBH+Glcd
         ybyrx/y9mJVSbUWOH1TCK9RRYDUnL/rxxUNxWqdAkJCPpolCSkoykSDDTr33iInc6diF
         t1qw==
X-Gm-Message-State: ACrzQf10DsKLLW09Y/jHa1VXkSEvLchz5VGSrsRJiY/ydygynA2o+FGl
        fE5cRF3o9UM0qN+8Pdu3Gqj3HXXAslE=
X-Google-Smtp-Source: AMsMyM4moFi5+iumYozT+7qlS1BDI8DN0/blS/CYnmUA6IS+xnhRO4FLKdQ/ipgElvsFL6t89fVCoWxZ3Ew=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a25:af13:0:b0:6ae:3166:1aee with SMTP id
 a19-20020a25af13000000b006ae31661aeemr23247290ybh.288.1664234333269; Mon, 26
 Sep 2022 16:18:53 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:05 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-10-drosen@google.com>
Subject: [PATCH 09/26] fuse-bpf: Don't support export_operations
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

In the future, we may choose to support these, but it poses some
challenges. In order to create a disconnected dentry/inode, we'll need
to encode the mountpoint and bpf into the file_handle, which means we'd
need a stable representation of them. This also won't hold up to cases
where the bpf is not stateless. One possibility is registering bpf
programs and mounts in a specific order, so they can be assigned
consistent ids we can use in the file_handle. We can defer to the lower
filesystem for the lower inode's representation in the file_handle.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ca65199b38cb..290eae750282 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1122,6 +1122,14 @@ static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	nodeid = get_fuse_inode(inode)->nodeid;
 	generation = inode->i_generation;
 
+#ifdef CONFIG_FUSE_BPF
+	/* TODO: Does it make sense to support this in some cases? */
+	if (!nodeid && get_fuse_inode(inode)->backing_inode) {
+		*max_len = 0;
+		return FILEID_INVALID;
+	}
+#endif
+
 	fh[0] = (u32)(nodeid >> 32);
 	fh[1] = (u32)(nodeid & 0xffffffff);
 	fh[2] = generation;
-- 
2.37.3.998.g577e59143f-goog

