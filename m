Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AAD598E26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 22:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346120AbiHRUfT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 16:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345574AbiHRUfR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:35:17 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2560FD2B2C;
        Thu, 18 Aug 2022 13:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=53E2Yo5ESs/I+3QUv/Re4q+BkYWNVyRc6niwYZP0G5I=; b=LO23WrHCwFjA5w+i1qu28x+8hl
        ZQZ0G/9mfO1hVOcxqbTyJbiYPXL+vhUoXT1n81C0Uw01SaGhk5kbD98XPXpqiiLkYXkdp5M6ih5Bh
        TotN6VtDm/AXBToEYcpzw+dz/aVslDdd4KVWmEsUzihsUxBrzGxghswpYPFwo/xKEeq4IZy+oDetP
        TYabo7EdxwWYzCnZbLVmhImZ4OLtVR+iFeuA37YHLsZjtcu/KxAosUfGR6OE51LnnvOTqNk+Pghjm
        qGhukkA1YjGf1VrFqGHaT1vY8J3KlRzAUs4mHLHaMNfBZbTya4zli68P2TMvuYrGpY1KOs0Z2eExA
        v5sM3BCw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oOmES-005owk-QY;
        Thu, 18 Aug 2022 20:35:12 +0000
Date:   Thu, 18 Aug 2022 21:35:12 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH 4/5] ksmbd: don't open-code %pf
Message-ID: <Yv6igFDtDa0vmq6H@ZenIV>
References: <Yv2qoNQg48rtymGE@ZenIV>
 <Yv2rCqD7M8fAhq5v@ZenIV>
 <CAKYAXd-Xsih1TKTbM0kTGmjQfpkbpp7d3u9E7USuwmiSXLVvBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd-Xsih1TKTbM0kTGmjQfpkbpp7d3u9E7USuwmiSXLVvBw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022 at 03:08:36PM +0900, Namjae Jeon wrote:
> 2022-08-18 11:59 GMT+09:00, Al Viro <viro@zeniv.linux.org.uk>:
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  fs/ksmbd/vfs.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
> > index 78d01033604c..a0fafba8b5d0 100644
> > --- a/fs/ksmbd/vfs.c
> > +++ b/fs/ksmbd/vfs.c
> > @@ -1743,11 +1743,11 @@ int ksmbd_vfs_copy_file_ranges(struct ksmbd_work
> > *work,
> >  	*total_size_written = 0;
> >
> >  	if (!(src_fp->daccess & (FILE_READ_DATA_LE | FILE_EXECUTE_LE))) {
> > -		pr_err("no right to read(%pd)\n", src_fp->filp->f_path.dentry);
> > +		pr_err("no right to read(%pf)\n", src_fp->filp);
> Isn't this probably %pD?

*blink*

It certainly is; thanks for catching that braino...  While we are at it,
there's several more places of the same form these days, so fixed and
updated variant follows:

ksmbd: don't open-code %pD
    
a bunch of places used %pd with file->f_path.dentry; shorter (and saner)
way to spell that is %pD with file...
    
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 0e1924a6476d..bed670410c37 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -3897,8 +3897,7 @@ int smb2_query_dir(struct ksmbd_work *work)
 	    inode_permission(file_mnt_user_ns(dir_fp->filp),
 			     file_inode(dir_fp->filp),
 			     MAY_READ | MAY_EXEC)) {
-		pr_err("no right to enumerate directory (%pd)\n",
-		       dir_fp->filp->f_path.dentry);
+		pr_err("no right to enumerate directory (%pD)\n", dir_fp->filp);
 		rc = -EACCES;
 		goto err_out2;
 	}
@@ -6269,8 +6268,8 @@ int smb2_read(struct ksmbd_work *work)
 		goto out;
 	}
 
-	ksmbd_debug(SMB, "filename %pd, offset %lld, len %zu\n",
-		    fp->filp->f_path.dentry, offset, length);
+	ksmbd_debug(SMB, "filename %pD, offset %lld, len %zu\n",
+		    fp->filp, offset, length);
 
 	work->aux_payload_buf = kvmalloc(length, GFP_KERNEL | __GFP_ZERO);
 	if (!work->aux_payload_buf) {
@@ -6534,8 +6533,8 @@ int smb2_write(struct ksmbd_work *work)
 		data_buf = (char *)(((char *)&req->hdr.ProtocolId) +
 				    le16_to_cpu(req->DataOffset));
 
-		ksmbd_debug(SMB, "filename %pd, offset %lld, len %zu\n",
-			    fp->filp->f_path.dentry, offset, length);
+		ksmbd_debug(SMB, "filename %pD, offset %lld, len %zu\n",
+			    fp->filp, offset, length);
 		err = ksmbd_vfs_write(work, fp, data_buf, length, &offset,
 				      writethrough, &nbytes);
 		if (err < 0)
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 78d01033604c..0c04a59cbe60 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -377,8 +377,7 @@ int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
 
 	if (work->conn->connection_type) {
 		if (!(fp->daccess & (FILE_READ_DATA_LE | FILE_EXECUTE_LE))) {
-			pr_err("no right to read(%pd)\n",
-			       fp->filp->f_path.dentry);
+			pr_err("no right to read(%pD)\n", fp->filp);
 			return -EACCES;
 		}
 	}
@@ -487,8 +486,7 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 
 	if (work->conn->connection_type) {
 		if (!(fp->daccess & FILE_WRITE_DATA_LE)) {
-			pr_err("no right to write(%pd)\n",
-			       fp->filp->f_path.dentry);
+			pr_err("no right to write(%pD)\n", fp->filp);
 			err = -EACCES;
 			goto out;
 		}
@@ -527,8 +525,8 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 	if (sync) {
 		err = vfs_fsync_range(filp, offset, offset + *written, 0);
 		if (err < 0)
-			pr_err("fsync failed for filename = %pd, err = %d\n",
-			       fp->filp->f_path.dentry, err);
+			pr_err("fsync failed for filename = %pD, err = %d\n",
+			       fp->filp, err);
 	}
 
 out:
@@ -1743,11 +1741,11 @@ int ksmbd_vfs_copy_file_ranges(struct ksmbd_work *work,
 	*total_size_written = 0;
 
 	if (!(src_fp->daccess & (FILE_READ_DATA_LE | FILE_EXECUTE_LE))) {
-		pr_err("no right to read(%pd)\n", src_fp->filp->f_path.dentry);
+		pr_err("no right to read(%pD)\n", src_fp->filp);
 		return -EACCES;
 	}
 	if (!(dst_fp->daccess & (FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE))) {
-		pr_err("no right to write(%pd)\n", dst_fp->filp->f_path.dentry);
+		pr_err("no right to write(%pD)\n", dst_fp->filp);
 		return -EACCES;
 	}
 
