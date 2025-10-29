Return-Path: <linux-fsdevel+bounces-66035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 098B6C17A9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EE184ED448
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5942D6E51;
	Wed, 29 Oct 2025 00:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn4j2TYQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CF3258ED8;
	Wed, 29 Oct 2025 00:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699214; cv=none; b=RWYZabCwXSapV7frKewOsVGyFjjllCq94lL5FMvj22vRjevvV6RPcLe1A9uwXqWF2D6OvgvtN3nEu13Mg+5aLD+9ZVr5JaTNQUqVhtJh+8F+6dlWYBENvT1t48yXzI8x3O0MsgWeoq+0MDcakU3FqAUzQQPgHtJcHZvPlZDpnyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699214; c=relaxed/simple;
	bh=v63W4gAivma6xTPsQJ0wr2fNBZbqwAzkRzZsuZxbHug=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcyZfKzq+Qk+NdfWSY0CrfNwYYATwUKkVgQYZR0B9AQum3Rsio3ChtoHdb170H17KtwEXxM5h6FekBhhkN8DV51EVMNKDMW87DP2JW2VI3bnjMLR3weMcXjNmm1No+5F9a4R31uDZJahBzmE8C/V9SN2nuuV0BSsUov3XgirDu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn4j2TYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E160FC4CEE7;
	Wed, 29 Oct 2025 00:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699213;
	bh=v63W4gAivma6xTPsQJ0wr2fNBZbqwAzkRzZsuZxbHug=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Dn4j2TYQRE8th1MilZxdW5Cn2vZ3bR2sT7wMHc+VLidMYfvDzq/YEcWh5411YCY5p
	 L+nljfGmX8aAVaqHViHkuyuRswjaZBYykEwSXY0KUhzjNL9kRzMsNOWEGEPjOguMew
	 Up1F49D7ypx1Cgl9Pb/Yc9MZEosCwi4vt105DYdDNEExS9jmJBhYa+zL+gx8un/6oF
	 EzPTt077jIctcGg3at7SSKWEc4PPLGBHAmtE2ql4ncMSLysf8uewWdF/Tb05/x+5bD
	 hWURG6f95mvAma0NclEP12ckkXy8FSBEJZIB5smrmVvoQ1DxYWMtKAyE4va53Kngk7
	 qd93R+yrKNvfQ==
Date: Tue, 28 Oct 2025 17:53:33 -0700
Subject: [PATCH 2/3] fuse_trace: make the root nodeid dynamic
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169811290.1426070.12532889416864507400.stgit@frogsfrogsfrogs>
In-Reply-To: <176169811231.1426070.12996939158894110793.stgit@frogsfrogsfrogs>
References: <176169811231.1426070.12996939158894110793.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Enhance the iomap config tracepoint to report the node id of the root
directory.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index c425c56f71d4af..9a52f258ca3b2b 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -991,6 +991,7 @@ TRACE_EVENT(fuse_iomap_config,
 
 	TP_STRUCT__entry(
 		__field(dev_t,			connection)
+		__field(uint64_t,		root_nodeid)
 
 		__field(uint32_t,		flags)
 		__field(uint32_t,		blocksize)
@@ -1005,6 +1006,7 @@ TRACE_EVENT(fuse_iomap_config,
 
 	TP_fast_assign(
 		__entry->connection	=	fm->fc->dev;
+		__entry->root_nodeid	=	fm->fc->root_nodeid;
 		__entry->flags		=	outarg->flags;
 		__entry->blocksize	=	outarg->s_blocksize;
 		__entry->max_links	=	outarg->s_max_links;
@@ -1015,8 +1017,8 @@ TRACE_EVENT(fuse_iomap_config,
 		__entry->uuid_len	=	outarg->s_uuid_len;
 	),
 
-	TP_printk("connection %u flags (%s) blocksize 0x%x max_links %u time_gran %u time_min %lld time_max %lld maxbytes 0x%llx uuid_len %u",
-		  __entry->connection,
+	TP_printk("connection %u root_ino 0x%llx flags (%s) blocksize 0x%x max_links %u time_gran %u time_min %lld time_max %lld maxbytes 0x%llx uuid_len %u",
+		  __entry->connection, __entry->root_nodeid,
 		  __print_flags(__entry->flags, "|", FUSE_IOMAP_CONFIG_STRINGS),
 		  __entry->blocksize, __entry->max_links, __entry->time_gran,
 		  __entry->time_min, __entry->time_max, __entry->maxbytes,


