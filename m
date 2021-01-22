Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7AE30012B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 12:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbhAVLGN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 06:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbhAVLEl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:04:41 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B28AC061793
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 03:03:50 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n10so3445860pgl.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 03:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8Cv1OFV4PqWqs9OFGtdzGJdasAixNkXlyH3Z+SOrD2s=;
        b=BJiJsu3jZE45SKsE//wnDRYUoE66mojERC6nqj+RXSMJq8L+sAWvy+Ek/eY6X7iXnQ
         7HRii0Cn+94pI4Tk41+twVE5idKl5uXF8luTbId76mulGeB2KsJOuYNFE4ZsQE+itwfO
         bNA0qeRJv5ijMl9BekVDecCGmm2Ce8kP7diBZkM7j4+N9OM1Pfv00OjZ0+sScXRY6ETW
         w99BkWAm4PMJRR414OVcaFZ/fK94ewRt9f9SKoWoUkHtMbZJby3VDvUinrywWCBQEYVQ
         nv8DReuPmIZ597uGVMZQsYIijzcCOPAQCQD8iVP0ORqZrNf0nOcgUyDU5JxhhzCNY9Gv
         JnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8Cv1OFV4PqWqs9OFGtdzGJdasAixNkXlyH3Z+SOrD2s=;
        b=MOE+KzJ89y+ClgjNXodV9xgtfX38xSbs60/dzhoKoHFCGeJlPAEvk9FwofTZ9JX5p6
         JoxZ0QDz+9FibG05eM/5owDWEsR8sKR7oypblIO/Fj+kjrIRNNP2TZHqrBUFQHqg96gy
         2GHII0h3plDcDoN9roSLNi1UwKZc9SG/+xtrROO7h2o5PQakKm0iQQt/PuhDhIe1jDGo
         QBDYTDmwE9cUnGPDT9I7+mK1vlS/uISX5tfnUkyAyi1Rhl3r61KLB8AapfWvnnbS3phO
         f3Rd5YIxU+dgtyNJvv2nAvXxvcR+bU3LytmHJdADeGUIn1me/n0iFlI/df01NZQIxiUh
         lORg==
X-Gm-Message-State: AOAM5332eAzfFt3dUnUIaMssURxFxQKQHR6WJQTk5sb1TpKOHQNvfgFu
        8ntkabZ2s0PmnI3lMo7vQjiW92LXxGzCEw==
X-Google-Smtp-Source: ABdhPJwR4JqPoRoXyEluavVlTxcnJ79QUlGMEikjpUDWhjKyaOyL+fE+3pOmyoD1A9wUV+Lx8yB51g==
X-Received: by 2002:aa7:88c3:0:b029:1b4:ca2f:2074 with SMTP id k3-20020aa788c30000b02901b4ca2f2074mr4146235pff.45.1611313429324;
        Fri, 22 Jan 2021 03:03:49 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c5sm8997659pjo.4.2021.01.22.03.03.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 03:03:48 -0800 (PST)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     NeilBrown <neilb@suse.com>
Subject: [PATCH] seq_read: move count check against iov_iter_count after calling op show
Date:   Fri, 22 Jan 2021 19:03:40 +0800
Message-Id: <91568e002fed69425485c17de223bef0ff660f3a.1611313420.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code
and interface"), it broke a behavior: op show() is always called when op
next() returns an available obj.

This caused a refcnt leak in net/sctp/proc.c, as of the seq_operations
sctp_assoc_ops, transport obj is held in op next() and released in op
show().

Here fix it by moving count check against iov_iter_count after calling
op show() so that op show() can still be called when op next() returns
an available obj.

Note that m->index needs to increase so that op start() could go fetch
the next obj in the next round.

Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
Reported-by: Prijesh <prpatel@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 fs/seq_file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 03a369c..da304f7 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -264,8 +264,6 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		}
 		if (!p || IS_ERR(p))	// no next record for us
 			break;
-		if (m->count >= iov_iter_count(iter))
-			break;
 		err = m->op->show(m, p);
 		if (err > 0) {		// ->show() says "skip it"
 			m->count = offs;
@@ -273,6 +271,10 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 			m->count = offs;
 			break;
 		}
+		if (m->count >= iov_iter_count(iter)) {
+			m->index++;
+			break;
+		}
 	}
 	m->op->stop(m, p);
 	n = copy_to_iter(m->buf, m->count, iter);
-- 
2.1.0

