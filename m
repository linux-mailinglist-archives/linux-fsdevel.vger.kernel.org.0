Return-Path: <linux-fsdevel+bounces-53285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00855AED2B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A003B551A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BDB21CC71;
	Mon, 30 Jun 2025 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kMg+/6qT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC521D8A10
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251984; cv=none; b=Pz2TGyEFhGiFP45ekfLXzJuZAXQtbwtVnvVofQ75f3JkqirjhoF1sNiHpdd9LoVlrBTtU5qHdjn3hByNCCZxi9FqfYJ97we341cKxK19eYFsVwnVijGevt0bJFls0pXjuUwZAybnZdeGT3s4v4XKpGnCZDV942hqTP52VL5JlEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251984; c=relaxed/simple;
	bh=+dpoHuQUHQu6n7g7XIJ1tHd8xk05L3fNgu1iK0mO5Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrkrD+4G/WD8i8FAbTBYcEpzZsRv16lpL4n7h9JhiAUcEwGndXzDOT3h7aGzQshYmQlOAsOuZiIKkF0XS4OeLiBW9rNQVXDyXeYomQC5K0tVfXAHF6+CWGXwJ3Gown4lmv1cuMQkARFcxQYFRt1yV69PtN1+4VL65eEkrHGIoBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kMg+/6qT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=20dGlnlEiCeuubFOdWz0hEF8BuGDxDDy6KTNkr8UByA=; b=kMg+/6qT6p+qhOCjsfwIHhPpwe
	VMb9xOu09Jvd/zc34rPyzdGOZVveiH/p8NG8c5QZQkSNJfbP8w21Ud8+abYrH4zAk5GQX+Iwg2z5k
	Cma9tXOk1MjfkcRr/C4v6/IEJzX2M0naKacyvoj8z5ZqoIQlYlTvJ5vwBZGe8/g4yQwxSDx2X+Jyp
	Zqf1tP0tsLtUNL47cVRs5SXe79d0yT/DcEdG/9197BgLwJKbyZ6raCjYiOhUJxt1RiGX3CqjuVrJV
	SSxMFQvFp66qxuj5v4G+KDGNAlsmnga4Q3BuQE5DpGYKj9IHuzYNpOS5+rcbmrqFiw+uDhZnNl9zm
	OqhRfSPg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dg-00000005p2m-1MyL;
	Mon, 30 Jun 2025 02:53:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 41/48] turn do_make_slave() into transfer_propagation()
Date: Mon, 30 Jun 2025 03:52:48 +0100
Message-ID: <20250630025255.1387419-41-viro@zeniv.linux.org.uk>
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

Lift calculation of replacement propagation source, removal from
peer group and assignment of ->mnt_master from do_make_slave() into
change_mnt_propagation() itself.  What remains is switching of
what used to get propagation *through* mnt to alternative source.
Rename to transfer_propagation(), passing it the replacement source
as the second argument.  Have it return void, while we are at it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pnode.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index 91d10af867bd..0a54848cbbd1 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -83,19 +83,10 @@ static struct mount *propagation_source(struct mount *mnt)
 	return mnt;
 }
 
-static int do_make_slave(struct mount *mnt)
+static void transfer_propagation(struct mount *mnt, struct mount *to)
 {
-	struct mount *master = propagation_source(mnt);
 	struct mount *slave_mnt;
-
-	if (list_empty(&mnt->mnt_share)) {
-		mnt_release_group_id(mnt);
-	} else {
-		list_del_init(&mnt->mnt_share);
-		mnt->mnt_group_id = 0;
-	}
-	CLEAR_MNT_SHARED(mnt);
-	if (!master) {
+	if (!to) {
 		struct list_head *p = &mnt->mnt_slave_list;
 		while (!list_empty(p)) {
 			slave_mnt = list_first_entry(p,
@@ -103,14 +94,12 @@ static int do_make_slave(struct mount *mnt)
 			list_del_init(&slave_mnt->mnt_slave);
 			slave_mnt->mnt_master = NULL;
 		}
-		return 0;
+		return;
 	}
 	list_for_each_entry(slave_mnt, &mnt->mnt_slave_list, mnt_slave)
-		slave_mnt->mnt_master = master;
-	list_splice(&mnt->mnt_slave_list, master->mnt_slave_list.prev);
+		slave_mnt->mnt_master = to;
+	list_splice(&mnt->mnt_slave_list, to->mnt_slave_list.prev);
 	INIT_LIST_HEAD(&mnt->mnt_slave_list);
-	mnt->mnt_master = master;
-	return 0;
 }
 
 /*
@@ -122,8 +111,19 @@ void change_mnt_propagation(struct mount *mnt, int type)
 		set_mnt_shared(mnt);
 		return;
 	}
-	if (IS_MNT_SHARED(mnt))
-		do_make_slave(mnt);
+	if (IS_MNT_SHARED(mnt)) {
+		struct mount *m = propagation_source(mnt);
+
+		if (list_empty(&mnt->mnt_share)) {
+			mnt_release_group_id(mnt);
+		} else {
+			list_del_init(&mnt->mnt_share);
+			mnt->mnt_group_id = 0;
+		}
+		CLEAR_MNT_SHARED(mnt);
+		transfer_propagation(mnt, m);
+		mnt->mnt_master = m;
+	}
 	list_del_init(&mnt->mnt_slave);
 	if (type == MS_SLAVE) {
 		if (mnt->mnt_master)
-- 
2.39.5


