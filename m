Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0944F777650
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 12:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbjHJK4C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 06:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjHJK4B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:56:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777FD213F
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 03:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691664908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b06CcaAE7+jk62SrlDLBDiqbuy9hcBibaIoFiOaaong=;
        b=gmb0pedJSFA/ncnEoJsJRHo/ueqWFKn87XulAFzPt8985/+up+EjPJGgI+rEiIp7qi7rPW
        g3G4H/v0Gp3T5C70MLDmadhKTbiqO8OMDLpm8Mp9wxCFZ45PNCfJgUEXGDR910lesRJIGk
        27ZXcRKFCpz81aKKMwYDvH2xh4e6yYo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-Zt_zfJSMOkmbitX68FJwCg-1; Thu, 10 Aug 2023 06:55:06 -0400
X-MC-Unique: Zt_zfJSMOkmbitX68FJwCg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fe356c71d6so784890e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 03:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691664904; x=1692269704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b06CcaAE7+jk62SrlDLBDiqbuy9hcBibaIoFiOaaong=;
        b=keaFNb2S3TG2RTehI5aC+OOa/XVxr1n7H9lN6eZxQ86dRjVM4ueBJ1mf8DuXWwy5Vx
         7C+x8fY0etX6c2+quL0UPPnDzz3I3NYtDZ5Umh3p6rQ5nwhG38MijYYwu7+E3ETK6CPa
         E7nHoe1oXmlOwJXj/e7xdGzfPU/49qy0u6bGUDBxdTsv6b9KFXfdaAcU4m3JXd4+nNNI
         vnF00sHN2aFFjP7z1Tamcm3U6TF5mpI564z2VQSmbODQWFVufeYK3hLimWYf/LJY7EhQ
         xgvm4/14Hu7XrNaAchBv3eLDkIIzgMaZjF0699czTXdltOfm7wJ0NJUvlkT/+kCI5AmS
         0u2w==
X-Gm-Message-State: AOJu0YxsjGOYYXXKgZ16TgA+mvCEoYkA4gnXZDZDLG2DlKoVK0C/r/sO
        /XbD8kCmuCeMjzEAsZobyppd9HitxvyJccGsbVnp0B2v4tkGBP4ui/6Y9mq7eVsJXAkVSIudTRZ
        HzJERcAMOvPnm8cwLLSz7OH2HyhhG9Tb7g6OtIMWnhk2LY1iRAJKUMfPhBMMDmCm9BN7XV0z8xk
        2wlxT2NxyYeA==
X-Received: by 2002:a19:6d0d:0:b0:4fd:da65:d10 with SMTP id i13-20020a196d0d000000b004fdda650d10mr1354581lfc.36.1691664904399;
        Thu, 10 Aug 2023 03:55:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9k5W3ZufNymLkIVjFDgmLjut8wSSuK/UGQi9p3wr0US7W6Bl1KolUaZD3oi9ppigHF0rLFQ==
X-Received: by 2002:a19:6d0d:0:b0:4fd:da65:d10 with SMTP id i13-20020a196d0d000000b004fdda650d10mr1354561lfc.36.1691664903952;
        Thu, 10 Aug 2023 03:55:03 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-246-142.pool.digikabel.hu. [193.226.246.142])
        by smtp.gmail.com with ESMTPSA id v20-20020aa7cd54000000b005231f324a0bsm643732edw.28.2023.08.10.03.55.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:55:03 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5] fuse: handle empty request_mask in statx
Date:   Thu, 10 Aug 2023 12:54:57 +0200
Message-Id: <20230810105501.1418427-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230810105501.1418427-1-mszeredi@redhat.com>
References: <20230810105501.1418427-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If no attribute is requested, then don't send request to userspace.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index f67bef9d83c4..d38ab93e2007 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1209,7 +1209,12 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 	u32 inval_mask = READ_ONCE(fi->inval_mask);
 	u32 cache_mask = fuse_get_cache_mask(inode);
 
-	if (flags & AT_STATX_FORCE_SYNC)
+	/* FUSE only supports basic stats */
+	request_mask &= STATX_BASIC_STATS;
+
+	if (!request_mask)
+		sync = false;
+	else if (flags & AT_STATX_FORCE_SYNC)
 		sync = true;
 	else if (flags & AT_STATX_DONT_SYNC)
 		sync = false;
-- 
2.40.1

