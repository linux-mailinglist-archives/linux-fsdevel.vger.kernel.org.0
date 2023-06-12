Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F2E72C171
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 12:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbjFLK6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 06:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbjFLK5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:57:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA3EE57D;
        Mon, 12 Jun 2023 03:45:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23BE962418;
        Mon, 12 Jun 2023 10:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5433C433D2;
        Mon, 12 Jun 2023 10:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686566744;
        bh=9ZN85s2F3/oEy5pkv6yI4Tv5XU9EfGqK4A7t1kaGRdY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Sv98hIAW85F4HBftzDcqOyvM/R3EukSSckezqktp1nVmTUG16TJv0cTmZ7SZqrheb
         d4IypswNbwiWEDy/oOarsubCsCA3ax3zQ3H9iLKzVTYSmCKzyXYNS/5sahPEso7cuj
         2VuMf+UQPbv18bzClnCD63+Vm3dpGSjDADvHTxD0cbM7bauFma36sYcKjJBaAT7/JB
         bPGjUyszcMJqtojtlNPoeTxFbjM4KhWRNKx0efDE8UgBAAQbbgtog1Y5rePrnTS841
         IkhITd1epcN0mh1bQ6Jk4cLEMA1nMm2CbuaTOSCBgqEts5gyguTJNTvyuSzqq9k91F
         PZ1odKwWKFr2A==
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
Subject: [PATCH v2 5/8] efivarfs: update ctime when mtime changes on a write
Date:   Mon, 12 Jun 2023 06:45:21 -0400
Message-Id: <20230612104524.17058-6-jlayton@kernel.org>
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

POSIX says:

"Upon successful completion, where nbyte is greater than 0, write()
 shall mark for update the last data modification and last file status
 change timestamps of the file..."

Add the missing ctime update.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/efivarfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index d57ee15874f9..375576111dc3 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -51,7 +51,7 @@ static ssize_t efivarfs_file_write(struct file *file,
 	} else {
 		inode_lock(inode);
 		i_size_write(inode, datasize + sizeof(attributes));
-		inode->i_mtime = current_time(inode);
+		inode->i_mtime = inode->i_ctime = current_time(inode);
 		inode_unlock(inode);
 	}
 
-- 
2.40.1

