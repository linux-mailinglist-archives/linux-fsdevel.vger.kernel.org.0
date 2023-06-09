Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CCB729641
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 12:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjFIKFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 06:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241609AbjFIKEw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:04:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A085876AC;
        Fri,  9 Jun 2023 02:55:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DD146562F;
        Fri,  9 Jun 2023 09:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D030C433EF;
        Fri,  9 Jun 2023 09:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686304552;
        bh=uqvOx4/42WF9u1Z4/HtFX8Pm1E0TonQfTXArXvkURkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdzIyam8/Hprw/kcrk1+G6ruKL7QoJEXhrCZElBH/E7fcFmxlSZtuGyhKv8D/GdqC
         r1rT27XhvJT5eHPL2u7ybGdpBoleCA+z9Nw7GN23rvEAZVvSme0KLjGcKMuFy6BzAR
         m4C5ia4AvOuFGECAuGPIni2pfBAE3rHNHpDLPstMDbc5FHXevH6JOnTjGx+ZkKLOwQ
         HJXvgiCRsyRAIZNX+fgREfuKqjV9fokG5sqWNMe5P7rs19rbmPItAD+ZPdPCC+zICu
         tmi783MSlRsCaDVA+u7wqYx/4WrnShKaPlQ16hzpeXoWWGDZ2T72G2iGZD7evNFG3t
         s1nO3ri4UAXuw==
Date:   Fri, 9 Jun 2023 11:55:48 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH] ovl: port to new mount api
Message-ID: <20230609-zubetoniert-bretter-52206737d6a8@brauner>
References: <20230605-fs-overlayfs-mount_api-v1-1-a8d78c3fbeaf@kernel.org>
 <CAOQ4uxhMwet9mO2RpsJn0CFGkqJZ-fTYvDFuV-rAD6xy9RZjkw@mail.gmail.com>
 <20230609-hufen-zensor-490247280b6c@brauner>
 <CAOQ4uxhzbAZLydw=eEH12XfR37LDV-E5SD9b_et5QsG+qyLu-Q@mail.gmail.com>
 <20230609-tasten-raumfahrt-7b8a499ef787@brauner>
 <CAJfpegv4q4=kOM9KLiTmvbPkR15g1vkmWq3brkFuFqy50J7Xwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpegv4q4=kOM9KLiTmvbPkR15g1vkmWq3brkFuFqy50J7Xwg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 10:36:17AM +0200, Miklos Szeredi wrote:
> On Fri, 9 Jun 2023 at 10:03, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Jun 09, 2023 at 10:38:15AM +0300, Amir Goldstein wrote:
> > > On Fri, Jun 9, 2023 at 10:28 AM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > On Thu, Jun 08, 2023 at 09:29:39PM +0300, Amir Goldstein wrote:
> > > > > On Thu, Jun 8, 2023 at 7:07 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > > >
> > > > > > We recently ported util-linux to the new mount api. Now the mount(8)
> > > > > > tool will by default use the new mount api. While trying hard to fall
> > > > > > back to the old mount api gracefully there are still cases where we run
> > > > > > into issues that are difficult to handle nicely.
> > > > > >
> > > > > > Now with mount(8) and libmount supporting the new mount api I expect an
> > > > > > increase in the number of bug reports and issues we're going to see with
> > > > > > filesystems that don't yet support the new mount api. So it's time we
> > > > > > rectify this.
> > > > > >
> > > > > > For overlayfs specifically we ran into issues where mount(8) passed
> > > > > > multiple lower layers as one big string through fsconfig(). But the
> > > > > > fsconfig() FSCONFIG_SET_STRING option is limited to 256 bytes in
> > > > > > strndup_user(). While this would be fixable by extending the fsconfig()
> > > > > > buffer I'd rather encourage users to append layers via multiple
> > > > > > fsconfig() calls as the interface allows nicely for this. This has also
> > > > > > been requested as a feature before.
> > > > > >
> > > > > > With this port to the new mount api the following will be possible:
> > > > > >
> > > > > >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", "/lower1", 0);
> > > > > >
> > > > > >         /* set upper layer */
> > > > > >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "upperdir", "/upper", 0);
> > > > > >
> > > > > >         /* append "/lower2", "/lower3", and "/lower4" */
> > > > > >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", ":/lower2:/lower3:/lower4", 0);
> > > > > >
> > > > > >         /* turn index feature on */
> > > > > >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "index", "on", 0);
> > > > > >
> > > > > >         /* append "/lower5" */
> > > > > >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", ":/lower5", 0);
> > > > > >
> > > > > > Specifying ':' would have been rejected so this isn't a regression. And
> > > > > > we can't simply use "lowerdir=/lower" to append on top of existing
> > > > > > layers as "lowerdir=/lower,lowerdir=/other-lower" would make
> > > > > > "/other-lower" the only lower layer so we'd break uapi if we changed
> > > > > > this. So the ':' prefix seems a good compromise.
> > > > > >
> > > > > > Users can choose to specify multiple layers at once or individual
> > > > > > layers. A layer is appended if it starts with ":". This requires that
> > > > > > the user has already added at least one layer before. If lowerdir is
> > > > > > specified again without a leading ":" then all previous layers are
> > > > > > dropped and replaced with the new layers. If lowerdir is specified and
> > > > > > empty than all layers are simply dropped.
> > > > > >
> > > > > > An additional change is that overlayfs will now parse and resolve layers
> > > > > > right when they are specified in fsconfig() instead of deferring until
> > > > > > super block creation. This allows users to receive early errors.
> > > > > >
> > > > > > It also allows users to actually use up to 500 layers something which
> > > > > > was theoretically possible but ended up not working due to the mount
> > > > > > option string passed via mount(2) being too large.
> > > > > >
> > > > > > This also allows a more privileged process to set config options for a
> > > > > > lesser privileged process as the creds for fsconfig() and the creds for
> > > > > > fsopen() can differ. We could restrict that they match by enforcing that
> > > > > > the creds of fsopen() and fsconfig() match but I don't see why that
> > > > > > needs to be the case and allows for a good delegation mechanism.
> > > > > >
> > > > > > Plus, in the future it means we're able to extend overlayfs mount
> > > > > > options and allow users to specify layers via file descriptors instead
> > > > > > of paths:
> > > > > >
> > > > > >         fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower1", dirfd);
> > > > > >
> > > > > >         /* append */
> > > > > >         fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower2", dirfd);
> > > > > >
> > > > > >         /* append */
> > > > > >         fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower3", dirfd);
> > > > > >
> > > > > >         /* clear all layers specified until now */
> > > > > >         fsconfig(FSCONFIG_SET_STRING, "lowerdir", NULL, 0);
> > > > > >
> > > > > > This would be especially nice if users create an overlayfs mount on top
> > > > > > of idmapped layers or just in general private mounts created via
> > > > > > open_tree(OPEN_TREE_CLONE). Those mounts would then never have to appear
> > > > > > anywhere in the filesystem. But for now just do the minimal thing.
> > > > > >
> > > > > > We should probably aim to move more validation into ovl_fs_parse_param()
> > > > > > so users get errors before fsconfig(FSCONFIG_CMD_CREATE). But that can
> > > > > > be done in additional patches later.
> > > > > >
> > > > > > Link: https://github.com/util-linux/util-linux/issues/2287 [1]
> > > > > > Link: https://github.com/util-linux/util-linux/issues/1992 [2]
> > > > > > Link: https://bugs.archlinux.org/task/78702 [3]
> > > > > > Link: https://lore.kernel.org/linux-unionfs/20230530-klagen-zudem-32c0908c2108@brauner [4]
> > > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > > ---
> > > > > >
> > > > > > ---
> > > > > >
> > > > > > I'm starting to get the feeling that I stared enough at this and I would
> > > > > > need a fresh set of eyes to review it for any bugs. Plus, Amir seems to
> > > > > > have conflicting series and I would have to rebase anyway so no point in
> > > > > > delaying this any further.
> > > > > > ---
> > > > > >  fs/overlayfs/super.c | 896 ++++++++++++++++++++++++++++++++-------------------
> > > > > >  1 file changed, 568 insertions(+), 328 deletions(-)
> > > > > >
> > > > >
> > > > > Very big patch - Not so easy to review.
> > > > > It feels like a large refactoring mixed with the api change.
> > > > > Can it easily be split to just the refactoring patch
> > > > > and the api change patch? or any other split that will be
> > > > > easier to review.
> > > >
> > > > I don't really think so because you can't do a piecemeal conversion
> > > > unfortunately. But if you have concrete ideas I'm happy to hear them.
> > > >
> > >
> > > To me it looks like besides using new api you changed the order
> > > of config parsing to:
> > > - fill ovl_config and sanitize path arguments
> > >   (replacing string with path in case of upper/workdir)
> >
> > Afaict this only makes sense if you cane have a sensible split between
> > option parsing and superblock creation. While the new mount api does
> > have that the old one doesn't. So ovl_fill_super() does option parsing,
> > verification, and superblock creation.
> >
> > So the only thing we could do is something where we move
> > ovl_mount_dir_noesc() out of ovl_lower_dir() and ovl_mount_dir() out of
> > ovl_get_workdir() and ovl_get_upper(). And resolve all layers first.
> >
> > But it would still need to remain centralized in ovl_fill_super() and
> > then it'd be an equal amount of churn when we implement proper option
> > parsing for the new mount api in ovl_parse_param() as the implementation
> > of the helpers used in there doesn't make sense before the switch.
> >
> > So I honestly thing this might end up being churn for churn. But I'll do
> > it if you insist.
> >
> > But it'd be good to first get an indication whether this is even
> > acceptable overall and whether I should do rebase and resend asap
> > for v6.5.
> 
> Looks good to me overall.  The only added complexity I see is parsing
> the lowerdir option, so it might make sense to split it like this:
> 
> 1) convert to new API, don't touch lowerdir parsing (technically this
> could be a bisect confusing regression, but I'm not really worried)
> 
> 2) add the new split lowerdir handling

Ok.

> 
> Also would it make sense to move parsing to a separate source file?

Let me try.

> 
> Does the split option handling make sense for other fs?  Is it
> something that could be standardized?

So far I only see overlayfs that would immediately benefit from this.
If we wanted to standardize this my preference would be:
* Additive options should be implemented simply by specifying the same
  options multiple times. For example:

  fsconfig(FSCONFIG_SET_FD, "option", NULL, fd1)
  // add
  fsconfig(FSCONFIG_SET_FD, "option", NULL, fd2)
  // add
  fsconfig(FSCONFIG_SET_FD, "option", NULL, fd3)

* To reset all specified options the mount options should be specified
  as:

  fsconfig(FSCONFIG_SET_STRING, "option", NULL, 0)

This would still need to be handled in the filesystem of course but I
would personally prefer this over stuff like:

  fsconfig(FSCONFIG_SET_FD, "option", NULL, fd3)
  // add
  fsconfig(FSCONFIG_SET_FD, "+option", NULL, fd3)

or other prefixed/suffixed methods. But I'm not sure it's something we
need to do right now given that I don't see that there are so many other
beneficiaries currently.
