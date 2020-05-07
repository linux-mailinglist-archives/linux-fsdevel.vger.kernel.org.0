Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971F61C9DA7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 23:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgEGVoq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 17:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbgEGVo2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 17:44:28 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBB8C05BD09
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 14:44:26 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id b20so5865519ejg.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MKELhdYWYdAhzUDf2017C+zkiBNUO+dgi+kWgqsMaQo=;
        b=Js03/NCa0TzF0VfdeXIzvkro8wybq6NjNQGCqPdKQimeJrwvTYtam+cSE0RRwMUm3v
         UKO22AXxUWq/amzRnIRIwO0Z5TTODWjNj+FTzFVyBu30xNOBzSAfGNyNMKkLB+Armh8i
         nvTYb6dHmiGx9DTByyKmOD/rNqQhoVbdn/2HvmK0gC/pAmGrkxCsvIYzi4qm0lTF/Dof
         bOzxMb3YXJQhTb0g/oiCNAhJ7f03rlHoxMG7flnajSrFCu0UUpFwCNuCbH6q4YTGwB58
         tjjHhZ0vmnw9ocarUaxvdVGuTgV9Gh2fHuamzzNAgyG4ZfzqwxeVh4dcPrvW+ZQdPafm
         8E6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MKELhdYWYdAhzUDf2017C+zkiBNUO+dgi+kWgqsMaQo=;
        b=V+jmHtfBewRYn8ebHZVvtgJgD2pWc0K2AQxWliHPn/nfA/eqHrzwkAFgguh9CkqmTQ
         ORUxmxxOHdthFVORw5Hc8A5jJ/JNK1K1jV/Dem9/8uRtL6Z3fTO4Ht9ryMoWOhWp5YM8
         SCMKTXEMHJyNNq9Vp2V2Vuijhthr0i/MEJVsLl60PiZooxXoku5S29WW4rv6dZn8BlAH
         XadwETyp2KDcyiBiabUd9+mKPLGAfaBXrE2DYgHhpCU1AU4P85qAKE+m6EKIuCMs7or+
         oE72276Y19/gTdTZrJBaK2NFlFPVJjt58Y7UAR8apZ+RH4gpcI+CcoXeCQ1xygMyUYhN
         tAug==
X-Gm-Message-State: AGi0PuZwFAaM1G1Z3i+0fL0D4qkWCJ7Lhit2bdPd3MrKd3h80PAF1Wps
        Wl/xO1ztyOiXP/QD/4grzGNzTqh2+49XYA==
X-Google-Smtp-Source: APiQypJzdpl8spMfNAAlzzO6AXeNQL/Cqjj7WRO6qZUO8sBaGbOHi6SshrS0cNwvt3L9wQtnEzsBJw==
X-Received: by 2002:a17:906:6990:: with SMTP id i16mr13653114ejr.175.1588887864765;
        Thu, 07 May 2020 14:44:24 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ee:a39a:b93a:c084])
        by smtp.gmail.com with ESMTPSA id k3sm613530edi.60.2020.05.07.14.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:44:23 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [RFC PATCH V3 07/10] ntfs: replace attach_page_buffers with attach_page_private
Date:   Thu,  7 May 2020 23:43:57 +0200
Message-Id: <20200507214400.15785-8-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
References: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Call the new function since attach_page_buffers will be removed.

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
RFC V2 -> RFC V3: no change

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

