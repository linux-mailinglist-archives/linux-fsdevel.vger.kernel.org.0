Return-Path: <linux-fsdevel+bounces-73601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD49D1C864
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 06:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5B2A31EC079
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 04:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9B830AAAF;
	Wed, 14 Jan 2026 04:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dSBOj4wQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51305302151;
	Wed, 14 Jan 2026 04:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768365177; cv=none; b=jBuNv1JGlHhTx/3GqKtv57aic1M3/o36Mz406r/CFpqkAvgr/FwrCKIyWEtVOY2Rxe6vJZAcK+5/lqRWn8sxsRyJYx/3p9JBBpoLqjeYSkiC/Cp06lAohIqcLK3x24XpbYo2O5xRfgiohG2/qcfHSsqYEKKNu1upC4EFvjZYCjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768365177; c=relaxed/simple;
	bh=Gaqat4jw+piMBKROSNm/Id/kd9FzARkuhkgXExJAHe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yzxva9tL0u9F2CMds5Q0YDUeTsBtRCq8wg2X0QuBH2wktsn9xFm4SQqCAKjuplDMk77M3Kub6Lw7lsfoNmo6/PaGsJDu/eg9tQFawEdFz1Hul57Rn2384ff+XWFbgbHWeXujqRcypqdcq5hkxvwOL1ejabFhKh0xuT25SY9+B1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dSBOj4wQ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C4IGWB9h4YXDBFwtQ7Qk1rJLaL0FHlCcZCE95extF/o=; b=dSBOj4wQBA9FpAH4NpK+TpFUYR
	y5DcsbjLUVm51q80Z01h1w35kjdDQR1hj12yNi3PqiQPksYCuu4/SmtgxbrTi4LhQNc4lofS5bf0S
	hn9rR9DJmdQC58QGOTtTvVYqaoL07iiBINhuDiwoS6GyH3tOyEmvF0p2aFot4GlMLcpUo6u8My9Qh
	/lyCoG6eqxbR5UaTizfRFYjds1mZLZXYKn5eD3kXDuZ8/jhjhxJcMvlGBXH8dPS/d6hZi+blw9s7w
	fsx5cBS1/MjQVp1EN3kCkki9gTDWmAr16KlgiKXT3Q4zB2f7bOicFnhaYrw/e71TlSTeKZXGFNPcl
	NkfNI8vA==;
Received: from [177.139.22.247] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vfsYe-0057lT-2r; Wed, 14 Jan 2026 05:32:36 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 14 Jan 2026 01:31:43 -0300
Subject: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com>
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
In-Reply-To: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
To: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Carlos Maiolino <cem@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.3

Some filesystem, like btrfs, supports mounting cloned images, but assign
random UUIDs for them to avoid conflicts. This breaks overlayfs "index"
check, given that every time the same image is mounted, it get's
assigned a new UUID.

Fix this assigning the disk UUID for filesystem that implements the
export operation get_disk_uuid(), so overlayfs check is also against the
same value.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 fs/overlayfs/copy_up.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 758611ee4475..8551681fffd3 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -421,8 +421,26 @@ struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct inode *realinode,
 	struct ovl_fh *fh;
 	int fh_type, dwords;
 	int buflen = MAX_HANDLE_SZ;
-	uuid_t *uuid = &realinode->i_sb->s_uuid;
-	int err;
+	struct super_block *real_sb = realinode->i_sb;
+	uuid_t *uuid = &real_sb->s_uuid, real_uuid;
+	u32 len = sizeof(uuid_t);
+	int err, ret;
+	u64 offset;
+
+	/*
+	 * Some filesystems that support cloned devices may expose random UUIDs
+	 * for userspace, which will cause the upper root origin check to fail
+	 * during a remount. To avoid this, store the real disk UUID.
+	 *
+	 * ENODATA means that the filesystem implements get_disk_uuid(), but
+	 * this instance is using the real UUID so we can skip the operation.
+	 */
+	if (real_sb->s_export_op && real_sb->s_export_op->get_disk_uuid) {
+		ret = real_sb->s_export_op->get_disk_uuid(real_sb, real_uuid.b, &len, &offset);
+
+		if (!ret || ret != ENODATA)
+			uuid = &real_uuid;
+	}
 
 	/* Make sure the real fid stays 32bit aligned */
 	BUILD_BUG_ON(OVL_FH_FID_OFFSET % 4);

-- 
2.52.0


