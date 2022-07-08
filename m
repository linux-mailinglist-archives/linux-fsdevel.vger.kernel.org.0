Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCFE56B5AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 11:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbiGHJfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 05:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbiGHJe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:34:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A391532EC1
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jul 2022 02:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657272897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sMFHzJKRiYj62gdYRhno9WSMM22FrLKbwCUpBPEktWM=;
        b=IFbCmAIGioD3FcTWcwnZ4Aqlc3jzOEZZPAEiNtnih7hOsOFVTjBeSiI07jhRBux4kNMC+q
        iTxohJv+sFvWo0efsYjmvfuDkkgMfB6BeyCBLZnQ2jzUXDbB2jfXo9LWlIBGqZN217fgdn
        x3GIrvFquX17FLYvZOchjXEU+wtdoKw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-vld6GB2dOrW5EGRY1SMkzw-1; Fri, 08 Jul 2022 05:34:54 -0400
X-MC-Unique: vld6GB2dOrW5EGRY1SMkzw-1
Received: by mail-ej1-f69.google.com with SMTP id hd35-20020a17090796a300b0072a707cfac4so5451078ejc.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jul 2022 02:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sMFHzJKRiYj62gdYRhno9WSMM22FrLKbwCUpBPEktWM=;
        b=au1vCEnChNX6TzwPSH97adWfCmD98LxcIefF4ejhqJPYP9F56HIqxvnrKvZ8YnsfbT
         5WwAypQWbFtJ1SL/Wl6Px75OZjP+Di2I4g2f0bY1YyJYpdPyakhkTDFCbud/z76QRGwk
         CJhO0mgdSeg8m/1s8WRzOkYq+54JODSGiXDXGx00SkCCxQp6pFL/d3i15/fvG/kZlSag
         GDLv5/LAn6Xuj5ZSsCmbBoeqW7WOvyg5Z9ml/czN/BR1J+supz2qVyF+1rjdbPiepDSg
         aSTmg9xVfmuQVvd7tjWxPoPPsO7gd48bULJRxAJPLM9hz0RlrgH7h/5tCcoUEu7D0N9z
         0pgQ==
X-Gm-Message-State: AJIora/Ey1Z9EW7wRVyirj+loRhFLFcfr9mDDvX0xGhUzNieo+zVItr1
        G2rLXHuGA74owdsvfE5fUgEJZTGC8Z4ymuwxM2msD4Yrx7HY1PtL84kYe6kj1H+4rQtXhyHAbFR
        Pv1RYbZVYPi8QvPyevrWAgUQTRg==
X-Received: by 2002:a17:907:2895:b0:72a:f3bd:6e5f with SMTP id em21-20020a170907289500b0072af3bd6e5fmr2545868ejc.767.1657272893404;
        Fri, 08 Jul 2022 02:34:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vqzsj8D95ygzAuhY0cpDJI7xEx8WuoI4Z9hfBmeRv2uPXFteeEPUMGrkSiqA1aqHu8V5VEjQ==
X-Received: by 2002:a17:907:2895:b0:72a:f3bd:6e5f with SMTP id em21-20020a170907289500b0072af3bd6e5fmr2545851ejc.767.1657272893155;
        Fri, 08 Jul 2022 02:34:53 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j24-20020aa7de98000000b00435726bd375sm29359084edv.57.2022.07.08.02.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 02:34:52 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert O'Callahan <roc@ocallahan.org>
Subject: [RFC PATCH RESEND] userfaultfd: open userfaultfds with O_RDONLY
Date:   Fri,  8 Jul 2022 11:34:51 +0200
Message-Id: <20220708093451.472870-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since userfaultfd doesn't implement a write operation, it is more
appropriate to open it read-only.

When userfaultfds are opened read-write like it is now, and such fd is
passed from one process to another, SELinux will check both read and
write permissions for the target process, even though it can't actually
do any write operation on the fd later.

Inspired by the following bug report, which has hit the SELinux scenario
described above:
https://bugzilla.redhat.com/show_bug.cgi?id=1974559

Reported-by: Robert O'Callahan <roc@ocallahan.org>
Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

Resending as the last submission was ignored for over a year...

https://lore.kernel.org/lkml/20210624152515.1844133-1-omosnace@redhat.com/T/

I marked this as RFC, because I'm not sure if this has any unwanted side
effects. I only ran this patch through selinux-testsuite, which has a
simple userfaultfd subtest, and a reproducer from the Bugzilla report.

Please tell me whether this makes sense and/or if it passes any
userfaultfd tests you guys might have.

 fs/userfaultfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e943370107d0..8ccf00be63e1 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -989,7 +989,7 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *new,
 	int fd;
 
 	fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, new,
-			O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
+			O_RDONLY | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
 	if (fd < 0)
 		return fd;
 
@@ -2090,7 +2090,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	mmgrab(ctx->mm);
 
 	fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, ctx,
-			O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
+			O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
 	if (fd < 0) {
 		mmdrop(ctx->mm);
 		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
-- 
2.36.1

