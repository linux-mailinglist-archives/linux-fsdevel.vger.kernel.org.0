Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D551D5B0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 22:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgEOU4m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 16:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgEOU4m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 16:56:42 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D092AC061A0C;
        Fri, 15 May 2020 13:56:41 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZhNV-009Hh7-7g; Fri, 15 May 2020 20:56:21 +0000
Date:   Fri, 15 May 2020 21:56:21 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Olga Kornievskaia <kolga@netapp.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        syzbot <syzbot+c1af344512918c61362c@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-security-module@vger.kernel.org,
        serge@hallyn.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        ".Tetsuo Handa" <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: linux-next boot error: general protection fault in
 tomoyo_get_local_path
Message-ID: <20200515205621.GH23230@ZenIV.linux.org.uk>
References: <0000000000002f0c7505a5b0e04c@google.com>
 <c3461e26-1407-2262-c709-dac0df3da2d0@i-love.sakura.ne.jp>
 <72cb7aea-92bd-d71b-2f8a-63881a35fad8@i-love.sakura.ne.jp>
 <20200515201357.GG23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515201357.GG23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 09:13:57PM +0100, Al Viro wrote:
> On Sat, May 16, 2020 at 12:36:28AM +0900, Tetsuo Handa wrote:
> > On 2020/05/16 0:18, Tetsuo Handa wrote:
[snip]
> > A similar bug (racing inode destruction with open() on proc filesystem) was fixed as
> > commit 6f7c41374b62fd80 ("tomoyo: Don't use nifty names on sockets."). Then, it might
> > not be safe to replace dentry->d_sb->s_fs_info with dentry->d_inode->i_sb->s_fs_info .
> 
> Could you explain why do you want to bother with d_inode() anyway?  Anything that
> does dentry->d_inode->i_sb can bloody well use dentry->d_sb.  And that's never
> changed over the struct dentry lifetime - ->d_sb is set on allocation and never
> modified afterwards.

Incidentally, this
        r_ino = nfs_fhget(ss_mnt->mnt_root->d_inode->i_sb, src_fh, &fattr,
                        NULL);
(in nfs42_ssc_open()) is just plain weird.

	1) d->d_inode->i_sb is equal to d->d_sb
	2) m->mnt_root->d_sb is equal to m->mnt_sb
IOW, the whole thing should be 
        r_ino = nfs_fhget(ss_mnt->mnt_sb, src_fh, &fattr, NULL);

Moreover,
	server = NFS_SERVER(ss_mnt->mnt_root->d_inode);
in the same function is again too convoluted for no good reason, seeing that
NFS_SERVER(inode) is NFS_SB(inode->i_sb).

Something along the lines of

nfs: don't obfuscate ->mnt_sb as ->mnt_root->d_inode->i_sb

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 8e5d6223ddd3..1e8ca45bc806 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -317,15 +317,14 @@ nfs42_ssc_open(struct vfsmount *ss_mnt, struct nfs_fh *src_fh,
 {
 	struct nfs_fattr fattr;
 	struct file *filep, *res;
-	struct nfs_server *server;
+	struct super_block *sb = ss_mnt->mnt_sb;
+	struct nfs_server *server = NFS_SB(sb);
 	struct inode *r_ino = NULL;
 	struct nfs_open_context *ctx;
 	struct nfs4_state_owner *sp;
 	char *read_name = NULL;
 	int len, status = 0;
 
-	server = NFS_SERVER(ss_mnt->mnt_root->d_inode);
-
 	nfs_fattr_init(&fattr);
 
 	status = nfs4_proc_getattr(server, src_fh, &fattr, NULL, NULL);
@@ -341,8 +340,7 @@ nfs42_ssc_open(struct vfsmount *ss_mnt, struct nfs_fh *src_fh,
 		goto out;
 	snprintf(read_name, len, SSC_READ_NAME_BODY, read_name_gen++);
 
-	r_ino = nfs_fhget(ss_mnt->mnt_root->d_inode->i_sb, src_fh, &fattr,
-			NULL);
+	r_ino = nfs_fhget(sb, src_fh, &fattr, NULL);
 	if (IS_ERR(r_ino)) {
 		res = ERR_CAST(r_ino);
 		goto out_free_name;
