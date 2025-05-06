Return-Path: <linux-fsdevel+bounces-48307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F88AAD19E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 01:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D90717C83A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 23:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3502D21D5AA;
	Tue,  6 May 2025 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI6NKVCy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B27021CA04;
	Tue,  6 May 2025 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746574748; cv=none; b=fmBs8AF3a/Wrh+pivPGxKeMuCUO4WD3HhWb4o/cU6FwAG5NkVKZjhevu0v3Z9356LNoFkFYBhFFQeuPrltYvBoA6gPTAPybw+ckEogIGAqI+7TyjIZmQpu2CPZT6v6xr3FrsXS4L7GhCCzTp/XuxxtXb4uAkIjyLDPRSuaJEdIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746574748; c=relaxed/simple;
	bh=RtTfCzdvA8kKTsBb680Ada7FdLAq/TjbjBFv8liv6f8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E0E5ybDpEXpPLcx/srguQdSG9fgIapw6zCih5lJvXAN2ZSjDfvDKqfQb/lqUFpeLUQ6rStRAMYqxz7X8W1lLrZqNcP9J8tyrGAZJIu80QgWj3SR2pPcqvnvjXLEysWo5X9uvY9TZIARpKcJQxe4AmueVRgnQSBn+CyDt5ARUOZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI6NKVCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8697CC4CEE4;
	Tue,  6 May 2025 23:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746574748;
	bh=RtTfCzdvA8kKTsBb680Ada7FdLAq/TjbjBFv8liv6f8=;
	h=Date:From:To:Cc:Subject:From;
	b=MI6NKVCyDtlbvA8NgsKWl5eu7TYLpDcFBcApghEX+IZRhK91Px5/6E2pEijjQ/uaz
	 HUUWXfYx4cnXW3hBANS9SNpeNrF7dKpXEQBPY1bCTDOqpHV5lb8IsDQJXunbkgiYiO
	 tBEt2IXDSpvwyZTvFsEmecOQnWunwLo4u+fxy1fLhegwJvE4taXtnhlsdsgkvJN1U2
	 bH6BwggDrNFWaPYZgy10aARIZ9CF4gQGAs4DIkaIrf5n03SvH2IC6fqEZJ3e2/Us+V
	 4O5P1+BPSXOv8hEWR1mbi0Pp7y/cQXH+ylLs9bEZaXteL/pgWA7qWG500pqO0MO0o2
	 l58zZ1dnQRrrQ==
Date: Tue, 6 May 2025 17:39:03 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] fanotify: Avoid a couple of
 -Wflex-array-member-not-at-end warnings
Message-ID: <aBqdlxlBtb9s7ydc@kspp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Modify FANOTIFY_INLINE_FH() macro, which defines a struct containing a
flexible-array member in the middle (struct fanotify_fh::buf), to use
struct_size_t() to pre-allocate space for both struct fanotify_fh and
its flexible-array member. Replace the struct with a union and relocate
the flexible structure (struct fanotify_fh) to the end.

See the memory layout of struct fanotify_fid_event before and after
changes below.

pahole -C fanotify_fid_event fs/notify/fanotify/fanotify.o

BEFORE:
struct fanotify_fid_event {
        struct fanotify_event      fae;                  /*     0    48 */
        __kernel_fsid_t            fsid;                 /*    48     8 */
        struct {
                struct fanotify_fh object_fh;            /*    56     4 */
                unsigned char      _inline_fh_buf[12];   /*    60    12 */
        };                                               /*    56    16 */

        /* size: 72, cachelines: 2, members: 3 */
        /* last cacheline: 8 bytes */
};

AFTER:
struct fanotify_fid_event {
        struct fanotify_event      fae;                  /*     0    48 */
        __kernel_fsid_t            fsid;                 /*    48     8 */
        union {
                unsigned char      _inline_fh_buf[16];   /*    56    16 */
                struct fanotify_fh object_fh __attribute__((__aligned__(1))); /*    56     4 */
        } __attribute__((__aligned__(1)));               /*    56    16 */

        /* size: 72, cachelines: 2, members: 3 */
        /* forced alignments: 1 */
        /* last cacheline: 8 bytes */
} __attribute__((__aligned__(8)));

So, with these changes, fix the following warnings:

fs/notify/fanotify/fanotify.h:317:28: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/notify/fanotify/fanotify.h:289:28: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/notify/fanotify/fanotify.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index b44e70e44be6..91c26b1c1d32 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -275,12 +275,12 @@ static inline void fanotify_init_event(struct fanotify_event *event,
 	event->pid = NULL;
 }
 
-#define FANOTIFY_INLINE_FH(name, size)					\
-struct {								\
-	struct fanotify_fh name;					\
-	/* Space for object_fh.buf[] - access with fanotify_fh_buf() */	\
-	unsigned char _inline_fh_buf[size];				\
-}
+#define FANOTIFY_INLINE_FH(name, size)						      \
+union {										      \
+	/* Space for object_fh and object_fh.buf[] - access with fanotify_fh_buf() */ \
+	unsigned char _inline_fh_buf[struct_size_t(struct fanotify_fh, buf, size)];   \
+	struct fanotify_fh name;						      \
+} __packed
 
 struct fanotify_fid_event {
 	struct fanotify_event fae;
-- 
2.43.0


