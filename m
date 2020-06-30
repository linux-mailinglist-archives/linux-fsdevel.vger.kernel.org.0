Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18FA20F448
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 14:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387556AbgF3MOu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 08:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732036AbgF3MOp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:14:45 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1ACC061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2020 05:14:45 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id z12so11934684plk.23
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2020 05:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WYYjT2/hNkPnR18Pb1O8vFno0wa46kUGqnYNvHL7CO8=;
        b=OsSqYUaDlsn3RDGvRxnfKrOwwmVcSIoKG8D6+pXbsKD6FCLrWQ7Jsvin1ELj893EwN
         A1EIorvIYssa3wRXvBKD3Pp5AQVAVwbbcFQnApEYe0llGG59RkWdtJsMv4yoTqHMHG/L
         MT8D7toVHPVzVH5VL8rSdns+WpG5nKBZntcm7l1L3YDixzo8bwTPfpB53TtfGi+uWPcr
         uMnSqNHaY4af/zEeB7qaznrN9lZp0jjVyzzKYLL56pR0rRpLF0T2yV5GJxboGlDmy1fE
         g0lc4Dk9/oq1duRbjwWwlwL64IeUlgKRSQ7dvQAfUnKENvYOsPjSlWohIAehtV3joMFu
         AYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WYYjT2/hNkPnR18Pb1O8vFno0wa46kUGqnYNvHL7CO8=;
        b=ulJDI/fRcVasPnAczEKL01l1xP1NQi6MWAFaQz/APYi59IGGGliTI5JetkEfEtT1EE
         ux+1khTGf1/d/H7u16PLS1hpJvNTKf2Juc1ssB+qq3Iu9vpDDkCwYSb7Bi0zzVelj86b
         iANwyxSW5iiGOp2pNvpuTccIDxD70gRTLcV5mWACnUa62fktT2q3U68gY7yGX7G5pdPy
         pka3pTziUDQh0/dTHXqWjFQ4Wyvcg8ucNzu04WMLjdBpK8C6x3FX1lfkctY70/neTbZe
         /xbTq3v20lazfcnvMEwS2WmbE/qjfleKCt5T700rGuIH5RZh+vLSLZuVhViz0DBY/jbK
         nh/w==
X-Gm-Message-State: AOAM530xwd2AUT7gCvEnczudaFZ0SHOrtc83gygRQxtdRgBLT6j+JiZp
        BXXpjG9xjekUM6+sxfD41Z5VyBiNN/M=
X-Google-Smtp-Source: ABdhPJyEEcykC3kPlH4nyjzH8L4IuQtmaVrj3RrJmq3Xhyj4L95ZMctLLgbq3tAQNaoQgla9CrRf9QIq+4E=
X-Received: by 2002:a17:90a:6306:: with SMTP id e6mr3080137pjj.1.1593519284966;
 Tue, 30 Jun 2020 05:14:44 -0700 (PDT)
Date:   Tue, 30 Jun 2020 12:14:35 +0000
In-Reply-To: <20200630121438.891320-1-satyat@google.com>
Message-Id: <20200630121438.891320-2-satyat@google.com>
Mime-Version: 1.0
References: <20200630121438.891320-1-satyat@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v3 1/4] fs: introduce SB_INLINECRYPT
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     Satya Tangirala <satyat@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce SB_INLINECRYPT, which is set by filesystems that wish to use
blk-crypto for file content en/decryption. This flag maps to the
'-o inlinecrypt' mount option which multiple filesystems will implement,
and code in fs/crypto/ needs to be able to check for this mount option
in a filesystem-independent way.

Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3f881a892ea7..b5e07fcdd11d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1380,6 +1380,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_NODIRATIME	2048	/* Do not update directory access times */
 #define SB_SILENT	32768
 #define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
+#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
 #define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
 #define SB_I_VERSION	(1<<23) /* Update inode I_version field */
 #define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
-- 
2.27.0.212.ge8ba1cc988-goog

