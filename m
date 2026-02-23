Return-Path: <linux-fsdevel+bounces-78199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHxnM/7nnGmNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:51:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD9918009B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6451A31A7AC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361A337FF7F;
	Mon, 23 Feb 2026 23:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGR8/mM8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79C523AB9D;
	Mon, 23 Feb 2026 23:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890484; cv=none; b=QrYL1jBC8hhrobK9wlIM7i4fClWJ25G6WKL3n1H0KxN49CcpYbaCuQtUgiusfAVLla0ybNiukxlhMGUc4rm90POqeozehznyEs4KQKUdS688NsjPe7oC43qVpBacuOVd8CgFvol2E87ULe1I5sLGza7+DV2+Rycsq4rSh0l0hIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890484; c=relaxed/simple;
	bh=QHkGWd3+4lKvorCdF1TCF8Nwp5z++0luVlnsW4DBgmw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cuzY8SeLhgc6PLIy84kohvahZm/nrY8vCoJvzJATb5taJP1Kt4WoxucDYAr21su32wBFgq9eWCWg5hS+/+0toHW5y1Nh22Cp3tFO0j/teJY67WcN34IbK5LVuGKgAcdDBP4o4yHBQ7GddQIPs6wd1y7SXJIdN+Ik+izy/A/N5HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGR8/mM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9DAC116C6;
	Mon, 23 Feb 2026 23:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890484;
	bh=QHkGWd3+4lKvorCdF1TCF8Nwp5z++0luVlnsW4DBgmw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FGR8/mM8XsZvhv2PVYlWOmh/78Co84Hc0l0wtz0XV7A3aLJabhOEEzcIEPXYk3w9Z
	 D0rjp7QYKXDio0E0QDAGyDLeb9gABo2LUfCzEZCLSfpnRETc2me5ie7JMIaeGLeY13
	 3DMWbLqmtO1h/q9wg2ULn65rz6pWa1Lz6boQlnUd9THOGrTF0muoCd3uZYCnOCUcjL
	 IHlrYDI28P8Fx7l24U/1KJJzpGVCJw19wUOlHChNHLXzOsYJLm0+6ZAlUypaV8umz8
	 g4gXwwdATFlnEEz8GZyrZlA37mUhJ9l5POndrHunZ9980c+BOBq69rfc/KG/YjNFlk
	 QyxBVej27Ikcg==
Date: Mon, 23 Feb 2026 15:48:03 -0800
Subject: [PATCH 7/8] fuse4fs: make MMP work correctly in safe service mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188746081.3944907.690804051240495856.stgit@frogsfrogsfrogs>
In-Reply-To: <177188745924.3944907.12406087337118974135.stgit@frogsfrogsfrogs>
References: <177188745924.3944907.12406087337118974135.stgit@frogsfrogsfrogs>
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
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78199-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 7AD9918009B
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Normally, the libext2fs MMP code open()s a complete separate file
descriptor to read and write the MMP block so that it can have its own
private open file with its own access mode and file position.  However,
if the unixfd IO manager is in use, it will reuse the io channel, which
means that MMP and the unixfd share the same open file and hence the
access mode and file position.

MMP requires directio access to block devices so that changes are
immediately visible on other nodes.  Therefore, we need the IO channel
(and thus the filesystem) to be running in directio mode if MMP is in
use.

To make this work correctly with the sole unixfd IO manager user
(fuse4fs in unprivileged service mode), we must set O_DIRECT on the
bdev fd and mount the filesystem in directio mode.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index e3d1e080822e16..b12bd926931a69 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -1558,13 +1558,57 @@ static int fuse4fs_service_get_config(struct fuse4fs *ff)
 }
 
 static errcode_t fuse4fs_service_openfs(struct fuse4fs *ff, char *options,
-					int flags)
+					int *flags)
 {
+	struct stat statbuf;
 	char path[32];
+	errcode_t retval;
+	int ret;
+
+	ret = fstat(ff->bdev_fd, &statbuf);
+	if (ret)
+		return errno;
 
 	snprintf(path, sizeof(path), "%d", ff->bdev_fd);
 	iocache_set_backing_manager(unixfd_io_manager);
-	return ext2fs_open2(path, options, flags, 0, 0, iocache_io_manager,
+
+	/*
+	 * Open the filesystem with SKIP_MMP so that we can find out if the
+	 * filesystem actually has MMP.
+	 */
+	retval = ext2fs_open2(path, options, *flags | EXT2_FLAG_SKIP_MMP, 0, 0,
+			      iocache_io_manager, &ff->fs);
+	if (retval)
+		return retval;
+
+	/*
+	 * If the fs doesn't have MMP then we're good to go.  Otherwise close
+	 * the filesystem so that we can reopen it with MMP enabled.
+	 */
+	if (!ext2fs_has_feature_mmp(ff->fs->super))
+		return 0;
+
+	retval = ext2fs_close_free(&ff->fs);
+	if (retval)
+		return retval;
+
+	/*
+	 * If the filesystem is not on a regular file, MMP will share the same
+	 * fd as the unixfd IO channel.  We need to set O_DIRECT on the bdev_fd
+	 * and open the filesystem in directio mode.
+	 */
+	if (!S_ISREG(statbuf.st_mode)) {
+		int fflags = fcntl(ff->bdev_fd, F_GETFL);
+
+		ret = fcntl(ff->bdev_fd, F_SETFL, fflags | O_DIRECT);
+		if (ret)
+			return EXT2_ET_MMP_OPEN_DIRECT;
+
+		ff->directio = 1;
+		*flags |= EXT2_FLAG_DIRECT_IO;
+	}
+
+	return ext2fs_open2(path, options, *flags, 0, 0, iocache_io_manager,
 			&ff->fs);
 }
 
@@ -1845,7 +1889,7 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff)
 	deadline = init_deadline(FUSE4FS_OPEN_TIMEOUT);
 	do {
 		if (fuse4fs_is_service(ff))
-			err = fuse4fs_service_openfs(ff, options, flags);
+			err = fuse4fs_service_openfs(ff, options, &flags);
 		else
 			err = ext2fs_open2(fuse4fs_device(ff), options, flags,
 					   0, 0, iocache_io_manager, &ff->fs);


