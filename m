Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00051F1E0D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 19:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbgFHRBc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 13:01:32 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54175 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbgFHRBc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 13:01:32 -0400
Received: by mail-pj1-f65.google.com with SMTP id i12so91506pju.3;
        Mon, 08 Jun 2020 10:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZlpRC/Mpz8aVWhkWOBV4KQndGPE3w8KEQwXgj5xVC8o=;
        b=aff/EbkvWJkPS7DAFZmAJ5iblzVnr3aahxzDr2JgvOKco/vu9ZDAd1nd8fEfSrQ9GS
         Jz7CNNnkkNjLM0eZMDDDjlOBcCB9oRipy0KgmNuPQ6CnowyXNRXdoLbiKyvsVl3FXhR0
         OQh+Z4i1F18z+01GjsvV+dQkMHrzynbG9x4AAg8OBfImr71UTVAzJea1AzVTw1XLAVbp
         Z4jOyqD/YjRDEOWtEDtqaaiGJpwOYsS45j/ypRAt8DELTI0HPyVsH8bxHZo5tPElK9Pk
         iBugA1qKw2qqzGzAw5gV6j+U3r6y4gPImdMlss2BdMsEul/V0tKFQlLgd7jNwb6+SI+F
         n1Cw==
X-Gm-Message-State: AOAM5332KUbHnPLw/5aA6Ovc5evenJOJcyV5LZhNYvug3Ieaq31lKPXB
        6jZdIkRkTU98PYDKJTs9KUTMD/Nu5Ac=
X-Google-Smtp-Source: ABdhPJwNsBvs+w+3hNLWX1L/WRF8FImqilYKhRJVhUwJyH1Y0WnlC6Bcs7lRahJkSJraRMBfGhoc7w==
X-Received: by 2002:a17:902:eb13:: with SMTP id l19mr20105245plb.213.1591635691008;
        Mon, 08 Jun 2020 10:01:31 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id e124sm7619466pfh.140.2020.06.08.10.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 10:01:28 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 217B640B6C; Mon,  8 Jun 2020 17:01:28 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 2/6] block: clarify context for refcount increment helpers
Date:   Mon,  8 Jun 2020 17:01:22 +0000
Message-Id: <20200608170127.20419-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200608170127.20419-1-mcgrof@kernel.org>
References: <20200608170127.20419-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let us clarify the context under which the helpers to increment the
refcount for the gendisk and request_queue can be called under. We
make this explicit on the places where we may sleep with might_sleep().

We don't address the decrement context yet, as that needs some extra
work and fixes, but will be addressed in the next patch.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/blk-core.c | 2 ++
 block/genhd.c    | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index a0760aac110a..14c09daf55f3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -610,6 +610,8 @@ EXPORT_SYMBOL(blk_alloc_queue);
  * @q: the request_queue structure to increment the refcount for
  *
  * Increment the refcount of the request_queue kobject.
+ *
+ * Context: Any context.
  */
 bool blk_get_queue(struct request_queue *q)
 {
diff --git a/block/genhd.c b/block/genhd.c
index f741613d731f..1be86b1f43ec 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -985,11 +985,15 @@ static ssize_t disk_badblocks_store(struct device *dev,
  *
  * This function gets the structure containing partitioning
  * information for the given device @devt.
+ *
+ * Context: can sleep
  */
 struct gendisk *get_gendisk(dev_t devt, int *partno)
 {
 	struct gendisk *disk = NULL;
 
+	might_sleep();
+
 	if (MAJOR(devt) != BLOCK_EXT_MAJOR) {
 		struct kobject *kobj;
 
@@ -1764,6 +1768,8 @@ EXPORT_SYMBOL(__alloc_disk_node);
  *
  * This increments the refcount for the struct gendisk, and the gendisk's
  * fops module owner.
+ *
+ * Context: Any context.
  */
 struct kobject *get_disk_and_module(struct gendisk *disk)
 {
-- 
2.26.2

