Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DCA1C9FA0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 02:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgEHA2R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 20:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727123AbgEHA2P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 20:28:15 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EFBC05BD0C
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 17:28:15 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a5so3428607pjh.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 17:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d89QrDod8n3DS0mHAWOT8Nhxmdw/BYJeM/jPsxOJaUA=;
        b=BVCEG8eDlA86Kc3DaKoVApgyVNNVTpgY8y4vx9gcEnguJ1dEe7z5lgDTbTzC/qjCq2
         x+gJ7f7GxT27U+R8QKnfUV/JlbVxgcsBnP+mH8K3KG6LYrmVtMpih45iOxwrNuMXbsND
         i9pBLGXqA5iNRT7gde+iRZ/9z6Um+IIGKGmZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d89QrDod8n3DS0mHAWOT8Nhxmdw/BYJeM/jPsxOJaUA=;
        b=ZnMjc9ETg17RPP172CmdEEulGKRVzu4vdPR8VXZXiRoOzTgjulkciFk0svRkPmM3YJ
         OY/MGT0Fjc8N4GYuR6iwajAyAi9jfegXMl9sRYeaXcWj9OIK5gWqx1bVai2hs6DSIPkw
         6T+qXiWPvOzPlSjiIVaJR1F41o9nwNyoyaIKhowoRKLyBRJsVpANw0haPRDzQnu0UDMY
         g+RieRd53MTznja+10rTSihP8WpYOitJyn3TEayTD7DhjZdTzpWaRXNqmCshDcJgacPZ
         j5cFkH/Jp6dzrNI96gMPtDt8WCocaQ9txj+hUAOfp3wN5+5lhJmQ4jzGMzhtTavbwsWB
         0O4Q==
X-Gm-Message-State: AGi0PuZRZZA+VRIzLcZk1OVwOtmoWc43MGXDD6iMS835A14I5hRCKMp6
        jv1Ox8/7CvMbgOP8+UX54Ry21A==
X-Google-Smtp-Source: APiQypL9yg+UTfakfAY/PGrCH8wWW3n8ccPxXXOpi3O6KW2uN1JVvwO4pJpQK+Wqdfoa82/pMFJAYQ==
X-Received: by 2002:a17:902:361:: with SMTP id 88mr15726849pld.279.1588897694996;
        Thu, 07 May 2020 17:28:14 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id gz14sm882677pjb.42.2020.05.07.17.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 17:28:14 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
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
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v5 7/7] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Thu,  7 May 2020 17:27:39 -0700
Message-Id: <20200508002739.19360-8-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508002739.19360-1-scott.branden@broadcom.com>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
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
index 88bf36ab2b22..63eec54250f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3612,6 +3612,13 @@ L:	netdev@vger.kernel.org
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

