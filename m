Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FD15F0641
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 10:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiI3ILh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 04:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiI3ILd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:11:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2CC1BB6C8;
        Fri, 30 Sep 2022 01:11:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19253B8275F;
        Fri, 30 Sep 2022 08:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CC2C433D6;
        Fri, 30 Sep 2022 08:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664525488;
        bh=RnAuN7ArCjMiR+Ns0K2qV+ZE4a1puMppCM/ESDvAdqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XNS9QTOb+k/X3bfWTicAbw6Yglb4mTvfnHuAnDCvTHwYGar6LmarlYTAgmUTtx3ai
         +UxmG66pUrQv6oWe2xhu7QgL9L7Y1t8fhjNCtXgYkXNeisJIRWGdDbhr8m4dcFaSfl
         TDQBM2qXIPM51TNWzLt/dEeaMTMKiVU7OutjZSWLWvDkkrLC8rOqbj3J82iDUW20mp
         KpwSVZ+QrpHIJURH8E7EXJiay59fKvxdPzaBRCvwjeIUm/tVb4dPRzi9YqvMZWH6oy
         X5AhQ0gBMMToDavvAPM6+FEIj8wIC/OUhntY8ovmnvZal604gmd9+loNXYWHcYf6G2
         7UHjO/qrVUo2g==
Date:   Fri, 30 Sep 2022 10:11:23 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 12/30] integrity: implement get and set acl hook
Message-ID: <20220930081123.dwoijem2fpy6ubpp@wittgenstein>
References: <20220929153041.500115-1-brauner@kernel.org>
 <20220929153041.500115-13-brauner@kernel.org>
 <CAHC9VhSxr-aUj7mqKo05B5Oj=5FWeajx_mNjR_EszzpYR1YozA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhSxr-aUj7mqKo05B5Oj=5FWeajx_mNjR_EszzpYR1YozA@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 03:14:42PM -0400, Paul Moore wrote:
> On Thu, Sep 29, 2022 at 11:33 AM Christian Brauner <brauner@kernel.org> wrote:
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
> > I spent considerate time in the security module and integrity
> > infrastructure and audited all codepaths. EVM is the only part that
> > really has restrictions based on the actual posix acl values passed
> > through it. Before this dedicated hook EVM used to translate from the
> > uapi posix acl format sent to it in the form of a void pointer into the
> > vfs format. This is not a good thing. Instead of hacking around in the
> > uapi struct give EVM the posix acls in the appropriate vfs format and
> > perform sane permissions checks that mirror what it used to to in the
> > generic xattr hook.
> >
> > IMA doesn't have any restrictions on posix acls. When posix acls are
> > changed it just wants to update its appraisal status.
> >
> > The removal of posix acls is equivalent to passing NULL to the posix set
> > acl hooks. This is the same as before through the generic xattr api.
> >
> > Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
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
> >     unchanged
> >
> >  include/linux/evm.h                   | 23 +++++++++
> >  include/linux/ima.h                   | 21 ++++++++
> >  security/integrity/evm/evm_main.c     | 70 ++++++++++++++++++++++++++-
> >  security/integrity/ima/ima_appraise.c |  9 ++++
> >  security/security.c                   | 21 +++++++-
> >  5 files changed, 141 insertions(+), 3 deletions(-)
> 
> ...
> 
> > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> > index 23d484e05e6f..7904786b610f 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -8,7 +8,7 @@
> >   *
> >   * File: evm_main.c
> >   *     implements evm_inode_setxattr, evm_inode_post_setxattr,
> > - *     evm_inode_removexattr, and evm_verifyxattr
> > + *     evm_inode_removexattr, evm_verifyxattr, and evm_inode_set_acl.
> >   */
> >
> >  #define pr_fmt(fmt) "EVM: "fmt
> > @@ -670,6 +670,74 @@ int evm_inode_removexattr(struct user_namespace *mnt_userns,
> >         return evm_protect_xattr(mnt_userns, dentry, xattr_name, NULL, 0);
> >  }
> >
> > +static int evm_inode_set_acl_change(struct user_namespace *mnt_userns,
> > +                                   struct dentry *dentry, const char *name,
> > +                                   struct posix_acl *kacl)
> > +{
> > +#ifdef CONFIG_FS_POSIX_ACL
> > +       int rc;
> > +
> > +       umode_t mode;
> > +       struct inode *inode = d_backing_inode(dentry);
> > +
> > +       if (!kacl)
> > +               return 1;
> > +
> > +       rc = posix_acl_update_mode(mnt_userns, inode, &mode, &kacl);
> > +       if (rc || (inode->i_mode != mode))
> > +               return 1;
> > +#endif
> > +       return 0;
> > +}
> 
> I'm not too bothered by it either way, but one might consider pulling
> the #ifdef outside the function definition, for example:
> 
> #ifdef CONFIG_FS_POSIX_ACL
> static int evm_inode_foo(...)
> {
>   /* ... stuff ... */
> }
> #else
> static int evm_inode_foo(...)
> {
>   return 0;
> }
> #endif /* CONFIG_FS_POSIX_ACL */
> 
> > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> > index bde74fcecee3..698a8ae2fe3e 100644
> > --- a/security/integrity/ima/ima_appraise.c
> > +++ b/security/integrity/ima/ima_appraise.c
> > @@ -770,6 +770,15 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
> >         return result;
> >  }
> >
> > +int ima_inode_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
> > +                     const char *acl_name, struct posix_acl *kacl)
> > +{
> > +       if (evm_revalidate_status(acl_name))
> > +               ima_reset_appraise_flags(d_backing_inode(dentry), 0);
> > +
> > +       return 0;
> > +}
> 
> While the ima_inode_set_acl() implementation above looks okay for the
> remove case, I do see that the ima_inode_setxattr() function has a
> call to validate_hash_algo() before calling
> ima_reset_appraise_flags().  IANAIE (I Am Not An Ima Expert), but it
> seems like we would still want that check in the ACL case.

Ah, you might've missed this bug...
The fact that they call validate_hash_algo() on posix acls is a bug in
ima. It's a type safety bug. IMA uses posix acls passed through the void
pointer as struct evm_ima_xattr:

 	const struct evm_ima_xattr_data *xvalue = xattr_value;

	result = validate_hash_algo(dentry, xvalue, xattr_value_len);

I reported this to them a little while ago and Mimi sent a fix for it
that's in -next:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=5926586f291b53cb8a0c9631fc19489be1186e2d

IOW, what I have here seems correct.
