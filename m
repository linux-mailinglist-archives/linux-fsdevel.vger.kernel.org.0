Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA785F06B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 10:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiI3Ikb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 04:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiI3IkZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:40:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4941B75CDD;
        Fri, 30 Sep 2022 01:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B102BCE22B2;
        Fri, 30 Sep 2022 08:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029D0C433D6;
        Fri, 30 Sep 2022 08:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664527218;
        bh=+pzqCGHcS+oDTJ6vdGeBmuJ64GbjEMcLiONUBFjg9hI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Drs7aM51gm8fmH5+ncLlIfqqu3pNvckWhFftzjifsqpneHdfSx0fpstl3lDDfu5Rx
         fZANb13i5jor2cFSBd6z4Q8lEQUz8tuxB/+xy63wXI0JqkuICQ9a6YV61/HhyA9RAX
         uyHfpfRQVn0Mn8QhU81qDigSSboMoi+zrrPIb3/t3peFmLBWemAj/vaN6lqhpTCbzw
         JBvUK5tSe/yKd2g0ufiHmrZ+CKdZ4nCLtIbHqPRAQhq5mQh8cLKQnvldm76czMGo5t
         9Z4BdvYeLC0sfBqggRMS4Eh3CWg8sLSZ4bSAHdIwHC3enxmrOnB77JAL0pu2I7SBOg
         Nb2zWEqvKS98g==
Date:   Fri, 30 Sep 2022 10:40:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 11/30] smack: implement get, set and remove acl hook
Message-ID: <20220930084007.r57rig7qdjx3amcz@wittgenstein>
References: <20220929153041.500115-1-brauner@kernel.org>
 <20220929153041.500115-12-brauner@kernel.org>
 <CAHC9VhSRsm85VNW+y0-NTwdatH5-H-KAeeMUgSpx8iD8mOqiWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhSRsm85VNW+y0-NTwdatH5-H-KAeeMUgSpx8iD8mOqiWQ@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 03:15:09PM -0400, Paul Moore wrote:
> On Thu, Sep 29, 2022 at 11:31 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > The current way of setting and getting posix acls through the generic
> > xattr interface is error prone and type unsafe. The vfs needs to
> > interpret and fixup posix acls before storing or reporting it to
> > userspace. Various hacks exist to make this work. The code is hard to
> > understand and difficult to maintain in it's current form. Instead of
> > making this work by hacking posix acls through xattr handlers we are
> > building a dedicated posix acl api around the get and set inode
> > operations. This removes a lot of hackiness and makes the codepaths
> > easier to maintain. A lot of background can be found in [1].
> >
> > So far posix acls were passed as a void blob to the security and
> > integrity modules. Some of them like evm then proceed to interpret the
> > void pointer and convert it into the kernel internal struct posix acl
> > representation to perform their integrity checking magic. This is
> > obviously pretty problematic as that requires knowledge that only the
> > vfs is guaranteed to have and has lead to various bugs. Add a proper
> > security hook for setting posix acls and pass down the posix acls in
> > their appropriate vfs format instead of hacking it through a void
> > pointer stored in the uapi format.
> >
> > I spent considerate time in the security module infrastructure and
> > audited all codepaths. Smack has no restrictions based on the posix
> > acl values passed through it. The capability hook doesn't need to be
> > called either because it only has restrictions on security.* xattrs. So
> > these all becomes very simple hooks for smack.
> >
> > Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > ---
> >
> > Notes:
> >     /* v2 */
> >     unchanged
> >
> >     /* v3 */
> >     Paul Moore <paul@paul-moore.com>:
> >     - Add get, and remove acl hook
> >
> >     /* v4 */
> >     Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> >
> >  security/smack/smack_lsm.c | 69 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> 
> Two nit-picky comments below, only worth considering if you are
> respinning for other reasons.
> 
> Reviewed-by: Paul Moore <paul@paul-moore.com>
> 
> > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > index 001831458fa2..8247e8fd43d0 100644
> > --- a/security/smack/smack_lsm.c
> > +++ b/security/smack/smack_lsm.c
> > @@ -1393,6 +1393,72 @@ static int smack_inode_removexattr(struct user_namespace *mnt_userns,
> >         return 0;
> >  }
> >
> > +/**
> > + * smack_inode_set_acl - Smack check for setting posix acls
> > + * @mnt_userns: the userns attached to the mnt this request came from
> > + * @dentry: the object
> > + * @acl_name: name of the posix acl
> > + * @kacl: the posix acls
> > + *
> > + * Returns 0 if access is permitted, an error code otherwise
> > + */
> > +static int smack_inode_set_acl(struct user_namespace *mnt_userns,
> > +                              struct dentry *dentry, const char *acl_name,
> > +                              struct posix_acl *kacl)
> > +{
> > +       struct smk_audit_info ad;
> > +       int rc;
> > +
> > +       smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
> > +       smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
> > +       rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
> > +       rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
> > +       return rc;
> > +}
> 
> Smack tends to add a line of vertical whitespace between the
> smk_ad_setfield_...(...) call and the smk_curacc(...) call in the
> xattr functions, consistency here might be nice.
> 
> > +/**
> > + * smack_inode_remove_acl - Smack check for getting posix acls
> > + * @mnt_userns: the userns attached to the mnt this request came from
> > + * @dentry: the object
> > + * @acl_name: name of the posix acl
> > + *
> > + * Returns 0 if access is permitted, an error code otherwise
> > + */
> > +static int smack_inode_remove_acl(struct user_namespace *mnt_userns,
> > +                                 struct dentry *dentry, const char *acl_name)
> > +{
> > +       struct smk_audit_info ad;
> > +       int rc;
> > +
> > +       smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
> > +       smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
> > +       rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
> > +       rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
> > +       return rc;
> > +}
> 
> Same comment about the vertical whitespace applies here.

Ok.
