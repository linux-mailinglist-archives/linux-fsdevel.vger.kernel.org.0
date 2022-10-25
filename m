Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC6C60D37B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 20:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiJYSV6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 14:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJYSV5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:21:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E350DD8A9
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 11:21:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-36b7cfda276so77261157b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 11:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PjNoCfBC/CKwMAwiLtsnaqEW9HWbqcvaYiZFCHqhX1A=;
        b=cUt63EGPJ5XLXHEiRR83p6e5nk3wF+EccI3J2Nj4Hz7sd+o45EdjHmClaVdJS7D6Qt
         SRVj8/gV7ow6GDJ8o9U0wqDQuR4bhJD648XzGLZIF6bPN1Sdx3E6Rg7CDPlZWdwOkQgp
         AldXSSSnsZD7zLMgOdb0Vfa/h8JHe098M+X4gSZKtZWQWp5p15UcDWhAiMMLrjUjhkcY
         KC0eBsTNKsCRaOvTdGIHQ6ESz+Ix1YWpg7YnPKEM4Ti4Gz2qXJY47W47EziC/8C/dDfo
         8xbZi5AbaDJ/hjFTwNPbJswDGS8yutCtZxwos1qagpx/I6fIYQdakdLMhuiTDm8H//iZ
         9INg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PjNoCfBC/CKwMAwiLtsnaqEW9HWbqcvaYiZFCHqhX1A=;
        b=5ovnUH0cShQDYdgG59szmxOcLex2XfwZikif8OHkY/zBy7XmBSkHecwwMvErTVr7ra
         BRR/E/7XAkhvU4VGCR+0WJE+eFHztxEKsyi8MyjELaHcsfIc9IGwErw3PfU1RGsODQww
         jSISJuwAidxRYbppSakAp+5vYS4pnf0bZ92WSnUjr5xwotdjbkcCRLcMpC+nnp4Ipbrp
         KhkjqJk/ODxluw+BEYT+e+hz56rr6gn8PVAGqzeoD+hhixrEk0r1H3v7Wt1DLUO1K2PI
         mjxbua5lihLcaf8RS+Xs9rOkDhTw6Dh3sukPGnSVw18c/C1RiHVrinx54VuYgCIazWmN
         WXaA==
X-Gm-Message-State: ACrzQf0i+ijAIm/iVbvxCjTOSfR3m7GCHEaxzHQFnMu/sIqtNY+B6bK7
        JF25NJSbVAWyOyJS25d9IAcDj8hC8Fs9H6NDGNeS
X-Google-Smtp-Source: AMsMyM4O87oXuKbv1CK6ykDEbUdHUhv03vaFJfj6qvi2cGjc27L1Ng0hWt6v43WJjuwTFmjgJpiMHYC0BIw0H/MfKP8n
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:9558:df20:7923:f362])
 (user=axelrasmussen job=sendgmr) by 2002:a0d:cc51:0:b0:36c:98b0:dc38 with
 SMTP id o78-20020a0dcc51000000b0036c98b0dc38mr12308042ywd.275.1666722115408;
 Tue, 25 Oct 2022 11:21:55 -0700 (PDT)
Date:   Tue, 25 Oct 2022 11:21:49 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221025182149.3076870-1-axelrasmussen@google.com>
Subject: [PATCH] userfaultfd: wake on unregister for minor faults as well as missing
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This was an overlooked edge case when minor faults were added. In
general, minor faults have the same rough edge here as missing faults:
if we unregister while there are waiting threads, they will just remain
waiting forever, as there is no way for userspace to wake them after
unregistration. To work around this, userspace needs to carefully wake
everything before unregistering.

So, wake for minor faults just like we already do for missing faults as
part of the unregistration process.

Cc: stable@vger.kernel.org
Fixes: 7677f7fd8be7 ("userfaultfd: add minor fault registration mode")
Reported-by: Lokesh Gidra <lokeshgidra@google.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 07c81ab3fd4d..7daee4b9481c 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1606,7 +1606,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			start = vma->vm_start;
 		vma_end = min(end, vma->vm_end);
 
-		if (userfaultfd_missing(vma)) {
+		if (userfaultfd_missing(vma) || userfaultfd_minor(vma)) {
 			/*
 			 * Wake any concurrent pending userfault while
 			 * we unregister, so they will not hang
-- 
2.38.0.135.g90850a2211-goog

