Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F1F3A7DAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 13:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFOL5n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 07:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42612 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230081AbhFOL5m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623758138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=paJlfJ3NUi9BTJrv4iZ5RAe2NIk2kE19q2VsrD4YODI=;
        b=UW275erfcLhRrWd+EwMK4JILTwHnzEjDlfXdhS+MH6uevyb4Q+De2KeCD3IDAwo7r1aZS8
        79pp4VDq7M4F6LplyeAqdjEuNRt3PEvZxIN52bV4WX4j+mhpVP+ZBxeNNtdnX6o4Bq/rbq
        DnlrpOkG5Ckyjr9GQNTYf+Eio2MhpBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-Colm3IHUP36oStMHJL3tnw-1; Tue, 15 Jun 2021 07:55:36 -0400
X-MC-Unique: Colm3IHUP36oStMHJL3tnw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97B61100C660;
        Tue, 15 Jun 2021 11:55:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6D98620DE;
        Tue, 15 Jun 2021 11:55:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: fix no return statement in function returning non-void
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Hulk Robot <hulkci@huawei.com>,
        Zheng Zengkai <zhengzengkai@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tom Rix <trix@redhat.com>, linux-afs@lists.infradead.org,
        dhowells@redhat.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 15 Jun 2021 12:55:31 +0100
Message-ID: <162375813191.653958.11993495571264748407.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zheng Zengkai <zhengzengkai@huawei.com>

Add missing return to fix following compilation issue:

fs/afs/dir.c: In function ‘afs_dir_set_page_dirty’:
fs/afs/dir.c:51:1: error: no return statement in function
returning non-void [-Werror=return-type]

Fixes: f3ddee8dc4e2 ("afs: Fix directory handling")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
cc: Tom Rix <trix@redhat.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/20210327121624.194639-1-zhengzengkai@huawei.com/
---

 fs/afs/dir.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 78719f2f567e..c31c21afd2e1 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -48,6 +48,7 @@ static void afs_dir_invalidatepage(struct page *page, unsigned int offset,
 static int afs_dir_set_page_dirty(struct page *page)
 {
 	BUG(); /* This should never happen. */
+	return 0;
 }
 
 const struct file_operations afs_dir_file_operations = {


