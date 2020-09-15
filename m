Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912F026B0ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 00:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgIOWV7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 18:21:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49644 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgIOQ0b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:26:31 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kIDQf-0006J3-1g; Tue, 15 Sep 2020 16:03:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vboxsf: fix comparison of signed char constant with unsigned char array elements
Date:   Tue, 15 Sep 2020 17:03:36 +0100
Message-Id: <20200915160336.36107-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The comparison of signed char constants with unsigned char array
elements leads to checks that are always false. Fix this by declaring
the VBSF_MOUNT_SIGNATURE_BYTE* macros as octal unsigned int constants
rather than as signed char constants. (Argueably the U is not necessarily
required, but add it to be really clear of intent).

Addresses-Coverity: ("Operands don't affect result")
Fixes: 0fd169576648 ("fs: Add VirtualBox guest shared folder (vboxsf) support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/vboxsf/super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index 25aade344192..986efcb29cc2 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -21,10 +21,10 @@
 
 #define VBOXSF_SUPER_MAGIC 0x786f4256 /* 'VBox' little endian */
 
-#define VBSF_MOUNT_SIGNATURE_BYTE_0 ('\000')
-#define VBSF_MOUNT_SIGNATURE_BYTE_1 ('\377')
-#define VBSF_MOUNT_SIGNATURE_BYTE_2 ('\376')
-#define VBSF_MOUNT_SIGNATURE_BYTE_3 ('\375')
+#define VBSF_MOUNT_SIGNATURE_BYTE_0 0000U
+#define VBSF_MOUNT_SIGNATURE_BYTE_1 0377U
+#define VBSF_MOUNT_SIGNATURE_BYTE_2 0376U
+#define VBSF_MOUNT_SIGNATURE_BYTE_3 0375U
 
 static int follow_symlinks;
 module_param(follow_symlinks, int, 0444);
-- 
2.27.0

