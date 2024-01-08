Return-Path: <linux-fsdevel+bounces-7544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBEA826D86
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 13:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5408F1C2231F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 12:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D688543178;
	Mon,  8 Jan 2024 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ew0XhTsk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E5B42059
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 964A83F744
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 12:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704715821;
	bh=9iWRZnNscxr8QayhU5Rg4d2f++I0rJo2nyXgNTtGjkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=ew0XhTskysynAuIDEjjZcAgeykIuYk5jbgpsfXs4zYxexdPva80npFNM9S8ENrrJI
	 gA5lbbz/JQHvxDppemMhkYLic7sT9S1Mv6ZaDvsP2u3r+rP/DT1vnasr8WoACHvNR9
	 rlHekq8r1RwPWBiVrZ+vhZNTuHQG54P5zrJWTR+LKC8DwmbzHhu9d7ujG/nvWnL7cL
	 6diUp/SBEbF4heJnC7jCGqxo+hjvRBhH37I2mk6J3hjXKCalF7M1VrdEaYG8JcID6u
	 hUz04nuug5NF/fDzWd0dnHWh2Tl0zkHM3hG9eqVLzyk+au9zjTh+E9TCabYqgLsXZV
	 vbsZAJ8u/TbLw==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5551f8ec1c8so1104869a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jan 2024 04:10:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704715821; x=1705320621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iWRZnNscxr8QayhU5Rg4d2f++I0rJo2nyXgNTtGjkw=;
        b=efXF19wFXGxMfqIeo8C01IjsKcD8T30Ug4gGK/dnEww52DayQaqY8HQzKuRLwOD8oX
         XwTV05mhACskaqGdmxKDFyakJWFZp36PHsfTYImlmi+W8pv0NVFrjcrjmQhg1rUtUGJ/
         dIjuZMvXeRLOmuM6A0QA1RyCpaAcPmpMqNdPHVWYc7C42rqGUrXOmu8LMpyqrmiYbONZ
         HFUr3EhEJWag/aNNGmN+X6/IbfR+ljaePqh59ySeC48AeCYe9I0b9VMHvrhcObSW/411
         tRscxiQveWcg/pKcQgOzWXyrWRJLosVWb1EBKIGHKlEPgF5Es2ShB+FwVyEj9GWJKp23
         Xcdw==
X-Gm-Message-State: AOJu0Yxydw7PZjJA2M/GPpFuu0xYmbVKt0HjpkHjMEf4/Nt2rdNewM9q
	CYU156ps+bKfiWpxHzvzEnuySLdtQ7dfPaabFoLEYGNhzyuD4Nc2ZqiLnFCbznpym2wE10LXLkP
	DQRbWRp1R2FcJDGXLGSaEWCGzPhV0DRWWDNbdbEbo2x8GP0o+uQ==
X-Received: by 2002:a50:f688:0:b0:557:8d37:2e8d with SMTP id d8-20020a50f688000000b005578d372e8dmr1279931edn.15.1704715821271;
        Mon, 08 Jan 2024 04:10:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkOLg4PdqdFQ702pfHBj3dKeidAQf6BOtGBbpwTprd9QoY0lj1ZgOD0aGwJAUpLDd3U2Afjw==
X-Received: by 2002:a50:f688:0:b0:557:8d37:2e8d with SMTP id d8-20020a50f688000000b005578d372e8dmr1279918edn.15.1704715821105;
        Mon, 08 Jan 2024 04:10:21 -0800 (PST)
Received: from localhost.localdomain ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id fi21-20020a056402551500b005578b816f20sm1767959edb.29.2024.01.08.04.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:10:20 -0800 (PST)
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
Subject: [PATCH v1 8/9] fs/fuse: support idmapped ->set_acl
Date: Mon,  8 Jan 2024 13:08:23 +0100
Message-Id: <20240108120824.122178-9-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
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
---
 fs/fuse/acl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 3a3cd88bd3d7..727fe50e255e 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -144,8 +144,8 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * be stripped.
 		 */
 		if (fc->posix_acl &&
-		    !vfsgid_in_group_p(i_gid_into_vfsgid(&nop_mnt_idmap, inode)) &&
-		    !capable_wrt_inode_uidgid(&nop_mnt_idmap, inode, CAP_FSETID))
+		    !vfsgid_in_group_p(i_gid_into_vfsgid(idmap, inode)) &&
+		    !capable_wrt_inode_uidgid(idmap, inode, CAP_FSETID))
 			extra_flags |= FUSE_SETXATTR_ACL_KILL_SGID;
 
 		ret = fuse_setxattr(inode, name, value, size, 0, extra_flags);
-- 
2.34.1


