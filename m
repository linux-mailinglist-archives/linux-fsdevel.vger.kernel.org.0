Return-Path: <linux-fsdevel+bounces-52435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE42AE3469
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F0B16D2EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112151D63C0;
	Mon, 23 Jun 2025 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IrIBt42L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5702FB2
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654472; cv=none; b=esujThp2VssdtkwXgi5V70vNhIj0Rev4AaIziw+RqsFilj5J93koBB71flfPc44yRzE/VadGpBkwin2ZTjI2SOj2v2iASvORaXM7UkYTGTPZnk7NsUGtxCNt5UCE1oHtr2I+fH8791oxra564DkZF/QSpNvceINtGP3g3jRq8Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654472; c=relaxed/simple;
	bh=8gLV80q4G45hl5C0GIJmVO/5GW6WNg2dibfjsU/++wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7ZTrmSFXSfuOjxhC3Eu7uFR7rXZxgvxEWVB3rcfgUxIbZgbSHitBVuY6gmJP6omHGt84GFvYadsbd6LcVYqkhgPufRqVYCmAVa6mkChIsrhRpG1OXtShxsCRn7BdsWw3ri6s94WhN4daERDVpalIUaPWkopA92tjUetTOho8kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IrIBt42L; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mW0OtHiZadvf79DFKJhQXdY8TS9drY3KO6WxS3KuVuA=; b=IrIBt42L1i0t4L9VGxXRy7iIyQ
	9k/Ad1x8n0rIymHJkLy0thsmiOrf4NqWFXO5AsDpgTxvol5djUtFrPAPMH3KVKOseJlyaOCEJDNWt
	bG4QN5VitgIyrSRJ9wBitXCYlxSZ7mR2Svk57xUPOLP7Ud7ul04h4teA3ZZV0cXuJdsjth7VsKRdc
	t2UCsgjYI7X2pXLHvwvXcdeJ0ANvtFh5RnCqykADQWfXwShbRj8Agv94VDjJ7YgY9rSNJu+JKdXYR
	zE8k/ArBNSphigfeGIjY16938SAnf8TbTUL0LdWBYEjZQvsKoFAEAXGD+sijcO2O9fL+l8r35ELPF
	Q44Fxxbg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCO-00000005Ko9-2gj8;
	Mon, 23 Jun 2025 04:54:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 02/35] attach_recursive_mnt(): do not lock the covering tree when sliding something under it
Date: Mon, 23 Jun 2025 05:53:55 +0100
Message-ID: <20250623045428.1271612-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
References: <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

If we are propagating across the userns boundary, we need to lock the
mounts added there.  However, in case when something has already
been mounted there and we end up sliding a new tree under that,
the stuff that had been there before should not get locked.

IOW, lock_mnt_tree() should be called before we reparent the
preexisting tree on top of what we are adding.

Fixes: 3bd045cc9c4b ("separate copying and locking mount tree on cross-userns copies")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 14601ec4c2c5..eed83254492f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2768,14 +2768,14 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	hlist_for_each_entry_safe(child, n, &tree_list, mnt_hash) {
 		struct mount *q;
 		hlist_del_init(&child->mnt_hash);
-		q = __lookup_mnt(&child->mnt_parent->mnt,
-				 child->mnt_mountpoint);
-		if (q)
-			mnt_change_mountpoint(child, smp, q);
 		/* Notice when we are propagating across user namespaces */
 		if (child->mnt_parent->mnt_ns->user_ns != user_ns)
 			lock_mnt_tree(child);
 		child->mnt.mnt_flags &= ~MNT_LOCKED;
+		q = __lookup_mnt(&child->mnt_parent->mnt,
+				 child->mnt_mountpoint);
+		if (q)
+			mnt_change_mountpoint(child, smp, q);
 		commit_tree(child);
 	}
 	put_mountpoint(smp);
-- 
2.39.5


