Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9E048DF37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 22:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfHNUqE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 16:46:04 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:35369 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfHNUqD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:46:03 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N3bnP-1iPFzy0qGp-010ZeU; Wed, 14 Aug 2019 22:45:41 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-watchdog@vger.kernel.org
Subject: [PATCH v5 05/18] watchdog: cpwd: use generic compat_ptr_ioctl
Date:   Wed, 14 Aug 2019 22:42:32 +0200
Message-Id: <20190814204259.120942-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190814204259.120942-1-arnd@arndb.de>
References: <20190814204259.120942-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3a4T0+6d97+aohDNW/FtRRy0OL3GUoodnLsBOLxtmzvxYHD4nsU
 luMbWfHIl5BcsdlVHGK5m+/bWCtSjslqMmO0AuL6u0+1oNKgoWMdj1Eld5ELQNoNlyNLQKC
 zVp2goGJq19LaFW42VqCYrhFLWr2I7j5Uvog04XNttVJ4FfNpg241HZlZYV2vGqzh939Tw+
 yopb/D3+LbbYSDvFLqrsA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:83dwGx/HYvo=:APkpK2EDgzEki9/bZwgwND
 A99E1l5pNDtDf3RPKP4Ek2PjpdG5dN8qa5s732xBWIBGtLLil+F3mi9BrGnk8BOr9cCwNHqPS
 K1STEn4T9rgarD9uHPla+WlYSqjGQfUsKRAsArAzLpMxwLmzQvcXoEN00hoKeNmI2cD3b/LB0
 iP6v/6qP71QTVl5CZn89I3iQqWnXMzn8mV65/SgHEtd1YpcovXZcrFoHYEF43a82cHVBuOM+B
 /71RlU0gi9/MqjY+K0nCPfipm8V136v/wsdNIpFSlg6hCF167yal5lGIs1f0VhzViizQ9dvQP
 Lp35ipf5J4D7GXOVWCJ2JCoXFjgbsuEPclPOLydazGxwIV2WwugQz2qpI3Qk5trLSFT28cEji
 2PjSRFu1XXJ+bpN4f4io4BtXjRcy2JQrSPxWQZ2ULD1eZ1j53AB72dVM+gLNeRGpxNWEw5NNY
 Ef67jpDJqbJGUti0VXjlM0D8eO4VJPyVoNsy/iCeC3mAR5Hh2cEe5IWcE6k8/I1PwGM25yana
 hcZwAn7lCxBOxJyKqMBKSkI9vEC4CKHQweMQDL/s4xIEoe3gku1JxxDoV+xiqLEpD5CqMn9zY
 ag1QjS8r421e+NCHyYH0jXUBTk5uqYnD/AKbJ279d7pkaVThbeP5BZ0wTRc4Q4mcRwyxe27Ag
 QhRNIAb+KVw2vAIn8ivYxpAJneBOdH7O2R9tdP2zLMoUPDLLIsy4DLPPUzvPkAZjkF0shMFCq
 4+/bk3paNofJmv0FMYM7UXA366Ajon2TEW5vGg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The cpwd_compat_ioctl() contains a bogus mutex that dates
back to a leftover BKL instance.

Simplify the implementation by using the new compat_ptr_ioctl()
helper function that will do the right thing for all calls
here.

Note that WIOCSTART/WIOCSTOP don't take any arguments, so
the compat_ptr() conversion is not needed here, but it also
doesn't hurt.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/watchdog/cpwd.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index b973b31179df..9393be584e72 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -473,29 +473,6 @@ static long cpwd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return 0;
 }
 
-static long cpwd_compat_ioctl(struct file *file, unsigned int cmd,
-			      unsigned long arg)
-{
-	int rval = -ENOIOCTLCMD;
-
-	switch (cmd) {
-	/* solaris ioctls are specific to this driver */
-	case WIOCSTART:
-	case WIOCSTOP:
-	case WIOCGSTAT:
-		mutex_lock(&cpwd_mutex);
-		rval = cpwd_ioctl(file, cmd, arg);
-		mutex_unlock(&cpwd_mutex);
-		break;
-
-	/* everything else is handled by the generic compat layer */
-	default:
-		break;
-	}
-
-	return rval;
-}
-
 static ssize_t cpwd_write(struct file *file, const char __user *buf,
 			  size_t count, loff_t *ppos)
 {
@@ -520,7 +497,7 @@ static ssize_t cpwd_read(struct file *file, char __user *buffer,
 static const struct file_operations cpwd_fops = {
 	.owner =		THIS_MODULE,
 	.unlocked_ioctl =	cpwd_ioctl,
-	.compat_ioctl =		cpwd_compat_ioctl,
+	.compat_ioctl =		compat_ptr_ioctl,
 	.open =			cpwd_open,
 	.write =		cpwd_write,
 	.read =			cpwd_read,
-- 
2.20.0

