Return-Path: <linux-fsdevel+bounces-50770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1129ACF56B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 19:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16AE53AC24B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 17:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950CC2797BE;
	Thu,  5 Jun 2025 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKCzNV1D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AD527603F
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749144644; cv=none; b=j5hrpji4APA7G9UxJzMlb643BqsefkU885LuedfdEKGdCNgX7yUNgLz6hI9KAuwR/wrBoO8ovE43vrWRka5eaLa7fE+5ZYK/sOiljSg7iiaPlvQTiuBJAdrA2XGm08l+d4Y9LMCy79gFVFTY+YWWkpCzNPpK1kdCqsiRx2T2SYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749144644; c=relaxed/simple;
	bh=wwNjceRLNn82XbbDj9Vk+tR8yUTme8CFQm9F2eUDIJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TrvwoU6oT0upWoxBHdIbatfIGBlKhI3fxW7zHZ5dCrPjSuXP6YQAC+zW3/cWoUrP/JLsfz4PYYmfy/nelYJDEynAwZVFWM9yb3uNxTdjzKHm8fBpgkNYT7qIp6nrxE7Sevpcbv593wgAFBsYqZsww5NbyJIIIBtib0s53DHMjKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CKCzNV1D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749144641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TdA4MqEs+iXthUcjZmFuz3drXHjXLr7u45s4ZOP6ueQ=;
	b=CKCzNV1DzvJeYFXHhsgjPG5OJx65cVfHXNmWzACJDOAP7xDduVcFbpnY0UnE5NW/GOm0wh
	Gi6LB8qk6Z0EPrW2KtKGjp/rEyPbEZfBoy7An0cnKkOaXHel0iHskBiojgixY7Ganm6gQE
	ttFIsm/SIqc1O/GT8bOCXjaXovK1SUo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-3tqSx6eMOhS7yDV-rnjWdg-1; Thu,
 05 Jun 2025 13:30:36 -0400
X-MC-Unique: 3tqSx6eMOhS7yDV-rnjWdg-1
X-Mimecast-MFC-AGG-ID: 3tqSx6eMOhS7yDV-rnjWdg_1749144635
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5316B1956089;
	Thu,  5 Jun 2025 17:30:35 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.123])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 96A7B30002C0;
	Thu,  5 Jun 2025 17:30:34 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH RFC 7/7] xfs: error tag to force zeroing on debug kernels
Date: Thu,  5 Jun 2025 13:33:57 -0400
Message-ID: <20250605173357.579720-8-bfoster@redhat.com>
In-Reply-To: <20250605173357.579720-1-bfoster@redhat.com>
References: <20250605173357.579720-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

iomap_zero_range() has to cover various corner cases that are
difficult to test on production kernels because it is used in fairly
limited use cases. For example, it is currently only used by XFS and
mostly only in partial block zeroing cases.

While it's possible to test most of these functional cases, we can
provide more robust test coverage by co-opting fallocate zero range
to invoke zeroing of the entire range instead of the more efficient
block punch/allocate sequence. Add an errortag to occasionally
invoke forced zeroing.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

Hi all,

My original test approach involved a hack that redirected fallocate zero
range to iomap. The easiest way to incorporate something like that in
XFS would probably be via a randomized debug branch in the same path
(i.e. similar to what is done in the block/inode allocation paths), but
I find it a little annoying that there's currently no great way to run a
full fstests run with certain error tags enabled.

So for that I was playing around with some fstests hacks to hook into
the device mount paths and enable certain errortags immediately on each
mount. Obviously this implicitly depends on XFS_DEBUG plus the specific
errortag support, but otherwise I'd probably propose something simple
like to enable or disable the whole thing with an XFS_ERRORS_ON=1 type
setting or some such.

So that's the context for this patch. I'm curious if there are any
thoughts..? Another simple option might be to enable certain errortags
by default on XFS_DEBUG, or with XFS_DEBUG plus some new kernel config
option (i.e. XFS_DEBUG_ERRORTAGS). That would be less code in fstests
and perhaps facilitate external testing, but we'd still need to track
which tags get enabled by default in that mode. OTOH, if you consider
the couple or so open coded get_random_u32_below(2) branches we do have,
these are in theory just errortags that happen to be on by default on
XFS_DEBUG kernels (without the log noise). Thoughts?

Brian

 fs/xfs/libxfs/xfs_errortag.h |  4 +++-
 fs/xfs/xfs_error.c           |  3 +++
 fs/xfs/xfs_file.c            | 21 +++++++++++++++------
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_errortag.h b/fs/xfs/libxfs/xfs_errortag.h
index a53c5d40e084..33ca3fc2ca88 100644
--- a/fs/xfs/libxfs/xfs_errortag.h
+++ b/fs/xfs/libxfs/xfs_errortag.h
@@ -65,7 +65,8 @@
 #define XFS_ERRTAG_WRITE_DELAY_MS			43
 #define XFS_ERRTAG_EXCHMAPS_FINISH_ONE			44
 #define XFS_ERRTAG_METAFILE_RESV_CRITICAL		45
-#define XFS_ERRTAG_MAX					46
+#define XFS_ERRTAG_FORCE_ZERO_RANGE			46
+#define XFS_ERRTAG_MAX					47
 
 /*
  * Random factors for above tags, 1 means always, 2 means 1/2 time, etc.
@@ -115,5 +116,6 @@
 #define XFS_RANDOM_WRITE_DELAY_MS			3000
 #define XFS_RANDOM_EXCHMAPS_FINISH_ONE			1
 #define XFS_RANDOM_METAFILE_RESV_CRITICAL		4
+#define XFS_RANDOM_FORCE_ZERO_RANGE			4
 
 #endif /* __XFS_ERRORTAG_H_ */
diff --git a/fs/xfs/xfs_error.c b/fs/xfs/xfs_error.c
index dbd87e137694..00c0c391c329 100644
--- a/fs/xfs/xfs_error.c
+++ b/fs/xfs/xfs_error.c
@@ -64,6 +64,7 @@ static unsigned int xfs_errortag_random_default[] = {
 	XFS_RANDOM_WRITE_DELAY_MS,
 	XFS_RANDOM_EXCHMAPS_FINISH_ONE,
 	XFS_RANDOM_METAFILE_RESV_CRITICAL,
+	XFS_RANDOM_FORCE_ZERO_RANGE,
 };
 
 struct xfs_errortag_attr {
@@ -183,6 +184,7 @@ XFS_ERRORTAG_ATTR_RW(wb_delay_ms,	XFS_ERRTAG_WB_DELAY_MS);
 XFS_ERRORTAG_ATTR_RW(write_delay_ms,	XFS_ERRTAG_WRITE_DELAY_MS);
 XFS_ERRORTAG_ATTR_RW(exchmaps_finish_one, XFS_ERRTAG_EXCHMAPS_FINISH_ONE);
 XFS_ERRORTAG_ATTR_RW(metafile_resv_crit, XFS_ERRTAG_METAFILE_RESV_CRITICAL);
+XFS_ERRORTAG_ATTR_RW(force_zero_range, XFS_ERRTAG_FORCE_ZERO_RANGE);
 
 static struct attribute *xfs_errortag_attrs[] = {
 	XFS_ERRORTAG_ATTR_LIST(noerror),
@@ -230,6 +232,7 @@ static struct attribute *xfs_errortag_attrs[] = {
 	XFS_ERRORTAG_ATTR_LIST(write_delay_ms),
 	XFS_ERRORTAG_ATTR_LIST(exchmaps_finish_one),
 	XFS_ERRORTAG_ATTR_LIST(metafile_resv_crit),
+	XFS_ERRORTAG_ATTR_LIST(force_zero_range),
 	NULL,
 };
 ATTRIBUTE_GROUPS(xfs_errortag);
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 48254a72071b..88ce754ef226 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -27,6 +27,8 @@
 #include "xfs_file.h"
 #include "xfs_aops.h"
 #include "xfs_zone_alloc.h"
+#include "xfs_error.h"
+#include "xfs_errortag.h"
 
 #include <linux/dax.h>
 #include <linux/falloc.h>
@@ -1269,13 +1271,20 @@ xfs_falloc_zero_range(
 	if (error)
 		return error;
 
-	error = xfs_free_file_space(XFS_I(inode), offset, len, ac);
-	if (error)
-		return error;
+	/* randomly force zeroing to exercise zero range */
+	if (XFS_TEST_ERROR(false, XFS_I(inode)->i_mount,
+			   XFS_ERRTAG_FORCE_ZERO_RANGE)) {
+		error = xfs_zero_range(XFS_I(inode), offset, len, ac, NULL);
+	} else {
+		error = xfs_free_file_space(XFS_I(inode), offset, len, ac);
+		if (error)
+			return error;
 
-	len = round_up(offset + len, blksize) - round_down(offset, blksize);
-	offset = round_down(offset, blksize);
-	error = xfs_alloc_file_space(XFS_I(inode), offset, len);
+		len = round_up(offset + len, blksize) -
+			round_down(offset, blksize);
+		offset = round_down(offset, blksize);
+		error = xfs_alloc_file_space(XFS_I(inode), offset, len);
+	}
 	if (error)
 		return error;
 	return xfs_falloc_setsize(file, new_size);
-- 
2.49.0


