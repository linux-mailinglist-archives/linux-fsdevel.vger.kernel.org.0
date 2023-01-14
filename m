Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A74C66AD30
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 19:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjANSCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Jan 2023 13:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjANSCo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Jan 2023 13:02:44 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89088BBA3;
        Sat, 14 Jan 2023 10:02:43 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v10so34232897edi.8;
        Sat, 14 Jan 2023 10:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t6N7J2F7vZrkh1mREUzr3Uhb6M7WIvjgHrSlVsDZzcw=;
        b=ADIUZhCDGwtjc8id6hSSs006LIW01fTkLA7qDjjWvNb/XOV8bzMbSndCye++Bulk/E
         M4XvfL2Xl23aCvItGnL/eRYVDX0E1L93zYjB1XMlcBMhwuKjb91SxOPMrxoGs0EbBl8O
         FL3c1tBUHcdZpmNTFESAWkUgAA096Q9uwMkckxhYiDuQrUmbSSXhGOAtNvGf06fTALIA
         GJMHHAcitXaux2mWlnrqcdEU9/Dq7yOdZ42S4XzJd/zoVx79kOw84T63GIXAWU7NJ1Q9
         v6m0S06ymhRKmMU1MTXgrWHKVacHsBhc5kw/YbFIdU7eYEQJQe+mcdLMwhMcWOTj3ooa
         fpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6N7J2F7vZrkh1mREUzr3Uhb6M7WIvjgHrSlVsDZzcw=;
        b=WXiJKmtm47MFbXtklcGjoqc39zWMwUXHoPDLdLRo3787WzxhxMuUbvfltlgv8FheN6
         z+aL0kAszChvx9JJUm/Mr7UUgPPH1HBLp61miL4Ygq4qrCfamhdqSAmH/phhYmr489/C
         3r8khWvtKQ3Gv20T9jZ52Dt4H3560QQ/lPKKiSKVQnDRKFqGfJ2rik17X4aQDJzRJdGH
         n93yAdtblEu0yZY/adz4QBEAbzU3h769vHMK5KopkDj5eektOHfpoiGQ9iAkXvb6QZpz
         suqdZ9ckHA3oBauXhI3kHBpySWr4kXqUSUor8zj573OjLxXTVLtqF5L5yl4oCa3jzh5P
         SN0A==
X-Gm-Message-State: AFqh2kpjY+8t68D8VvB/JzOCdyAZ6jkpgUeeu9C5Sr5DD81tBRwlgCEW
        22nOctwCPVBj0j5TPxHA1U5qrTYcI+YSwg==
X-Google-Smtp-Source: AMrXdXt4I50W/aoCUj/+8khUmGwAPDrxlvImYlI3YLhe5z/06Iv/bo4RMdGoLE+iWHrsHTFenLGnXg==
X-Received: by 2002:a05:6402:b55:b0:49d:d8ec:cbd3 with SMTP id bx21-20020a0564020b5500b0049dd8eccbd3mr2165859edb.16.1673719362094;
        Sat, 14 Jan 2023 10:02:42 -0800 (PST)
Received: from f.. (cst-prg-72-175.cust.vodafone.cz. [46.135.72.175])
        by smtp.gmail.com with ESMTPSA id eg49-20020a05640228b100b00488117821ffsm9623220edb.31.2023.01.14.10.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 10:02:41 -0800 (PST)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     serge@hallyn.com, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/2] capability: add cap_isidentical
Date:   Sat, 14 Jan 2023 19:02:23 +0100
Message-Id: <20230114180224.1777699-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/capability.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 65efb74c3585..736a973c677a 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -156,6 +156,16 @@ static inline bool cap_isclear(const kernel_cap_t a)
 	return true;
 }
 
+static inline bool cap_isidentical(const kernel_cap_t a, const kernel_cap_t b)
+{
+	unsigned __capi;
+	CAP_FOR_EACH_U32(__capi) {
+		if (a.cap[__capi] != b.cap[__capi])
+			return false;
+	}
+	return true;
+}
+
 /*
  * Check if "a" is a subset of "set".
  * return true if ALL of the capabilities in "a" are also in "set"
-- 
2.34.1

