Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F491CC578
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 01:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgEIXqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 19:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728794AbgEIXqB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 19:46:01 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE54C05BD0C;
        Sat,  9 May 2020 16:46:01 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXZAO-004iSZ-DN; Sat, 09 May 2020 23:46:00 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 18/20] usb: get rid of pointless access_ok() calls
Date:   Sun, 10 May 2020 00:45:55 +0100
Message-Id: <20200509234557.1124086-18-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

in all affected cases addresses are passed only to
copy_from()_user or copy_to_user().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/usb/core/devices.c          | 2 --
 drivers/usb/core/devio.c            | 9 ---------
 drivers/usb/gadget/function/f_hid.c | 6 ------
 3 files changed, 17 deletions(-)

diff --git a/drivers/usb/core/devices.c b/drivers/usb/core/devices.c
index 44f28a114c2b..94b6fa6e585e 100644
--- a/drivers/usb/core/devices.c
+++ b/drivers/usb/core/devices.c
@@ -598,8 +598,6 @@ static ssize_t usb_device_read(struct file *file, char __user *buf,
 		return -EINVAL;
 	if (nbytes <= 0)
 		return 0;
-	if (!access_ok(buf, nbytes))
-		return -EFAULT;
 
 	mutex_lock(&usb_bus_idr_lock);
 	/* print devices for all busses */
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 6833c918abce..544769807ab8 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1127,11 +1127,6 @@ static int proc_control(struct usb_dev_state *ps, void __user *arg)
 		ctrl.bRequestType, ctrl.bRequest, ctrl.wValue,
 		ctrl.wIndex, ctrl.wLength);
 	if (ctrl.bRequestType & 0x80) {
-		if (ctrl.wLength && !access_ok(ctrl.data,
-					       ctrl.wLength)) {
-			ret = -EINVAL;
-			goto done;
-		}
 		pipe = usb_rcvctrlpipe(dev, 0);
 		snoop_urb(dev, NULL, pipe, ctrl.wLength, tmo, SUBMIT, NULL, 0);
 
@@ -1216,10 +1211,6 @@ static int proc_bulk(struct usb_dev_state *ps, void __user *arg)
 	}
 	tmo = bulk.timeout;
 	if (bulk.ep & 0x80) {
-		if (len1 && !access_ok(bulk.data, len1)) {
-			ret = -EINVAL;
-			goto done;
-		}
 		snoop_urb(dev, NULL, pipe, len1, tmo, SUBMIT, NULL, 0);
 
 		usb_unlock_device(dev);
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index f3816a5c861e..df671acdd464 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -252,9 +252,6 @@ static ssize_t f_hidg_read(struct file *file, char __user *buffer,
 	if (!count)
 		return 0;
 
-	if (!access_ok(buffer, count))
-		return -EFAULT;
-
 	spin_lock_irqsave(&hidg->read_spinlock, flags);
 
 #define READ_COND (!list_empty(&hidg->completed_out_req))
@@ -339,9 +336,6 @@ static ssize_t f_hidg_write(struct file *file, const char __user *buffer,
 	unsigned long flags;
 	ssize_t status = -ENOMEM;
 
-	if (!access_ok(buffer, count))
-		return -EFAULT;
-
 	spin_lock_irqsave(&hidg->write_spinlock, flags);
 
 #define WRITE_COND (!hidg->write_pending)
-- 
2.11.0

