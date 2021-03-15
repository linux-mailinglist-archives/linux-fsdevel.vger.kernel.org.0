Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAC333C53C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 19:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhCOSHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 14:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230287AbhCOSHU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:07:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F9CF64F37;
        Mon, 15 Mar 2021 18:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615831640;
        bh=AlajZnYK1cbulqk1lQLn9BPuxq9jUuZejkdjoUBA0Uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=axXjXGt1FSsrEy4rCGHT2YFZKypBXvJfJYTQgxRiqyNfef7G7g2fbwxPVek5JvIZV
         hMC6S0OFgigtNDlLge/6uSmgq5mBN/pRCl+GlKh0JyNbWtjymp2rQqSQuoCW7tzU4/
         a4+/DDB+wt7doYdyS8sS4nUzQZein8Eq0JNckgj8R3VBJfKrHoYmHB+fzDe9zq5cR9
         7Ibh4Ffn386Wz/TMVjs8X7UuWeWY9TGHQVX5eexAhTtTEZpI6MvEmWSnZsfnkJ/qW+
         GaKN1+Z2lfEH2Q0a2Xz+LZ+gQbU7fgFjviw31kBAGuiv0EWGtuSAjrGmyS9HN7mCck
         zsE3+ux5B+W3w==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, idryomov@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: [PATCH 1/2] ceph: don't clobber i_snap_caps on non-I_NEW inode
Date:   Mon, 15 Mar 2021 14:07:16 -0400
Message-Id: <20210315180717.266155-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315180717.266155-1-jlayton@kernel.org>
References: <20210315180717.266155-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We want the snapdir to mirror the non-snapped directory's attributes for
most things, but i_snap_caps represents the caps granted on the snapshot
directory by the MDS itself. A misbehaving MDS could issue different
caps for the snapdir and we lose them here.

Only reset i_snap_caps when the inode is I_NEW.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 26dc7a296f6b..fc7f4bf63306 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -101,12 +101,13 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 	inode->i_atime = parent->i_atime;
 	inode->i_op = &ceph_snapdir_iops;
 	inode->i_fop = &ceph_snapdir_fops;
-	ci->i_snap_caps = CEPH_CAP_PIN; /* so we can open */
-	ci->i_rbytes = 0;
 	ci->i_btime = ceph_inode(parent)->i_btime;
+	ci->i_rbytes = 0;
 
-	if (inode->i_state & I_NEW)
+	if (inode->i_state & I_NEW) {
+		ci->i_snap_caps = CEPH_CAP_PIN; /* so we can open */
 		unlock_new_inode(inode);
+	}
 
 	return inode;
 }
-- 
2.30.2

