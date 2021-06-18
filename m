Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605393AC58F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 09:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbhFRIBo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 04:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbhFRIBm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 04:01:42 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A363C061574;
        Fri, 18 Jun 2021 00:59:32 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e33so7153396pgm.3;
        Fri, 18 Jun 2021 00:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dO9vd7sYPzUkbEGL9cf5HXTiOWzCKdLCgZPTGvHdqSI=;
        b=qf3WPuQbi1rO7hQHqHTLHqAPpN4YDpZI4MQmpdNeabsd9uDI+8MRBjKHkqKV9baqxA
         UjRcsfV5si/2LZrZVEgALCDmdsaQrFMOJNACRjQj+vaIF01Iqd1Q2yZi7QtjhzK4FiTS
         2FS2OC11ZqzX0eVVOlTO8Ix15oRpHN2wsNxP26BAMvo3dMgS9Y5l75qeb04f8wsd0UvN
         7Snw/QtYpxmbSR3LQT6Du+1r9ZIguTpvTkh/1X5/zLQfLplXWAaXs37U8r73IYw4m5U2
         n3THln3WKLX2pZvZvh2kKOJE0WCnIJRZGD2xpnvznjPPgFurNnU4hroCUfARYkkMDRb+
         AaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dO9vd7sYPzUkbEGL9cf5HXTiOWzCKdLCgZPTGvHdqSI=;
        b=uPqxXsfw8TRQtQvHo7olB29SPh1faJriQGHQ4MPgF+/m9rK7ZJ1a/g1GPQ/Ila7kUt
         i8ZjuD+G2m62ZyQeOe2/R+se1d48ECy98hS24Nvaq9ocCsX1WUf+zgEIq4McMiobZTM5
         B7oRsoTkg+Z8Je08fgj7chH2Jpj4cgnlph0pzYXlLp9OtSUj8lF7FHKQVmSR7ztIoPiM
         OVS4ZY/pYPW9Cp7XWKK93cAmq4HuSODr4pybi3QvtaIOsJvH3LOEynTkA7uWCxDL+B/8
         khOXoBw3IkwoQEQ8zFSOGCNBlCjPv3a3XpfaWwmX9b76pcbkIz0A3m3rf1lJAiFW9pRY
         l5Vw==
X-Gm-Message-State: AOAM533fxf5ypRkztgZzntY+5NsUHG6SwhsdN1HH7w0MBAGKkXI0jzxZ
        HPvhgiKnXDz157fCPq/Zhjc=
X-Google-Smtp-Source: ABdhPJz3JwXH7zCmtl+3Mwn2iiW+9nGV+M6hL+pXbQoAcV1YDSC/sGIlPqhT47so8g9ez5/9OElq6w==
X-Received: by 2002:a05:6a00:1789:b029:2f4:cb41:ec1d with SMTP id s9-20020a056a001789b02902f4cb41ec1dmr3805646pfg.3.1624003171965;
        Fri, 18 Jun 2021 00:59:31 -0700 (PDT)
Received: from localhost.localdomain (220-130-175-235.HINET-IP.hinet.net. [220.130.175.235])
        by smtp.gmail.com with ESMTPSA id 195sm412598pfw.133.2021.06.18.00.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 00:59:31 -0700 (PDT)
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
X-Google-Original-From: Chung-Chiang Cheng <cccheng@synology.com>
To:     jlbec@evilplan.org, hch@lst.de, pantelis.antoniou@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH] configfs: fix memleak in configfs_release_bin_file
Date:   Fri, 18 Jun 2021 15:59:25 +0800
Message-Id: <20210618075925.803052-1-cccheng@synology.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When reading binary attributes in progress, buffer->bin_buffer is setup in
configfs_read_bin_file() but never freed.

Fixes: 03607ace807b4 ("configfs: implement binary attributes")
Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 fs/configfs/file.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/configfs/file.c b/fs/configfs/file.c
index e26060dae70a..cdd23f4a51c8 100644
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -466,9 +466,13 @@ static int configfs_release_bin_file(struct inode *inode, struct file *file)
 {
 	struct configfs_buffer *buffer = file->private_data;
 
-	buffer->read_in_progress = false;
-
-	if (buffer->write_in_progress) {
+	if (buffer->read_in_progress) {
+		buffer->read_in_progress = false;
+		vfree(buffer->bin_buffer);
+		buffer->bin_buffer = NULL;
+		buffer->bin_buffer_size = 0;
+		buffer->needs_read_fill = 1;
+	} else if (buffer->write_in_progress) {
 		struct configfs_fragment *frag = to_frag(file);
 		buffer->write_in_progress = false;
 
-- 
2.25.1

