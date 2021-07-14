Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FD13C9202
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 22:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbhGNU0n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 16:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39381 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235103AbhGNU0m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626294230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GD652Dv0mO/EqFC8MlYZcI3PTfmYv/h39ouJ4ycGzec=;
        b=cGua1vPLZqBgxhXLitQ32TFPW61pM0Nv3UlqtKm6YQx/RC2gsOvhca0UFpp72+0Ntc+iKw
        mT91AgJOyF/SdzUfP93RURLJsf9usS4arYBHfSXSWMAjqej565V/eJNULPLXlo3p7jsLmX
        rRABsZW/xYqkL9ycwnN9GXwO7kApwEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-A9qbPfj_NXuVRandrNoQcw-1; Wed, 14 Jul 2021 16:23:48 -0400
X-MC-Unique: A9qbPfj_NXuVRandrNoQcw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAB8F612D9;
        Wed, 14 Jul 2021 20:23:41 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-201.rdu2.redhat.com [10.10.114.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB83B10074F8;
        Wed, 14 Jul 2021 20:23:40 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 5F978226A1B; Wed, 14 Jul 2021 16:23:40 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, virtio-fs@redhat.com,
        v9fs-developer@lists.sourceforge.net, stefanha@redhat.com,
        miklos@szeredi.hu
Subject: [PATCH v3 1/3] init: split get_fs_names
Date:   Wed, 14 Jul 2021 16:23:19 -0400
Message-Id: <20210714202321.59729-2-vgoyal@redhat.com>
In-Reply-To: <20210714202321.59729-1-vgoyal@redhat.com>
References: <20210714202321.59729-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

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
2.31.1

