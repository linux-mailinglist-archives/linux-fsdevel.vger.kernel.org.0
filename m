Return-Path: <linux-fsdevel+bounces-51123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B81EFAD300B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0565F3B4CEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9DD2820AF;
	Tue, 10 Jun 2025 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qmYMdOx/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D15A27FD7E
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543712; cv=none; b=Csgd+5o9xxjdcWGdJ4rTtrCHsZHma6T72P0FJyasolPEcrgAdAkQeUHJ6wjhjA4OVz6Lo2U+0Vouu66TdQt2I1jC0csOLFilbwhqGPmIJR1H92IKOV4VJCsKPMibNgXXTV6Chwc2hoU01od3ogMkqHQaMS5OHqBpxMUoQ+WtHuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543712; c=relaxed/simple;
	bh=OCQ/nOLeA7qfhm/GbqVNcFdl4TrrP6/4myFMh29e2Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGEM/6IrHjAv7mwPzcPfVP3QyC7lY2PqW0JSKYlLDJmkkixLhlUxc8sPT8IO906LVKPCBRgP6FhQnPeJc0Z+QAvg2gTkFcfDtCaemk36JrvVyahMmnKzhAaDjjW0ui9G5U0PZhTX3EZlVOsk0GBw7OL71T419axLrnQ9W5PfJZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qmYMdOx/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oGn2rdxURtjBa0GxUMeK4TigVyQG4avOCmsuJ9STxNY=; b=qmYMdOx/GHFzCzh1OB9qfm7Yoc
	o+7uc+vjZfGOgnElm4ZQSKBI2/DMHZDz4zBnC9dOq96KLc3NDDx1HrMshgcW4BSX9OInve7EVxIbn
	lXvgB34kqmX973l0EJurbpy3Cb3AavH7Z8e5+HlXOB+SbOBKFPa0NJyNTkNa4b//gmSiXy+LEUHxA
	c0lurF9QyZVImXezPIK/IK0n0nL+B/xh6BQFNxK2T8Tpea0KHzW8zgktslSB1k8mIVgFhqyBe2BDu
	Ci7UxUwqu6ARUeft637WEMcDg8/Pay11GciFhdAL7kGHAQdb4J5xlsZxpA80JP0lXpcjc9bSCpWNt
	8E8DM9yg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEv-00000004jKd-2U6E;
	Tue, 10 Jun 2025 08:21:49 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 03/26] pnode: lift peers() into pnode.h
Date: Tue, 10 Jun 2025 09:21:25 +0100
Message-ID: <20250610082148.1127550-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

it's going to be useful both in pnode.c and namespace.c

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pnode.c | 5 -----
 fs/pnode.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index ffd429b760d5..aa187144e389 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -216,11 +216,6 @@ static struct mount *next_group(struct mount *m, struct mount *origin)
 static struct mount *last_dest, *first_source, *last_source, *dest_master;
 static struct hlist_head *list;
 
-static inline bool peers(const struct mount *m1, const struct mount *m2)
-{
-	return m1->mnt_group_id == m2->mnt_group_id && m1->mnt_group_id;
-}
-
 static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
 {
 	struct mount *child;
diff --git a/fs/pnode.h b/fs/pnode.h
index 34b6247af01d..b728b5de4adc 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -36,6 +36,11 @@ static inline void set_mnt_shared(struct mount *mnt)
 	mnt->mnt.mnt_flags |= MNT_SHARED;
 }
 
+static inline bool peers(const struct mount *m1, const struct mount *m2)
+{
+	return m1->mnt_group_id == m2->mnt_group_id && m1->mnt_group_id;
+}
+
 void change_mnt_propagation(struct mount *, int);
 int propagate_mnt(struct mount *, struct mountpoint *, struct mount *,
 		struct hlist_head *);
-- 
2.39.5


