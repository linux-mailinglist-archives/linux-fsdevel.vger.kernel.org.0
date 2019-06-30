Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 284C45AFF3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 15:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfF3Nyw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 09:54:52 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33077 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfF3Nyw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 09:54:52 -0400
Received: by mail-io1-f65.google.com with SMTP id u13so22795175iop.0;
        Sun, 30 Jun 2019 06:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uJQISiYeBNw/ErwgBXjdG4575zJj77MOUucRMpWDu8E=;
        b=Amx+zs+jqxuwfnOy7YTys1WQvbm1ORqiNaeYZ0+/JH0wvFBJtcT2+s3nkqOn2EghzP
         7vBkjVnNqHd6FkTcq7pRrerdIKu0xeP5nI8F+auISQob4e6WXulgGIfdhhGYn1BjSljb
         fnAMd37SUI5L5SdzCfZZ/Pm5Hk2farLvH2frfh4ccOTEfANbdgAcdodajMrYim4KqxO1
         BBBzIHxy2BmqZsyJ7h9sykLRC7JRa4N0ivRNWQgMcgH+0DtP9sFnjYgDsbprdYzksj+O
         Qui7DlJG1KLhobUvJl7jQfRtWBNPzH+m8kf0QCXnSilgO5rO+qMEKyOQqOSalF3pjkWq
         +gDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uJQISiYeBNw/ErwgBXjdG4575zJj77MOUucRMpWDu8E=;
        b=m39uJFsm2elcz9WRF8+gu3q663mEiJS2upOXfl6fbLz3Bn2TMYrIB+XWqCii9Au6+v
         E6mHHVEVgI2zbDdunkjovXO6zI2bHVnpaPyz/o9DLdHtXZQMGBZHxg3VNBt7Zpbmz9QG
         4QoE0GlPYN0mHT9UeoutNKKYzPYHYkA03i53zQgWFbnpxpseITEntS7NOD4kwZi8TAya
         2VXuCyIiZCpVD+2rj40fSv+whHDuzXkbbU4rxMRedytO8O9N/LBM4xneFKteBiUiyd1h
         G2J9ySDHW7Y7ske0dWYMlLhrbivJ80yLMJOjI1eg+pwbkh2OInSpBVAzA6Bm85QgGJs1
         5PJA==
X-Gm-Message-State: APjAAAVRL7ZBExTamUPcxszQEFy3LZG3TGFIl1+JdQf2JfxE0TgB673+
        cyR64B5Y4trMKSjIhXFoQw==
X-Google-Smtp-Source: APXvYqyk3S1cpCQT1HOJYwqr5nnu/XjZIYzoTGMLa4TWX74+2XMPWP69Qz8LgFkUCR+E2nWWQ6KmSA==
X-Received: by 2002:a02:c885:: with SMTP id m5mr22837003jao.101.1561902890491;
        Sun, 30 Jun 2019 06:54:50 -0700 (PDT)
Received: from localhost.localdomain (50-124-245-189.alma.mi.frontiernet.net. [50.124.245.189])
        by smtp.gmail.com with ESMTPSA id z17sm11930378iol.73.2019.06.30.06.54.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 06:54:49 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/16] sunrpc: add a new cache_detail operation for when a cache is flushed
Date:   Sun, 30 Jun 2019 09:52:25 -0400
Message-Id: <20190630135240.7490-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
References: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

When the exports table is changed, exportfs will usually write a new
time to the "flush" file in the nfsd.export cache procfile. This tells
the kernel to flush any entries that are older than that value.

This gives us a mechanism to tell whether an unexport might have
occurred. Add a new ->flush cache_detail operation that is called after
flushing the cache whenever someone writes to a "flush" file.

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/cache.h | 1 +
 net/sunrpc/cache.c           | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index c7f38e897174..dfa3ab97564a 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -87,6 +87,7 @@ struct cache_detail {
 					      int has_died);
 
 	struct cache_head *	(*alloc)(void);
+	void			(*flush)(void);
 	int			(*match)(struct cache_head *orig, struct cache_head *new);
 	void			(*init)(struct cache_head *orig, struct cache_head *new);
 	void			(*update)(struct cache_head *orig, struct cache_head *new);
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 66fbb9d2fba7..195b46a4a512 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1521,6 +1521,9 @@ static ssize_t write_flush(struct file *file, const char __user *buf,
 	cd->nextcheck = now;
 	cache_flush();
 
+	if (cd->flush)
+		cd->flush();
+
 	*ppos += count;
 	return count;
 }
-- 
2.21.0

