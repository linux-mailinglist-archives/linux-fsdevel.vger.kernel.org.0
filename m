Return-Path: <linux-fsdevel+bounces-14270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF09787A3FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 09:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06C21C21730
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 08:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8253520DDC;
	Wed, 13 Mar 2024 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILWkOZxB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B22D1BC3B
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710317718; cv=none; b=Sd4Qhn8NsvaLZu5htmhIuGp0r7hUU1WV6eiFYryLDCBL4ULRsRXBVsa5v2jrSR4nV3Jnmg0tr8qhrCWOtYWhSzNrHYnR9x3zlIdb0x/EELIS209XgbxBzfFTqywTl0JHiigqV2CDqn9dP6UzfSuAnBKRZYpcHOKWeuPzhTiT6aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710317718; c=relaxed/simple;
	bh=2JhikHnvZA+K8h+nUpROY6IhHBbfBTTzo4tCnXSdzbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umm3GOra8BHXQK5XLLcjLTGDoJb1ldkAH1xiJZk46pcPBQVcduoRm4w4dCjH2bidUhob7lhGK+Y++VvG9Jo3UyAhJ2zUubTgpzk3cCWarS/cs2VocFolXndT/H2s4ihd8Jo8pMylfdhw0ZuKZTOtrbxEPqZfjyr746vcJ5a9PxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ILWkOZxB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710317715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91bNCNkvqiMRdaqnUe2NMNtpy4+Y+1Q/++18wDtAqbY=;
	b=ILWkOZxBUU8VlZ0p5q1mqoJeVpJg2RCpgyjXkR/y6H5qjZNCMEYrjWoX+fXF2xTr5GOZpI
	aQ3zjGO/1l48Muf1xW3T6xICFub5FO/CBug1Rqg6me0Ln6QpSKDWKCq+9TQcOIpPVc6dFz
	HWYix+9xgmKkVLnlylZ8RTMkhXdWlM8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-79ungZldNcmTSKzd7Pbu6w-1; Wed,
 13 Mar 2024 04:15:11 -0400
X-MC-Unique: 79ungZldNcmTSKzd7Pbu6w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C5FF3C000B3;
	Wed, 13 Mar 2024 08:15:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 982FD40C6CB2;
	Wed, 13 Mar 2024 08:15:10 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] afs: Fix occasional rmdir-then-VNOVNODE with generic/011
Date: Wed, 13 Mar 2024 08:15:03 +0000
Message-ID: <20240313081505.3060173-3-dhowells@redhat.com>
In-Reply-To: <20240313081505.3060173-1-dhowells@redhat.com>
References: <20240313081505.3060173-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Sometimes generic/011 causes kafs to follow up an FS.RemoveDir RPC call by
spending around a second sending a slew of FS.FetchStatus RPC calls to the
directory just deleted that then abort with VNOVNODE, indicating deletion
of the target directory.

This seems to stem from userspace attempting to stat the directory or
something in it:

    afs_select_fileserver+0x46d/0xaa2
    afs_wait_for_operation+0x12/0x17e
    afs_fetch_status+0x56/0x75
    afs_validate+0xfb/0x240
    afs_permission+0xef/0x1b0
    inode_permission+0x90/0x139
    link_path_walk.part.0.constprop.0+0x6f/0x2f0
    path_lookupat+0x4c/0xfa
    filename_lookup+0x63/0xd7
    vfs_statx+0x62/0x13f
    vfs_fstatat+0x72/0x8a

The issue appears to be that afs_dir_remove_subdir() marks the callback
promise as being cancelled by setting the expiry time to AFS_NO_CB_PROMISE
- which then confuses afs_validate() which sends the FetchStatus to try and
get a new one before it checks for the AFS_VNODE_DELETED flag which
indicates that we know the directory got deleted.

Fix this by:

 (1) Make afs_check_validity() return true if AFS_VNODE_DELETED is set, and
     then tweak the return from afs_validate() if the DELETED flag is set.

 (2) Move the AFS_VNODE_DELETED check in afs_validate() up above the
     expiration check to immediately after we've grabbed the validate_lock.

Fixes: 453924de6212 ("afs: Overhaul invalidation handling to better support RO volumes")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/validation.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/afs/validation.c b/fs/afs/validation.c
index 46b37f2cce7d..32a53fc8dfb2 100644
--- a/fs/afs/validation.c
+++ b/fs/afs/validation.c
@@ -122,6 +122,9 @@ bool afs_check_validity(const struct afs_vnode *vnode)
 	const struct afs_volume *volume = vnode->volume;
 	time64_t deadline = ktime_get_real_seconds() + 10;
 
+	if (test_bit(AFS_VNODE_DELETED, &vnode->flags))
+		return true;
+
 	if (atomic_read(&volume->cb_v_check) != atomic_read(&volume->cb_v_break) ||
 	    atomic64_read(&vnode->cb_expires_at)  <= deadline ||
 	    volume->cb_expires_at <= deadline ||
@@ -389,12 +392,17 @@ int afs_validate(struct afs_vnode *vnode, struct key *key)
 	       key_serial(key));
 
 	if (afs_check_validity(vnode))
-		return 0;
+		return test_bit(AFS_VNODE_DELETED, &vnode->flags) ? -ESTALE : 0;
 
 	ret = down_write_killable(&vnode->validate_lock);
 	if (ret < 0)
 		goto error;
 
+	if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
+		ret = -ESTALE;
+		goto error_unlock;
+	}
+
 	/* Validate a volume after the v_break has changed or the volume
 	 * callback expired.  We only want to do this once per volume per
 	 * v_break change.  The actual work will be done when parsing the
@@ -448,12 +456,6 @@ int afs_validate(struct afs_vnode *vnode, struct key *key)
 	vnode->cb_ro_snapshot = cb_ro_snapshot;
 	vnode->cb_scrub = cb_scrub;
 
-	if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
-		_debug("file already deleted");
-		ret = -ESTALE;
-		goto error_unlock;
-	}
-
 	/* if the vnode's data version number changed then its contents are
 	 * different */
 	zap |= test_and_clear_bit(AFS_VNODE_ZAP_DATA, &vnode->flags);


