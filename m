Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC885785074
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 08:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjHWGPg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 02:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjHWGPg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:15:36 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D61EE57
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 23:15:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99c1c66876aso693811966b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 23:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692771313; x=1693376113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ymUdLC7gtR59GEY6T/FNclwsv0WxAMDWF8PNtVnhLg0=;
        b=GrJfF0gWKSolCwbZvcwPx8lUe2iM82SjzCS1DlXAbdn4APLTB9QGem8SPDDH6swZ+N
         kgQCMedXNes8DAU3VSm8S9I1q1NXFhYdz5thkAnOpxh+wHTFdHYrfOY6C1ozKBuCh8S6
         RUKUvoeitDHGiAB0+u1UCmH915Sw88PXFBQlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692771313; x=1693376113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ymUdLC7gtR59GEY6T/FNclwsv0WxAMDWF8PNtVnhLg0=;
        b=VV8IllZYqwaseiNhqnHdVC0cr882cRnmZ9K+eqP4VxnrX4q5GIQ+yrn6U+wrRWsblG
         hONdtxy2DAqykO4Iy7SQXpYdMyz0GR1W9S7/JSSrR6sjNveuLxvVMhULNton8Gfte1BL
         lCZxv3/BZmOh7Kdi3xDz2UoyLbiPF+XlNg3BgYwVmzYrsBRE2gwGr1ErDTBnM+NQu0JS
         muij2hUV1wiuAi+aX0pArASUeMfPVc7D5jwqlOB2pO8VVk4IWxnAeKGPii18IkB0Gq1F
         MKXg81KtNnWh+3NeMQX0fKp6bxylp5mEyReWnTjRUe2Et5E5BBroLfzQabeoeoMiq/Le
         kLVQ==
X-Gm-Message-State: AOJu0YwzDWBagh2Rm7Z2OMBjx7CSPKx4b9m57L41PlcUj/LRlPRdWQAb
        20Z/kRyTt4DnM376eD5kNvaFPMmC+gp39V2zQVnYuw==
X-Google-Smtp-Source: AGHT+IH0wD4w3Iau9swl4fFSRNoz5rsMJRTYtr4AYn8Wr3qXf2JzEBS/Rl4rTtn34c47bcAoSi5VZU73X4/VblZ9e8A=
X-Received: by 2002:a17:906:73da:b0:98e:16b7:e038 with SMTP id
 n26-20020a17090673da00b0098e16b7e038mr9177132ejl.23.1692771313594; Tue, 22
 Aug 2023 23:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230810105501.1418427-1-mszeredi@redhat.com> <20230810105501.1418427-5-mszeredi@redhat.com>
 <b05d63c9-30e4-e3a5-2989-f5e66aab6496@fastmail.fm>
In-Reply-To: <b05d63c9-30e4-e3a5-2989-f5e66aab6496@fastmail.fm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 23 Aug 2023 08:15:01 +0200
Message-ID: <CAJfpegtk_zp7wdtc8ihZMFgLnZLppdv+SttUx__H2nDYX85mqw@mail.gmail.com>
Subject: Re: [PATCH 4/5] fuse: implement statx
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 22 Aug 2023 at 18:39, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 8/10/23 12:55, Miklos Szeredi wrote:
> > Allow querying btime.  When btime is requested in mask, then FUSE_STATX
> > request is sent.  Otherwise keep using FUSE_GETATTR.
> >
> > The userspace interface for statx matches that of the statx(2) API.
> > However there are limitations on how this interface is used:
> >
> >   - returned basic stats and btime are used, stx_attributes, etc. are
> >     ignored
> >
> >   - always query basic stats and btime, regardless of what was requested
> >
> >   - requested sync type is ignored, the default is passed to the server
> >
> >   - if server returns with some attributes missing from the result_mask,
> >     then no attributes will be cached
> >
> >   - btime is not cached yet (next patch will fix that)
> >
> > For new inodes initialize fi->inval_mask to "all invalid", instead of "all
> > valid" as previously.  Also only clear basic stats from inval_mask when
> > caching attributes.  This will result in the caching logic not thinking
> > that btime is cached.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >   fs/fuse/dir.c    | 106 ++++++++++++++++++++++++++++++++++++++++++++---
> >   fs/fuse/fuse_i.h |   3 ++
> >   fs/fuse/inode.c  |   5 ++-
> >   3 files changed, 107 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index 04006db6e173..552157bd6a4d 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -350,10 +350,14 @@ int fuse_valid_type(int m)
> >               S_ISBLK(m) || S_ISFIFO(m) || S_ISSOCK(m);
> >   }
> >
> > +bool fuse_valid_size(u64 size)
> > +{
> > +     return size <= LLONG_MAX;
> > +}
> > +
> >   bool fuse_invalid_attr(struct fuse_attr *attr)
> >   {
> > -     return !fuse_valid_type(attr->mode) ||
> > -             attr->size > LLONG_MAX;
> > +     return !fuse_valid_type(attr->mode) || !fuse_valid_size(attr->size);
> >   }
> >
> >   int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
> > @@ -1143,6 +1147,84 @@ static void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
> >       stat->blksize = 1 << blkbits;
> >   }
> >
> > +static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
> > +{
> > +     memset(attr, 0, sizeof(*attr));
> > +     attr->ino = sx->ino;
> > +     attr->size = sx->size;
> > +     attr->blocks = sx->blocks;
> > +     attr->atime = sx->atime.tv_sec;
> > +     attr->mtime = sx->mtime.tv_sec;
> > +     attr->ctime = sx->ctime.tv_sec;
> > +     attr->atimensec = sx->atime.tv_nsec;
> > +     attr->mtimensec = sx->mtime.tv_nsec;
> > +     attr->ctimensec = sx->ctime.tv_nsec;
> > +     attr->mode = sx->mode;
> > +     attr->nlink = sx->nlink;
> > +     attr->uid = sx->uid;
> > +     attr->gid = sx->gid;
> > +     attr->rdev = new_encode_dev(MKDEV(sx->rdev_major, sx->rdev_minor));
> > +     attr->blksize = sx->blksize;
> > +}
> > +
> > +static int fuse_do_statx(struct inode *inode, struct file *file,
> > +                      struct kstat *stat)
> > +{
> > +     int err;
> > +     struct fuse_attr attr;
> > +     struct fuse_statx *sx;
> > +     struct fuse_statx_in inarg;
> > +     struct fuse_statx_out outarg;
> > +     struct fuse_mount *fm = get_fuse_mount(inode);
> > +     u64 attr_version = fuse_get_attr_version(fm->fc);
> > +     FUSE_ARGS(args);
> > +
> > +     memset(&inarg, 0, sizeof(inarg));
> > +     memset(&outarg, 0, sizeof(outarg));
> > +     /* Directories have separate file-handle space */
> > +     if (file && S_ISREG(inode->i_mode)) {
> > +             struct fuse_file *ff = file->private_data;
> > +
> > +             inarg.getattr_flags |= FUSE_GETATTR_FH;
> > +             inarg.fh = ff->fh;
> > +     }
> > +     /* For now leave sync hints as the default, request all stats. */
> > +     inarg.sx_flags = 0;
> > +     inarg.sx_mask = STATX_BASIC_STATS | STATX_BTIME;
> > +     args.opcode = FUSE_STATX;
> > +     args.nodeid = get_node_id(inode);
> > +     args.in_numargs = 1;
> > +     args.in_args[0].size = sizeof(inarg);
> > +     args.in_args[0].value = &inarg;
> > +     args.out_numargs = 1;
> > +     args.out_args[0].size = sizeof(outarg);
> > +     args.out_args[0].value = &outarg;
> > +     err = fuse_simple_request(fm, &args);
> > +     if (err)
> > +             return err;
> > +
> > +     sx = &outarg.stat;
> > +     if (((sx->mask & STATX_SIZE) && !fuse_valid_size(sx->size)) ||
> > +         ((sx->mask & STATX_TYPE) && (!fuse_valid_type(sx->mode) ||
> > +                                      inode_wrong_type(inode, sx->mode)))) {
> > +             make_bad_inode(inode);
> > +             return -EIO;
> > +     }
> > +
> > +     fuse_statx_to_attr(&outarg.stat, &attr);
> > +     if ((sx->mask & STATX_BASIC_STATS) == STATX_BASIC_STATS) {
> > +             fuse_change_attributes(inode, &attr, ATTR_TIMEOUT(&outarg),
> > +                                    attr_version);
> > +     }
> > +     stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
> > +     stat->btime.tv_sec = sx->btime.tv_sec;
> > +     stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
> > +     fuse_fillattr(inode, &attr, stat);
> > +     stat->result_mask |= STATX_TYPE;
> > +
> > +     return 0;
> > +}
>
>
> Hmm, unconditionally using stat is potentially a NULL ptr with future
> updates. I think not right now, as fuse_update_get_attr() has the
> (request_mask & ~STATX_BASIC_STATS) condition and no caller
> that passes 'stat = NULL' requests anything beyond STATX_BASIC_STATS,
> but wouldn't it be more safe to access stat only conditionally?

Yes, makes sense.

Thanks,
Miklos
