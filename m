Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2492CB0C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 00:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgLAXXP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 18:23:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22059 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726852AbgLAXXP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 18:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606864908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/VrWq4ROZEETaUG6m+Wv8n9gH98JhhhsUtPF4KnUL34=;
        b=cG6Q6PYaC6038yM32uUs7dDDR9TpnovVQesCrVOmhKe/wVWslogRtjhcsgbisQU/a1dCta
        P9Eh7rmI+yEbdRUdbeWQqFPVgMRRiIhy3dh1WhTOjXXY0tqzAR1qVkKMjon31OZIe8yMe/
        fAybrrFN7s/6jHQ+hmxnuirFRdaXyK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-T4dzLGELMqmpzahP1zvfXw-1; Tue, 01 Dec 2020 18:21:46 -0500
X-MC-Unique: T4dzLGELMqmpzahP1zvfXw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49DF01076027;
        Tue,  1 Dec 2020 23:21:45 +0000 (UTC)
Received: from liberator.sandeen.net (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4189010013C1;
        Tue,  1 Dec 2020 23:21:41 +0000 (UTC)
From:   Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH V2] uapi: fix statx attribute value overlap for DAX &
 MOUNT_ROOT
To:     torvalds@linux-foundation.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Xiaoli Feng <xifeng@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>
Message-ID: <3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com>
Date:   Tue, 1 Dec 2020 17:21:40 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[*] Note: This needs to be merged as soon as possible as it's introducing an incompatible UAPI change...

STATX_ATTR_MOUNT_ROOT and STATX_ATTR_DAX got merged with the same value,
so one of them needs fixing. Move STATX_ATTR_DAX.

While we're in here, clarify the value-matching scheme for some of the
attributes, and explain why the value for DAX does not match.

Fixes: 80340fe3605c ("statx: add mount_root")
Fixes: 712b2698e4c0 ("fs/stat: Define DAX statx attribute")
Reported-by: David Howells <dhowells@redhat.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: David Howells <dhowells@redhat.com>
---
V2: Change flag value per Darrick Wong
    Tweak comment per Darrick Wong
    Add Fixes: tags & reported-by & RVB per dhowells

 include/uapi/linux/stat.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 82cc58fe9368..1500a0f58041 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -171,9 +171,12 @@ struct statx {
  * be of use to ordinary userspace programs such as GUIs or ls rather than
  * specialised tools.
  *
- * Note that the flags marked [I] correspond to generic FS_IOC_FLAGS
+ * Note that the flags marked [I] correspond to the FS_IOC_SETFLAGS flags
  * semantically.  Where possible, the numerical value is picked to correspond
- * also.
+ * also.  Note that the DAX attribute indicates that the file is in the CPU
+ * direct access state.  It does not correspond to the per-inode flag that
+ * some filesystems support.
+ *
  */
 #define STATX_ATTR_COMPRESSED		0x00000004 /* [I] File is compressed by the fs */
 #define STATX_ATTR_IMMUTABLE		0x00000010 /* [I] File is marked immutable */
@@ -183,7 +186,7 @@ struct statx {
 #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
 #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
 #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
-#define STATX_ATTR_DAX			0x00002000 /* [I] File is DAX */
+#define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
 
 
 #endif /* _UAPI_LINUX_STAT_H */
-- 
2.17.0

