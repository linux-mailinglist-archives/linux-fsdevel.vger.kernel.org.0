Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA1973322A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 15:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjFPN3A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 09:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjFPN27 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:28:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741D3ED;
        Fri, 16 Jun 2023 06:28:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 015806145D;
        Fri, 16 Jun 2023 13:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9F0C433C0;
        Fri, 16 Jun 2023 13:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686922137;
        bh=wCJi9aK3PULX7NqrqpoPPrFJKCYTmaLr5wcWDnKJJ5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nYpIspUF5nWeoQrPm4OWeYiJgbhyaH1v5qm4voF2fEz5HjkSZcreU7mpIHDAA/GCO
         haM0lqdbzCkfTgWdxx3H08sS+eQPHbkRdo79iR3xnndwA2Wl7/xCoM1J1PLcyMs/X7
         ZXnL1SlbRrmi1L8PxqokG5Nw1wKTBWpHgPvIvnD9g2wewune6WwJEJLvaTVC7Wb+mD
         UdgFQ+xbu0QFntZT4b+UFPU1nJ+QlBlbgLAbGY25psCSOYl+cJtYjTB0SOf8vorqFB
         /u4X0eUX2QPZzAi7Mj3/m3kPwscnoEpZExMZqkBRaLSHKSYdyCWmKARJsOZV/AsoB3
         S/12wJqmR8kKQ==
Date:   Fri, 16 Jun 2023 15:28:53 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3 2/3] ovl: port to new mount api
Message-ID: <20230616-neuplanung-zudem-0408ceb10767@brauner>
References: <20230605-fs-overlayfs-mount_api-v3-0-730d9646b27d@kernel.org>
 <20230605-fs-overlayfs-mount_api-v3-2-730d9646b27d@kernel.org>
 <CAOQ4uxi0cVquk5=VF8Q9JY8XWKOp19WxijHNkFGiO=LfpTw+Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi0cVquk5=VF8Q9JY8XWKOp19WxijHNkFGiO=LfpTw+Ng@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 16, 2023 at 04:21:29PM +0300, Amir Goldstein wrote:
> On Tue, Jun 13, 2023 at 5:49 PM Christian Brauner <brauner@kernel.org> wrote:
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
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/overlayfs/ovl_entry.h |   2 +-
> >  fs/overlayfs/super.c     | 557 ++++++++++++++++++++++++++---------------------
> >  2 files changed, 305 insertions(+), 254 deletions(-)
> >
> > diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> > index e5207c4bf5b8..c72433c06006 100644
> > --- a/fs/overlayfs/ovl_entry.h
> > +++ b/fs/overlayfs/ovl_entry.h
> > @@ -12,7 +12,7 @@ struct ovl_config {
> >         bool default_permissions;
> >         bool redirect_dir;
> >         bool redirect_follow;
> > -       const char *redirect_mode;
> > +       unsigned redirect_mode;
> 
> I have a separate patch to get rid of redirect_dir and redirect_follow
> leaving only redirect_mode enum.
> 
> I've already rebased your patches over this change in my branch.
> 
> https://github.com/amir73il/linux/commits/fs-overlayfs-mount_api
> 
> 
> >         bool index;
> >         bool uuid;
> >         bool nfs_export;
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index d9be5d318e1b..3392dc5d2082 100644
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
> > @@ -59,6 +61,79 @@ module_param_named(metacopy, ovl_metacopy_def, bool, 0644);
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
> 
> Renaming all those enums to lower case creates unneeded churn.
> I undid that in my branch, so now the mount api porting patch is a
> lot smaller.

Every single filesystem apart from fuse and overlayfs uses the standard
"Opt_" syntax. Only fuse and overlayfs use OPT_* all uppercase. Even the
documenation uses Opt_* throughout.

So I'd appreciate it if you please did not go out of your way to deviate
from this. I already did the work to convert to the Opt_* format on
purpose. If you want less churn however, then you can ofc move this to a
preparatory patch that converts to the standard format.
