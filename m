Return-Path: <linux-fsdevel+bounces-78124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBIOBBHjnGn4LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:30:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7D317F7A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4077D30A81BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D51537F8B7;
	Mon, 23 Feb 2026 23:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3V1+IJL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA08437F75D;
	Mon, 23 Feb 2026 23:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889325; cv=none; b=qgAVXj8UfV2K2Wqc4umRch5YczfYjwf2gzbd5ORm6YZjlyPH8SVy7iIAFgQsyMWQRAdJBd1aPqGquXXheeRdjfE7jvV+KmqK6PzVjFQdPVSV/ZgCzwlSCs/Nduh8sgzYM8x6G1glADHPjMWoBXkcivX7YYGwZf0Zw8G7wUtdBTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889325; c=relaxed/simple;
	bh=+ZsxR58QL6TsVTVeVziua7xHC49QlsxWbW6TLv1grT0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XP4BwS5J0UDiGy5rxabSx19HL3RzQnB3EkuDPMFx2P5c+cKHbRgrcSBm6ZT6XJ8iyAFnFvDx0DWu9gOkUGyRRC7C4xEJC1SqKQDJD1APvy8EDcX5MnXNA4LdoGiFcwrt4L/822zmdm+guNfDCRrd4xwdcHgciL7IwfVK/5DjznA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3V1+IJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C599C116C6;
	Mon, 23 Feb 2026 23:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889325;
	bh=+ZsxR58QL6TsVTVeVziua7xHC49QlsxWbW6TLv1grT0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Q3V1+IJLwrrlVkdmUYGtj/k6kAWe7s0WLOHv2r/Dt1yUXJTEHw/9FLaAZco5n431T
	 5TWQJKtsxTvGqFgYwk8BARcUxp0m3rcq91ZphSM8TQj3WjFIJWS8FrxcPDoxVwqvQQ
	 0oyAL3H7cdWrJhCjvdCxvb35C3p8qfNFfZN7qK2jFza8ygjVXJmJ5WfQyHeIzBhtZA
	 DzZLaKbPDb5BqiBRaIvD93TutVXlPETYv2JVBFLkh45Ls1oQ28YB7ou9vWAjiV4LHM
	 Z9NqrfbV8hpE6buqzH+6yu5ooeL7T2IgyYeK0/jSqJ8R43m6Z2mCaZKPEI93oj9rDR
	 KbmBF9mNWPfQA==
Date: Mon, 23 Feb 2026 15:28:44 -0800
Subject: [PATCH 13/25] libfuse: support direct I/O through iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188740168.3940670.10923943350297251384.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78124-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 9A7D317F7A9
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Make it so that fuse servers can ask the kernel fuse driver to use iomap
to support direct IO.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    2 ++
 include/fuse_kernel.h |    3 +++
 lib/fuse_lowlevel.c   |    2 ++
 3 files changed, 7 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index a21f1c8dd12e91..bece561ef3ec9c 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1225,6 +1225,8 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 #define FUSE_IFLAG_DAX			(1U << 0)
 /* exclusive attr mode */
 #define FUSE_IFLAG_EXCLUSIVE		(1U << 1)
+/* use iomap for this inode */
+#define FUSE_IFLAG_IOMAP		(1U << 2)
 
 /* ----------------------------------------------------------- *
  * Compatibility stuff					       *
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 9b0894899ca453..6b1fcc44004dbf 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -245,6 +245,7 @@
  *  - XXX magic minor revision to make experimental code really obvious
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
  *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
+ *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -587,10 +588,12 @@ struct fuse_file_lock {
  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
  * FUSE_ATTR_EXCLUSIVE: This file can only be modified by this mount, so the
  * kernel can use cached attributes more aggressively (e.g. ACL inheritance)
+ * FUSE_ATTR_IOMAP: Use iomap for this inode
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
 #define FUSE_ATTR_EXCLUSIVE	(1 << 2)
+#define FUSE_ATTR_IOMAP		(1 << 3)
 
 /**
  * Open flags
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index f34c86406552f9..23169c1946ce0b 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -166,6 +166,8 @@ static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr,
 		attr->flags |= FUSE_ATTR_DAX;
 	if (iflags & FUSE_IFLAG_EXCLUSIVE)
 		attr->flags |= FUSE_ATTR_EXCLUSIVE;
+	if (iflags & FUSE_IFLAG_IOMAP)
+		attr->flags |= FUSE_ATTR_IOMAP;
 }
 
 static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)


