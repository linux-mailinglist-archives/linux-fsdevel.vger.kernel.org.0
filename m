Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F0C2929D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 16:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgJSO5G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 10:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729674AbgJSO5F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603119424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zrEIfu12NEWVecQ6Z16uwfeUy5I8qXOuPBoK3cMjnXU=;
        b=eMMW/vTkmdN2gl4D42v0g2R35elXKQwH0hXfJXMwlnBp5kSetbtCju8+kqZYXmzDCThA8U
        w5KoU2FIhhCt2AwnKopTNVrBdaAenBigpXbKZqzRVWE9Kaz4HbX2HZ9VCisKEwpvsu12yb
        nTGWCe21hoHjwVIPJksTtEz2GRTWXuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-PTRCdDWGOpmzn0eRYGSE7Q-1; Mon, 19 Oct 2020 10:56:58 -0400
X-MC-Unique: PTRCdDWGOpmzn0eRYGSE7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3673518829E2;
        Mon, 19 Oct 2020 14:56:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C594855770;
        Mon, 19 Oct 2020 14:56:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] cachefiles: Drop superfluous readpages aops NULL check
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Takashi Iwai <tiwai@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        dhowells@redhat.com, dwysocha@redhat.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 19 Oct 2020 15:56:54 +0100
Message-ID: <160311941493.2265023.9116264838885193100.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

After the recent actions to convert readpages aops to readahead, the
NULL checks of readpages aops in cachefiles_read_or_alloc_page() may
hit falsely.  More badly, it's an ASSERT() call, and this panics.

Drop the superfluous NULL checks for fixing this regression.

[DH: Note that cachefiles never actually used readpages, so this check was
 never actually necessary]

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=208883
BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1175245
Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesystem")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
---

 fs/cachefiles/rdwr.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 3080cda9e824..5b4cee71fa32 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -412,7 +412,6 @@ int cachefiles_read_or_alloc_page(struct fscache_retrieval *op,
 
 	inode = d_backing_inode(object->backer);
 	ASSERT(S_ISREG(inode->i_mode));
-	ASSERT(inode->i_mapping->a_ops->readpages);
 
 	/* calculate the shift required to use bmap */
 	shift = PAGE_SHIFT - inode->i_sb->s_blocksize_bits;
@@ -712,7 +711,6 @@ int cachefiles_read_or_alloc_pages(struct fscache_retrieval *op,
 
 	inode = d_backing_inode(object->backer);
 	ASSERT(S_ISREG(inode->i_mode));
-	ASSERT(inode->i_mapping->a_ops->readpages);
 
 	/* calculate the shift required to use bmap */
 	shift = PAGE_SHIFT - inode->i_sb->s_blocksize_bits;


