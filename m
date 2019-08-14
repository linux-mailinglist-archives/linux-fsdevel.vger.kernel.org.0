Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3AA8DF5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 22:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfHNUxx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 16:53:53 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:35795 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbfHNUxx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:53:53 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MelWf-1iWVfO0Obl-00amXq; Wed, 14 Aug 2019 22:52:55 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
        openipmi-developer@lists.sourceforge.net,
        linux-hwmon@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 06/18] compat_ioctl: move WDIOC handling into wdt drivers
Date:   Wed, 14 Aug 2019 22:49:18 +0200
Message-Id: <20190814205245.121691-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190814204259.120942-1-arnd@arndb.de>
References: <20190814204259.120942-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:a6kAScvsv50hT1NELen7zAYH9qygDTRzq1l9QB7DcbqRWok0RWQ
 ue90k8BQu/iaOBvJiZpGQ4f8Qcii148hcNCyHmrKkDg1K/LvLxg9qh4ubKNoDcivd00xmKV
 68EjYkfBau/0VehiF7Lf2PMrPnWQgzusdxqX1nghtietn4gso6kKEotTpUqEQJkQsPJm/h3
 sIym8X71cQ6aQ3pXHLs/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xe708eNlWTM=:5mcJGKR0M21Xu7L9P8i4ws
 EqevnUp0rVDZRF/GEUDIeyCThi9e33Zn10+WtS5tDrNc0PpLqO1C2N4AsYj0s5ZYU+V5NmIBN
 6231Y+/z+rlUnwMY3vYo0oQMy5gEwDaKMV2aWktbzbBkYx444oc/4jgvIhAZcPzITvReBVUz0
 PldJ4dE3xSQ8rcPUirJtrZxTeoTpe29COSnWvhlkwT8BT6rWaZd9Jq3NfhyRi7DCML738eroU
 M1cvYp+Cr6nnguHul8kp/d/9PRI/I4zVbDDDHlfXuUhEbidREePuupFw8uiDQm+EKkUOSdIgD
 4C4MCp3JanFScoKYiXS+8/hf9ARjtNrkgPaxPctPqxQtlsGDbYplXf5AN8LX5b1u4HRBOUPIR
 Db4aS0v76bZoqRDMh9iSDMaUCCZpnABVVnykRabcUcRdi9sonR855xiiJYftDTWeLjj2+Sgqm
 6z6JuCvPIXV//TOhZAxbLiRZPwKJqYD3eCM+8+AUGw7B6YWOgUi1M3cBoMNlzvWM/uc0Qwwdz
 afoTxofedf+SBSeBfYvI6KgJFngAm8FZ8HvKXjE9SpTI8IU6102qSK9Twd8vfX9ozRxohxj4G
 26qS9w7frot2eCo876CnMAnBZtgIZUA0GUa7xQonNSsMABq16q27v/Z6b9cvmmF5mGHWGG8Xo
 cHRRE53XhfTZXY/kGKp79geBvghUtOCKomrlWp/OIv939aPMk0mM35Jrp0jkjg1XDOKpnMqBG
 mNYrKrxMKnNxKqwsIYHEIoa0Uoh2LfvQeQnjvw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All watchdog drivers implement the same set of ioctl commands, and
fortunately all of them are compatible between 32-bit and 64-bit
architectures.

Modern drivers always go through drivers/watchdog/wdt.c as an abstraction
layer, but older ones implement their own file_operations on a character
device for this.

Move the handling from fs/compat_ioctl.c into the individual drivers.

Note that most of the legacy drivers will never be used on 64-bit
hardware, because they are for an old 32-bit SoC implementation, but
doing them all at once is safer than trying to guess which ones do
or do not need the compat_ioctl handling.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c |  1 +
 arch/um/drivers/harddog_kern.c            |  1 +
 drivers/char/ipmi/ipmi_watchdog.c         |  1 +
 drivers/hwmon/fschmd.c                    |  1 +
 drivers/rtc/rtc-ds1374.c                  |  1 +
 drivers/watchdog/acquirewdt.c             |  1 +
 drivers/watchdog/advantechwdt.c           |  1 +
 drivers/watchdog/alim1535_wdt.c           |  1 +
 drivers/watchdog/alim7101_wdt.c           |  1 +
 drivers/watchdog/ar7_wdt.c                |  1 +
 drivers/watchdog/at91rm9200_wdt.c         |  1 +
 drivers/watchdog/ath79_wdt.c              |  1 +
 drivers/watchdog/bcm63xx_wdt.c            |  1 +
 drivers/watchdog/cpu5wdt.c                |  1 +
 drivers/watchdog/eurotechwdt.c            |  1 +
 drivers/watchdog/f71808e_wdt.c            |  1 +
 drivers/watchdog/gef_wdt.c                |  1 +
 drivers/watchdog/geodewdt.c               |  1 +
 drivers/watchdog/ib700wdt.c               |  1 +
 drivers/watchdog/ibmasr.c                 |  1 +
 drivers/watchdog/indydog.c                |  1 +
 drivers/watchdog/intel_scu_watchdog.c     |  1 +
 drivers/watchdog/iop_wdt.c                |  1 +
 drivers/watchdog/it8712f_wdt.c            |  1 +
 drivers/watchdog/ixp4xx_wdt.c             |  1 +
 drivers/watchdog/ks8695_wdt.c             |  1 +
 drivers/watchdog/m54xx_wdt.c              |  1 +
 drivers/watchdog/machzwd.c                |  1 +
 drivers/watchdog/mixcomwd.c               |  1 +
 drivers/watchdog/mtx-1_wdt.c              |  1 +
 drivers/watchdog/mv64x60_wdt.c            |  1 +
 drivers/watchdog/nuc900_wdt.c             |  1 +
 drivers/watchdog/nv_tco.c                 |  1 +
 drivers/watchdog/pc87413_wdt.c            |  1 +
 drivers/watchdog/pcwd.c                   |  1 +
 drivers/watchdog/pcwd_pci.c               |  1 +
 drivers/watchdog/pcwd_usb.c               |  1 +
 drivers/watchdog/pika_wdt.c               |  1 +
 drivers/watchdog/pnx833x_wdt.c            |  1 +
 drivers/watchdog/rc32434_wdt.c            |  1 +
 drivers/watchdog/rdc321x_wdt.c            |  1 +
 drivers/watchdog/riowd.c                  |  1 +
 drivers/watchdog/sa1100_wdt.c             |  1 +
 drivers/watchdog/sb_wdog.c                |  1 +
 drivers/watchdog/sbc60xxwdt.c             |  1 +
 drivers/watchdog/sbc7240_wdt.c            |  1 +
 drivers/watchdog/sbc_epx_c3.c             |  1 +
 drivers/watchdog/sbc_fitpc2_wdt.c         |  1 +
 drivers/watchdog/sc1200wdt.c              |  1 +
 drivers/watchdog/sc520_wdt.c              |  1 +
 drivers/watchdog/sch311x_wdt.c            |  1 +
 drivers/watchdog/scx200_wdt.c             |  1 +
 drivers/watchdog/smsc37b787_wdt.c         |  1 +
 drivers/watchdog/w83877f_wdt.c            |  1 +
 drivers/watchdog/w83977f_wdt.c            |  1 +
 drivers/watchdog/wafer5823wdt.c           |  1 +
 drivers/watchdog/watchdog_dev.c           |  1 +
 drivers/watchdog/wdrtas.c                 |  1 +
 drivers/watchdog/wdt.c                    |  1 +
 drivers/watchdog/wdt285.c                 |  1 +
 drivers/watchdog/wdt977.c                 |  1 +
 drivers/watchdog/wdt_pci.c                |  1 +
 fs/compat_ioctl.c                         | 11 -----------
 63 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index ba12dc14a3d1..8c0d324f657e 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -650,6 +650,7 @@ static const struct file_operations mpc52xx_wdt_fops = {
 	.llseek		= no_llseek,
 	.write		= mpc52xx_wdt_write,
 	.unlocked_ioctl = mpc52xx_wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= mpc52xx_wdt_open,
 	.release	= mpc52xx_wdt_release,
 };
diff --git a/arch/um/drivers/harddog_kern.c b/arch/um/drivers/harddog_kern.c
index 000cb69ba0bc..e6d4f43deba8 100644
--- a/arch/um/drivers/harddog_kern.c
+++ b/arch/um/drivers/harddog_kern.c
@@ -165,6 +165,7 @@ static const struct file_operations harddog_fops = {
 	.owner		= THIS_MODULE,
 	.write		= harddog_write,
 	.unlocked_ioctl	= harddog_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= harddog_open,
 	.release	= harddog_release,
 	.llseek		= no_llseek,
diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
index 74c6d1f34132..55986e10a124 100644
--- a/drivers/char/ipmi/ipmi_watchdog.c
+++ b/drivers/char/ipmi/ipmi_watchdog.c
@@ -893,6 +893,7 @@ static const struct file_operations ipmi_wdog_fops = {
 	.poll    = ipmi_poll,
 	.write   = ipmi_write,
 	.unlocked_ioctl = ipmi_unlocked_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open    = ipmi_open,
 	.release = ipmi_close,
 	.fasync  = ipmi_fasync,
diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
index fa0c2f1fb443..4136643d8e0c 100644
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -954,6 +954,7 @@ static const struct file_operations watchdog_fops = {
 	.release = watchdog_release,
 	.write = watchdog_write,
 	.unlocked_ioctl = watchdog_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 };
 
 
diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 225a8df1d4e9..7e73be9898ac 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -586,6 +586,7 @@ static const struct file_operations ds1374_wdt_fops = {
 	.owner			= THIS_MODULE,
 	.read			= ds1374_wdt_read,
 	.unlocked_ioctl		= ds1374_wdt_unlocked_ioctl,
+	.compat_ioctl		= compat_ptr_ioctl,
 	.write			= ds1374_wdt_write,
 	.open                   = ds1374_wdt_open,
 	.release                = ds1374_wdt_release,
diff --git a/drivers/watchdog/acquirewdt.c b/drivers/watchdog/acquirewdt.c
index 848db958411e..bc6f333565d3 100644
--- a/drivers/watchdog/acquirewdt.c
+++ b/drivers/watchdog/acquirewdt.c
@@ -221,6 +221,7 @@ static const struct file_operations acq_fops = {
 	.llseek		= no_llseek,
 	.write		= acq_write,
 	.unlocked_ioctl	= acq_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= acq_open,
 	.release	= acq_close,
 };
diff --git a/drivers/watchdog/advantechwdt.c b/drivers/watchdog/advantechwdt.c
index 0d02bb275b3d..0e4c18a2aa42 100644
--- a/drivers/watchdog/advantechwdt.c
+++ b/drivers/watchdog/advantechwdt.c
@@ -220,6 +220,7 @@ static const struct file_operations advwdt_fops = {
 	.llseek		= no_llseek,
 	.write		= advwdt_write,
 	.unlocked_ioctl	= advwdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= advwdt_open,
 	.release	= advwdt_close,
 };
diff --git a/drivers/watchdog/alim1535_wdt.c b/drivers/watchdog/alim1535_wdt.c
index c157dd3d92a3..42338c7d4540 100644
--- a/drivers/watchdog/alim1535_wdt.c
+++ b/drivers/watchdog/alim1535_wdt.c
@@ -362,6 +362,7 @@ static const struct file_operations ali_fops = {
 	.llseek		=	no_llseek,
 	.write		=	ali_write,
 	.unlocked_ioctl =	ali_ioctl,
+	.compat_ioctl	= 	compat_ptr_ioctl,
 	.open		=	ali_open,
 	.release	=	ali_release,
 };
diff --git a/drivers/watchdog/alim7101_wdt.c b/drivers/watchdog/alim7101_wdt.c
index c8e3ab056767..5af0358f4390 100644
--- a/drivers/watchdog/alim7101_wdt.c
+++ b/drivers/watchdog/alim7101_wdt.c
@@ -294,6 +294,7 @@ static const struct file_operations wdt_fops = {
 	.open		=	fop_open,
 	.release	=	fop_close,
 	.unlocked_ioctl	=	fop_ioctl,
+	.compat_ioctl	= 	compat_ptr_ioctl,
 };
 
 static struct miscdevice wdt_miscdev = {
diff --git a/drivers/watchdog/ar7_wdt.c b/drivers/watchdog/ar7_wdt.c
index 668a1c704f28..c087027ffd5d 100644
--- a/drivers/watchdog/ar7_wdt.c
+++ b/drivers/watchdog/ar7_wdt.c
@@ -250,6 +250,7 @@ static const struct file_operations ar7_wdt_fops = {
 	.owner		= THIS_MODULE,
 	.write		= ar7_wdt_write,
 	.unlocked_ioctl	= ar7_wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= ar7_wdt_open,
 	.release	= ar7_wdt_release,
 	.llseek		= no_llseek,
diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
index 907a4545dee6..6d751eb8191d 100644
--- a/drivers/watchdog/at91rm9200_wdt.c
+++ b/drivers/watchdog/at91rm9200_wdt.c
@@ -213,6 +213,7 @@ static const struct file_operations at91wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.unlocked_ioctl	= at91_wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= at91_wdt_open,
 	.release	= at91_wdt_close,
 	.write		= at91_wdt_write,
diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index 2e09981fe978..9ca8e5117dd8 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -234,6 +234,7 @@ static const struct file_operations ath79_wdt_fops = {
 	.llseek		= no_llseek,
 	.write		= ath79_wdt_write,
 	.unlocked_ioctl	= ath79_wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= ath79_wdt_open,
 	.release	= ath79_wdt_release,
 };
diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index e2af37c9a266..8a043b52aa2f 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -221,6 +221,7 @@ static const struct file_operations bcm63xx_wdt_fops = {
 	.llseek		= no_llseek,
 	.write		= bcm63xx_wdt_write,
 	.unlocked_ioctl	= bcm63xx_wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= bcm63xx_wdt_open,
 	.release	= bcm63xx_wdt_release,
 };
diff --git a/drivers/watchdog/cpu5wdt.c b/drivers/watchdog/cpu5wdt.c
index d6d53014cb68..9867a3a936df 100644
--- a/drivers/watchdog/cpu5wdt.c
+++ b/drivers/watchdog/cpu5wdt.c
@@ -187,6 +187,7 @@ static const struct file_operations cpu5wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.unlocked_ioctl	= cpu5wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= cpu5wdt_open,
 	.write		= cpu5wdt_write,
 	.release	= cpu5wdt_release,
diff --git a/drivers/watchdog/eurotechwdt.c b/drivers/watchdog/eurotechwdt.c
index 3a83a48abcae..f5ffa7be066e 100644
--- a/drivers/watchdog/eurotechwdt.c
+++ b/drivers/watchdog/eurotechwdt.c
@@ -371,6 +371,7 @@ static const struct file_operations eurwdt_fops = {
 	.llseek		= no_llseek,
 	.write		= eurwdt_write,
 	.unlocked_ioctl	= eurwdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= eurwdt_open,
 	.release	= eurwdt_release,
 };
diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index ff5cf1b48a4d..a30ac5b120c9 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -657,6 +657,7 @@ static const struct file_operations watchdog_fops = {
 	.release	= watchdog_release,
 	.write		= watchdog_write,
 	.unlocked_ioctl	= watchdog_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 };
 
 static struct miscdevice watchdog_miscdev = {
diff --git a/drivers/watchdog/gef_wdt.c b/drivers/watchdog/gef_wdt.c
index 7d5f56994f09..f6541d1b65e3 100644
--- a/drivers/watchdog/gef_wdt.c
+++ b/drivers/watchdog/gef_wdt.c
@@ -248,6 +248,7 @@ static const struct file_operations gef_wdt_fops = {
 	.llseek = no_llseek,
 	.write = gef_wdt_write,
 	.unlocked_ioctl = gef_wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open = gef_wdt_open,
 	.release = gef_wdt_release,
 };
diff --git a/drivers/watchdog/geodewdt.c b/drivers/watchdog/geodewdt.c
index 8d105d98908e..9914a4283cb2 100644
--- a/drivers/watchdog/geodewdt.c
+++ b/drivers/watchdog/geodewdt.c
@@ -201,6 +201,7 @@ static const struct file_operations geodewdt_fops = {
 	.llseek         = no_llseek,
 	.write          = geodewdt_write,
 	.unlocked_ioctl = geodewdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open           = geodewdt_open,
 	.release        = geodewdt_release,
 };
diff --git a/drivers/watchdog/ib700wdt.c b/drivers/watchdog/ib700wdt.c
index 92fd7f33bc4d..2b65ea9451d1 100644
--- a/drivers/watchdog/ib700wdt.c
+++ b/drivers/watchdog/ib700wdt.c
@@ -259,6 +259,7 @@ static const struct file_operations ibwdt_fops = {
 	.llseek		= no_llseek,
 	.write		= ibwdt_write,
 	.unlocked_ioctl	= ibwdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= ibwdt_open,
 	.release	= ibwdt_close,
 };
diff --git a/drivers/watchdog/ibmasr.c b/drivers/watchdog/ibmasr.c
index 897f7eda9e6a..4a22fe152086 100644
--- a/drivers/watchdog/ibmasr.c
+++ b/drivers/watchdog/ibmasr.c
@@ -344,6 +344,7 @@ static const struct file_operations asr_fops = {
 	.llseek =		no_llseek,
 	.write =		asr_write,
 	.unlocked_ioctl =	asr_ioctl,
+	.compat_ioctl =		compat_ptr_ioctl,
 	.open =			asr_open,
 	.release =		asr_release,
 };
diff --git a/drivers/watchdog/indydog.c b/drivers/watchdog/indydog.c
index 550358528084..9857bb74a723 100644
--- a/drivers/watchdog/indydog.c
+++ b/drivers/watchdog/indydog.c
@@ -152,6 +152,7 @@ static const struct file_operations indydog_fops = {
 	.llseek		= no_llseek,
 	.write		= indydog_write,
 	.unlocked_ioctl	= indydog_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= indydog_open,
 	.release	= indydog_release,
 };
diff --git a/drivers/watchdog/intel_scu_watchdog.c b/drivers/watchdog/intel_scu_watchdog.c
index 1c85103b750b..6ad5bf3451ec 100644
--- a/drivers/watchdog/intel_scu_watchdog.c
+++ b/drivers/watchdog/intel_scu_watchdog.c
@@ -412,6 +412,7 @@ static const struct file_operations intel_scu_fops = {
 	.llseek         = no_llseek,
 	.write          = intel_scu_write,
 	.unlocked_ioctl = intel_scu_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open           = intel_scu_open,
 	.release        = intel_scu_release,
 };
diff --git a/drivers/watchdog/iop_wdt.c b/drivers/watchdog/iop_wdt.c
index a9ccdb9a9159..6bf68d4750de 100644
--- a/drivers/watchdog/iop_wdt.c
+++ b/drivers/watchdog/iop_wdt.c
@@ -202,6 +202,7 @@ static const struct file_operations iop_wdt_fops = {
 	.llseek = no_llseek,
 	.write = iop_wdt_write,
 	.unlocked_ioctl = iop_wdt_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 	.open = iop_wdt_open,
 	.release = iop_wdt_release,
 };
diff --git a/drivers/watchdog/it8712f_wdt.c b/drivers/watchdog/it8712f_wdt.c
index 2fe1a3c499ed..2fed40d14007 100644
--- a/drivers/watchdog/it8712f_wdt.c
+++ b/drivers/watchdog/it8712f_wdt.c
@@ -345,6 +345,7 @@ static const struct file_operations it8712f_wdt_fops = {
 	.llseek = no_llseek,
 	.write = it8712f_wdt_write,
 	.unlocked_ioctl = it8712f_wdt_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 	.open = it8712f_wdt_open,
 	.release = it8712f_wdt_release,
 };
diff --git a/drivers/watchdog/ixp4xx_wdt.c b/drivers/watchdog/ixp4xx_wdt.c
index 9067998759e3..09886616fd21 100644
--- a/drivers/watchdog/ixp4xx_wdt.c
+++ b/drivers/watchdog/ixp4xx_wdt.c
@@ -163,6 +163,7 @@ static const struct file_operations ixp4xx_wdt_fops = {
 	.llseek		= no_llseek,
 	.write		= ixp4xx_wdt_write,
 	.unlocked_ioctl	= ixp4xx_wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= ixp4xx_wdt_open,
 	.release	= ixp4xx_wdt_release,
 };
diff --git a/drivers/watchdog/ks8695_wdt.c b/drivers/watchdog/ks8695_wdt.c
index 1550ce3c5702..6f375f302135 100644
--- a/drivers/watchdog/ks8695_wdt.c
+++ b/drivers/watchdog/ks8695_wdt.c
@@ -221,6 +221,7 @@ static const struct file_operations ks8695wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.unlocked_ioctl	= ks8695_wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= ks8695_wdt_open,
 	.release	= ks8695_wdt_close,
 	.write		= ks8695_wdt_write,
diff --git a/drivers/watchdog/m54xx_wdt.c b/drivers/watchdog/m54xx_wdt.c
index 752d03620f0a..22f335e1e164 100644
--- a/drivers/watchdog/m54xx_wdt.c
+++ b/drivers/watchdog/m54xx_wdt.c
@@ -183,6 +183,7 @@ static const struct file_operations m54xx_wdt_fops = {
 	.llseek		= no_llseek,
 	.write		= m54xx_wdt_write,
 	.unlocked_ioctl	= m54xx_wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= m54xx_wdt_open,
 	.release	= m54xx_wdt_release,
 };
diff --git a/drivers/watchdog/machzwd.c b/drivers/watchdog/machzwd.c
index cef2baf59dda..80ff94688487 100644
--- a/drivers/watchdog/machzwd.c
+++ b/drivers/watchdog/machzwd.c
@@ -361,6 +361,7 @@ static const struct file_operations zf_fops = {
 	.llseek		= no_llseek,
 	.write		= zf_write,
 	.unlocked_ioctl = zf_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= zf_open,
 	.release	= zf_close,
 };
diff --git a/drivers/watchdog/mixcomwd.c b/drivers/watchdog/mixcomwd.c
index a86faa5000f1..d387bad377c4 100644
--- a/drivers/watchdog/mixcomwd.c
+++ b/drivers/watchdog/mixcomwd.c
@@ -227,6 +227,7 @@ static const struct file_operations mixcomwd_fops = {
 	.llseek		= no_llseek,
 	.write		= mixcomwd_write,
 	.unlocked_ioctl	= mixcomwd_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= mixcomwd_open,
 	.release	= mixcomwd_release,
 };
diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 25a92857b217..8aa1cb4a295f 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -181,6 +181,7 @@ static const struct file_operations mtx1_wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.unlocked_ioctl	= mtx1_wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= mtx1_wdt_open,
 	.write		= mtx1_wdt_write,
 	.release	= mtx1_wdt_release,
diff --git a/drivers/watchdog/mv64x60_wdt.c b/drivers/watchdog/mv64x60_wdt.c
index 74bf7144a970..0bc72dd69b70 100644
--- a/drivers/watchdog/mv64x60_wdt.c
+++ b/drivers/watchdog/mv64x60_wdt.c
@@ -241,6 +241,7 @@ static const struct file_operations mv64x60_wdt_fops = {
 	.llseek = no_llseek,
 	.write = mv64x60_wdt_write,
 	.unlocked_ioctl = mv64x60_wdt_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 	.open = mv64x60_wdt_open,
 	.release = mv64x60_wdt_release,
 };
diff --git a/drivers/watchdog/nuc900_wdt.c b/drivers/watchdog/nuc900_wdt.c
index db124cebe838..bfe3e4e5d159 100644
--- a/drivers/watchdog/nuc900_wdt.c
+++ b/drivers/watchdog/nuc900_wdt.c
@@ -225,6 +225,7 @@ static const struct file_operations nuc900wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.unlocked_ioctl	= nuc900_wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= nuc900_wdt_open,
 	.release	= nuc900_wdt_close,
 	.write		= nuc900_wdt_write,
diff --git a/drivers/watchdog/nv_tco.c b/drivers/watchdog/nv_tco.c
index 5f0082e300bd..d7a560e348d5 100644
--- a/drivers/watchdog/nv_tco.c
+++ b/drivers/watchdog/nv_tco.c
@@ -267,6 +267,7 @@ static const struct file_operations nv_tco_fops = {
 	.llseek =		no_llseek,
 	.write =		nv_tco_write,
 	.unlocked_ioctl =	nv_tco_ioctl,
+	.compat_ioctl =		compat_ptr_ioctl,
 	.open =			nv_tco_open,
 	.release =		nv_tco_release,
 };
diff --git a/drivers/watchdog/pc87413_wdt.c b/drivers/watchdog/pc87413_wdt.c
index 2af1a8b3f973..73fbfc99083b 100644
--- a/drivers/watchdog/pc87413_wdt.c
+++ b/drivers/watchdog/pc87413_wdt.c
@@ -473,6 +473,7 @@ static const struct file_operations pc87413_fops = {
 	.llseek		= no_llseek,
 	.write		= pc87413_write,
 	.unlocked_ioctl	= pc87413_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= pc87413_open,
 	.release	= pc87413_release,
 };
diff --git a/drivers/watchdog/pcwd.c b/drivers/watchdog/pcwd.c
index c3c93e00b320..7a0587fdc52c 100644
--- a/drivers/watchdog/pcwd.c
+++ b/drivers/watchdog/pcwd.c
@@ -752,6 +752,7 @@ static const struct file_operations pcwd_fops = {
 	.llseek		= no_llseek,
 	.write		= pcwd_write,
 	.unlocked_ioctl	= pcwd_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= pcwd_open,
 	.release	= pcwd_close,
 };
diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
index e30c1f762045..81508a42a90c 100644
--- a/drivers/watchdog/pcwd_pci.c
+++ b/drivers/watchdog/pcwd_pci.c
@@ -646,6 +646,7 @@ static const struct file_operations pcipcwd_fops = {
 	.llseek =	no_llseek,
 	.write =	pcipcwd_write,
 	.unlocked_ioctl = pcipcwd_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 	.open =		pcipcwd_open,
 	.release =	pcipcwd_release,
 };
diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index 6727f8ab2d18..2f44af1831d0 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -550,6 +550,7 @@ static const struct file_operations usb_pcwd_fops = {
 	.llseek =	no_llseek,
 	.write =	usb_pcwd_write,
 	.unlocked_ioctl = usb_pcwd_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 	.open =		usb_pcwd_open,
 	.release =	usb_pcwd_release,
 };
diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
index 205c3c68fca1..a98abd0d3146 100644
--- a/drivers/watchdog/pika_wdt.c
+++ b/drivers/watchdog/pika_wdt.c
@@ -214,6 +214,7 @@ static const struct file_operations pikawdt_fops = {
 	.release	= pikawdt_release,
 	.write		= pikawdt_write,
 	.unlocked_ioctl	= pikawdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 };
 
 static struct miscdevice pikawdt_miscdev = {
diff --git a/drivers/watchdog/pnx833x_wdt.c b/drivers/watchdog/pnx833x_wdt.c
index aa53babf2bab..4097d076aab8 100644
--- a/drivers/watchdog/pnx833x_wdt.c
+++ b/drivers/watchdog/pnx833x_wdt.c
@@ -215,6 +215,7 @@ static const struct file_operations pnx833x_wdt_fops = {
 	.llseek		= no_llseek,
 	.write		= pnx833x_wdt_write,
 	.unlocked_ioctl	= pnx833x_wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= pnx833x_wdt_open,
 	.release	= pnx833x_wdt_release,
 };
diff --git a/drivers/watchdog/rc32434_wdt.c b/drivers/watchdog/rc32434_wdt.c
index a8a4b3a41a90..1dfede0abf18 100644
--- a/drivers/watchdog/rc32434_wdt.c
+++ b/drivers/watchdog/rc32434_wdt.c
@@ -245,6 +245,7 @@ static const struct file_operations rc32434_wdt_fops = {
 	.llseek		= no_llseek,
 	.write		= rc32434_wdt_write,
 	.unlocked_ioctl	= rc32434_wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= rc32434_wdt_open,
 	.release	= rc32434_wdt_release,
 };
diff --git a/drivers/watchdog/rdc321x_wdt.c b/drivers/watchdog/rdc321x_wdt.c
index 2e608ae6cbc7..57187efeb86f 100644
--- a/drivers/watchdog/rdc321x_wdt.c
+++ b/drivers/watchdog/rdc321x_wdt.c
@@ -199,6 +199,7 @@ static const struct file_operations rdc321x_wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.unlocked_ioctl	= rdc321x_wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= rdc321x_wdt_open,
 	.write		= rdc321x_wdt_write,
 	.release	= rdc321x_wdt_release,
diff --git a/drivers/watchdog/riowd.c b/drivers/watchdog/riowd.c
index b35f7be20c00..dc3c06a92f93 100644
--- a/drivers/watchdog/riowd.c
+++ b/drivers/watchdog/riowd.c
@@ -163,6 +163,7 @@ static const struct file_operations riowd_fops = {
 	.owner =		THIS_MODULE,
 	.llseek =		no_llseek,
 	.unlocked_ioctl =	riowd_ioctl,
+	.compat_ioctl	=	compat_ptr_ioctl,
 	.open =			riowd_open,
 	.write =		riowd_write,
 	.release =		riowd_release,
diff --git a/drivers/watchdog/sa1100_wdt.c b/drivers/watchdog/sa1100_wdt.c
index cbd8c957182f..9b93be00109f 100644
--- a/drivers/watchdog/sa1100_wdt.c
+++ b/drivers/watchdog/sa1100_wdt.c
@@ -141,6 +141,7 @@ static const struct file_operations sa1100dog_fops = {
 	.llseek		= no_llseek,
 	.write		= sa1100dog_write,
 	.unlocked_ioctl	= sa1100dog_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= sa1100dog_open,
 	.release	= sa1100dog_release,
 };
diff --git a/drivers/watchdog/sb_wdog.c b/drivers/watchdog/sb_wdog.c
index 202fc8d8ca5f..da2dad00d473 100644
--- a/drivers/watchdog/sb_wdog.c
+++ b/drivers/watchdog/sb_wdog.c
@@ -237,6 +237,7 @@ static const struct file_operations sbwdog_fops = {
 	.llseek		= no_llseek,
 	.write		= sbwdog_write,
 	.unlocked_ioctl	= sbwdog_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= sbwdog_open,
 	.release	= sbwdog_release,
 };
diff --git a/drivers/watchdog/sbc60xxwdt.c b/drivers/watchdog/sbc60xxwdt.c
index c3151642694c..f2cbe6d880a8 100644
--- a/drivers/watchdog/sbc60xxwdt.c
+++ b/drivers/watchdog/sbc60xxwdt.c
@@ -280,6 +280,7 @@ static const struct file_operations wdt_fops = {
 	.open		= fop_open,
 	.release	= fop_close,
 	.unlocked_ioctl	= fop_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 };
 
 static struct miscdevice wdt_miscdev = {
diff --git a/drivers/watchdog/sbc7240_wdt.c b/drivers/watchdog/sbc7240_wdt.c
index 12cdee7d5069..0bf583b76e6b 100644
--- a/drivers/watchdog/sbc7240_wdt.c
+++ b/drivers/watchdog/sbc7240_wdt.c
@@ -211,6 +211,7 @@ static const struct file_operations wdt_fops = {
 	.open = fop_open,
 	.release = fop_close,
 	.unlocked_ioctl = fop_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 };
 
 static struct miscdevice wdt_miscdev = {
diff --git a/drivers/watchdog/sbc_epx_c3.c b/drivers/watchdog/sbc_epx_c3.c
index 86828c28843f..5e3a9ddb952e 100644
--- a/drivers/watchdog/sbc_epx_c3.c
+++ b/drivers/watchdog/sbc_epx_c3.c
@@ -156,6 +156,7 @@ static const struct file_operations epx_c3_fops = {
 	.llseek		= no_llseek,
 	.write		= epx_c3_write,
 	.unlocked_ioctl	= epx_c3_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= epx_c3_open,
 	.release	= epx_c3_release,
 };
diff --git a/drivers/watchdog/sbc_fitpc2_wdt.c b/drivers/watchdog/sbc_fitpc2_wdt.c
index 3822a60a8d2b..1b20b33879c4 100644
--- a/drivers/watchdog/sbc_fitpc2_wdt.c
+++ b/drivers/watchdog/sbc_fitpc2_wdt.c
@@ -186,6 +186,7 @@ static const struct file_operations fitpc2_wdt_fops = {
 	.llseek		= no_llseek,
 	.write		= fitpc2_wdt_write,
 	.unlocked_ioctl	= fitpc2_wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= fitpc2_wdt_open,
 	.release	= fitpc2_wdt_release,
 };
diff --git a/drivers/watchdog/sc1200wdt.c b/drivers/watchdog/sc1200wdt.c
index 960385a766b3..9673eb12dacd 100644
--- a/drivers/watchdog/sc1200wdt.c
+++ b/drivers/watchdog/sc1200wdt.c
@@ -307,6 +307,7 @@ static const struct file_operations sc1200wdt_fops = {
 	.llseek		= no_llseek,
 	.write		= sc1200wdt_write,
 	.unlocked_ioctl = sc1200wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= sc1200wdt_open,
 	.release	= sc1200wdt_release,
 };
diff --git a/drivers/watchdog/sc520_wdt.c b/drivers/watchdog/sc520_wdt.c
index a612128c5f80..fbe79bcc9297 100644
--- a/drivers/watchdog/sc520_wdt.c
+++ b/drivers/watchdog/sc520_wdt.c
@@ -336,6 +336,7 @@ static const struct file_operations wdt_fops = {
 	.open		= fop_open,
 	.release	= fop_close,
 	.unlocked_ioctl	= fop_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 };
 
 static struct miscdevice wdt_miscdev = {
diff --git a/drivers/watchdog/sch311x_wdt.c b/drivers/watchdog/sch311x_wdt.c
index 3612f1df381b..83949a385f62 100644
--- a/drivers/watchdog/sch311x_wdt.c
+++ b/drivers/watchdog/sch311x_wdt.c
@@ -337,6 +337,7 @@ static const struct file_operations sch311x_wdt_fops = {
 	.llseek		= no_llseek,
 	.write		= sch311x_wdt_write,
 	.unlocked_ioctl	= sch311x_wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= sch311x_wdt_open,
 	.release	= sch311x_wdt_close,
 };
diff --git a/drivers/watchdog/scx200_wdt.c b/drivers/watchdog/scx200_wdt.c
index 46268309ee9b..c94098acb78f 100644
--- a/drivers/watchdog/scx200_wdt.c
+++ b/drivers/watchdog/scx200_wdt.c
@@ -201,6 +201,7 @@ static const struct file_operations scx200_wdt_fops = {
 	.llseek = no_llseek,
 	.write = scx200_wdt_write,
 	.unlocked_ioctl = scx200_wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open = scx200_wdt_open,
 	.release = scx200_wdt_release,
 };
diff --git a/drivers/watchdog/smsc37b787_wdt.c b/drivers/watchdog/smsc37b787_wdt.c
index f5713030d0f7..43de56acd767 100644
--- a/drivers/watchdog/smsc37b787_wdt.c
+++ b/drivers/watchdog/smsc37b787_wdt.c
@@ -505,6 +505,7 @@ static const struct file_operations wb_smsc_wdt_fops = {
 	.llseek		= no_llseek,
 	.write		= wb_smsc_wdt_write,
 	.unlocked_ioctl	= wb_smsc_wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= wb_smsc_wdt_open,
 	.release	= wb_smsc_wdt_release,
 };
diff --git a/drivers/watchdog/w83877f_wdt.c b/drivers/watchdog/w83877f_wdt.c
index 6eb5185d6ea6..6b3b667e6f23 100644
--- a/drivers/watchdog/w83877f_wdt.c
+++ b/drivers/watchdog/w83877f_wdt.c
@@ -304,6 +304,7 @@ static const struct file_operations wdt_fops = {
 	.open		= fop_open,
 	.release	= fop_close,
 	.unlocked_ioctl	= fop_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 };
 
 static struct miscdevice wdt_miscdev = {
diff --git a/drivers/watchdog/w83977f_wdt.c b/drivers/watchdog/w83977f_wdt.c
index 16e9cbe72acc..5212e68c6b01 100644
--- a/drivers/watchdog/w83977f_wdt.c
+++ b/drivers/watchdog/w83977f_wdt.c
@@ -446,6 +446,7 @@ static const struct file_operations wdt_fops = {
 	.llseek		= no_llseek,
 	.write		= wdt_write,
 	.unlocked_ioctl	= wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= wdt_open,
 	.release	= wdt_release,
 };
diff --git a/drivers/watchdog/wafer5823wdt.c b/drivers/watchdog/wafer5823wdt.c
index 6d2071a0590d..a6925847f76f 100644
--- a/drivers/watchdog/wafer5823wdt.c
+++ b/drivers/watchdog/wafer5823wdt.c
@@ -230,6 +230,7 @@ static const struct file_operations wafwdt_fops = {
 	.llseek		= no_llseek,
 	.write		= wafwdt_write,
 	.unlocked_ioctl	= wafwdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= wafwdt_open,
 	.release	= wafwdt_close,
 };
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index dbd2ad4c9294..3858094ca6ba 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -933,6 +933,7 @@ static const struct file_operations watchdog_fops = {
 	.owner		= THIS_MODULE,
 	.write		= watchdog_write,
 	.unlocked_ioctl	= watchdog_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= watchdog_open,
 	.release	= watchdog_release,
 };
diff --git a/drivers/watchdog/wdrtas.c b/drivers/watchdog/wdrtas.c
index 6ad7edb4a712..184a06a74f83 100644
--- a/drivers/watchdog/wdrtas.c
+++ b/drivers/watchdog/wdrtas.c
@@ -472,6 +472,7 @@ static const struct file_operations wdrtas_fops = {
 	.llseek		= no_llseek,
 	.write		= wdrtas_write,
 	.unlocked_ioctl	= wdrtas_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= wdrtas_open,
 	.release	= wdrtas_close,
 };
diff --git a/drivers/watchdog/wdt.c b/drivers/watchdog/wdt.c
index 7d278b37e083..f9054cb0f8e2 100644
--- a/drivers/watchdog/wdt.c
+++ b/drivers/watchdog/wdt.c
@@ -523,6 +523,7 @@ static const struct file_operations wdt_fops = {
 	.llseek		= no_llseek,
 	.write		= wdt_write,
 	.unlocked_ioctl	= wdt_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= wdt_open,
 	.release	= wdt_release,
 };
diff --git a/drivers/watchdog/wdt285.c b/drivers/watchdog/wdt285.c
index 4eacfb1ce1ac..4ec0580da76d 100644
--- a/drivers/watchdog/wdt285.c
+++ b/drivers/watchdog/wdt285.c
@@ -181,6 +181,7 @@ static const struct file_operations watchdog_fops = {
 	.llseek		= no_llseek,
 	.write		= watchdog_write,
 	.unlocked_ioctl	= watchdog_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= watchdog_open,
 	.release	= watchdog_release,
 };
diff --git a/drivers/watchdog/wdt977.c b/drivers/watchdog/wdt977.c
index 5c52c73e1839..066a4fb4d75b 100644
--- a/drivers/watchdog/wdt977.c
+++ b/drivers/watchdog/wdt977.c
@@ -422,6 +422,7 @@ static const struct file_operations wdt977_fops = {
 	.llseek		= no_llseek,
 	.write		= wdt977_write,
 	.unlocked_ioctl	= wdt977_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= wdt977_open,
 	.release	= wdt977_release,
 };
diff --git a/drivers/watchdog/wdt_pci.c b/drivers/watchdog/wdt_pci.c
index 66303ab95685..e528024faa41 100644
--- a/drivers/watchdog/wdt_pci.c
+++ b/drivers/watchdog/wdt_pci.c
@@ -566,6 +566,7 @@ static const struct file_operations wdtpci_fops = {
 	.llseek		= no_llseek,
 	.write		= wdtpci_write,
 	.unlocked_ioctl	= wdtpci_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= wdtpci_open,
 	.release	= wdtpci_release,
 };
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index b20228c19ccd..10ba2d9e20bc 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -412,17 +412,6 @@ COMPATIBLE_IOCTL(PPPIOCDISCONN)
 COMPATIBLE_IOCTL(PPPIOCATTCHAN)
 COMPATIBLE_IOCTL(PPPIOCGCHAN)
 COMPATIBLE_IOCTL(PPPIOCGL2TPSTATS)
-/* Watchdog */
-COMPATIBLE_IOCTL(WDIOC_GETSUPPORT)
-COMPATIBLE_IOCTL(WDIOC_GETSTATUS)
-COMPATIBLE_IOCTL(WDIOC_GETBOOTSTATUS)
-COMPATIBLE_IOCTL(WDIOC_GETTEMP)
-COMPATIBLE_IOCTL(WDIOC_SETOPTIONS)
-COMPATIBLE_IOCTL(WDIOC_KEEPALIVE)
-COMPATIBLE_IOCTL(WDIOC_SETTIMEOUT)
-COMPATIBLE_IOCTL(WDIOC_GETTIMEOUT)
-COMPATIBLE_IOCTL(WDIOC_SETPRETIMEOUT)
-COMPATIBLE_IOCTL(WDIOC_GETPRETIMEOUT)
 };
 
 /*
-- 
2.20.0

