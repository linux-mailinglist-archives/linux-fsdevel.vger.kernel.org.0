Return-Path: <linux-fsdevel+bounces-78082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNPlEyfhnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:22:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D059F17F399
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87AAB317A9A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D930437F72F;
	Mon, 23 Feb 2026 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogR7rDqZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667102749CF;
	Mon, 23 Feb 2026 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888669; cv=none; b=MRZxqhcXgLtO2sBjBFP1wowE7n52QwpDQ011SzjxsqXbqxH+9oJkXO5nFz+tx02WwOIyGYCZtriyEyjoJdrVJXSIKzSqGI7v1eQu5oU4xVDG07SsFzhKfP7FEJGpu5uva8SdoH+slP9I+VFudZ+/4mR0cChnnIk64ITYkxR5M2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888669; c=relaxed/simple;
	bh=4+A9pSHUOhLBxFxPoKWs630EgOZEXLCrG2C400OY4MU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ae4cs+1yHhOsvG9nAM6iE6VKfqR/BJkJnIyl/rR1vRBLSu4yqLNZq7RnjguJ12RGlgFU7D66hjY1AmSkK9CTDL3HsgX0/pETfEGf6hqmOnBYMKVYTl1J7QQ+/ZHvpGRaDuEfFomX49gig6ZyC1I475Wri1krbgrKz4MfeQYM5DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogR7rDqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19130C116C6;
	Mon, 23 Feb 2026 23:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888669;
	bh=4+A9pSHUOhLBxFxPoKWs630EgOZEXLCrG2C400OY4MU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ogR7rDqZe+H85WQnJ9g1LLgR1jOqul65J8gUWpQz5J9v1Zq7OVvowxQIqX6AckQgA
	 C0xpP8aJnUwq4ggARb3WtzJiLrNj7D067a7NBd7lFKVZmYEpqviknjmF8mS4xTL6XN
	 ZzFskU1cEjnK4Hxjseh1/cPd4J5Izfo7OVbIXML9llYV8jPknqLZNgFx/oQsjs1sf8
	 smhe01mN5HZ04Btc6UPgLzRhcs/enAqDQtBxPW326yVA8sFl8dELC0WkGSNm13wJu+
	 h06YU16lrwMdCzi2EPZDbcxU29p1WCzduV98jvW2mNqyGd/EE/II1TCQs9qOY/KF7l
	 Yh6md/1D8D8pg==
Date: Mon, 23 Feb 2026 15:17:48 -0800
Subject: [PATCH 2/3] fuse_trace: make the root nodeid dynamic
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188735224.3936993.11074144693830519570.stgit@frogsfrogsfrogs>
In-Reply-To: <177188735166.3936993.12658858435281080344.stgit@frogsfrogsfrogs>
References: <177188735166.3936993.12658858435281080344.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78082-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D059F17F399
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Enhance the iomap config tracepoint to report the node id of the root
directory.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 63cc1496ee5ca1..0016242ff34f62 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -1026,6 +1026,7 @@ TRACE_EVENT(fuse_iomap_config,
 
 	TP_STRUCT__entry(
 		__field(dev_t,			connection)
+		__field(uint64_t,		root_nodeid)
 
 		__field(uint64_t,		flags)
 		__field(uint32_t,		blocksize)
@@ -1040,6 +1041,7 @@ TRACE_EVENT(fuse_iomap_config,
 
 	TP_fast_assign(
 		__entry->connection	=	fm->fc->dev;
+		__entry->root_nodeid	=	fm->fc->root_nodeid;
 		__entry->flags		=	outarg->flags;
 		__entry->blocksize	=	outarg->s_blocksize;
 		__entry->max_links	=	outarg->s_max_links;
@@ -1050,8 +1052,8 @@ TRACE_EVENT(fuse_iomap_config,
 		__entry->uuid_len	=	outarg->s_uuid_len;
 	),
 
-	TP_printk("connection %u flags (%s) blocksize 0x%x max_links %u time_gran %u time_min %lld time_max %lld maxbytes 0x%llx uuid_len %u",
-		  __entry->connection,
+	TP_printk("connection %u root_ino 0x%llx flags (%s) blocksize 0x%x max_links %u time_gran %u time_min %lld time_max %lld maxbytes 0x%llx uuid_len %u",
+		  __entry->connection, __entry->root_nodeid,
 		  __print_flags(__entry->flags, "|", FUSE_IOMAP_CONFIG_STRINGS),
 		  __entry->blocksize, __entry->max_links, __entry->time_gran,
 		  __entry->time_min, __entry->time_max, __entry->maxbytes,


