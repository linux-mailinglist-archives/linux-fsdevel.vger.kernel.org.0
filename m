Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F951CBA8B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 00:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgEHWRN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 18:17:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50289 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728142AbgEHWRM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 18:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588976231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UD5XSlgRABZpNQHqOmdLjL/+0BOjmyS50s2XjxLJF1s=;
        b=NLZ1cOk2ivR0cb7eFLbXxpqck7zm3C2UcRsDLKrLb39vIVi7hOlKddO99kr+/Cld1mc9uH
        Ogx37m03Co8YIqr/1adDSoqVO8ElxbVQ/bivInO8gIuGRavy0PbzEVvcvymogjIcPu1xLU
        hURG0YFRC7fhkBNpE7jgprIXjcpsaY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-jBu2rhgDOtqTABtnEkhyIQ-1; Fri, 08 May 2020 18:17:09 -0400
X-MC-Unique: jBu2rhgDOtqTABtnEkhyIQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8BCD475;
        Fri,  8 May 2020 22:17:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99BAF2E183;
        Fri,  8 May 2020 22:17:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/5] NFS: Fix fscache super_cookie index_key from changing
 after umount
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 08 May 2020 23:17:02 +0100
Message-ID: <158897622270.1119820.974990693177541039.stgit@warthog.procyon.org.uk>
In-Reply-To: <158897619675.1119820.2203023452686054109.stgit@warthog.procyon.org.uk>
References: <158897619675.1119820.2203023452686054109.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Wysochanski <dwysocha@redhat.com>

Commit 402cb8dda949 ("fscache: Attach the index key and aux data to
the cookie") added the index_key and index_key_len parameters to
fscache_acquire_cookie(), and updated the callers in the NFS client.
One of the callers was inside nfs_fscache_get_super_cookie()
and was changed to use the full struct nfs_fscache_key as the
index_key.  However, a couple members of this structure contain
pointers and thus will change each time the same NFS share is
remounted.  Since index_key is used for fscache_cookie->key_hash
and this subsequently is used to compare cookies, the effectiveness
of fscache with NFS is reduced to the point at which a umount
occurs.   Any subsequent remount of the same share will cause a
unique NFS super_block index_key and key_hash to be generated for
the same data, rendering any prior fscache data unable to be
found.  A simple reproducer demonstrates the problem.

1. Mount share with 'fsc', create a file, drop page cache
systemctl start cachefilesd
mount -o vers=3,fsc 127.0.0.1:/export /mnt
dd if=/dev/zero of=/mnt/file1.bin bs=4096 count=1
echo 3 > /proc/sys/vm/drop_caches

2. Read file into page cache and fscache, then unmount
dd if=/mnt/file1.bin of=/dev/null bs=4096 count=1
umount /mnt

3. Remount and re-read which should come from fscache
mount -o vers=3,fsc 127.0.0.1:/export /mnt
echo 3 > /proc/sys/vm/drop_caches
dd if=/mnt/file1.bin of=/dev/null bs=4096 count=1

4. Check for READ ops in mountstats - there should be none
grep READ: /proc/self/mountstats

Looking at the history and the removed function, nfs_super_get_key(),
we should only use nfs_fscache_key.key plus any uniquifier, for
the fscache index_key.

Fixes: 402cb8dda949 ("fscache: Attach the index key and aux data to the cookie")
Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/nfs/fscache.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 1abf126c2df4..8eff1fd806b1 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -188,7 +188,8 @@ void nfs_fscache_get_super_cookie(struct super_block *sb, const char *uniq, int
 	/* create a cache index for looking up filehandles */
 	nfss->fscache = fscache_acquire_cookie(nfss->nfs_client->fscache,
 					       &nfs_fscache_super_index_def,
-					       key, sizeof(*key) + ulen,
+					       &key->key,
+					       sizeof(key->key) + ulen,
 					       NULL, 0,
 					       nfss, 0, true);
 	dfprintk(FSCACHE, "NFS: get superblock cookie (0x%p/0x%p)\n",


