Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF4972935B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 10:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbjFIIhg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 04:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241066AbjFIIhZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:37:25 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475AE4201
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 01:36:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-977d0ee1736so233787466b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 01:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686299788; x=1688891788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/SsbKkfXbREIq0fP7DKc16CbxBCfG8YCyzpXQ3vBS0=;
        b=O/eE6zP7NIkcxMtmzkTgvQ7d5DAjMNp9tR/ZAO3vsRDGhDf5ozvw+y58GvmCX+IP/D
         P+gJWZ7GuvRYo6z1/JoiAREg+Ph21CP1841E/TFI7TX2I5Y1j3Tr8YoQL3xMtUS9de0g
         0SX4AMUqSgNeqqxd7x7RWRXr1ijoFLVkO+G7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686299788; x=1688891788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/SsbKkfXbREIq0fP7DKc16CbxBCfG8YCyzpXQ3vBS0=;
        b=STE+7JQQBM3fX01Av0n7QC2ANvUM0bM83vOjvsk+isLQQxT7TOqpGGgCsrxBaGNRyv
         NaUjpX17UWRV+hT+b1Y72DHo5dFDILnHUIGI3/lnGHhuE8lFmqYSxLwTSLQxxCkfKh9D
         fbBle6D31SXoqvSiazQa3lyy6lZ87fMBuvuc1sOSXcxzWOYSY1cYsJenI8bcfVPGkfS8
         yQVOUjOjF4zCxBsnnXDNfDWDrLLDamiwI8zqbIVwfecwtcx4Nx0/f5pm7hOiyW3DzhrC
         dxeBx96QkkuET/Btjs/RarQ02822qBxSqB/BhOqqd870zXXHuWi7HwDMiVnOMqEid9uO
         TZog==
X-Gm-Message-State: AC+VfDzDb4kgwf30okKxhodAoHcPBfWQ63CR4YLMNWUabNdFtufAe8Mg
        FBFews2FIfYYg4sYBYuT1bBrlpQJWwsfk7Yh7UagBA==
X-Google-Smtp-Source: ACHHUZ77th1NEp2P5IEmo0BzxWXAS1JWWulMkToaSJqWFu67jPNyRPQf1bRXXpdJSTkYmpy9V9RhRIk/r/P+YpXfEHM=
X-Received: by 2002:a17:907:c15:b0:94e:1764:b09b with SMTP id
 ga21-20020a1709070c1500b0094e1764b09bmr970228ejc.45.1686299788430; Fri, 09
 Jun 2023 01:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230605-fs-overlayfs-mount_api-v1-1-a8d78c3fbeaf@kernel.org>
 <CAOQ4uxhMwet9mO2RpsJn0CFGkqJZ-fTYvDFuV-rAD6xy9RZjkw@mail.gmail.com>
 <20230609-hufen-zensor-490247280b6c@brauner> <CAOQ4uxhzbAZLydw=eEH12XfR37LDV-E5SD9b_et5QsG+qyLu-Q@mail.gmail.com>
 <20230609-tasten-raumfahrt-7b8a499ef787@brauner>
In-Reply-To: <20230609-tasten-raumfahrt-7b8a499ef787@brauner>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 9 Jun 2023 10:36:17 +0200
Message-ID: <CAJfpegv4q4=kOM9KLiTmvbPkR15g1vkmWq3brkFuFqy50J7Xwg@mail.gmail.com>
Subject: Re: [PATCH] ovl: port to new mount api
To:     Christian Brauner <brauner@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 9 Jun 2023 at 10:03, Christian Brauner <brauner@kernel.org> wrote:
>
> On Fri, Jun 09, 2023 at 10:38:15AM +0300, Amir Goldstein wrote:
> > On Fri, Jun 9, 2023 at 10:28=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Thu, Jun 08, 2023 at 09:29:39PM +0300, Amir Goldstein wrote:
> > > > On Thu, Jun 8, 2023 at 7:07=E2=80=AFPM Christian Brauner <brauner@k=
ernel.org> wrote:
> > > > >
> > > > > We recently ported util-linux to the new mount api. Now the mount=
(8)
> > > > > tool will by default use the new mount api. While trying hard to =
fall
> > > > > back to the old mount api gracefully there are still cases where =
we run
> > > > > into issues that are difficult to handle nicely.
> > > > >
> > > > > Now with mount(8) and libmount supporting the new mount api I exp=
ect an
> > > > > increase in the number of bug reports and issues we're going to s=
ee with
> > > > > filesystems that don't yet support the new mount api. So it's tim=
e we
> > > > > rectify this.
> > > > >
> > > > > For overlayfs specifically we ran into issues where mount(8) pass=
ed
> > > > > multiple lower layers as one big string through fsconfig(). But t=
he
> > > > > fsconfig() FSCONFIG_SET_STRING option is limited to 256 bytes in
> > > > > strndup_user(). While this would be fixable by extending the fsco=
nfig()
> > > > > buffer I'd rather encourage users to append layers via multiple
> > > > > fsconfig() calls as the interface allows nicely for this. This ha=
s also
> > > > > been requested as a feature before.
> > > > >
> > > > > With this port to the new mount api the following will be possibl=
e:
> > > > >
> > > > >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", "/lower1=
", 0);
> > > > >
> > > > >         /* set upper layer */
> > > > >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "upperdir", "/upper"=
, 0);
> > > > >
> > > > >         /* append "/lower2", "/lower3", and "/lower4" */
> > > > >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", ":/lower=
2:/lower3:/lower4", 0);
> > > > >
> > > > >         /* turn index feature on */
> > > > >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "index", "on", 0);
> > > > >
> > > > >         /* append "/lower5" */
> > > > >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", ":/lower=
5", 0);
> > > > >
> > > > > Specifying ':' would have been rejected so this isn't a regressio=
n. And
> > > > > we can't simply use "lowerdir=3D/lower" to append on top of exist=
ing
> > > > > layers as "lowerdir=3D/lower,lowerdir=3D/other-lower" would make
> > > > > "/other-lower" the only lower layer so we'd break uapi if we chan=
ged
> > > > > this. So the ':' prefix seems a good compromise.
> > > > >
> > > > > Users can choose to specify multiple layers at once or individual
> > > > > layers. A layer is appended if it starts with ":". This requires =
that
> > > > > the user has already added at least one layer before. If lowerdir=
 is
> > > > > specified again without a leading ":" then all previous layers ar=
e
> > > > > dropped and replaced with the new layers. If lowerdir is specifie=
d and
> > > > > empty than all layers are simply dropped.
> > > > >
> > > > > An additional change is that overlayfs will now parse and resolve=
 layers
> > > > > right when they are specified in fsconfig() instead of deferring =
until
> > > > > super block creation. This allows users to receive early errors.
> > > > >
> > > > > It also allows users to actually use up to 500 layers something w=
hich
> > > > > was theoretically possible but ended up not working due to the mo=
unt
> > > > > option string passed via mount(2) being too large.
> > > > >
> > > > > This also allows a more privileged process to set config options =
for a
> > > > > lesser privileged process as the creds for fsconfig() and the cre=
ds for
> > > > > fsopen() can differ. We could restrict that they match by enforci=
ng that
> > > > > the creds of fsopen() and fsconfig() match but I don't see why th=
at
> > > > > needs to be the case and allows for a good delegation mechanism.
> > > > >
> > > > > Plus, in the future it means we're able to extend overlayfs mount
> > > > > options and allow users to specify layers via file descriptors in=
stead
> > > > > of paths:
> > > > >
> > > > >         fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower1",=
 dirfd);
> > > > >
> > > > >         /* append */
> > > > >         fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower2",=
 dirfd);
> > > > >
> > > > >         /* append */
> > > > >         fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower3",=
 dirfd);
> > > > >
> > > > >         /* clear all layers specified until now */
> > > > >         fsconfig(FSCONFIG_SET_STRING, "lowerdir", NULL, 0);
> > > > >
> > > > > This would be especially nice if users create an overlayfs mount =
on top
> > > > > of idmapped layers or just in general private mounts created via
> > > > > open_tree(OPEN_TREE_CLONE). Those mounts would then never have to=
 appear
> > > > > anywhere in the filesystem. But for now just do the minimal thing=
.
> > > > >
> > > > > We should probably aim to move more validation into ovl_fs_parse_=
param()
> > > > > so users get errors before fsconfig(FSCONFIG_CMD_CREATE). But tha=
t can
> > > > > be done in additional patches later.
> > > > >
> > > > > Link: https://github.com/util-linux/util-linux/issues/2287 [1]
> > > > > Link: https://github.com/util-linux/util-linux/issues/1992 [2]
> > > > > Link: https://bugs.archlinux.org/task/78702 [3]
> > > > > Link: https://lore.kernel.org/linux-unionfs/20230530-klagen-zudem=
-32c0908c2108@brauner [4]
> > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > ---
> > > > >
> > > > > ---
> > > > >
> > > > > I'm starting to get the feeling that I stared enough at this and =
I would
> > > > > need a fresh set of eyes to review it for any bugs. Plus, Amir se=
ems to
> > > > > have conflicting series and I would have to rebase anyway so no p=
oint in
> > > > > delaying this any further.
> > > > > ---
> > > > >  fs/overlayfs/super.c | 896 ++++++++++++++++++++++++++++++++-----=
--------------
> > > > >  1 file changed, 568 insertions(+), 328 deletions(-)
> > > > >
> > > >
> > > > Very big patch - Not so easy to review.
> > > > It feels like a large refactoring mixed with the api change.
> > > > Can it easily be split to just the refactoring patch
> > > > and the api change patch? or any other split that will be
> > > > easier to review.
> > >
> > > I don't really think so because you can't do a piecemeal conversion
> > > unfortunately. But if you have concrete ideas I'm happy to hear them.
> > >
> >
> > To me it looks like besides using new api you changed the order
> > of config parsing to:
> > - fill ovl_config and sanitize path arguments
> >   (replacing string with path in case of upper/workdir)
>
> Afaict this only makes sense if you cane have a sensible split between
> option parsing and superblock creation. While the new mount api does
> have that the old one doesn't. So ovl_fill_super() does option parsing,
> verification, and superblock creation.
>
> So the only thing we could do is something where we move
> ovl_mount_dir_noesc() out of ovl_lower_dir() and ovl_mount_dir() out of
> ovl_get_workdir() and ovl_get_upper(). And resolve all layers first.
>
> But it would still need to remain centralized in ovl_fill_super() and
> then it'd be an equal amount of churn when we implement proper option
> parsing for the new mount api in ovl_parse_param() as the implementation
> of the helpers used in there doesn't make sense before the switch.
>
> So I honestly thing this might end up being churn for churn. But I'll do
> it if you insist.
>
> But it'd be good to first get an indication whether this is even
> acceptable overall and whether I should do rebase and resend asap
> for v6.5.

Looks good to me overall.  The only added complexity I see is parsing
the lowerdir option, so it might make sense to split it like this:

1) convert to new API, don't touch lowerdir parsing (technically this
could be a bisect confusing regression, but I'm not really worried)

2) add the new split lowerdir handling

Also would it make sense to move parsing to a separate source file?

Does the split option handling make sense for other fs?  Is it
something that could be standardized?

Thanks,
Miklos
