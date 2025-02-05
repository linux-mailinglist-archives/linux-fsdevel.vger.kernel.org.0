Return-Path: <linux-fsdevel+bounces-40958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7E0A29939
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E367167E23
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 18:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F50D1FF7D1;
	Wed,  5 Feb 2025 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSCpjYdb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D161FF1DC;
	Wed,  5 Feb 2025 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780777; cv=none; b=V9xh6sJlMHoCJL8ugpg5UJM3OdpZLhHMXcozdkj5pDWjnWZ+xxiltxa+s1z6Y1UJu/EiD9BQb0swlC0BBY9A4LH7ppoJMVXSZX5atF7LcZ2B/YQTsm2rGO4udZjraL9LhvRaewlf6u31HtMxWv9y8ujvWRKYqYPnTBhisVzI3kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780777; c=relaxed/simple;
	bh=61udqkcEg9wcSq/halgc8JMmMFwwfrBUY4mtNHZNt8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfEpjyrqLUunJCPmqsNHoAexrBWFV3oc9u6oMN8nyEXIi0tAzjlVjRe51V8JIG6XKW8buoo3z7+7IzKLB4d3tHC508MkMmdVvDpEwjqrNcZ5QAodPNkG0Zral/V4JW2tXwHm1TNm26fTb2zycYKbYdVGpXgPV+c1iawvt8Z65wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSCpjYdb; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab70043cd05so30517066b.0;
        Wed, 05 Feb 2025 10:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738780774; x=1739385574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8Wgr0+Th/eZItEiexHX2VH44yFxgC7CrIHewPAPMnk=;
        b=aSCpjYdbtM8LqP5L/JdgqIWlEKOvlcFZC7EgrLpkCUCRWiQig2BaBadOWiw31GfcsJ
         shnJCetRpDGcPGYBWTyzDjYUSUxoRefqG4iUqnZu448qy0WjhMUjArK2F7TSNT1nCXkh
         /Lu8OVrEK7V0As8ouya0Gbe1yiZe9sdrDAfn5b39/b4j+QmkgSlrOJ4u4oKvqJUjcOR+
         pmNu7lz8WYOCzGYgLjpAXszlE7E/Gh1CdxibnvMNdqW2mpnhz+K09Mo8ULSztutAfBC4
         qD8WF6F0vZhBctdc4BT0ZgSjixDDB4NqdrmvcTmM+fYKIEdRMm2GCPeZf1OBxGMjdigK
         APfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738780774; x=1739385574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8Wgr0+Th/eZItEiexHX2VH44yFxgC7CrIHewPAPMnk=;
        b=IXmEwJ8uaPX+tu+Cg+Sq6iOmqNp1YDnbASeN3WAML+dczEqcqjWZZRpI9mYMd4LvoK
         s4hAeg51OgGK6Cd62RaqWGMjL6pyBGK4RrULWYlZNEzePuXdWtMnFPBFMXsQWeevpIU1
         BWYRZdukAgcleQzkT1pojtOmxoG1Tnbva0+V2fx+evcskCMZhjXpKOU1BUQoSmmZgYlW
         bJ4sjOj4kMCH6LzLo/MB11Iowj5QLCsuNlnXxVZDwVeQKr7PMz5Y4lMzL5cI3nqj5HRi
         fV/wgYDoY5MoXPLZ+1tw8FHU43q7KgswEPcOw1QptgzeGGSnNb/0RX7UR4oBRu77HP+G
         4Vcw==
X-Forwarded-Encrypted: i=1; AJvYcCVcAQVgq01Aq9PJChE0zoKD6M6hLi9a/VokL4F70UdAtn2cwf6X9EnTUV2SFa+EZHBtNKF8BkuAiOsTXwdP@vger.kernel.org, AJvYcCWOZBEFK4iHxEqvl2inPcvtTvJ9LZdOnMlxax1PxGvQSA1B3OUQDc8QsslqDG6PVYLKSu6fBLbu+SA96KjY@vger.kernel.org
X-Gm-Message-State: AOJu0YyW3Yo7DTQiE/nz2wcKq+ZMRinhfshZTkATkaorBE9vUPYm+w4E
	tYL/EGYuAMNwFjTvU9dE9hyQ6XPPQFkj4arHD/6URYiXq4OsU6hg
X-Gm-Gg: ASbGnctyYEKx/z2iSuHr7iUc6f2Lg+fEetvmibDvVPLZ2dtoZWHHvqfENEn+pA/DKmJ
	qh3pVJkFs3+BKpUstdMLb1fXJkckSt3rX3DJtAA+Xn5e6rMDaHpayQNAt4a9oi7eXsbsSTx1gUJ
	ln5RXVqUaBXcED2myGO/Mj5rFFSNFIdwvMWkbHeEAXTdvrbgouF4WKP9WiQCB/0mQoxMHwTj3RM
	zdzzy2ShZDavdIhpfD2k52PbRW44DtadrZvSP7o0gX6+svzI2X02F3QcTCo3L/wuJUtFF1rTEuC
	vAYGV3DqBlQ5MC2Dpu+XDAMCHPMOXg4=
X-Google-Smtp-Source: AGHT+IE/ISlKiMGHnxVuW7IPBeeTUQHXZ8skwvGo50qqTintpOxx73+NGmUI9PGeCWkvW0zyYNFfaQ==
X-Received: by 2002:a17:906:f5a1:b0:ab2:f5e9:9a39 with SMTP id a640c23a62f3a-ab75e2820ffmr466077866b.23.1738780773822;
        Wed, 05 Feb 2025 10:39:33 -0800 (PST)
Received: from f.. (cst-prg-95-94.cust.vodafone.cz. [46.135.95.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47d0fa3sm1134082266b.47.2025.02.05.10.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 10:39:33 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 3/3] vfs: use the new debug macros in inode_set_cached_link()
Date: Wed,  5 Feb 2025 19:38:39 +0100
Message-ID: <20250205183839.395081-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205183839.395081-1-mjguzik@gmail.com>
References: <20250205183839.395081-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 034745af9702..e71d58c7f59c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -792,19 +792,8 @@ struct inode {
 
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
 {
-	int testlen;
-
-	/*
-	 * TODO: patch it into a debug-only check if relevant macros show up.
-	 * In the meantime, since we are suffering strlen even on production kernels
-	 * to find the right length, do a fixup if the wrong value got passed.
-	 */
-	testlen = strlen(link);
-	if (testlen != linklen) {
-		WARN_ONCE(1, "bad length passed for symlink [%s] (got %d, expected %d)",
-			  link, linklen, testlen);
-		linklen = testlen;
-	}
+	VFS_WARN_ON_INODE(strlen(link) != linklen, inode);
+	VFS_WARN_ON_INODE(inode->i_opflags & IOP_CACHED_LINK, inode);
 	inode->i_link = link;
 	inode->i_linklen = linklen;
 	inode->i_opflags |= IOP_CACHED_LINK;
-- 
2.43.0


