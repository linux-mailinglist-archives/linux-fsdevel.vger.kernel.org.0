Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316F35ED6A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 09:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbiI1Hp7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 03:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiI1Hpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:45:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D68151DCA;
        Wed, 28 Sep 2022 00:41:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7772B81F67;
        Wed, 28 Sep 2022 07:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D68BC433D6;
        Wed, 28 Sep 2022 07:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664350898;
        bh=yNC4J79hZIg9XibxXshy6JmGR/7yrod4uRcy/UzAas8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EyAzCD4dZKs7L7yDHFgt7or6vfdUSLh/9ejbM6ZyZWorbmEz/EUFSAvw2toXTCmfI
         CEHXftrjq72LKJ8YDbIsAccggx9wVjfqqKW0DjSZCoyQmyappSAvrI+nNw6WmoY5Pr
         cXpRs1blSpIys4fGnfwhQPHAwLUh9vLypmOHn2Oii0w3MzND9/u1xgxWIpL+QrzlV4
         SuZfV2CvG6WqKYVJ/CZ9RuVvteEUIHUmaZsBAk5VkfCAggykvs7ubgwjFG8uxWKrQu
         o8Pk7RsrgcdOoSPrIUz2mvJFMLfYJJOJgqVfTACdWVTaW0BQx+rsQ1ddNeLte2AkLz
         M9/V9IsXKjcHQ==
Date:   Wed, 28 Sep 2022 09:41:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 17/30] acl: add vfs_remove_acl()
Message-ID: <20220928074133.maredn3fcavfygxr@wittgenstein>
References: <20220926140827.142806-1-brauner@kernel.org>
 <20220926140827.142806-18-brauner@kernel.org>
 <CAHC9VhRZBP6fXtBseJJ_zHy+yoHMkVkSUbAFXmer7bKpt1Qvow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhRZBP6fXtBseJJ_zHy+yoHMkVkSUbAFXmer7bKpt1Qvow@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 06:55:37PM -0400, Paul Moore wrote:
> On Mon, Sep 26, 2022 at 11:24 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > In previous patches we implemented get and set inode operations for all
> > non-stacking filesystems that support posix acls but didn't yet
> > implement get and/or set acl inode operations. This specifically
> > affected cifs and 9p.
> >
> > Now we can build a posix acl api based solely on get and set inode
> > operations. We add a new vfs_remove_acl() api that can be used to set
> > posix acls. This finally removes all type unsafety and type conversion
> > issues explained in detail in [1] that we aim to get rid of.
> >
> > After we finished building the vfs api we can switch stacking
> > filesystems to rely on the new posix api and then finally switch the
> > xattr system calls themselves to rely on the posix acl api.
> >
> > Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > ---
> >
> > Notes:
> >     /* v2 */
> >     unchanged
> >
> >  fs/posix_acl.c            | 65 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/posix_acl.h |  8 +++++
> >  2 files changed, 73 insertions(+)
> 
> ...
> 
> > diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> > index 18873be583a9..40038851bfe1 100644
> > --- a/fs/posix_acl.c
> > +++ b/fs/posix_acl.c
> > @@ -1484,3 +1484,68 @@ struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
> >         return acl;
> >  }
> >  EXPORT_SYMBOL(vfs_get_acl);
> > +
> > +/**
> > + * vfs_remove_acl - remove posix acls
> > + * @mnt_userns: user namespace of the mount
> > + * @dentry: the dentry based on which to retrieve the posix acls
> > + * @acl_name: the name of the posix acl
> > + *
> > + * This function removes posix acls.
> > + *
> > + * Return: On success 0, on error negative errno.
> > + */
> > +int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
> > +                  const char *acl_name)
> > +{
> > +       int acl_type;
> > +       int error;
> > +       struct inode *inode = d_inode(dentry);
> > +       struct inode *delegated_inode = NULL;
> > +
> > +       acl_type = posix_acl_type(acl_name);
> > +       if (acl_type < 0)
> > +               return -EINVAL;
> > +
> > +retry_deleg:
> > +       inode_lock(inode);
> > +
> > +       /*
> > +        * We only care about restrictions the inode struct itself places upon
> > +        * us otherwise POSIX ACLs aren't subject to any VFS restrictions.
> > +        */
> > +       error = xattr_permission(mnt_userns, inode, acl_name, MAY_WRITE);
> > +       if (error)
> > +               goto out_inode_unlock;
> > +
> > +       error = security_inode_removexattr(mnt_userns, dentry, acl_name);
> > +       if (error)
> > +               goto out_inode_unlock;
> 
> Similar to my comments in patch 16/30 for vfs_get_acl(), I would
> suggest a dedicated ACL remove hook here.  Yes, it's still a little
> bit silly, but if we are going to make one dedicated hook, we might as
> well do them all.

Sure, I don't mind doing that. I'll add the infrastructure and then the
individual LSMs can add their own hooks.
