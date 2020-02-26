Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7A48170400
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 17:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgBZQPR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 11:15:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32575 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727902AbgBZQPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582733714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=uBXR1+O6Y9T5wb3u6HFevKde6rNHuDZ/iFf4G1XU/gM=;
        b=KkK1UadiKTpNJb4R6jaOyVey+tA3gz6+obGki7XOP+b2nmqf8r8ZIikmHyPvax8HI5EZsV
        78XdcIO0LTayxrQzLkbht6Ky++yIdq3h673rI8jvPzq7Q5I9zaMs3FgoxdHWL+ftwYzmui
        hMN6YsqlY5BmEo7j2Kae81zJ8RoDG/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-u4MJdIEmNNyJHCy2hu9kuA-1; Wed, 26 Feb 2020 11:15:09 -0500
X-MC-Unique: u4MJdIEmNNyJHCy2hu9kuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AEA51084430;
        Wed, 26 Feb 2020 16:15:07 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F6A760BE1;
        Wed, 26 Feb 2020 16:15:05 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 02/11] fs/dcache: Simplify __dentry_kill()
Date:   Wed, 26 Feb 2020 11:13:55 -0500
Message-Id: <20200226161404.14136-3-longman@redhat.com>
In-Reply-To: <20200226161404.14136-1-longman@redhat.com>
References: <20200226161404.14136-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the new d_in_lru() helper function to simplify __dentry_kill() a bit.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/dcache.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c17b538bf41c..a977f9e05840 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -572,10 +572,9 @@ static void __dentry_kill(struct dentry *dentry)
 	if (dentry->d_flags & DCACHE_OP_PRUNE)
 		dentry->d_op->d_prune(dentry);
 
-	if (dentry->d_flags & DCACHE_LRU_LIST) {
-		if (!(dentry->d_flags & DCACHE_SHRINK_LIST))
-			d_lru_del(dentry);
-	}
+	if (d_in_lru(dentry))
+		d_lru_del(dentry);
+
 	/* if it was on the hash then remove it */
 	__d_drop(dentry);
 	dentry_unlist(dentry, parent);
-- 
2.18.1

