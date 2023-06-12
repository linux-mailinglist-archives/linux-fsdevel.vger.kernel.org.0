Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC0472C16E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 12:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbjFLK6G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 06:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236960AbjFLK5g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:57:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DB8E572;
        Mon, 12 Jun 2023 03:45:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2DD162450;
        Mon, 12 Jun 2023 10:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB4FC433D2;
        Mon, 12 Jun 2023 10:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686566735;
        bh=f+sv9c83YeZdEFyBLfaVXVS9uGARTf71K6hxZfrcSr4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XNPqT5xCR/WjIlqL84s4wlNFJCgGYAqKwg9zWLKMlluT43pgIvq6UYpc7QjKUhuWL
         nVIrZgjKf9Le2yKWvchiJV4LBbC0ljP1qKKTZdnKa3LICWwFNHz7sMCYSAO1yPGWJc
         ixIaxMQwn51TByDyIFIJ4whm3OajAgo0a8S2bf51eFvXRyczHtk84FQpWxkDHAGszp
         9PgkQIWwHJTlHW8C02GLU7kZQHk3jA/g7J+XX7rjLsmWIk6SAhbZ3n7MsZXHbQi8fq
         1BN620+hBAnd5L8CGYKibFXxe0Hxle4OVCsDLjX9mMgrdf+RzkMkt3m7jsKCrQeUGe
         l++bREhCo36qQ==
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
Subject: [PATCH v2 2/8] usb: update the ctime as well when updating mtime after an ioctl
Date:   Mon, 12 Jun 2023 06:45:18 -0400
Message-Id: <20230612104524.17058-3-jlayton@kernel.org>
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

In general, POSIX requires that when the mtime is updated that the ctime
be updated as well. Add the missing timestamp updates to the usb ioctls.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/usb/core/devio.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index fcf68818e999..1268d313a8df 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -2640,21 +2640,21 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		snoop(&dev->dev, "%s: CONTROL\n", __func__);
 		ret = proc_control(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = current_time(inode);
+			inode->i_mtime = inode->i_ctime = current_time(inode);
 		break;
 
 	case USBDEVFS_BULK:
 		snoop(&dev->dev, "%s: BULK\n", __func__);
 		ret = proc_bulk(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = current_time(inode);
+			inode->i_mtime = inode->i_ctime = current_time(inode);
 		break;
 
 	case USBDEVFS_RESETEP:
 		snoop(&dev->dev, "%s: RESETEP\n", __func__);
 		ret = proc_resetep(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = current_time(inode);
+			inode->i_mtime = inode->i_ctime = current_time(inode);
 		break;
 
 	case USBDEVFS_RESET:
@@ -2666,7 +2666,7 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		snoop(&dev->dev, "%s: CLEAR_HALT\n", __func__);
 		ret = proc_clearhalt(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = current_time(inode);
+			inode->i_mtime = inode->i_ctime = current_time(inode);
 		break;
 
 	case USBDEVFS_GETDRIVER:
@@ -2693,7 +2693,7 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		snoop(&dev->dev, "%s: SUBMITURB\n", __func__);
 		ret = proc_submiturb(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = current_time(inode);
+			inode->i_mtime = inode->i_ctime = current_time(inode);
 		break;
 
 #ifdef CONFIG_COMPAT
@@ -2701,14 +2701,14 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		snoop(&dev->dev, "%s: CONTROL32\n", __func__);
 		ret = proc_control_compat(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = current_time(inode);
+			inode->i_mtime = inode->i_ctime = current_time(inode);
 		break;
 
 	case USBDEVFS_BULK32:
 		snoop(&dev->dev, "%s: BULK32\n", __func__);
 		ret = proc_bulk_compat(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = current_time(inode);
+			inode->i_mtime = inode->i_ctime = current_time(inode);
 		break;
 
 	case USBDEVFS_DISCSIGNAL32:
@@ -2720,7 +2720,7 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		snoop(&dev->dev, "%s: SUBMITURB32\n", __func__);
 		ret = proc_submiturb_compat(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = current_time(inode);
+			inode->i_mtime = inode->i_ctime = current_time(inode);
 		break;
 
 	case USBDEVFS_IOCTL32:
-- 
2.40.1

