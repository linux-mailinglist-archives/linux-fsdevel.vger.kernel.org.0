Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493B5729156
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 09:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238852AbjFIHis (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 03:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238954AbjFIHia (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:38:30 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5111A2;
        Fri,  9 Jun 2023 00:38:28 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-78a065548e3so590975241.0;
        Fri, 09 Jun 2023 00:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686296307; x=1688888307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYobAbl+LgHpCkhdJoEmFkXafh5M0MfEb0GDWHyvArM=;
        b=M9+4IaExNaDJsFZJ63LalW5dErqp22zhJdo5ENywIRL+dw/D91PvuhGECiRXIm7tne
         8kede1t/q44cl9JVX2zFHLQDDo+jxjTr1vEYHBkyUo6oCTIUBLmR0cW8lTrTdhXOTpTa
         +Kl5UCZJdwqLlK9fhfnlWCOqZbojUH5oZRgbeM8mo3E1zIJMXtg8qR5oP+Qj8qFVMoN5
         lpDlhxqypFd1isWbDmn2m4FRdx/PZT7Q3NWclh9b6zHSaXwR2q686+ath7kWkkxLQ1ZN
         PtOT5hJByye3ejqgQFm5nXbLG1hkY+bZDc+CN27f4hmqFU3EL0d21M0MyPjE39+w5wQp
         bQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686296307; x=1688888307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYobAbl+LgHpCkhdJoEmFkXafh5M0MfEb0GDWHyvArM=;
        b=F/XdeUnla0CHsFhDtNhQOND7RKUVi7GfgUM04XtbhQNBGYNmVIgSpfUU6XBEoWVI48
         hP8w2xN0T13mgKCpIjYdHcVpR1jpalQYkbjBgsj4MleSWnQA3tLMr1NLwMWp6lXZAp9y
         H6NXmjWcLaEtNbmSbI9P7lZZ2/Ge1UXJc0ulemDKoI5ccYLjtPKLI6u91tcfJJIUtRHP
         yQZ5K8PZnn4zoTRBcVovpa+LUh7z7mroW+HztRT6jrUR2bR5jpTDFX7yu/v5jmhSRBOc
         goi03O4+WovBuaRWUyFYsvzv1SkRvBuunNnFt6O/4cuFPeo4cEM37lYanIL+U44sVWEw
         ooYg==
X-Gm-Message-State: AC+VfDzgAR1WQDx43nDciUor1XXVCA7lhz0op13IpcVJELXpQAHwZxI7
        QmMTktRFNXQbqJy1lAWf42nW7Gl3KLHheyN30zlv1wTg
X-Google-Smtp-Source: ACHHUZ4PPQfa77EoWE29Rh8m2Ar3PvpYkuUxSF3L91D4fafCo+sWUhRG2x5litl/c4iOvyaG7R84zaWS9pqZnbfBpa0=
X-Received: by 2002:a67:f646:0:b0:43b:554e:fce8 with SMTP id
 u6-20020a67f646000000b0043b554efce8mr499434vso.19.1686296307121; Fri, 09 Jun
 2023 00:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230605-fs-overlayfs-mount_api-v1-1-a8d78c3fbeaf@kernel.org>
 <CAOQ4uxhMwet9mO2RpsJn0CFGkqJZ-fTYvDFuV-rAD6xy9RZjkw@mail.gmail.com> <20230609-hufen-zensor-490247280b6c@brauner>
In-Reply-To: <20230609-hufen-zensor-490247280b6c@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 9 Jun 2023 10:38:15 +0300
Message-ID: <CAOQ4uxhzbAZLydw=eEH12XfR37LDV-E5SD9b_et5QsG+qyLu-Q@mail.gmail.com>
Subject: Re: [PATCH] ovl: port to new mount api
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 9, 2023 at 10:28=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Jun 08, 2023 at 09:29:39PM +0300, Amir Goldstein wrote:
> > On Thu, Jun 8, 2023 at 7:07=E2=80=AFPM Christian Brauner <brauner@kerne=
l.org> wrote:
> > >
> > > We recently ported util-linux to the new mount api. Now the mount(8)
> > > tool will by default use the new mount api. While trying hard to fall
> > > back to the old mount api gracefully there are still cases where we r=
un
> > > into issues that are difficult to handle nicely.
> > >
> > > Now with mount(8) and libmount supporting the new mount api I expect =
an
> > > increase in the number of bug reports and issues we're going to see w=
ith
> > > filesystems that don't yet support the new mount api. So it's time we
> > > rectify this.
> > >
> > > For overlayfs specifically we ran into issues where mount(8) passed
> > > multiple lower layers as one big string through fsconfig(). But the
> > > fsconfig() FSCONFIG_SET_STRING option is limited to 256 bytes in
> > > strndup_user(). While this would be fixable by extending the fsconfig=
()
> > > buffer I'd rather encourage users to append layers via multiple
> > > fsconfig() calls as the interface allows nicely for this. This has al=
so
> > > been requested as a feature before.
> > >
> > > With this port to the new mount api the following will be possible:
> > >
> > >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", "/lower1", 0=
);
> > >
> > >         /* set upper layer */
> > >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "upperdir", "/upper", 0)=
;
> > >
> > >         /* append "/lower2", "/lower3", and "/lower4" */
> > >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", ":/lower2:/l=
ower3:/lower4", 0);
> > >
> > >         /* turn index feature on */
> > >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "index", "on", 0);
> > >
> > >         /* append "/lower5" */
> > >         fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", ":/lower5", =
0);
> > >
> > > Specifying ':' would have been rejected so this isn't a regression. A=
nd
> > > we can't simply use "lowerdir=3D/lower" to append on top of existing
> > > layers as "lowerdir=3D/lower,lowerdir=3D/other-lower" would make
> > > "/other-lower" the only lower layer so we'd break uapi if we changed
> > > this. So the ':' prefix seems a good compromise.
> > >
> > > Users can choose to specify multiple layers at once or individual
> > > layers. A layer is appended if it starts with ":". This requires that
> > > the user has already added at least one layer before. If lowerdir is
> > > specified again without a leading ":" then all previous layers are
> > > dropped and replaced with the new layers. If lowerdir is specified an=
d
> > > empty than all layers are simply dropped.
> > >
> > > An additional change is that overlayfs will now parse and resolve lay=
ers
> > > right when they are specified in fsconfig() instead of deferring unti=
l
> > > super block creation. This allows users to receive early errors.
> > >
> > > It also allows users to actually use up to 500 layers something which
> > > was theoretically possible but ended up not working due to the mount
> > > option string passed via mount(2) being too large.
> > >
> > > This also allows a more privileged process to set config options for =
a
> > > lesser privileged process as the creds for fsconfig() and the creds f=
or
> > > fsopen() can differ. We could restrict that they match by enforcing t=
hat
> > > the creds of fsopen() and fsconfig() match but I don't see why that
> > > needs to be the case and allows for a good delegation mechanism.
> > >
> > > Plus, in the future it means we're able to extend overlayfs mount
> > > options and allow users to specify layers via file descriptors instea=
d
> > > of paths:
> > >
> > >         fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower1", dir=
fd);
> > >
> > >         /* append */
> > >         fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower2", dir=
fd);
> > >
> > >         /* append */
> > >         fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower3", dir=
fd);
> > >
> > >         /* clear all layers specified until now */
> > >         fsconfig(FSCONFIG_SET_STRING, "lowerdir", NULL, 0);
> > >
> > > This would be especially nice if users create an overlayfs mount on t=
op
> > > of idmapped layers or just in general private mounts created via
> > > open_tree(OPEN_TREE_CLONE). Those mounts would then never have to app=
ear
> > > anywhere in the filesystem. But for now just do the minimal thing.
> > >
> > > We should probably aim to move more validation into ovl_fs_parse_para=
m()
> > > so users get errors before fsconfig(FSCONFIG_CMD_CREATE). But that ca=
n
> > > be done in additional patches later.
> > >
> > > Link: https://github.com/util-linux/util-linux/issues/2287 [1]
> > > Link: https://github.com/util-linux/util-linux/issues/1992 [2]
> > > Link: https://bugs.archlinux.org/task/78702 [3]
> > > Link: https://lore.kernel.org/linux-unionfs/20230530-klagen-zudem-32c=
0908c2108@brauner [4]
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >
> > > ---
> > >
> > > I'm starting to get the feeling that I stared enough at this and I wo=
uld
> > > need a fresh set of eyes to review it for any bugs. Plus, Amir seems =
to
> > > have conflicting series and I would have to rebase anyway so no point=
 in
> > > delaying this any further.
> > > ---
> > >  fs/overlayfs/super.c | 896 ++++++++++++++++++++++++++++++++---------=
----------
> > >  1 file changed, 568 insertions(+), 328 deletions(-)
> > >
> >
> > Very big patch - Not so easy to review.
> > It feels like a large refactoring mixed with the api change.
> > Can it easily be split to just the refactoring patch
> > and the api change patch? or any other split that will be
> > easier to review.
>
> I don't really think so because you can't do a piecemeal conversion
> unfortunately. But if you have concrete ideas I'm happy to hear them.
>

To me it looks like besides using new api you changed the order
of config parsing to:
- fill ovl_config and sanitize path arguments
  (replacing string with path in case of upper/workdir)
- then validate ovl_config
- then fill super

The re-order ref-factor for the first two steps seems
independent of the api change and I think it will make
this patch set much easier to review if it was separated.

Unless I am missing something.

Thanks,
Amir.
