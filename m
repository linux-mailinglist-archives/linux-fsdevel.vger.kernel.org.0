Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2257875282B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 18:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjGMQSW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 12:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbjGMQSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:18:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920C2271F
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 09:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689265049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MwgfqxZl2NTLTZ9ypu2Kr46Coc5E5W6F56QoJEGuiX4=;
        b=hjg3ait7odcE4myQ75mFBGJ24mYbf/khV7hiGRlrnavR56T84jjmIqmeUe7jub3vGLFhux
        TgChG1QX2TaHjKXk7CE7cUtDC2UcRch2vFP9yM5+Pn3reyBQ5ynk455RrgA/AgtBdFYYJ8
        zhsZgemongSH2pmYvDW2kzIfAmRHmVY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-f91XgNk2P7KxMVo0zqwyxg-1; Thu, 13 Jul 2023 12:17:23 -0400
X-MC-Unique: f91XgNk2P7KxMVo0zqwyxg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a342f1703so15914166b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 09:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689265042; x=1689869842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MwgfqxZl2NTLTZ9ypu2Kr46Coc5E5W6F56QoJEGuiX4=;
        b=Wt0RcSAgkUevpGSodZnARaw7H0SWyUxGUWbvhyckmdCwfnCBKPjwfEO/qB3wai65ST
         tmXPKbdI3C4f/XaPP4zph/lQO6lbFKC9xQ2Znzct5Tt/2O/wRA5c0uUcOIdN07Z820OO
         Ge6ngGxglFUoLhVcW9j0kOp8XkHsktBz4xzt4vji/eTrAWRwcTKvkvW8r2qV46qggx26
         qqJPOpk9CIrLS79iH1HyG/y7vnmyFhVUt4j7lnks20SZowQhDtwKMfmwnXx35llQmzYo
         dLVVb/dbubrVT/P6BcHVDZigY5mF+QrIem7QQ7X8SfRuNqjhjBV4EavwxMN/P9y0gPaA
         PwqA==
X-Gm-Message-State: ABy/qLY0FDxAq/XwVt6oQcoqfyFnP1gztTGXIRb2V7EEQFUCv79PwwoS
        jnz+wNbOW+mMnfYtbPoFAPeMk7riuySeZ03nmr7J/fFuEhuIPaXNiv0zkZg1AImqMllxEn0rNSP
        X0Xw6u3LiWK7hv9ShZRePaHtSfWx7cBLhuv43
X-Received: by 2002:a17:906:74dc:b0:994:1808:176b with SMTP id z28-20020a17090674dc00b009941808176bmr1357785ejl.6.1689265042044;
        Thu, 13 Jul 2023 09:17:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGg5/qA5OTZt4FPaDKjPRHcf+zaU3EShNfBuoczkoCDcWAVqvkcXNabXUJ7rSmng8vhPOPfxQ==
X-Received: by 2002:a17:906:74dc:b0:994:1808:176b with SMTP id z28-20020a17090674dc00b009941808176bmr1357771ejl.6.1689265041764;
        Thu, 13 Jul 2023 09:17:21 -0700 (PDT)
Received: from fedora.fritz.box ([2001:9e8:32ed:7c00:1004:219d:c045:4b92])
        by smtp.gmail.com with ESMTPSA id y24-20020a17090629d800b0098822e05539sm4190067eje.191.2023.07.13.09.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:17:21 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH 1/1] xarray: Document necessary flag in alloc-functions
Date:   Thu, 13 Jul 2023 18:17:11 +0200
Message-ID: <20230713161712.3163-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adds lines to the docstrings in xarray.h and xarray.c to inform about
the necessity of the XA_FLAGS_ALLOC flag being set when using
xa_alloc().

The documentation so far says that xa_alloc() is supposed to return
either -ENOMEM or -EBUSY in case of an error. If the xarray has been
initialized without the flag XA_FLAGS_ALLOC, however, xa_alloc() fails
with a different error code.

As hinted at in Documentation/core-api/xarray.rst, calling this function
requires that flag being set. The function's documentation should
reflect that as well.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
I would pick up the other places where this information has to be
added if someone can provide me with a list :)
---
 include/linux/xarray.h | 3 +++
 lib/xarray.c           | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 741703b45f61..2970014fca54 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -856,6 +856,9 @@ static inline int __must_check xa_insert_irq(struct xarray *xa,
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Must only be called on an xarray initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Any context.  Takes and releases the xa_lock.  May sleep if
  * the @gfp flags permit.
  * Return: 0 on success, -ENOMEM if memory could not be allocated or
diff --git a/lib/xarray.c b/lib/xarray.c
index 2071a3718f4e..73b3f8b33a56 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1802,6 +1802,9 @@ EXPORT_SYMBOL(xa_get_order);
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Must only be called on an xarray initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Any context.  Expects xa_lock to be held on entry.  May
  * release and reacquire xa_lock if @gfp flags permit.
  * Return: 0 on success, -ENOMEM if memory could not be allocated or
@@ -1850,6 +1853,9 @@ EXPORT_SYMBOL(__xa_alloc);
  * The search for an empty entry will start at @next and will wrap
  * around if necessary.
  *
+ * Must only be called on an xarray initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Any context.  Expects xa_lock to be held on entry.  May
  * release and reacquire xa_lock if @gfp flags permit.
  * Return: 0 if the allocation succeeded without wrapping.  1 if the
-- 
2.39.3

