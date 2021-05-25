Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8758390069
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 13:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhEYL7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 07:59:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232026AbhEYL7A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 07:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621943850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gwxlyb+FG0n3r9xn6t0mq/58ppDzosdIiReev7lbhbw=;
        b=QURt+4wp95h1skrYSoI1GE/jDH8acG+Wkg1ihWvaVPZvX1TP626ipErtU7GYDBOfLe3NGK
        J1UxinopTHccGGFmfoMNcGVGcEH2dw7LZF6Z/0GnjNzzWFZWLmmlJe00dWxHuFsMZrIPtL
        OMswDGpVqfKvhTpsnYQsYclqhVqNoCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-LnZV9HMQO4uMWVJ_Fd07lg-1; Tue, 25 May 2021 07:57:27 -0400
X-MC-Unique: LnZV9HMQO4uMWVJ_Fd07lg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3789D108C2AD;
        Tue, 25 May 2021 11:57:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-24.rdu2.redhat.com [10.10.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 738345C1C2;
        Tue, 25 May 2021 11:57:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix the nlink handling of dir-over-dir rename
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 25 May 2021 12:57:24 +0100
Message-ID: <162194384460.3999479.7605572278074191079.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix rename of one directory over another such that the nlink on the deleted
directory is cleared to 0 rather than being decremented to 1.

This was causing the generic/035 xfstest to fail.

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
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


