Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B745F06AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 10:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiI3IiT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 04:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiI3IiO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:38:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CA617F576;
        Fri, 30 Sep 2022 01:38:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B9FFBCE2411;
        Fri, 30 Sep 2022 08:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42580C433D6;
        Fri, 30 Sep 2022 08:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664527090;
        bh=U41+SuELhrOZgFndReiM0JtxaQ2kfDZc2rf6Pb0RggY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qF3Hxq4XARE6U5McgrAK9EzX249VkntliTMLDi50996w6CUqYNSYQSof5JE3Dhjra
         RKZNciQCoMLFXjQKuCV7aab9ypcBiN855R96OiipdRVmotN83TJhcmcObjwczzmtAp
         DiuSclaUHTNkR2gM9Za3U7IeCKgAZaWmWrI3BI/WHf/le6lYW9RXTcGL+tDT/r5JPv
         AD3iE2pTVUe9718aG6No4W6BxP8mykGcpioOpBo/E8+xprupgjjOteJVqpIKuZcbmj
         K4qV4Ean0OfyWfVKdPXG3XTyMwny/9i7ckbG5mDBnOA3zN3JmeyctUmSjZ4Czlg40f
         rl6Ikb4OzwoCw==
Date:   Fri, 30 Sep 2022 10:38:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 10/30] selinux: implement get, set and remove acl hook
Message-ID: <20220930083804.eiar274qhclpo5uw@wittgenstein>
References: <20220929153041.500115-1-brauner@kernel.org>
 <20220929153041.500115-11-brauner@kernel.org>
 <CAHC9VhSHSk9MNK+FmydGTZDzDOuwF0b1A3SqYhG+X0NSCwoUEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhSHSk9MNK+FmydGTZDzDOuwF0b1A3SqYhG+X0NSCwoUEg@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 03:15:17PM -0400, Paul Moore wrote:
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
> > audited all codepaths. SELinux has no restrictions based on the posix
> > acl values passed through it. The capability hook doesn't need to be
> > called either because it only has restrictions on security.* xattrs. So
> > these are all fairly simply hooks for SELinux.
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
> >  security/selinux/hooks.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> 
> One small nitpick below, but looks good regardless.
> 
> Acked-by: Paul Moore <paul@paul-moore.com>
> 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 79573504783b..0e3cd67e5e92 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3239,6 +3239,27 @@ static int selinux_inode_setxattr(struct user_namespace *mnt_userns,
> >                             &ad);
> >  }
> >
> > +static int selinux_inode_set_acl(struct user_namespace *mnt_userns,
> > +                                struct dentry *dentry, const char *acl_name,
> > +                                struct posix_acl *kacl)
> > +{
> > +       return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
> > +}
> > +
> > +static int selinux_inode_get_acl(struct user_namespace *mnt_userns,
> > +                                struct dentry *dentry, const char *acl_name)
> > +{
> > +       const struct cred *cred = current_cred();
> > +
> > +       return dentry_has_perm(cred, dentry, FILE__GETATTR);
> > +}
> 
> Both the set and remove hooks use current_cred() directly in the call
> to dentry_has_perm(), you might as well do the same in the get hook.

Done.
