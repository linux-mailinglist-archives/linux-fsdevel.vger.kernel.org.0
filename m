Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50E3CD187F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbfJITOh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:14:37 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:44107 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731815AbfJITLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:16 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MUGuZ-1iiRKk3Akl-00RHrY; Wed, 09 Oct 2019 21:11:13 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH v6 20/43] compat_ioctl: remove HIDIO translation
Date:   Wed,  9 Oct 2019 21:10:20 +0200
Message-Id: <20191009191044.308087-20-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7RMTQj/IzXWYNqxbs38UjXmvOPx/nPUg/Jyhl5K5JkL70CQCnF4
 P7q/KM2dZFFM1mtdBuyaIqUOFQ17HlCzmqS0tuXPXTEirxZH9GS8gORXXirs/gILMvMEyja
 5hNst7E+UHJdZxWMQnw0p3I0VbnvpoDPWpJHRD/vsv8+rHK2g9WQfQad4vs+tpXs/xmRHjT
 MbggUfSSb6Uvr6f+ZBoDQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:x0djXe2zRmc=:ad8+YXein6bQ0QFyxFmaf5
 3H7cUXons26UtN1mFsrj6+7EPNH5+j8wl04KuKJboRJXY6swmLiRvc2JyvfLrEwlXQnApxrrp
 JsHHkVh32zh6mpb/a1ZZzohM0N9ua+czPNFXB8Y5VKPHQB88O2yvmWRJ5v/EO/6e5vCMqGOGn
 HZQrkA8YxrqX8y3mXBAlsGQgF6eWxC9pet/+6xkbNcvRSiUfjTtwLO/D/1bdK3RjjVrMtfX13
 Xf+DT120gHyHUcN0adf2srndF+BLmhNdds4gL9y+YukBzCKnRd/MrjS3PYPYs5CWwjMpwADFF
 ZXD21oeBdqGpQ9N2vhzZzGie+FQ/0pV3U8EI7RuzDHyv+HvmODurkqCyQ589vXvvkzeDfbRcl
 HfFO4XhgNzIKLH2PYpsoE21njqZi8n6u5N8zxYxCSyenIemzI1RWzck/FgqetAymWZeEkblrj
 xuJyI7N908igBl2AWWo8e3QHjMmmKzdx+blAea9rfGZAK7/FKCF3sdtZBV8OhbFgD3rWEPtTI
 Iwx1yNMvY4hiyhHf8ajTTJRvCeyMigqy/MorBDgZNFJdj66MK4Zlx/Itv9rjcv1S8pfERWjlI
 kZbOmbjKQG+w3GcxfAfeCJvE5uqiA+DYh4yJA1duY34hTLQsvBR8qKr7g7lPJpJMlp9C+TCEH
 YB+U6wL6C3kRUyp8skEW6cwIp23vVHz9t8WH5nvk6ypeLbdays2PKFEbiD20MRjpCZXCpgqVB
 Qs5zxUonl/onGJKMvt8dIrbIEdGPfGgHFFX4LZQRmmFlL5iuHF3xzgThTj53kV21/1G8oUnpW
 bomS/5kPMX2XtDxewQlWEkfyyOlvZFLk+OwzZg40ihqyPe2xvxr8qIM1sICy067JDcGPgnlzg
 sBUW1gq3ojBcK0FdJojg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The two drivers implementing these both gained proper compat_ioctl()
handlers a long time ago with commits bb6c8d8fa9b5 ("HID: hiddev:
Add 32bit ioctl compatibilty") and ae5e49c79c05 ("HID: hidraw: add
compatibility ioctl() for 32-bit applications."), so the lists in
fs/compat_ioctl.c are no longer used.

It appears that the lists were also incomplete, so the translation
didn't actually work correctly when it was still in use.

Remove them as cleanup.

Cc: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 758b8b934b70..03da7934a351 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -640,23 +640,6 @@ COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_MEM)
 COMPATIBLE_IOCTL(PCIIOC_WRITE_COMBINE)
-/* hiddev */
-COMPATIBLE_IOCTL(HIDIOCGVERSION)
-COMPATIBLE_IOCTL(HIDIOCAPPLICATION)
-COMPATIBLE_IOCTL(HIDIOCGDEVINFO)
-COMPATIBLE_IOCTL(HIDIOCGSTRING)
-COMPATIBLE_IOCTL(HIDIOCINITREPORT)
-COMPATIBLE_IOCTL(HIDIOCGREPORT)
-COMPATIBLE_IOCTL(HIDIOCSREPORT)
-COMPATIBLE_IOCTL(HIDIOCGREPORTINFO)
-COMPATIBLE_IOCTL(HIDIOCGFIELDINFO)
-COMPATIBLE_IOCTL(HIDIOCGUSAGE)
-COMPATIBLE_IOCTL(HIDIOCSUSAGE)
-COMPATIBLE_IOCTL(HIDIOCGUCODE)
-COMPATIBLE_IOCTL(HIDIOCGFLAG)
-COMPATIBLE_IOCTL(HIDIOCSFLAG)
-COMPATIBLE_IOCTL(HIDIOCGCOLLECTIONINDEX)
-COMPATIBLE_IOCTL(HIDIOCGCOLLECTIONINFO)
 /* joystick */
 COMPATIBLE_IOCTL(JSIOCGVERSION)
 COMPATIBLE_IOCTL(JSIOCGAXES)
-- 
2.20.0

