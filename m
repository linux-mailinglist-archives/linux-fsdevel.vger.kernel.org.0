Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC3F6094CB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Oct 2022 18:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiJWQln (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 12:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiJWQlm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 12:41:42 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CB665667;
        Sun, 23 Oct 2022 09:41:41 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q71so6804037pgq.8;
        Sun, 23 Oct 2022 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2bDAIefZxbRVSM/SaH1NL1oBBLTDGxU2sWjuEVySo0=;
        b=Al/bcK0raH1SRXE3/4nftiI+qFU0z7u3k5IRgL6icE1yDmPYX2WINBttZZWg6W9gdw
         qHV+4EGaMiArBjM6MvF2wwY6mN2LVba5NOMZj/QrP/5+Bryf2WTfQlW+08VUjSMr5MG/
         13kG3W3i7TdUKHtJrSytliHcOPp9cuLRBFRAuhlht3va1ku6Xf1g7XQFZMHBzKnqsAMH
         Ae21n34Q7N6EUO2YWsClQUHKZZwnQnTl2NdNcEAbjYYplZ6LBpjtKQj1EwcNKC750YTE
         uI7vtK/s1V8cusDsD9AUW+bkBmYF9/UMTyhRCRsXOxv79AISblKjdYeq2okdLegW+Jpw
         MZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2bDAIefZxbRVSM/SaH1NL1oBBLTDGxU2sWjuEVySo0=;
        b=rxm/W7eI9a0komlZLMZWCKPXIs/fD8BKPFgqGSUU0vcG/NAta5SUHft2TQlSoq/os8
         AtD0T+C5m+JxcaIXFDGnFgdf4xm2Y+RZSxyqGyOhgUxVH6B9vnB9p+BZm9HOnTF7Am+C
         aDijTa3+TxsHf6urxkHIt4AB/HTv1OVR3993BfJcP6CvRkmASiIkgqQQB1imri+/3zCj
         n7gPTwfI8l0AOGZu/iWjz9P/vetGn6tNc9Viqr5jj3RgH6rz0EL7lza5gzi3ddPW09ba
         GK35aLFVoKjzObqrleU6QKU/s3Ibe7R2ZiDzzOoI8GrHMiiHgkCAZiTbCpLTVoZXx9dl
         cHjQ==
X-Gm-Message-State: ACrzQf0I3brjG7BhCcw15Y7QxNdUXqE5/1urXm8Uy5E3KiyoK2J3d2pX
        jYzMYtgMaLA9li44uSueZMA=
X-Google-Smtp-Source: AMsMyM7irLWDlav1VeIiY5mui3ckyNhI3n2zU5dxXGRJ0JYZXVfYymRXmX9OmNkmEthf8F8HB6u5Zw==
X-Received: by 2002:a05:6a00:27a1:b0:566:8937:27c2 with SMTP id bd33-20020a056a0027a100b00566893727c2mr29010630pfb.24.1666543301375;
        Sun, 23 Oct 2022 09:41:41 -0700 (PDT)
Received: from localhost ([223.104.41.250])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b0017a04542a45sm5618366pln.159.2022.10.23.09.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 09:41:41 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     yin31149@gmail.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     18801353760@163.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH -next 2/5] nfs: fix possible null-ptr-deref when parsing param
Date:   Mon, 24 Oct 2022 00:39:45 +0800
Message-Id: <20221023163945.39920-3-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221023163945.39920-1-yin31149@gmail.com>
References: <20221023163945.39920-1-yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

According to commit "vfs: parse: deal with zero length string value",
kernel will set the param->string to null pointer in vfs_parse_fs_string()
if fs string has zero length.

Yet the problem is that, nfs_fs_context_parse_param() will dereferences the
param->string, without checking whether it is a null pointer, which may
trigger a null-ptr-deref bug.

This patch solves it by adding sanity check on param->string
in nfs_fs_context_parse_param().

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 fs/nfs/fs_context.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 4da701fd1424..0c330bc13ef2 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -684,6 +684,8 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 			return ret;
 		break;
 	case Opt_vers:
+		if (!param->string)
+			goto out_invalid_value;
 		trace_nfs_mount_assign(param->key, param->string);
 		ret = nfs_parse_version_string(fc, param->string);
 		if (ret < 0)
@@ -696,6 +698,8 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		break;
 
 	case Opt_proto:
+		if (!param->string)
+			goto out_invalid_value;
 		trace_nfs_mount_assign(param->key, param->string);
 		protofamily = AF_INET;
 		switch (lookup_constant(nfs_xprt_protocol_tokens, param->string, -1)) {
@@ -732,6 +736,8 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		break;
 
 	case Opt_mountproto:
+		if (!param->string)
+			goto out_invalid_value;
 		trace_nfs_mount_assign(param->key, param->string);
 		mountfamily = AF_INET;
 		switch (lookup_constant(nfs_xprt_protocol_tokens, param->string, -1)) {
-- 
2.25.1

