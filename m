Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF08FE3714
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 17:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409811AbfJXPyR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 11:54:17 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:54324 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2409806AbfJXPyQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:54:16 -0400
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFsFb9026689
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:15 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFsAu6003422
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:15 -0400
Received: by mail-qt1-f197.google.com with SMTP id d6so25527133qtn.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 08:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MUvS5PDnwB4+WdsZuJfNIUv2476cZnvleiETBi+G30w=;
        b=Ni0IbcbnZqdMQfzTlnS0euv9eR0LIOQtlaZEx4Sz9O6mHEabm6jkZ4xHqw9wNvC+KZ
         RCot+Y5sEimCUC9M7E3POqgdxVXvQfxfssU6EF/LjKbpiSKShdX9+XhJRLduDXmaYDMa
         CK+YA+iE5AcAy8XXyzQEZyw+HTCzIZ+KNnrlZhTEMkLlZh7+6g008UhKIBoKp2fvW12g
         VcluBKWBKD0emiU7qWUt1pd74q6sj0s2kldKZeqFdkYoeKCnUOXnp3TBE6DkkjmAOrej
         Y0gCzJPPUQR3+mvW19MqhLYo4mjafdavpFbUxl1WiiXAjoaAlN0ikhuBk7EwZpUKKG3j
         Y4qw==
X-Gm-Message-State: APjAAAWjpKgRa+vTs2JuS1r9QGXtotxMjRGc67NXn+vWwGrsZG3LQNxp
        NCmnBgKNTAyJpqHpjXYW08xw8WYy/m4B1oZcuL7U61q2Xq4brdjfOLi1oaiojBLI94Qvb19ktu3
        NyS/Joz27m/qMIkO3x9iNHGGp9qgw/4LixFkb
X-Received: by 2002:a37:2d45:: with SMTP id t66mr14453495qkh.259.1571932449987;
        Thu, 24 Oct 2019 08:54:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyv0THDRF5Q8L/pxFbc9GDAB6Ang93ytLfBAJhcM8jNwiofzVTAkF/B5LwGaOEgwq3ULpiVKA==
X-Received: by 2002:a37:2d45:: with SMTP id t66mr14453464qkh.259.1571932449713;
        Thu, 24 Oct 2019 08:54:09 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:08 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] staging: exfat: Clean up return codes - FFS_DIRBUSY
Date:   Thu, 24 Oct 2019 11:53:14 -0400
Message-Id: <20191024155327.1095907-4-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert FFS_DIRBUSY to -EBUSY

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       | 1 -
 drivers/staging/exfat/exfat_super.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 1d82de4e1a5c..ec52237b01cd 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -221,7 +221,6 @@ static inline u16 get_row_index(u16 i)
 #define FFS_NOTOPENED           12
 #define FFS_MAXOPENED           13
 #define FFS_EOF                 15
-#define FFS_DIRBUSY             16
 #define FFS_MEMORYERR           17
 #define FFS_NAMETOOLONG		18
 #define FFS_ERROR               19
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 50fc097ded69..566cfba0a522 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -2697,7 +2697,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 			err = -ENOTEMPTY;
 		else if (err == -ENOENT)
 			err = -ENOENT;
-		else if (err == FFS_DIRBUSY)
+		else if (err == -EBUSY)
 			err = -EBUSY;
 		else
 			err = -EIO;
-- 
2.23.0

