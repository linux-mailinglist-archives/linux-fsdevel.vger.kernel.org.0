Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D2A392BB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 12:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbhE0K0L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 06:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49359 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236008AbhE0K0K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 06:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622111077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zD053S+JtGOJd2KF0odlaJPL/U3ZxA8pIk2xD19hKgI=;
        b=UdgEkqsa4CM46+W+OnNipMViUeppoQCshBjDrfva+fSTyGuJifk6EK87wh38SUaWR707jN
        0TJGy6TJ6QFBp21gmBcDX7gScfEWZppZgDZjl3jn8rkE7eJCI7oVkrvKEFAjRqVNI/4+Wq
        EPZdOL3B0TyMkjBBrZDCjnmCwNP5H0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-7Fsq34D_OZG0-EbwWi7VfQ-1; Thu, 27 May 2021 06:24:36 -0400
X-MC-Unique: 7Fsq34D_OZG0-EbwWi7VfQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEB136D4F0;
        Thu, 27 May 2021 10:24:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-24.rdu2.redhat.com [10.10.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2D425D6D3;
        Thu, 27 May 2021 10:24:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix the nlink handling of dir-over-dir rename
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 27 May 2021 11:24:33 +0100
Message-ID: <162211107302.582915.15087790435117657722.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix rename of one directory over another such that the nlink on the deleted
directory is cleared to 0 rather than being decremented to 1.

This was causing the generic/035 xfstest to fail.

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/162194384460.3999479.7605572278074191079.stgit@warthog.procyon.org.uk/ # v1
---

 fs/afs/dir.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 9fbe5a5ec9bd..78719f2f567e 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1919,7 +1919,9 @@ static void afs_rename_edit_dir(struct afs_operation *op)
 	new_inode = d_inode(new_dentry);
 	if (new_inode) {
 		spin_lock(&new_inode->i_lock);
-		if (new_inode->i_nlink > 0)
+		if (S_ISDIR(new_inode->i_mode))
+			clear_nlink(new_inode);
+		else if (new_inode->i_nlink > 0)
 			drop_nlink(new_inode);
 		spin_unlock(&new_inode->i_lock);
 	}


