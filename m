Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5EC5EDDB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 15:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiI1Nbs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 09:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiI1Nbr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:31:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B2CA2233;
        Wed, 28 Sep 2022 06:31:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 869E761EAB;
        Wed, 28 Sep 2022 13:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA1CC433D6;
        Wed, 28 Sep 2022 13:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664371903;
        bh=fv8K7xC6bKS8EccwTZv0pR5iY+09mG3RZycCPUFUFGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OekWThH4kvbq6ymsyKm2fXQ5hFgBLaGRER/NTKeUNH/5h2nIhKwRs5NpETvolN5DX
         BZcM1Wk/9uN5n0Jv5JPB95cKxV+0ePMCFQBJXXzn17zoBVToyt+KdBxO8tX2cR75aH
         8j4ctmn6lN3RSEWbEmK/ykQyTy+3eSE7doYFs7to+sDFjc1fUSsOcEiKGOBPhPQyq4
         cfGr1LPtu4gYhFMn3XAVcYpDPE5Tyc80fLMQl1u57KcNz2LsazOXy6IvRGtuMMBl/H
         cL1SfnkkAJIE0YAA7LuJplQ9d5mCirSS9XF9BXVkGCznN7zPo30ZPeGw29aPHoVQiH
         Y8XNM4vv+Ou3g==
Date:   Wed, 28 Sep 2022 15:31:39 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 18/30] evm: simplify evm_xattr_acl_change()
Message-ID: <20220928133139.ectxtqgitfjmioef@wittgenstein>
References: <20220926140827.142806-1-brauner@kernel.org>
 <20220926140827.142806-19-brauner@kernel.org>
 <CAHC9VhTx-Pkh0E3Awr=BR-Zh31gmoP3d1MKHf-UPVibfV3VxKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhTx-Pkh0E3Awr=BR-Zh31gmoP3d1MKHf-UPVibfV3VxKQ@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 06:56:44PM -0400, Paul Moore wrote:
> On Mon, Sep 26, 2022 at 11:24 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > The posix acl api provides a dedicated security and integrity hook for
> > setting posix acls. This means that
> >
> > evm_protect_xattr()
> > -> evm_xattr_change()
> >    -> evm_xattr_acl_change()
> >
> > is now only hit during vfs_remove_acl() at which point we are guaranteed
> > that xattr_value and xattr_value_len are NULL and 0. In this case evm
> > always used to return 1. Simplify this function to do just that.
> >
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > ---
> >
> > Notes:
> >     /* v2 */
> >     unchanged
> >
> >  security/integrity/evm/evm_main.c | 62 +++++++------------------------
> >  1 file changed, 14 insertions(+), 48 deletions(-)
> >
> > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> > index 15aa5995fff4..1fbe1b8d0364 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -436,62 +436,29 @@ static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
> >
> >  /*
> >   * evm_xattr_acl_change - check if passed ACL changes the inode mode
> > - * @mnt_userns: user namespace of the idmapped mount
> > - * @dentry: pointer to the affected dentry
> >   * @xattr_name: requested xattr
> >   * @xattr_value: requested xattr value
> >   * @xattr_value_len: requested xattr value length
> >   *
> > - * Check if passed ACL changes the inode mode, which is protected by EVM.
> > + * This is only hit during xattr removal at which point we always return 1.
> > + * Splat a warning in case someone managed to pass data to this function. That
> > + * should never happen.
> >   *
> >   * Returns 1 if passed ACL causes inode mode change, 0 otherwise.
> >   */
> > -static int evm_xattr_acl_change(struct user_namespace *mnt_userns,
> > -                               struct dentry *dentry, const char *xattr_name,
> > -                               const void *xattr_value, size_t xattr_value_len)
> > +static int evm_xattr_acl_change(const void *xattr_value, size_t xattr_value_len)
> >  {
> > -#ifdef CONFIG_FS_POSIX_ACL
> > -       umode_t mode;
> > -       struct posix_acl *acl = NULL, *acl_res;
> > -       struct inode *inode = d_backing_inode(dentry);
> > -       int rc;
> > -
> > -       /*
> > -        * An earlier comment here mentioned that the idmappings for
> > -        * ACL_{GROUP,USER} don't matter since EVM is only interested in the
> > -        * mode stored as part of POSIX ACLs. Nonetheless, if it must translate
> > -        * from the uapi POSIX ACL representation to the VFS internal POSIX ACL
> > -        * representation it should do so correctly. There's no guarantee that
> > -        * we won't change POSIX ACLs in a way that ACL_{GROUP,USER} matters
> > -        * for the mode at some point and it's difficult to keep track of all
> > -        * the LSM and integrity modules and what they do to POSIX ACLs.
> > -        *
> > -        * Frankly, EVM shouldn't try to interpret the uapi struct for POSIX
> > -        * ACLs it received. It requires knowledge that only the VFS is
> > -        * guaranteed to have.
> > -        */
> > -       acl = vfs_set_acl_prepare(mnt_userns, i_user_ns(inode),
> > -                                 xattr_value, xattr_value_len);
> > -       if (IS_ERR_OR_NULL(acl))
> > -               return 1;
> > -
> > -       acl_res = acl;
> > -       /*
> > -        * Passing mnt_userns is necessary to correctly determine the GID in
> > -        * an idmapped mount, as the GID is used to clear the setgid bit in
> > -        * the inode mode.
> > -        */
> > -       rc = posix_acl_update_mode(mnt_userns, inode, &mode, &acl_res);
> > -
> > -       posix_acl_release(acl);
> > -
> > -       if (rc)
> > -               return 1;
> > +       int rc = 0;
> >
> > -       if (inode->i_mode != mode)
> > -               return 1;
> > +#ifdef CONFIG_FS_POSIX_ACL
> > +       WARN_ONCE(xattr_value != NULL,
> > +                 "Passing xattr value for POSIX ACLs not supported\n");
> > +       WARN_ONCE(xattr_value_len != 0,
> > +                 "Passing non-zero length for POSIX ACLs not supported\n");
> > +       rc = 1;
> >  #endif
> > -       return 0;
> > +
> > +       return rc;
> >  }
> 
> This is another case where I'll leave the final say up to Mimi, but
> why not just get rid of evm_xattr_acl_change() entirely?  Unless I'm
> missing something, it's only reason for existing now is to check that
> it is passed the proper (empty) parameters which seems pointless ...
> no?

Yeah, I think we can remove it. evm_inode_remove_acl() is just
evm_inode_set_acl(NULL, 0) so if we add evm_inode_remove_acl() as a
wrapper around it instead of simply abusing the existing
evm_inode_removexattr() we can delete all that code indeed as it won't
be reachable from generic xattr code anymore.
