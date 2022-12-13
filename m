Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B85264BB06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 18:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbiLMRas (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 12:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbiLMRah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:30:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920D323152
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670952588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P1G95qaTROMe5TeWa2MEdzfjCg/0RQKcVeEKeOMEgQQ=;
        b=cI2JJuD1orAfSLLixAInkYfRyZIU/EpyuWDkGFHz9TM06HokyMvAwrfig8Vcae75eBiBA4
        Vfyc+UIYwj1rYKrZeX2eqv6/UmTEeasbx/RmtzUzrH/Wa+sbqc+MJc4O3ynpix72Mcdol/
        QDEETqWSQKWfP7nULZplXsOJ+JZDrS0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-FJ7n8XV7MISQnbGx160IjQ-1; Tue, 13 Dec 2022 12:29:46 -0500
X-MC-Unique: FJ7n8XV7MISQnbGx160IjQ-1
Received: by mail-ed1-f71.google.com with SMTP id b13-20020a056402350d00b00464175c3f1eso7711714edd.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:29:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1G95qaTROMe5TeWa2MEdzfjCg/0RQKcVeEKeOMEgQQ=;
        b=dLelhNE0msOD/zMQ2TrQTiMyHOxlUNjjQmFXNRzgiJT11iLusT8PRnCiXaC/XdGrp9
         5tTKjtgM2tcwTdwb5as8fCqc4BjNCRnf9yV1ubfVclA6JqVS6XM0OFB+4mNBoe2wnF87
         Fm5uzf2T2HciXYxcPthyS+ziRELmR9Rku5Dxdh+XeE8njbF/fadpGFs1XDDbs/NKcuHS
         TxMQ8OXhhOEacJFEjPt4ebuI3UeSAKeYD2uxC8LKghX6I0G5GE71kn2pyLPNAexEuKC3
         7ZGQfOd/XooINnRgbfHJ5p7ufI8LgXoUm3kuOWDjryj0uJ4ic112zR6enpXVxepirlX/
         3z+Q==
X-Gm-Message-State: ANoB5pnuGE6jbGvXHHInHJ2LhlWCC/QGCAhnmyDmU/MSN16gGHl1g1E5
        SSZbyMeS68YdRiKQtr4XxgOjhEdOM7VRQWcFz0fzMUNAYSW59rWBws/kovObqIERXAf021XKXuO
        hjjLyS/9CO+7J0aV/ZIpsePva
X-Received: by 2002:a05:6402:65a:b0:46c:2034:f481 with SMTP id u26-20020a056402065a00b0046c2034f481mr21253796edx.8.1670952585544;
        Tue, 13 Dec 2022 09:29:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf49GadwBBNQqxZylW80lnXLXsFDzu+9jd/T//0zrTD7s7L3ad+tNrjoVsQREKpKn+QzrVVffg==
X-Received: by 2002:a05:6402:65a:b0:46c:2034:f481 with SMTP id u26-20020a056402065a00b0046c2034f481mr21253788edx.8.1670952585386;
        Tue, 13 Dec 2022 09:29:45 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id ec14-20020a0564020d4e00b0047025bf942bsm1204187edb.16.2022.12.13.09.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:29:44 -0800 (PST)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [RFC PATCH 07/11] xfs: disable direct read path for fs-verity sealed files
Date:   Tue, 13 Dec 2022 18:29:31 +0100
Message-Id: <20221213172935.680971-8-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221213172935.680971-1-aalbersh@redhat.com>
References: <20221213172935.680971-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The direct path is not supported on verity files. Attempts to use direct
I/O path on such files should fall back to buffered I/O path.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_file.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 5eadd9a37c50e..fb4181e38a19d 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -245,7 +245,8 @@ xfs_file_dax_read(
 	struct kiocb		*iocb,
 	struct iov_iter		*to)
 {
-	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
+	struct inode		*inode = iocb->ki_filp->f_mapping->host;
+	struct xfs_inode	*ip = XFS_I(inode);
 	ssize_t			ret = 0;
 
 	trace_xfs_file_dax_read(iocb, to);
@@ -298,10 +299,17 @@ xfs_file_read_iter(
 
 	if (IS_DAX(inode))
 		ret = xfs_file_dax_read(iocb, to);
-	else if (iocb->ki_flags & IOCB_DIRECT)
+	else if (iocb->ki_flags & IOCB_DIRECT && !fsverity_active(inode))
 		ret = xfs_file_dio_read(iocb, to);
-	else
+	else {
+		/*
+		 * In case fs-verity is enabled, we also fallback to the
+		 * buffered read from the direct read path. Therefore,
+		 * IOCB_DIRECT is set and need to be cleared
+		 */
+		iocb->ki_flags &= ~IOCB_DIRECT;
 		ret = xfs_file_buffered_read(iocb, to);
+	}
 
 	if (ret > 0)
 		XFS_STATS_ADD(mp, xs_read_bytes, ret);
-- 
2.31.1

