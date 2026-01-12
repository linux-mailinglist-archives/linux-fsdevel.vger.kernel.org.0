Return-Path: <linux-fsdevel+bounces-73244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C643D13569
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 15:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A184630BA4E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D89F2D5C6C;
	Mon, 12 Jan 2026 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRDC+P2Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IdrZZgFN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2D62D1F6B
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229412; cv=none; b=SuWs4ojTwI+JG00sxKREm7R07wQEeulniydYu9j0gZi0jqgcJDT0ce54tVOr4w8rs4/+Kt+obVmF7Hx2a4Ay8JxmK5kNyHYlmkVdGEkJWgjUy1tptsEq1JXxa9KSFUSd2DjvkmyHcNPxqHL6u+CMr0B65jnKk2Orx/Sbi78OwaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229412; c=relaxed/simple;
	bh=lB7wBAy3M3z8P6ED/Qvh7FHLytVcPytGJfFQJNDXzlw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVwDVIQAbx4wiifFxt460uc58vJUhGA2ZqCQ3MUERQhSiWEHcyHuoBzXT4LVxiV8OdBR0eHcMOu9toUFRUP/V9fiEznqpVqznB/xX6tZsXGVba4Z7cU8EL/+Uek1dYWxN/It+mqEj9FnbKXWxV/lqbdHbYX9uXl94e1SeYzC3Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GRDC+P2Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IdrZZgFN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H9nqGXF7VZB/t40lccwLaOeVR9kiIu9hGxW7Aiixpys=;
	b=GRDC+P2YQpzL2dQSL4DEXV8PggJBTcpzcZ9UxLrTpAy1TQyyVUb4iDth8kYjazGe4bZG8P
	dfhRTBt76FBw0oBrsCc6kCZSbhW6B0PcPQktrqXWgHDQ1LgcxF0J3/lkJvvRcjLxGQn3Ak
	JmZ7oYmWuv9ZvKCLfQhDafb38NwL+pk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-o9wGYljANA2YA5IpRmcoYA-1; Mon, 12 Jan 2026 09:50:09 -0500
X-MC-Unique: o9wGYljANA2YA5IpRmcoYA-1
X-Mimecast-MFC-AGG-ID: o9wGYljANA2YA5IpRmcoYA_1768229408
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7cea4b3f15so880872666b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229408; x=1768834208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H9nqGXF7VZB/t40lccwLaOeVR9kiIu9hGxW7Aiixpys=;
        b=IdrZZgFNLD16ASFcHfA8aL+VXrVJ0JKTDsZ/g2KvLLoBvQnTBx1GTbgVJHQ/VVHMAL
         XtOHN4BjRQyX7iRFHBpJhH4r57YQ+aESYXoULm/I7JsV2EF8vXHfFt2ZLqZUHEw/qTBH
         30lFOPVtXHXHCzzoSMKACkbumLGF+7oHuMCMaIfUt5IOzXHueBaOM1EEuPuV3O76Svsl
         dFPJZt6Tzju5DJlwYUoPEaSUNXKlmAyD81MT/JHVcmjzE4AtC3yWT+lHFPOP6X7wNZ/f
         cS8/2KtKmxkMLI6svT63jXfq65SWb3hrqWP4HQDGpbPsE6PhF/wfTNylux/8PkUCqHXE
         8U8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229408; x=1768834208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9nqGXF7VZB/t40lccwLaOeVR9kiIu9hGxW7Aiixpys=;
        b=O6alcDp6+/HuApvkyHrko+EhnsuWK4aD+yBabvr3KPB0a8lALiTmeUEOzcEbIYNVR3
         IqYTrbqvKFFFIm4f1a+zOdV7AQ/QvYnSBUbaWEcxErnyfH/s1e2hto7pCk4Xl8Mrrwy7
         UNiFDA+UBsEEZiXq+M3syfvGH0QZKAHN95KuqBuF+e49FbCe1PSwdK2OADAAjTmMIeVW
         ykD4ImSSzCDgt/CbCTuEXeHNEWwKePGKP9m5yIGmKjrfWynpoTa8sD8ERZoBb41crr9c
         MpbLk94HavXI+OKW0Xdm1WNEolG9B4TPmeNKaqeg2m3sC/w4LKkMPDQE7RqnpWoImNSw
         juRw==
X-Forwarded-Encrypted: i=1; AJvYcCWTwEBTMzM08Fy3MvJ4/cD3SVuvNRLlIcPgifybT04CX7fW+Mr+H3xeq95CsS+N6LXucA2PewR7Pm/8muu9@vger.kernel.org
X-Gm-Message-State: AOJu0YyRJIon6V6FmckZ41QQI608GjHizHAXDjKD56rkz4ZM62qnlf+J
	7k5AejpWYy4Do1vbbmvuoR/dfN6PzvBvhQ9Q9ZL9NIKXdpwo5OChSXNt0EYQIHchY1Y2vMA3LFj
	lQhuiqIz0eEqQuzsbUd2/nlyK5YaYQilVSVxiqVrdqCGCopd2MTdeVo3p/TujCz82vA==
X-Gm-Gg: AY/fxX4NvKGwpMnhBClU2DeGl1O6Bp01573npd5ALZDrdSfPKS8oUtNSc41UE9razkY
	WNofVpTyZJRwVf1+t6CS/iwBLHQ761a8+zwarLIMhJmH849bVdISutgckCG40A/L1qFlMpOwmsL
	KElgBugqFZfreoPUNqmx401RBs0tvKVhopruyIZAdnCVFf8fA1du+Za1+tfc9Cv3GEgUYEA3jHR
	CL6/mfc4+IaHkYurXh9dRGqYOaJcXu94v33Of6mrnSC76FW/xzAJfa+YCohPgwjBLDGMoHUpyvu
	ll8nTRYirxT7CWr9x5Mhkjv6rFmInCM1mzyLpmsigjEK6zZ/FqBfeQ1kPqTGlsOmYRlQCgrTbDU
	=
X-Received: by 2002:a17:907:3f8d:b0:b87:117f:b6ed with SMTP id a640c23a62f3a-b87117fc7e0mr436715966b.21.1768229407943;
        Mon, 12 Jan 2026 06:50:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqMxLNiTQozzXuSioBg+1XMgAdT8qg+RoHIsG2zDVIHtJhfMKwuQp3tBwxWEI5jhYze2cXDg==
X-Received: by 2002:a17:907:3f8d:b0:b87:117f:b6ed with SMTP id a640c23a62f3a-b87117fc7e0mr436712466b.21.1768229407405;
        Mon, 12 Jan 2026 06:50:07 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a27cc6bsm1966748766b.23.2026.01.12.06.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:50:07 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 Jan 2026 15:50:05 +0100
To: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	aalbersh@redhat.com, djwong@kernel.org
Cc: djwong@kernel.org, david@fromorbit.com, hch@lst.de
Subject: [PATCH v2 3/22] iomap: introduce IOMAP_F_BEYOND_EOF
Message-ID: <d5fc72ldfwyzbgiypzlhn5diiqyijxaicpa3w6obx4iismuko3@kttpcgqjy6i5>
References: <cover.1768229271.patch-series@thinky>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768229271.patch-series@thinky>

Flag to indicate to iomap that read/write is happening beyond EOF and no
isize checks/update is needed.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/iomap/buffered-io.c | 13 ++++++++-----
 fs/iomap/trace.h       |  3 ++-
 include/linux/iomap.h  |  5 +++++
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e5c1ca440d..cc1cbf2a4c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -533,7 +533,8 @@
 			return 0;
 
 		/* zero post-eof blocks as the page may be mapped */
-		if (iomap_block_needs_zeroing(iter, pos)) {
+		if (iomap_block_needs_zeroing(iter, pos) &&
+		    !(iomap->flags & IOMAP_F_BEYOND_EOF)) {
 			folio_zero_range(folio, poff, plen);
 			iomap_set_range_uptodate(folio, poff, plen);
 		} else {
@@ -1130,13 +1131,14 @@
 		 * unlock and release the folio.
 		 */
 		old_size = iter->inode->i_size;
-		if (pos + written > old_size) {
+		if (pos + written > old_size &&
+		    !(iter->flags & IOMAP_F_BEYOND_EOF)) {
 			i_size_write(iter->inode, pos + written);
 			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
 		}
 		__iomap_put_folio(iter, write_ops, written, folio);
 
-		if (old_size < pos)
+		if (old_size < pos && !(iter->flags & IOMAP_F_BEYOND_EOF))
 			pagecache_isize_extended(iter->inode, old_size, pos);
 
 		cond_resched();
@@ -1815,8 +1817,9 @@
 
 	trace_iomap_writeback_folio(inode, pos, folio_size(folio));
 
-	if (!iomap_writeback_handle_eof(folio, inode, &end_pos))
-		return 0;
+	if (!(wpc->iomap.flags & IOMAP_F_BEYOND_EOF) &&
+	    !iomap_writeback_handle_eof(folio, inode, &end_pos))
+ 		return 0;
 	WARN_ON_ONCE(end_pos <= pos);
 
 	if (i_blocks_per_folio(inode, folio) > 1) {
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 532787277b..f1895f7ae5 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -118,7 +118,8 @@
 	{ IOMAP_F_ATOMIC_BIO,	"ATOMIC_BIO" }, \
 	{ IOMAP_F_PRIVATE,	"PRIVATE" }, \
 	{ IOMAP_F_SIZE_CHANGED,	"SIZE_CHANGED" }, \
-	{ IOMAP_F_STALE,	"STALE" }
+	{ IOMAP_F_STALE,	"STALE" }, \
+	{ IOMAP_F_BEYOND_EOF,	"BEYOND_EOF" }
 
 
 #define IOMAP_DIO_STRINGS \
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 520e967cb5..7a7e31c499 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -86,6 +86,11 @@
 #define IOMAP_F_PRIVATE		(1U << 12)
 
 /*
+ * IO happens beyound inode EOF
+ */
+#define IOMAP_F_BEYOND_EOF	(1U << 13)
+
+/*
  * Flags set by the core iomap code during operations:
  *
  * IOMAP_F_SIZE_CHANGED indicates to the iomap_end method that the file size

-- 
- Andrey


