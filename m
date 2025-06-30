Return-Path: <linux-fsdevel+bounces-53274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC38AED2A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81CAC3B5460
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA26210F53;
	Mon, 30 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EEQxtS/D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C417A305
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251983; cv=none; b=txN1npC2U7fdyBn8HhsdVqC3tgddcA9xj6b8qyygvqzJKc6LA5ekLaQ+zOOtBUrqhh18uzmssHxcGWG10lKfu9UyUGhyrY1vfw53f/kqc7uFJZ5gAqR5xWQZHcWSWlU8Woh/h54NtXKuSgtRYjOC6n5qAruZ6lZpsD9DuHMQExM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251983; c=relaxed/simple;
	bh=3/uPSWRKDyKSfECCcqVWZ2bymYLZc36WuTLAuewnJ6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7JVrI0RSVTOJH2BKhmlVigHETvOcVLzDmGr85PWDzBK2CDgoYPf7+DoKR2PneqFX3LsxNEuL0EJbWgW7lLPSWtc+Iq5d/ruJ9Xg89O0KlQ5Ljqla/EyqEVOLRb1LCXmyqpPi5EvDNgluM/UZueLYrWynIlVkdgbPnYVqvInM7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EEQxtS/D; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZrQAJGytOBykv3km3wKbMoFdWlWz0FgvVwKQ8BEloP0=; b=EEQxtS/DYBmWa9B9KZxduDey2Y
	qMh8P8qOwsV7es+Urezr6/aN+RiyICRi+49zKFTkuyJYqE4Kz4+wxccGVZ2i5z0RQ+bxH/UldBEt7
	NDIZLoIhAQ8BDvCYzctWejoGGkzKq5QTSWSjRqzlIeJaB/BAvcHBOs03GrDb0oZUmP5BCoY6gg3nM
	Tc2QGgPB9dRDmONaZQop9bmqh6FfM8kFguSyotbeQnsJGcmcqgduVWa0z6ygSDQcvgegjziSkXHOL
	mfQxcAnfaqgbC3STKVNIF/dQFWTX8l3XMnKJ5cMKD24Xu7tMtCbCg5v/DeOG0idtXTe6GTlFCkKKJ
	W1fE1Rng==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4df-00000005p2I-3j6M;
	Mon, 30 Jun 2025 02:52:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 38/48] change_mnt_propagation() cleanups, step 1
Date: Mon, 30 Jun 2025 03:52:45 +0100
Message-ID: <20250630025255.1387419-38-viro@zeniv.linux.org.uk>
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

Lift changing ->mnt_slave from do_make_slave() into the caller.
Simplifies the next steps...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pnode.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index b887116f0041..14618eac2025 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -104,7 +104,6 @@ static int do_make_slave(struct mount *mnt)
 	}
 	list_for_each_entry(slave_mnt, &mnt->mnt_slave_list, mnt_slave)
 		slave_mnt->mnt_master = master;
-	list_move(&mnt->mnt_slave, &master->mnt_slave_list);
 	list_splice(&mnt->mnt_slave_list, master->mnt_slave_list.prev);
 	INIT_LIST_HEAD(&mnt->mnt_slave_list);
 	mnt->mnt_master = master;
@@ -121,8 +120,12 @@ void change_mnt_propagation(struct mount *mnt, int type)
 		return;
 	}
 	do_make_slave(mnt);
-	if (type != MS_SLAVE) {
-		list_del_init(&mnt->mnt_slave);
+	list_del_init(&mnt->mnt_slave);
+	if (type == MS_SLAVE) {
+		if (mnt->mnt_master)
+			list_add(&mnt->mnt_slave,
+				 &mnt->mnt_master->mnt_slave_list);
+	} else {
 		mnt->mnt_master = NULL;
 		if (type == MS_UNBINDABLE)
 			mnt->mnt_t_flags |= T_UNBINDABLE;
-- 
2.39.5


