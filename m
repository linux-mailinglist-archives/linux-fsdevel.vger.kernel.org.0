Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5A940DEAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 17:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240380AbhIPPwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 11:52:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32022 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240159AbhIPPwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631807463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ILE8AEREB8TZ6G58cEw5uMQNt+FdD69KNJ799+4U0ss=;
        b=XyTmw2SO8l6vyUZdmwvziJuAAbJ5E0ceMVqybZdLixsdPiedr/aAKvwpFsQWxPpjy31mzB
        672X2HxV42re0nme2C3wU3r+gg24sCf3aekEuLotjVZ1i8zyo7S7Rz7JluuZ3D51+O5uan
        NW71p0GcjbS6mVHDaLI/K9yKTBki8Tk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-TVuuzRMsP0CvOiQEOWXN_Q-1; Thu, 16 Sep 2021 11:51:00 -0400
X-MC-Unique: TVuuzRMsP0CvOiQEOWXN_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CBB2BAF85;
        Thu, 16 Sep 2021 15:50:59 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.32.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A22ED6A902;
        Thu, 16 Sep 2021 15:50:58 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3B581220C99; Thu, 16 Sep 2021 11:50:58 -0400 (EDT)
Date:   Thu, 16 Sep 2021 11:50:58 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        viro@zeniv.linux.org.uk
Cc:     Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        linux kernel mailing list <linux-kernel@vger.kernel.org>,
        xu.xin16@zte.com.cn
Subject: [PATCH v2] init/do_mounts.c: Harden split_fs_names() against buffer
 overflow
Message-ID: <YUNn4k1FCgQmOpuw@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
---
 init/do_mounts.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

Index: redhat-linux/init/do_mounts.c
===================================================================
--- redhat-linux.orig/init/do_mounts.c	2021-09-15 08:46:33.801689806 -0400
+++ redhat-linux/init/do_mounts.c	2021-09-16 11:28:36.753625037 -0400
@@ -338,19 +338,25 @@ __setup("rootflags=", root_data_setup);
 __setup("rootfstype=", fs_names_setup);
 __setup("rootdelay=", root_delay_setup);
 
-static int __init split_fs_names(char *page, char *names)
+static int __init split_fs_names(char *page, size_t size, char *names)
 {
 	int count = 0;
 	char *p = page;
+	bool str_start = false;
 
-	strcpy(p, root_fs_names);
+	strlcpy(p, root_fs_names, size);
 	while (*p++) {
-		if (p[-1] == ',')
+		if (p[-1] == ',') {
 			p[-1] = '\0';
+			count++;
+			str_start = false;
+		} else {
+			str_start = true;
+		}
 	}
-	*p = '\0';
 
-	for (p = page; *p; p += strlen(p)+1)
+	/* Last string which might not be comma terminated */
+	if (str_start)
 		count++;
 
 	return count;
@@ -404,12 +410,16 @@ void __init mount_block_root(char *name,
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
@@ -543,10 +553,12 @@ static int __init mount_nodev_root(void)
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

