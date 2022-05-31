Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C478538E46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 12:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245464AbiEaKA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 06:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245419AbiEaKAT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 06:00:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9170282172;
        Tue, 31 May 2022 03:00:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n10so25580324ejk.5;
        Tue, 31 May 2022 03:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nne0qJckA/hMuSOr0O9+SBShBUR9gCrIksc3pugIfaw=;
        b=O04QHlDY6DBBsKrGQS2x+dxNPUvaLGwatBhA9Ypf6fUvXeQn4u2iZyLs+G4Gopi2gn
         lMPnA9p2Gz45t7ICtHVl6tg1eE8albLaPc/BmmQBPg3ZJxqBikRQy57f7Gd//Yisj1mq
         76jYCx/vPIdNy0UXH2etO7PDMMWd1OqeisBEgyFTI9zNlOQxBgL6irhDuYoGR91FeUzH
         EGqVWW4gL9+MALPxEAxgJkeLA1KAldYG/7fZPitSHzltfhEhG1K7I0p/7oGL1xaLWwU1
         IWCc36zCKbmVtfqPjeE1k5dNjDQMnB1bXMwDXVEhisX6bguza7GDvQPXMaO9uEGf9zR/
         OIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nne0qJckA/hMuSOr0O9+SBShBUR9gCrIksc3pugIfaw=;
        b=YKY4kc4K9h88N6xlb2ExBoxaxveasYRFz+2xrYsGxYV+Xgck5RLQL3HMbf02oopUlu
         9c4OsC862N9XSoU7+rcvEik7eGyTqELi6YsDG2UFC859tZ98evKBlQXD5qXyNLHN6+8X
         ZAUka2voptF66lrtZFpfD0yWS5rgT4ZOdy81KqJuSNS/46vIo4mXUjSYYRd3Kjeya//f
         tY29+u/8OTxPY1RYPRL+Br29ixVdZ9FZmqqKlZjR5TTCvDVEJpjbiotjTnDGMxZJHZ8I
         FkCvT3IeI4cOSJXllHvxedRguAtKARthjiw7mR82QdnpxWUt9o0+8ulDg8mMaY+gcuGr
         73Ig==
X-Gm-Message-State: AOAM531x4513CxI1N2RoS6rnHlA32wTcCHxZ9O6sdcWzTuuKwlmWdBQD
        MCs/5Mhdk8OYPNY8wcrh3IGMiOjNPMdcFA==
X-Google-Smtp-Source: ABdhPJxmWnOcxxDaVC0tQGNbj0CSrxLQR0xy8ghD6daeqEn1NVbnq/aFqlXxIqVHd6RNxE0nHnKb2Q==
X-Received: by 2002:a17:907:3f13:b0:6ff:18ad:6936 with SMTP id hq19-20020a1709073f1300b006ff18ad6936mr25394163ejc.158.1653991216188;
        Tue, 31 May 2022 03:00:16 -0700 (PDT)
Received: from able.fritz.box (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
        by smtp.gmail.com with ESMTPSA id r13-20020a056402018d00b0042617ba6389sm582062edv.19.2022.05.31.03.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:00:15 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     christian.koenig@amd.com, alexander.deucher@amd.com,
        daniel@ffwll.ch, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, hughd@google.com,
        andrey.grodzovsky@amd.com
Subject: [PATCH 04/13] dma-buf: provide oom badness for DMA-buf files
Date:   Tue, 31 May 2022 11:59:58 +0200
Message-Id: <20220531100007.174649-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531100007.174649-1-christian.koenig@amd.com>
References: <20220531100007.174649-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For now just return the size of the DMA-buf in pages as badness in the
OOM situation. That should probably be extended to be in control of the
exporter in the future.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-buf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index a2f9a1815e38..bdd4e8767cd3 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -388,6 +388,12 @@ static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
 	spin_unlock(&dmabuf->name_lock);
 }
 
+static long dma_buf_oom_badness(struct file *file)
+{
+	/* TODO: This should probably be controlled by a flag */
+	return i_size_read(file_inode(file)) >> PAGE_SHIFT;
+}
+
 static const struct file_operations dma_buf_fops = {
 	.release	= dma_buf_file_release,
 	.mmap		= dma_buf_mmap_internal,
@@ -396,6 +402,7 @@ static const struct file_operations dma_buf_fops = {
 	.unlocked_ioctl	= dma_buf_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.show_fdinfo	= dma_buf_show_fdinfo,
+	.oom_badness	= dma_buf_oom_badness,
 };
 
 /*
-- 
2.25.1

