Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6EB67B3E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 22:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfG3UB6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 16:01:58 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:53607 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfG3UB6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:01:58 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N4z2Y-1iJx7g20Oa-010r46; Tue, 30 Jul 2019 22:01:56 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 21/29] compat_ioctl: remove HIDIO translation
Date:   Tue, 30 Jul 2019 22:01:26 +0200
Message-Id: <20190730200145.1081541-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190730200145.1081541-1-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
 <20190730200145.1081541-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cGLMrdz2ftVA7JM7GI8tQRavvjPNvWde0+oUJ+i1B0HZ6yecjDl
 tpiXJL8sYfaJuCRKfRXz2kWMjbiNPDzLshRoNOvpsI5eFVW2wOm9EHdXbMb99s0P+gvRZBb
 nChZVeLN5QFMRXcHWPZs2207CRJAZns19pR7cEktAnF/YMScucqPN5uc8znBlMl7QvIq5dq
 4Qhuiud3G0zPCyBIJs9Cw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sjyi9QjQeG8=:h9L/SUSxbtmHhFu4hoU0Ik
 cZEJ7xUKF7FcQig7cHJCMLOJXae4syoYA9HyUM71NdxsXTBsi3KvC7MeBvBsIfel+a+x6OZi8
 +WfpN/s8v8Cylua7AXANPiKZJeTw5/w2i+r6v1mTIIaX04w00oBJ8eOQWuB7fbjSIcELpDSYs
 rYBTSMFqCs8V0XVteKBLQoGELzG/x8itnH9nl2ybe9b1XPARdw7uLYAJloboknNP7y0S6PWYH
 Vyb487r+4jWzFs9zyhlUNNQzWdvDQppYNykwR4qN51/f9h7XT+ligpn1CoJvRmN1ZT7qv11be
 eA9Mrclp759tTNdDkjdd8C0iwO+McpDyL5DZBpSXIr0+p0uGZYKO5N8SBXk5WAM7wZ663uTV3
 pQPTf0ds/C7OweV/W8oVrfcoFi4sphwXluZjiFKF33K71Jlh0sTKjeb8JUd6ea5kst7kuIi51
 AQwi0eUY4AiN3zy67s9jFirzcA/sggOCXIaZkPXs19+bXoessZEdt6g6lE2zL8ZhIiAdGPTZj
 cRqcyAFiEtNBH+N64HuU9ezNHLKqDruDrwnldbIvJ2jp03tprakSv7SjVNfibZCfXhw9sLeR4
 c5h6IhhLLtsO0AJQ+YcChHqoMJyd6mOQCEuqKwH69tAuF1ciPp3ZMW7QZoE15XCQE4MenQQE9
 n8c/HA/TKsu9zBSsTMJ1JzXEw6g4tgYdCn9Hp5sQHhXBb8DzXfZmroi+Rj3Uj4OpsDGK8YIlg
 k0bf1EQ+Hh03M0KqNn7TcgMsknAMD+9B4UOuyQ==
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

