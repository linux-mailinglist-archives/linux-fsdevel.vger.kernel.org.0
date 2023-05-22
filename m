Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1C370C047
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 15:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbjEVNxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 09:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjEVNw3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 09:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB163102
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 06:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684763477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bxp9/2gLZL2I594j4SxMybgCNb+qE9Rj6mhPK/7tAtY=;
        b=CKOxLOMINd3Nd4RwfJzO/I9u4sQrHHR67lkfRvQaFRlPntMTF+FmFWWwDqeOZvstkBStDp
        ZqWXfDydGmma64anU1cg3AjICa+oGSvsEhMU03OgmcTn1l3c24n0WnS6RSH9emgtk5IACB
        YyeCoyJpzSGP3nNgeWB35rUNJ6Rv/cI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-bixELT5tPzuTZyhz1OURlQ-1; Mon, 22 May 2023 09:51:13 -0400
X-MC-Unique: bixELT5tPzuTZyhz1OURlQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1A3B2812942;
        Mon, 22 May 2023 13:51:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5F7D200B415;
        Mon, 22 May 2023 13:51:09 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v22 12/31] tty, proc, kernfs, random: Use copy_splice_read()
Date:   Mon, 22 May 2023 14:49:59 +0100
Message-Id: <20230522135018.2742245-13-dhowells@redhat.com>
In-Reply-To: <20230522135018.2742245-1-dhowells@redhat.com>
References: <20230522135018.2742245-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use copy_splice_read() for tty, procfs, kernfs and random files rather
than going through generic_file_splice_read() as they just copy the file
into the output buffer and don't splice pages.  This avoids the need for
them to have a ->read_folio() to satisfy filemap_splice_read().

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: John Hubbard <jhubbard@nvidia.com>
cc: David Hildenbrand <david@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: Arnd Bergmann <arnd@arndb.de>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 drivers/char/random.c | 4 ++--
 drivers/tty/tty_io.c  | 4 ++--
 fs/kernfs/file.c      | 2 +-
 fs/proc/inode.c       | 4 ++--
 fs/proc/proc_sysctl.c | 2 +-
 fs/proc_namespace.c   | 6 +++---
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 253f2ddb8913..3cb37760dfec 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1546,7 +1546,7 @@ const struct file_operations random_fops = {
 	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
-	.splice_read = generic_file_splice_read,
+	.splice_read = copy_splice_read,
 	.splice_write = iter_file_splice_write,
 };
 
@@ -1557,7 +1557,7 @@ const struct file_operations urandom_fops = {
 	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
-	.splice_read = generic_file_splice_read,
+	.splice_read = copy_splice_read,
 	.splice_write = iter_file_splice_write,
 };
 
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index c84be40fb8df..4737a8f92c2e 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -466,7 +466,7 @@ static const struct file_operations tty_fops = {
 	.llseek		= no_llseek,
 	.read_iter	= tty_read,
 	.write_iter	= tty_write,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= copy_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.poll		= tty_poll,
 	.unlocked_ioctl	= tty_ioctl,
@@ -481,7 +481,7 @@ static const struct file_operations console_fops = {
 	.llseek		= no_llseek,
 	.read_iter	= tty_read,
 	.write_iter	= redirected_tty_write,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= copy_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.poll		= tty_poll,
 	.unlocked_ioctl	= tty_ioctl,
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 40c4661f15b7..180906c36f51 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -1011,7 +1011,7 @@ const struct file_operations kernfs_file_fops = {
 	.release	= kernfs_fop_release,
 	.poll		= kernfs_fop_poll,
 	.fsync		= noop_fsync,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= copy_splice_read,
 	.splice_write	= iter_file_splice_write,
 };
 
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index f495fdb39151..67b09a1d9433 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -591,7 +591,7 @@ static const struct file_operations proc_iter_file_ops = {
 	.llseek		= proc_reg_llseek,
 	.read_iter	= proc_reg_read_iter,
 	.write		= proc_reg_write,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= copy_splice_read,
 	.poll		= proc_reg_poll,
 	.unlocked_ioctl	= proc_reg_unlocked_ioctl,
 	.mmap		= proc_reg_mmap,
@@ -617,7 +617,7 @@ static const struct file_operations proc_reg_file_ops_compat = {
 static const struct file_operations proc_iter_file_ops_compat = {
 	.llseek		= proc_reg_llseek,
 	.read_iter	= proc_reg_read_iter,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= copy_splice_read,
 	.write		= proc_reg_write,
 	.poll		= proc_reg_poll,
 	.unlocked_ioctl	= proc_reg_unlocked_ioctl,
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 8038833ff5b0..ae832e982003 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -868,7 +868,7 @@ static const struct file_operations proc_sys_file_operations = {
 	.poll		= proc_sys_poll,
 	.read_iter	= proc_sys_read,
 	.write_iter	= proc_sys_write,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= copy_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.llseek		= default_llseek,
 };
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 846f9455ae22..250eb5bf7b52 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -324,7 +324,7 @@ static int mountstats_open(struct inode *inode, struct file *file)
 const struct file_operations proc_mounts_operations = {
 	.open		= mounts_open,
 	.read_iter	= seq_read_iter,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= copy_splice_read,
 	.llseek		= seq_lseek,
 	.release	= mounts_release,
 	.poll		= mounts_poll,
@@ -333,7 +333,7 @@ const struct file_operations proc_mounts_operations = {
 const struct file_operations proc_mountinfo_operations = {
 	.open		= mountinfo_open,
 	.read_iter	= seq_read_iter,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= copy_splice_read,
 	.llseek		= seq_lseek,
 	.release	= mounts_release,
 	.poll		= mounts_poll,
@@ -342,7 +342,7 @@ const struct file_operations proc_mountinfo_operations = {
 const struct file_operations proc_mountstats_operations = {
 	.open		= mountstats_open,
 	.read_iter	= seq_read_iter,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= copy_splice_read,
 	.llseek		= seq_lseek,
 	.release	= mounts_release,
 };

