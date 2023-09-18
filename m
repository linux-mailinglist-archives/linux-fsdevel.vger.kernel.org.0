Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02CD7A518F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 20:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjIRSFa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 14:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIRSFa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:05:30 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA77FD
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 11:05:23 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7a7857e5290so1690006241.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 11:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695060323; x=1695665123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pt7JWLa7KETj1gU+fN0iEyD6E+IUDMZR1fG28nEfhSo=;
        b=XNLoskqL9oRINfmyJ6E2Od8P4VFBF8yPm5M+LD1OUVcXT6FRNBFjmVHHkDJ9Zk8DdZ
         BBEI88sCtymsAfla5zprFOtjCx5fLJUJiA8KMnkx2OsE1pYHLqZqlfolPMpBdLQYXQDr
         fD8BsdVVcLESs4lSuD7Pcr/hBtxYsE+khanXjBIq4IAjRz3pkxSFPRnTZEWDLzp1qVPC
         Ax+mCV3tBDRTwf0Bxj8BD2V2naFoR5QRQ0u/bXQz5jSFGm4jz5YGI3oGBxLuE2O6IsyK
         pPQWVrPt/TI8qlb7jeUxOSUXSZ4NpFK7Tu1NoE6QVilEn8l3FSr8GimKXAwJLPnEMS9B
         XUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695060323; x=1695665123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pt7JWLa7KETj1gU+fN0iEyD6E+IUDMZR1fG28nEfhSo=;
        b=tSxsqnPFWJdl5oJ4MSWb5qQOzBWKH66lIA8KVQyjsKuEXaMEIF5fRhXRNbiufAKYVk
         HAKtBGuRs87opud09Aq061Y4f6zS40UctT+qHIjTS/ZLUtCScV83la0PiU8UAAHBeQZS
         6armmD5d+uiQXtVvkRP222ruEWzyWuxDGxIOVAzEf3CV6q5d/2G+v4oEgBDutmgZ+up1
         G561757AeFZ5ajf7CtlocP/axxODSKQOrU6m1UKhbFOsdLHJ5q3RwjfxeBo3zUMwyAuh
         ACJIgCGSVRSLjc/U/NHGLtheAaeocnOth0jFfhrbySYtPPLypQD9oecZ7GWhLrArR40w
         7Qrg==
X-Gm-Message-State: AOJu0YxxnXdDsjlcrYb2LHKYIMmO6x+isLc95Cx2KT/rOS01Z36naLWT
        E78d8+QdPTMPCdwg2QrwGyh04loxRZdt4D/BKE4=
X-Google-Smtp-Source: AGHT+IHunT/s0LGrX/CbNMxkc2/InivGd+M8T46ikQKRTDWJyNyBbfuGZdyLophF3H03O6j84/Tbl7tl192aRN0jJc8=
X-Received: by 2002:a05:6102:14a3:b0:452:5eb4:96fc with SMTP id
 d35-20020a05610214a300b004525eb496fcmr5339951vsv.9.1695060322660; Mon, 18 Sep
 2023 11:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com> <20230918124050.hzbgpci42illkcec@quack3>
 <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com>
 <20230918142319.kvzc3lcpn5n2ty6g@quack3> <CAOQ4uxic7C5skHv4d+Gek_uokRL8sgUegTusiGkwAY4dSSADYQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxic7C5skHv4d+Gek_uokRL8sgUegTusiGkwAY4dSSADYQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 18 Sep 2023 21:05:11 +0300
Message-ID: <CAOQ4uxjzf6NeoCaTrx_X0yZ0nMEWcQC_gq3M-j3jS+CuUTskSA@mail.gmail.com>
Subject: Re: inotify maintenance status
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Max Kellermann <max.kellermann@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Forked from https://lore.kernel.org/linux-fsdevel/20230918123217.932179-1-=
max.kellermann@ionos.com/]

On Mon, Sep 18, 2023 at 6:28=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Mon, Sep 18, 2023 at 5:23=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 18-09-23 15:57:43, Max Kellermann wrote:
> > > On Mon, Sep 18, 2023 at 2:40=E2=80=AFPM Jan Kara <jack@suse.cz> wrote=
:
> > > > Note that since kernel 5.13 you
> > > > don't need CAP_SYS_ADMIN capability for fanotify functionality that=
 is
> > > > more-or-less equivalent to what inotify provides.
> > >
> > > Oh, I missed that change - I remember fanotify as being inaccessible
> > > for unprivileged processes, and fanotify being designed for things
> > > like virus scanners. Indeed I should migrate my code to fanotify.
> > >
> > > If fanotify has now become the designated successor of inotify, that
> > > should be hinted in the inotify manpage, and if inotify is effectivel=
y
> > > feature-frozen, maybe that should be an extra status in the
> > > MAINTAINERS file?
> >
> > The manpage update is a good idea. I'm not sure about the MAINTAINERS
> > status - we do have 'Obsolete' but I'm reluctant to mark inotify as
> > obsolete as it's perfectly fine for existing users, we fully maintain i=
t
> > and support it but we just don't want to extend the API anymore. Amir, =
what
> > are your thoughts on this?
>
> I think that the mention of inotify vs. fanotify features in fanotify.7 m=
an page
> is decent - if anyone wants to improve it I won't mind.
> A mention of fanotify as successor in inotify.7 man page is not a bad ide=
a -
> patches welcome.
>
> As to MAINTAINERS, I think that 'Maintained' feels right.
> We may consider 'Odd Fixes' for inotify and certainly for 'dnotify',
> but that sounds a bit too harsh for the level of maintenance they get.
>
> I'd like to point out that IMO, man-page is mainly aimed for the UAPI
> users and MAINTAINERS is mostly aimed at bug reporters and drive-by
> developers who submit small fixes.
>
> When developers wish to add a feature/improvement to a subsystem,
> they are advised to send an RFC with their intentions to the subsystem
> maintainers/list to get feedback on their design before starting to imple=
ment.
> Otherwise, the feature could be NACKed for several reasons other than
> "we would rather invest in the newer API".
>
> Bottom line - I don't see a strong reason to change anything, but I also =
do
> not object to improving man page nor to switching to 'Odd Fixes' status.
>

BTW, before we can really mark inotify as Obsolete and document that
inotify was superseded by fanotify, there are at least two items on the
TODO list [1]:
1. UNMOUNT/IGNORED events
2. Filesystems without fid support

MOUNT/UNMOUNT fanotify events have already been discussed
and the feature has known users.

Christian has also mentioned [1] the IN_UNMOUNT use case for
waiting for sb shutdown several times and I will not be surprised
to see systemd starting to use inotify for that use case before too long...

Regarding the second item on the TODO list, we have had this discussion
before - if we are going to continue the current policy of opting-in to fan=
otify
(i.e. tmpfs, fuse, overlayfs, kernfs), we will always have odd filesystems =
that
only support inotify and we will need to keep supporting inotify only for t=
he
users that use inotify on those odd filesystems.

OTOH, if we implement FAN_REPORT_DINO_NAME, we could
have fanotify inode mark support for any filesystem, where the
pinned marked inode ino is the object id.

Thanks,
Amir.

[1] https://github.com/amir73il/fsnotify-utils/wiki/fsnotify-TODO
[2] https://lore.kernel.org/linux-fsdevel/20230908-verflachen-neudefinition=
-4da649d673a9@brauner/
