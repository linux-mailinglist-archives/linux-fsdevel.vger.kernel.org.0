Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5928B3AB7A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 17:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhFQPj2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 11:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhFQPj2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:39:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F36CC061574;
        Thu, 17 Jun 2021 08:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DKovqRXh4dqmrxQdIruB25dwODhSqd/6TFIr0rlw624=; b=HE4fGjXpjdiOpUEO+Lsb/kA+Ub
        gFpQLwjrVHkgeo3k8zqyi4bwBHPr3uk2aS4pFRvF6mG0+ctn8ZOEFR0Qx2pKSSfjkV2ofRKpfn3BA
        37Y+WbhVovxtZVFjBAKyA+/8F0L7PcLNJ4I92wsM6fKdhOA23wCk7XqC3VpHXVjumkaZ97/JegO3m
        2Nv0cJ3WjhlrT4ll89FaklooveTz8OlTjDyFrFEdSA0RS6BCRmQjCZOHldiITBvHP3a0URB80QqPK
        m+nND6v0qqlzJ8mkW7uPnwSW70BkEnPJmN9dVV6dCGeDrfUwEHnD+SoQQpXnjb8W0AVf/pSBguQuk
        OivMdIxQ==;
Received: from [2001:4bb8:19b:fdce:dccf:26cc:e207:71f6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltu4j-009HvY-5Z; Thu, 17 Jun 2021 15:37:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com
Subject: [PATCH 1/2] init: split get_fs_names
Date:   Thu, 17 Jun 2021 17:36:48 +0200
Message-Id: <20210617153649.1886693-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210617153649.1886693-1-hch@lst.de>
References: <20210617153649.1886693-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split get_fs_names into one function that splits up the command line
argument, and one that gets the list of all registered file systems.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts.c | 48 ++++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 74aede860de7..ec32de3ad52b 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -338,30 +338,31 @@ __setup("rootflags=", root_data_setup);
 __setup("rootfstype=", fs_names_setup);
 __setup("rootdelay=", root_delay_setup);
 
-static void __init get_fs_names(char *page)
+static void __init split_fs_names(char *page, char *names)
 {
-	char *s = page;
-
-	if (root_fs_names) {
-		strcpy(page, root_fs_names);
-		while (*s++) {
-			if (s[-1] == ',')
-				s[-1] = '\0';
-		}
-	} else {
-		int len = get_filesystem_list(page);
-		char *p, *next;
+	strcpy(page, root_fs_names);
+	while (*page++) {
+		if (page[-1] == ',')
+			page[-1] = '\0';
+	}
+	*page = '\0';
+}
 
-		page[len] = '\0';
-		for (p = page-1; p; p = next) {
-			next = strchr(++p, '\n');
-			if (*p++ != '\t')
-				continue;
-			while ((*s++ = *p++) != '\n')
-				;
-			s[-1] = '\0';
-		}
+static void __init get_all_fs_names(char *page)
+{
+	int len = get_filesystem_list(page);
+	char *s = page, *p, *next;
+
+	page[len] = '\0';
+	for (p = page - 1; p; p = next) {
+		next = strchr(++p, '\n');
+		if (*p++ != '\t')
+			continue;
+		while ((*s++ = *p++) != '\n')
+			;
+		s[-1] = '\0';
 	}
+
 	*s = '\0';
 }
 
@@ -411,7 +412,10 @@ void __init mount_block_root(char *name, int flags)
 
 	scnprintf(b, BDEVNAME_SIZE, "unknown-block(%u,%u)",
 		  MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
-	get_fs_names(fs_names);
+	if (root_fs_names)
+		split_fs_names(fs_names, root_fs_names);
+	else
+		get_all_fs_names(fs_names);
 retry:
 	for (p = fs_names; *p; p += strlen(p)+1) {
 		int err = do_mount_root(name, p, flags, root_mount_data);
-- 
2.30.2

