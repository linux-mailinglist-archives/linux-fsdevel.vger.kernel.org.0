Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1506B26CD4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 22:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgIPU5B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 16:57:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27560 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbgIPQwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600275136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sp0/SuqJJA+dNQKs9AmCAo8k+mDHaLEZwtyll25OTOU=;
        b=dJnPTwhHLEdKXV7G+Wfo9BO9BpSK/pd8F9hTMMLHRMqlBfLH8w+ypvkqWW2+UpL71QssTE
        RnMKmirnL/s3feMIiVGISp6ODOUhd/a6/2bB/WnmZ9o7s3rcuKKfs4hzqSI0I9y4x+gi+o
        33vnwLtFAKj5Re8fbuoX5Ytqck1oJmo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-Znft36czMiC3Kc4wYMf-Ew-1; Wed, 16 Sep 2020 12:17:59 -0400
X-MC-Unique: Znft36czMiC3Kc4wYMf-Ew-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B19491891E83;
        Wed, 16 Sep 2020 16:17:58 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-139.rdu2.redhat.com [10.10.116.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 139A67880E;
        Wed, 16 Sep 2020 16:17:55 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9651A223D0A; Wed, 16 Sep 2020 12:17:54 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, virtio-fs@redhat.com
Subject: [PATCH v2 4/6] fuse: Kill suid/sgid using ATTR_MODE if it is not truncate
Date:   Wed, 16 Sep 2020 12:17:35 -0400
Message-Id: <20200916161737.38028-5-vgoyal@redhat.com>
In-Reply-To: <20200916161737.38028-1-vgoyal@redhat.com>
References: <20200916161737.38028-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a truncate is happening with ->handle_killpriv_v2 is enabled, then
we don't have to send ATTR_MODE to kill suid/sgid as server will
kill it as part of the protocol.

But if this is non-truncate setattr then server will not kill suid/sgid.
So continue to send ATTR_MODE to kill suid/sgid for non-truncate setattr,
even if ->handle_killpriv_v2 is enabled.

This path is taken when client does a write on a file which has suid/
sgid is set. VFS will first kill suid/sgid and then proceed with WRITE.

One can argue that why not simply ignore ATTR_MODE because a WRITE
will follow and ->handle_killpriv_v2 will kill suid/sgid that time.
I feel this is a safer approach for following reasons.

- With ->writeback_cache enabled, WRITE will not go to server. I feel
  that for this reason ->writeback_cache mode is not fully compatible
  with ->handle_killpriv_v2. But if we kill suid/sgid now, this will
  solve this particular issue for ->writeback_cache mode too.

  Again, I will not solve all the issues around ->writeback_cache but
  makes things better.

- If we rely on WRITE killing suid/sgid, then after cache becomes
  out of sync w.r.t host. Client will still have suid/sgid set but
  subsequent WRITE will clear suid/sgid. Well WRITE will also invalidate
  client cache so further access to inode->i_mode should result in
  a ->getattr. Hmm..., for the case of ->writeback_cache, I am
  kind of inclined to send ATTR_MODE.

- We are sending setattr(ATTR_FORCE) anyway (even if we clear ATTR_MODE).
  So if we are not saving on setattr(), why not kill suid/sgid now.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/dir.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ecdb7895c156..4b0fe0828e36 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1655,6 +1655,21 @@ static int fuse_setattr(struct dentry *entry, struct iattr *attr)
 		return -EACCES;
 
 	if (attr->ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID)) {
+		bool kill_sugid = true;
+		bool is_truncate = !!(attr->ia_valid & ATTR_SIZE);
+
+		if (fc->handle_killpriv ||
+		    (fc->handle_killpriv_v2 && is_truncate)) {
+			/*
+			 * If this is truncate and ->handle_killpriv_v2 is
+			 * enabled, we don't have to send ATTR_MODE to
+			 * kill suid/sgid as server will do it anyway as
+			 * part of truncate. But if this is not truncate
+			 * then kill suid/sgid by sending ATTR_MODE.
+			 */
+			kill_sugid = false;
+		}
+
 		attr->ia_valid &= ~(ATTR_KILL_SUID | ATTR_KILL_SGID |
 				    ATTR_MODE);
 
@@ -1664,7 +1679,7 @@ static int fuse_setattr(struct dentry *entry, struct iattr *attr)
 		 *
 		 * This should be done on write(), truncate() and chown().
 		 */
-		if (!fc->handle_killpriv) {
+		if (kill_sugid) {
 			/*
 			 * ia_mode calculation may have used stale i_mode.
 			 * Refresh and recalculate.
-- 
2.25.4

