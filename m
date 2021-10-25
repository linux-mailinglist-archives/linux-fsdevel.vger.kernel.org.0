Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70547438DF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 06:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhJYEHo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 00:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhJYEHm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 00:07:42 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBFFC061745;
        Sun, 24 Oct 2021 21:05:21 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id A5FCB100281;
        Mon, 25 Oct 2021 15:05:19 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FdNsQPSpWM8W; Mon, 25 Oct 2021 15:05:19 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 8502F100337; Mon, 25 Oct 2021 15:05:19 +1100 (AEDT)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        smtp01.aussiebb.com.au
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=10.0 tests=RDNS_NONE autolearn=disabled
        version=3.4.2
Received: from mickey.themaw.net (unknown [100.72.131.210])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id ED6F8100337;
        Mon, 25 Oct 2021 15:05:17 +1100 (AEDT)
Subject: [PATCH 2/2] vfs: escape hash as well
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 25 Oct 2021 12:05:17 +0800
Message-ID: <163513471773.40352.15886350498066945740.stgit@mickey.themaw.net>
In-Reply-To: <163513470696.40352.1069626993439788071.stgit@mickey.themaw.net>
References: <163513470696.40352.1069626993439788071.stgit@mickey.themaw.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ian Kent <ikent@redhat.com>

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

Signed-off-by: Ian Kent <ikent@redhat.com>
---
 fs/proc_namespace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 392ef5162655..835eb71a0169 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -86,7 +86,7 @@ static void show_mnt_opts(struct seq_file *m, struct vfsmount *mnt)
 
 static inline void mangle(struct seq_file *m, const char *s)
 {
-	seq_escape(m, s, " \t\n\\");
+	seq_escape(m, s, " \t\n\\#");
 }
 
 static void show_type(struct seq_file *m, struct super_block *sb)


