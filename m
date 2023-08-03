Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800C576EA56
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 15:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbjHCN3a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 09:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbjHCN3P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:29:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FA03C21;
        Thu,  3 Aug 2023 06:28:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B917B61DA1;
        Thu,  3 Aug 2023 13:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717C9C433C7;
        Thu,  3 Aug 2023 13:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691069285;
        bh=h6hdfySgHxDqBVi3enZ1Bajg6bKORcm3++m69sKmuEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IG4Gkucwm1mbLGKKV/B9RwfdNSOWljd5UbxhLOj6wF5WBY2BmAg3HZUVqbJk/TmkT
         dlH2ZND/d8QkcFDZSkkQq7yC/boFCLguAAKcgWNO6VnJD6KtcdzdCNVRdaP4oO5ag6
         yGCPfdmIsSfjA7Btzu8IXlHhvUuBXszz6yapaI+z2A9+fzElYvtF5LhheHO+fLz00+
         Uu1wtXLg794Tii74Yd6gczLt2jKR0b/7f7D/j2ElkUm372ZJyfQq+vdpUa8GtgbjiF
         NMgUS7R1zC6jkb4ntcvoiMn3OT0PuasIQMR0Brnb+2IdC3etFewGnbMAOeyuHY27+4
         YAyUxuosntjNg==
Date:   Thu, 3 Aug 2023 15:27:58 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
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
Subject: Re: [PATCH v6] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
Message-ID: <20230803-verlassen-lernprogramm-b9e61719ce55@brauner>
References: <20230802-master-v6-1-45d48299168b@kernel.org>
 <bac543537058619345b363bbfc745927.paul@paul-moore.com>
 <ca156cecbc070c3b7c68626572274806079a6e04.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca156cecbc070c3b7c68626572274806079a6e04.camel@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 02, 2023 at 03:34:27PM -0400, Jeff Layton wrote:
> On Wed, 2023-08-02 at 14:16 -0400, Paul Moore wrote:
> > On Aug  2, 2023 Jeff Layton <jlayton@kernel.org> wrote:
> > > 
> > > When NFS superblocks are created by automounting, their LSM parameters
> > > aren't set in the fs_context struct prior to sget_fc() being called,
> > > leading to failure to match existing superblocks.
> > > 
> > > Fix this by adding a new LSM hook to load fc->security for submount
> > > creation when alloc_fs_context() is creating the fs_context for it.
> > > 
> > > However, this uncovers a further bug: nfs_get_root() initialises the
> > > superblock security manually by calling security_sb_set_mnt_opts() or
> > > security_sb_clone_mnt_opts() - but then vfs_get_tree() calls
> > > security_sb_set_mnt_opts(), which can lead to SELinux, at least,
> > > complaining.
> > > 
> > > Fix that by adding a flag to the fs_context that suppresses the
> > > security_sb_set_mnt_opts() call in vfs_get_tree().  This can be set by NFS
> > > when it sets the LSM context on the new superblock.
> > > 
> > > The first bug leads to messages like the following appearing in dmesg:
> > > 
> > > 	NFS: Cache volume key already in use (nfs,4.2,2,108,106a8c0,1,,,,100000,100000,2ee,3a98,1d4c,3a98,1)
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
> > > This patch was originally sent by David several months ago, but it
> > > never got merged. I'm resending to resurrect the discussion. Can we
> > > get this fixed?
> > 
> > Sorry, I sorta lost track of this after the ROOTCONTEXT_MNT discussion
> > back in v3.  Looking at it a bit closer now I have one nitpicky
> > request and one larger concern (see below).
> > 
> > > diff --git a/fs/super.c b/fs/super.c
> > > index e781226e2880..13adf43e2e5d 100644
> > > --- a/fs/super.c
> > > +++ b/fs/super.c
> > > @@ -1541,10 +1541,12 @@ int vfs_get_tree(struct fs_context *fc)
> > >  	smp_wmb();
> > >  	sb->s_flags |= SB_BORN;
> > >  
> > > -	error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
> > > -	if (unlikely(error)) {
> > > -		fc_drop_locked(fc);
> > > -		return error;
> > > +	if (!(fc->lsm_set)) {
> > > +		error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
> > > +		if (unlikely(error)) {
> > > +			fc_drop_locked(fc);
> > > +			return error;
> > > +		}
> > >  	}
> > 
> > I generally dislike core kernel code which makes LSM calls conditional
> > on some kernel state maintained outside the LSM.  Sometimes it has to
> > be done as there is no other good options, but I would like us to try
> > and avoid it if possible.  The commit description mentioned that this
> > was put here to avoid a SELinux complaint, can you provide an example
> > of the complain?  Does it complain about a double/invalid mount, e.g.
> > "SELinux: mount invalid.  Same superblock, different security ..."?
> > 
> 
> The problem I had was not so much SELinux warnings, but rather that in a
> situation where I would expect to share superblocks between two
> filesystems, it didn't.
> 
> Basically if you do something like this:
> 
> # mount nfsserver:/export/foo /mnt/foo -o context=system_u:object_r:root_t:s0
> # mount nfsserver:/export/bar /mnt/bar -o context=system_u:object_r:root_t:s0
> 
> ...when "foo" and "bar" are directories on the same filesystem on the
> server, you should get two vfsmounts that share a superblock. That's
> what you get if selinux is disabled, but not when it's enabled (even
> when it's in permissive mode).
> 
> The problems that David hit with the automounter have a similar root
> cause though, I believe.
> 
> > I'd like to understand why the sb_set_mnt_opts() call fails when it
> > comes after the fs_context_init() call.  I'm particulary curious to
> > know if the failure is due to conflicting SELinux state in the
> > fs_context, or if it is simply an issue of sb_set_mnt_opts() not
> > properly handling existing values.  Perhaps I'm being overly naive,
> > but I'm hopeful that we can address both of these within the SELinux
> > code itself.
> > 
> 
> The problem I hit was that nfs_compare_super is called with a fs_context
> that has a NULL ->security pointer. That caused it to call
> selinux_sb_mnt_opts_compat with mnt_opts set to NULL, and at that point
> it returns 1 and decides not to share sb's.

I tried to follow this because I'm really still quite puzzled by this
whole thing. Two consecutive mounts that should share the superblock
don't share the superblock. But behavior differs between nfs3 and nfs4
due to how automounting works.

Afaict, the callchain you're looking at in this scenario is:

(1) nfs3

(1.1) mount 127.0.0.1:/export/foo /mnt/foo -o context=system_u:object_r:root_t:s0,nfsvers=3
      vfs_get_tree(fc_foo)
      -> fs_contex_operations->get_tree::nfs_get_tree(fc_foo)
            -> ctx->nfs_mod->rpc_ops->try_get_tree::nfs_try_get_tree(fc_foo)
               -> nfs_get_tree_common(fc_foo)
                  -> sb_foo = sget_fc(fc_foo, nfs_compare_super, ...)

(1.2) mount 127.0.0.1:/export/bar /mnt/bar -o context=system_u:object_r:root_t:s0,nfsvers=3
      vfs_get_tree(fc_bar)
      -> fs_contex_operations->get_tree::nfs_get_tree(fc_bar)
            -> ctx->nfs_mod->rpc_ops->try_get_tree::nfs_try_get_tree(fc_bar)
               -> nfs_get_tree_common(fc_bar)
                  -> sb_foo = sget_fc(fc_bar, nfs_compare_super, ...)
                     -> nfs_compare_super(sb_foo, fc_bar)
                        -> selinux_sb_mnt_opts_compat(sb_foo, fc_bar->security)

And fc_bar->security is non-NULL and compatible with sb_foo's current
security settings. Fine.

(2) nfs4

But for nfs4 we're looking at a vastly more complicated callchain at
least looking at this from a local nfs:

(2.1) mount 127.0.0.1:/export/foo /mnt/foo -o context=system_u:object_r:root_t:s0
      vfs_get_tree(fc_foo)
      -> fs_contex_operations->get_tree::nfs_get_tree(fc_foo)
         -> if (!ctx->internal) branch is taken
            -> ctx->nfs_mod->rpc_ops->try_get_tree::nfs4_try_get_tree(fc_foo)
               -> do_nfs4_mount(fc_foo)
                  -> fc_dup_foo = vfs_dup_fs_context(fc_foo)
                    -> security_fs_context_dup(fc_dup_foo, fc_foo)
                       {
                                fc_dup_foo->security = kmemdup(fc_foo->security)
                       }
                       new_fs_context->internal = true
                  -> foo_mnt = fc_mount(fc_dup_foo)
                    -> vfs_get_tree(fc_dup_foo)
                       -> if (!ctx->internal) branch is _not_ taken
                          -> nfs_get_tree_common(fc_dup_foo)
                                 sb_foo = sget_fc(fc, nfs_compare_super, ...)
                  -> mount_subtree()
                     -> vfs_path_lookup(..., "/export/foo", LOOKUP_AUTOMOUNT)
                        -> nfs_d_automount("export")
                           -> fc_sub_foo = fs_context_for_submount()
                              {
                                      fc_sub_bar->security = NULL
                              {
                           -> nfs4_submount(fc_sub_foo)
                              -> nfs4_do_submount(fc_sub_foo)
                                 -> vfs_get_tree(fc_sub_foo)
                                    -> nfs_get_tree_common(fc_sub_foo)
                                       -> sb_foo_2 = sget_fc(fc_sub_foo, nfs_compare_super, ...)
                        -> nfs_d_automount("foo")
                           -> fc_sub_foo = fs_context_for_submount()
                              {
                                      fc_sub_bar->security = NULL
                              {
                           -> nfs4_submount(fc_sub_foo)
                              -> nfs4_do_submount(fc_sub_foo)
                                 -> vfs_get_tree(fc_sub_foo)
                                    -> nfs_get_tree_common(fc_sub_foo)
             |--------------------------> sb_foo_3 = sget_fc(fc_sub_foo, nfs_compare_super, ...)
             |
As far as I can see you're already allocating 3 separate superblocks of
which two are discarded and only one survives. Afaict, the one that
survives is _| the last one. Under the assumption that I'm correct,
where does the third superblock get it's selinux context from given that
fc->security isn't even set during submount?

And where is the context=%s output generated for mountinfo?

Is this a correct callchain?

> 
> Filling out fc->security with this new operation seems to fix that, but
> if you see a better way to do this, then I'm certainly open to the idea.
> 
> > In a worst case situation, we could always implement a flag *inside*
> > the SELinux code, similar to what has been done with 'lsm_set' here.
> > 
> 
> I'm fine with a different solution, if you see a better one. You'll have

Independent of the modification in fs_context_for_submount() you might want to
think about something like:

static const struct fs_context_operations nfs4_fs_context_ops = {
      .free           = nfs4_free,
      .parse_param    = nfs4_parse_param,
      .get_tree       = nfs4_get_tree,
};

static const struct fs_context_operations nfs4_fs_submount_ops = {
      .free           = nfs4_free_submount,
      .parse_param    = nfs4_parse_param_submount,
      .get_tree       = nfs4_get_tree_submount,
};

static int nfs4_init_fs_context_submount(struct fs_context *fc)
{
        return 0;
}

static int nfs4_fs_context_get_tree(struct fs_context *fc)
{
        if (fc->purpose == FS_CONTEXT_FOR_SUBMOUNT)
                fc->ops = &nfs4_fs_submount_ops;
        else
                fc->ops = &nfs4_fs_context_ops;
        .
        .
        .
}

which will make the callchain probably a lot to follow instead of wafting
through the same nested functions over and over. But just a thought.
