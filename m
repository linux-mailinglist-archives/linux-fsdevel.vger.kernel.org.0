Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71864E3734
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 17:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503376AbfJXPyw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 11:54:52 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:43054 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2503367AbfJXPyw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:54:52 -0400
Received: from mr1.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFsorl010500
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:50 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFsjNq023897
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:50 -0400
Received: by mail-qt1-f200.google.com with SMTP id j5so25427150qtn.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 08:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=w9B0/WniKt/epgo+p5dMZKrzDCoq6S2v82rQ+FNBDqI=;
        b=TCR/gNP2JyFC1O+9weOKjrMu6PUpJU7dmcuDYQQ4q1OmoGq3xv7J4VYxJzsAPvT5F6
         NvR60o/xPlwkb1QgQ0pgMfnq8pqePt/XT8jg+1x91QX1sM6xrsDhbuYQnTtKeEj4z0NZ
         asQwTR+EpdQpjRblAXML9NiXQU3dZ0BXaC/yNzO5ErlQm+fM8KMEKsHuidiPEAq0t1Gx
         /r2Hj3SETBL7J1GeiLBNFlSdFz7QU27WZiNRpOabhFuLDCWekWbIwY6T3rA5XNRR4tbu
         DM4FOuHkDAi3NqG+qiA3DtYZGq2ak053+49Vp+9at/7S3RSSW1lcBX1wyfULvXliIwpO
         4v1g==
X-Gm-Message-State: APjAAAVAb/MDsNUJ/jPEl/SGr031q/dY6W9PyVFlVQD+sLu3Ma+vp0gK
        JqSwBAOkbRH4rZ0Bwn2eqpqjnhbXqku2NWBJ2Lgard31QZ3aVYDqjMC49D7HqL5bZde36fyX0mt
        AXNYsdRXlIvgucpCUy+YrN4O7Z0j+wRWiasOG
X-Received: by 2002:a37:8b44:: with SMTP id n65mr11178801qkd.312.1571932485436;
        Thu, 24 Oct 2019 08:54:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxUaqQXOGe/pBFaYVlG1qusbGV1mxhM6T0ltC9sZRdfer7+GV4J8xUWUbutmzgjsBo7GZUudA==
X-Received: by 2002:a37:8b44:: with SMTP id n65mr11178775qkd.312.1571932485163;
        Thu, 24 Oct 2019 08:54:45 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:44 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] staging: exfat: Clean up return codes - FFS_EOF
Date:   Thu, 24 Oct 2019 11:53:22 -0400
Message-Id: <20191024155327.1095907-12-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
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
index df7b99707aed..3ff7293fedd2 100644
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
index a5c85dafefb4..a0c28fd8824b 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -717,7 +717,7 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
 	if (count == 0) {
 		if (rcount)
 			*rcount = 0;
-		ret = FFS_EOF;
+		ret = 0;
 		goto out;
 	}
 
-- 
2.23.0

