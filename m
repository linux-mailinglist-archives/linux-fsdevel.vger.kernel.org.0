Return-Path: <linux-fsdevel+bounces-78087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDx8E9rgnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:20:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD9817F323
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEC28303919B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BF837F73D;
	Mon, 23 Feb 2026 23:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLAH0oY+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1229125D0;
	Mon, 23 Feb 2026 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888747; cv=none; b=FLiDDJ8QYoQPJ8lOO0TqBxPa2I91GeRH7yZ0egxFxg6+V/VnZEbxEtsk+jgddJyKNNyPzJ+iho8UOZTg8l8F0iH/ZG3tIV0bylm4TOZ4DXdn8MCNaOlccZGyLAd0jLlqzwyxmgWqNQdN46KXlyqH/wD9rVYIxN7x1c2DffboFhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888747; c=relaxed/simple;
	bh=HktYWAhIQohNIclt683aNaIMB8eqpiu8PpxWbxZZHV0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVVQWedtCnF4nvZwnxL6MTjW4dGqH5476jVw9cIq3pXoxAJhGR/WL2L2mvzhIia/AnAv2Zj3gBulW6V6UIjA/z89a5PFm8C8lYoYNgBsgBdT3K89/w31y39UJMIG3uetKt14jh1pGNb7m8/q/E8fpIFlqysbWynCs0gEf41IQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLAH0oY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EFFC116C6;
	Mon, 23 Feb 2026 23:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888747;
	bh=HktYWAhIQohNIclt683aNaIMB8eqpiu8PpxWbxZZHV0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KLAH0oY+YmfwA5t1JoOz/SjicsiHkze58vBAjV1C8av110d/VmleIRY29y7/mlTzt
	 9gF3iNreWE+GLmCKsI5fqLhJI14NgJcC01jD8DFCfKy6C7EBCQQoDyrELD5XcviZwP
	 SMUppSO4wxZ/4ddVuRoNSfk+yJ7128M1tthFg+1eHp314FXrFEDWcUgz0pOQNbykqV
	 8KiG/IdKxouHq2CT5iNlRLTxx64s63JHT8RveI1VGtRMGoG84FhW3RxZWKLQFhJsht
	 9MfW4W2pzMXbAvnrciJbBFC5imRFpYnbQYz5a4FiaX2LPcM+IQhuVneZftmkIEbsVE
	 pYeZQcCI6hFZg==
Date: Mon, 23 Feb 2026 15:19:06 -0800
Subject: [PATCH 4/9] fuse_trace: allow local filesystems to set some VFS
 iflags
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188735612.3937167.5883540940833023614.stgit@frogsfrogsfrogs>
In-Reply-To: <177188735474.3937167.17022266174919777880.stgit@frogsfrogsfrogs>
References: <177188735474.3937167.17022266174919777880.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78087-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9AD9817F323
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |   29 +++++++++++++++++++++++++++++
 fs/fuse/ioctl.c      |    7 +++++++
 2 files changed, 36 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 0016242ff34f62..7136ecf25e1f2b 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -179,6 +179,35 @@ TRACE_EVENT(fuse_request_end,
 		  __entry->unique, __entry->len, __entry->error)
 );
 
+DECLARE_EVENT_CLASS(fuse_fileattr_class,
+	TP_PROTO(const struct inode *inode, unsigned int old_iflags),
+
+	TP_ARGS(inode, old_iflags),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(unsigned int,		old_iflags)
+		__field(unsigned int,		new_iflags)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->old_iflags	=	old_iflags;
+		__entry->new_iflags	=	inode->i_flags;
+	),
+
+	TP_printk(FUSE_INODE_FMT " old_iflags 0x%x iflags 0x%x",
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->old_iflags,
+		  __entry->new_iflags)
+);
+#define DEFINE_FUSE_FILEATTR_EVENT(name)	\
+DEFINE_EVENT(fuse_fileattr_class, name,		\
+	TP_PROTO(const struct inode *inode, unsigned int old_iflags), \
+	TP_ARGS(inode, old_iflags))
+DEFINE_FUSE_FILEATTR_EVENT(fuse_fileattr_update_inode);
+DEFINE_FUSE_FILEATTR_EVENT(fuse_fileattr_init);
+
 #ifdef CONFIG_FUSE_BACKING
 #define FUSE_BACKING_FLAG_STRINGS \
 	{ FUSE_BACKING_TYPE_PASSTHROUGH,	"pass" }, \
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index bd2caf191ce2e0..5180066678e8c1 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -4,6 +4,7 @@
  */
 
 #include "fuse_i.h"
+#include "fuse_trace.h"
 
 #include <linux/uio.h>
 #include <linux/compat.h>
@@ -530,12 +531,16 @@ static void fuse_fileattr_update_inode(struct inode *inode,
 		update_iflag(inode, S_APPEND, fa->fsx_xflags & FS_XFLAG_APPEND);
 	}
 
+	trace_fuse_fileattr_update_inode(inode, old_iflags);
+
 	if (old_iflags != inode->i_flags)
 		fuse_invalidate_attr(inode);
 }
 
 void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *attr)
 {
+	unsigned int old_iflags = inode->i_flags;
+
 	if (!fuse_inode_is_exclusive(inode))
 		return;
 
@@ -547,6 +552,8 @@ void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *attr)
 
 	if (attr->flags & FUSE_ATTR_APPEND)
 		inode->i_flags |= S_APPEND;
+
+	trace_fuse_fileattr_init(inode, old_iflags);
 }
 
 int fuse_fileattr_get(struct dentry *dentry, struct file_kattr *fa)


