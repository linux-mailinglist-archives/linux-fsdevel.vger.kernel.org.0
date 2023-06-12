Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288BC72C1A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 12:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbjFLK7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 06:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbjFLK5w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:57:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186026EAB;
        Mon, 12 Jun 2023 03:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1A6D62451;
        Mon, 12 Jun 2023 10:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E347C433D2;
        Mon, 12 Jun 2023 10:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686566754;
        bh=n83nlEjKdfIOBmYidDyhQMkFJfDZwR7ta+gYJd+TVCQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=q+YkQNa328pMVFsA2bRAmz5UMjgF+DnvTPqv88BK4VXVNKMksbd7Idlt4Ynx5ayzp
         0mpe940TUN7nIlv6rm8JohB1cnuug/RTPS8ZSK+Gqpfo935WqDt6AQW29cfrzEWyI0
         hntdqRNzxTdjhNixoS4zPOB7ooqWzN4tqKdIHQzS3XjVL+czdUWoPRcWhg6kxtbJ6I
         Cr9pv+DlyR4FK0jjAjwunzAxUmuLz2ahMFQjJr+odeexqZ9ZZh/jTAkvwuE5rDARGz
         WM34MHMRkkLBu8ZnBc5JXo2/ZX2kgl5ccHEvr2qcjhgn1OBiH3soWsvGTwYWhRxGiM
         bCPjv8pHoyx6w==
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
Subject: [PATCH v2 8/8] cifs: update the ctime on a partial page write
Date:   Mon, 12 Jun 2023 06:45:24 -0400
Message-Id: <20230612104524.17058-9-jlayton@kernel.org>
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
 fs/smb/client/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index df88b8c04d03..a00038a326cf 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2596,7 +2596,7 @@ static int cifs_partialpagewrite(struct page *page, unsigned from, unsigned to)
 					   write_data, to - from, &offset);
 		cifsFileInfo_put(open_file);
 		/* Does mm or vfs already set times? */
-		inode->i_atime = inode->i_mtime = current_time(inode);
+		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 		if ((bytes_written > 0) && (offset))
 			rc = 0;
 		else if (bytes_written < 0)
-- 
2.40.1

