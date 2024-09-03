Return-Path: <linux-fsdevel+bounces-28423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A9496A211
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 17:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDB71C23672
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51014192B8C;
	Tue,  3 Sep 2024 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vYYS8ckV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118F11922F8
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376635; cv=none; b=MwzLotu5OBsQxj45D7fDtHP5PF7z1ABXGVUHYMae2m4qI3KhKKWCq+2KpqDeM+6FD4q/LkX1zlBSu4VgCXLTTLdkrPC7Yl6Y4Xw4oHTu4zsadCOj1vhDiuMnl6M9AwQpIip7jeaukwywKHbyWXmtGlhoYur5JEFtQIPYOhH/60o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376635; c=relaxed/simple;
	bh=zCrcaSPlVef9fMgj6fnLuhDo1m+kzv16tHWQShTiBI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M9Gr48LnY9x7hqScN5fcTV1GLDxMHJPCVL0WfGoXsFB5WK3RZa0CYC4KBx6BEJMPVU4ccktjeT1lnNIH2QAC4tpbF0GUnRKUA6HQkkWmv36eikSQBYMyhnQ8nL2/9SisZIH44G4coP9NglouUKHRi+aLyXXkdeQO2KdDKD3yrnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vYYS8ckV; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6AF9E3FC04
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376631;
	bh=btta7JvkwVu4o++SpqzGVQUNPal7Y+ZsmtoSEosWuhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=vYYS8ckVqaTMWNJBCPphlcouEvbpQ2KhpU/o3bXj7JehDaFasNpBRRcwslGJytNXP
	 G68b3Wgtu8Oz//s9oxjH65eYh0YWsNkLsa1e9PbHfiO1v8XbhcQj+QeklBAjzFxspI
	 Gc6ZdOic9CaCy3KpF+nUVTKjMJHu0JrQC2Xvy9fVqHZudyLFdRLblMG5T+qTrZP8Ya
	 VsISIcnC5UQrMuWdPPOoD3ZcwVjjjWoQq5sefhc0s6DyVXPfTM/feNuf/kM2yTNufo
	 3ptaApsEM5/Px+NIxZulySycVhrslzeams5WVkfjGE6cNKfLN5HfAu5G2cUvj52Psi
	 3tOiPI8mGXedA==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5343808962cso6211042e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 08:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376631; x=1725981431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btta7JvkwVu4o++SpqzGVQUNPal7Y+ZsmtoSEosWuhw=;
        b=l9rh+iHn07GVLJOZZSluZGbHP1TSFsa1vTtgupjoSEE/XxoVjiYJf7bqjMCw4nQsBj
         K2DDbTsp98lzCn5RodmGsyLYXVMQULq3VMoFyHGu1VGXUrR4fN+1ZlvxZ+UG9TXOO011
         79MXQZ9tNNxS7BZFlkqI1XO4beu3g1Nv2F7tX64h1os+sz/gq0r49vcj2FgGD4s2N7uv
         QUFVk3SUPiza/reTZSUvuXiTaSN4Bq5jiBblsQX9AHDWNWeLAuVrVs0ub42KlzKn3kY8
         3DFKjNsCkmfxSBFlIgmrIOtr9EmgIxMqDzvf+8ep4tBg5ielPqhBQjVe9/NB1SM2W2ML
         hMWg==
X-Forwarded-Encrypted: i=1; AJvYcCVdxk1j9EfVnenDI36go+jbJXzODKSgaCY5roXenkXRt+l3nJ4z8WGNX0N5DJvylWLPqY6xNQ9QM3dUL59A@vger.kernel.org
X-Gm-Message-State: AOJu0YzaDiYwtPBqUg6e6nXTpBswTxNBOWHsRP/JJWFeaB6wCCAdjbT2
	r5RQkUMYkxKq2Ja0wpQjDPIflkldRGadD+GHyWdbODUldFlOWFymtWRTraHqXUhRQfO7ZQM+Jbw
	WJoPuXx+dNN7sGdl3qfkYy2VaP0FLN6pTvYuOx27dpH5RXdVqB6I77BfSx0Dj0hxet8IJFf618G
	b9AOo=
X-Received: by 2002:a05:6512:2215:b0:533:4676:c218 with SMTP id 2adb3069b0e04-53546b191c1mr10714026e87.8.1725376630617;
        Tue, 03 Sep 2024 08:17:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9/hcou3cmyT9HFV+yv/KjP2e+D8E+jeLocrBSGTUTM5RMK5sgega+1/hOouRDW8vLnMtf4A==
X-Received: by 2002:a05:6512:2215:b0:533:4676:c218 with SMTP id 2adb3069b0e04-53546b191c1mr10713999e87.8.1725376630113;
        Tue, 03 Sep 2024 08:17:10 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:17:09 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/15] fs/fuse: support idmapped ->set_acl
Date: Tue,  3 Sep 2024 17:16:21 +0200
Message-Id: <20240903151626.264609-11-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's just a matter of adjusting a permission check condition
for S_ISGID flag. All the rest is already handled in the generic
VFS code.

Notice that this permission check is the analog of what
we have in posix_acl_update_mode() generic helper, but
fuse doesn't use this helper as on the kernel side we don't
care about ensuring that POSIX ACL and CHMOD permissions are in sync
as it is a responsibility of a userspace daemon to handle that.
For the same reason we don't have a calls to posix_acl_chmod(),
while most of other filesystem do.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 fs/fuse/acl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 897d813c5e92..8f484b105f13 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -144,8 +144,8 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * be stripped.
 		 */
 		if (fc->posix_acl &&
-		    !in_group_or_capable(&nop_mnt_idmap, inode,
-					 i_gid_into_vfsgid(&nop_mnt_idmap, inode)))
+		    !in_group_or_capable(idmap, inode,
+					 i_gid_into_vfsgid(idmap, inode)))
 			extra_flags |= FUSE_SETXATTR_ACL_KILL_SGID;
 
 		ret = fuse_setxattr(inode, name, value, size, 0, extra_flags);
-- 
2.34.1


