Return-Path: <linux-fsdevel+bounces-28420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35DF96A205
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 17:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26EC2B277D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4E0190057;
	Tue,  3 Sep 2024 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="eCFITWd6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF118F2CF
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376626; cv=none; b=M/H5B3Jixqdrownie3pZAfti2dmNKLbmTLp9oevWihWr5ZQI2sNCxqEPVviUL4RZXF+X82FU0cV0/Y86Xw1F5YW7un506+tAPjlBlhWC0m1d81YNSwUmYdDB1SZt5N8BxyNmMhYCXqNedmlxZ6F7MKov43hT349AOioYl5IFsfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376626; c=relaxed/simple;
	bh=/KSxVyB7IT7zZF5p/b+JrUDxUP53IflmxMsoAbMzrQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pEPEKGZ1lpNirxcCtZMlOFcJfrOBOEBaB/FpwntOvEvRnfqh9SFh3nSFiVA3OTcI5GDJAuwaWa+hFk2pADVV34Qbcsnx47aZ9Y+qbk7G5ae1GQZkEbPKZLkRaJ9aOj2/Z7QqR+/sstCQKds+cToiqgJQrgHzsgYP7t+VHVzBuGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=eCFITWd6; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5FF303F339
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376623;
	bh=GgxPCzVaZ1cVZVunPaJCembmyRCPwoxjS+kDMNcCdhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=eCFITWd6K84eNO4iTeyQkjYIkmpK2gCgQIdPqUcrRYUGJdL0xhfaqvO+p5/I6kR8I
	 ou8HAKvmFyTOkJyoIdmhtREeDGwEjIoB8JS+RvAJafmJBYetUOBr+P+NAbM86j2mbj
	 X7hRbjkpn0JHcnwSUQldPm0HK+Ka62isuYn0PIzXyD5PFB5Mxs7cBOZndBMahJ+JO2
	 6IcyfNW4VHdRLNGCDfly3m1+PSrkE0hzupHwuTZgeRU7RMgA6aUQUPzrSwcESwzwU9
	 +9aVpfjKEWRYwm3v2ij7EVYGOjR5sTSPVI9lS7ZR7ZYVV3cadr4azHVY1hG1eb06es
	 ELnLQP0+R1rDw==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8683bd9e67so462501466b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 08:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376623; x=1725981423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgxPCzVaZ1cVZVunPaJCembmyRCPwoxjS+kDMNcCdhg=;
        b=gj5op08g6OA4gjtDhPbITtG6BXz7O9/KLT9i8VJFWUYV/ZAmPdSJtBvBOrhu+DOrUV
         VL0g5AtRxeOGbDWiAtJC/d0I/+ZEAI7nqFdtu+UM3v1ZCFQIEbMMM7JzmHjeVtQ3WuFa
         u4tyIZJXG2d9A33gSVPj9vrGRIyQMSEWq6ArLBHHAjwuaauxJIPDL+HAE9TYPxwB4JBG
         FQ/yWaBz7GRdEy0xd+tgZberGgmV4vMYq9t8rKB2F75eAVyNaN4IOBbVrW+Kf/uBtcno
         Q+3QQPoUecS25k4t5hO4IObk7UBaENXXLCVvOnkY5LfQPjTEhFknnYYmfOkFh20GLFLo
         PVqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKMRaTxlVgkdS+u1DPvCPjSFfi/r9HaxzzEh1gs6UaVL1Hkl31lLvwOahaZ8MRAgTze0eVCF0OwbsfpoO9@vger.kernel.org
X-Gm-Message-State: AOJu0YyUiwP3RNHfG0z3cCZg7Xu4JKAA/ADC/flw7ArqtT6mFSF4qU1f
	bFSf29sBZ9x0ZipZiiHBwkNl7qP1rQInupGQ3k1k2TzNq9IE3tCS+eftHhZUkyduZsE1RQlDwbZ
	YhgHaYQRGD6T6Y1/3FwUB6ZpRbO72QnDKfFiDXjtRU1wYjC3Lb8U9ETZUL/BAggg9o7xCDJG5u4
	5dmzY=
X-Received: by 2002:a17:907:3f1c:b0:a86:789c:2d07 with SMTP id a640c23a62f3a-a8a1d29bc25mr284010866b.4.1725376622788;
        Tue, 03 Sep 2024 08:17:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEt5VDltIc8zPXPIFeiCz8KAUJj0grhVupIthxizBUK009KgECFOvAGAbSM0OXZIC/NPX1VA==
X-Received: by 2002:a17:907:3f1c:b0:a86:789c:2d07 with SMTP id a640c23a62f3a-a8a1d29bc25mr284008566b.4.1725376622275;
        Tue, 03 Sep 2024 08:17:02 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:17:01 -0700 (PDT)
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
Subject: [PATCH v4 07/15] fs/fuse: support idmapped ->permission inode op
Date: Tue,  3 Sep 2024 17:16:18 +0200
Message-Id: <20240903151626.264609-8-aleksandr.mikhalitsyn@canonical.com>
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
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 fs/fuse/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 1c28cdf9dd41..870932543aa0 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1544,7 +1544,7 @@ static int fuse_permission(struct mnt_idmap *idmap,
 	}
 
 	if (fc->default_permissions) {
-		err = generic_permission(&nop_mnt_idmap, inode, mask);
+		err = generic_permission(idmap, inode, mask);
 
 		/* If permission is denied, try to refresh file
 		   attributes.  This is also needed, because the root
@@ -1552,7 +1552,7 @@ static int fuse_permission(struct mnt_idmap *idmap,
 		if (err == -EACCES && !refreshed) {
 			err = fuse_perm_getattr(inode, mask);
 			if (!err)
-				err = generic_permission(&nop_mnt_idmap,
+				err = generic_permission(idmap,
 							 inode, mask);
 		}
 
-- 
2.34.1


