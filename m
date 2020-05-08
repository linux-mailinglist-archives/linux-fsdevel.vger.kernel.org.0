Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2A31CBA8F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 00:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgEHWRZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 18:17:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33690 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728187AbgEHWRZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 18:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588976244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9k5fONXRoGGpUm/+O6b3dtEn9muEjRjeCevuOz1pW/Y=;
        b=DBsnSUokEclrRC3Pph+2SXAupD4KCy++oV7DW5ZD8bbYdHRAJp0fYx+VoZUs5E29ZpLfic
        jlyPsBNRqH/LWeKaFupJew+dpDYwcXPMSf6Zm+FYZEqvpO6VmnLsPhLj4drE8YeRyEOc0m
        n+ZjQdCE/tjpXvUf8R/RZJ0DBBf/CCA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-EZaiUri1MeWzG0HAWIIqRw-1; Fri, 08 May 2020 18:17:22 -0400
X-MC-Unique: EZaiUri1MeWzG0HAWIIqRw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 310681005510;
        Fri,  8 May 2020 22:17:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 019216AD09;
        Fri,  8 May 2020 22:17:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/5] NFS: Fix fscache super_cookie allocation
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 08 May 2020 23:17:13 +0100
Message-ID: <158897623318.1119820.7449630665489854540.stgit@warthog.procyon.org.uk>
In-Reply-To: <158897619675.1119820.2203023452686054109.stgit@warthog.procyon.org.uk>
References: <158897619675.1119820.2203023452686054109.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Wysochanski <dwysocha@redhat.com>

Commit f2aedb713c28 ("NFS: Add fs_context support.") reworked
NFS mount code paths for fs_context support which included
super_block initialization.  In the process there was an extra
return left in the code and so we never call
nfs_fscache_get_super_cookie even if 'fsc' is given on as mount
option.  In addition, there is an extra check inside
nfs_fscache_get_super_cookie for the NFS_OPTION_FSCACHE which
is unnecessary since the only caller nfs_get_cache_cookie
checks this flag.

Fixes: f2aedb713c28 ("NFS: Add fs_context support.")
Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/nfs/fscache.c |    2 --
 fs/nfs/super.c   |    1 -
 2 files changed, 3 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 8eff1fd806b1..f51718415606 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -118,8 +118,6 @@ void nfs_fscache_get_super_cookie(struct super_block *sb, const char *uniq, int
 
 	nfss->fscache_key = NULL;
 	nfss->fscache = NULL;
-	if (!(nfss->options & NFS_OPTION_FSCACHE))
-		return;
 	if (!uniq) {
 		uniq = "";
 		ulen = 1;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 59ef3b13ccca..cc34aa3a8ba4 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1189,7 +1189,6 @@ static void nfs_get_cache_cookie(struct super_block *sb,
 			uniq = ctx->fscache_uniq;
 			ulen = strlen(ctx->fscache_uniq);
 		}
-		return;
 	}
 
 	nfs_fscache_get_super_cookie(sb, uniq, ulen);


