Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6229D2CA92C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 18:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389973AbgLAQ6n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 11:58:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728491AbgLAQ6n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606841837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Ro4gapDF/c1vHKexZiNGzqQBi5h9f7igOkn2/s1ehI=;
        b=KfgYPkqjdH2p3lnep1vgh30v2tU4Wai0TvX4BaW/QBimmOn9AI98VV3YDMef30B2boDl45
        3foFcNdNdiid9QdEuZO9Y7tKfFkLboYuDa7j8f0OrdkfUcTaxuz3nY5pK7xMvWRcsu/BHm
        0hTzw0Wrs1xytejzWrgaVTrAJdhm3/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-niUJn-4kNAuxnRoPOyqzVw-1; Tue, 01 Dec 2020 11:57:14 -0500
X-MC-Unique: niUJn-4kNAuxnRoPOyqzVw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E86181084427;
        Tue,  1 Dec 2020 16:57:12 +0000 (UTC)
Received: from liberator.sandeen.net (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D32219D61;
        Tue,  1 Dec 2020 16:57:12 +0000 (UTC)
Subject: [PATCH 1/2] uapi: fix statx attribute value overlap for DAX &
 MOUNT_ROOT
To:     torvalds@linux-foundation.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Xiaoli Feng <xifeng@redhat.com>
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <7027520f-7c79-087e-1d00-743bdefa1a1e@redhat.com>
Date:   Tue, 1 Dec 2020 10:57:11 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

STATX_ATTR_MOUNT_ROOT and STATX_ATTR_DAX got merged with the same value,
so one of them needs fixing. Move STATX_ATTR_DAX.

While we're in here, clarify the value-matching scheme for some of the
attributes, and explain why the value for DAX does not match.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 include/uapi/linux/stat.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 82cc58fe9368..9ad19eb9bbbf 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -171,9 +171,10 @@ struct statx {
  * be of use to ordinary userspace programs such as GUIs or ls rather than
  * specialised tools.
  *
- * Note that the flags marked [I] correspond to generic FS_IOC_FLAGS
+ * Note that the flags marked [I] correspond to the FS_IOC_SETFLAGS flags
  * semantically.  Where possible, the numerical value is picked to correspond
- * also.
+ * also. Note that the DAX attribute indicates that the inode is currently
+ * DAX-enabled, not simply that the per-inode flag has been set.
  */
 #define STATX_ATTR_COMPRESSED		0x00000004 /* [I] File is compressed by the fs */
 #define STATX_ATTR_IMMUTABLE		0x00000010 /* [I] File is marked immutable */
@@ -183,7 +184,7 @@ struct statx {
 #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
 #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
 #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
-#define STATX_ATTR_DAX			0x00002000 /* [I] File is DAX */
+#define STATX_ATTR_DAX			0x00400000 /* File is currently DAX-enabled */
 
 
 #endif /* _UAPI_LINUX_STAT_H */
-- 
2.17.0

