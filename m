Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5777667B666
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 16:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbjAYP4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 10:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbjAYP4G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:56:06 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBD4113CE;
        Wed, 25 Jan 2023 07:56:04 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id u21so363019edv.3;
        Wed, 25 Jan 2023 07:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YwP2tm0CAOWY073suUhF0J/FRKYyYwUasCH1kI3YMoo=;
        b=b4Hz3cF3NnfPCbJomxECRfpWj1EP+pcb7wwtSC3FfiHAtis7Fa5wHww841JNA8SfCs
         KI5ydzziw1GyKjGph9B0R2bUY7w9eOIMCiTMtCSSwWRTFgBMIt4vtyya0bEhltICTtVT
         HXPXkm03w94K7eVlE/046M5lHlrZWMorer8C2PysP7EH16d7r+bD88618oouazgF7DyM
         lq1b9BR2r7hz8Vt/cNVQBdXlV+5k/zhxf3vFE1K3xOBT4iR+LgBpsWRdaDwt70ZzENJ8
         E17gitlojSEGk8tS2+lhF2KG1aa0M6ldVeBY+eRTMlnaMTv7ehMB8GLnbQ/ZCcBtGVkX
         VXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YwP2tm0CAOWY073suUhF0J/FRKYyYwUasCH1kI3YMoo=;
        b=zttSkI4LdfEFVPiVdkjO6vCwoLb91LO6Y92BsBwYQhR9a8BgBiccBdFQY6V2c4Ewyi
         1B1Re6vMRYDtFvkUd2PJRhLRcMWZ3XwASA1auypK/TAxbrMjWBFFhlq7Ck+TmX+Le9rs
         7R4qzhMsHycJo7iGiGmnmj/LLooIHaKST3XmlZoz1kvHrjopPwCYYFNZbhp0HQsmiyHC
         40AGWLmsmxkWdZFL2SgTGa4susBh+QnI3Pa/zusQKakG6ezTt5witsfVZixuNaO1Y6DO
         91J0AvpPHnF0rjy0Tnyd51OSJ/dTzM3UU5eU4QMb9+aIbaBymFwJsY2dSq9JUF7FOTFS
         YAKg==
X-Gm-Message-State: AFqh2krYGRCz0iBEkBtJUsaWBcU6F/lW15jjUZK6CQJagvdPrcppj9if
        AEILbNy0obDH7bzHTQCd10I=
X-Google-Smtp-Source: AMrXdXvSd6T12qkyw8dnzURz9Uzda3DdvoaTri+iWPGTm1uzwOsBwUROpY2drT0hNnuSn7Kr40hCKw==
X-Received: by 2002:a05:6402:25cb:b0:49d:6ebe:e9dc with SMTP id x11-20020a05640225cb00b0049d6ebee9dcmr43014072edb.25.1674662162788;
        Wed, 25 Jan 2023 07:56:02 -0800 (PST)
Received: from f.. (cst-prg-88-122.cust.vodafone.cz. [46.135.88.122])
        by smtp.gmail.com with ESMTPSA id d24-20020a056402517800b0049e249c0e56sm2539287ede.56.2023.01.25.07.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 07:56:02 -0800 (PST)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     serge@hallyn.com, torvalds@linux-foundation.org,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 1/2] capability: add cap_isidentical
Date:   Wed, 25 Jan 2023 16:55:56 +0100
Message-Id: <20230125155557.37816-1-mjguzik@gmail.com>
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
2.39.0

