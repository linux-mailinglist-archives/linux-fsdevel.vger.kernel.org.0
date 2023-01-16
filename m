Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680B966D0DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 22:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjAPVVS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 16:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjAPVVQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 16:21:16 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDE623858;
        Mon, 16 Jan 2023 13:21:15 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id v6so27887374ejg.6;
        Mon, 16 Jan 2023 13:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZUr775SZEUdEUVQ50LyInwYmbWVTce14ME9QhXkqM8=;
        b=EXi/YH/G3S3FVDSqo2MMGTcu9D/1ESejD72sgxsRBtmzrBOrZU5zlWQmckWD2bY+jr
         FrCHz8y6RUp2GyS49S8LKfpMqLQKjSx25pz3bqFWCrefLFzuOWr5pbDibIyJMqLSgXFq
         34SmGJHjFpHi4AA5yMRIyqIcEqTPOm2vHqx/oKv3QjWd73L22NArkdUr5YDSB7mkThtq
         ISyULCs8LUoeFh24UHcBgZz4D4nAdCK11Olhk68L95Qe6pYyd6QJU95MBrVSReULPPiW
         44Y+HmMWRYet6UVRWy2vlhlGuJkfxZ3YTS4tl+zzjrqHmTekATEzm6QOXDWY+TfVa4V/
         BW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ZUr775SZEUdEUVQ50LyInwYmbWVTce14ME9QhXkqM8=;
        b=RO7NF9eWpoxbELFNLxhcK05nbkLm6dzf7Bc0KdLRDgOScT6KRMl9fH+DSYvnP4xcb4
         iG58ps4VEcZE4/e2QZILF0k2oBJml3I/60wMaq0E/Q0XKgTBMHuw05rh0/1+cY0IIL/3
         Fass/r+7qmF/WblIi2jHlhwmsqzK734b6QRx7mklddbxMdJG7Cek5ktMz838Q//jOQ4l
         bw8hm43Slul1glyK+PrTA8qTfdnv/x4EILFOh7dByF3gXwgy+6jlNalNtcdTotqoYAEq
         ico0SAR9qtn53dryLTjrC0EP4zBcEWwf2Hnbrb5rkJUBW3+7zbzi0vOV14ypM0J3XyQ5
         7r8g==
X-Gm-Message-State: AFqh2krSzOl9rWnGTdEoMxM3xXbzbXadZiexGlHstBYpBy6gMfaXYdyX
        i00xuWrLRNJooIGnmW5FFVE=
X-Google-Smtp-Source: AMrXdXtRA6viwDNQpmAscLu1ZrTmv8E2nfZRNDx6J5yodEg7Yk/dH6aw081jjftiYPC2/kdo95W07w==
X-Received: by 2002:a17:907:2bdf:b0:86e:38ae:8713 with SMTP id gv31-20020a1709072bdf00b0086e38ae8713mr431733ejc.51.1673904074355;
        Mon, 16 Jan 2023 13:21:14 -0800 (PST)
Received: from f.. (cst-prg-72-175.cust.vodafone.cz. [46.135.72.175])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090676d200b00857c2c29553sm7961721ejn.197.2023.01.16.13.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 13:21:13 -0800 (PST)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     serge@hallyn.com, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 1/2] capability: add cap_isidentical
Date:   Mon, 16 Jan 2023 22:21:04 +0100
Message-Id: <20230116212105.1840362-1-mjguzik@gmail.com>
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
Reviewed-by: Serge Hallyn <serge@hallyn.com>
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

