Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AE23A7815
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 09:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhFOHmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 03:42:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52459 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229788AbhFOHmB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623742797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tf+WxfDAC8RDdxV/HmQmbtlveiKFYYWCFXXFOPqcUcw=;
        b=hPrKv8J9Ee6WBq0UKYf673B7RYlXQhmNhyNINzDwCRIYNmIzu3q3pECs5xl8yDxY9EZ5it
        M+5G3K1wxg8wfX9Mk3Ce4iKEI88Cw5PORomgqcOtjlUz9Y7ZwQ9eApln77H1DpPK+ho8Py
        3ubCYX751FSgF2vq0V717aUKEacP4BM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-WOm38uHMNKmiehy_4UyVfg-1; Tue, 15 Jun 2021 03:39:55 -0400
X-MC-Unique: WOm38uHMNKmiehy_4UyVfg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B82D81084F46;
        Tue, 15 Jun 2021 07:39:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DE005D6DC;
        Tue, 15 Jun 2021 07:39:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix an IS_ERR() vs NULL check
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-afs@lists.infradead.org, dhowells@redhat.com,
        marc.dionne@auristor.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 15 Jun 2021 08:39:52 +0100
Message-ID: <162374279240.549176.3013926133275425458.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

The proc_symlink() function returns NULL on error, it doesn't return
error pointers.

Fixes: 5b86d4ff5dce ("afs: Implement network namespacing")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/YLjMRKX40pTrJvgf@mwanda/
---

 fs/afs/main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/main.c b/fs/afs/main.c
index b2975256dadb..179004b15566 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -203,8 +203,8 @@ static int __init afs_init(void)
 		goto error_fs;
 
 	afs_proc_symlink = proc_symlink("fs/afs", NULL, "../self/net/afs");
-	if (IS_ERR(afs_proc_symlink)) {
-		ret = PTR_ERR(afs_proc_symlink);
+	if (!afs_proc_symlink) {
+		ret = -ENOMEM;
 		goto error_proc;
 	}
 


