Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2987290FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 09:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbjFIH31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 03:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjFIH3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:29:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151F73594;
        Fri,  9 Jun 2023 00:28:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8753061566;
        Fri,  9 Jun 2023 07:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1DCC433D2;
        Fri,  9 Jun 2023 07:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686295729;
        bh=PuYsYVpcfL5KHsIQ2gpLajm0hOKBdtkDNuZjwYhlW88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fy6YwRC6H9BaF4ZpVR8ASmsbDqbHJGXUP5Y7j8THkzJJZ//g7eEYzbGeYkRBkMpm4
         prFHGe2nC/KyaL2okzJ1WubiNGCd4IF4WH+OHunwVWxA3tWRH8/yyW6VYdJcUHurVv
         Kh6h5ubpSKQdhssRP22V3ueW3WZfW0pIk+pe9dTt83V8qQh4SYcZi5Tj30lUZyvXIA
         gC9FrExJf9LJxCE9PwhA28YB8TN6l8qx0YV5+ULN/aekMnt9DKuzgAAPdeVNlkSzlM
         Vzwuz5e7ToPzmwTYij/mlcxgcWYhH4FpldW/hza5PGbVP7RW8jcQcY7UzaXw6srRSh
         P1XSy/+mSlLDA==
Date:   Fri, 9 Jun 2023 09:28:45 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH] ovl: port to new mount api
Message-ID: <20230609-hufen-zensor-490247280b6c@brauner>
References: <20230605-fs-overlayfs-mount_api-v1-1-a8d78c3fbeaf@kernel.org>
 <CAOQ4uxhMwet9mO2RpsJn0CFGkqJZ-fTYvDFuV-rAD6xy9RZjkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhMwet9mO2RpsJn0CFGkqJZ-fTYvDFuV-rAD6xy9RZjkw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 08, 2023 at 09:29:39PM +0300, Amir Goldstein wrote:
> On Thu, Jun 8, 2023 at 7:07 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > We recently ported util-linux to the new mount api. Now the mount(8)
> > tool will by default use the new mount api. While trying hard to fall
> > back to the old mount api gracefully there are still cases where we run
> > into issues that are difficult to handle nicely.
> >
> > Now with mount(8) and libmount supporting the new mount api I expect an
> > increase in the number of bug reports and issues we're going to see with
> > filesystems that don't yet support the new mount api. So it's time we
> > rectify this.
> >
> > For overlayfs specifically we ran into issues where mount(8) passed
> > multiple lower layers as one big string through fsconfig(). But the
> > fsconfig() FSCONFIG_SET_STRING option is limited to 256 bytes in
> > strndup_user(). While this would be fixable by extending the fsconfig()
> > buffer I'd rather encourage users to append layers via multiple
> > fsconfig() calls as the interface allows nicely for this. This has also
> > been requested as a feature before.
> >
> > With this port to the new mount api the following will be possible:
> >
> >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", "/lower1", 0);
> >
> >         /* set upper layer */
> >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "upperdir", "/upper", 0);
> >
> >         /* append "/lower2", "/lower3", and "/lower4" */
> >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", ":/lower2:/lower3:/lower4", 0);
> >
> >         /* turn index feature on */
> >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "index", "on", 0);
> >
> >         /* append "/lower5" */
> >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", ":/lower5", 0);
> >
> > Specifying ':' would have been rejected so this isn't a regression. And
> > we can't simply use "lowerdir=/lower" to append on top of existing
> > layers as "lowerdir=/lower,lowerdir=/other-lower" would make
> > "/other-lower" the only lower layer so we'd break uapi if we changed
> > this. So the ':' prefix seems a good compromise.
> >
> > Users can choose to specify multiple layers at once or individual
> > layers. A layer is appended if it starts with ":". This requires that
> > the user has already added at least one layer before. If lowerdir is
> > specified again without a leading ":" then all previous layers are
> > dropped and replaced with the new layers. If lowerdir is specified and
> > empty than all layers are simply dropped.
> >
> > An additional change is that overlayfs will now parse and resolve layers
> > right when they are specified in fsconfig() instead of deferring until
> > super block creation. This allows users to receive early errors.
> >
> > It also allows users to actually use up to 500 layers something which
> > was theoretically possible but ended up not working due to the mount
> > option string passed via mount(2) being too large.
> >
> > This also allows a more privileged process to set config options for a
> > lesser privileged process as the creds for fsconfig() and the creds for
> > fsopen() can differ. We could restrict that they match by enforcing that
> > the creds of fsopen() and fsconfig() match but I don't see why that
> > needs to be the case and allows for a good delegation mechanism.
> >
> > Plus, in the future it means we're able to extend overlayfs mount
> > options and allow users to specify layers via file descriptors instead
> > of paths:
> >
> >         fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower1", dirfd);
> >
> >         /* append */
> >         fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower2", dirfd);
> >
> >         /* append */
> >         fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower3", dirfd);
> >
> >         /* clear all layers specified until now */
> >         fsconfig(FSCONFIG_SET_STRING, "lowerdir", NULL, 0);
> >
> > This would be especially nice if users create an overlayfs mount on top
> > of idmapped layers or just in general private mounts created via
> > open_tree(OPEN_TREE_CLONE). Those mounts would then never have to appear
> > anywhere in the filesystem. But for now just do the minimal thing.
> >
> > We should probably aim to move more validation into ovl_fs_parse_param()
> > so users get errors before fsconfig(FSCONFIG_CMD_CREATE). But that can
> > be done in additional patches later.
> >
> > Link: https://github.com/util-linux/util-linux/issues/2287 [1]
> > Link: https://github.com/util-linux/util-linux/issues/1992 [2]
> > Link: https://bugs.archlinux.org/task/78702 [3]
> > Link: https://lore.kernel.org/linux-unionfs/20230530-klagen-zudem-32c0908c2108@brauner [4]
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >
> > ---
> >
> > I'm starting to get the feeling that I stared enough at this and I would
> > need a fresh set of eyes to review it for any bugs. Plus, Amir seems to
> > have conflicting series and I would have to rebase anyway so no point in
> > delaying this any further.
> > ---
> >  fs/overlayfs/super.c | 896 ++++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 568 insertions(+), 328 deletions(-)
> >
> 
> Very big patch - Not so easy to review.
> It feels like a large refactoring mixed with the api change.
> Can it easily be split to just the refactoring patch
> and the api change patch? or any other split that will be
> easier to review.

I don't really think so because you can't do a piecemeal conversion
unfortunately. But if you have concrete ideas I'm happy to hear them.

> 
> All looking quite sane, I only noticed one glitch below...
> 
> Thanks,
> Amir.
> 
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index f97ad8b40dbb..db22cbde1487 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -16,6 +16,8 @@
> >  #include <linux/posix_acl_xattr.h>
> >  #include <linux/exportfs.h>
> >  #include <linux/file.h>
> > +#include <linux/fs_context.h>
> > +#include <linux/fs_parser.h>
> >  #include "overlayfs.h"
> >
> >  MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
> > @@ -67,6 +69,76 @@ module_param_named(metacopy, ovl_metacopy_def, bool, 0644);
> >  MODULE_PARM_DESC(metacopy,
> >                  "Default to on or off for the metadata only copy up feature");
> >
> > +enum {
> > +       Opt_lowerdir,
> > +       Opt_upperdir,
> > +       Opt_workdir,
> > +       Opt_default_permissions,
> > +       Opt_redirect_dir,
> > +       Opt_index,
> > +       Opt_uuid,
> > +       Opt_nfs_export,
> > +       Opt_userxattr,
> > +       Opt_xino,
> > +       Opt_metacopy,
> > +       Opt_volatile,
> > +};
> > +
> > +static const struct constant_table ovl_parameter_bool[] = {
> > +       { "on",         true  },
> > +       { "off",        false },
> > +       {}
> > +};
> > +
> > +static const struct constant_table ovl_parameter_xino[] = {
> > +       { "on",         OVL_XINO_ON   },
> > +       { "off",        OVL_XINO_OFF  },
> > +       { "auto",       OVL_XINO_AUTO },
> > +       {}
> > +};
> > +
> > +#define fsparam_string_empty(NAME, OPT) \
> > +       __fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL)
> > +
> > +static const struct fs_parameter_spec ovl_parameter_spec[] = {
> > +       fsparam_string_empty("lowerdir",    Opt_lowerdir),
> > +       fsparam_string_empty("upperdir",    Opt_upperdir),
> > +       fsparam_string_empty("workdir",     Opt_workdir),
> > +       fsparam_flag("default_permissions", Opt_default_permissions),
> > +       fsparam_enum("redirect_dir",        Opt_redirect_dir, ovl_parameter_xino),
> 
> ovl_parameter_xino out of place.

That's rather odd. Thanks for spotting this...
