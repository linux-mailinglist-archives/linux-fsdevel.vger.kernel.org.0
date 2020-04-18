Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2671AF33F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 20:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgDRSlV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 14:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726408AbgDRSlS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:41:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917EFC0610D6;
        Sat, 18 Apr 2020 11:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=8++U0J0JftLda//wkFlmbDic7vW6wvPQj9vRP451qyE=; b=pyHV1YjuYgoOSvT5iNE2Y7QesB
        NXrQxVgUayq4HjgeqKsk2tapY3tZ0T5adrg2tRGVb9UDxjDW8Ymr23ZQvkVi+4TN/ycZwkIUkaudG
        oGMqI5Zd6s+C1gyru6NOrS5ZFX1JqPWuYEb45qk0a5RAHpEztnjpgk8xMtaZ2YEB2mXtj14HUzOUk
        LVAd8pg4/P6e1JpzKE3ulBSzOtFhS8JXHt+oL461ce4TL035IHm65XTXUhN54RnOcQ2jZv7YhSCS+
        V6nVFKIksP8CDgK7V6ubm5iolAEN2qiHG681gjIL3NBvd9hAfq4bMBMyPZ7R3p3jHd0ZxUtJLl1rc
        SIUUC5lg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPsP0-0007rZ-CC; Sat, 18 Apr 2020 18:41:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Zzy Wysm <zzy@zzywysm.com>
Subject: [PATCH 5/9] usb: fix empty-body warning in sysfs.c
Date:   Sat, 18 Apr 2020 11:41:07 -0700
Message-Id: <20200418184111.13401-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200418184111.13401-1-rdunlap@infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix gcc empty-body warning when -Wextra is used:

../drivers/usb/core/sysfs.c: In function ‘usb_create_sysfs_intf_files’:
../drivers/usb/core/sysfs.c:1266:3: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
   ; /* We don't actually care if the function fails. */
   ^

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/usb/core/sysfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200327.orig/drivers/usb/core/sysfs.c
+++ linux-next-20200327/drivers/usb/core/sysfs.c
@@ -1263,7 +1263,7 @@ void usb_create_sysfs_intf_files(struct
 	if (!alt->string && !(udev->quirks & USB_QUIRK_CONFIG_INTF_STRINGS))
 		alt->string = usb_cache_string(udev, alt->desc.iInterface);
 	if (alt->string && device_create_file(&intf->dev, &dev_attr_interface))
-		;	/* We don't actually care if the function fails. */
+		do_empty(); /* We don't actually care if the function fails. */
 	intf->sysfs_files_created = 1;
 }
 
