Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA3754F076
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 07:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379952AbiFQFPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 01:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379854AbiFQFPG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:15:06 -0400
X-Greylist: delayed 357 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Jun 2022 22:15:04 PDT
Received: from smtp03.aussiebb.com.au (smtp03.aussiebb.com.au [121.200.0.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C9A63BEE;
        Thu, 16 Jun 2022 22:15:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp03.aussiebb.com.au (Postfix) with ESMTP id 945521A00A3;
        Fri, 17 Jun 2022 15:09:10 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp03.aussiebb.com.au
Received: from smtp03.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp03.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kGe32BYKn8Wr; Fri, 17 Jun 2022 15:09:10 +1000 (AEST)
Received: by smtp03.aussiebb.com.au (Postfix, from userid 119)
        id 86B8C1A00A1; Fri, 17 Jun 2022 15:09:10 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp03.aussiebb.com.au (Postfix) with ESMTP id D31E01A0074;
        Fri, 17 Jun 2022 15:09:09 +1000 (AEST)
Subject: [PATCH 2/2] vfs: escape hash as well
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Siddhesh Poyarekar <siddhesh@gotplt.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Jun 2022 13:09:09 +0800
Message-ID: <165544254964.247784.15840426718395834690.stgit@donald.themaw.net>
In-Reply-To: <165544249242.247784.13096425754908440867.stgit@donald.themaw.net>
References: <165544249242.247784.13096425754908440867.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Siddhesh Poyarekar <siddhesh@gotplt.org>

When a filesystem is mounted with a name that starts with a #:

 # mount '#name' /mnt/bad -t tmpfs

this will cause the entry to look like this (leading space added so
that git does not strip it out):

 #name /mnt/bad tmpfs rw,seclabel,relatime,inode64 0 0

This breaks getmntent and any code that aims to parse fstab as well as
/proc/mounts with the same logic since they need to strip leading spaces
or skip over comment lines, due to which they report incorrect output or
skip over the line respectively.

Solve this by translating the hash character into its octal encoding
equivalent so that applications can decode the name correctly.

Signed-off-by: Siddhesh Poyarekar <siddhesh@gotplt.org>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/proc_namespace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 49650e54d2f8..846f9455ae22 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -86,7 +86,7 @@ static void show_mnt_opts(struct seq_file *m, struct vfsmount *mnt)
 
 static inline void mangle(struct seq_file *m, const char *s)
 {
-	seq_escape(m, s, " \t\n\\");
+	seq_escape(m, s, " \t\n\\#");
 }
 
 static void show_type(struct seq_file *m, struct super_block *sb)


