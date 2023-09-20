Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2627A70A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 04:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjITClf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 22:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjITClf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78D0CA
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 19:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695177645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LON9ahyVIde4FDVLqDdNEWwu95NHYIyR61+gZR8925U=;
        b=QRP89fuvfIp6JLQjkyqu7ebqu3Xt7qV6A9uBoesTA4QcPh5ZWO1IaFZmbqRXpx439+iB7M
        z+WG88udvEBYr+60Zr4ELqRaYPlecG29c0gNmzRvk0ZsovFJEsYPp0+fAKrz4xF350c+7N
        swr47vaJhvIKUvpuy7ui+rleGpOf7Tc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-NczkEcqfMjqgRT2L0_8QaA-1; Tue, 19 Sep 2023 22:40:42 -0400
X-MC-Unique: NczkEcqfMjqgRT2L0_8QaA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41669a6a888so77827961cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 19:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695177639; x=1695782439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LON9ahyVIde4FDVLqDdNEWwu95NHYIyR61+gZR8925U=;
        b=vDEaS/7aZRQOkrpcydLC9vAeIMVbAiwQLVTZSqZpEmUxH78Q33bVN5GNBTWx5itQ+D
         bIQtIAPdV6MInS/8kOL5VbWNuxzmQ4hi94XIjeyGQ9ldL26iGKM88g1oCuTnBYGs8hwH
         zmumRUCF6pUa1Q/GHWu7Do9nXgCD99kgOvVRTXziPywxczai3PlF+w7ob060my3Mtpmz
         OwnDu5S5ztk/Gj5yNoe69wCiX60SCql4H4y4XUrqiaE/KjcZVH+KWaVSKFez6TXDptoe
         GsDyXUT9mMYYmZzOndmEfMnwoE5U5FjxInpI5phrNBApIs3Gb2AMjHAJK45wij0zhazf
         Xmiw==
X-Gm-Message-State: AOJu0Yydql8l2H6fzoGxfjByVdlQgUn+1m56h7jkyuEVhCUQGQoK8Ysq
        PfSjKQD0mt51JRurPFB3oqraha762qA6bSURt2xspRG9QVg0CyFOXMDwo0D3zggVYM4hh18nweL
        nZVJAgpSI263thSJkJZG5OwCH9SI1Oo57mLwqWdMbR2roXNXBJNeVKZvi+4sFbjuead+A+l2i19
        WlTReoH4/PPsrC
X-Received: by 2002:a05:622a:5590:b0:40c:58a1:cb48 with SMTP id fk16-20020a05622a559000b0040c58a1cb48mr1300296qtb.51.1695177639504;
        Tue, 19 Sep 2023 19:40:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQH6Q0sJMM7XpuZfvx3a0H2Zo814eG7ChLMFxDWzCDUKw6tl5dlZj0ZyduE3ho7CWgp6mBMw==
X-Received: by 2002:a05:622a:5590:b0:40c:58a1:cb48 with SMTP id fk16-20020a05622a559000b0040c58a1cb48mr1300281qtb.51.1695177639200;
        Tue, 19 Sep 2023 19:40:39 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
        by smtp.gmail.com with ESMTPSA id j23-20020ac84417000000b0041020e8e261sm4277093qtn.1.2023.09.19.19.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 19:40:38 -0700 (PDT)
From:   Tyler Fanelli <tfanelli@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     mszeredi@redhat.com, gmaglione@redhat.com, hreitz@redhat.com,
        Tyler Fanelli <tfanelli@redhat.com>
Subject: [PATCH 2/2] docs/fuse-io: Document the usage of DIRECT_IO_ALLOW_MMAP
Date:   Tue, 19 Sep 2023 22:40:01 -0400
Message-Id: <20230920024001.493477-3-tfanelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230920024001.493477-1-tfanelli@redhat.com>
References: <20230920024001.493477-1-tfanelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

By default, shared mmap is disabled in FUSE DIRECT_IO mode. However,
when the DIRECT_IO_ALLOW_MMAP flag is enabled in the FUSE_INIT reply,
shared mmap is allowed.

Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
---
 Documentation/filesystems/fuse-io.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/fuse-io.rst b/Documentation/filesystems/fuse-io.rst
index 255a368fe534..6464de4266ad 100644
--- a/Documentation/filesystems/fuse-io.rst
+++ b/Documentation/filesystems/fuse-io.rst
@@ -15,7 +15,8 @@ The direct-io mode can be selected with the FOPEN_DIRECT_IO flag in the
 FUSE_OPEN reply.
 
 In direct-io mode the page cache is completely bypassed for reads and writes.
-No read-ahead takes place. Shared mmap is disabled.
+No read-ahead takes place. Shared mmap is disabled by default. To allow shared
+mmap, the FUSE_DIRECT_IO_ALLOW_MMAP flag may be enabled in the FUSE_INIT reply.
 
 In cached mode reads may be satisfied from the page cache, and data may be
 read-ahead by the kernel to fill the cache.  The cache is always kept consistent
-- 
2.40.1

