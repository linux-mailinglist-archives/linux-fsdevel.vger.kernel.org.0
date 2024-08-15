Return-Path: <linux-fsdevel+bounces-26050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA111952C22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 12:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63C5BB2614D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 10:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD5B210196;
	Thu, 15 Aug 2024 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="uKYtqnOY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD1320FA8C
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713910; cv=none; b=bk8ibpyLtYxUq5SmktLgb/LMZ2xDMW9Fd7TrOvfNxzlCWaNsI/1ngr+tg1E2QqkA3m6WWuRZ1NR37YQmGXM48UirP0efmcqJ5pu8fE+MbQihvxrNTH2bBkxkEPFiM7rSoIBBKVMdUU8Xml7LE08vhc9sen66RYWpUezvawp3WXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713910; c=relaxed/simple;
	bh=ItY86ikXLB5CiOOsAivB6bVSog31+kYXgujXhFdDat8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XUzUOv6GA8g+f6MHIf7iW/gEv6cx/SDQ/xHL2yZ+wsWUhPxhviNBGQ3HtOAKboPQtub46RONY7MArvN1Pcc7ZosCXMRpEpFats7ueg0uGN4WoRhNtOt2i6gJFpWnmTfh+Rz9U9LQnKADFExfgjo73ZxB0S7rAPgjGkKwisl9oBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=uKYtqnOY; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2D6E9402E8
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 09:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723713907;
	bh=AKgOJzf1FD6sazbw1kqXlY4ydMZMTG/q+wfid3Wy6NY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=uKYtqnOYPR3K/sTeXrDQWfFo9+G2Xh7O3ihjiNiBQNCXFsYhqgsapU9Q9cb8RpdxS
	 iaaK1f2kbetz2xlEE4wOwmiP274yX8D7fz/yU4OEMvncYzjany2bLYpNiNRLcjGwKL
	 T7yAB0lQdH18WhNEJs7XnKozIKx6260UiMlMFEE54A/wjsEPqJmrKUoHbGfsssPI4T
	 LTpOww3/Q/khPbtnmb3G39QdXjw0ke5m+qdk7f5K32fkMNTq12tHNxtluDusNqqqoD
	 Tij+J00E1S1+FGe9TniBwXHxnMoLU4bTnKVnuE9ODK+IbAD+rRhZ27isXH7zTHdKI9
	 xmIvSORsPrs7A==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52efe4c2261so927426e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 02:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723713905; x=1724318705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKgOJzf1FD6sazbw1kqXlY4ydMZMTG/q+wfid3Wy6NY=;
        b=QarFFmWeAkakK9xmTkMFUGSl4KnmppFuwxCdigHVYjl6t3Fp0Zq1RSUnGhdyk0Y2vx
         oEiK96cYCsMfZ6trO0Y3pnPrC+wGb0K+F7UIoOEsxDoqP/gZi18M4Z/zQjsxb8zrzSXM
         odzeZB1uLREfUDPfpf8v6+XbKkbnIui6LxOhX47yDQuMgVYRju977MpArpI/r/LnMOdz
         My/hYv/ETCuk8RkaaxQ28c6SL9xFtF3JLRFR6A7jo57v/ieNgNec10nDbKLbHcvRAv7s
         v0YQKZBjeOauI+CwQIWOPM0C40sACnnZUkYnnPWKFiKojjw1wKsxFvcZbscrrYCGwWzj
         Rfhw==
X-Forwarded-Encrypted: i=1; AJvYcCWoSsNME5WTo4u7QLRlkekheUPaNpczMQ192ZgzpaMyEpEgWWCqEtGEgu18ASA4vBzvE/yF7GSppdh/R5XqZ1A1iRurrUcYuHvz5QSJGw==
X-Gm-Message-State: AOJu0Yxu/dv2q9efvZYvSORpJ+ePaPJCkczEbgw+UD89zJRk43hstKKG
	Y8U5AWlrklKTHhfaEYpyPrw5wYm0J+R8W/eyjGxXaRhnGLTGlskU/Ka133hD64CV0nDi4K23aqi
	Kq2OFUuhciZi3Vr7izg/hMmwfFe0ishib7nqU+B4dOQFZp86o2eiI8Q1rw+JZxUYV+Q5KA4mAAX
	e80kU=
X-Received: by 2002:ac2:5695:0:b0:532:fb9e:a175 with SMTP id 2adb3069b0e04-532fb9ea617mr3817510e87.6.1723713904889;
        Thu, 15 Aug 2024 02:25:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGx/vdKNpZNgVQz01CbRwoXGyKCak1Dnuqwz633QdtWw+oIMOWdvHhKLICOjgJpC7mpuObEw==
X-Received: by 2002:ac2:5695:0:b0:532:fb9e:a175 with SMTP id 2adb3069b0e04-532fb9ea617mr3817480e87.6.1723713904456;
        Thu, 15 Aug 2024 02:25:04 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934585sm72142866b.107.2024.08.15.02.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 02:25:03 -0700 (PDT)
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
Subject: [PATCH v3 08/11] fs/fuse: support idmapped ->set_acl
Date: Thu, 15 Aug 2024 11:24:25 +0200
Message-Id: <20240815092429.103356-9-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
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


