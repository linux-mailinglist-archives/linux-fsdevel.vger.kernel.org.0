Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3E827498
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 04:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfEWCvc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 22:51:32 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:34814 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729969AbfEWCvc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 22:51:32 -0400
Received: by mail-pf1-f176.google.com with SMTP id n19so2390253pfa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 19:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fg/iHmx0B1Mv4Llb80mXau43v90pWA5HUyUPc2gShgg=;
        b=N7gavrhWEUw0x/OIpr76d/A/QEMOAExQ8CGX8SNEHzd2JYpT3BBsEN530r3g2yElpk
         wugcmhEbfKVTlhkWKEjCBVr3lU+rUfVMzJZSFvlX2W+k+T70pFHPUHfiK9lhtq5qYdh6
         SvnzqrkmEVoHcpfXIlsCgqzZds2/iFokvqmN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fg/iHmx0B1Mv4Llb80mXau43v90pWA5HUyUPc2gShgg=;
        b=aW/EXWUbagh6FtTHORtoDwWzCE5dqHZCCGGcvzaYr7i/2gbm1wrXJBsLh5RiO71giO
         jbw8iNHPNPv6c6dpWfSD93z1wQC31ZALTNSg0h5QQCw1Nq5WV3GHnV0uyml+QPb9aENJ
         yrVvQMdjyQKde7/2c/9C0duaL2bV9KRrwMzZ8XKXUX9QMXA2EXuHB/Dqdt8CF5fyz5wB
         RiRVbWC9/xFqxh9F3jNFoGHx0bZUhTq4fWFxUEr36dKCQHTyU4bTT3NW8vzgtPsdAYks
         vJW7ZLCcVzXSc8Ri0bSroInj9ionB3R8UVI+02z5LWaE86Yfsqa5E20286pMWIKKV7CL
         RdCw==
X-Gm-Message-State: APjAAAV/H2NrNwxAuCoI3O1zfoLjbm/1oOBz0XJ8hNSrrRGY4ucjqEjt
        r2p+SAjiVIoUI+RjZMfhCXpmZg==
X-Google-Smtp-Source: APXvYqyXG074m3md96HTSMqZH6wIifHHqDJmGnwXeGgSJ4ZhoMxIhAnPrKUyQBs+M9DIGdtK5+64qQ==
X-Received: by 2002:a62:14d6:: with SMTP id 205mr100298494pfu.4.1558579891739;
        Wed, 22 May 2019 19:51:31 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id q19sm42812174pff.96.2019.05.22.19.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 19:51:31 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 3/3] soc: qcom: mdt_loader: add offset to request_firmware_into_buf
Date:   Wed, 22 May 2019 19:51:13 -0700
Message-Id: <20190523025113.4605-4-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523025113.4605-1-scott.branden@broadcom.com>
References: <20190523025113.4605-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adjust request_firmware_into_buf API to allow for portions
of firmware file to be read into a buffer.  mdt_loader still
retricts request fo whole file read into buffer.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/soc/qcom/mdt_loader.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 1c488024c698..ad20d159699c 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -172,8 +172,11 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 
 		if (phdr->p_filesz) {
 			sprintf(fw_name + fw_name_len - 3, "b%02d", i);
-			ret = request_firmware_into_buf(&seg_fw, fw_name, dev,
-							ptr, phdr->p_filesz);
+			ret = request_firmware_into_buf
+						(&seg_fw, fw_name, dev,
+						 ptr, phdr->p_filesz,
+						 0,
+						 KERNEL_PREAD_FLAG_WHOLE);
 			if (ret) {
 				dev_err(dev, "failed to load %s\n", fw_name);
 				break;
-- 
2.17.1

