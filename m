Return-Path: <linux-fsdevel+bounces-28422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7013E96A20B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 17:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0AE28188D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EF71922CC;
	Tue,  3 Sep 2024 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AxoFDJrR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2C41917EF
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376631; cv=none; b=GqNsWBp/zg1neJ1tYHV/nJSBxj8BXJUX6oaui9lOqb42SYFEVov1VpZP+I6fpcsF8B45JxR7pfE5EN4cPRHiErxj7VgkuZOOMFeGfZNDT7nDk9l0C8sa/gHG18794V0424GhjHEglFgVs4SbGwl+vhuCANbDdau5sIPUbz5KlGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376631; c=relaxed/simple;
	bh=4adc61tKzjK2fTdo7B9pTquQAHQKVd/XEnUnW9CoK7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=frReaKpKjg2oPnjUQYs+9YHYhUKg/AdigM1ZgsHpnMuuXu08mdI4YmXXeX2KIkq6EV0gAMLO/UUL9YXiWdsq4FzebrleY5NS05zGaGZHlxWvOwofW0g9Tjtht6L0abLObExsytxGbZ5+H3DulQaoZba+FfyXJ9UV+mhGQeqdEG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=AxoFDJrR; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B1C203F283
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376628;
	bh=ftHOv+os2MH3Qk9OKnsGMHrGZxHBoFg3umKFJ4e1joU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=AxoFDJrR/uAvx2WbQfxnvYk5PgY958HjeB1+ETaE1JDOhukN+meK7erSN4/UDSHfz
	 0GneFHw0ulyFq1IGnJEvknX8NCLVMNbEVZbRCNb51VplxrCWb37Q1kKrPPc6HAPMnb
	 604DJ/AN51av/3k1dFrvvRRMOAOo1xIxzrYzPfsZo1z87KhUCNQXFGnpHy0TtGgc0b
	 JwEgok/I5/kabsva8iPoVYmdBmgSbCKuj8WSo3tDT7WbByzgw/6cQTvU3KVxglDHVw
	 XFISOpAoRJGWTeLvPJ8qn6ikozoGJUxpFIZpz3qA5c3b/LziTY13DgBWKSXXxR3gJl
	 MP8d2mZBqXtmg==
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-53440ff1ecfso5784290e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 08:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376628; x=1725981428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftHOv+os2MH3Qk9OKnsGMHrGZxHBoFg3umKFJ4e1joU=;
        b=dJwmvv84xlb12VQ/a8E4JQ8TzHSoX31vmTNPlqxE5XmugkEpfEUqX5MG3/MRAYJ3Iy
         658Qu2ILlkHN4lDmR4Je5HB1Eqx8+YEMC9AVN0OWtwYtZtDGBpKi333r1bnRdtt5oarG
         oIZonWuFUvI9Nsqn7S2QmbwcQBkxT3pktlcRCy0lFXOXPK35oJ2LIkScqr/fHqrH1Wmh
         5/bi5lSrXr0ELqRRWnDd/fOO5Muz8kK+lehPYNouex0GMrbRr4Kz749A12PcRzuBRnyK
         2stPH9X2V3N80DK7IXzPpR7af0uklBawvBIf2tUJDiRJ0FViGZl21GK8P0Gk2yUCzrqu
         8YfA==
X-Forwarded-Encrypted: i=1; AJvYcCWKboSV/BeuXz6W7gT+lo3nvD542AC01z4lgKOWJsYsLlpUwgXpN+3o6JPsyXUtdWLbq9ulNRGlDooRx5sA@vger.kernel.org
X-Gm-Message-State: AOJu0YyoTY/d4stP3alfVMVVqlEgVeEGhGlbotkNEwsyMKWkJIC5dcN8
	CO9/zqMTXz2inJ9fZUHg8ioysMbsOsiP4HCMxBuZyk6Hrbn+JGTCHgwrhXmmmYxFjOQsUKYLWln
	RjcWLiPSL6AkODJYactK6Vjd7pXaHMhX21dnwmrRAPEZmugvujhpZZVUpI2vCFqRaZ30LBPT6Ec
	5I/Sg=
X-Received: by 2002:a05:6512:282a:b0:533:6f3:9844 with SMTP id 2adb3069b0e04-53546afa387mr10490574e87.11.1725376627979;
        Tue, 03 Sep 2024 08:17:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5r2bdM4b8pU4WooC0ysEsGd9NXSqimzWCsNEiz5JuzrIziCYp6jmEEIfAj6my8kq7tExZbg==
X-Received: by 2002:a05:6512:282a:b0:533:6f3:9844 with SMTP id 2adb3069b0e04-53546afa387mr10490545e87.11.1725376627555;
        Tue, 03 Sep 2024 08:17:07 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:17:07 -0700 (PDT)
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
Subject: [PATCH v4 09/15] fs/fuse: drop idmap argument from __fuse_get_acl
Date: Tue,  3 Sep 2024 17:16:20 +0200
Message-Id: <20240903151626.264609-10-aleksandr.mikhalitsyn@canonical.com>
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

We don't need to have idmap in the __fuse_get_acl as we don't
have any use for it.

In the current POSIX ACL implementation, idmapped mounts are
taken into account on the userspace/kernel border
(see vfs_set_acl_idmapped_mnt() and vfs_posix_acl_to_xattr()).

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 fs/fuse/acl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 04cfd8fee992..897d813c5e92 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -12,7 +12,6 @@
 #include <linux/posix_acl_xattr.h>
 
 static struct posix_acl *__fuse_get_acl(struct fuse_conn *fc,
-					struct mnt_idmap *idmap,
 					struct inode *inode, int type, bool rcu)
 {
 	int size;
@@ -74,7 +73,7 @@ struct posix_acl *fuse_get_acl(struct mnt_idmap *idmap,
 	if (fuse_no_acl(fc, inode))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	return __fuse_get_acl(fc, idmap, inode, type, false);
+	return __fuse_get_acl(fc, inode, type, false);
 }
 
 struct posix_acl *fuse_get_inode_acl(struct inode *inode, int type, bool rcu)
@@ -90,8 +89,7 @@ struct posix_acl *fuse_get_inode_acl(struct inode *inode, int type, bool rcu)
 	 */
 	if (!fc->posix_acl)
 		return NULL;
-
-	return __fuse_get_acl(fc, &nop_mnt_idmap, inode, type, rcu);
+	return __fuse_get_acl(fc,  inode, type, rcu);
 }
 
 int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
-- 
2.34.1


