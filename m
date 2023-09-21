Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22E77AA252
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 23:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjIUVPt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 17:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjIUVPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:15:07 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56045B82
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:08:43 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7a893053770so776892241.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316122; x=1695920922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sq0CizTw6rtlb/8BPXQU7UyJyNQ1kmgf8TNxepLeNhA=;
        b=MR9xt4a1RRprQxKe2DLRKcw1BIO43VVecXWSOs5US1WyRo1yY6hnpYxDoVwwIAfI+p
         saIFcmD/CSjRI1wKoTqYQ6vA1BS7uKOkym4PxIl2eid5/iuIjfbWd7QlmFVzfza0xvsq
         Fws7mKmlsgrlt5BW/aVkny4Yul8OMMozYwkVIBAWlA2oD69WgnAsnF+Ntvh5wgMh5VNT
         H8lGO/cIMway2HmMotBYWYvBgqDJOp8wklxwGQrR5GjshZVnTqobbEmsstdsmmodWAe+
         d+pdWk6nc7zn21jbszwqkfKJI0+yPFcxld7tfcddGJCN3273UGhZdStEVxgq5it4ndSz
         ju/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316122; x=1695920922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sq0CizTw6rtlb/8BPXQU7UyJyNQ1kmgf8TNxepLeNhA=;
        b=IXSb1+TOU6MGLU5kNMh86p5PDVAlxBYe12JCIiu4pYZtVGsl1bNH8h3y8z3MZXj8Gb
         cEe4dmh+LiwxuYZ8GL6dN2AW1rDy17XMYYioObLZojORqQJANjTQkaKIeAa6ijYOmEXT
         GHyvs1h2DSNbZS1FrqxvM96MHl/OtnmMPXmaAw6htQ8iNfCq0Wlk+NqW8bI+gv7U0z/l
         Xel6MLVyq5S1TnSrnW/vCk0/KJHZ4/gA/ejwzPycG8FRzM/I20Uakv8OONjmqtG3+QqA
         wIS9mfMpNpHYIC8Vc7Aq+kN4h/uO7eiv033PhiiplY/WzPEM+dSx4iz7Jgn1DKPSjHkF
         z1jw==
X-Gm-Message-State: AOJu0YwvHBJOwfH+cgAklKfBeHevpHmGoe+3H1wQLPPp0C0xnKQgEuZM
        m9qYaQ6c8hFYwpRnevAEL6F08WVCcRkzsAN/83Iw9y3A
X-Google-Smtp-Source: AGHT+IGQymInHEK/8/UZVIFgCyglb79akQNCHslCRU3RF3ANENr3iHfAlqBLBNTCHm9lR46mBBTxDzbWo+sxb1P3YOc=
X-Received: by 2002:a67:dc06:0:b0:452:6d82:56e3 with SMTP id
 x6-20020a67dc06000000b004526d8256e3mr4154477vsj.6.1695284973403; Thu, 21 Sep
 2023 01:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230920173445.3943581-1-bschubert@ddn.com> <20230920173445.3943581-5-bschubert@ddn.com>
 <CAOQ4uxjsfjEBo3obU9EPZuwkHXu_aPo+BJgVCOdN7V6bSRGXvA@mail.gmail.com> <9a135af5-2acf-42ed-b30e-f79ac7c86e25@fastmail.fm>
In-Reply-To: <9a135af5-2acf-42ed-b30e-f79ac7c86e25@fastmail.fm>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 21 Sep 2023 11:29:22 +0300
Message-ID: <CAOQ4uxjouwKB4p=V-fWa_vx4_FpyHpS1xm5vwr_sdFRiQTwWTg@mail.gmail.com>
Subject: Re: [PATCH v9 4/7] vfs: Optimize atomic_open() on positive dentry
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        miklos@szeredi.hu, dsingh@ddn.com,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 11:09=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 9/21/23 08:16, Amir Goldstein wrote:
> > On Thu, Sep 21, 2023 at 12:48=E2=80=AFAM Bernd Schubert <bschubert@ddn.=
com> wrote:
> >>
> >> This was suggested by Miklos based on review from the previous
> >> patch that introduced atomic open for positive dentries.
> >> In open_last_lookups() the dentry was not used anymore when atomic
> >> revalidate was available, which required to release the dentry,
> >> then code fall through to lookup_open was done, which resulted
> >> in another d_lookup and also d_revalidate. All of that can
> >> be avoided by the new atomic_revalidate_open() function.
> >>
> >> Another included change is the introduction of an enum as
> >> d_revalidate return code.
> >>
> >> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> >> Cc: Miklos Szeredi <miklos@szeredi.hu>
> >> Cc: Dharmendra Singh <dsingh@ddn.com>
> >> Cc: Christian Brauner <brauner@kernel.org>
> >> Cc: Al Viro <viro@zeniv.linux.org.uk>
> >> Cc: linux-fsdevel@vger.kernel.org
> >> ---
> >>   fs/namei.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
> >>   1 file changed, 43 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/namei.c b/fs/namei.c
> >> index f01b278ac0ef..8ad7a0dfa596 100644
> >> --- a/fs/namei.c
> >> +++ b/fs/namei.c
> >> @@ -3388,6 +3388,44 @@ static struct dentry *atomic_open(struct nameid=
ata *nd, struct dentry *dentry,
> >>          return dentry;
> >>   }
> >>
> >> +static struct dentry *atomic_revalidate_open(struct dentry *dentry,
> >> +                                            struct nameidata *nd,
> >> +                                            struct file *file,
> >> +                                            const struct open_flags *=
op,
> >> +                                            bool *got_write)
> >> +{
> >> +       struct mnt_idmap *idmap;
> >> +       struct dentry *dir =3D nd->path.dentry;
> >> +       struct inode *dir_inode =3D dir->d_inode;
> >> +       int open_flag =3D op->open_flag;
> >> +       umode_t mode =3D op->mode;
> >> +
> >> +       if (unlikely(IS_DEADDIR(dir_inode)))
> >> +               return ERR_PTR(-ENOENT);
> >> +
> >> +       file->f_mode &=3D ~FMODE_CREATED;
> >> +
> >> +       if (unlikely(open_flag & O_CREAT)) {
> >> +               WARN_ON(1);
> >
> >        if (WARN_ON_ONCE(open_flag & O_CREAT)) {
> >
> > is more compact and produces a nicer print
>
> Thanks a lot for your review Amir! Nice, I hadn't noticed that
> these macros actually return a value. Also updated the related
> fuse patch, which had a similar construct.
>
> >
> >> +               return ERR_PTR(-EINVAL);
> >> +       }
> >> +
> >> +       if (open_flag & (O_TRUNC | O_WRONLY | O_RDWR))
> >> +               *got_write =3D !mnt_want_write(nd->path.mnt);
> >> +       else
> >> +               *got_write =3D false;
> >> +
> >> +       if (!got_write)
> >> +               open_flag &=3D ~O_TRUNC;
> >> +
> >> +       inode_lock_shared(dir->d_inode);
> >> +       dentry =3D atomic_open(nd, dentry, file, open_flag, mode);
> >> +       inode_unlock_shared(dir->d_inode);
> >> +
> >> +       return dentry;
> >> +
> >> +}
> >> +
> >>   /*
> >>    * Look up and maybe create and open the last component.
> >>    *
> >> @@ -3541,8 +3579,10 @@ static const char *open_last_lookups(struct nam=
eidata *nd,
> >>                  if (IS_ERR(dentry))
> >>                          return ERR_CAST(dentry);
> >>                  if (dentry && unlikely(atomic_revalidate)) {
> >> -                       dput(dentry);
> >> -                       dentry =3D NULL;
> >> +                       BUG_ON(nd->flags & LOOKUP_RCU);
> >
> > The assertion means that someone wrote bad code
> > it does not mean that the kernel internal state is hopelessly corrupted=
.
> > Please avoid BUG_ON and use WARN_ON_ONCE and if possible
> > (seems to be the case here) also take the graceful error path.
> > It's better to fail an open than to crash the kernel.
>
> Thanks, updated. I had used BUG_ON because there is a similar BUG_ON a
> few lines below.

checkpatch strictly forbids new BUG_ON:
"Do not crash the kernel unless it is absolutely unavoidable-- use
 WARN_ON_ONCE() plus recovery code (if feasible) instead of BUG() or varian=
ts"

But it's true that vfs code has several of those.

> Added another RFC patch to covert that one as well.
> I'm going to wait a few days for possible other reviews and will then sen=
d
> out the new version. The updated v10 branch is here
>
> https://github.com/bsbernd/linux/tree/atomic-open-for-6.5-v10
>

IIUC, patches 3,4 are independent vfs optimization.
Is that correct?

Since you are going to need review of vfs maintainers
and since Christian would probably want to merge them
via the vfs tree, I think it would be better for you to post
them separately from your series if possible, so Miklos
would be able to pick up the fuse patches when they are
reviewed.

Thanks,
Amir.
