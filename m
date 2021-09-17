Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5813F40F8E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 15:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbhIQNOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 09:14:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23259 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233882AbhIQNOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 09:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631884408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=930lS4KvYKgd66K5Uz05GiZ4C4QUjCLMki7qZuPZ1rI=;
        b=G+nnayXiK1O2+4DqfXAtneApJU2tJSzrzJGKVUOCa7zzt6TYKxQ1sCJUdjed0vptEfwtCY
        zHTYCaZvN+fqQdvoTz8AfPVEPNHzfAXETaAvn9OBKhPaR3egIbYMUpypNfjskJvrwOSQVI
        GGU0vl/2g5iFx/VtYMbdM84Zz4RlZ4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-52NA16V5N9OzLHxwkxK1PQ-1; Fri, 17 Sep 2021 09:13:25 -0400
X-MC-Unique: 52NA16V5N9OzLHxwkxK1PQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4326F801B3D;
        Fri, 17 Sep 2021 13:13:24 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.32.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 234225C1A1;
        Fri, 17 Sep 2021 13:13:24 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id AAE0A220C99; Fri, 17 Sep 2021 09:13:23 -0400 (EDT)
Date:   Fri, 17 Sep 2021 09:13:23 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        viro@zeniv.linux.org.uk
Cc:     Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        linux kernel mailing list <linux-kernel@vger.kernel.org>,
        xu.xin16@zte.com.cn, christian.brauner@ubuntu.com
Subject: [PATCH v3] init/do_mounts.c: Harden split_fs_names() against buffer
 overflow
Message-ID: <YUSUc7AyCq/P3SLR@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

split_fs_names() currently takes comma separate list of filesystems
and converts it into individual filesystem strings. Pleaces these
strings in the input buffer passed by caller and returns number of
strings.

If caller manages to pass input string bigger than buffer, then we
can write beyond the buffer. Or if string just fits buffer, we will
still write beyond the buffer as we append a '\0' byte at the end.

Pass size of input buffer to split_fs_names() and put enough checks
in place so such buffer overrun possibilities do not occur.

This patch does few things.

- Add a parameter "size" to split_fs_names(). This specifies size
  of input buffer.

- Use strlcpy() (instead of strcpy()) so that we can't go beyond
  buffer size. If input string "names" is larger than passed in
  buffer, input string will be truncated to fit in buffer.

- Stop appending extra '\0' character at the end and avoid one
  possibility of going beyond the input buffer size.

- Do not use extra loop to count number of strings.

- Previously if one passed "rootfstype=foo,,bar", split_fs_names()
  will return only 1 string "foo" (and "bar" will be truncated
  due to extra ,). After this patch, now split_fs_names() will
  return 3 strings ("foo", zero-sized-string, and "bar").

  Callers of split_fs_names() have been modified to check for
  zero sized string and skip to next one.

Reported-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
Changes from v2:
- Got rid of str_start variable. (Jan Kara)
---
 init/do_mounts.c |   27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

Index: redhat-linux/init/do_mounts.c
===================================================================
--- redhat-linux.orig/init/do_mounts.c	2021-09-15 08:46:33.801689806 -0400
+++ redhat-linux/init/do_mounts.c	2021-09-17 08:44:40.781430167 -0400
@@ -338,20 +338,19 @@ __setup("rootflags=", root_data_setup);
 __setup("rootfstype=", fs_names_setup);
 __setup("rootdelay=", root_delay_setup);
 
-static int __init split_fs_names(char *page, char *names)
+/* This can return zero length strings. Caller should check */
+static int __init split_fs_names(char *page, size_t size, char *names)
 {
-	int count = 0;
+	int count = 1;
 	char *p = page;
 
-	strcpy(p, root_fs_names);
+	strlcpy(p, root_fs_names, size);
 	while (*p++) {
-		if (p[-1] == ',')
+		if (p[-1] == ',') {
 			p[-1] = '\0';
+			count++;
+		}
 	}
-	*p = '\0';
-
-	for (p = page; *p; p += strlen(p)+1)
-		count++;
 
 	return count;
 }
@@ -404,12 +403,16 @@ void __init mount_block_root(char *name,
 	scnprintf(b, BDEVNAME_SIZE, "unknown-block(%u,%u)",
 		  MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
 	if (root_fs_names)
-		num_fs = split_fs_names(fs_names, root_fs_names);
+		num_fs = split_fs_names(fs_names, PAGE_SIZE, root_fs_names);
 	else
 		num_fs = list_bdev_fs_names(fs_names, PAGE_SIZE);
 retry:
 	for (i = 0, p = fs_names; i < num_fs; i++, p += strlen(p)+1) {
-		int err = do_mount_root(name, p, flags, root_mount_data);
+		int err;
+
+		if (!*p)
+			continue;
+		err = do_mount_root(name, p, flags, root_mount_data);
 		switch (err) {
 			case 0:
 				goto out;
@@ -543,10 +546,12 @@ static int __init mount_nodev_root(void)
 	fs_names = (void *)__get_free_page(GFP_KERNEL);
 	if (!fs_names)
 		return -EINVAL;
-	num_fs = split_fs_names(fs_names, root_fs_names);
+	num_fs = split_fs_names(fs_names, PAGE_SIZE, root_fs_names);
 
 	for (i = 0, fstype = fs_names; i < num_fs;
 	     i++, fstype += strlen(fstype) + 1) {
+		if (!*fstype)
+			continue;
 		if (!fs_is_nodev(fstype))
 			continue;
 		err = do_mount_root(root_device_name, fstype, root_mountflags,

