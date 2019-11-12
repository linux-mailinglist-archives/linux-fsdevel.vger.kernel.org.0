Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA1FDF86A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 03:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKLCKg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 21:10:36 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:47980 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727049AbfKLCKg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:10:36 -0500
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xAC2AZg5011464
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 21:10:35 -0500
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xAC2AUNL032198
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 21:10:35 -0500
Received: by mail-qt1-f199.google.com with SMTP id v92so19071667qtd.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 18:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DPYClz7LCDj0+BjYYDN7UOMear3Iae3kG0hEuBak2P8=;
        b=ZuZ6aFX+HJk2rK5VfqWRyURb1Lz5azoV+yCuEoqijPRL0qX6Lw9naumvNsVl8qO0zH
         NlqdIxMuLh3q4pElALcXc2Xo+jj26cThkwb0zHqz4wB454eIoyZeH5kJoEcyfrjW1xTl
         cM3Erggjl9ZFPqxkkGb4zhDPMJGvQHV1v/am3NFCVhYzCAoDRYjCg24xYCRsTsdYLGrJ
         C561TuoqZhsFEH3VNVVmn1QNj8SYCWr3Htx6H2UYPQB/5s/FI0fS2+kqQ2HOt2nPPdLV
         +0uNQhbZie2EfvNKb1fEK0r/R7EX6SkzjqzOO7i6ydtUvEmfWMzl6h9uzzlVd+4yqz8S
         gF/Q==
X-Gm-Message-State: APjAAAV4Tn9CmY7erbvrcv54Yzpbn4e0pgb0ezDkN8vJeh9Xo+fggbLj
        Ye1KlF2AZyrPkFC+pwP790sYaBsx6ZC6N7okbdk6sOfxe1BwTsf8SuSVJy/pjpHKwBqYsecQlRO
        UkfF22+O2tDhK3hHaZApFGIS1fszskZOvMKxj
X-Received: by 2002:a37:30b:: with SMTP id 11mr3819796qkd.254.1573524629782;
        Mon, 11 Nov 2019 18:10:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqw2dur+yakoYVVJvPAEPbS3GqD5CoXaqf6BC9T/Frq5jGpMp/n1Sbs+SyzKW5RMGN/bLLZ0cQ==
X-Received: by 2002:a37:30b:: with SMTP id 11mr3819776qkd.254.1573524629505;
        Mon, 11 Nov 2019 18:10:29 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id o195sm8004767qke.35.2019.11.11.18.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 18:10:28 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     gregkh@linuxfoundation.org
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] staging: exfat: Clean up return codes - FFS_EOF
Date:   Mon, 11 Nov 2019 21:09:51 -0500
Message-Id: <20191112021000.42091-4-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
References: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
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
2.24.0

