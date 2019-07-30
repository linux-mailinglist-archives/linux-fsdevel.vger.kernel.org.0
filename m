Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27ED17B3F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 22:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfG3UDS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 16:03:18 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:55395 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfG3UDR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:03:17 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N3Kc8-1iJOc03PN4-010Ipo; Tue, 30 Jul 2019 22:03:10 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH v5 24/29] compat_ioctl: remove /dev/random commands
Date:   Tue, 30 Jul 2019 22:01:29 +0200
Message-Id: <20190730200145.1081541-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190730200145.1081541-1-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
 <20190730200145.1081541-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ixl6q7ELY2CPbzKLyp5yiEj9Xp94vS2g2+D9pmZiqmQGtHrHVuh
 aP6VLFt1s3Angfhw3puQSSyPIQoMFC8JaAaLkWZaC0dvRz7VXG9RWpet+Nb76KQIPpekFKA
 Nd1b1kdnf+YNa3DAaG/jC8KTP1EdrF4cdI0wOPTlmx9eag5FHB2S6nJ0/Zmfkmri53ukm18
 DiLPEdVaRaX0snXTmEcVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xy4izpXa1kI=:sVc73Mvr8CzeTr6AVkie+W
 Ki5UhfHTqiaYmzPJC1WgRAU3/qCbvvatP5Rs7Ptqozk94PUzdruutiYIu8Yi9TmHALz2GYGkM
 tWCINWkn8QZmmmY1adp3OP3ziuHeI6Y7j1IY5CT8OBjwJ65F31EsPmcDwlIvb12THeTsdBqdg
 +sR3BHARGMJmN+Pk2yX8sCHbu62H99NSWXNFWrdBywrciWeAskzBbkvkNhhqbOTysWybV2rvb
 Jg5icpjkAyglp/JalFGj6qKj3ikZTbpPklBn3O2jXQ4KhwqyO8z/3GPybItzr6wFuyErBcFGm
 R3vUXD7bvcgdguDkbTyCC64OufFxFDtbCXYXv+LYXsTmExt0mPMEoBNK5tHGpfF/dfFAGWNux
 4Qbq3ohc8XRr1M1xAEzmKMPnOH/kLWJBTZu5yorCcBIKgUKE6jFPbiHqKvZzFL8oL7VFi97yI
 R1FVBHf6DWs4TVYLDbCz5Dw3NwFsm5SdnhyDOZI7Tt5pihusWjTSWUBkiZTi11NPXJN4o7+5q
 3XyiNakD9nzjP895d/HTkGHbc/9gP321Wp72L0/3XDifndBv95EGeDMSd1C+1IdqSi5iFTBUV
 lDogv/dbn37ssdB2tuqcGkZjuHQp9HSlWXgvXGpaEyRms6ZeyE3MFHKENtke4SRU7fKkd2gP3
 SVsPm7c6UYAs9ScsaUi/f0THXTBVcXst/zA3YoqdjISfz9Pso5sHTtRxACzRQiz5xfdOTDCOr
 Hnya4c5Mjdv08QPOAW4PHEVzM1OkdB+FnoX8Vw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are all handled by the random driver, so instead of listing
each ioctl, we can use the generic compat_ptr_ioctl() helper.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/random.c | 1 +
 fs/compat_ioctl.c     | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 5d5ea4ce1442..355dc54576f2 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2106,6 +2106,7 @@ const struct file_operations random_fops = {
 	.write = random_write,
 	.poll  = random_poll,
 	.unlocked_ioctl = random_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
 };
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 10dfe4d80bbd..398268604ab7 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -439,13 +439,6 @@ COMPATIBLE_IOCTL(WDIOC_SETTIMEOUT)
 COMPATIBLE_IOCTL(WDIOC_GETTIMEOUT)
 COMPATIBLE_IOCTL(WDIOC_SETPRETIMEOUT)
 COMPATIBLE_IOCTL(WDIOC_GETPRETIMEOUT)
-/* Big R */
-COMPATIBLE_IOCTL(RNDGETENTCNT)
-COMPATIBLE_IOCTL(RNDADDTOENTCNT)
-COMPATIBLE_IOCTL(RNDGETPOOL)
-COMPATIBLE_IOCTL(RNDADDENTROPY)
-COMPATIBLE_IOCTL(RNDZAPENTCNT)
-COMPATIBLE_IOCTL(RNDCLEARPOOL)
 /* Misc. */
 COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
-- 
2.20.0

