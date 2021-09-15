Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3308340C832
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 17:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbhIOPXy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 11:23:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40727 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234300AbhIOPXx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631719353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Ekmwk3OztOf0647iP1EhnCMT1OsTFbXB30u374i/AVo=;
        b=e/oZkWGCwNlLTrEOCq462sndX4EFw/L0oZikLDunvWzFnzgBazIHzgvIfp27F99tACf4hd
        kx3VRfIPBKGSZvown/hgGJVtsXl4hu3zBb2KW0g/98JtBudgfX7UeLpLAruEsZFcYT98GW
        7RU36MPnVJUe2PJQ9DfxaosZzAIxRa4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-g4daYCpBPySJB6TQPbJPOg-1; Wed, 15 Sep 2021 11:22:29 -0400
X-MC-Unique: g4daYCpBPySJB6TQPbJPOg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50EC1BD047;
        Wed, 15 Sep 2021 15:22:05 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C500519736;
        Wed, 15 Sep 2021 15:22:04 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 2B6FD220C99; Wed, 15 Sep 2021 11:22:04 -0400 (EDT)
Date:   Wed, 15 Sep 2021 11:22:04 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, xu.xin16@zte.com.cn,
        Christoph Hellwig <hch@infradead.org>, zhang.yunkai@zte.com.cn
Subject: [PATCH] init/do_mounts.c: Harden split_fs_names() against buffer
 overflow
Message-ID: <YUIPnPV2ttOHNIcX@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

split_fs_names() currently takes comma separated list of filesystems
and converts it into individual filesystem strings. Pleaces these
strings in the input buffer passed by caller and returns number of
strings.

If caller manages to pass input string bigger than buffer, then we
can write beyond the buffer. Or if string just fits buffer, we will
still write beyond the buffer as we append a '\0' byte at the end.

Will be nice to pass size of input buffer to split_fs_names() and
put enough checks in place so such buffer overrun possibilities
do not occur.

Hence this patch adds "size" parameter to split_fs_names() and makes
sure we do not access memory beyond size. If input string "names"
is larger than passed in buffer, input string will be truncated to
fit in buffer.

Reported-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 init/do_mounts.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

Index: redhat-linux/init/do_mounts.c
===================================================================
--- redhat-linux.orig/init/do_mounts.c	2021-09-15 08:46:33.801689806 -0400
+++ redhat-linux/init/do_mounts.c	2021-09-15 09:52:09.884449718 -0400
@@ -338,19 +338,20 @@ __setup("rootflags=", root_data_setup);
 __setup("rootfstype=", fs_names_setup);
 __setup("rootdelay=", root_delay_setup);
 
-static int __init split_fs_names(char *page, char *names)
+static int __init split_fs_names(char *page, size_t size, char *names)
 {
 	int count = 0;
-	char *p = page;
+	char *p = page, *end = page + size - 1;
+
+	strncpy(p, root_fs_names, size);
+	*end = '\0';
 
-	strcpy(p, root_fs_names);
 	while (*p++) {
 		if (p[-1] == ',')
 			p[-1] = '\0';
 	}
-	*p = '\0';
 
-	for (p = page; *p; p += strlen(p)+1)
+	for (p = page; p < end && *p; p += strlen(p)+1)
 		count++;
 
 	return count;
@@ -404,7 +405,7 @@ void __init mount_block_root(char *name,
 	scnprintf(b, BDEVNAME_SIZE, "unknown-block(%u,%u)",
 		  MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
 	if (root_fs_names)
-		num_fs = split_fs_names(fs_names, root_fs_names);
+		num_fs = split_fs_names(fs_names, PAGE_SIZE, root_fs_names);
 	else
 		num_fs = list_bdev_fs_names(fs_names, PAGE_SIZE);
 retry:
@@ -543,7 +544,7 @@ static int __init mount_nodev_root(void)
 	fs_names = (void *)__get_free_page(GFP_KERNEL);
 	if (!fs_names)
 		return -EINVAL;
-	num_fs = split_fs_names(fs_names, root_fs_names);
+	num_fs = split_fs_names(fs_names, PAGE_SIZE, root_fs_names);
 
 	for (i = 0, fstype = fs_names; i < num_fs;
 	     i++, fstype += strlen(fstype) + 1) {

