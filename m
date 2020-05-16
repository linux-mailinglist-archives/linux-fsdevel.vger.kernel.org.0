Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CE01D5E23
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 May 2020 05:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgEPDUG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 23:20:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42301 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgEPDUE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 23:20:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id k19so1689852pll.9;
        Fri, 15 May 2020 20:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5R02k+n3cdjio+bit0SkkAOewNF+56MtF6LzxgE/Yc4=;
        b=SxXw5Sz59WDOSmbDO38rqZBaI43VGqZibN5/OlZjwCIAKmtaNa5jktpkugtvgo8ZGo
         Ux7t/crgJvXqMets4Y609k0U2+kghQVozOn5N9oULPRexmEMKiuDPO9phMqeNtvvnp2q
         3jcFAwwcZO6bH1AyNwDWpvkBtEvkecPzlnYAv2T2QlhBAwNE0N+RZElpk21Y0I4EAQeJ
         cfbwjqFxXy1dIWuEIoL8pCSaVzFbBwjOejz4g4Nl3jW2VlHZ1r7mKijH9TUBGlr60Kkz
         UrB8EMknXBvBciDfgEbUo7G4qiO/noRdBolQWs87moS5QG/bWOqAM10oxjfBUePr/Jtk
         Obxw==
X-Gm-Message-State: AOAM533F5OULubmunh6bD9sNlbJZdfPhJ/RFrdOc/Kyi1OfndyS9d6NK
        sGSw/nGj4cEW2y1xqXkbj8A=
X-Google-Smtp-Source: ABdhPJxH1a/0+wYkeQjawqSViebcCCHDKk4gr7Y6Fd5IRIO2nQhXkOGRxo0KxGldWnfbVVdS506+0g==
X-Received: by 2002:a17:902:7402:: with SMTP id g2mr6609838pll.241.1589599203778;
        Fri, 15 May 2020 20:20:03 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id e21sm2763562pga.71.2020.05.15.20.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 20:20:00 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E676141D00; Sat, 16 May 2020 03:19:58 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 2/7] block: clarify context for gendisk / request_queue refcount increment helpers
Date:   Sat, 16 May 2020 03:19:51 +0000
Message-Id: <20200516031956.2605-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200516031956.2605-1-mcgrof@kernel.org>
References: <20200516031956.2605-1-mcgrof@kernel.org>
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
index e438c3b0815b..94216fa16a05 100644
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
index af910e6a0233..598bd32ad28c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1017,11 +1017,15 @@ static ssize_t disk_badblocks_store(struct device *dev,
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
 
@@ -1785,6 +1789,8 @@ EXPORT_SYMBOL(__alloc_disk_node);
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

