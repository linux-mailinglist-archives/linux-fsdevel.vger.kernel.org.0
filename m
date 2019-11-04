Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 170C9ED72A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 02:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfKDBqH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 20:46:07 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:39738 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728881AbfKDBqG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:46:06 -0500
Received: from mr2.cc.vt.edu (mr2.cc.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA41k563025782
        for <linux-fsdevel@vger.kernel.org>; Sun, 3 Nov 2019 20:46:05 -0500
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA41k04E008011
        for <linux-fsdevel@vger.kernel.org>; Sun, 3 Nov 2019 20:46:05 -0500
Received: by mail-qt1-f200.google.com with SMTP id l5so17340966qtj.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Nov 2019 17:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=v4VlzHRnLSC3b1EjzBkiWjmC1bP42YDPnuAdgZvBprM=;
        b=nWKCdoDWFVUcK6bXmzRU8VMwtMRSQe94unXvbi6lXstLaNGQNM34oag2ADUiuvCxS0
         sH0Xrqgs2f8gT2fTBKnsw8rcok52qRQcR/fVT+iGnrh4Hwg+xOOb9p62U+ZpPQFkp0B7
         9loc1rwg7itLLmH4x4wANd3UlpquQIkRCi4Z6Pn8pVvSmfDDr6RAluXdBtn2vzULJjfw
         +zdMJ8zwlKz2LvNa/2t5y0QpFjzucO9yxdbfEEGitR4xbyCTOUjDrg0oAJkuueTKa3hi
         cPCZOwEo8uRcgChD3LhIOP9kwTfhmW/ZgBkzPAcyw0jiAmPvYUqmt+ibRy4M97QXBDdY
         ORUQ==
X-Gm-Message-State: APjAAAWBG9ODJsANoMgwXBpLEK6/2duHoleh7TUxBdyJCo5OyU+vHdEy
        7b/vf8W57XpsM+Wk+4oWFyhSawV1RC2x0m8f4e/ch1YGRcP62jdnauoQeNu0eBYFW8OlBHFcEHM
        PjcQTLNmk8sWl3KUNeKhzgXj+B8IL6h5De+7q
X-Received: by 2002:ad4:5429:: with SMTP id g9mr20440309qvt.27.1572831959969;
        Sun, 03 Nov 2019 17:45:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXoWMfSxtMRA4ckuqq21dK8J+BAjDxrP0r0w/l8V1aRV7ziX/XVpeMeGToZS1TbuMSc3RYUg==
X-Received: by 2002:ad4:5429:: with SMTP id g9mr20440300qvt.27.1572831959712;
        Sun, 03 Nov 2019 17:45:59 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id d2sm8195354qkg.77.2019.11.03.17.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 17:45:58 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/10] staging: exfat: Clean up return codes - FFS_EOF
Date:   Sun,  3 Nov 2019 20:44:59 -0500
Message-Id: <20191104014510.102356-4-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert FFS_EOF to return 0 for a zero-length read() as per 'man 2 read'.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       | 1 -
 drivers/staging/exfat/exfat_super.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 286605262345..292af85e3cd2 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -217,7 +217,6 @@ static inline u16 get_row_index(u16 i)
 #define FFS_INVALIDFID          8
 #define FFS_NOTOPENED           12
 #define FFS_MAXOPENED           13
-#define FFS_EOF                 15
 #define FFS_ERROR               19
 
 #define NUM_UPCASE              2918
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index d6d5f0fd47fd..7c99d1f8cba8 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -723,7 +723,7 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
 	if (count == 0) {
 		if (rcount)
 			*rcount = 0;
-		ret = FFS_EOF;
+		ret = 0;
 		goto out;
 	}
 
-- 
2.24.0.rc1

