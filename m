Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F28EF118CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 14:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfEBMPk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 08:15:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42084 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfEBMPk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 08:15:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so967042pgh.9;
        Thu, 02 May 2019 05:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=auCY3PzhugcAdArS7AYx5TEJOOjQXZAWuV/mKevsN1Q=;
        b=XuabbuKVSY7a2TM5F6FvBFQn2davKNOV1y7Lr6scBDIEa+acuivbsLTj5HYd71Zzt6
         sJXngEGEvlPSLXN6Gp2QAKTx9r4BhjQLOcyh7oyyT76eo0PW3t3uWf2K9M3wL2VrCqPb
         dzoE7YfVfatqZM4E1NjkZZtgSRXYjcVxPLUr0SUnS5VlrBhSYGhSl5oDmSqpzgeEOgD7
         0IMQueDF6Kd1ijK2aE9FUd7xv+94J0F04o4H1UA6gtPVzfHORRGmZKo1MqN5D61FpTu2
         W/lm74RDzcUfD7ZLUMg9YnHGvpsH6HOT1LNZhaAh6BWwyylOtktnXXxfV4+FzxkU6NPr
         GTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=auCY3PzhugcAdArS7AYx5TEJOOjQXZAWuV/mKevsN1Q=;
        b=rfcdXzzZzGH6w+0z15YETqGAarJ+AIizvHLU79735ffnYhe+X0nN6OoH0xSBBilNNM
         CtJWMGxqxC57+TBCdFtj6SklQ8ymuFGRg+QrEJii8x4hIHMnh+ADObjtE6eBQ8nzFhxw
         VNCmSDx/O4f58/a7J4WOVKBWSphOM8god1ujHDebzhOiu2SENTab8SWuvVrm4ABDZWmC
         6UiYt8fUKAq4d4cmd4yD+RrTjb+mhRCPGSOO0Amdxa8T8U5QtTHhq5uKSf+yLGqoBRFw
         s8lfxM9e1zKDtLFY8wNSSznvNydfmLpkwDay2Rxtcb8pbKXVopQZ5ZUh3TZEACCxHll2
         vA7g==
X-Gm-Message-State: APjAAAWgG0PmGwA2RQgujpW3/E+Nv33nGeIz9bIjwXn079y6gItmBQYb
        JBPw9k2MywNwRrmT7FJjqDc=
X-Google-Smtp-Source: APXvYqyNDzr4VF4z/AVRLM0JxesMpf6pLO1/Hf/qL0RfemyI7luIkHnjwSRcCepUsyWRR+ut+H+Ryw==
X-Received: by 2002:aa7:9116:: with SMTP id 22mr3801463pfh.165.1556799340062;
        Thu, 02 May 2019 05:15:40 -0700 (PDT)
Received: from localhost.localdomain ([149.129.49.136])
        by smtp.gmail.com with ESMTPSA id j9sm97547364pfc.43.2019.05.02.05.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 May 2019 05:15:39 -0700 (PDT)
From:   Chengguang Xu <cgxu519@gmail.com>
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmail.com>
Subject: [PATCH v2] chardev: set variable ret to -EBUSY before checking minor range overlap
Date:   Thu,  2 May 2019 20:15:05 +0800
Message-Id: <1556799305-13288-1-git-send-email-cgxu519@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When allocating dynamic major, the minor range overlap check
in __register_chrdev_region() will not fail, so actually
there is no real case to passing non negative error code to
caller. However, set variable ret to -EBUSY before checking
minor range overlap will avoid false-positive warning from
code analyzing tool(like Smatch) and also make the code more
easy to understand.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Chengguang Xu <cgxu519@gmail.com>
---
v1->v2:
- Rebase against the latest char-misc-next.
- Modify signed-off mail address.

 fs/char_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index d18cad28c1c3..00dfe17871ac 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -98,7 +98,7 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
 			   int minorct, const char *name)
 {
 	struct char_device_struct *cd, *curr, *prev = NULL;
-	int ret = -EBUSY;
+	int ret;
 	int i;
 
 	if (major >= CHRDEV_MAJOR_MAX) {
@@ -129,6 +129,7 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
 		major = ret;
 	}
 
+	ret = -EBUSY;
 	i = major_to_index(major);
 	for (curr = chrdevs[i]; curr; prev = curr, curr = curr->next) {
 		if (curr->major < major)
-- 
2.17.2

