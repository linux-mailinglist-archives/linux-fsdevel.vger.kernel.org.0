Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4FD2E0144
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 20:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgLUTwq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 14:52:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25888 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726547AbgLUTwq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 14:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608580280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i+Wu06QQA8V7H5DaVe6ll9ITIbYelVgG1MNXlVmRWcw=;
        b=MLsjyUQW18vxgNcolQMv24EuJ8gKU9DNjk813qR/otgRjZVJieUa0at5JcrX6ilgrk0L3Y
        M4ItrihH/q2dDXULi+DGnzvAlso6j/SVV1JbkF+HDQ1dUqap9OShWDw9bdMiCIuevoPv6T
        MSDRJS2wt7mnDAj1na8+ag+Of9embA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-GHupDSMONC-1jwPNcKH0XA-1; Mon, 21 Dec 2020 14:51:15 -0500
X-MC-Unique: GHupDSMONC-1jwPNcKH0XA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 556BF801817;
        Mon, 21 Dec 2020 19:51:13 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-244.rdu2.redhat.com [10.10.114.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9ED9619D9C;
        Mon, 21 Dec 2020 19:51:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 30DA3223D99; Mon, 21 Dec 2020 14:51:11 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc:     jlayton@kernel.org, vgoyal@redhat.com, amir73il@gmail.com,
        sargun@sargun.me, miklos@szeredi.hu, willy@infradead.org,
        jack@suse.cz, neilb@suse.com, viro@zeniv.linux.org.uk, hch@lst.de
Subject: [PATCH 2/3] vfs: Add a super block operation to check for writeback errors
Date:   Mon, 21 Dec 2020 14:50:54 -0500
Message-Id: <20201221195055.35295-3-vgoyal@redhat.com>
In-Reply-To: <20201221195055.35295-1-vgoyal@redhat.com>
References: <20201221195055.35295-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Right now we check for errors on super block in syncfs().

ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);

overlayfs does not update sb->s_wb_err and it is tracked on upper filesystem.
So provide a superblock operation to check errors so that filesystem
can provide override generic method and provide its own method to
check for writeback errors.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/sync.c          | 5 ++++-
 include/linux/fs.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/sync.c b/fs/sync.c
index b5fb83a734cd..57e43a16dfca 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -176,7 +176,10 @@ SYSCALL_DEFINE1(syncfs, int, fd)
 	ret = sync_filesystem(sb);
 	up_read(&sb->s_umount);
 
-	ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
+	if (sb->s_op->errseq_check_advance)
+		ret2 = sb->s_op->errseq_check_advance(sb, f.file);
+	else
+		ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
 
 	fdput(f);
 	return ret ? ret : ret2;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8667d0cdc71e..4297b6127adf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1965,6 +1965,7 @@ struct super_operations {
 				  struct shrink_control *);
 	long (*free_cached_objects)(struct super_block *,
 				    struct shrink_control *);
+	int (*errseq_check_advance)(struct super_block *, struct file *);
 };
 
 /*
-- 
2.25.4

