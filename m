Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831BA6072DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 10:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJUIuI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 04:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJUIuD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:50:03 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C39C13D49;
        Fri, 21 Oct 2022 01:49:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VSioR4e_1666342153;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VSioR4e_1666342153)
          by smtp.aliyun-inc.com;
          Fri, 21 Oct 2022 16:49:14 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     jlayton@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] netfs: export helpers for request and subrequest
Date:   Fri, 21 Oct 2022 16:49:11 +0800
Message-Id: <20221021084912.61468-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20221021084912.61468-1-jefflexu@linux.alibaba.com>
References: <20221021084912.61468-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Export netfs_put_subrequest() and netfs_rreq_completed().

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/netfs/io.c         | 3 ++-
 fs/netfs/objects.c    | 1 +
 include/linux/netfs.h | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 428925899282..58dd56e3e780 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -94,12 +94,13 @@ static void netfs_read_from_server(struct netfs_io_request *rreq,
 /*
  * Release those waiting.
  */
-static void netfs_rreq_completed(struct netfs_io_request *rreq, bool was_async)
+void netfs_rreq_completed(struct netfs_io_request *rreq, bool was_async)
 {
 	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
 	netfs_clear_subrequests(rreq, was_async);
 	netfs_put_request(rreq, was_async, netfs_rreq_trace_put_complete);
 }
+EXPORT_SYMBOL(netfs_rreq_completed);
 
 /*
  * Deal with the completion of writing the data to the cache.  We have to clear
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index e17cdf53f6a7..478cc1a1664c 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -158,3 +158,4 @@ void netfs_put_subrequest(struct netfs_io_subrequest *subreq, bool was_async,
 	if (dead)
 		netfs_free_subrequest(subreq, was_async);
 }
+EXPORT_SYMBOL(netfs_put_subrequest);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index f2402ddeafbf..d519fb709d7f 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -282,6 +282,8 @@ int netfs_write_begin(struct netfs_inode *, struct file *,
 		struct address_space *, loff_t pos, unsigned int len,
 		struct folio **, void **fsdata);
 
+void netfs_rreq_completed(struct netfs_io_request *rreq, bool was_async);
+
 void netfs_subreq_terminated(struct netfs_io_subrequest *, ssize_t, bool);
 void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);
-- 
2.19.1.6.gb485710b

