Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A451B9443
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Apr 2020 23:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgDZVt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 17:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgDZVtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 17:49:55 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03624C09B050
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:55 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id re23so12482015ejb.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Iy5dbJ5ulEBQZnVYe4LdimJwxmRBu3H1I8kAoywkhO4=;
        b=CNngllvg67ixykLg7cIJmP9idgw85CRV9miXlKw51shYgZp8X7u0kscny53amrBTHc
         911VnBxmwMuOV4SMj0chVxA/OMGNGdYUJIvzcQY/1rcco/Mso860J2eU88rH1GapiEOf
         Lk5647aRv60gkMz62Di52oIsDnE1MnHVDvMWsDKr7xXXLrfk0hSblYlNC7L9OB5nBYTz
         0eY+qIPp8bjWHmcEmAzKTNtLyLaF3FQTM05XLfoOp5jpG4gvO9k5PW0q0qwnt/BOvI6w
         juUApwcHoJ/i5G0Pds+09eEE7A53kzuE0TnqRhvo9v7tEzJM9ViaeYaCS4t/KJ5QCYC6
         kcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Iy5dbJ5ulEBQZnVYe4LdimJwxmRBu3H1I8kAoywkhO4=;
        b=KiUGW/2gJfrwFIUYv9xpE/rS2iVuJlA08nTWLWFbI6oYC70NBkDyI7tcE8rapyY8VD
         6qqOTKneS9z6BwM2djHkX/I3eLSy06B0ZKAkODrhTJUBq90UPcyty5A9GXCObMKEkn+f
         EuZlNAQZZ0TkDwsOumcVn9Nx+j98sZa03PPe+MT3s11Zfl3/q2njyn6ChohneI3IiXGR
         5ja7ptgSlQu8VThstDekJf1OfCJD2hX8xygzrzXKdOscECpZjJ4m7nX4rYKqC/LC1hmT
         PF7MbFAfwCqpX5OpdOajjMRuN6cU7Gc9ESeJeP2/tWB1uwERwxQ//se6vkQk9LfEI+SA
         5DGQ==
X-Gm-Message-State: AGi0PuYqgsmOUdDaEPQeFgqN8RtaTjZgbOuuHh4STKD57mdgVODJgdE9
        b8YKLW+Yi3kerqxjp1UOXxhKUBySv5R2PEyF
X-Google-Smtp-Source: APiQypJatlHYD59JEc271Gli6C08LancT/2sGpWnY7Tf056t/k2L5Citpx+qKcX3OmqZHaINj2ZELA==
X-Received: by 2002:a17:906:6856:: with SMTP id a22mr17551863ejs.115.1587937793540;
        Sun, 26 Apr 2020 14:49:53 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:fab1:56ff:feab:56b1])
        by smtp.gmail.com with ESMTPSA id ce18sm2270108ejb.61.2020.04.26.14.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 14:49:52 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [RFC PATCH 7/9] ntfs: replace attach_page_buffers with set_fs_page_private
Date:   Sun, 26 Apr 2020 23:49:23 +0200
Message-Id: <20200426214925.10970-8-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Call the new function since attach_page_buffers will be removed.

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 fs/ntfs/aops.c | 2 +-
 fs/ntfs/mft.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 554b744f41bf..d8c60e5793c0 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1732,7 +1732,7 @@ void mark_ntfs_record_dirty(struct page *page, const unsigned int ofs) {
 				bh = bh->b_this_page;
 			} while (bh);
 			tail->b_this_page = head;
-			attach_page_buffers(page, head);
+			set_fs_page_private(page, head);
 		} else
 			buffers_to_free = bh;
 	}
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 3aac5c917afe..e61cb280aee0 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -504,7 +504,7 @@ int ntfs_sync_mft_mirror(ntfs_volume *vol, const unsigned long mft_no,
 			bh = bh->b_this_page;
 		} while (bh);
 		tail->b_this_page = head;
-		attach_page_buffers(page, head);
+		set_fs_page_private(page, head);
 	}
 	bh = head = page_buffers(page);
 	BUG_ON(!bh);
-- 
2.17.1

