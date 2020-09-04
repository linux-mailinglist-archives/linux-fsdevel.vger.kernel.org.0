Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C2E25DF1D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 18:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgIDQGf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 12:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbgIDQFv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:05:51 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDA3B20772;
        Fri,  4 Sep 2020 16:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599235551;
        bh=L2/V/5hUAv0dQLRJb7AhQdxLOxUodIGz52r4rMuTRRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EEgtSJ3jSaTR88quYfZvTQY3HQnGwwZan9OlEFXbWDgDoKH7NemLL0fWOU8QHrwXH
         /ELlAZY0oh8F/580vZbcXSccObbqQjhBGAYNSF5WVPo3+tsk7CbBJox3fObwexGNwc
         dIB+ldrAG1pEfrecoIp3CGdedDMwHtM1+l+mmNP0=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        ebiggers@kernel.org
Subject: [RFC PATCH v2 15/18] ceph: make d_revalidate call fscrypt revalidator for encrypted dentries
Date:   Fri,  4 Sep 2020 12:05:34 -0400
Message-Id: <20200904160537.76663-16-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904160537.76663-1-jlayton@kernel.org>
References: <20200904160537.76663-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we have an encrypted dentry, then we need to test whether a new key
might have been established or removed. Do that before we test anything
else about the dentry.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/dir.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index b3f2741becdb..cc85933413b9 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1695,6 +1695,12 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 	dout("d_revalidate %p '%pd' inode %p offset 0x%llx\n", dentry,
 	     dentry, inode, ceph_dentry(dentry)->offset);
 
+	if (IS_ENCRYPTED(dir)) {
+		valid = fscrypt_d_revalidate(dentry, flags);
+		if (valid <= 0)
+			return valid;
+	}
+
 	mdsc = ceph_sb_to_client(dir->i_sb)->mdsc;
 
 	/* always trust cached snapped dentries, snapdir dentry */
-- 
2.26.2

