Return-Path: <linux-fsdevel+bounces-78132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J2fC5bjnGn4LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:32:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E14C517F88E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B66530A04C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2212A37F8C4;
	Mon, 23 Feb 2026 23:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S28MTu4H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E8C37BE9E;
	Mon, 23 Feb 2026 23:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889450; cv=none; b=Uc7VoRHWkTVOEPTlxo34E2D7Llag2wUEMsCHp6y55xxoB9shTYAlgSx4okhISHbew3oN4dJo2SEnLXvOg1C2//o2yVW78tjKkDSJYvz7FGaA72HQhxxWSI6bEGSS2sqQ0/1WxK7Th89CegURXH8UXdoFOa1CYapXGZi99xRYixU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889450; c=relaxed/simple;
	bh=SiJMhpKEqJDWkg18SE6BCS+4H25lZe66wBnNsNOFun4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfyfVX5U0lJxd9o2hb6H72j97FOF7MNKbB9dm2epYWNKIl4FQgE3FkkTo6sSZOavr40376ZC9w+7XIhRWagzByjq9BT423yC6JAGf/kursg0nsnBUAPZncpAidLSmw+8B/b8Afey58fm1Icz3FD2oszcvPXW7hFXDAIc/p5N6r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S28MTu4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E75C116C6;
	Mon, 23 Feb 2026 23:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889450;
	bh=SiJMhpKEqJDWkg18SE6BCS+4H25lZe66wBnNsNOFun4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=S28MTu4HOBMymvmFxuKNchECBkA7fCzq23Q/E07iq8J5bc8dm5p6g9w48U1Ljpboa
	 MCh9GOD0ciyFU/Su9/lqUMbUnaVlh6GFoJOiIz8ySSQEYiRBIK02Q8dGay8FPjKLf6
	 lQ3Yp/GyjI5adGXA/c1S3NYvTQtEYslv/rv+tVDG/n/CS+VUWX3rtdz6IZJB6RIJHV
	 xB0X3E0BOYF8Fj9X2m+29F+SYsccrGBKGxRjI5IdSA/zmQs2mQpxLuFR3DWQwdqPcO
	 deeyHqZ6yXjjtaKaQgNLzv4ld2IP5GdZi4BtH/wOSGCCRcPyOmYjlw2ItvcsM+kEMG
	 Gd2FoPHe3aF6w==
Date: Mon, 23 Feb 2026 15:30:49 -0800
Subject: [PATCH 21/25] libfuse: allow disabling of fs memory reclaim and write
 throttling
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188740309.3940670.14551552885979850971.stgit@frogsfrogsfrogs>
In-Reply-To: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
References: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78132-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E14C517F88E
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Create a library function so that fuse-iomap servers can ask the kernel
to disable direct memory reclaim for filesystems and BDI write
throttling.

Disabling fs reclaim prevents livelocks where the fuse server can
allocate memory, fault into the kernel, and then the allocation tries to
initiate writeback by calling back into the same fuse server.

Disabling BDI write throttling means that writeback won't be throttled
by metadata writes to the filesystem.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h   |    1 +
 include/fuse_lowlevel.h |   13 +++++++++++++
 lib/fuse_lowlevel.c     |    5 +++++
 lib/fuse_versionscript  |    1 +
 4 files changed, 20 insertions(+)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 71a6a92b4b4a65..0779e3917a1e8f 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1176,6 +1176,7 @@ struct fuse_iomap_support {
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
 #define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
 					     struct fuse_iomap_support)
+#define FUSE_DEV_IOC_SET_NOFS		_IOW(FUSE_DEV_IOC_MAGIC, 100, uint32_t)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 95429ac096a82c..e2127c40940640 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2709,6 +2709,19 @@ int fuse_req_get_payload(fuse_req_t req, char **payload, size_t *payload_sz,
  */
 uint64_t fuse_lowlevel_discover_iomap(int fd);
 
+/**
+ * Disable direct fs memory reclaim and BDI throttling for a fuse-iomap server.
+ * This prevents memory allocations for the fuse server from initiating
+ * pagecache writeback to the fuse server and only throttles writes to the
+ * fuse server's block devices.  The fuse connection must already be
+ * initialized with iomap enabled.
+ *
+ * @param se the session object
+ * @param val 1 to disable fs reclaim and throttling, 0 to enable them
+ * @return 0 on success, or -1 on failure with errno set
+ */
+int fuse_lowlevel_disable_fsreclaim(struct fuse_session *se, int val);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 91aaf6a1183d30..a6b65ccf9fe1df 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -5198,3 +5198,8 @@ uint64_t fuse_lowlevel_discover_iomap(int fd)
 
 	return ios.flags;
 }
+
+int fuse_lowlevel_disable_fsreclaim(struct fuse_session *se, int val)
+{
+	return ioctl(se->fd, FUSE_DEV_IOC_SET_NOFS, &val);
+}
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 56cc5fade272e5..556562f1bb4588 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -248,6 +248,7 @@ FUSE_3.99 {
 		fuse_reply_iomap_config;
 		fuse_lowlevel_iomap_device_invalidate;
 		fuse_fs_iomap_device_invalidate;
+		fuse_lowlevel_disable_fsreclaim;
 } FUSE_3.19;
 
 # Local Variables:


