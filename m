Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3FE78C780
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 16:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjH2O0G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 10:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbjH2OZ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE336AB
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 07:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693319107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=72jjJIsr12NXRU7aDK4GbDjvA7ef38LcvCbu/brjroY=;
        b=jM1uH5au6IDpdLsmKPLzAAFD3ShGhBl7TKjLxUEUV3H4NgWhQ1eYfg7KGYr97Aga53nDiG
        WUE92JeKl6mK8vKbZXxtB86epVVHJMkB2lbsL1PbBy82XV9EclJwDYPzNhpfe8X23bUUc2
        sjFK8knsaIf1QQ1Uq9MzPg0XzVVkWA4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-wtVE9DrCNKGX2Z_VT7fiSQ-1; Tue, 29 Aug 2023 10:25:05 -0400
X-MC-Unique: wtVE9DrCNKGX2Z_VT7fiSQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a1c4506e1eso68502366b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 07:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693319104; x=1693923904;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72jjJIsr12NXRU7aDK4GbDjvA7ef38LcvCbu/brjroY=;
        b=OEfvd6qo7wukEmJbgAlHp6ja6RilvKHBwCEZtgtMIVRNoyWuO2gcyueimStBnVX1ws
         nR6PuaslYQPAJGKxBCTUuNbwVvLE7Z8kbdXag04o9VfVTTgotzkuOdRp0QM24z5UPmmU
         0WnxCaDIuPscnZf5hcKEIYjVvM4uJhelvDqWgSY1EO2dtHgLmxjvSz0iMK2TDCZVE/YL
         /gZRMP6VRkOmveTYSuMG4CGhbCdZwng0XEeXz0B/YDpmfru7n9ryPf4SXNjlx68z5wer
         Br6XvCfY/5nT14P7Ibl98rF7qFKp9L5a4PqZ8vzXDtc+XGuUCa0kHSHoijmkKSGwWZ/A
         a8Tg==
X-Gm-Message-State: AOJu0YzKZgZDZ1Y8J/xeQWdypZeBC7TjGObt7gS0W3LlolM8oMbMaoPw
        7IsJ/9xgn+k0Z/y5HmRIu7bA5JlUHKHoAnBaSaydNsxTd3X4KndwuZR6CgcD0B6cXIigOuRSA+t
        iaT0hfFD6/bOdADIABtONOkyXlw==
X-Received: by 2002:a17:906:257:b0:9a1:eb67:c0d2 with SMTP id 23-20020a170906025700b009a1eb67c0d2mr12931439ejl.6.1693319104109;
        Tue, 29 Aug 2023 07:25:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKi2VXt+Ovw7zv8607SLKgZhnUivVO6erEvkOL/iqaS7Wn9pyraiegUPmPO3FzcCzxQroolQ==
X-Received: by 2002:a17:906:257:b0:9a1:eb67:c0d2 with SMTP id 23-20020a170906025700b009a1eb67c0d2mr12931432ejl.6.1693319103814;
        Tue, 29 Aug 2023 07:25:03 -0700 (PDT)
Received: from ?IPv6:2001:9e8:32d7:ba00:5749:c26e:a109:dac4? ([2001:9e8:32d7:ba00:5749:c26e:a109:dac4])
        by smtp.gmail.com with ESMTPSA id lv12-20020a170906bc8c00b009a19701e7b5sm6015949ejb.96.2023.08.29.07.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 07:25:03 -0700 (PDT)
Message-ID: <c441390345db294517195653408ef1cecea08feb.camel@redhat.com>
Subject: [RESEND PATCH v2] xarray: Document necessary flag in alloc functions
From:   pstanner@redhat.com
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>
Date:   Tue, 29 Aug 2023 16:25:02 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adds a new line to the docstrings of functions wrapping __xa_alloc() and
__xa_alloc_cyclic(), informing about the necessity of flag XA_FLAGS_ALLOC
being set previously.

The documentation so far says that functions wrapping __xa_alloc() and
__xa_alloc_cyclic() are supposed to return either -ENOMEM or -EBUSY in
case of an error. If the xarray has been initialized without the flag
XA_FLAGS_ALLOC, however, they fail with a different, undocumented error
code.

As hinted at in Documentation/core-api/xarray.rst, wrappers around these
functions should only be invoked when the flag has been set. The
functions' documentation should reflect that as well.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Version 2 of the proposed documentation update. As Matthew requested, I
added the sentence to all functions wrapping the above mentioned two
core functions.
Additionally, I added it to themselves, too, as these functions can also
be called by the user directly.
I also rephrased the commit message so that the implemented change is
mentioned first.
---
=C2=A0include/linux/xarray.h | 18 ++++++++++++++++++
=C2=A0lib/xarray.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 6 ++++++
=C2=A02 files changed, 24 insertions(+)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 741703b45f61..cb571dfcf4b1 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -856,6 +856,9 @@ static inline int __must_check xa_insert_irq(struct xar=
ray *xa,
=C2=A0 * stores the index into the @id pointer, then stores the entry at
=C2=A0 * that index.=C2=A0 A concurrent lookup will not see an uninitialise=
d @id.
=C2=A0 *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC=
 set
+ * in xa_init_flags().
+ *
=C2=A0 * Context: Any context.=C2=A0 Takes and releases the xa_lock.=C2=A0 =
May sleep if
=C2=A0 * the @gfp flags permit.
=C2=A0 * Return: 0 on success, -ENOMEM if memory could not be allocated or
@@ -886,6 +889,9 @@ static inline __must_check int xa_alloc(struct xarray *=
xa, u32 *id,
=C2=A0 * stores the index into the @id pointer, then stores the entry at
=C2=A0 * that index.=C2=A0 A concurrent lookup will not see an uninitialise=
d @id.
=C2=A0 *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC=
 set
+ * in xa_init_flags().
+ *
=C2=A0 * Context: Any context.=C2=A0 Takes and releases the xa_lock while
=C2=A0 * disabling softirqs.=C2=A0 May sleep if the @gfp flags permit.
=C2=A0 * Return: 0 on success, -ENOMEM if memory could not be allocated or
@@ -916,6 +922,9 @@ static inline int __must_check xa_alloc_bh(struct xarra=
y *xa, u32 *id,
=C2=A0 * stores the index into the @id pointer, then stores the entry at
=C2=A0 * that index.=C2=A0 A concurrent lookup will not see an uninitialise=
d @id.
=C2=A0 *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC=
 set
+ * in xa_init_flags().
+ *
=C2=A0 * Context: Process context.=C2=A0 Takes and releases the xa_lock whi=
le
=C2=A0 * disabling interrupts.=C2=A0 May sleep if the @gfp flags permit.
=C2=A0 * Return: 0 on success, -ENOMEM if memory could not be allocated or
@@ -949,6 +958,9 @@ static inline int __must_check xa_alloc_irq(struct xarr=
ay *xa, u32 *id,
=C2=A0 * The search for an empty entry will start at @next and will wrap
=C2=A0 * around if necessary.
=C2=A0 *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC=
 set
+ * in xa_init_flags().
+ *
=C2=A0 * Context: Any context.=C2=A0 Takes and releases the xa_lock.=C2=A0 =
May sleep if
=C2=A0 * the @gfp flags permit.
=C2=A0 * Return: 0 if the allocation succeeded without wrapping.=C2=A0 1 if=
 the
@@ -983,6 +995,9 @@ static inline int xa_alloc_cyclic(struct xarray *xa, u3=
2 *id, void *entry,
=C2=A0 * The search for an empty entry will start at @next and will wrap
=C2=A0 * around if necessary.
=C2=A0 *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC=
 set
+ * in xa_init_flags().
+ *
=C2=A0 * Context: Any context.=C2=A0 Takes and releases the xa_lock while
=C2=A0 * disabling softirqs.=C2=A0 May sleep if the @gfp flags permit.
=C2=A0 * Return: 0 if the allocation succeeded without wrapping.=C2=A0 1 if=
 the
@@ -1017,6 +1032,9 @@ static inline int xa_alloc_cyclic_bh(struct xarray *x=
a, u32 *id, void *entry,
=C2=A0 * The search for an empty entry will start at @next and will wrap
=C2=A0 * around if necessary.
=C2=A0 *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC=
 set
+ * in xa_init_flags().
+ *
=C2=A0 * Context: Process context.=C2=A0 Takes and releases the xa_lock whi=
le
=C2=A0 * disabling interrupts.=C2=A0 May sleep if the @gfp flags permit.
=C2=A0 * Return: 0 if the allocation succeeded without wrapping.=C2=A0 1 if=
 the
diff --git a/lib/xarray.c b/lib/xarray.c
index 2071a3718f4e..73b3f8b33a56 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1802,6 +1802,9 @@ EXPORT_SYMBOL(xa_get_order);
=C2=A0 * stores the index into the @id pointer, then stores the entry at
=C2=A0 * that index.=C2=A0 A concurrent lookup will not see an uninitialise=
d @id.
=C2=A0 *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC=
 set
+ * in xa_init_flags().
+ *
=C2=A0 * Context: Any context.=C2=A0 Expects xa_lock to be held on entry.=
=C2=A0 May
=C2=A0 * release and reacquire xa_lock if @gfp flags permit.
=C2=A0 * Return: 0 on success, -ENOMEM if memory could not be allocated or
@@ -1850,6 +1853,9 @@ EXPORT_SYMBOL(__xa_alloc);
=C2=A0 * The search for an empty entry will start at @next and will wrap
=C2=A0 * around if necessary.
=C2=A0 *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC=
 set
+ * in xa_init_flags().
+ *
=C2=A0 * Context: Any context.=C2=A0 Expects xa_lock to be held on entry.=
=C2=A0 May
=C2=A0 * release and reacquire xa_lock if @gfp flags permit.
=C2=A0 * Return: 0 if the allocation succeeded without wrapping.=C2=A0 1 if=
 the


