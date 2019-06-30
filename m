Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3DD5AFF7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 15:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfF3Ny5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 09:54:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35108 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfF3Nyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 09:54:55 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so22777412ioo.2;
        Sun, 30 Jun 2019 06:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0lUkdpLwnsPV2033Gelot7S3NczTnw9f1lWg30kTGWo=;
        b=ca9mDhOnXlgaCdc1K3+hB0JNFEsZRVz+E1NbCNTsvyHHUf7vA/YLvMPFT+y0SLXwAJ
         Fohf8dd0Lu2/2GGhOTOs1cSc6lAG2duO0QZf1iTgXIlXU/T/QTuwdpblOtHzB3oXMvdt
         qWyh99CWIog1LuBAuhd9ZX52y+BGgSk/JapvnqKo/GUSyyOEUrER8XreJLMMc+gaJMDR
         Ynm/LoclspqzfTPuG3wPjRaO1i+5LK1L9zn0CAK6ZmpIpc1Jw8z7XKnaJfSBYbsWh//o
         a9X7RQQkWHyHEEOcRvGM+jCaI73iKtn+bDOOdJeLar2RgwALr6mmudSaC3Pwv0HU6HKs
         DR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0lUkdpLwnsPV2033Gelot7S3NczTnw9f1lWg30kTGWo=;
        b=uZ7m2AuZKOZ6BwvApZYF0/b2g1/KyjT3JPeWZZrm9Znw8bH27Po5WXV2m/8Pfi7b1c
         bPY14F2bYMlzSV/ncZ2Nd/60Hen34JyKKfcrSAVakklADD0QrZxz7HiVBR+61LnQCXKQ
         la4A4iOQcEc4ffK7BFNdV+ulSwBkJdC84biXLuY7nvU+tuSc9Ol61OD5jiG/CAKsFFKW
         J806O16RK1DNaGP7olDlS+7MBuZeDHzuRLy/HODglP5DpJPgE5m0MYhG1HwR/0xhP0lI
         yYer9EWRxgtizLqOeFHe8cI/a4/CZmhxHhTDLOkePUM+rc08k1HsgGI33rOzXTZXUbXN
         CU0g==
X-Gm-Message-State: APjAAAVWN/MTd/posWt6QGu+eOfCPgl8npP+H4wdmSHwQ4/ak3J0k5mm
        xiYNCCJxajhSeILLL6QL9A==
X-Google-Smtp-Source: APXvYqyoslI3WEdCtnA0U+TyuFQ3CDVcS92Gaa8/+Fm0Vnh/N0Lo98CZ2CLAO7LKCx9B3KkecBOk3w==
X-Received: by 2002:a5d:94d7:: with SMTP id y23mr19362623ior.296.1561902894928;
        Sun, 30 Jun 2019 06:54:54 -0700 (PDT)
Received: from localhost.localdomain (50-124-245-189.alma.mi.frontiernet.net. [50.124.245.189])
        by smtp.gmail.com with ESMTPSA id z17sm11930378iol.73.2019.06.30.06.54.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 06:54:54 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/16] vfs: Export flush_delayed_fput for use by knfsd.
Date:   Sun, 30 Jun 2019 09:52:28 -0400
Message-Id: <20190630135240.7490-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630135240.7490-4-trond.myklebust@hammerspace.com>
References: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
 <20190630135240.7490-2-trond.myklebust@hammerspace.com>
 <20190630135240.7490-3-trond.myklebust@hammerspace.com>
 <20190630135240.7490-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@primarydata.com>

Allow knfsd to flush the delayed fput list so that it can ensure the
cached struct file is closed before it is unlinked.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/file_table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/file_table.c b/fs/file_table.c
index b07b53f24ff5..30d55c9a1744 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -327,6 +327,7 @@ void flush_delayed_fput(void)
 {
 	delayed_fput(NULL);
 }
+EXPORT_SYMBOL_GPL(flush_delayed_fput);
 
 static DECLARE_DELAYED_WORK(delayed_fput_work, delayed_fput);
 
-- 
2.21.0

