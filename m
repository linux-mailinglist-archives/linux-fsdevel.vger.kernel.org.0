Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AC93AE31E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 08:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFUGaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 02:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFUGaJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 02:30:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB837C061574;
        Sun, 20 Jun 2021 23:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DKovqRXh4dqmrxQdIruB25dwODhSqd/6TFIr0rlw624=; b=vmChmrOpkXrDUoS765QNJDNtMW
        +MFrH5sQhBciM1NYRgXTrYc/HFecqMy2guREmpktfvJ9Qtnm+2CUoJYfgr7iRJEDJhhp8awR9Wfu4
        sVWObjAnxHwtarFtLHPCblQLAjFbldZlQdr6uZkl5+X7CN6qiQaQbRU7jAS8gyYQg6cSIdP+iYTZC
        +TJ4/Rrc23hrTLlVx0p7OduDAlaW8+DBHl+QyypalntMYMrGi8hHvQhxFxC+q4+WTfsXJcKtV0kuQ
        xQbdzR5pOfAyakspP69Pr1kXd15Cl3intqKSMYFiAExF8ZSECaF7uu24m/uyjZuYz0UcptY+RdXR9
        uqq8FkNg==;
Received: from [2001:4bb8:188:3e21:8988:c934:59d4:cfe6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvDP3-00Cmq8-2w; Mon, 21 Jun 2021 06:27:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com
Subject: [PATCH 1/2] init: split get_fs_names
Date:   Mon, 21 Jun 2021 08:26:56 +0200
Message-Id: <20210621062657.3641879-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621062657.3641879-1-hch@lst.de>
References: <20210621062657.3641879-1-hch@lst.de>
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

