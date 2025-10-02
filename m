Return-Path: <linux-fsdevel+bounces-63284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544BCBB3F32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 14:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520BC192245B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 12:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CB130E0F4;
	Thu,  2 Oct 2025 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhl9EF9F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62687311958
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409750; cv=none; b=bfhGAKTudAirjhWUNjoosuKc+EGziDtLnafyYlbYKZ0ugKbM0+5ZgW6vz67H33E8anYOGR8LO7EdBUxCnfbhZzbQHYqIFNDBzHx/YvJaUkmyIguYKGR8Nz44UZfYOd+kj2FKJ8vDw6aD0Y4BF5dVp6WVYQ1WMu0itg350FCL4o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409750; c=relaxed/simple;
	bh=fak1x7u6QjeJLvthEEWVG8U8+j2kAQGpv7pJ0KElavg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gom79/X41SSF0o4uDhZ8RwXX3bUR0V6c7yLAD2k5qXS1opw8O5T1jdRqlPPHJ6c3IK2Fb3noT0mFCEniGrkj3aw2O0cAV+olJkuf7gy6erhnaRFjOUZeW69XQT3Pckk6JCTVOsP9T0dTVS8NMr6LTKbDLF+/DG5asyV5Pthg53o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhl9EF9F; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so1070580b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 05:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759409749; x=1760014549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJKixBnmE478kGZ+GgFsDt+ITdYACcgY7ioQS8r/oGI=;
        b=dhl9EF9FwUKUnmtTaj21fF+rKEq1ZT3x9Lo9Me7HtOjocW6eEuXKFYCiXs9xr9fINF
         qjQY1VPcGwMgETi+Ijb0OOeRzsM9f7ZxWXUMm79oXpw/UwAwvVMogQFgllYs1GsOD7EM
         MErO1Q8aYno/5EMlr7ZnNIdI+Ir66o+2FYQeFKoVAIjC9tWOaUfXQ54nNwlF0cUCYgWk
         1ESeAevyq2Kf7+7G7GYUxOx2kV7BN4l/rUAhFIn8M6a8B1J2AK5si6Ymt4v4/9H560xF
         ruD4M1FelN3IJQX9a550gSB5T6IrSK9Dq7e+vSIkUAjFfB9BvmQurLpDp+6OcxdB3wMM
         zi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759409749; x=1760014549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJKixBnmE478kGZ+GgFsDt+ITdYACcgY7ioQS8r/oGI=;
        b=hh8mRwwDVYbySc2E6iplHx0vuUHfRsYQwMWc91Oc4UiWWYdo56tJsxiARwLlrz8p9j
         LYS5FPkSefmtg6+cPzL2+hQPujHzm9WPa8rHywUxBkfOiJjoHlyKP1sNy1GpPU46AjhN
         jG6/PgtzyzfrrkNC37m6fUvFWnRHKGagrMRyTNmBKur81bPesoHWnx36XjU8RdlxYxAe
         Icp1tj230j44221PAM7DufdlYgQL4dDjT7PW/81J40WE+Z34nFHiLJWA25VebdGaUxwZ
         xHt3uDoQqqudJrPgckp/Cx5j8L9OX/TZWCsosGWi0M17T43Fvt/KNI0AHO56YnaZtReb
         sDBg==
X-Gm-Message-State: AOJu0YxJeq5+q5Oz9NNRuRw0lBf38DqLXf1A9ExgbHW7DivVpn49wgJv
	namHQQEZ0lSP3dQQUO6LO/999EL/R/Wl8BkVnL0G/NOKZGUNdLxVtmgu
X-Gm-Gg: ASbGncseKYCuLf7hN4IxwgyOYDTHWdvdTLyDtEA80PO4AGP15DwQwNxaFZLAJ8jI3A+
	+OBbop2GtAauMYliN7FCNBvdXa0XV1kz4aWGrrkUve7HWe5NXajG0H4MZf6um6eVeYhwcNKwt/4
	jnDUOAEyNANEjEh2oAdHZW/AcPWgmddS3xowFF0pUNUsK53nxpjl3H/bRm0qjs+Hn+EtoPHpWXR
	GCoJiNTHRHbD4KruHv/FSSP0RR8uAtVSdyFdDbtAqh+vI0FTWemZnzNjK8yBnXEXYNr1mOSdXcb
	AKH7edki1/EAii4eBIV3BXMsxv4Tt1NZc2Lj89y4Gk3I2Og8JjIPvu79VLjzC3XywLR8RV7bzIN
	b954pAyQdiQ8oFkXv2wTMRDWNKJlABoSk/qDHDZ17IRUDJ0w=
X-Google-Smtp-Source: AGHT+IEXlSEGCReTXDSDLwHVI1dX1cLJG7c7lxdNNuysBOzqp9JYRTzMQXY47Kt2ZLlng9HpZPzO6Q==
X-Received: by 2002:a05:6a00:4f94:b0:780:f6db:b1af with SMTP id d2e1a72fcca58-78af420a72bmr7689110b3a.16.1759409748735;
        Thu, 02 Oct 2025 05:55:48 -0700 (PDT)
Received: from fedora ([2405:201:3017:a80:9e5c:2c74:b73f:890a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9a2b9sm2165556b3a.19.2025.10.02.05.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 05:55:48 -0700 (PDT)
From: Bhavik Sachdev <b.sachdev1904@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksa Sarai <cyphar@cyphar.com>,
	Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrei Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: [PATCH 3/4] statmount: allow for "unmounted" mounts
Date: Thu,  2 Oct 2025 18:18:39 +0530
Message-ID: <20251002125422.203598-4-b.sachdev1904@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002125422.203598-1-b.sachdev1904@gmail.com>
References: <20251002125422.203598-1-b.sachdev1904@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With "unmounted" mounts getting added to a separate umount_mnt_ns, we
need special handling in statmount in order for it to work on
"unmounted" mounts.

unmount_mnt_ns has no root mount (it doesn't really make sense for it to
have one) and "unmounted" mounts have no mountpoint. We handle both
these things in statmount and output the mountpoint as "[detached]" in
case of an "unmounted" mount.

Signed-off-by: Bhavik Sachdev <b.sachdev1904@gmail.com>
---
 fs/namespace.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 0b4be12c02de..29d0e692b365 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5365,6 +5365,12 @@ static int statmount_mnt_root(struct kstatmount *s, struct seq_file *seq)
 	return 0;
 }
 
+static int statmount_mnt_point_detached(struct kstatmount *s, struct seq_file *seq)
+{
+	seq_puts(seq, "[detached]");
+	return 0;
+}
+
 static int statmount_mnt_point(struct kstatmount *s, struct seq_file *seq)
 {
 	struct vfsmount *mnt = s->mnt;
@@ -5589,7 +5595,11 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 		break;
 	case STATMOUNT_MNT_POINT:
 		offp = &sm->mnt_point;
-		ret = statmount_mnt_point(s, seq);
+		if (!s->root.mnt && !s->root.dentry)
+			/* detached mount case */
+			ret = statmount_mnt_point_detached(s, seq);
+		else
+			ret = statmount_mnt_point(s, seq);
 		break;
 	case STATMOUNT_MNT_OPTS:
 		offp = &sm->mnt_opts;
@@ -5743,17 +5753,20 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	if (!s->mnt)
 		return -ENOENT;
 
-	err = grab_requested_root(ns, &root);
-	if (err)
-		return err;
+	if (!is_umount_ns(ns)) {
+		err = grab_requested_root(ns, &root);
+		if (err)
+			return err;
+	}
 
 	/*
 	 * Don't trigger audit denials. We just want to determine what
 	 * mounts to show users.
 	 */
 	m = real_mount(s->mnt);
-	if (!is_path_reachable(m, m->mnt.mnt_root, &root) &&
-	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
+
+	if (!is_umount_ns(ns) && !is_path_reachable(m, m->mnt.mnt_root, &root) &&
+		!ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	err = security_sb_statfs(s->mnt->mnt_root);
-- 
2.51.0


