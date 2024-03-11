Return-Path: <linux-fsdevel+bounces-14164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095A7878981
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 21:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4711C20F90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 20:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43B43C482;
	Mon, 11 Mar 2024 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wUkd7RJv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BA2CA47
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189154; cv=none; b=m4ZmX/wEnb0qXa7h2Qi3YbxxyTVedj8hBDBy9RzJGYr/7t4ZwwXLZWl5VDSG4BZH1wpD9OKRAnBq6U1z+t9oFVlIWY1CyzF6ZJKMjlzoaQRA/yAyNFplHWgvrrn+iRLe1ZinxKu46WVtl+Zpl7nFbMc87MvuC/0lY+rWZVYe80k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189154; c=relaxed/simple;
	bh=JSoTYUAuP34+knTgGqTWdlAaFvpqjYTdSvrz0mHZI70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JBPglDN7aozRLewAkS65GvYzjpAKFsbRi9pIMKUaJj6pdlqlQGX3HN3LsD3gSj8wnlOZztlDds/z9CF+O1UBK4BFIjEJT2J3RWeNM0YZHHY8DCMbjw1oo2ZaInqYbt2j3d57R+7n3Skb02f9qMHiuvBr1V0fjBjZ38FlOAY+3LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wUkd7RJv; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710189149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=93PVRPm3jExltgroLUWMmGHJV0Ed3xhPRujyitTeW7o=;
	b=wUkd7RJv+CSIcNZiKvrTHiaqO7pC4z0c/1friYgRqb8jsYyynnxUnoIMP5mwg1ilvzAz5H
	gbV87lM0vT+NgY3Re6JftVmvRulee/rscUucWI3DfPkCg2513hK/dAZTcqobccF0mg4ycW
	L1wqFutkfCz6n1udYqJBw+l8BmQvLmg=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: 
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Alejandro Colomar <alx@kernel.org>,
	linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] statx.2: Document STATX_SUBVOL
Date: Mon, 11 Mar 2024 16:31:36 -0400
Message-ID: <20240311203221.2118219-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Document the new statxt.stx_subvol field.

This would be clearer if we had a proper API for walking subvolumes that
we could refer to, but that's still coming.

Link: https://lore.kernel.org/linux-fsdevel/20240308022914.196982-1-kent.overstreet@linux.dev/
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
---
 man2/statx.2 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/man2/statx.2 b/man2/statx.2
index 0dcf7e20bb1f..480e69b46a89 100644
--- a/man2/statx.2
+++ b/man2/statx.2
@@ -68,6 +68,7 @@ struct statx {
     /* Direct I/O alignment restrictions */
     __u32 stx_dio_mem_align;
     __u32 stx_dio_offset_align;
+    __u64 stx_subvol;      /* Subvolume identifier */
 };
 .EE
 .in
@@ -255,6 +256,8 @@ STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
 STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
 STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
 	(since Linux 6.1; support varies by filesystem)
+STATX_SUBVOL	Wants stx_subvol
+	(since Linux 6.9; support varies by filesystem)
 .TE
 .in
 .P
@@ -439,6 +442,11 @@ or 0 if direct I/O is not supported on this file.
 This will only be nonzero if
 .I stx_dio_mem_align
 is nonzero, and vice versa.
+.TP
+.I stx_subvolume
+Subvolume number of the current file.
+
+Subvolumes are fancy directories, i.e. they form a tree structure that may be walked recursively.
 .P
 For further information on the above fields, see
 .BR inode (7).
-- 
2.43.0


