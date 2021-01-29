Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1A2308D67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 20:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhA2T1S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 14:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbhA2T1R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:27:17 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F07C061574;
        Fri, 29 Jan 2021 11:27:02 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7A2254163; Fri, 29 Jan 2021 14:27:01 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7A2254163
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1611948421;
        bh=Czt3r+DII0qD79e+XDEsUiPQlCPOuV8iSW4i1vozb+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cMQpszRGMhwbbGuK/BZ9DB3fryZxvUhKKBw3H85anxYNPA8OVrSPULJsKsHwHgFYh
         anIOtEZeNVlWSQ9PVxujP+gOSotRy2Ind+fOTw08so9petmb704BQsF2/zE8Pnt1fZ
         YmbpBpsLyoq9E3zx3CStYrN6jWfnAD+woZJs17yg=
Date:   Fri, 29 Jan 2021 14:27:01 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 2/2 v2] nfsd: skip some unnecessary stats in the v4 case
Message-ID: <20210129192701.GD8033@fieldses.org>
References: <1611084297-27352-1-git-send-email-bfields@redhat.com>
 <1611084297-27352-3-git-send-email-bfields@redhat.com>
 <20210120084638.GA3678536@infradead.org>
 <20210121202756.GA13298@pick.fieldses.org>
 <20210122082059.GA119852@infradead.org>
 <20210129192629.GC8033@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129192629.GC8033@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

In the typical case of v4 and an i_version-supporting filesystem, we can
skip a stat which is only required to fake up a change attribute from
ctime.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs3xdr.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 821db21ba072..8bcda5274089 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -252,6 +252,11 @@ encode_wcc_data(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp)
 	return encode_post_op_attr(rqstp, p, fhp);
 }
 
+static bool fs_supports_change_attribute(struct super_block *sb)
+{
+	return sb->s_flags & SB_I_VERSION || sb->s_export_op->fetch_iversion;
+}
+
 /*
  * Fill in the pre_op attr for the wcc data
  */
@@ -260,24 +265,25 @@ void fill_pre_wcc(struct svc_fh *fhp)
 	struct inode    *inode;
 	struct kstat	stat;
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
-	__be32 err;
 
 	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
 		return;
 	inode = d_inode(fhp->fh_dentry);
-	err = fh_getattr(fhp, &stat);
-	if (err) {
-		/* Grab the times from inode anyway */
-		stat.mtime = inode->i_mtime;
-		stat.ctime = inode->i_ctime;
-		stat.size  = inode->i_size;
+	if (fs_supports_change_attribute(inode->i_sb) || !v4) {
+		__be32 err = fh_getattr(fhp, &stat);
+		if (err) {
+			/* Grab the times from inode anyway */
+			stat.mtime = inode->i_mtime;
+			stat.ctime = inode->i_ctime;
+			stat.size  = inode->i_size;
+		}
+		fhp->fh_pre_mtime = stat.mtime;
+		fhp->fh_pre_ctime = stat.ctime;
+		fhp->fh_pre_size  = stat.size;
 	}
 	if (v4)
 		fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
 
-	fhp->fh_pre_mtime = stat.mtime;
-	fhp->fh_pre_ctime = stat.ctime;
-	fhp->fh_pre_size  = stat.size;
 	fhp->fh_pre_saved = true;
 }
 
@@ -288,7 +294,6 @@ void fill_post_wcc(struct svc_fh *fhp)
 {
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
 	struct inode *inode = d_inode(fhp->fh_dentry);
-	__be32 err;
 
 	if (fhp->fh_no_wcc)
 		return;
@@ -296,12 +301,15 @@ void fill_post_wcc(struct svc_fh *fhp)
 	if (fhp->fh_post_saved)
 		printk("nfsd: inode locked twice during operation.\n");
 
-	err = fh_getattr(fhp, &fhp->fh_post_attr);
-	if (err) {
-		fhp->fh_post_saved = false;
-		fhp->fh_post_attr.ctime = inode->i_ctime;
-	} else
-		fhp->fh_post_saved = true;
+	fhp->fh_post_saved = true;
+
+	if (fs_supports_change_attribute(inode->i_sb) || !v4) {
+		__be32 err = fh_getattr(fhp, &fhp->fh_post_attr);
+		if (err) {
+			fhp->fh_post_saved = false;
+			fhp->fh_post_attr.ctime = inode->i_ctime;
+		}
+	}
 	if (v4)
 		fhp->fh_post_change =
 			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
-- 
2.29.2

