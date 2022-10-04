Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA415F413D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 13:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJDLAB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 07:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiJDK7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:59:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B40D10D6;
        Tue,  4 Oct 2022 03:59:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA733B819BA;
        Tue,  4 Oct 2022 10:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF3AC433D6;
        Tue,  4 Oct 2022 10:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664881177;
        bh=41d3lcHf5P4mC0WuBshx8sCdcu2vykEQa3hb81hp1aQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZoTbqhs3pH1e2O1fizPxHN92sywX0jpDkR7XSrmlIYF9qmVZD7Qr+0kWS5JWIV5Jo
         2SS0kXKNTnI8sBIUkRY3dZazwYZMFvYKBXwdhq1gkKh0QxG2h1NXWLMVJn7znuE3VF
         AWtGKmTVS3aAfe+cpD9MYAETx8L4BwMK4TkgUVfGyKuomhMIJgfRgqeO/hJucMlJsW
         I93DH66UQ+zTCVzmAXhQRY4rVaWRB6kAIFaM2TCbRP1OWM+gTa+N8zBtrZQk8Feq1v
         wHU32ANaziMDreKSpvCdS3GRuV+gI+0fd5Fj540AbsX9+M966X1OfPa98Msf6i9wFq
         KNMxFSZ2CL6bw==
Date:   Tue, 4 Oct 2022 12:59:32 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] ovl: remove privs in ovl_fallocate()
Message-ID: <20221004105932.bpvqstjrfpud5rcs@wittgenstein>
References: <20221003123040.900827-1-amir73il@gmail.com>
 <20221003123040.900827-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221003123040.900827-3-amir73il@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 03, 2022 at 03:30:40PM +0300, Amir Goldstein wrote:
> Underlying fs doesn't remove privs because fallocate is called with
> privileged mounter credentials.
> 
> This fixes some failure in fstests generic/683..687.
> 
> Fixes: aab8848cee5e ("ovl: add ovl_fallocate()")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/overlayfs/file.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index c8308da8909a..e90ac5376456 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -517,9 +517,16 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
>  	const struct cred *old_cred;
>  	int ret;
>  
> +	inode_lock(inode);
> +	/* Update mode */
> +	ovl_copyattr(inode);
> +	ret = file_remove_privs(file);

First, thank you for picking this up!

Let me analyze generic/683 failure of Test1 to see why you still see
failures in this test:

echo "Test 1 - qa_user, non-exec file $verb"
setup_testfile
chmod a+rws $junk_file
commit_and_check "$qa_user" "$verb" 64k 64k

So this creates a file with 6666 permissions. While the file has the
S_ISUID and S_ISGID bits set it does not have the S_IXGRP set. This is
important in a little bit.

On a regular filesystem like xfs what will happen is:

sys_fallocate()
-> vfs_fallocate()
   -> xfs_file_fallocate()
      -> file_modified()
         -> __file_remove_privs()
            -> dentry_needs_remove_privs()
               -> should_remove_suid()
            -> __remove_privs()
               newattrs.ia_valid = ATTR_FORCE | kill;
               -> notify_change()

In should_remove_suid() we can see that ATTR_KILL_SUID is raised
unconditionally because the file in the test has S_ISUID set.

But we also see that ATTR_KILL_SGID won't be set because while the file
is S_ISGID it is not S_IXGRP (see above) which is a condition for
ATTR_KILL_SGID being raised.

So by the time we call notify_change() we have attr->ia_valid set to
ATTR_KILL_SUID | ATTR_FORCE. Now notify_change() sees that
ATTR_KILL_SUID is set and does:

ia_valid = attr->ia_valid |= ATTR_MODE
attr->ia_mode = (inode->i_mode & ~S_ISUID);

which means that when we call setattr_copy() later we will definitely
update inode->i_mode. Note that attr->ia_mode still contain S_ISGID.

Now we call into the filesystem's ->setattr() inode operation which will end up
calling setattr_copy(). Since ATTR_MODE is set we will hit:

if (ia_valid & ATTR_MODE) {
        umode_t mode = attr->ia_mode;
        vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
        if (!vfsgid_in_group_p(vfsgid) &&
            !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
                mode &= ~S_ISGID;
        inode->i_mode = mode;
}

and since the caller in the test is neither capable nor in the group of the
inode the S_ISGID bit is stripped.

But now contrast this with overlayfs even after your changes. When
ovl_setattr() is hit from ovl_fallocate()'s call to file_remove_privs()
and calls ovl_do_notify_change() then we are doing this under the
mounter's creds and so the S_ISGID bit is retained:

sys_fallocate()
-> vfs_fallocate()
   -> ovl_fallocate()
      -> file_remove_privs()
         -> dentry_needs_remove_privs()
            -> should_remove_suid()
         -> __remove_privs()
            newattrs.ia_valid = attr_force | kill;
            -> notify_change()
	       -> ovl_setattr()
	          // TAKE ON MOUNTER'S CREDS
	          -> ovl_do_notify_change()
	          // GIVE UP MOUNTER'S CREDS
     // TAKE ON MOUNTER'S CREDS
     -> vfs_fallocate()
        -> xfs_file_fallocate()
           -> file_modified()
              -> __file_remove_privs()
                 -> dentry_needs_remove_privs()
                    -> should_remove_suid()
                 -> __remove_privs()
                    newattrs.ia_valid = attr_force | kill;
                    -> notify_change()
