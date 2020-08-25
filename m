Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050E425172E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 13:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbgHYLNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 07:13:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36461 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728117AbgHYLNE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 07:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598353982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CVf2pyzjjJBjA3QNt2e9YL5p7a0LopoutHVX8WCtcew=;
        b=EZkjJy7sfoRWItNIN7IetyImyNhQyWbjfMWPTW3kZvSPpMo9Ql7FeL58VsjvWUUBmt6F1d
        UfN+xn5EdkEEX4FoDKqCG5PAqFbZ644vtKbt2XjtsEjbQDXPqAImZwRl8t4x23aELA2U17
        MK8dKvDJ2KzJP2ddghVkJCqzUBzlm2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-HWNRIEmpP8ewjdQKA8Y-4w-1; Tue, 25 Aug 2020 07:13:01 -0400
X-MC-Unique: HWNRIEmpP8ewjdQKA8Y-4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBE3B10066FB;
        Tue, 25 Aug 2020 11:12:59 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-132.ams2.redhat.com [10.36.114.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8328460DA0;
        Tue, 25 Aug 2020 11:12:58 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-fsdevel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] vboxsf: Fix the check for the old binary mount-arguments struct
Date:   Tue, 25 Aug 2020 13:12:57 +0200
Message-Id: <20200825111257.125385-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the check for the mainline vboxsf code being used with the old
mount.vboxsf mount binary from the out-of-tree vboxsf version doing
a comparison between signed and unsigned data types.

This fixes the following smatch warnings:

fs/vboxsf/super.c:390 vboxsf_parse_monolithic() warn: impossible condition '(options[1] == (255)) => ((-128)-127 == 255)'
fs/vboxsf/super.c:391 vboxsf_parse_monolithic() warn: impossible condition '(options[2] == (254)) => ((-128)-127 == 254)'
fs/vboxsf/super.c:392 vboxsf_parse_monolithic() warn: impossible condition '(options[3] == (253)) => ((-128)-127 == 253)'

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 fs/vboxsf/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index 8fe03b4a0d2b..25aade344192 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -384,7 +384,7 @@ static int vboxsf_setup(void)
 
 static int vboxsf_parse_monolithic(struct fs_context *fc, void *data)
 {
-	char *options = data;
+	unsigned char *options = data;
 
 	if (options && options[0] == VBSF_MOUNT_SIGNATURE_BYTE_0 &&
 		       options[1] == VBSF_MOUNT_SIGNATURE_BYTE_1 &&
-- 
2.28.0

