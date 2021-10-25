Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4BB438DF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 06:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhJYEHl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 00:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhJYEHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 00:07:40 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045B4C061745;
        Sun, 24 Oct 2021 21:05:18 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 16894100281;
        Mon, 25 Oct 2021 15:05:14 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 30-6G5htNg-C; Mon, 25 Oct 2021 15:05:14 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 06819100328; Mon, 25 Oct 2021 15:05:14 +1100 (AEDT)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        smtp01.aussiebb.com.au
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=10.0 tests=RDNS_NONE autolearn=disabled
        version=3.4.2
Received: from mickey.themaw.net (unknown [100.72.131.210])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 51AAE100281;
        Mon, 25 Oct 2021 15:05:12 +1100 (AEDT)
Subject: [PATCH 1/2] vfs: parse: deal with zero length string value
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 25 Oct 2021 12:05:06 +0800
Message-ID: <163513470696.40352.1069626993439788071.stgit@mickey.themaw.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ian Kent <ikent@redhat.com>

Parsing an fs string that has zero length should result in the parameter
being set to NULL so that downstream processing handles it correctly.
For example, the proc mount table processing should print "(none)" in
this case to preserve mount record field count, but if the value points
to the NULL string this doesn't happen.

Signed-off-by: Ian Kent <ikent@redhat.com>
---
 fs/fs_context.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index b7e43a780a62..a949cceccbfd 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -175,9 +175,13 @@ int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 	};
 
 	if (value) {
-		param.string = kmemdup_nul(value, v_size, GFP_KERNEL);
-		if (!param.string)
-			return -ENOMEM;
+		if (!v_size)
+			param.string = NULL;
+		else {
+			param.string = kmemdup_nul(value, v_size, GFP_KERNEL);
+			if (!param.string)
+				return -ENOMEM;
+		}
 		param.type = fs_value_is_string;
 	}
 


