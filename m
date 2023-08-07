Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3222677250C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 15:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbjHGNIL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 09:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjHGNIK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:08:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373D310FD;
        Mon,  7 Aug 2023 06:08:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA00561A73;
        Mon,  7 Aug 2023 13:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF49C433C8;
        Mon,  7 Aug 2023 13:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691413688;
        bh=T4H5FHLaTu/CMH204/FAnov8lc6ZCUi87TDnDHHPTE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CRco9KD2M2RT13Q9QDFHqw7O9kx+gb9Xfxmh2X85dVJCyOaKFD6d/qS219QiH46jH
         fCk6AKnukj8xDtWQZOU2Y/IMZ14PoR6VgFPb+iX39ookD+LXdK9NkS9D4jI6xeP3Ql
         281kAbXQJsCXmYSDlwtKYoYTwYzThA/qadNhhVKaDilCJVrADlV5f/1QYueQxzPaIx
         O5bd2m0pEu6A232+Gzt/JTlXjpg+JwL3yJgLQ0rosx+A8vUZWe9RNcLMqchZ8UD9aL
         UX7t2E6P0rjgbcYQu0VY9zxIL4aDDjmdlfi/8UwmX7y+o8EFqdKTTIpev+Kgs1NM6d
         AZV9cjvUh1Mng==
Date:   Mon, 7 Aug 2023 15:08:01 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH v7] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
Message-ID: <20230807-gastdirigent-laufkundschaft-17e681a8e14e@brauner>
References: <20230804-master-v7-1-5d4e48407298@kernel.org>
 <20230805-anrechnen-medien-c639c85ebd42@brauner>
 <650f7b6ea6b55de4c9cbc791af0da4f800907c21.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <650f7b6ea6b55de4c9cbc791af0da4f800907c21.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 07, 2023 at 08:57:03AM -0400, Jeff Layton wrote:
> On Sat, 2023-08-05 at 14:43 +0200, Christian Brauner wrote:
> > On Fri, Aug 04, 2023 at 12:09:34PM -0400, Jeff Layton wrote:
> > > From: David Howells <dhowells@redhat.com>
> > > 
> > > When NFS superblocks are created by automounting, their LSM parameters
> > > aren't set in the fs_context struct prior to sget_fc() being called,
> > > leading to failure to match existing superblocks.
> > > 
> > > This bug leads to messages like the following appearing in dmesg when
> > > fscache is enabled:
> > > 
> > >     NFS: Cache volume key already in use (nfs,4.2,2,108,106a8c0,1,,,,100000,100000,2ee,3a98,1d4c,3a98,1)
> > > 
> > > Fix this by adding a new LSM hook to load fc->security for submount
> > > creation when alloc_fs_context() is creating the fs_context for it.
> > > 
> > > Signed-off-by: David Howells <dhowells@redhat.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > Fixes: 9bc61ab18b1d ("vfs: Introduce fs_context, switch vfs_kern_mount() to it.")
> > > Fixes: 779df6a5480f ("NFS: Ensure security label is set for root inode)
> > > Tested-by: Jeff Layton <jlayton@kernel.org>
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> > > Acked-by: "Christian Brauner (Microsoft)" <brauner@kernel.org>
> > > Link: https://lore.kernel.org/r/165962680944.3334508.6610023900349142034.stgit@warthog.procyon.org.uk/ # v1
> > > Link: https://lore.kernel.org/r/165962729225.3357250.14350728846471527137.stgit@warthog.procyon.org.uk/ # v2
> > > Link: https://lore.kernel.org/r/165970659095.2812394.6868894171102318796.stgit@warthog.procyon.org.uk/ # v3
> > > Link: https://lore.kernel.org/r/166133579016.3678898.6283195019480567275.stgit@warthog.procyon.org.uk/ # v4
> > > Link: https://lore.kernel.org/r/217595.1662033775@warthog.procyon.org.uk/ # v5
> > > ---
> > > ver #7)
> > >  - Drop lsm_set boolean
> > >  - Link to v6: https://lore.kernel.org/r/20230802-master-v6-1-45d48299168b@kernel.org
> > > 
> > > ver #6)
> > >  - Rebase onto v6.5.0-rc4
> > > 
> > > ver #5)
> > >  - Removed unused variable.
> > >  - Only allocate smack_mnt_opts if we're dealing with a submount.
> > > 
> > > ver #4)
> > >  - When doing a FOR_SUBMOUNT mount, don't set the root label in SELinux or
> > >    Smack.
> > > 
> > > ver #3)
> > >  - Made LSM parameter extraction dependent on fc->purpose ==
> > >    FS_CONTEXT_FOR_SUBMOUNT.  Shouldn't happen on FOR_RECONFIGURE.
> > > 
> > > ver #2)
> > >  - Added Smack support
> > >  - Made LSM parameter extraction dependent on reference != NULL.
> > > ---
> > >  fs/fs_context.c               |  4 ++++
> > >  include/linux/lsm_hook_defs.h |  1 +
> > >  include/linux/security.h      |  6 +++++
> > >  security/security.c           | 14 +++++++++++
> > >  security/selinux/hooks.c      | 25 ++++++++++++++++++++
> > >  security/smack/smack_lsm.c    | 54 +++++++++++++++++++++++++++++++++++++++++++
> > >  6 files changed, 104 insertions(+)
> > > 
> > > diff --git a/fs/fs_context.c b/fs/fs_context.c
> > > index 851214d1d013..a523aea956c4 100644
> > > --- a/fs/fs_context.c
> > > +++ b/fs/fs_context.c
> > > @@ -282,6 +282,10 @@ static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
> > >  		break;
> > >  	}
> > >  
> > > +	ret = security_fs_context_init(fc, reference);
> > > +	if (ret < 0)
> > > +		goto err_fc;
> > > +
> > >  	/* TODO: Make all filesystems support this unconditionally */
> > >  	init_fs_context = fc->fs_type->init_fs_context;
> > >  	if (!init_fs_context)
> > > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > > index 7308a1a7599b..7ce3550154b1 100644
> > > --- a/include/linux/lsm_hook_defs.h
> > > +++ b/include/linux/lsm_hook_defs.h
> > > @@ -54,6 +54,7 @@ LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, struct file *f
> > >  LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
> > >  LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binprm *bprm)
> > >  LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm *bprm)
> > > +LSM_HOOK(int, 0, fs_context_init, struct fs_context *fc, struct dentry *reference)
> > >  LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
> > >  	 struct fs_context *src_sc)
> > >  LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
> > > diff --git a/include/linux/security.h b/include/linux/security.h
> > > index 32828502f09e..61fda06fac9d 100644
> > > --- a/include/linux/security.h
> > > +++ b/include/linux/security.h
> > > @@ -293,6 +293,7 @@ int security_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file);
> > >  int security_bprm_check(struct linux_binprm *bprm);
> > >  void security_bprm_committing_creds(struct linux_binprm *bprm);
> > >  void security_bprm_committed_creds(struct linux_binprm *bprm);
> > > +int security_fs_context_init(struct fs_context *fc, struct dentry *reference);
> > >  int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc);
> > >  int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param);
> > >  int security_sb_alloc(struct super_block *sb);
> > > @@ -629,6 +630,11 @@ static inline void security_bprm_committed_creds(struct linux_binprm *bprm)
> > >  {
> > >  }
> > >  
> > > +static inline int security_fs_context_init(struct fs_context *fc,
> > > +					   struct dentry *reference)
> > 
> > I think that's the wrong way of doing this hook. The security hook
> > really doesn't belong into alloc_fs_context().
> > 
> > I think what we want is a dedicated helper similar to vfs_dup_context():
> > 
> > // Only pass the superblock. There's no need for the dentry. I would
> > // avoid even passing fs_context but if that's preferred then sure.
> > security_fs_context_submount(struct fs_context *fc, const struct super_block *sb)
> > 
> > vfs_submount_fs_context(struct file_system_type *fs_type, struct dentry *reference)
> > {
> >         fc = fs_context_for_submount(fs_type, reference);
> > 
> >         security_fs_context_for_submount(fc, reference->d_sb);
> > }
> > 
> > This automatically ensures it's only called for submounts, the LSM
> > doesn't need to care about fc->purpose and this isn't called
> > in a pure allocation function for all allocation calls.
> > 
> > The we should switch all callers over to that new helper and unexport
> > that fs_context_for_submount() thing completely. Yes, that's more work
> > but that's the correct thing to do. And we need to audit fuse, cifs,
> > afs, and nfs anyway that they work fine with the new security hook.*
> > 
> 
> It's the same prototype. We could just move the hook call to the end of
> fs_context_for_submount, and that would be less churn for its callers.

If you just add it into fs_context_for_submount() after the allocation
and then leave that as first class citizen it's fine ofc. It's the same
result as what I mentioned earlier. We just shouldn't put generic hooks
in an allocation function that allocates different types of filesystem
contexts. I prefer to have them as targeted as possible and also avoid
unnecessary trips into the LSM layer.

> Or were you wanting to do that to make this a more gradual changeover
> for some reason?

No, I think it's fine if you switch it all in one go. I just don't know
if fuse/virtiofs submounts expect an selinux context to be bestowed upon
them.
