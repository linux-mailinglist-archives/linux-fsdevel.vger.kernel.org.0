Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714DC6EEB28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 02:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbjDZABS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 20:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237873AbjDZABR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 20:01:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2342B217;
        Tue, 25 Apr 2023 17:01:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DD39631C7;
        Wed, 26 Apr 2023 00:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37ECC4339B;
        Wed, 26 Apr 2023 00:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682467275;
        bh=65K7Cfyen6bnf2mZnH4Di3GHXwOFItB8erJ//utGX5U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PLK2dHWsdZkgzzxryFF1SLQDynepiILESN5cZIFwk1wqcAGCwINS41doy1UfEqGBZ
         2gZITqVGzXynLyWmpSzuK3aFFauMJ+mTTF4X1TBmEAbvEHiOIQbCifJGjkCnc8BoRC
         awFdwd87wFxL8+rl3xFhvPG8l9GhHwJsAwpvyazPMjiiO6dcIdKA/HPDZxKQFJr9nt
         10OOn2eSR3TRzjtA7L7NnRhCha6A4MmzPy8TiwD+GVEaYj7Aw6qoUq/O1ulOOliOo2
         9R3el/c/1n3GZnnC4EF1V5YZyYbXkyrROsv6GpDvvwE/nUrH7LZ53319EmG/l9RI41
         Pjao9J9EWSHPg==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-54fe0146b01so76924537b3.3;
        Tue, 25 Apr 2023 17:01:14 -0700 (PDT)
X-Gm-Message-State: AAQBX9cD7cUGhWiUGGdsBoPfM22iVKC8oo7QSIMxqvApd4YuEcq6OTbM
        tVMgWe79BYfk7Wql4LvvZSuIFSyL77B6B3VnVZU=
X-Google-Smtp-Source: AKy350bqhG4b57DBoF/DhuGpuedwoIq9kgM3yX7+amLnkF3rSUHq1JlM73TuDB5N4DEWyuDuFaUh2eLIqE23miJEgUs=
X-Received: by 2002:a0d:db47:0:b0:54f:ba89:225d with SMTP id
 d68-20020a0ddb47000000b0054fba89225dmr12104461ywe.19.1682467274086; Tue, 25
 Apr 2023 17:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230218003323.2322580-11-ericvh@kernel.org> <ZCEGmS4FBRFClQjS@7e9e31583646>
 <7686c810-4ed6-9e3a-3714-8b803e2d3c46@wanadoo.fr>
In-Reply-To: <7686c810-4ed6-9e3a-3714-8b803e2d3c46@wanadoo.fr>
From:   Eric Van Hensbergen <ericvh@kernel.org>
Date:   Tue, 25 Apr 2023 17:01:03 -0700
X-Gmail-Original-Message-ID: <CAFkjPT=-EvCf1HKT2-k73G4SVBwRDp=YtvfwhNAcjv6BzS4f9Q@mail.gmail.com>
Message-ID: <CAFkjPT=-EvCf1HKT2-k73G4SVBwRDp=YtvfwhNAcjv6BzS4f9Q@mail.gmail.com>
Subject: Re: [PATCH v5] fs/9p: remove writeback fid and fix per-file modes
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux_oss@crudebyte.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I swear I fixed that, must have been one of my fixes got dropped in
the process of churning over this patch.  I'm quite concerned that
this is coming up during the merge window because I'd really rather
not punt this patch series another two months.  I'm going to apply the
fix as an additional patch which hopefully Linus will accept with the
rest of the series.

On Tue, Apr 25, 2023 at 12:11=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 27/03/2023 =C3=A0 04:59, Eric Van Hensbergen a =C3=A9crit :
> > This patch removes the creating of an additional writeback_fid
> > for opened files.  The patch addresses problems when files
> > were opened write-only or getattr on files with dirty caches.
> >
> > This patch also incorporates information about cache behavior
> > in the fid for every file.  This allows us to reflect cache
> > behavior from mount flags, open mode, and information from
> > the server to inform readahead and writeback behavior.
> >
> > This includes adding support for a 9p semantic that qid.version=3D=3D0
> > is used to mark a file as non-cachable which is important for
> > synthetic files.  This may have a side-effect of not supporting
> > caching on certain legacy file servers that do not properly set
> > qid.version.  There is also now a mount flag which can disable
> > the qid.version behavior.
> >
> > Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> > ---
> >   fs/9p/fid.c            | 48 +++++++++-------------
> >   fs/9p/fid.h            | 33 ++++++++++++++-
> >   fs/9p/v9fs.h           |  1 -
> >   fs/9p/vfs_addr.c       | 22 +++++-----
> >   fs/9p/vfs_file.c       | 91 ++++++++++++++---------------------------=
-
> >   fs/9p/vfs_inode.c      | 45 +++++++--------------
> >   fs/9p/vfs_inode_dotl.c | 48 +++++++++-------------
> >   fs/9p/vfs_super.c      | 33 ++++-----------
> >   8 files changed, 135 insertions(+), 186 deletions(-)
> >
>
> Hi,
>
> this patch has already reached -next, but there is some spurious code.
>
> As, I'm not sure what the real intent is, I prefer to reply here instead
> of sending a patch.
>
>
> [...]
>
> > @@ -817,9 +814,14 @@ v9fs_vfs_atomic_open(struct inode *dir, struct den=
try *dentry,
> >
> >       v9ses =3D v9fs_inode2v9ses(dir);
> >       perm =3D unixmode2p9mode(v9ses, mode);
> > -     fid =3D v9fs_create(v9ses, dir, dentry, NULL, perm,
> > -                             v9fs_uflags2omode(flags,
> > -                                             v9fs_proto_dotu(v9ses)));
> > +     p9_omode =3D v9fs_uflags2omode(flags, v9fs_proto_dotu(v9ses));
> > +
> > +     if ((v9ses->cache >=3D CACHE_WRITEBACK) && (p9_omode & P9_OWRITE)=
) {
> > +             p9_omode =3D (p9_omode & !P9_OWRITE) | P9_ORDWR;
>
> This code looks strange.
> P9_OWRITE is 0x01, so !P9_OWRITE is 0.
> So the code is equivalent to "p9_omode =3D P9_ORDWR;"
>
> Is it what is expexted?
>
> Maybe
>         p9_omode =3D (p9_omode & ~P9_OWRITE) | P9_ORDWR;
> ?
>
> > +             p9_debug(P9_DEBUG_CACHE,
> > +                     "write-only file with writeback enabled, creating=
 w/ O_RDWR\n");
> > +     }
> > +     fid =3D v9fs_create(v9ses, dir, dentry, NULL, perm, p9_omode);
> >       if (IS_ERR(fid)) {
> >               err =3D PTR_ERR(fid);
> >               goto error;
>
> [...]
>
> > diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> > index a28eb3aeab29..4b9488cb7a56 100644
> > --- a/fs/9p/vfs_inode_dotl.c
> > +++ b/fs/9p/vfs_inode_dotl.c
> > @@ -232,12 +232,12 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, stru=
ct dentry *dentry,
> >       int err =3D 0;
> >       kgid_t gid;
> >       umode_t mode;
> > +     int p9_omode =3D v9fs_open_to_dotl_flags(flags);
> >       const unsigned char *name =3D NULL;
> >       struct p9_qid qid;
> >       struct inode *inode;
> >       struct p9_fid *fid =3D NULL;
> > -     struct v9fs_inode *v9inode;
> > -     struct p9_fid *dfid =3D NULL, *ofid =3D NULL, *inode_fid =3D NULL=
;
> > +     struct p9_fid *dfid =3D NULL, *ofid =3D NULL;
> >       struct v9fs_session_info *v9ses;
> >       struct posix_acl *pacl =3D NULL, *dacl =3D NULL;
> >       struct dentry *res =3D NULL;
> > @@ -282,14 +282,19 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, stru=
ct dentry *dentry,
> >       /* Update mode based on ACL value */
> >       err =3D v9fs_acl_mode(dir, &mode, &dacl, &pacl);
> >       if (err) {
> > -             p9_debug(P9_DEBUG_VFS, "Failed to get acl values in creat=
 %d\n",
> > +             p9_debug(P9_DEBUG_VFS, "Failed to get acl values in creat=
e %d\n",
> >                        err);
> >               goto out;
> >       }
> > -     err =3D p9_client_create_dotl(ofid, name, v9fs_open_to_dotl_flags=
(flags),
> > -                                 mode, gid, &qid);
> > +
> > +     if ((v9ses->cache >=3D CACHE_WRITEBACK) && (p9_omode & P9_OWRITE)=
) {
> > +             p9_omode =3D (p9_omode & !P9_OWRITE) | P9_ORDWR;
>
> Same here.
>
> CJ
>
> > +             p9_debug(P9_DEBUG_CACHE,
> > +                     "write-only file with writeback enabled, creating=
 w/ O_RDWR\n");
> > +     }
> > +     err =3D p9_client_create_dotl(ofid, name, p9_omode, mode, gid, &q=
id);
> >       if (err < 0) {
> > -             p9_debug(P9_DEBUG_VFS, "p9_client_open_dotl failed in cre=
at %d\n",
> > +             p9_debug(P9_DEBUG_VFS, "p9_client_open_dotl failed in cre=
ate %d\n",
> >                        err);
> >               goto out;
> >       }
>
