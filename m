Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE7E5648ED
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jul 2022 20:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiGCSRu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 14:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiGCSRt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 14:17:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C0C16273
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 Jul 2022 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656872267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+VCKl9j7lixqYhrfaZVBrVSB6bBOfCLezxzbPVQjUoo=;
        b=a0ngEOouFjwuo9Snt7+tMCIx+cx7/5oCQBqsC36wcnhpUEOp+JNT9hWwvgwid3WU7LW76L
        p0BZePZ4329TmKpi0xLKiA5YPan46jeGH+8EKIFwcuwKP2LUjrQttyri5sPbSg1LEfh+Vx
        Efw3WW6XJqPmoAt4cVvI/6Sg3X9HqxQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-D53PypdIMYOvkjTdwx7plw-1; Sun, 03 Jul 2022 14:17:46 -0400
X-MC-Unique: D53PypdIMYOvkjTdwx7plw-1
Received: by mail-ed1-f72.google.com with SMTP id v16-20020a056402349000b00435a1c942a9so5665943edc.15
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Jul 2022 11:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+VCKl9j7lixqYhrfaZVBrVSB6bBOfCLezxzbPVQjUoo=;
        b=UQc//EEQ4bSiCo9ZYiYOqsmXq08WUa2sXCrUL1jBwGtrClvyjg0wSvC3FL4ShCO6SO
         xcVJ9uUp324iwIIi4w/g3n8PwuvsRxV/cHxsDWX6mF8iOuBHLyRQ1vEAe040hr0KdBnq
         SIe5db8paiWgGq0m4W0YbbXDipVAMXBsqKF9xToYqXcIImXX0d/EQqXMXqPKMdkJzCnX
         DD26IpLUARbz7NjKj6r3NEhK2MlLXPdzrRErbhe/Xqw7dJ/m1XyLnueLgV+RWW/8kOXm
         cL2BEKhayG8Co73kdDvI34MtdpMDu4L3jgsKdWefTy/SvFxG8kbJigOY1yHl1DX8h75p
         QmbA==
X-Gm-Message-State: AJIora84xX3Eg2pzr9hpUFqOy1KtscDVIVtY77KoRcjqM+rQamNaeDI+
        AjbVctqDyRAzCSzjsa+Dol4k7ID1bhqw1nNKfFg+QWe5SdJNxh8Lz76hRJjLH/NbmGZ8bDeqqqJ
        vWcQ02mLwnrzX6AKFjNIe1r9JUQ==
X-Received: by 2002:a17:907:7639:b0:72a:98dd:58b9 with SMTP id jy25-20020a170907763900b0072a98dd58b9mr10377962ejc.614.1656872265244;
        Sun, 03 Jul 2022 11:17:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tn30U8VpEG0/uAZ6YMxLWwj5KleLa3Q2L8vKMz5Ki6156+H1VAQyMdLwSjZs/vCGF6vVHHIw==
X-Received: by 2002:a17:907:7639:b0:72a:98dd:58b9 with SMTP id jy25-20020a170907763900b0072a98dd58b9mr10377955ejc.614.1656872265097;
        Sun, 03 Jul 2022 11:17:45 -0700 (PDT)
Received: from pollux.. ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id q21-20020aa7cc15000000b0042617ba638esm18959371edt.24.2022.07.03.11.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 11:17:44 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 2/2] doc/idr: adjust to new IDR allocation API
Date:   Sun,  3 Jul 2022 20:17:39 +0200
Message-Id: <20220703181739.387584-2-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220703181739.387584-1-dakr@redhat.com>
References: <20220703181739.387584-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The IDR API was adjusted to match the IDA API, adjust the
documentation accordingly.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 Documentation/core-api/idr.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/idr.rst b/Documentation/core-api/idr.rst
index 2eb5afdb9931..53310d1a2552 100644
--- a/Documentation/core-api/idr.rst
+++ b/Documentation/core-api/idr.rst
@@ -24,9 +24,9 @@ Start by initialising an IDR, either with DEFINE_IDR()
 for statically allocated IDRs or idr_init() for dynamically
 allocated IDRs.
 
-You can call idr_alloc() to allocate an unused ID.  Look up
-the pointer you associated with the ID by calling idr_find()
-and free the ID by calling idr_remove().
+You can call idr_alloc(), idr_alloc_range(), idr_alloc_min() or idr_alloc_max()
+to allocate an unused ID, look up the pointer you associated with the ID by
+calling idr_find() and free the ID by calling idr_remove().
 
 If you need to change the pointer associated with an ID, you can call
 idr_replace().  One common reason to do this is to reserve an
-- 
2.36.1

