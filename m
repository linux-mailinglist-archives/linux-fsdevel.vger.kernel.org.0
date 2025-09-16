Return-Path: <linux-fsdevel+bounces-61530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFC4B589A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892C23B2DFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5358518C933;
	Tue, 16 Sep 2025 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDi0ksRw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60901BC5C;
	Tue, 16 Sep 2025 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982838; cv=none; b=en2YfVPMh4HCWvfIgqxlX1CzKKvUuWQbsgz5JIabC8c808w42A0xVWSU7UjXYwnkUe/DJUz/UEUXATKPvDUIakhSH7EtQi+7igYXlfQF14oL106v2zCRU/enKpA549yXtQOk/nFAzU/7Nmrc1xEnS4f5XMXaBpc4UxeAqwgydXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982838; c=relaxed/simple;
	bh=4NumaOVsQnpBQN9GmZpBCaycxWB/VUAUnt3j90Yhu6c=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=teBNaNs0chokZyIGaeCTZ4iNpiZlaiDQKiYKa9oIloIZcBXPRJNzOgrS2zTEhJ2WSpp945+HH7ITA8hGVid/6yygZP7RxyMm7i8ADJC4EKft3HnQ87croBTHlBNiNr7YcZJFePDDb6pcvc6ltjvMbyUOpaF1HAPO64Zv7otBkOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDi0ksRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAE5C4CEF1;
	Tue, 16 Sep 2025 00:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982838;
	bh=4NumaOVsQnpBQN9GmZpBCaycxWB/VUAUnt3j90Yhu6c=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=IDi0ksRwG0vSwz7cWf/eqLdiu2OoPiYDD/9DuV9jiIWbvG6qzjbeFPwflgF81eRlm
	 ViclqdFFgqy3XXirX4Ma25GLd09s4SovG4GjVGHohyvZbyVQ/70vbF92cO6U7U+jjj
	 oB5dG8a5+dKWZfk/kvT59DM1QKi0k3ChJLnStBuJelWFOawUlDfFbPymvt6fiujzOv
	 cyciTjJ7S5KgaRLOQWHZhIgxjQ8GPpFZIG1k5TVIR9KnlfDiGJDV3w4RiqYC7vPEyk
	 PWtVgFH8rErSypGnf2GM3MjIy95mDvER/ttnW5vvFEFNKUMlPAIGi1DKDRRESpdLUU
	 lax7hjSnI8rSQ==
Date: Mon, 15 Sep 2025 17:33:58 -0700
Subject: [PATCH 23/28] fuse_trace: invalidate ranges of block devices being
 used for iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151759.382724.14763411950940245381.stgit@frogsfrogsfrogs>
In-Reply-To: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
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
index 66b564bcd25360..1cff42bc5907bf 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -1016,6 +1016,32 @@ TRACE_EVENT(fuse_iomap_config,
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
index 9c798435e45633..d2945f8071a296 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1885,6 +1885,8 @@ int fuse_iomap_dev_inval(struct fuse_conn *fc,
 	loff_t end;
 	int ret = 0;
 
+	trace_fuse_iomap_dev_inval(fc, arg);
+
 	if (!fc->iomap || arg->dev == FUSE_IOMAP_DEV_NULL)
 		return -EINVAL;
 


