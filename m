Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2F15FAEA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 10:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiJKIqi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 04:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJKIqh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:46:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FA25808D;
        Tue, 11 Oct 2022 01:46:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2172B80C90;
        Tue, 11 Oct 2022 08:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D62BC433D6;
        Tue, 11 Oct 2022 08:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665477993;
        bh=VLER+GkIIMPoe2MsMWA4k9HDMBrMdXSLGdOU1cpnK18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QqRtHip53vY1lNzmvm4ryfzCCf6H8p0dMXrOo8EauW/7fZOytClrR1MJAn9oCDMdH
         vOz2PsWysC1Lqklv43w8PwLCKp6F15BFi3KTFeqOTZXMUjuoXtZAHqI09IQ/eIU37B
         Hav0mdCd2tlDGj3RwaXrI4z2Sd/EzwanR5a/FFk1qZm8IQuxNnaa/dH8Y8sNpHrRkX
         Zv9GrPFTmno7nNpTwvTyFk6vAG409l2YcoNMUUvVDaYlSHZ9HIbcuyBE5NoIxtX+WM
         rlS6eGiKI/qGWjFFFfnfBkZ1eI0q50g3uQ2P6wcJAH6sWoXUfdvK1DdiOIiGGqiN0q
         Z/pjNApQ6wgXQ==
Date:   Tue, 11 Oct 2022 10:46:25 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] attr: add should_remove_sgid()
Message-ID: <20221011084625.2gojupsucmm7kfd2@wittgenstein>
References: <20221007140543.1039983-1-brauner@kernel.org>
 <20221007140543.1039983-3-brauner@kernel.org>
 <CAOQ4uxic0+=QH1-=zzHgNnn1KTpMuLK-j3-AXJtFe5+t9yWs+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxic0+=QH1-=zzHgNnn1KTpMuLK-j3-AXJtFe5+t9yWs+w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 11, 2022 at 11:18:22AM +0300, Amir Goldstein wrote:
> On Fri, Oct 7, 2022 at 5:06 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > The current setgid stripping logic during write and ownership change
> > operations is inconsistent and strewn over multiple places. In order to
> > consolidate it and make more consistent we'll add a new helper
> > should_remove_sgid(). The function retains the old behavior where we
> > remove the S_ISGID bit unconditionally when S_IXGRP is set but also when
> > it isn't set and the caller is neither in the group of the inode nor
> > privileged over the inode.
> >
> > We will use this helper both in write operation permission removal such
> > as file_remove_privs() as well as in ownership change operations.
> >
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> 
> Looks good.
> Some suggestions below.
> 
> > ---
> >
> > Notes:
> >     /* v2 */
> >     Dave Chinner <dchinner@redhat.com>:
> >     - Use easier to follow logic in the new helper.
> >
> >  fs/attr.c     | 27 +++++++++++++++++++++++++++
> >  fs/internal.h |  2 ++
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/fs/attr.c b/fs/attr.c
> > index b1cff6f5b715..d0bb1dae425e 100644
> > --- a/fs/attr.c
> > +++ b/fs/attr.c
> > @@ -39,6 +39,33 @@ static bool setattr_drop_sgid(struct user_namespace *mnt_userns,
> >         return true;
> >  }
> >
> > +/**
> > + * should_remove_sgid - determine whether the setgid bit needs to be removed
> > + * @mnt_userns:        User namespace of the mount the inode was created from
> > + * @inode: inode to check
> > + *
> > + * This function determines whether the setgid bit needs to be removed.
> > + * We retain backwards compatibility and require setgid bit to be removed
> > + * unconditionally if S_IXGRP is set. Otherwise we have the exact same
> > + * requirements as setattr_prepare() and setattr_copy().
> > + *
> > + * Return: ATTR_KILL_SGID if setgid bit needs to be removed, 0 otherwise.
> > + */
> > +int should_remove_sgid(struct user_namespace *mnt_userns,
> > +                      const struct inode *inode)
> > +{
> > +       umode_t mode = inode->i_mode;
> > +
> > +       if (!(mode & S_ISGID))
> > +               return 0;
> > +       if (mode & S_IXGRP)
> > +               return ATTR_KILL_SGID;
> > +       if (setattr_drop_sgid(mnt_userns, inode,
> > +                             i_gid_into_vfsgid(mnt_userns, inode)))
> > +               return ATTR_KILL_SGID;
> > +       return 0;
> 
> If you take my suggestion from patch 1/5, that would become:
> 
>     return setattr_should_remove_sgid(mnt_userns, inode,
>                                  i_gid_into_vfsgid(mnt_userns, inode));
> 
> > +}
> > +
> >  /**
> >   * chown_ok - verify permissions to chown inode
> >   * @mnt_userns:        user namespace of the mount @inode was found from
> > diff --git a/fs/internal.h b/fs/internal.h
> > index 87e96b9024ce..9d165ab65a2a 100644
> > --- a/fs/internal.h
> > +++ b/fs/internal.h
> > @@ -221,3 +221,5 @@ ssize_t do_getxattr(struct user_namespace *mnt_userns,
> >  int setxattr_copy(const char __user *name, struct xattr_ctx *ctx);
> >  int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
> >                 struct xattr_ctx *ctx);
> > +int should_remove_sgid(struct user_namespace *mnt_userns,
> > +                      const struct inode *inode);
> 
> I realize that you placed this helper in attr.c to make
> setattr_drop_sgid() static, but IMO the code will be clearer to readers
> if all the family of suig/sgid stripping helpers were clustered together
> in inode.c where it will be easier to get the high level view.

I think then we should rather move all those helpers into attr.c. After
all it's is setting/returning iattr flags. Then they can be called from
inode.c
