Return-Path: <linux-fsdevel+bounces-25904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313EB951A47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 13:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1FE1F21F35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 11:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDE81B32D0;
	Wed, 14 Aug 2024 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="I2NJ6bVK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB64D1B4C23
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635696; cv=none; b=b8QyJUmR7S4PqHAO9Erqe2K+1csSN5KbLN6OKOUaTDEuWIgNYuEMb27NJQDpVUjyFWvNMYkkKxSVOFLELnThoi9apkwaJcaPcUQT5yQX23h6KDU6+9lJeZJ8OQF55ibPJggoAoHRvqy4fm89P9Y3wRnw8tqZ57B0oya9yHYnDVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635696; c=relaxed/simple;
	bh=ONyUrWrgUBZRJvO+nhcwWS/g3zi/w0z15wLOTv3nesw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IqkeRy4fMrrS9e5E8h5WYrfi10TgeFUEvAz+a1ntflH/TFuyQkoH3jULUu9K/G5TaNtB0gJ7duhWCBHDUYNs2lc4+poZSeT83Wa4aFEuo5nIJ3TE0sj3i9yjJPcuivCdI1O1VTcAtUocthN/6sXi0Z0YVUAVYvo4gi9aTMkSBTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=I2NJ6bVK; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A63C93F670
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723635692;
	bh=+wGAYIUsqVxDBSfRQAij7GIIUQJC7PY8L940f+LK16E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=I2NJ6bVKanTmfw09WWLcHODSd99tdFbhqQYMo70JBwEcOWEuDfpu5GW2XPUIBktUI
	 U5Kk4FetTVK4RRfUYWB8Mr7WmO5BlFaXcSDbUnGMeYB6qtP3M3ez6W7miCDYffCxpk
	 PULkGoQEX3nLMD63lSHAA1fHgQqGVUMcMdG/WfiuqHDdIzc98MSEVl2AgZRTTH7kZj
	 /LoX3sdHuKWUdyrfThRsE3o0DASm3cxZ31TOCRPgDz8Jqyw0QoJhAfUslhDgsO1PRb
	 lNPucHxNcReQuPB3tNaUleq+EW2+TOQiBU0mQxn/A+DuRhqowSxcibxYlA9mL/QNCd
	 edEB2B69aRvZw==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5a30be1c5cfso5963211a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 04:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635692; x=1724240492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wGAYIUsqVxDBSfRQAij7GIIUQJC7PY8L940f+LK16E=;
        b=sgQhA26OpvzowOvw0aM7cbJhaE4+K6kObycz0ii3vLkkxvwbuBBCp5DBWOLRANh6vL
         /fFs7w3DCI9pTnNR/JCCEB1ju19mKDx1wBK5o6CndSRPskBGv/9GGIaFRO9uei3xAf1p
         G8EBmm6oGjvd0zFaJnbQS/Uv87IYHadmSuZeM3JtzjqQEycg8kUJRTsFyMtm6bQgwCQy
         WZx+jDsAG/Ps0abvzCHPrCl6OPHeKpsxUxpPea8JF19tBOCcZQheCZTJqo189PC7Op3I
         B9lYBw2uGYXMVY6Fpc/1eH2d/kIjQZgC76KyKPaz7sc2jjDNoaQ6oS9eMImlZMHuWj2D
         bPcw==
X-Forwarded-Encrypted: i=1; AJvYcCV+Le5wt+lP0Mv/EdvkCWaZobiK+jvSE6xDOJPcRDs0aLhXjyuxP96HsUfwPJ0lVTcfCy/jdWTnTKa8ZUUzlTs9yzM03FJFmI0SkWJHLg==
X-Gm-Message-State: AOJu0Ywygci2+WElS9XuIl9NjX8gh+dFA4M0mr0yHWYpUTfQicpV6NQb
	L3CZNRmoPtPdbOwIhW8YDQd6HKR3ay+zROKi/vn6Dk0s1tZw5aW0FqRbIcDF3bsITWrdx1ET2Da
	Rn2T1JXCmXu73LSgcLZCY+BZGZdHIkf5yeHP5/0Jj29Zjn7ixtCcynmKqCVoIxbnsoB7RFCzcOR
	prpOI=
X-Received: by 2002:a17:907:e299:b0:a7a:a30b:7b93 with SMTP id a640c23a62f3a-a8366bfc205mr185943066b.2.1723635692268;
        Wed, 14 Aug 2024 04:41:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVElzlGQvCp40SGYdLshfg4SAiY1Lf5Iy2oHIC3dUD7p8/6p96C39Yy7gEUeBpOKaBSMFHag==
X-Received: by 2002:a17:907:e299:b0:a7a:a30b:7b93 with SMTP id a640c23a62f3a-a8366bfc205mr185941466b.2.1723635691845;
        Wed, 14 Aug 2024 04:41:31 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa782csm162586166b.60.2024.08.14.04.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:41:31 -0700 (PDT)
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
Subject: [PATCH v2 4/9] fs/fuse: support idmapped ->permission inode op
Date: Wed, 14 Aug 2024 13:40:29 +0200
Message-Id: <20240814114034.113953-5-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only cover the case when "default_permissions" flag
is used. A reason for that is that otherwise all the permission
checks are done in the userspace and we have to deal with
VFS idmapping in the userspace (which is bad), alternatively
we have to provide the userspace with idmapped req->in.h.uid/req->in.h.gid
which is also not align with VFS idmaps philosophy.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index a5bf8c18a0ae..cd3b91b60cae 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1567,7 +1567,7 @@ static int fuse_permission(struct mnt_idmap *idmap,
 	}
 
 	if (fc->default_permissions) {
-		err = generic_permission(&nop_mnt_idmap, inode, mask);
+		err = generic_permission(idmap, inode, mask);
 
 		/* If permission is denied, try to refresh file
 		   attributes.  This is also needed, because the root
@@ -1575,7 +1575,7 @@ static int fuse_permission(struct mnt_idmap *idmap,
 		if (err == -EACCES && !refreshed) {
 			err = fuse_perm_getattr(inode, mask);
 			if (!err)
-				err = generic_permission(&nop_mnt_idmap,
+				err = generic_permission(idmap,
 							 inode, mask);
 		}
 
-- 
2.34.1


