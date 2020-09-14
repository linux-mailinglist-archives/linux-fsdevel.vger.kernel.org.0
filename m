Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A90B269584
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 21:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgINTTI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 15:19:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgINTRW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:17:22 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0F36221E5;
        Mon, 14 Sep 2020 19:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600111038;
        bh=rDemq33XJt6lQnTdk4QFnDjQ60aCNi5fWYRrwbTyZjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=igc/6RaTnba1YFRrooWazQEdvgr9QLoDr6e8jHVGKPwMx2h4DzCngUOUJVzBRwwMg
         B5/gtroU39YQOZDW7/xWjIBshYwa+PuZ7BkDEHvKeeISwUlreAF043k3XbJ3r2lVh/
         d8aJ6Qz2Mj5dC/kN24dWmpcgl5oqPEG64YlCr2F8=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v3 13/16] ceph: make d_revalidate call fscrypt revalidator for encrypted dentries
Date:   Mon, 14 Sep 2020 15:17:04 -0400
Message-Id: <20200914191707.380444-14-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914191707.380444-1-jlayton@kernel.org>
References: <20200914191707.380444-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we have a dentry which represents a no-key name, then we need to test
whether the parent directory's encryption key has since been added.  Do
that before we test anything else about the dentry.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/dir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index b1e04d7d4b68..b6e5d751024d 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1689,6 +1689,10 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 	dout("d_revalidate %p '%pd' inode %p offset 0x%llx\n", dentry,
 	     dentry, inode, ceph_dentry(dentry)->offset);
 
+	valid = fscrypt_d_revalidate(dentry, flags);
+	if (valid <= 0)
+		return valid;
+
 	mdsc = ceph_sb_to_client(dir->i_sb)->mdsc;
 
 	/* always trust cached snapped dentries, snapdir dentry */
-- 
2.26.2

