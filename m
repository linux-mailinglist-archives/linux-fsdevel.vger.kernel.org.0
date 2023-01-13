Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B214669CAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 16:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjAMPpl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 10:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjAMPpR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:45:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B5F831A8
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 07:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673624107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+e8LXuZohWsWAKx1dvrBva8MxDrnRmzpeJF6iBcKD4=;
        b=FWz3ZL4U4EX3jGV8E7NBugkyeIK3pmGE0BSbTeUrhaVXwiRJuPZc5CdhC+zm/PTdlVWbrp
        QV2k8can/YyzhfVueRJBdpQ7/FR1GUPXCW6bDqQbPSvFhOUxJOkblablTKb12euSd78Du5
        7WNihYvaCnWJfaOCLHGDKk5zP80U2WU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-536-A7pzPxerOfuYjC5EdMCgyA-1; Fri, 13 Jan 2023 10:35:06 -0500
X-MC-Unique: A7pzPxerOfuYjC5EdMCgyA-1
Received: by mail-lf1-f71.google.com with SMTP id k1-20020a05651210c100b004cae66ea2bfso8426491lfg.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 07:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+e8LXuZohWsWAKx1dvrBva8MxDrnRmzpeJF6iBcKD4=;
        b=Jay+fl2oHTok3Td40gjIzV5tBkFSRnLN36vg5M3axtpB1vWeGIRANA2f0yxXf0cU4U
         eAmUCLkf6THsnPiNeNu0qDWFYB5emWigJw1VeHGSdMKXBikO+0raqkoTsSI7xBPFm4tH
         zl1ZTZkcoIeih4Gyx1Li1UI2Wdtw892uWryq1Mr/70E/Unv7dHRzfO3IbkaZEOfvBGVO
         v5e8+wvfLopL4oFlMsrXKhwsnGHA8e867RC9wA8APZrFfd9AqY+6nu2ldWJ743vf0bSJ
         b0lQLSaBf2bYcdZJQ3tFKL0gR4pibWAyKNjFTpf1HFfPzRduPKoR1n5Hu9LdRS7VIEHD
         jZvg==
X-Gm-Message-State: AFqh2kpO4gu0L7byT/PjSxZ2qfRQ4MW0scOdRr7MVnaKRDFDwzn1uDQ2
        JCxppsYVJI+FFH9HG0eMTIFeeGb4ZRFwEQECdbv07diun0mAPUWROZKRgllCVa2XLSslmCF2NwQ
        BbXFeXTJrm3ww47d5tqyhH7m1LW0s4ggDJIoEjwdrE/GI1h/uQtuDCMkyt597rfmP+lcMCdB7eA
        ==
X-Received: by 2002:a2e:9ccd:0:b0:27f:d941:82eb with SMTP id g13-20020a2e9ccd000000b0027fd94182ebmr14244564ljj.14.1673624105011;
        Fri, 13 Jan 2023 07:35:05 -0800 (PST)
X-Google-Smtp-Source: AMrXdXurzBcSbNHDnD97N/Jbb5UaRDPyfmiObjWJaHb4mIMzrQ90BcrNYqaObVK8QJ2Zuy+UbqB4VQ==
X-Received: by 2002:a2e:9ccd:0:b0:27f:d941:82eb with SMTP id g13-20020a2e9ccd000000b0027fd94182ebmr14244556ljj.14.1673624104810;
        Fri, 13 Jan 2023 07:35:04 -0800 (PST)
Received: from localhost.localdomain (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.googlemail.com with ESMTPSA id p20-20020a2e9a94000000b00289bb528b8dsm725473lji.49.2023.01.13.07.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 07:35:04 -0800 (PST)
From:   Alexander Larsson <alexl@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com,
        Alexander Larsson <alexl@redhat.com>
Subject: [PATCH v2 1/6] fsverity: Export fsverity_get_digest
Date:   Fri, 13 Jan 2023 16:33:54 +0100
Message-Id: <772d16b63f0eba74b8b09167f9e426fbb33ae546.1673623253.git.alexl@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673623253.git.alexl@redhat.com>
References: <cover.1673623253.git.alexl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Composefs needs to call this when built in module form, so
we need to export the symbol. This uses EXPORT_SYMBOL_GPL
like the other fsverity functions do.

Signed-off-by: Alexander Larsson <alexl@redhat.com>
---
 fs/verity/measure.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index 5c79ea1b2468..875d143e0c7e 100644
--- a/fs/verity/measure.c
+++ b/fs/verity/measure.c
@@ -85,3 +85,4 @@ int fsverity_get_digest(struct inode *inode,
 	*alg = hash_alg->algo_id;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(fsverity_get_digest);
-- 
2.39.0

