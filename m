Return-Path: <linux-fsdevel+bounces-78052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADL9DJnenGm4LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:11:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C490017EF22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A078430707AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A4F37E2FF;
	Mon, 23 Feb 2026 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jetMIQJC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EBD37C0F7;
	Mon, 23 Feb 2026 23:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888199; cv=none; b=WEQC/4FxPw8vEYijrWXbFL2k32++8K8tDzXhwXfW4IAwZF9T3kcYSMXCW7pzJB3FWxw789KeCwi/MeYVQlDLjFKblZB19MBcMzptXk8RSv65D0CJzO77+w2l7bbkPMxU4Kf5nEdQ4hsuqDVI8cGUj3QohNc2V2Norsfh88IYWDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888199; c=relaxed/simple;
	bh=oEs8w5qVI3UZn4t0lpcf/tU0UDILxYde96tBRJcCCzU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZhW7SqvfLihO3BqQXoswLk+MDJZcvng1nYpM7DoK6Hwwfy1UnVexaM0qBovS1pV/WC05qyyTcH7i93wPfLvPs1fnTTzSBCrp0QbnTlRqtO+flp7zwMEU/DaS3siAvoUj5pJ5oDN7zC1NM6m1jymG40uIvuCv4CJhEUEBYQ7fXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jetMIQJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B72C116C6;
	Mon, 23 Feb 2026 23:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888198;
	bh=oEs8w5qVI3UZn4t0lpcf/tU0UDILxYde96tBRJcCCzU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jetMIQJCjDnXDJaWppzq0PHMV8uHbn+7NyzOjHlylF4urtwv12MUfi62iQWZOsilx
	 RivjBjFxWQKwrXBslGp4MJPVtXBF+gcw4qogswzJPnZZlpoUhARXp0r9oNTKXwB542
	 PIrt96vfN0pzKDNsQ/nQwNkRNC6A9MWoAjgQyU5nJF2B9KPmvBhgkgF5RVYodHSA06
	 R5Hz8uPuhP5nXTge5Z/V8eTqK88oIesAScJWuue6MVlkYNj2bQFSjPewi/ynrEzEhC
	 PcQdIHx4FWC9ayfImHB1PZt8CnzKwGMKOzELwpGBATR0dbiVm6lE3/aMnL6ctzNNN7
	 /+waMb/Llhe6w==
Date: Mon, 23 Feb 2026 15:09:58 -0800
Subject: [PATCH 05/33] fuse_trace: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to
 add new iomap devices
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734353.3935739.4840890865463642031.stgit@frogsfrogsfrogs>
In-Reply-To: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
References: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78052-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C490017EF22
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Enhance the existing backing file tracepoints to report the subsystem
that's actually using the backing file.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |   42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index c0878253e7c6ad..af21654d797f45 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -175,6 +175,10 @@ TRACE_EVENT(fuse_request_end,
 );
 
 #ifdef CONFIG_FUSE_BACKING
+#define FUSE_BACKING_FLAG_STRINGS \
+	{ FUSE_BACKING_TYPE_PASSTHROUGH,	"pass" }, \
+	{ FUSE_BACKING_TYPE_IOMAP,		"iomap" }
+
 TRACE_EVENT(fuse_backing_class,
 	TP_PROTO(const struct fuse_conn *fc, unsigned int idx,
 		 const struct fuse_backing *fb),
@@ -184,7 +188,9 @@ TRACE_EVENT(fuse_backing_class,
 	TP_STRUCT__entry(
 		__field(dev_t,			connection)
 		__field(unsigned int,		idx)
+		__field(unsigned int,		type)
 		__field(unsigned long,		ino)
+		__field(dev_t,			rdev)
 	),
 
 	TP_fast_assign(
@@ -193,12 +199,19 @@ TRACE_EVENT(fuse_backing_class,
 		__entry->connection	=	fc->dev;
 		__entry->idx		=	idx;
 		__entry->ino		=	inode->i_ino;
+		__entry->type		=	fb->ops->type;
+		if (fb->ops->type == FUSE_BACKING_TYPE_IOMAP)
+			__entry->rdev	=	inode->i_rdev;
+		else
+			__entry->rdev	=	0;
 	),
 
-	TP_printk("connection %u idx %u ino 0x%lx",
+	TP_printk("connection %u idx %u type %s ino 0x%lx rdev %u:%u",
 		  __entry->connection,
 		  __entry->idx,
-		  __entry->ino)
+		  __print_symbolic(__entry->type, FUSE_BACKING_FLAG_STRINGS),
+		  __entry->ino,
+		  MAJOR(__entry->rdev), MINOR(__entry->rdev))
 );
 #define DEFINE_FUSE_BACKING_EVENT(name)		\
 DEFINE_EVENT(fuse_backing_class, name,		\
@@ -210,7 +223,6 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 #endif /* CONFIG_FUSE_BACKING */
 
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
-
 /* tracepoint boilerplate so we don't have to keep doing this */
 #define FUSE_IOMAP_OPFLAGS_FIELD \
 		__field(unsigned,		opflags)
@@ -452,6 +464,30 @@ TRACE_EVENT(fuse_iomap_end_error,
 		  __entry->written,
 		  __entry->error)
 );
+
+TRACE_EVENT(fuse_iomap_dev_add,
+	TP_PROTO(const struct fuse_conn *fc,
+		 const struct fuse_backing_map *map),
+
+	TP_ARGS(fc, map),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(int,			fd)
+		__field(unsigned int,		flags)
+	),
+
+	TP_fast_assign(
+		__entry->connection	=	fc->dev;
+		__entry->fd		=	map->fd;
+		__entry->flags		=	map->flags;
+	),
+
+	TP_printk("connection %u fd %d flags 0x%x",
+		  __entry->connection,
+		  __entry->fd,
+		  __entry->flags)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */


