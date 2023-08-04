Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D045A7701FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjHDNjM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjHDNi6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:38:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B617749C5;
        Fri,  4 Aug 2023 06:38:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3697A62023;
        Fri,  4 Aug 2023 13:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37DDC433D9;
        Fri,  4 Aug 2023 13:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691156331;
        bh=xsOXK3337r2+9tc024ms0Swr6StPO0/gPNY9Xj6RLOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I5FANPmnhO5CzVHH1+5GLXxNpmqgaABeFjm+CMuZqAJvTROBRkO/J1dI0YqX9u1E4
         RW5BRR1ckn36FD9E5halhlXcfVV7k83EL15sME9c/qMYwRiOvTjbqyee5NC8ApBBZJ
         TvZlt3sRGZNKx4osgGiLeK+BH7CmNXEAkX46FBgSP6GM4RI1p1gUTgC6vo/rBEdDIh
         0wqY32KjVuXVujwrqL/2j9wWIG4VaAALVcg0xSXjjQHpYSGSGj5s7D3PF/6Vucm+lI
         NAr6QbhqEXG5Uin9dXeViQg44jfoZfD6CZ4YN3pA9VX29hz1VkSp+zw+r2x9omhta4
         o7AegDWnqHWLg==
Date:   Fri, 4 Aug 2023 15:38:44 +0200
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
Message-ID: <20230804-ehedrama-abspecken-1347ab6fe8a2@brauner>
References: <20230802-master-v6-1-45d48299168b@kernel.org>
 <bac543537058619345b363bbfc745927.paul@paul-moore.com>
 <ca156cecbc070c3b7c68626572274806079a6e04.camel@kernel.org>
 <20230803-verlassen-lernprogramm-b9e61719ce55@brauner>
 <782a39afec947b1a3575be9cf8921e7294190326.camel@kernel.org>
 <20230803-verstanden-perfide-70ee3b425417@brauner>
 <bab1dda495bc157d3d0650738ea9b620365d9813.camel@kernel.org>
 <20230804-geruch-fortgehen-f9dc1743cf8b@brauner>
 <1fc42ea5c54f9e47786f9d11d7630c9a34782bae.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1fc42ea5c54f9e47786f9d11d7630c9a34782bae.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 04, 2023 at 09:25:40AM -0400, Jeff Layton wrote:
> On Fri, 2023-08-04 at 10:25 +0200, Christian Brauner wrote:
> > On Thu, Aug 03, 2023 at 02:58:46PM -0400, Jeff Layton wrote:
> > > On Thu, 2023-08-03 at 19:36 +0200, Christian Brauner wrote:
> > > > On Thu, Aug 03, 2023 at 12:09:33PM -0400, Jeff Layton wrote:
> > > > > On Thu, 2023-08-03 at 15:27 +0200, Christian Brauner wrote:
> > > > > > On Wed, Aug 02, 2023 at 03:34:27PM -0400, Jeff Layton wrote:
> > > > > > > On Wed, 2023-08-02 at 14:16 -0400, Paul Moore wrote:
> > > > > > > > On Aug  2, 2023 Jeff Layton <jlayton@kernel.org> wrote:
> > > > > > > > > 
> > > > > > > > > When NFS superblocks are created by automounting, their LSM parameters
> > > > > > > > > aren't set in the fs_context struct prior to sget_fc() being called,
> > > > > > > > > leading to failure to match existing superblocks.
> > > > > > > > > 
> > > > > > > > > Fix this by adding a new LSM hook to load fc->security for submount
> > > > > > > > > creation when alloc_fs_context() is creating the fs_context for it.
> > > > > > > > > 
> > > > > > > > > However, this uncovers a further bug: nfs_get_root() initialises the
> > > > > > > > > superblock security manually by calling security_sb_set_mnt_opts() or
> > > > > > > > > security_sb_clone_mnt_opts() - but then vfs_get_tree() calls
> > > > > > > > > security_sb_set_mnt_opts(), which can lead to SELinux, at least,
> > > > > > > > > complaining.
> > > > > > > > > 
> > > > > > > > > Fix that by adding a flag to the fs_context that suppresses the
> > > > > > > > > security_sb_set_mnt_opts() call in vfs_get_tree().  This can be set by NFS
> > > > > > > > > when it sets the LSM context on the new superblock.
> > > > > > > > > 
> > > > > > > > > The first bug leads to messages like the following appearing in dmesg:
> > > > > > > > > 
> > > > > > > > > 	NFS: Cache volume key already in use (nfs,4.2,2,108,106a8c0,1,,,,100000,100000,2ee,3a98,1d4c,3a98,1)
> > > > > > > > > 
> > > > > > > > > Signed-off-by: David Howells <dhowells@redhat.com>
> > > > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > > Fixes: 9bc61ab18b1d ("vfs: Introduce fs_context, switch vfs_kern_mount() to it.")
> > > > > > > > > Fixes: 779df6a5480f ("NFS: Ensure security label is set for root inode)
> > > > > > > > > Tested-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> > > > > > > > > Acked-by: "Christian Brauner (Microsoft)" <brauner@kernel.org>
> > > > > > > > > Link: https://lore.kernel.org/r/165962680944.3334508.6610023900349142034.stgit@warthog.procyon.org.uk/ # v1
> > > > > > > > > Link: https://lore.kernel.org/r/165962729225.3357250.14350728846471527137.stgit@warthog.procyon.org.uk/ # v2
> > > > > > > > > Link: https://lore.kernel.org/r/165970659095.2812394.6868894171102318796.stgit@warthog.procyon.org.uk/ # v3
> > > > > > > > > Link: https://lore.kernel.org/r/166133579016.3678898.6283195019480567275.stgit@warthog.procyon.org.uk/ # v4
> > > > > > > > > Link: https://lore.kernel.org/r/217595.1662033775@warthog.procyon.org.uk/ # v5
> > > > > > > > > ---
> > > > > > > > > This patch was originally sent by David several months ago, but it
> > > > > > > > > never got merged. I'm resending to resurrect the discussion. Can we
> > > > > > > > > get this fixed?
> > > > > > > > 
> > > > > > > > Sorry, I sorta lost track of this after the ROOTCONTEXT_MNT discussion
> > > > > > > > back in v3.  Looking at it a bit closer now I have one nitpicky
> > > > > > > > request and one larger concern (see below).
> > > > > > > > 
> > > > > > > > > diff --git a/fs/super.c b/fs/super.c
> > > > > > > > > index e781226e2880..13adf43e2e5d 100644
> > > > > > > > > --- a/fs/super.c
> > > > > > > > > +++ b/fs/super.c
> > > > > > > > > @@ -1541,10 +1541,12 @@ int vfs_get_tree(struct fs_context *fc)
> > > > > > > > >  	smp_wmb();
> > > > > > > > >  	sb->s_flags |= SB_BORN;
> > > > > > > > >  
> > > > > > > > > -	error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
> > > > > > > > > -	if (unlikely(error)) {
> > > > > > > > > -		fc_drop_locked(fc);
> > > > > > > > > -		return error;
> > > > > > > > > +	if (!(fc->lsm_set)) {
> > > > > > > > > +		error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
> > > > > > > > > +		if (unlikely(error)) {
> > > > > > > > > +			fc_drop_locked(fc);
> > > > > > > > > +			return error;
> > > > > > > > > +		}
> > > > > > > > >  	}
> > > > > > > > 
> > > > > > > > I generally dislike core kernel code which makes LSM calls conditional
> > > > > > > > on some kernel state maintained outside the LSM.  Sometimes it has to
> > > > > > > > be done as there is no other good options, but I would like us to try
> > > > > > > > and avoid it if possible.  The commit description mentioned that this
> > > > > > > > was put here to avoid a SELinux complaint, can you provide an example
> > > > > > > > of the complain?  Does it complain about a double/invalid mount, e.g.
> > > > > > > > "SELinux: mount invalid.  Same superblock, different security ..."?
> > > > > > > > 
> > > > > > > 
> > > > > > > The problem I had was not so much SELinux warnings, but rather that in a
> > > > > > > situation where I would expect to share superblocks between two
> > > > > > > filesystems, it didn't.
> > > > > > > 
> > > > > > > Basically if you do something like this:
> > > > > > > 
> > > > > > > # mount nfsserver:/export/foo /mnt/foo -o context=system_u:object_r:root_t:s0
> > > > > > > # mount nfsserver:/export/bar /mnt/bar -o context=system_u:object_r:root_t:s0
> > > > > > > 
> > > > > > > ...when "foo" and "bar" are directories on the same filesystem on the
> > > > > > > server, you should get two vfsmounts that share a superblock. That's
> > > > > > > what you get if selinux is disabled, but not when it's enabled (even
> > > > > > > when it's in permissive mode).
> > > > > > > 
> > > > > > > The problems that David hit with the automounter have a similar root
> > > > > > > cause though, I believe.
> > > > > > > 
> > > > > > > > I'd like to understand why the sb_set_mnt_opts() call fails when it
> > > > > > > > comes after the fs_context_init() call.  I'm particulary curious to
> > > > > > > > know if the failure is due to conflicting SELinux state in the
> > > > > > > > fs_context, or if it is simply an issue of sb_set_mnt_opts() not
> > > > > > > > properly handling existing values.  Perhaps I'm being overly naive,
> > > > > > > > but I'm hopeful that we can address both of these within the SELinux
> > > > > > > > code itself.
> > > > > > > > 
> > > > > > > 
> > > > > > > The problem I hit was that nfs_compare_super is called with a fs_context
> > > > > > > that has a NULL ->security pointer. That caused it to call
> > > > > > > selinux_sb_mnt_opts_compat with mnt_opts set to NULL, and at that point
> > > > > > > it returns 1 and decides not to share sb's.
> > > > > > 
> > > > > > I tried to follow this because I'm really still quite puzzled by this
> > > > > > whole thing. Two consecutive mounts that should share the superblock
> > > > > > don't share the superblock. But behavior differs between nfs3 and nfs4
> > > > > > due to how automounting works.
> > > > > > 
> > > > > > Afaict, the callchain you're looking at in this scenario is:
> > > > > > 
> > > > > > (1) nfs3
> > > > > > 
> > > > > > (1.1) mount 127.0.0.1:/export/foo /mnt/foo -o context=system_u:object_r:root_t:s0,nfsvers=3
> > > > > >       vfs_get_tree(fc_foo)
> > > > > >       -> fs_contex_operations->get_tree::nfs_get_tree(fc_foo)
> > > > > >             -> ctx->nfs_mod->rpc_ops->try_get_tree::nfs_try_get_tree(fc_foo)
> > > > > >                -> nfs_get_tree_common(fc_foo)
> > > > > >                   -> sb_foo = sget_fc(fc_foo, nfs_compare_super, ...)
> > > > > > 
> > > > > > (1.2) mount 127.0.0.1:/export/bar /mnt/bar -o context=system_u:object_r:root_t:s0,nfsvers=3
> > > > > >       vfs_get_tree(fc_bar)
> > > > > >       -> fs_contex_operations->get_tree::nfs_get_tree(fc_bar)
> > > > > >             -> ctx->nfs_mod->rpc_ops->try_get_tree::nfs_try_get_tree(fc_bar)
> > > > > >                -> nfs_get_tree_common(fc_bar)
> > > > > >                   -> sb_foo = sget_fc(fc_bar, nfs_compare_super, ...)
> > > > > >                      -> nfs_compare_super(sb_foo, fc_bar)
> > > > > >                         -> selinux_sb_mnt_opts_compat(sb_foo, fc_bar->security)
> > > > > > 
> > > > > > And fc_bar->security is non-NULL and compatible with sb_foo's current
> > > > > > security settings. Fine.
> > > > > > 
> > > > > > (2) nfs4
> > > > > > 
> > > > > > But for nfs4 we're looking at a vastly more complicated callchain at
> > > > > > least looking at this from a local nfs:
> > > > > > 
> > > > > > (2.1) mount 127.0.0.1:/export/foo /mnt/foo -o context=system_u:object_r:root_t:s0
> > > > > >       vfs_get_tree(fc_foo)
> > > > > >       -> fs_contex_operations->get_tree::nfs_get_tree(fc_foo)
> > > > > >          -> if (!ctx->internal) branch is taken
> > > > > >             -> ctx->nfs_mod->rpc_ops->try_get_tree::nfs4_try_get_tree(fc_foo)
> > > > > >                -> do_nfs4_mount(fc_foo)
> > > > > >                   -> fc_dup_foo = vfs_dup_fs_context(fc_foo)
> > > > > >                     -> security_fs_context_dup(fc_dup_foo, fc_foo)
> > > > > >                        {
> > > > > >                                 fc_dup_foo->security = kmemdup(fc_foo->security)
> > > > > >                        }
> > > > > >                        new_fs_context->internal = true
> > > > > >                   -> foo_mnt = fc_mount(fc_dup_foo)
> > > > > >                     -> vfs_get_tree(fc_dup_foo)
> > > > > >                        -> if (!ctx->internal) branch is _not_ taken
> > > > > >                           -> nfs_get_tree_common(fc_dup_foo)
> > > > > >                                  sb_foo = sget_fc(fc, nfs_compare_super, ...)
> > > > > >                   -> mount_subtree()
> > > > > >                      -> vfs_path_lookup(..., "/export/foo", LOOKUP_AUTOMOUNT)
> > > > > >                         -> nfs_d_automount("export")
> > > > > >                            -> fc_sub_foo = fs_context_for_submount()
> > > > > >                               {
> > > > > >                                       fc_sub_bar->security = NULL
> > > > > 
> > > > > 
> > > > > Should the above be:
> > > > > 
> > > > > 					fc_sub_foo->security = NULL;
> > > > 
> > > > Yes, typo for whatever reason.
> > > > 
> > > > > 
> > > > > ?
> > > > > 
> > > > > If so, then with this patch, the above would no longer be NULL. We'd
> > > > > inherit the security context info from the reference dentry passed to
> > > > > fs_context_for_submount().
> > > > > 
> > > > > >                               {
> > > > > >                            -> nfs4_submount(fc_sub_foo)
> > > > > >                               -> nfs4_do_submount(fc_sub_foo)
> > > > > >                                  -> vfs_get_tree(fc_sub_foo)
> > > > > >                                     -> nfs_get_tree_common(fc_sub_foo)
> > > > > >                                        -> sb_foo_2 = sget_fc(fc_sub_foo, nfs_compare_super, ...)
> > > > > >                         -> nfs_d_automount("foo")
> > > > > >                            -> fc_sub_foo = fs_context_for_submount()
> > > > > >                               {
> > > > > >                                       fc_sub_bar->security = NULL
> > > > > 
> > > > > Ditto here -- that should be fc_sub_foo , correct?
> > > > 
> > > > Yes, same. Was just a typo.
> > > > 
> > > > > >                               {
> > > > > >                            -> nfs4_submount(fc_sub_foo)
> > > > > >                               -> nfs4_do_submount(fc_sub_foo)
> > > > > >                                  -> vfs_get_tree(fc_sub_foo)
> > > > > >                                     -> nfs_get_tree_common(fc_sub_foo)
> > > > > >              |--------------------------> sb_foo_3 = sget_fc(fc_sub_foo, nfs_compare_super, ...)
> > > > > >              |
> > > > > > As far as I can see you're already allocating 3 separate superblocks of
> > > > > > which two are discarded and only one survives. Afaict, the one that
> > > > > > survives is _| the last one. Under the assumption that I'm correct,
> > > > > > where does the third superblock get it's selinux context from given that
> > > > > > fc->security isn't even set during submount?
> > > > > > 
> > > > > 
> > > > > That's the problem this patch is intended to fix. It allows child mounts
> > > > > to properly inherit security options from a parent dentry.
> > > > 
> > > > Yeah, I'm aware. Your patch will ensure that the last superblock is
> > > > found again. But you're always going to allocate addititional
> > > > superblocks afaict. That's at least what I can gather from the logic.
> > > > Say you have:
> > > > 
> > > > /export/a/b/c/d/e/foo   *(rw,insecure,no_subtree_check,no_root_squash)
> > > > /export/a/b/c/d/e/bar   *(rw,insecure,no_subtree_check,no_root_squash)
> > > > 
> > > > you allocate 8 superblocks (it's always path components +1) of which you
> > > > immediately discard 7 after you finished. That's easily reproducible
> > > > with selinux completely disabled. I'm just astonished.
> > > > 
> > > 
> > > Actually, your callchain might not be correct.
> > > 
> > > I think that you should only end up calling back into nfs_d_automount
> > > and creating a new sb when we cross a mount boundary. So if each of
> > > those intermediate directories represents a different fs, then you'll
> > > get a bunch of superblocks that will end up discarded, but I don't
> > > believe we create a new mount just for intermediate directories that we
> > > can walk.
> > > 
> > > Basically the nfsv4 mount process is to create a (hidden) superblock for
> > > the root of the tree on the server, and then use the normal pathwalk
> > > scheme to walk down to the right dentry for the root. Once we get there
> > > we can prune everything above that point and we end up with a single sb.
> > 
> > Now, I may just be doing something really wrong but that's not what's
> > happening according to my tracing. See below. 
> > 
> > cat /etc/exports
> > /export/a/b/c/d/e/foo   *(rw,insecure,no_subtree_check,no_root_squash)
> > /export/a/b/c/d/e/bar   *(rw,insecure,no_subtree_check,no_root_squash)
> > 
> > systemctl start nfs-server
> > exportfs -avr
> > mount 127.0.0.1:/export/a/b/c/d/e/foo /mnt/a
> > 
> 
> Ahh ok. In your case, you're only exporting those single directories,
> which means that the server has to create pseudoroot entries for all of
> the intermediate directories in that path.
> 
> So, while "foo" corresponds to the directory on the server, the
> intermediate /export/a/b/c/d/e hierarchy are constructed, and the client
> is (probably) treating each of those as if they were new mountpoints.

That's kinda what I figured but I didn't really understand why.

It's probably not too bad for nfs but it's a pricy endeavour for the
whole system. Yes, it's rare but it means, if you have say 250 path
components you're keeping 250 NFS superblocks in fs_type->instances
until you finished mount_subtree(). Which means as pathwalk progresses
costs for each new superblock increase dramatically and since sb_lock is
global you're also stalling other superblocks creation on the system.

Anyway, that's for another time.
