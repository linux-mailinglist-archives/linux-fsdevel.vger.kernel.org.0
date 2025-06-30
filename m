Return-Path: <linux-fsdevel+bounces-53283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F94AED2AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64CCF168BE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B12721CC54;
	Mon, 30 Jun 2025 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BqTTV/hg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810D81DE4FF
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251984; cv=none; b=tBln1QNYPKT7zuS1PxNaU1EFiNcQM6dai0alKzvcRdsW5NtaYRWDTIjSi9Fbk2Othm1N+sIZOr1QJntiXoHL1ZLd1opfgGeq97um3Nwhid7u1grE5Z8ddz7c2pPnvxwgA9TgxvJntZ2jFe4uaDRYYz9OwLb38isVyjwZziI4vCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251984; c=relaxed/simple;
	bh=vQpH3k5NWYC4Kk5zvvgBdoDpPHriH6jAkO+LCceQO+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSS+zgtPqtOSHyIcSeyoaFskDnYlf7sQcj4Hc5IZeN9MhtZRI0edW8t5LZKEI51bPC701Rsyt+By5oEVbtcdI6TcronGzTBKrWxZtMARIRu+1lNlEL4AXo/iLHyh+3ICBban+AmH5HmsIQNo0RU921Vp9HfR8yBe0Et1ZWQv76s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BqTTV/hg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=t3zcRo20kEgw4YVL5pC0SkgJWqUa2gai9XpGKC54VKk=; b=BqTTV/hgk8nLOiNG9aqOnzm9MM
	tosVSwK20a/2e5S54pStKMsq6phJwNmJIjM1FF8WTs2jxHsJGyMxMtpWR/lpuiB+apwdspn03KRZO
	eupBJ/x1zb/fu6PpJTBKJe5vOvv0Jd6YcCb0n/FiAMGf+8cmrcf4H0PGx1YvSIKCzXpxZNXDVnXKP
	x+qkBlFDuXKzmCcaoCw/t9Ow0YbbRXaXtRyHzEqFxqycIS2K+FbVr5RipJppQ/OsZ4SvXSXibhKGl
	nCtsXs++Wsefk4Jm5zJ05hFIltOqQ0JEEO5lxO58Wua/Qm61hEDEGFcoqJ62wE26VNbHLLfC9IBZ8
	7zvoFm3g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dg-00000005p3F-2J8c;
	Mon, 30 Jun 2025 02:53:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 43/48] change_mnt_propagation(): move ->mnt_master assignment into MS_SLAVE case
Date: Mon, 30 Jun 2025 03:52:50 +0100
Message-ID: <20250630025255.1387419-43-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pnode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index 69278079faeb..cbf5f5746252 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -104,13 +104,14 @@ static void transfer_propagation(struct mount *mnt, struct mount *to)
  */
 void change_mnt_propagation(struct mount *mnt, int type)
 {
+	struct mount *m = mnt->mnt_master;
+
 	if (type == MS_SHARED) {
 		set_mnt_shared(mnt);
 		return;
 	}
 	if (IS_MNT_SHARED(mnt)) {
-		struct mount *m = propagation_source(mnt);
-
+		m = propagation_source(mnt);
 		if (list_empty(&mnt->mnt_share)) {
 			mnt_release_group_id(mnt);
 		} else {
@@ -119,13 +120,12 @@ void change_mnt_propagation(struct mount *mnt, int type)
 		}
 		CLEAR_MNT_SHARED(mnt);
 		transfer_propagation(mnt, m);
-		mnt->mnt_master = m;
 	}
 	hlist_del_init(&mnt->mnt_slave);
 	if (type == MS_SLAVE) {
-		if (mnt->mnt_master)
-			hlist_add_head(&mnt->mnt_slave,
-				 &mnt->mnt_master->mnt_slave_list);
+		mnt->mnt_master = m;
+		if (m)
+			hlist_add_head(&mnt->mnt_slave, &m->mnt_slave_list);
 	} else {
 		mnt->mnt_master = NULL;
 		if (type == MS_UNBINDABLE)
-- 
2.39.5


