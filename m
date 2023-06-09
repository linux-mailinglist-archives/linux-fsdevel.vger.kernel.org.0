Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434E9729A96
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 14:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241012AbjFIMvK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 08:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240763AbjFIMug (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:50:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A74210A;
        Fri,  9 Jun 2023 05:50:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4630165489;
        Fri,  9 Jun 2023 12:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EB0C433A0;
        Fri,  9 Jun 2023 12:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686315034;
        bh=yUgO0XnKI1BbTfLGM0bCDn9qpGeiaXMDR0HU5CRWhAE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OsfdjrHcHty7OLY/KeXT8tTjMzBp/v/UFPT3HeXd2rL2d2bPqHofhYemos4x86pSA
         erf6NOWo/X2/RzN25PZphi8WmWHmyXXgbPmQhPPz6PDyBGK5QqCcDKetJoaRMcH2r7
         R8nqpIwb2tKNk3CPbpPCHf04ebtNiB53pwoSaST7t24XwcBcigXvTIDc3/UTvCzF+v
         sk71YpnyIcuzVMf+Cadazp7/WcrCWdKB8RCwVM8+FWTl7pYxjLOxdEf2MUk0qU9rnu
         +WfcEM8N4jDGZgE1F53TxLU+5Wo/zZ7eQJT9NlVcnzpRFF+1VxBmnV1S+0Az4/6wQo
         iEtm52+AU8/TA==
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
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
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
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        autofs@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
Subject: [PATCH 2/9] usb: update the ctime as well when updating mtime after an ioctl
Date:   Fri,  9 Jun 2023 08:50:16 -0400
Message-Id: <20230609125023.399942-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609125023.399942-1-jlayton@kernel.org>
References: <20230609125023.399942-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

