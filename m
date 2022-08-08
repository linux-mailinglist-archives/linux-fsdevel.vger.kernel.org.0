Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FF358C93D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 15:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbiHHNRr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 09:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbiHHNRo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A830B5FDE
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Aug 2022 06:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659964661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=F3isuR0jQPqF+YB0HX0DbKwI7eUCGW/G7ScBjYwrfKU=;
        b=YEtd8SccRz3RUn6HV5yl5KBN9kpGYRcGwyWAnhVovNSURVWw1A30r46qrjEMrSHtfeUzES
        vfaVC+YSgpFt939tGrPTRXivxnuZj+Z+whSknAhXSWv9EQrTHJ9/RsR3voCjofZUEUlkxU
        WfWtedYq63LOqVB23Lo+EMHnaTTV+qc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-2sQI0B1CMFqk3ENTj3BrcQ-1; Mon, 08 Aug 2022 09:17:37 -0400
X-MC-Unique: 2sQI0B1CMFqk3ENTj3BrcQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E19485A58C;
        Mon,  8 Aug 2022 13:17:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E1279457F;
        Mon,  8 Aug 2022 13:17:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org
cc:     dhowells@redhat.com, Ian Kent <raven@themaw.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] uapi: Remove the inclusion of linux/mount.h from uapi/linux/fs.h
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <163409.1659964655.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 08 Aug 2022 14:17:35 +0100
Message-ID: <163410.1659964655@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

We're seeing issues in autofs and xfstests whereby linux/mount.h (the UAPI
version) as included indirectly by linux/fs.h is conflicting with
sys/mount.h (there's a struct and an enum).

Would it be possible to just remove the #include from linux/fs.h (as patch
below) and rely on those hopefully few things that need mount flags that d=
on't
use the glibc header for them working around it by configuration?

David
---
uapi: Remove the inclusion of linux/mount.h from uapi/linux/fs.h
    =

Remove the inclusion of <linux/mount.h> from uapi/linux/fs.h as it
interferes with definitions in sys/mount.h - but linux/fs.h is needed by
various things where mount flags and structs are not.

Note that this will likely have the side effect of causing some build
failures.

Reported-by: Ian Kent <raven@themaw.net>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Christian Brauner <christian@brauner.io>
cc: linux-fsdevel@vger.kernel.org
cc: linux-api@vger.kernel.org
---
 include/uapi/linux/fs.h |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index bdf7b404b3e7..7a2597ac59ed 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -17,11 +17,6 @@
 #include <linux/fscrypt.h>
 #endif
 =

-/* Use of MS_* flags within the kernel is restricted to core mount(2) cod=
e. */
-#if !defined(__KERNEL__)
-#include <linux/mount.h>
-#endif
-
 /*
  * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
  * the file limit at runtime and only root can increase the per-process

