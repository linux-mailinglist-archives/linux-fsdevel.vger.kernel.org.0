Return-Path: <linux-fsdevel+bounces-61537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5AAB589B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F1B206700
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC16A1C3BE0;
	Tue, 16 Sep 2025 00:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8w9/el4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405701A3172;
	Tue, 16 Sep 2025 00:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982948; cv=none; b=igbkd2VjpwOiRlJY5fDiuVMbSfFI01G0ZqkczUFri3hXAkO0fEPw0M/43+jHCxeoUowJrUSkCzbtfDAyFQN4WF1Ds6bvnztdP7bpv4CvwhLld0gcygGKetV3BJKjc5aSzimDSe9lOKWp0u46BmY7HmuZYoJ3AUkzJS7GDXZCwmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982948; c=relaxed/simple;
	bh=7AtNwrmnE8bpqFyluiG8900uSmiLQmsRfA2YDBXHMbE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZgP00//Kn9iKMEaSQBXoiWgFoGPevOev7HM6tiEk4b+uy/vOQI/Qdk9B3Y4n3wc6SRLgkXqIbDw3rCt7ladMTk9zC4ZH1cHMN0Ze70e1DbKG5yAGimsn/0kG3L1PaKm3dOob8kK48W7ZBkRzGeg/bP6AGd7CUIXevXIiw1X6MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8w9/el4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E116EC4CEF1;
	Tue, 16 Sep 2025 00:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982947;
	bh=7AtNwrmnE8bpqFyluiG8900uSmiLQmsRfA2YDBXHMbE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=s8w9/el4xVdUVl5MW6lNXyk1zALY0eJ4Iat9HULQY2g+Sl/dOqGHb+tXcqPWyj9vZ
	 KkMku9XoUMQgM5tO8tgCNZHl9LZETj7pCJOz7PCcO6UlRjaNm9Jp7LBnTn8VRlYx1N
	 TizV2ROYRRstxbB4LBn/CHZqsihJgrdEVY+SGIm7Sg5r3HdweQURTLDP/869uFtEZs
	 FPfMjpWv/0OyXVPRbURww4KuraLb5Jiql+T/s4VwtdJmycDPga66qnAR2KONp1tH+c
	 r7vd0lkSfEbYOqoOOKQczoLOheqwWmkfmCFTcq+Rc18SDij7S473LVdn86QwEGu8Rb
	 1VKLAn5+Bpoqg==
Date: Mon, 15 Sep 2025 17:35:47 -0700
Subject: [PATCH 2/3] fuse_trace: make the root nodeid dynamic
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798152140.383798.2151634438327603906.stgit@frogsfrogsfrogs>
In-Reply-To: <175798152081.383798.16940546036390782667.stgit@frogsfrogsfrogs>
References: <175798152081.383798.16940546036390782667.stgit@frogsfrogsfrogs>
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
index 1befea65d4b15c..9c2eb497730b06 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -988,6 +988,7 @@ TRACE_EVENT(fuse_iomap_config,
 
 	TP_STRUCT__entry(
 		__field(dev_t,			connection)
+		__field(uint64_t,		root_nodeid)
 
 		__field(uint32_t,		flags)
 		__field(uint32_t,		blocksize)
@@ -1002,6 +1003,7 @@ TRACE_EVENT(fuse_iomap_config,
 
 	TP_fast_assign(
 		__entry->connection	=	fm->fc->dev;
+		__entry->root_nodeid	=	fm->fc->root_nodeid;
 		__entry->flags		=	outarg->flags;
 		__entry->blocksize	=	outarg->s_blocksize;
 		__entry->max_links	=	outarg->s_max_links;
@@ -1012,8 +1014,8 @@ TRACE_EVENT(fuse_iomap_config,
 		__entry->uuid_len	=	outarg->s_uuid_len;
 	),
 
-	TP_printk("connection %u flags (%s) blocksize 0x%x max_links %u time_gran %u time_min %lld time_max %lld maxbytes 0x%llx uuid_len %u",
-		  __entry->connection,
+	TP_printk("connection %u root_ino 0x%llx flags (%s) blocksize 0x%x max_links %u time_gran %u time_min %lld time_max %lld maxbytes 0x%llx uuid_len %u",
+		  __entry->connection, __entry->root_nodeid,
 		  __print_flags(__entry->flags, "|", FUSE_IOMAP_CONFIG_STRINGS),
 		  __entry->blocksize, __entry->max_links, __entry->time_gran,
 		  __entry->time_min, __entry->time_max, __entry->maxbytes,


