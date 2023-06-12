Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CED372C191
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 12:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbjFLK7E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 06:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbjFLK5u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:57:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FD759D1;
        Mon, 12 Jun 2023 03:45:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A6D862451;
        Mon, 12 Jun 2023 10:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C7EC4339C;
        Mon, 12 Jun 2023 10:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686566750;
        bh=wKObH6RqfDSKn8NJ5P1Az5k/GApq/hL/pKFLfNG4hQ4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LmmZkhNyD5zDhN30iflITZjik39GhWUe9Zp2752cKSdJF2l1rVLjseSvmT8FZAnUW
         Tt+Rk6fBUYPjKCd4SxlgSiLiIF8+vtYo5Sb5QtZpNg3apDbKEGO4QI+cdJ3s+yXJw9
         Bi8/f7AqA8ESRTQKcBuEh6nTtDgtKi4wFVDK8wQLx0Zo25LDolbf5jZMc1ZTwyb7pe
         0dKP/F7COKkhUtTASLHTMB7PzYC874EBAcrWbqIGcZW5hdEJiHjrXkVqvdBBmZWCPM
         ITZ9AnpeSKjuXFRWezYx5SYvEEwPZRK+EnpN6qR/ONpj6ISjGT7cQvL7MV0db9dJMg
         f0/ADoTJDBpSw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Kent <raven@themaw.net>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Suren Baghdasaryan <surenb@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        autofs@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 7/8] apparmor: update ctime whenever the mtime changes on an inode
Date:   Mon, 12 Jun 2023 06:45:23 -0400
Message-Id: <20230612104524.17058-8-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612104524.17058-1-jlayton@kernel.org>
References: <20230612104524.17058-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In general, when updating the mtime on an inode, one must also update
the ctime. Add the missing ctime updates.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 security/apparmor/apparmorfs.c    |  7 +++++--
 security/apparmor/policy_unpack.c | 11 +++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index db7a51acf9db..c06053718836 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1554,8 +1554,11 @@ void __aafs_profile_migrate_dents(struct aa_profile *old,
 
 	for (i = 0; i < AAFS_PROF_SIZEOF; i++) {
 		new->dents[i] = old->dents[i];
-		if (new->dents[i])
-			new->dents[i]->d_inode->i_mtime = current_time(new->dents[i]->d_inode);
+		if (new->dents[i]) {
+			struct inode *inode = d_inode(new->dents[i]);
+
+			inode->i_mtime = inode->i_ctime = current_time(inode);
+		}
 		old->dents[i] = NULL;
 	}
 }
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index cf2ceec40b28..48a97c1800b9 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -86,10 +86,13 @@ void __aa_loaddata_update(struct aa_loaddata *data, long revision)
 
 	data->revision = revision;
 	if ((data->dents[AAFS_LOADDATA_REVISION])) {
-		d_inode(data->dents[AAFS_LOADDATA_DIR])->i_mtime =
-			current_time(d_inode(data->dents[AAFS_LOADDATA_DIR]));
-		d_inode(data->dents[AAFS_LOADDATA_REVISION])->i_mtime =
-			current_time(d_inode(data->dents[AAFS_LOADDATA_REVISION]));
+		struct inode *inode;
+
+		inode = d_inode(data->dents[AAFS_LOADDATA_DIR]);
+		inode->i_mtime = inode->i_ctime = current_time(inode);
+
+		inode = d_inode(data->dents[AAFS_LOADDATA_REVISION]);
+		inode->i_mtime = inode->i_ctime = current_time(inode);
 	}
 }
 
-- 
2.40.1

