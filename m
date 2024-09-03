Return-Path: <linux-fsdevel+bounces-28415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEC696A1F9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 17:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90ED51F26DD9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66289189BAD;
	Tue,  3 Sep 2024 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FC+OgzKo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBAD188A3B
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376616; cv=none; b=Y587Q/DUB0tvaNKpd4X/TOxyYcASB2dxuJkxXL2E/KIyx/JCVZLgfUYESIjq5PLta3Scr7TXgAhlGZMWkOGNFKd3qrFmsmD8wTuATTg0GVZkkxqZEy5Yxc5h2s4SrS/3iJfObOOZ4ZnhthKxtEOZ+bfn2dUStqfkoII7Nq3J6yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376616; c=relaxed/simple;
	bh=+65lnekXMhI1t21zuHkzMVhnAJ/aGY9ksednbDEEX24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Szhfepfbs33ahKHgi7uTfhUmdoBZbO9gtIL+HgcePIwSddvqVEmgtweTzCbeieI0Bo5z6wM+/srnINhmQrhWyTpVgYxnqq9xJ2ypc7Bm/fesMUGnmBVaZhn0UHpXQRMbRdvH4nJib4n9oUP2mIzrIJyLTmZDzHEyPhmZ8046dIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=FC+OgzKo; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B90BF3FE1C
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376607;
	bh=j3VPDcvR6dDhs8ZQ9mZ4n82aTjnb//+beKKdu3S1mOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=FC+OgzKoplrRZ3LZvzUa47yyNi4xzPI33BUErX699JruaOKmXF5QsuVZzA+6an2zT
	 +a8H2yxwSA3k7+cbkqjx7xJ7JQJUGjvLojwUm/J/DEeWdPhUQ1IDO5762hLwpEfmRe
	 3usFe+hYf2NoIe0QOACAIQBj5CjaBM9uc53mPL9o07SQrEfwbqDa/IglYTdQRFW3qO
	 dVjC0PFcVToaJb+mZPBkHJ5H8chMY/39ZeomXnKqc1k97d+y8PnglierdKUE32C/Mf
	 kEmmeXi7566nbWsXTMTeSYeGItVsPu2Zt6y5/k+DJ7Eu4ok0bNVraBz9TwhVOFMMEs
	 dQYEwieDLomhQ==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8696019319so395843766b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 08:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376607; x=1725981407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3VPDcvR6dDhs8ZQ9mZ4n82aTjnb//+beKKdu3S1mOA=;
        b=YIDiDpFHxhn4hV/ppwenVXMEmir41XAPX3/HdgU8qv4gVpAsnGkWUS+3SyDUX+Lkvb
         tvBWDH+PIE1A4fyilwEJkNaMjdRmShicTFeHbjaeBK2mPqV/dRf+PBCr5SLACa7g7mNt
         oQtYaxlI8X1hYpCZcX7j8EmlH3JyuSDNxE6WweFPaCc6c/3fmXgG/xbhmycN+TuYhwsO
         TudTJB9ytowvib1zQ8GRK/Q0J9WbEgSLzf8U/wsQTWGVtoXTt4HM8VR+0NdgcupAw//0
         uQavBniNJb570+dG1p+GBJCjDwA2G6Jx4OklNVpdmg8qCeAepzm3TxpmqV1D8HcRth/v
         xJLA==
X-Forwarded-Encrypted: i=1; AJvYcCXIZEMeEbAidSwtNVv/sAtG5e1bQCMjzjQKkDX2+w8Y7wfcQ95tvqejuwfQDgJOeQnYlI+nOUNpf/EItzjd@vger.kernel.org
X-Gm-Message-State: AOJu0YyWK7dol+CN91MOSiVnLSaoa7GfZaUD3HYJ+TMyvXacb3VBMyPn
	/T1TVgkSPl2czD09HLgmlzWLI+3OeeRwMs7vlsMxwAJEAPSLU/aSX1E5pky0Ctbr5RrC0arwpZZ
	wOM2V/8qsxzCwwdGsCTRMlIT2d22vwzcnbJW6mqP4ZV3stkJlvszUO3g7sjIcWIZrhajHUDt5LG
	sXaGI=
X-Received: by 2002:a17:907:7f29:b0:a7a:b4bd:d0eb with SMTP id a640c23a62f3a-a89b94cef55mr877281766b.24.1725376606805;
        Tue, 03 Sep 2024 08:16:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeYN6hRfAhuD0+4Q5mLVtZ2Al7kWcPr9w+dVvPFIc/c9/ume9/DhCoB3QIXHG+d0EhOrXsgQ==
X-Received: by 2002:a17:907:7f29:b0:a7a:b4bd:d0eb with SMTP id a640c23a62f3a-a89b94cef55mr877278866b.24.1725376606295;
        Tue, 03 Sep 2024 08:16:46 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:16:45 -0700 (PDT)
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
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/15] fs/namespace: introduce SB_I_NOIDMAP flag
Date: Tue,  3 Sep 2024 17:16:12 +0200
Message-Id: <20240903151626.264609-2-aleksandr.mikhalitsyn@canonical.com>
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

Right now we determine if filesystem support vfs idmappings
or not basing on the FS_ALLOW_IDMAP flag presence. This
"static" way works perfecly well for local filesystems
like ext4, xfs, btrfs, etc. But for network-like filesystems
like fuse, cephfs this approach is not ideal, because sometimes
proper support of vfs idmaps requires some extensions for the on-wire
protocol, which implies that changes have to be made not only
in the Linux kernel code but also in the 3rd party components like
libfuse, cephfs MDS server and so on.

We have seen that issue during our work on cephfs idmapped mounts [1]
with Christian, but right now I'm working on the idmapped mounts
support for fuse/virtiofs and I think that it is a right time for this extension.

[1] 5ccd8530dd7 ("ceph: handle idmapped mounts in create_request_message()")

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
v3:
	- this commit added
---
 fs/namespace.c     | 4 ++++
 include/linux/fs.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 328087a4df8a..d1702285c915 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4436,6 +4436,10 @@ static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
 	if (!(m->mnt_sb->s_type->fs_flags & FS_ALLOW_IDMAP))
 		return -EINVAL;
 
+	/* The filesystem has turned off idmapped mounts. */
+	if (m->mnt_sb->s_iflags & SB_I_NOIDMAP)
+		return -EINVAL;
+
 	/* We're not controlling the superblock. */
 	if (!ns_capable(fs_userns, CAP_SYS_ADMIN))
 		return -EPERM;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6ca11e241a24..8756f84d627c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1190,6 +1190,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_TS_EXPIRY_WARNED 0x00000400 /* warned about timestamp range expiry */
 #define SB_I_RETIRED	0x00000800	/* superblock shouldn't be reused */
 #define SB_I_NOUMASK	0x00001000	/* VFS does not apply umask */
+#define SB_I_NOIDMAP	0x00002000	/* No idmapped mounts on this superblock */
 
 /* Possible states of 'frozen' field */
 enum {
-- 
2.34.1


