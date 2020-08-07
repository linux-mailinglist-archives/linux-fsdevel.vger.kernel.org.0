Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D7323F364
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 21:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgHGT5O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 15:57:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24431 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726664AbgHGTzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596830150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Vt4OYUmY+cg0HEFATX9XeJVvApvCT7zrfmElMLSgMc=;
        b=UrtXko359PrGjTY6gptwk/uWu9eP8iR8YDMxiPAWQ146IOftjUASjvCxmlM9N1CSnmPWFu
        gSKjwfsIdzfdzFmMiWglWhQ5lRUCh6EPgSCuyRFdBhrcseuiK/DnRckKc6yB7qn1j8OTaa
        ejHnbrBDZTJB+u1RXdSqw8PrAl7K0UQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-FJwWHB0uPeCITfWcL7KA4w-1; Fri, 07 Aug 2020 15:55:48 -0400
X-MC-Unique: FJwWHB0uPeCITfWcL7KA4w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAC011902EA7;
        Fri,  7 Aug 2020 19:55:47 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-142.rdu2.redhat.com [10.10.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A93802DE7E;
        Fri,  7 Aug 2020 19:55:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 35F55222E61; Fri,  7 Aug 2020 15:55:39 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com
Subject: [PATCH v2 19/20] fuse: Take inode lock for dax inode truncation
Date:   Fri,  7 Aug 2020 15:55:25 -0400
Message-Id: <20200807195526.426056-20-vgoyal@redhat.com>
In-Reply-To: <20200807195526.426056-1-vgoyal@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a file is opened with O_TRUNC, we need to make sure that any other
DAX operation is not in progress. DAX expects i_size to be stable.

In fuse_iomap_begin() we check for i_size at multiple places and we expect
i_size to not change.

Another problem is, if we setup a mapping in fuse_iomap_begin(), and
file gets truncated and dax read/write happens, KVM currently hangs.
It tries to fault in a page which does not exist on host (file got
truncated). It probably requries fixing in KVM.

So for now, take inode lock. Once KVM is fixed, we might have to
have a look at it again.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 605976a586c2..f103355bf71f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -467,7 +467,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 	int err;
 	bool is_wb_truncate = (file->f_flags & O_TRUNC) &&
 			  fc->atomic_o_trunc &&
-			  fc->writeback_cache;
+			  (fc->writeback_cache || IS_DAX(inode));
 
 	err = generic_file_open(inode, file);
 	if (err)
-- 
2.25.4

