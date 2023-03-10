Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1426B555F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 00:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCJXNJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 18:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjCJXND (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:13:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0FC7D98;
        Fri, 10 Mar 2023 15:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EPRtJdAYUThD9v7MOatRvgqEa9X3fVwxqlIN4DTz3cs=; b=SnYgNMBzREroBXdPEY7ZqIIMzG
        cTnmobatmfXagXhqbITIy4V4ITQRAK7YAEx/+E69OXETmV5ggH1R2qyBW8N55HLDXLE4gc+kys/6F
        uSuOaFyJtC+f2y3omET8kB7nLHBQ/JDqkiv/NSKoVOVa8DeEhDAC/PTgx4G/c4ECoc4as0kMX4dts
        gOPJbb8IsXGj/4pLluzZrFaAsVZbLg85X3cPxknaJLPtK3XDqmj4HA0Tz28c44eCuDodXMVeQM33x
        1rP/K8GTCDr113mywkzg4bTIPqPka82LBxtqt+lyqrBRy0aXqPi635WEuSTk1XJyD56evrKQWDkfl
        yWAponhw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paluB-00GaJH-7h; Fri, 10 Mar 2023 23:12:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, jack@suse.com,
        jaharkes@cs.cmu.edu, coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/5] devpts: simplify two-level sysctl registration for pty_kern_table
Date:   Fri, 10 Mar 2023 15:12:03 -0800
Message-Id: <20230310231206.3952808-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230310231206.3952808-1-mcgrof@kernel.org>
References: <20230310231206.3952808-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no need to declare two tables to just create directories,
this can be easily be done with a prefix path with register_sysctl().

Simplify this registration.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/devpts/inode.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 4f25015aa534..fe3db0eda8e4 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -72,24 +72,6 @@ static struct ctl_table pty_table[] = {
 	{}
 };
 
-static struct ctl_table pty_kern_table[] = {
-	{
-		.procname	= "pty",
-		.mode		= 0555,
-		.child		= pty_table,
-	},
-	{}
-};
-
-static struct ctl_table pty_root_table[] = {
-	{
-		.procname	= "kernel",
-		.mode		= 0555,
-		.child		= pty_kern_table,
-	},
-	{}
-};
-
 struct pts_mount_opts {
 	int setuid;
 	int setgid;
@@ -630,7 +612,7 @@ static int __init init_devpts_fs(void)
 {
 	int err = register_filesystem(&devpts_fs_type);
 	if (!err) {
-		register_sysctl_table(pty_root_table);
+		register_sysctl("kernel/pty", pty_table);
 	}
 	return err;
 }
-- 
2.39.1

