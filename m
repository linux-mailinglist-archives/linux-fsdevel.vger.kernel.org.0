Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402371F0530
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 07:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgFFFHS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 01:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbgFFFHR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 01:07:17 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093D1C08C5C4
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2020 22:07:17 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d66so5933156pfd.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2020 22:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nPZxvHwBEufxYBdudZlyF4qOYy0qjWWsAs0E7hFIitY=;
        b=LKRXcXAxk/S4d1ojJso185sZY4EDd7oB/TMjk4qHxfa7tmHK7uGzpexJtAQ0bVeTe4
         gxBGgLgZRHQuGtimtkN1dVO21gb6VLxc7FipvFzOng1pcG9UzU9p6XcUDSBuN+VOdGTa
         UMazTNd+n15aosaq7Nu8SUmiRSlNUnFAGE6lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nPZxvHwBEufxYBdudZlyF4qOYy0qjWWsAs0E7hFIitY=;
        b=nV0X2kFJoNlT2/lgOjUsdkkOzPaIQOFO/Ew3v4J0bySeht+aQcJIjB9yZtwyriPJxN
         GsudMy2HRG9nFGfyJ6pQ04XEIul+QJIbThi58mT83HuZxTUbenP/a37MJJM8t6Q5nYMp
         ug2aumtGGAbmxmCK4yCvVGkFxsJugiQnI60X/5Nc2Bs+ba6mE1YV2v4KozgFg+viiNB2
         hkoeoUwrMsmb8EFFYrAiX8C35EGaxLIjg+F3kgcEs2yROlwezd/UtKwdj0kZZAo2FEOs
         UIL0h/t6dEXUDE9y1YThQnScSSDcwD+y3H60tyD5mkiTSwH0AWI+WAut+ZgK6P7Z7lRe
         EBCw==
X-Gm-Message-State: AOAM533yKqUj4IN3zyAehjbQgrw653vEDZi/Hkx5YIRsyafmUtWa9h5q
        CvTpPeOe0mK15pyKglIW3Vdx9A==
X-Google-Smtp-Source: ABdhPJxeVT9a/KR76jybKQryE79B0JYUNZw1/TXZXF/G9QFvxCuTwEjn/4pcIn1mqf1SwS4HR8Nf4g==
X-Received: by 2002:a63:c44b:: with SMTP id m11mr11796192pgg.404.1591420036309;
        Fri, 05 Jun 2020 22:07:16 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v8sm1057636pfn.217.2020.06.05.22.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 22:07:15 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v7 7/8] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Fri,  5 Jun 2020 22:04:57 -0700
Message-Id: <20200606050458.17281-8-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200606050458.17281-1-scott.branden@broadcom.com>
References: <20200606050458.17281-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add maintainer entry for new Broadcom VK Driver

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 411cd97bb485..ced084c526df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3656,6 +3656,13 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/tg3.*
 
+BROADCOM VK DRIVER
+M:	Scott Branden <scott.branden@broadcom.com>
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Supported
+F:	drivers/misc/bcm-vk/
+F:	include/uapi/linux/misc/bcm_vk.h
+
 BROCADE BFA FC SCSI DRIVER
 M:	Anil Gurumurthy <anil.gurumurthy@qlogic.com>
 M:	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
-- 
2.17.1

