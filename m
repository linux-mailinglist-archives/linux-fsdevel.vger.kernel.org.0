Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA90D216237
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 01:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgGFXYb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 19:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGFXY1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:24:27 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279DFC08C5E1
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2020 16:24:27 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id lx13so25969854ejb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2020 16:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BrHH5kRclULDOdDmCKSphD9MpdFvNVhZ0LXrhxcdSB0=;
        b=IVIJRThow6tn/N97r3n4/BKaVZn+4H66M0gR5/D6e+EgiJ1PO9sGNPiyiFSy8BAjS2
         y4dZn/j6lrxrQE9+I7JGTdLZiHyNHJ7NDmuiQz+MZL/2NCp92CVE/NNJqaCgs6cI+Ru6
         W3uRJXG3yBCv1PvOFcO+ffi9urcK5rLH1lVhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BrHH5kRclULDOdDmCKSphD9MpdFvNVhZ0LXrhxcdSB0=;
        b=e6Mq6Sk1N7Qws2rlnxoXRNPgeCbgLPibusOfEbWn2H4PZKQcO4oaPH7kd6J6/JPSp3
         AlyGOjJVhjsKLsGVtyAN+mhSmhReqeQ6OWqydCQsaQjZiHwewThHquCSsVTsWgPmYWHY
         ZPkrTQHLmOnMvcCUKedWPUou95zIGEI8hYG0cD1y1e5NkAOPmv6ci8qM4k19fMcZunG7
         dbLlJ1lTvPjNCuQUz90+35DhbHMKfCVwYUeaia7QInukJBl2XcazUZUgSocfLTBgfEp6
         20jA+fZGUCRGRo+PwkakFJhsdN7oiSc3WKjhVBB8Jiu6d4eyLHUI+hAswDb5Y5niQ1dS
         V9jg==
X-Gm-Message-State: AOAM532P8uXaxaIAFqEP7u7oazmr+uTGLpiox04lEsOPH4WjLkzT6yhb
        Agq1NQRkNp0TUdv789ZUjaJzTw==
X-Google-Smtp-Source: ABdhPJzWcz+Mj6jHkPd2AzL08/6QjZY1NbAg2dSQ7/J8yJURAGa/99taBr0TBd0+ycIhCdnu4jxSyA==
X-Received: by 2002:a17:906:9716:: with SMTP id k22mr26338159ejx.200.1594077865774;
        Mon, 06 Jul 2020 16:24:25 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id i2sm4002567ejp.114.2020.07.06.16.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 16:24:25 -0700 (PDT)
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
Subject: [PATCH v10 8/9] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Mon,  6 Jul 2020 16:23:08 -0700
Message-Id: <20200706232309.12010-9-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706232309.12010-1-scott.branden@broadcom.com>
References: <20200706232309.12010-1-scott.branden@broadcom.com>
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
index fb5fa302d05b..996e06f78f27 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3662,6 +3662,13 @@ L:	netdev@vger.kernel.org
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

