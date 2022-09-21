Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3231D5BFA4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 11:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiIUJLq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 05:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiIUJLm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:11:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7F48C01B
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 02:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663751500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WC6/DGYF8qcehWVY2jYYza3kiuELOiZFELq0Dz0Z19s=;
        b=HN82nFWGA3KGqTVTgiAJy+LaJoM+slTprxospBvdYlI+RdApBpf7i9+os+J2KCk2ITGioD
        iEfHFhj5VwrFv9PMnuikOao+U9BrC/PoYqHuEFdUa5kjEvZ0S13aFk/IuGo5yZxcgBORUe
        IYYgDqgZlLx2zaXXPLr9jAKjO5qfR5A=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-636-RLOEpnYOOXCcH6ok-c12fA-1; Wed, 21 Sep 2022 05:11:37 -0400
X-MC-Unique: RLOEpnYOOXCcH6ok-c12fA-1
Received: by mail-lj1-f200.google.com with SMTP id r17-20020a2e9951000000b0026c37a02656so1793364ljj.20
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 02:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=WC6/DGYF8qcehWVY2jYYza3kiuELOiZFELq0Dz0Z19s=;
        b=5x44B8jHT2IKsYz7CmfzmrslgXpcQWBX3qcgNIwsfzq4DCdfPYhoFElMOooYDM+NIE
         YJV3E5xFr5P5UVh0Y+V4yeE4rpioHYqIN7AstCvim6EtEAOeRBqs/c6jH0bT8xTEbRH4
         CPrQgJHSMm2RrMBqVefgdUXN7ZTeL0+kwlK46LB/I8psiVDGQdWY8Pnb5gdj0Wyqwt7T
         6j/aKlREYqyjQH8ATZ6LBkotrp+d6xTN1rIubGWa42utrPJ7FOJYzpU9uQHjT8GYqidT
         E3n1xMRVdVd7ztXDweKcMzQpMgRmvP/F3LNKFZaGZAfWDa2hzso18qKQ7pNIjQMaAjIc
         qpVA==
X-Gm-Message-State: ACrzQf3pgm7ir4ssJi4qaEIBK7ok9QbxX4co3YjSavIlp+hlmtfeN+rL
        gOvo/EwtvDIKwso6Nn+kQifkLUAgHXrgQ8DXcYAz1V/16401jJC5n3VBNqnohirUZH2pg9y+geV
        TfR3geSBC3wMir2M/Lp/2Bzdu+Q==
X-Received: by 2002:a2e:a5c2:0:b0:261:d23a:2009 with SMTP id n2-20020a2ea5c2000000b00261d23a2009mr8077866ljp.303.1663751496014;
        Wed, 21 Sep 2022 02:11:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5CUB9Hh/6MaXySh1VRbTMoUrEPjkPKSHx38BhiNswfwTqi2zOjzaySKF/DMi+C1I0DN0LQCw==
X-Received: by 2002:a2e:a5c2:0:b0:261:d23a:2009 with SMTP id n2-20020a2ea5c2000000b00261d23a2009mr8077862ljp.303.1663751495837;
        Wed, 21 Sep 2022 02:11:35 -0700 (PDT)
Received: from greebo.redhat.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.googlemail.com with ESMTPSA id c11-20020a056512074b00b0049aa7a56715sm341480lfs.267.2022.09.21.02.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:11:35 -0700 (PDT)
From:   Alexander Larsson <alexl@redhat.com>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, Alexander Larsson <alexl@redhat.com>
Subject: [PATCH] filemap: Fix error propagation in do_read_cache_page()
Date:   Wed, 21 Sep 2022 11:10:10 +0200
Message-Id: <20220921091010.1309093-1-alexl@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When do_read_cache_folio() returns an error pointer the code
was dereferencing it rather than forwarding the error via
ERR_CAST().

Found during code review.

Fixes: 539a3322f208 ("filemap: Add read_cache_folio and read_mapping_folio")
Signed-off-by: Alexander Larsson <alexl@redhat.com>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 15800334147b..6bc55506f7a8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3560,7 +3560,7 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 
 	folio = do_read_cache_folio(mapping, index, filler, file, gfp);
 	if (IS_ERR(folio))
-		return &folio->page;
+		return ERR_CAST(folio);
 	return folio_file_page(folio, index);
 }
 
-- 
2.37.3

