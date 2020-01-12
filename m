Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B11A01386D6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2020 15:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733026AbgALOuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jan 2020 09:50:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38879 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733021AbgALOuS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jan 2020 09:50:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id u2so6856967wmc.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2020 06:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WKXH1hdb6rQMtxlZxjexnbpxERmcEI8x0sovi7aY8CY=;
        b=HUe9IeetWd8tI7ualmyZ7XyhAQH+aGSH37/T9NB+JYSHTrUBmCaBLwgL3xFMXVg94g
         94XMc6WxOfr1D/Gamy+T7b7+l/yR3eJa2bkaXUX0TPckduBdqBmMuCTgiVe55EH23xwy
         hiyRiCplY8woN1vHhyGYRZa4veEvQo5LpPP6tPDF7gQlDeFI7lrbZdiU0Wq2I0vgyN9o
         hyxRRDpwcPHMuJ8mudeKMeaeqCF0wTstN2aBeLXAaIlx2WjfTvpPA2Bh3HXemAhVpe92
         4EXXp+lEoH425n/nKsfkbKSM1J1/hEPBCKiVNn6yuvWxUP5JmYMQr2GbVhHR39oMvO3p
         vjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WKXH1hdb6rQMtxlZxjexnbpxERmcEI8x0sovi7aY8CY=;
        b=aJnb+A6WXOMcajAPGtayF/KQI3S4A3hNj9V/d+q+AE2Id7OykIlaKJmsWoc2LjX8dJ
         1a/j6aqdNv8a0xwJWfq6E0YfgiFP0/vCtAApNbjUOzW5vuYV0RQ2Ar3uLK5x+J5fuW1C
         xUdHZ6Ek3+Y0/wfT26ZgI1ofvj3FVBtF2vHNZ+bjvjBipKxE1S+UiokLv9sk4GMgPemc
         so2uFFAs8cSQU75p2ADHvHxwHhEYZ+P2SR7zUAYOQD1xImfqeJ2g3ErPDdl9BiOrf9Mg
         Imd9+5tPmDN2lEcxQB5LGs+aZ1G2yOhwiahZOLvGfPYzvrkloaGfkG8uwL1MNtZXVDQu
         t5vA==
X-Gm-Message-State: APjAAAUpUIT0pB2w4M/wPqvLPRGdI5oGb8PandQ9jxmo9CaRBnAKkow4
        bfCqQtF0lgXHE2C2FgocnpTI5P/6
X-Google-Smtp-Source: APXvYqwn9AL/BROQkDwbDgKBgvmiL4lxNrzQ9gG8TSZLM9hI+MjJZfBTT1Nbb+zgnq4DXRL2RcmgkQ==
X-Received: by 2002:a1c:f719:: with SMTP id v25mr15243494wmh.116.1578840616245;
        Sun, 12 Jan 2020 06:50:16 -0800 (PST)
Received: from Pali-Latitude.lan (ip-89-103-160-142.net.upcbroadband.cz. [89.103.160.142])
        by smtp.gmail.com with ESMTPSA id s15sm10136330wrp.4.2020.01.12.06.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 06:50:15 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH] udf: Disallow R/W mode for disk with Metadata partition
Date:   Sun, 12 Jan 2020 15:49:59 +0100
Message-Id: <20200112144959.28104-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently we do not support writing to UDF disks with Metadata partition.
There is already check that disks with declared minimal write revision to
UDF 2.50 or higher are mounted only in R/O mode but this does not cover
situation when minimal write revision is set incorrectly (e.g. to 2.01).

Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
---
 fs/udf/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 8c28e93e9..3b7073c2f 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1063,7 +1063,8 @@ static int check_partition_desc(struct super_block *sb,
 		goto force_ro;
 
 	if (map->s_partition_type == UDF_VIRTUAL_MAP15 ||
-	    map->s_partition_type == UDF_VIRTUAL_MAP20)
+	    map->s_partition_type == UDF_VIRTUAL_MAP20 ||
+	    map->s_partition_type == UDF_METADATA_MAP25)
 		goto force_ro;
 
 	return 0;
-- 
2.20.1

