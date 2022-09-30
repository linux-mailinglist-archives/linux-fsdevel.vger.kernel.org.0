Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4489A5F06A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 10:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiI3IgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 04:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiI3IgI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:36:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBD1132FEB;
        Fri, 30 Sep 2022 01:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A884ACE22B2;
        Fri, 30 Sep 2022 08:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1474EC433D6;
        Fri, 30 Sep 2022 08:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664526960;
        bh=ZFvhFZYY7IY2TkbWXnjSLCO8efIt0D1AkUMxPCqYAt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HAwBr6+k0o2B9xkpcDlFp26ASAQ/+y42edNdD6vOoWeiaAlT8DLftvRrQqu5O+gUk
         sRiwutUAXQPYXVGfrpTLXwBsFcrr+16KEtQ0ldjcI+F90tzFKXrNrzms3BGZehpdxP
         5jdmR+RJKSJu3hrHE9ESCZ/5C6Ue3LFy08A6RRJmduyqvQkTK95/6myVP0+5iWFaza
         gTz3n0sta46GERkjlviV4VL6YjP0qmLVFwuteioFT6d0RdiRfJVOUsRLBhr6Oo1tjr
         hEs6ZH2wo2h1ASUPV7D/R8/YDDmil/SmzVVF6addu8IKhhbOfznBvs8wLB7jpj/U7e
         7X0gcYciwwhSg==
Date:   Fri, 30 Sep 2022 10:35:55 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 12/29] integrity: implement get and set acl hook
Message-ID: <20220930083555.6gqizh7ccvyqhujs@wittgenstein>
References: <20220928160843.382601-1-brauner@kernel.org>
 <20220928160843.382601-13-brauner@kernel.org>
 <41a0deedf4f035b8470f5fe237d192c9b30b9ba6.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41a0deedf4f035b8470f5fe237d192c9b30b9ba6.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 07:25:46PM -0400, Mimi Zohar wrote:
> Hi Christian,
> 
> On Wed, 2022-09-28 at 18:08 +0200, Christian Brauner wrote:
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
> > through it
> 
> (e.g. i_mode).
> 
> > Before this dedicated hook EVM used to translate from the
> > uapi posix acl format sent to it in the form of a void pointer into the
> > vfs format. This is not a good thing. Instead of hacking around in the
> > uapi struct give EVM the posix acls in the appropriate vfs format and
> > perform sane permissions checks that mirror what it used to to in the
> > generic xattr hook.
> > 
> > IMA doesn't have any restrictions on posix acls. When posix acls are
> > changed it just wants to update its appraisal status.
> 
> to trigger an EVM re-validation.
> 
> > The removal of posix acls is equivalent to passing NULL to the posix set
> > acl hooks. This is the same as before through the generic xattr api.
> > 
> > Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> 
> 
> > ---
> 
> > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> > index 23d484e05e6f..7904786b610f 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -8,7 +8,7 @@
> >   *
> >   * File: evm_main.c
> >   *	implements evm_inode_setxattr, evm_inode_post_setxattr,
> > - *	evm_inode_removexattr, and evm_verifyxattr
> > + *	evm_inode_removexattr, evm_verifyxattr, and evm_inode_set_acl.
> >   */
> >  
> >  #define pr_fmt(fmt) "EVM: "fmt
> > @@ -670,6 +670,74 @@ int evm_inode_removexattr(struct user_namespace *mnt_userns,
> >  	return evm_protect_xattr(mnt_userns, dentry, xattr_name, NULL, 0);
> >  }
> >  
> > +static int evm_inode_set_acl_change(struct user_namespace *mnt_userns,
> > +				    struct dentry *dentry, const char *name,
> > +				    struct posix_acl *kacl)
> > +{
> > +#ifdef CONFIG_FS_POSIX_ACL
> > +	int rc;
> > +
> > +	umode_t mode;
> > +	struct inode *inode = d_backing_inode(dentry);
> > +
> > +	if (!kacl)
> > +		return 1;
> > +
> > +	rc = posix_acl_update_mode(mnt_userns, inode, &mode, &kacl);
> > +	if (rc || (inode->i_mode != mode))
> 
> acl_res in the existing evm_xattr_acl_change() code is based on the
> init_user_ns.  Is that the same here?   Is it guaranteed?

Using init_user_ns in the old evm_xattr_acl_change() helper is not about
correctness it's simply about getting the uapi format into a vfs struct
posix_acl to look at the mode.

For the new hook that question becomes moot as in the new clean api
evm/ima receives a struct posix_acl from the vfs. The actual code that
interprets the mode uses the mnt_userns in both.

The old evm_xattr_acl_change() helper goes away in a later patch because
it can't be reached anymore after we added dedicated acl hooks.

> 
> > +		return 1;
> > +#endif
> > +	return 0;
> > +}
> > +
> > +/**
> > + * evm_inode_set_acl - protect the EVM extended attribute for posix acls
> 
> ^from posix acls

Fixed.

> 
> 
> > + * @mnt_userns: user namespace of the idmapped mount
> > + * @dentry: pointer to the affected dentry
> > + * @acl_name: name of the posix acl
> > + * @kacl: pointer to the posix acls
> 
> Prevent modifying posix acls causing the EVM HMAC to be re-calculated
> and 'security.evm' xattr updated, unless the existing 'security.evm' is
> valid.

Added, thanks.
