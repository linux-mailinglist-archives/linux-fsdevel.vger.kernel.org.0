Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1478603243
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 20:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJRSWk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 14:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiJRSWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:22:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3093A537E3;
        Tue, 18 Oct 2022 11:22:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id 13so34278987ejn.3;
        Tue, 18 Oct 2022 11:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUBbOEFW53KqYnQJv0OgmvKNjQw4g+0MWXRaawv7+iQ=;
        b=nRpoRKZTK3LZz+cVRmefY9fdWuEY96VtZbCp3J9uXVdMtZk4tPgGaHL3Of5fthLpyV
         QldgMdRzgnzPaOL5BW8krhREVCVvaEbLWC13sQ+VLWMTf9H5+fSnpi6AFrbthq64NEPp
         Pvp/1xFy00hJPmKlo9+1dB1h2SNrBuUTom05zoevqp66PsvPls85cbCYySAmN06bTukZ
         AYpOfEjQY4Gq1g91O82SeAY5CbpTX6L44OrNl5VQ4q3SNt4INljse5V59/pAtB0gVSQc
         Im+OMo4CPH1y6Si6m8OsGgyqtaFMnZe2IUEIAi27IUf1AxAwB/Gzhcp2yvq9Lfuw3i5k
         GQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUBbOEFW53KqYnQJv0OgmvKNjQw4g+0MWXRaawv7+iQ=;
        b=yfky876OeyduWGXAaqMxXQzAR5WdEwLe/6vic/w1o6AVn4dOpCPh7aDrdkLE8iHC9j
         dqR5ogj42kEJM/GTNjCVibaxoLB0lBqboGDzAv5SYyPIM4uhRoogyVaBr6CaF7SzOq/k
         bXQMT7hpD5nqxOJeqokIDicfie22Gv/LKbvHaRDkZjCHnZTBc0DsdxMPMu4ZqT/MrUxS
         nQ1uXwKOM9+A5V2qYu5qA/HsWFiGWIAlNDgKCV/aQ/W01jX4cvbDud1H5ULVnLz8tacE
         cboGhjcVF+KGbpofCPohVTXN8aznju3d3eVbn2JQtbHLFo2RNXwgzhJ80yOElAsNaH0e
         oSKA==
X-Gm-Message-State: ACrzQf1gk2ub0FeLUGsYMBEKjvpuAlVbo39ehEFXD3CyzSDZoxpfUabX
        rt4zI8ONvT24Ny36mdurkx7p1S1sD6k=
X-Google-Smtp-Source: AMsMyM5GRSw2mW8kjwpc/pAo80lfYu2N8YUdTSW7HbqIHHuLGpjyZdXq7Xoal154wZPPhyO4ULO+zw==
X-Received: by 2002:a17:906:7055:b0:78b:9148:6b41 with SMTP id r21-20020a170906705500b0078b91486b41mr3446006ejj.629.1666117351774;
        Tue, 18 Oct 2022 11:22:31 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id i18-20020a0564020f1200b00458a03203b1sm9358395eda.31.2022.10.18.11.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:22:31 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v10 03/11] landlock: Document init_layer_masks() helper
Date:   Tue, 18 Oct 2022 20:22:08 +0200
Message-Id: <20221018182216.301684-4-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018182216.301684-1-gnoack3000@gmail.com>
References: <20221018182216.301684-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add kernel-doc to the init_layer_masks() function.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/fs.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 277868e3c6ce..87fde50eb550 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -297,6 +297,19 @@ get_handled_accesses(const struct landlock_ruleset *const domain)
 	return access_dom & LANDLOCK_MASK_ACCESS_FS;
 }
 
+/**
+ * init_layer_masks - Initialize layer masks from an access request
+ *
+ * Populates @layer_masks such that for each access right in @access_request,
+ * the bits for all the layers are set where this access right is handled.
+ *
+ * @domain: The domain that defines the current restrictions.
+ * @access_request: The requested access rights to check.
+ * @layer_masks: The layer masks to populate.
+ *
+ * Returns: An access mask where each access right bit is set which is handled
+ * in any of the active layers in @domain.
+ */
 static inline access_mask_t
 init_layer_masks(const struct landlock_ruleset *const domain,
 		 const access_mask_t access_request,
-- 
2.38.0

