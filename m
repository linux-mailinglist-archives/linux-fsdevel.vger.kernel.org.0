Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBEB54F074
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 07:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379829AbiFQFPG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 01:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379711AbiFQFPF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:15:05 -0400
Received: from smtp03.aussiebb.com.au (2403-5800-3-25--1003.ip6.aussiebb.net [IPv6:2403:5800:3:25::1003])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9630063BE8;
        Thu, 16 Jun 2022 22:15:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp03.aussiebb.com.au (Postfix) with ESMTP id CC5211A0081;
        Fri, 17 Jun 2022 15:09:04 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp03.aussiebb.com.au
Received: from smtp03.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp03.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bDvF_O3hSklq; Fri, 17 Jun 2022 15:09:04 +1000 (AEST)
Received: by smtp03.aussiebb.com.au (Postfix, from userid 119)
        id C349D1A009C; Fri, 17 Jun 2022 15:09:04 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp03.aussiebb.com.au (Postfix) with ESMTP id 30AAF1A0081;
        Fri, 17 Jun 2022 15:09:04 +1000 (AEST)
Subject: [PATCH 1/2] vfs: parse: deal with zero length string value
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Siddhesh Poyarekar <siddhesh@gotplt.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Jun 2022 13:09:03 +0800
Message-ID: <165544254397.247784.17488951418549565189.stgit@donald.themaw.net>
In-Reply-To: <165544249242.247784.13096425754908440867.stgit@donald.themaw.net>
References: <165544249242.247784.13096425754908440867.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Parsing an fs string that has zero length should result in the parameter
being set to NULL so that downstream processing handles it correctly.
For example, the proc mount table processing should print "(none)" in
this case to preserve mount record field count, but if the value points
to the NULL string this doesn't happen.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/fs_context.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 24ce12f0db32..4c735d0ce3cb 100644
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
 


