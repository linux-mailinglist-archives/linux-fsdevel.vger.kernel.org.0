Return-Path: <linux-fsdevel+bounces-26049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F873952C21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 12:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F8ACB26158
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 10:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0E221018B;
	Thu, 15 Aug 2024 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="R86FgbAk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1322820FAA1
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713910; cv=none; b=Qhtf3c3G4bXT3NXgTa6TwYR1c6kYopxV5DM25PRFRUSS0tXolbRo8R2aa14rDL9jT+d5yEzuhOfBFhajAtmHAkXOhuRn5ZWUe5OvL7stmBb/mlHSLY1o44cdl32SVksrUas55KNG2xUFjYxWDHVwHNa8Dx8/3KxaC3/9jwfOw/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713910; c=relaxed/simple;
	bh=9LyCmNQL+Wo2sLWHPY86vHgjnCGu8A+hXloJ3pDxAko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qx/wnaUoNRo1dMO9Bv4+0crMzE6sZgD3hcYhA8hl9XhLjetHpdY0Qgxzu546deOxtLibBr62hYMgnuw3jwHwBVtUKXDdSgFow9ND+egXNqm9FkzpaQJqoJKODodxsDuZyaFDO1gOAPB6oJTNivYW79xKmxO0OGtyp+Vljc8vDHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=R86FgbAk; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C75913F670
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 09:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723713907;
	bh=ex29ohbhGi3Fy6+0Qs/1K/FDT7vHiirCCSI2eAx8vvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=R86FgbAkGw8v8oIzoq6yVS/N45XM7MC35LVyhhnJYLgPT+P1mtfCZ1juOGIJk24I2
	 wHln28uqSibfD9o/Ck2KAMUOJV7uhJbbxEtGMrrEgxl7tc7INt7yQF7RCt8/rP5mZ3
	 wxRWWqOuTR7Pt1zKkxsI3+MdiGIqknitdln2Fmry27A21GCnxIEk/8KfAWM5YctxjR
	 jvayuk5uUbXAcqQ/rDnqrScP+29Udp3xUHVxOKM3JVF1fKRqoK9ZxeUzml+HIdrpA6
	 LBJB40UcnPOOf7ELFeSmNuCpnCTIWAEiE0MB7aeKE5gY4VkA7nk8nSacTWLHeIbhXl
	 1s+PvInnZg1Yg==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a79c35c28f1so71968566b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 02:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723713907; x=1724318707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ex29ohbhGi3Fy6+0Qs/1K/FDT7vHiirCCSI2eAx8vvk=;
        b=IxVN0btAWmbDAt/QcV9PbtnipZ1RUjBu44bY1F9n4CzKrrio7VjC+dAhA6df1G2g/O
         Lqvti4VFhULEpK2Kr5OrpDiAmQbjjL0ykQBOr5lPBhEekwnwUSxPYIYkHCCLG5c6QabT
         +KD+n6ontpSQEjQ8F8VlUqfy9QBk424c2FxUt0ygRu7dKlXrokypwBCLKQBmDtVfv5K1
         M8Vz+irOrxelIuCesAB2LBsHHlG8SZvFBnll7Azuumld0+T/wlQIzOd81rD/4AG+5eCh
         2jelZjfeThvpdvsSr02z/rU5DX+/BZt3BgWZDExeY3XDHxi2PEbQ1YYpXBDvXQUGqsaU
         NdDg==
X-Forwarded-Encrypted: i=1; AJvYcCX2/fUy/rry/7K2xywfAM2ZQcZFQZ2Y6hMHTquuns3nxkJ57rhSwcZ55sMSrtpBq0hfHdqIzwFJLBY0gJQ7GuRMa/C38wKkmtLIJDVtPg==
X-Gm-Message-State: AOJu0YzHKQsu4z8uqkmrRNekhKQ05kwSNiN7c9od3Cr7IvjNTNKdBcgq
	zDeMAz1FDQSW5XFrbe8w0Z6RrbVhbEpyIttvca8FpyXK4Sh6Kx7ZCZZTeOnXu9f2vJoU5M6tL9B
	PVD2iLGFZn2GBHumzawGo6EDiJlefxh2jx1BIus7Bru58i2G1pCbOU9NTuioC3o5cU6qzMgfFOY
	RS64c=
X-Received: by 2002:a17:907:e622:b0:a7d:cf4f:180b with SMTP id a640c23a62f3a-a8366d5be39mr383852566b.32.1723713906894;
        Thu, 15 Aug 2024 02:25:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ5OnmkMFXHCENGvuouya0YLtsXvkFjYOL6tsjC3SgQjQW5b/e4j/Mtgu8clZbCAuhvbK4pg==
X-Received: by 2002:a17:907:e622:b0:a7d:cf4f:180b with SMTP id a640c23a62f3a-a8366d5be39mr383851166b.32.1723713906574;
        Thu, 15 Aug 2024 02:25:06 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934585sm72142866b.107.2024.08.15.02.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 02:25:06 -0700 (PDT)
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
Subject: [PATCH v3 09/11] fs/fuse: properly handle idmapped ->rename op
Date: Thu, 15 Aug 2024 11:24:26 +0200
Message-Id: <20240815092429.103356-10-aleksandr.mikhalitsyn@canonical.com>
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

Support of RENAME_WHITEOUT with idmapped mounts requires
an API extension for FUSE_RENAME2.

Let's just forbid this combination for now. It's not
critical at all as it's only needed for overlayfs on top
of fuse/virtiofs.

Choice of EINVAL is not random, we just simulate a standard
behavior when RENAME_WHITEOUT flag is not supported.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v2:
	- this commit added
---
 fs/fuse/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index c50f951596dd..0cd01f25251f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1111,6 +1111,9 @@ static int fuse_rename2(struct mnt_idmap *idmap, struct inode *olddir,
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
 		return -EINVAL;
 
+	if ((flags & RENAME_WHITEOUT) && (idmap != &nop_mnt_idmap))
+		return -EINVAL;
+
 	if (flags) {
 		if (fc->no_rename2 || fc->minor < 23)
 			return -EINVAL;
-- 
2.34.1


