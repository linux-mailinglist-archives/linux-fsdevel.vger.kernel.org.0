Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12C11C09B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 23:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgD3Vwr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 17:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgD3Vwp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:52:45 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7C6C035495
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:45 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id pg17so5977302ejb.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+HP7z6Hg8lzRP/U1gFmfA3WajvLlBxqo/6VD8xCmFbY=;
        b=hWSupT2lw0h4JkwT99fJDHoFXbGY/qi6K3JHIXf5XBVKrA1IxBVU9BjwR9JRYAP5M3
         mQNvDt+6buK5JxU3IZxBmLzv2kDzBUP6Gel0wdmJlpz/KnhWIY7jFwNA+BriUUF4zQ6e
         F9cGtBvaIgbMyqxC8HVgrTcDdKGLR7mCDmD7KpHofoQk1AYm7qd5z0fb8cCn032cGOWf
         MQPJXejMcv3AkFk6a0BUHTG61C8Bn41oPqbRdS5B/l8Ck9sMF0foC2alUi4NmJaLp6Ol
         Z7ewU8Jdmv3xb8msOTEVnp/iHyk1XgmTBbyFwZCFwhT0W8lD9F5M0SbP32SSiPb2dbI7
         432g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+HP7z6Hg8lzRP/U1gFmfA3WajvLlBxqo/6VD8xCmFbY=;
        b=qHXdDKX4RWvUktnJjRJsS6dku1SndWxzxQ+mgEuCllpHRRPit8GSI6+qBK8AF2cyrA
         py4V7giqHsqaOkOuwyKXhrTM43uCdJ3DmKUFSf2d2VBxEgcNUXzjc/7Uu/q5DXMhZSee
         FSOa7UsC/v2MJziqe4Ao3PuKmaUgm4iqH6dKYiUGuxixj0+DJr3j/ekGTJm16fYR/2c7
         qMHnUx1G9gbzBfa40J3vnuB2H/0tYjRcfD9l3tbhKO8Y6cvKh4qValQ0K5+gE3TP/qqK
         Fp7iwpOrGAfYBzMIqctCE5vuxN+08p3DUnQekwd5plnenFtsCElHro4UJgbBcJT2UdgM
         D+Xw==
X-Gm-Message-State: AGi0PuYlO1w7j5W3oFLQgwZWb+OvNhfNuzqNcTaxVpxBVODPrBuBzJUB
        bjKS8qmsXnfTxyzHSuc3Ew1V+HvR8cN9vA==
X-Google-Smtp-Source: APiQypLxnuHJHZvv+dCCIXb9HbZa2z7yfUHGFVq7rRLwlffWLOh/A1m6HRhFPDQQ2qs6EOYeAyuRQg==
X-Received: by 2002:a17:907:2155:: with SMTP id rk21mr517017ejb.163.1588283563771;
        Thu, 30 Apr 2020 14:52:43 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:b82f:dfc:5e2a:e7cc])
        by smtp.gmail.com with ESMTPSA id f13sm92022ejd.2.2020.04.30.14.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:52:43 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [RFC PATCH V2 7/9] ntfs: replace attach_page_buffers with attach_page_private
Date:   Thu, 30 Apr 2020 23:44:48 +0200
Message-Id: <20200430214450.10662-8-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
References: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Call the new function since attach_page_buffers will be removed.

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
RFC -> RFC V2
1. change the name of new function to attach_page_private.

 fs/ntfs/aops.c | 2 +-
 fs/ntfs/mft.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 554b744f41bf..bb0a43860ad2 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1732,7 +1732,7 @@ void mark_ntfs_record_dirty(struct page *page, const unsigned int ofs) {
 				bh = bh->b_this_page;
 			} while (bh);
 			tail->b_this_page = head;
-			attach_page_buffers(page, head);
+			attach_page_private(page, head);
 		} else
 			buffers_to_free = bh;
 	}
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 3aac5c917afe..fbb9f1bc623d 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -504,7 +504,7 @@ int ntfs_sync_mft_mirror(ntfs_volume *vol, const unsigned long mft_no,
 			bh = bh->b_this_page;
 		} while (bh);
 		tail->b_this_page = head;
-		attach_page_buffers(page, head);
+		attach_page_private(page, head);
 	}
 	bh = head = page_buffers(page);
 	BUG_ON(!bh);
-- 
2.17.1

