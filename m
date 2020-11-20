Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1842C2BADDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgKTPKm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:10:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54326 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728666AbgKTPKl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GHC1Y4EPbSKYW62n1FidQXRKA53vRUJFmWg0w3l9EZY=;
        b=T01Chx0C01VDHg/pZFalgh6m3IWmv3bI0QmQmjODLHeAVjjrgMRO+wx0Y+Yaaysyos2vTt
        pvcyvz8GzRsSPHGSgaQc2JHqiDGCL41Zjtvd+VY71glBS9EzoOlNKiSxduOXZIhv5teoDh
        lFkhrJnRScr2zy4l3HlgmkQMfAC6RqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-2ldpRSTSOwur7TZfp5VZ3w-1; Fri, 20 Nov 2020 10:10:35 -0500
X-MC-Unique: 2ldpRSTSOwur7TZfp5VZ3w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D7628797F3;
        Fri, 20 Nov 2020 15:10:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75B565C22B;
        Fri, 20 Nov 2020 15:10:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 36/76] cachefiles: Remove some redundant checks on
 unsigned values
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:10:26 +0000
Message-ID: <160588502662.3465195.3229574373260266355.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove some redundant checks for unsigned values being >= 0.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/bind.c   |    6 ++----
 fs/cachefiles/daemon.c |    6 +++---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index a39e65d5103b..c89a422fd1d1 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -36,13 +36,11 @@ int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args)
 	       args);
 
 	/* start by checking things over */
-	ASSERT(cache->fstop_percent >= 0 &&
-	       cache->fstop_percent < cache->fcull_percent &&
+	ASSERT(cache->fstop_percent < cache->fcull_percent &&
 	       cache->fcull_percent < cache->frun_percent &&
 	       cache->frun_percent  < 100);
 
-	ASSERT(cache->bstop_percent >= 0 &&
-	       cache->bstop_percent < cache->bcull_percent &&
+	ASSERT(cache->bstop_percent < cache->bcull_percent &&
 	       cache->bcull_percent < cache->brun_percent &&
 	       cache->brun_percent  < 100);
 
diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 8a937d6d5e22..e8ab3ab57147 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -221,7 +221,7 @@ static ssize_t cachefiles_daemon_write(struct file *file,
 	if (test_bit(CACHEFILES_DEAD, &cache->flags))
 		return -EIO;
 
-	if (datalen < 0 || datalen > PAGE_SIZE - 1)
+	if (datalen > PAGE_SIZE - 1)
 		return -EOPNOTSUPP;
 
 	/* drag the command string into the kernel so we can parse it */
@@ -378,7 +378,7 @@ static int cachefiles_daemon_fstop(struct cachefiles_cache *cache, char *args)
 	if (args[0] != '%' || args[1] != '\0')
 		return -EINVAL;
 
-	if (fstop < 0 || fstop >= cache->fcull_percent)
+	if (fstop >= cache->fcull_percent)
 		return cachefiles_daemon_range_error(cache, args);
 
 	cache->fstop_percent = fstop;
@@ -450,7 +450,7 @@ static int cachefiles_daemon_bstop(struct cachefiles_cache *cache, char *args)
 	if (args[0] != '%' || args[1] != '\0')
 		return -EINVAL;
 
-	if (bstop < 0 || bstop >= cache->bcull_percent)
+	if (bstop >= cache->bcull_percent)
 		return cachefiles_daemon_range_error(cache, args);
 
 	cache->bstop_percent = bstop;


