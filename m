Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2225F76D6A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 20:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjHBSQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 14:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjHBSQG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:16:06 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE611717
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 11:16:02 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76754b9eac0so5995785a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 11:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691000161; x=1691604961;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jttay3Y7tZ44PZ3pDqY6yaCEufBzLxT6C+Rmg0Bmtnw=;
        b=d0PA4A+jJfozBkqa8UDo7N4WMrxQqmldV/JhxJQwAwTQxncKxV7wRNigctbcr86AYI
         clESekvuuB+Wrv1ZtpfR4IysIKu6fag+QBQshGld66Kt0Q5XuzBVE3sezvwdHHM5GBRA
         /QbFR57HWoXChW9HY4Unpbabt/NXEcF8Mp8W4kKnIVcnINk3NpDlTQ2PvG6h59YoeeXG
         0UBUUmhk4nFes79N033bvPCT31OiqdAXrld91YhXQF+3Z9q1JUL6gOI1m0L868Lko8rS
         dBxtDaX/QpbTdFRjMbLdH9vVb6j6uBlTpEPyJ6bFjo/PFc4fUwtLddOSw2bqQJ2b0DU5
         m/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691000161; x=1691604961;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jttay3Y7tZ44PZ3pDqY6yaCEufBzLxT6C+Rmg0Bmtnw=;
        b=VvpMe+t/0l/bRmKp8E1lnidtfSCbAg+TrCvPKVI/aDjDvcIStfsNVfsrE9rRbHpOoO
         xey/P02J3oTOuIZ4NOoZQ/J2C6Jj18ZanCBOS3inyWouiNAdtPyqxL33jaj8mjF3eB2Y
         ChcJY9ToM6fphJ84EsefHwL5uzLI4FrmdSJohW4BHV7yR5YjUqJNnBkOUfrtzLT0qC+X
         i+TXgkDd8BT2qCMLPfpGwjxXkA0Exrug/9WasBvJ3vImhnCcuvfqo8Mww4E26h7dkutM
         YVz7cFm+q/n0bUylVTRiNfo76KCmbxEtOGO9nbexWokx31ZG8mmRTAzC7zoiYHLdj/jY
         ayvg==
X-Gm-Message-State: ABy/qLbkhcCZeSPAD63pqdgnBIH82oz6UCcqdFoUG1VuP7HS/jM2RU9u
        fYqAXPbx7dWmQ/aTOGzFr/Cv
X-Google-Smtp-Source: APBJJlGGqbRJcuJCCqcoiQEPQ2nJxHgmcoYfak2Lu/M5Lqa7mfvnk8ungVqsLJDbg3pq5fFNVCUEEg==
X-Received: by 2002:a05:620a:2204:b0:76c:d007:b544 with SMTP id m4-20020a05620a220400b0076cd007b544mr2485423qkh.26.1691000161351;
        Wed, 02 Aug 2023 11:16:01 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id u19-20020a05620a121300b007659935ce64sm5224030qkj.71.2023.08.02.11.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 11:16:00 -0700 (PDT)
Date:   Wed, 02 Aug 2023 14:16:00 -0400
Message-ID: <bac543537058619345b363bbfc745927.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6] vfs, security: Fix automount superblock LSM init  problem, preventing NFS sb sharing
References: <20230802-master-v6-1-45d48299168b@kernel.org>
In-Reply-To: <20230802-master-v6-1-45d48299168b@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Aug  2, 2023 Jeff Layton <jlayton@kernel.org> wrote:
> 
> When NFS superblocks are created by automounting, their LSM parameters
> aren't set in the fs_context struct prior to sget_fc() being called,
> leading to failure to match existing superblocks.
> 
> Fix this by adding a new LSM hook to load fc->security for submount
> creation when alloc_fs_context() is creating the fs_context for it.
> 
> However, this uncovers a further bug: nfs_get_root() initialises the
> superblock security manually by calling security_sb_set_mnt_opts() or
> security_sb_clone_mnt_opts() - but then vfs_get_tree() calls
> security_sb_set_mnt_opts(), which can lead to SELinux, at least,
> complaining.
> 
> Fix that by adding a flag to the fs_context that suppresses the
> security_sb_set_mnt_opts() call in vfs_get_tree().  This can be set by NFS
> when it sets the LSM context on the new superblock.
>
> The first bug leads to messages like the following appearing in dmesg:
> 
> 	NFS: Cache volume key already in use (nfs,4.2,2,108,106a8c0,1,,,,100000,100000,2ee,3a98,1d4c,3a98,1)
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Fixes: 9bc61ab18b1d ("vfs: Introduce fs_context, switch vfs_kern_mount() to it.")
> Fixes: 779df6a5480f ("NFS: Ensure security label is set for root inode)
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: "Christian Brauner (Microsoft)" <brauner@kernel.org>
> Link: https://lore.kernel.org/r/165962680944.3334508.6610023900349142034.stgit@warthog.procyon.org.uk/ # v1
> Link: https://lore.kernel.org/r/165962729225.3357250.14350728846471527137.stgit@warthog.procyon.org.uk/ # v2
> Link: https://lore.kernel.org/r/165970659095.2812394.6868894171102318796.stgit@warthog.procyon.org.uk/ # v3
> Link: https://lore.kernel.org/r/166133579016.3678898.6283195019480567275.stgit@warthog.procyon.org.uk/ # v4
> Link: https://lore.kernel.org/r/217595.1662033775@warthog.procyon.org.uk/ # v5
> ---
> This patch was originally sent by David several months ago, but it
> never got merged. I'm resending to resurrect the discussion. Can we
> get this fixed?

Sorry, I sorta lost track of this after the ROOTCONTEXT_MNT discussion
back in v3.  Looking at it a bit closer now I have one nitpicky
request and one larger concern (see below).

> diff --git a/fs/super.c b/fs/super.c
> index e781226e2880..13adf43e2e5d 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1541,10 +1541,12 @@ int vfs_get_tree(struct fs_context *fc)
>  	smp_wmb();
>  	sb->s_flags |= SB_BORN;
>  
> -	error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
> -	if (unlikely(error)) {
> -		fc_drop_locked(fc);
> -		return error;
> +	if (!(fc->lsm_set)) {
> +		error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
> +		if (unlikely(error)) {
> +			fc_drop_locked(fc);
> +			return error;
> +		}
>  	}

I generally dislike core kernel code which makes LSM calls conditional
on some kernel state maintained outside the LSM.  Sometimes it has to
be done as there is no other good options, but I would like us to try
and avoid it if possible.  The commit description mentioned that this
was put here to avoid a SELinux complaint, can you provide an example
of the complain?  Does it complain about a double/invalid mount, e.g.
"SELinux: mount invalid.  Same superblock, different security ..."?

I'd like to understand why the sb_set_mnt_opts() call fails when it
comes after the fs_context_init() call.  I'm particulary curious to
know if the failure is due to conflicting SELinux state in the
fs_context, or if it is simply an issue of sb_set_mnt_opts() not
properly handling existing values.  Perhaps I'm being overly naive,
but I'm hopeful that we can address both of these within the SELinux
code itself.

In a worst case situation, we could always implement a flag *inside*
the SELinux code, similar to what has been done with 'lsm_set' here.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d06e350fedee..29cce0fadbeb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2745,6 +2745,30 @@ static int selinux_umount(struct vfsmount *mnt, int flags)
>  				   FILESYSTEM__UNMOUNT, NULL);
>  }
>  
> +static int selinux_fs_context_init(struct fs_context *fc,
> +				   struct dentry *reference)
> +{
> +	const struct superblock_security_struct *sbsec;
> +	struct selinux_mnt_opts *opts;
> +
> +	if (fc->purpose == FS_CONTEXT_FOR_SUBMOUNT) {
> +		opts = kzalloc(sizeof(*opts), GFP_KERNEL);
> +		if (!opts)
> +			return -ENOMEM;
> +
> +		sbsec = selinux_superblock(reference->d_sb);
> +		if (sbsec->flags & FSCONTEXT_MNT)
> +			opts->fscontext_sid	= sbsec->sid;
> +		if (sbsec->flags & CONTEXT_MNT)
> +			opts->context_sid	= sbsec->mntpoint_sid;
> +		if (sbsec->flags & DEFCONTEXT_MNT)
> +			opts->defcontext_sid	= sbsec->def_sid;

I acknowledge this is very nitpicky, but we're starting to make a
greater effort towards using consistent style within the SELinux
code.  With that in mind, please remove the alignment whitespace in
the assignments above.  Thank you.

> +		fc->security = opts;
> +	}
> +
> +	return 0;
> +}
> +
>  static int selinux_fs_context_dup(struct fs_context *fc,
>  				  struct fs_context *src_fc)
>  {

--
paul-moore.com
