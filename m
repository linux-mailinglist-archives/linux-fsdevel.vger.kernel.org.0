Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85BE57E828
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 22:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbiGVUPW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 16:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbiGVUPU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:15:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CCF13CFB
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jul 2022 13:15:19 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-317f6128c86so46881257b3.22
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jul 2022 13:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=c/c766f5IweLiXfTzCwsILplI2BRgHB64Zpkrcr5r4c=;
        b=IVmB1KhfRC9dhpaTkpIjZ6E3f+Szh9fFdOVOyseY1NVukF8w6zwOAocHq6J1WNgOx7
         MkeP7D6XmaSW+5oGvdDUL4lzrNGQs+5+3SzlU1AMRuxE8aagduAp2F/E7t9ZmgbuwpjO
         f306zDfgyelvBDZnfGcG8V+emseVEwfjhn1IjzDmb1pHxpuSwWN5tvBBazNN5/qG4idy
         0HIiZvpiJVPJ0ZAcKaJCuS/PXvPEoLzAMUJto3JnYgY7Ng6J/iATPcYHANgx87GtHulV
         wiCPLmIuBvP3zKYVaBGLJd3oDLj4WIAhZAT9wtlrMeNw2yNlJnbECqep3fMPmM0ZgOif
         HqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=c/c766f5IweLiXfTzCwsILplI2BRgHB64Zpkrcr5r4c=;
        b=UlwXqckeFvW65YJkbLEQz3jCzEW3BfsW9zdGVfxjAwg941k6dBo1FFR9+/xmlkQrKn
         XmIrz+fZHeKcaLqMu8444c2LkDnKdaytEu3SJOkeqqAHtNmcXj/T3YDmM2pmZ0Q9suUb
         lMuqFqYkXmFk1nXZBjJ8kR/yx91bzx2mv7m0yVN/FAOE/GflxMKpbQPJ8Tgl/eJl4Jm1
         qT9UMQ3z7UZO4woyuOaoAlEJhAh7imj0e2snwBJP42C1gm3C/TbjM8FIdPrPsizZzKSq
         wGszdDxdMUIsbbiwMdoRsYi2pU+/IT7mqYvsHjz47b0YAkiPSwn7P2sLsdYjkzXtf14G
         Mj7A==
X-Gm-Message-State: AJIora+WOAzQS9ptjqQuWF8Cd7L9xeqqpmRPn2vEg45ES2FuNq2erc1V
        8fEG8o4/aoSj0R7Gr++d+Fb35PeBR/6D4IsMPW++
X-Google-Smtp-Source: AGRyM1uRjPK6eRsDWx956R4w3PIY9GowmVfxAwibKdWDAaVTmRSzk/CGssJt4ZsxlokH97WRezORFs8FoPg+8IAOZxDR
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:1623:4cce:b896:4e2f])
 (user=axelrasmussen job=sendgmr) by 2002:a25:af93:0:b0:670:7de3:6c30 with
 SMTP id g19-20020a25af93000000b006707de36c30mr1242861ybh.569.1658520918930;
 Fri, 22 Jul 2022 13:15:18 -0700 (PDT)
Date:   Fri, 22 Jul 2022 13:15:13 -0700
Message-Id: <20220722201513.1624158-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH] userfaultfd: don't fail on unrecognized features
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

The basic interaction for setting up a userfaultfd is, userspace issues
a UFFDIO_API ioctl, and passes in a set of zero or more feature flags,
indicating the features they would prefer to use.

Of course, different kernels may support different sets of features
(depending on kernel version, kconfig options, architecture, etc).
Userspace's expectations may also not match: perhaps it was built
against newer kernel headers, which defined some features the kernel
it's running on doesn't support.

Currently, if userspace passes in a flag we don't recognize, the
initialization fails and we return -EINVAL. This isn't great, though.
Userspace doesn't have an obvious way to react to this; sure, one of the
features I asked for was unavailable, but which one? The only option it
has is to turn off things "at random" and hope something works.

Instead, modify UFFDIO_API to just ignore any unrecognized feature
flags. The interaction is now that the initialization will succeed, and
as always we return the *subset* of feature flags that can actually be
used back to userspace.

Now userspace has an obvious way to react: it checks if any flags it
asked for are missing. If so, it can conclude this kernel doesn't
support those, and it can either resign itself to not using them, or
fail with an error on its own, or whatever else.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e943370107d0..4974da1f620c 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1923,10 +1923,8 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_api, buf, sizeof(uffdio_api)))
 		goto out;
-	features = uffdio_api.features;
-	ret = -EINVAL;
-	if (uffdio_api.api != UFFD_API || (features & ~UFFD_API_FEATURES))
-		goto err_out;
+	/* Ignore unsupported features (userspace built against newer kernel) */
+	features = uffdio_api.features & UFFD_API_FEATURES;
 	ret = -EPERM;
 	if ((features & UFFD_FEATURE_EVENT_FORK) && !capable(CAP_SYS_PTRACE))
 		goto err_out;
-- 
2.37.1.359.gd136c6c3e2-goog

