Return-Path: <linux-fsdevel+bounces-53275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDDEAED2A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258E23B522F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC48F21019C;
	Mon, 30 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="e6Y1yR5J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008E81C4609
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251983; cv=none; b=HHdtPwjFNtT11qYKGkXyk9aINX8/P4eU0xq624NjpceDoSCx1RGgD2IOvxnZ2ESm9aos2tnqtTcHhsfwyXlVBQXOxTUW5qejw+jHoVmDx1N04IMTZ2SYUkCiHX4qJ3nIFzHk7XZRo6hOfql5Q+EY8mVmtoLDquDjDTkbnE7xI6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251983; c=relaxed/simple;
	bh=WLv/8dwh2uzazzwCmpPeURH7VdwaQvPnpkbU4anF828=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSHfeHDFdvWcNRc0FnrDSTKuZdf+yGeE8HE7Vq+dGza9TxG8W3EBItKdz60lsZbGxwAB2ULEScAbYw1yvF8JQeawFYqLG9PAxnLAEbpNEZwb2gmogY9dgmEMFSar5iCjhNheKzR7Y0wDSCCaDHmc15ull6dpneuU5EKmpjQ9eC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=e6Y1yR5J; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=g+OYNGqBhLFN+Gjp0hfK5Gws0eHQRL62NSoM+nOcYMQ=; b=e6Y1yR5JaerOgOWCKGDOOU44Lq
	lFc/VIlAJXDmxhuQ5kI6hKxHdPFL6V9Xwwj5EtcWzbkZvSihAIguhzpfiSfgz6h1Olsv4yphwbCia
	igEUBqW2rtkVqVBBjcsOnI6yjAFTfKflIGrHAxp3P9Xk0a3bNBpOku227zej7HG6VVALBo5P6xKuo
	r5kNMNNeuMsFPHb1Bjq9AwmvNNxADtfBQcaDN5WB9+M1OVFgWlV6dxHICS0Z8aEYUSINmqxCDpPwH
	uVDdjN68sD4HMRsWDlz1jFP143tTXBpeklKVp7aVVt6HltpqH5UUxN1dUf6pEzh3GVMM+eLZqbKTm
	RJ9wJTEw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4df-00000005p1y-1YPK;
	Mon, 30 Jun 2025 02:52:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 36/48] propagate_mnt(): get rid of last_dest
Date: Mon, 30 Jun 2025 03:52:43 +0100
Message-ID: <20250630025255.1387419-36-viro@zeniv.linux.org.uk>
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

Its only use is choosing the type of copy - CL_MAKE_SHARED if there
already is a copy in that peer group, CL_SLAVE or CL_SLAVE | CL_MAKE_SHARED
otherwise.

But that's easy to keep track of - just set type in the beginning of group
and reset to CL_MAKE_SHARED after the first created secondary in it...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pnode.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index e01f43820a93..b3af55123a82 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -269,35 +269,32 @@ static struct mount *find_master(struct mount *m,
 int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 		    struct mount *source_mnt, struct hlist_head *tree_list)
 {
-	struct mount *m, *n, *copy, *this, *last_dest;
+	struct mount *m, *n, *copy, *this;
 	int err = 0, type;
 
-	last_dest = dest_mnt;
-	copy = source_mnt;
 	if (dest_mnt->mnt_master)
 		SET_MNT_MARK(dest_mnt->mnt_master);
 
 	/* iterate over peer groups, depth first */
 	for (m = dest_mnt; m && !err; m = next_group(m, dest_mnt)) {
 		if (m == dest_mnt) { // have one for dest_mnt itself
+			copy = source_mnt;
+			type = CL_MAKE_SHARED;
 			n = next_peer(m);
 			if (n == m)
 				continue;
 		} else {
+			type = CL_SLAVE;
+			/* beginning of peer group among the slaves? */
+			if (IS_MNT_SHARED(m))
+				type |= CL_MAKE_SHARED;
 			n = m;
 		}
 		do {
 			if (!need_secondary(n, dest_mp))
 				continue;
-			if (peers(n, last_dest)) {
-				type = CL_MAKE_SHARED;
-			} else {
+			if (type & CL_SLAVE) // first in this peer group
 				copy = find_master(n, copy, source_mnt);
-				type = CL_SLAVE;
-				/* beginning of peer group among the slaves? */
-				if (IS_MNT_SHARED(n))
-					type |= CL_MAKE_SHARED;
-			}
 			this = copy_tree(copy, copy->mnt.mnt_root, type);
 			if (IS_ERR(this)) {
 				err = PTR_ERR(this);
@@ -308,12 +305,12 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 			read_sequnlock_excl(&mount_lock);
 			if (n->mnt_master)
 				SET_MNT_MARK(n->mnt_master);
-			last_dest = n;
 			copy = this;
 			hlist_add_head(&this->mnt_hash, tree_list);
 			err = count_mounts(n->mnt_ns, this);
 			if (err)
 				break;
+			type = CL_MAKE_SHARED;
 		} while ((n = next_peer(n)) != m);
 	}
 
-- 
2.39.5


