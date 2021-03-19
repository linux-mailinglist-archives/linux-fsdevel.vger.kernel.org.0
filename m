Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DEE342083
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 16:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhCSPHF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 11:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhCSPGn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:06:43 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A878C06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 08:06:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k8so9437831wrc.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O1cliPNt4IOuiJ9NAYStWdoDOAvSKQBjj0GaKYwsRdg=;
        b=C7B11toD2TiZrKj3lUFGE6nIMpJt59OarnlrWaEPVb/dlUNaAI44URh9mHbRj5Mtsm
         CFbdzOKA5NliU2BRgP9V7b/Wyj87h0LMQWZnjq8/oAXMyKDgeTLzx22oETziyJkwdGCt
         vRuvYYbZVZ2iMw4pujpbyzsO+WQ9m/W3s22lEB+Jd4INJtM5OS0I0rewOFW1klije2Gk
         hD/uF+swP6rbRbbeGXdzyph++nVVpjVtxFfg0RR/oS69IHjcKpGVwTe6rqzNbeFNXy9q
         PA2mm79+6wP4DjDzPS13Alx+sWEqLzoljLVWHUqjih7ACGLUcKCuwkxNXt0X076iFnx3
         MeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O1cliPNt4IOuiJ9NAYStWdoDOAvSKQBjj0GaKYwsRdg=;
        b=XalNe4pwwyA9DJJ1lR8vdkoLybMCaIkTjeF/HQrOx9dTLcIE0jP5i2JQD8JVPxiKv2
         GQGC1z6d5SSFTXg/0VqrYC6lM/pZ6ZCc+PfaVO0pZz/sCWiBGRFBY17289nV8PxG3ooE
         UIZ66O7fhE9jRsPcJHE/65oZFaGhn+Xxr6dVWp2V+eZdC6y92TyvFdoT61mScK2PltzR
         TSLBnQzOvCdsEUzQ1SclBd9rO7mG8gJS+cNADo7dloosgno7wc8x9AmEQV1U5wcpCHIs
         YBk7ueS1jzL8cAqk3LVmkdgaMq1K/x6jtFfTG/NTDQvn78Hl3vwgcCvLBrBPRPIiMxMN
         +MAw==
X-Gm-Message-State: AOAM531Akp6Ge2FeSCgSp5zvNiErxRmRMupjqBdVD4rKc5bDWoyvqokj
        jNTK5PTd3QLqpCw+ztwjGzzuLQ==
X-Google-Smtp-Source: ABdhPJylifZpjlgybLtsRkl9QRce48/5Mik44BkROT+y6TCzi+J69u+qGfIUwuE5ieQk3X0q5NEtUA==
X-Received: by 2002:a5d:4686:: with SMTP id u6mr5040256wrq.60.1616166401927;
        Fri, 19 Mar 2021 08:06:41 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:d49c:45f3:9d86:b2e9])
        by smtp.gmail.com with ESMTPSA id w6sm8381391wrl.49.2021.03.19.08.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 08:06:41 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     Arnd Bergmann <arnd@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc:     kernel-team@android.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/fuse: Fix matching of FUSE_DEV_IOC_CLONE command
Date:   Fri, 19 Mar 2021 15:05:14 +0000
Message-Id: <20210319150514.1315985-1-balsini@android.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With commit f8425c939663 ("fuse: 32-bit user space ioctl compat for fuse
device") the matching constraints for the FUSE_DEV_IOC_CLONE ioctl
command are relaxed, limited to the testing of command type and number.
As Arnd noticed, this is wrong as it wouldn't ensure the correctness of
the data size or direction for the received FUSE device ioctl.

Fix by bringing back the comparison of the ioctl received by the FUSE
device to the originally generated FUSE_DEV_IOC_CLONE.

Fixes: f8425c939663 ("fuse: 32-bit user space ioctl compat for fuse device")
Reported-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/fuse/dev.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index c0fee830a34e..a5ceccc5ef00 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2233,11 +2233,8 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	int oldfd;
 	struct fuse_dev *fud = NULL;
 
-	if (_IOC_TYPE(cmd) != FUSE_DEV_IOC_MAGIC)
-		return -ENOTTY;
-
-	switch (_IOC_NR(cmd)) {
-	case _IOC_NR(FUSE_DEV_IOC_CLONE):
+	switch (cmd) {
+	case FUSE_DEV_IOC_CLONE:
 		res = -EFAULT;
 		if (!get_user(oldfd, (__u32 __user *)arg)) {
 			struct file *old = fget(oldfd);
-- 
2.31.0.291.g576ba9dcdaf-goog

