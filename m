Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359531F406B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 18:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbgFIQNo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 12:13:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42869 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731163AbgFIQNl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591719220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U5NH97ZcwEvgcbggB5cCoStGuDG8xCBT7rh0SCpAdEE=;
        b=PEuRLxIFrajIE7iMdDL/V/Y9C8KsXfHa8JgG2LKv+ZaPAvFQS3+yDvd3uCBExsK7m3/gVr
        jGdqBk2Ia/ZOOOoec/QCwsSptFiq5piepNpz5mcra26zXDRPZrx0KGS5PaUK9tSblfSwgY
        fg8PGWjDDAy8T9tYGcVngX7KkDa7/K0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-wdOCNE_SOFmOVkJqu5AyHg-1; Tue, 09 Jun 2020 12:13:36 -0400
X-MC-Unique: wdOCNE_SOFmOVkJqu5AyHg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D3388014D4;
        Tue,  9 Jun 2020 16:13:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5982360C87;
        Tue,  9 Jun 2020 16:13:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/6] afs: Fix debugging statements with %px to be %p
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Kees Cook <keescook@chromium.org>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Jun 2020 17:13:33 +0100
Message-ID: <159171921360.3038039.10494245358653942664.stgit@warthog.procyon.org.uk>
In-Reply-To: <159171918506.3038039.10915051218779105094.stgit@warthog.procyon.org.uk>
References: <159171918506.3038039.10915051218779105094.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix a couple of %px to be %x in debugging statements.

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Fixes: 8a070a964877 ("afs: Detect cell aliases 1 - Cells with root volumes")
Reported-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c      |    2 +-
 fs/afs/vl_alias.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 25cbe0aeeec5..aa1d34141ea3 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -980,7 +980,7 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 	if (!IS_ERR_OR_NULL(inode))
 		fid = AFS_FS_I(inode)->fid;
 
-	_debug("splice %px", dentry->d_inode);
+	_debug("splice %p", dentry->d_inode);
 	d = d_splice_alias(inode, dentry);
 	if (!IS_ERR_OR_NULL(d)) {
 		d->d_fsdata = dentry->d_fsdata;
diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
index 136fc6164e00..5082ef04e99c 100644
--- a/fs/afs/vl_alias.c
+++ b/fs/afs/vl_alias.c
@@ -28,7 +28,7 @@ static struct afs_volume *afs_sample_volume(struct afs_cell *cell, struct key *k
 	};
 
 	volume = afs_create_volume(&fc);
-	_leave(" = %px", volume);
+	_leave(" = %p", volume);
 	return volume;
 }
 


