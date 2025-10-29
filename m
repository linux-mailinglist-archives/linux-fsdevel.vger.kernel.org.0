Return-Path: <linux-fsdevel+bounces-66025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAB3C17A60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26F814F6C25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5149A2D641F;
	Wed, 29 Oct 2025 00:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kgp2MV9J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9C533993;
	Wed, 29 Oct 2025 00:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699057; cv=none; b=m0gt8qhpKVRvj5JYsf4H8dh+KTdOK69v+e2uE8F3sva2uNs7UX14Sy33W9R96XUli4b87xq6yfgF5lMOhLQ1aYguDqEeD1FmFM3zQmZ6L53wRoKOWKnzZuqYdPbtHHQ3BMo24mtqgl+hIL2DHbwx3bxRppFi/eg762trK5IX1cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699057; c=relaxed/simple;
	bh=UiF4Hz/GrOfvZJ1X6PwRMGPeeacU5cApz+G1eN3Ud2g=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYCTohepnfINbgy8Gq/t9kt7W20JVutOg4YY2tUxzBDOumG2PSSpQGGqdHtkZXmYLUst+Hfq/I9GP+K7lncxwWWAQIGHiFJk6ZRVFLA0huHnS2vba5U4uh0p3KjkBJs18HPZkfsoVblcYUY6jOhoP9pes1WL4Q867cVfuhWfIeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kgp2MV9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833BFC4CEE7;
	Wed, 29 Oct 2025 00:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699057;
	bh=UiF4Hz/GrOfvZJ1X6PwRMGPeeacU5cApz+G1eN3Ud2g=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Kgp2MV9JCgQZDw9LFxJGLZAJcE1b0kNS+6TvEjISdy2Fc4EaSVkEVjjZhxoeJd/Ik
	 KFWbgwU0WIqWyc90TCAk82NRI+l8wUrPnpQY+xqTACG2R00D1CyVYa2TbCcTLQU8ey
	 KeWffjfJZ/vCvoSJOA8icvUPPdkI1u5wFEeeftPB1DxXPUGGE5FYpqJWmPa316TRfE
	 bCQ/MINoKGmyfTk9tpoj4WzfSExOa8ScDxl7b1rP3WfIQrZNT6sGwCM+1F6vxXF1t2
	 iWFxgW61DfzaLd4HcSJ089goe18ug76Wqib9XyIXOqLuv3V1mauxjRPwrDxpjBlyCB
	 OjrG9lFGk09/g==
Date: Tue, 28 Oct 2025 17:50:57 -0700
Subject: [PATCH 23/31] fuse_trace: invalidate ranges of block devices being
 used for iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810852.1424854.13302856886300712707.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |   26 ++++++++++++++++++++++++++
 fs/fuse/file_iomap.c |    2 ++
 2 files changed, 28 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 6f973149ca72f0..67b9bd8ea52b79 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -1018,6 +1018,32 @@ TRACE_EVENT(fuse_iomap_config,
 		  __entry->time_min, __entry->time_max, __entry->maxbytes,
 		  __entry->uuid_len)
 );
+
+TRACE_EVENT(fuse_iomap_dev_inval,
+	TP_PROTO(const struct fuse_conn *fc,
+		 const struct fuse_iomap_dev_inval_out *arg),
+	TP_ARGS(fc, arg),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(int,			dev)
+		__field(unsigned long long,	offset)
+		__field(unsigned long long,	length)
+	),
+
+	TP_fast_assign(
+		__entry->connection	=	fc->dev;
+		__entry->dev		=	arg->dev;
+		__entry->offset		=	arg->offset;
+		__entry->length		=	arg->length;
+	),
+
+	TP_printk("connection %u dev %d offset 0x%llx length 0x%llx",
+		  __entry->connection,
+		  __entry->dev,
+		  __entry->offset,
+		  __entry->length)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 332f41eeaf0a87..ebf154d70ccfe2 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1906,6 +1906,8 @@ int fuse_iomap_dev_inval(struct fuse_conn *fc,
 	loff_t end;
 	int ret = 0;
 
+	trace_fuse_iomap_dev_inval(fc, arg);
+
 	if (!fc->iomap || arg->dev == FUSE_IOMAP_DEV_NULL)
 		return -EINVAL;
 


