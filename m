Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E6D59AB09
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 05:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240576AbiHTDrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 23:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbiHTDrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 23:47:11 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAFAB56C6;
        Fri, 19 Aug 2022 20:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jEisbFXoK0baeP7ZPXx11MPiAJ078uCaibUT3qGPYUA=; b=qRPozz0Dt+QCIgqqKnCjn+M2z5
        IJCufpDPjbLSzjKVZko0uTRwcGF3PDb39kIt1FuNfmijJ3cGnUYQcYt/zXP9SGt2S79YfeCMWhNDP
        t3BNwIztS9cSnuGXnRNNld6cDoS+TyjQymW4XCW+/Mrf/T1pYAtOswV7gPZSK3ofL7EwUuVuaj302
        qEmXlE+IdGo29+D9NgjLt8HS88vXx0pdH5TmLPSg50RjR4vRYLgbJbXoDSa/7u1mEIJqjyEJEPRWo
        jTM1rtK6OIsWDiHdH26hF5df8F2sVN+jOCeuRuJo7mf3D+cb94asWYi944ysAVEerH05A8EmPedEt
        0Gt2/Feg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPFS0-006Hvp-BM;
        Sat, 20 Aug 2022 03:47:08 +0000
Date:   Sat, 20 Aug 2022 04:47:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH 4/5] ksmbd: don't open-code %pf
Message-ID: <YwBZPCy0RBc9hwIk@ZenIV>
References: <Yv2qoNQg48rtymGE@ZenIV>
 <Yv2rCqD7M8fAhq5v@ZenIV>
 <CAKYAXd-Xsih1TKTbM0kTGmjQfpkbpp7d3u9E7USuwmiSXLVvBw@mail.gmail.com>
 <Yv6igFDtDa0vmq6H@ZenIV>
 <CAKYAXd-6fT5qG2VmVG6Q51Z8-_79cjKhERHDatR_z62w19+p1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd-6fT5qG2VmVG6Q51Z8-_79cjKhERHDatR_z62w19+p1Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 19, 2022 at 08:26:55AM +0900, Namjae Jeon wrote:
> 2022-08-19 5:35 GMT+09:00, Al Viro <viro@zeniv.linux.org.uk>:
> > On Thu, Aug 18, 2022 at 03:08:36PM +0900, Namjae Jeon wrote:
> >> 2022-08-18 11:59 GMT+09:00, Al Viro <viro@zeniv.linux.org.uk>:
> >> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> >> > ---
> >> >  fs/ksmbd/vfs.c | 4 ++--
> >> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
> >> > index 78d01033604c..a0fafba8b5d0 100644
> >> > --- a/fs/ksmbd/vfs.c
> >> > +++ b/fs/ksmbd/vfs.c
> >> > @@ -1743,11 +1743,11 @@ int ksmbd_vfs_copy_file_ranges(struct
> >> > ksmbd_work
> >> > *work,
> >> >  	*total_size_written = 0;
> >> >
> >> >  	if (!(src_fp->daccess & (FILE_READ_DATA_LE | FILE_EXECUTE_LE))) {
> >> > -		pr_err("no right to read(%pd)\n", src_fp->filp->f_path.dentry);
> >> > +		pr_err("no right to read(%pf)\n", src_fp->filp);
> >> Isn't this probably %pD?
> >
> > *blink*
> >
> > It certainly is; thanks for catching that braino...  While we are at it,
> > there's several more places of the same form these days, so fixed and
> > updated variant follows:
> Thanks for updating the patch!

OK...  FWIW, I've another ksmbd patch hanging around and it might be
less PITA if I put it + those two patches into never-rebased branch
(for-ksmbd) for ksmbd folks to pull from.  Fewer pointless conflicts
that way...  The third patch is below:

ksmbd: constify struct path
    
... in particular, there should never be a non-const pointers to
any file->f_path.
    
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

diff --git a/fs/ksmbd/misc.c b/fs/ksmbd/misc.c
index df991107ad2c..364a0a463dfc 100644
--- a/fs/ksmbd/misc.c
+++ b/fs/ksmbd/misc.c
@@ -159,7 +159,7 @@ int parse_stream_name(char *filename, char **stream_name, int *s_type)
  */
 
 char *convert_to_nt_pathname(struct ksmbd_share_config *share,
-			     struct path *path)
+			     const struct path *path)
 {
 	char *pathname, *ab_pathname, *nt_pathname;
 	int share_path_len = share->path_sz;
diff --git a/fs/ksmbd/misc.h b/fs/ksmbd/misc.h
index aae2a252945f..5a0ae2f8e5e7 100644
--- a/fs/ksmbd/misc.h
+++ b/fs/ksmbd/misc.h
@@ -15,7 +15,7 @@ int match_pattern(const char *str, size_t len, const char *pattern);
 int ksmbd_validate_filename(char *filename);
 int parse_stream_name(char *filename, char **stream_name, int *s_type);
 char *convert_to_nt_pathname(struct ksmbd_share_config *share,
-			     struct path *path);
+			     const struct path *path);
 int get_nlink(struct kstat *st);
 void ksmbd_conv_path_to_unix(char *path);
 void ksmbd_strip_last_slash(char *path);
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index bed670410c37..2b7b9dad94fc 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2183,7 +2183,7 @@ static noinline int create_smb2_pipe(struct ksmbd_work *work)
  * Return:	0 on success, otherwise error
  */
 static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
-		       struct path *path)
+		       const struct path *path)
 {
 	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
 	char *attr_name = NULL, *value;
@@ -2270,7 +2270,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 	return rc;
 }
 
-static noinline int smb2_set_stream_name_xattr(struct path *path,
+static noinline int smb2_set_stream_name_xattr(const struct path *path,
 					       struct ksmbd_file *fp,
 					       char *stream_name, int s_type)
 {
@@ -2309,7 +2309,7 @@ static noinline int smb2_set_stream_name_xattr(struct path *path,
 	return 0;
 }
 
-static int smb2_remove_smb_xattrs(struct path *path)
+static int smb2_remove_smb_xattrs(const struct path *path)
 {
 	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
 	char *name, *xattr_list = NULL;
@@ -2343,7 +2343,7 @@ static int smb2_remove_smb_xattrs(struct path *path)
 	return err;
 }
 
-static int smb2_create_truncate(struct path *path)
+static int smb2_create_truncate(const struct path *path)
 {
 	int rc = vfs_truncate(path, 0);
 
@@ -2362,7 +2362,7 @@ static int smb2_create_truncate(struct path *path)
 	return rc;
 }
 
-static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, struct path *path,
+static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, const struct path *path,
 			    struct ksmbd_file *fp)
 {
 	struct xattr_dos_attrib da = {0};
@@ -2385,7 +2385,7 @@ static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, struct path *path,
 }
 
 static void smb2_update_xattrs(struct ksmbd_tree_connect *tcon,
-			       struct path *path, struct ksmbd_file *fp)
+			       const struct path *path, struct ksmbd_file *fp)
 {
 	struct xattr_dos_attrib da;
 	int rc;
@@ -2445,7 +2445,7 @@ static int smb2_creat(struct ksmbd_work *work, struct path *path, char *name,
 
 static int smb2_create_sd_buffer(struct ksmbd_work *work,
 				 struct smb2_create_req *req,
-				 struct path *path)
+				 const struct path *path)
 {
 	struct create_context *context;
 	struct create_sd_buf_req *sd_buf;
@@ -4160,7 +4160,7 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 	int rc, name_len, value_len, xattr_list_len, idx;
 	ssize_t buf_free_len, alignment_bytes, next_offset, rsp_data_cnt = 0;
 	struct smb2_ea_info_req *ea_req = NULL;
-	struct path *path;
+	const struct path *path;
 	struct user_namespace *user_ns = file_mnt_user_ns(fp->filp);
 
 	if (!(fp->daccess & FILE_READ_EA_LE)) {
@@ -4497,7 +4497,7 @@ static void get_file_stream_info(struct ksmbd_work *work,
 	struct smb2_file_stream_info *file_info;
 	char *stream_name, *xattr_list = NULL, *stream_buf;
 	struct kstat stat;
-	struct path *path = &fp->filp->f_path;
+	const struct path *path = &fp->filp->f_path;
 	ssize_t xattr_list_len;
 	int nbytes = 0, streamlen, stream_name_len, next, idx = 0;
 	int buf_free_len;
diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index 3781bca2c8fc..85c4de640ed3 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -991,7 +991,7 @@ static void smb_set_ace(struct smb_ace *ace, const struct smb_sid *sid, u8 type,
 }
 
 int smb_inherit_dacl(struct ksmbd_conn *conn,
-		     struct path *path,
+		     const struct path *path,
 		     unsigned int uid, unsigned int gid)
 {
 	const struct smb_sid *psid, *creator = NULL;
@@ -1185,7 +1185,7 @@ bool smb_inherit_flags(int flags, bool is_dir)
 	return false;
 }
 
-int smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
+int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			__le32 *pdaccess, int uid)
 {
 	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
@@ -1352,7 +1352,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
 }
 
 int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
-		 struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
+		 const struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
 		 bool type_check)
 {
 	int rc;
diff --git a/fs/ksmbd/smbacl.h b/fs/ksmbd/smbacl.h
index fcb2c83f2992..f06abf247445 100644
--- a/fs/ksmbd/smbacl.h
+++ b/fs/ksmbd/smbacl.h
@@ -201,12 +201,12 @@ void posix_state_to_acl(struct posix_acl_state *state,
 			struct posix_acl_entry *pace);
 int compare_sids(const struct smb_sid *ctsid, const struct smb_sid *cwsid);
 bool smb_inherit_flags(int flags, bool is_dir);
-int smb_inherit_dacl(struct ksmbd_conn *conn, struct path *path,
+int smb_inherit_dacl(struct ksmbd_conn *conn, const struct path *path,
 		     unsigned int uid, unsigned int gid);
-int smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
+int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			__le32 *pdaccess, int uid);
 int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
-		 struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
+		 const struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
 		 bool type_check);
 void id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid);
 void ksmbd_init_domain(u32 *sub_auth);
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 0c04a59cbe60..4fcf96a01c16 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -541,7 +541,7 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
  *
  * Return:	0 on success, otherwise error
  */
-int ksmbd_vfs_getattr(struct path *path, struct kstat *stat)
+int ksmbd_vfs_getattr(const struct path *path, struct kstat *stat)
 {
 	int err;
 
@@ -1166,7 +1166,7 @@ static int __caseless_lookup(struct dir_context *ctx, const char *name,
  *
  * Return:	0 on success, otherwise error
  */
-static int ksmbd_vfs_lookup_in_dir(struct path *dir, char *name, size_t namelen)
+static int ksmbd_vfs_lookup_in_dir(const struct path *dir, char *name, size_t namelen)
 {
 	int ret;
 	struct file *dfilp;
diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
index 70da4c0ba7ad..d7542a2dab52 100644
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -85,7 +85,7 @@ int ksmbd_vfs_fsync(struct ksmbd_work *work, u64 fid, u64 p_id);
 int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name);
 int ksmbd_vfs_link(struct ksmbd_work *work,
 		   const char *oldname, const char *newname);
-int ksmbd_vfs_getattr(struct path *path, struct kstat *stat);
+int ksmbd_vfs_getattr(const struct path *path, struct kstat *stat);
 int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
 			char *newname);
 int ksmbd_vfs_truncate(struct ksmbd_work *work,
