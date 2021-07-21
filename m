Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F08A3D0DCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 13:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbhGUKxM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 06:53:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20628 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240538AbhGUKud (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626867063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oA30pC+NLPNjhuZMIyTOnYWru5jXEULhx+1Gh+KaFPk=;
        b=Heicmh4CDdy6/AEz8JkRjTOOQ7PWoFLErGjbSjSun6pAbBpge04CO9lrIttPTVV7BPepjO
        q+Zl5iQWpc7DPidKkAwRqyW2rcjkmMqW7RjXYZveDUJZFcX5yPvUP3AfH54vbCELlgrtwG
        C4ciLlUZp1lkKEP6e4aQjOhqAD4KC/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-1qlpE8gePdOBqdgerNxxhg-1; Wed, 21 Jul 2021 07:31:01 -0400
X-MC-Unique: 1qlpE8gePdOBqdgerNxxhg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1470802B56;
        Wed, 21 Jul 2021 11:31:00 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.33.36.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0260C5C225;
        Wed, 21 Jul 2021 11:30:59 +0000 (UTC)
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] vfs: parse sloppy mount option in correct order
Date:   Wed, 21 Jul 2021 13:30:57 +0200
Message-Id: <20210721113057.993344-1-rbergant@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With addition of fs_context support, options string is parsed
sequentially, if 'sloppy' option is not leftmost one, we may
return ENOPARAM to userland if a non-valid option preceeds sloopy
and mount will fail :

host# mount -o quota,sloppy 172.23.1.225:/share /mnt
mount.nfs: an incorrect mount option was specified
host# mount -o sloppy,quota 172.23.1.225:/share /mnt
host#

This patch correct that behaviour so that sloppy takes precedence
if specified anywhere on the string

Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
---
 fs/fs_context.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index de1985eae535..f930808e9db8 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -210,8 +210,12 @@ int generic_parse_monolithic(struct fs_context *fc, void *data)
 	if (ret)
 		return ret;
 
+	/* 'sloppy' should be parsed first */
+	if (strstr((const char *)data, "sloppy") != NULL)
+		vfs_parse_fs_string(fc, "sloppy", NULL, 0);
+
 	while ((key = strsep(&options, ",")) != NULL) {
-		if (*key) {
+		if (*key && strcmp(key, "sloppy")) {
 			size_t v_len = 0;
 			char *value = strchr(key, '=');
 
-- 
2.31.1

