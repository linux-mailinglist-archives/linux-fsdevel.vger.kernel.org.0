Return-Path: <linux-fsdevel+bounces-10081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648BA8479C7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B98928A1A8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 19:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B27E5FEE6;
	Fri,  2 Feb 2024 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXA8Ij5K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B23115E5C8
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 19:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706902854; cv=none; b=p/KpXvs2ORsPzYwgGyI6OLr34GUpBqLWzKx/dNTsbjx+IQUHrTHaKFuNlNwYYlX2jucJHStGSf5H8oz/iHX8kvCABmtTEwmAsspBkcatMS/OP20dGAYOvM+TXf/uoKZx9qFPXRFMtExAA+yZXV8nlBWrADB7UC/RQjilhf4GaV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706902854; c=relaxed/simple;
	bh=3N75KitqmFfxmL+JxgYiP7a7BWFWzujWB0dvTJmsjgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2GHhsea/gNlnPukByMeOZP02b4Q0ynFuFBwJUVZxrFIdzeKvzFYECeIsvokaVwO3Ie+53DRoTyoLGFw8VBV4SfbvdlunqhHPRTdSrMj4XGZ2uFh4VXCkAnlEIIErt9YsmilzwSL+gfA990CaUYbME7xc6W10XULyWKCfPphLts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXA8Ij5K; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68c431c6c91so11001496d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 11:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706902851; x=1707507651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NepBByk7e2uPvOe4fNlTxIthJCFFSZE6uh6kJJ8UevU=;
        b=OXA8Ij5KE3bL2GDrmlRna+GfZRqyNFHYrvsMX602iDtrquMdZhCXiGs2w0GXMlFPX2
         fxFxI0rcVsFUUyrsTeQcftS0Wmu7fKEb+SbsDvMZB4/UWSfEk9hvU2q+FvmxGWQMtSE4
         0GNmrksmfjyX417dFPUVOec4pSiszITkiLlOiHZt/rWFEWq0r55TzdzzDJy1CwMv29uw
         bOT5QwY9DwJSkEabqHfUsv9GQLRChKRNgUjNPjlEKV+WPdu8v2dnB+gcDe8fy59hb+eT
         WKmCywTmFQu3f5OUu1yEdHqp0sJnDQChIz7TQSgPW2Pik+wNvv+oq+AqaV2Sk5aGDPKg
         oWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706902851; x=1707507651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NepBByk7e2uPvOe4fNlTxIthJCFFSZE6uh6kJJ8UevU=;
        b=KAdJBgspAaq8O897wKkb1vYnomHLFE+Mp/wWTeocLmuMo+fc0Q+qK/UE34xv7wKbZF
         BAl26qlSRsCrjMYxRfCGRwQsko7zhV0EX74xjEva7Hh1rzRYaSdrlz5i6suB7WIP4H94
         GSntEjbq5fxvwE8HG46e9lZk0ODRVLWGnLxhLLOiDdfsjUsbGzpN4BKgTgYHst1RifKy
         hcHwMiefQWVP46HJssckKoA2Q6rXN4F2HbYZ/d/npuOI61XXEhbBnRngU6SsJUzW4Fsw
         7gSoBAiuyyv0iR6Bbi5jtNxoRo9+wD/uDtvs3xWcBfA6QR0pUdAYArVyC83CAPSl+77v
         5L9Q==
X-Forwarded-Encrypted: i=0; AJvYcCXdAhzHORpDCfbmbN9uK/izPhSGePcBksM/iVpEuy1QkyIl7Xw3YJk32ln/xRNvoyfr8smhJTXj1YjpwdjJwEFyi9mAQS2rUNKQB13M4Q==
X-Gm-Message-State: AOJu0YzT9D/zqywlYdHbGBmdOe81CdLqsJg3Tjl0XUQLX2bRADd6yvvO
	65aXPuPFVCQSAOsnItwvC8FrdtouH+O7bJK2vJ7aAVZZdKaDwG+kpxBCI6mndAZutx7i+y+kP5B
	YX/KlkaKdL0yb3bBkZo9tgnUiF+0=
X-Google-Smtp-Source: AGHT+IH6jQQaN/Jy5SK16g9mfxxpQX0RC+MmRCLi2XbJPQqu5fCp9EK9lcNnhFBJLoPJgxrCt2i3uC6WtK7cMpnSYAk=
X-Received: by 2002:a0c:f0cc:0:b0:68c:8742:5929 with SMTP id
 d12-20020a0cf0cc000000b0068c87425929mr2543055qvl.6.1706902850934; Fri, 02 Feb
 2024 11:40:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com> <20240131230827.207552-6-bschubert@ddn.com>
 <CAJfpegvUfQw4TF7Vz_=GMO9Ta=6Yb8zUfRaGMm4AzCXOTdYEAA@mail.gmail.com>
 <CAOQ4uxjVqCAYhn07Bnk6HsXB21t4FFQk91ywS3S8A8u=+B9A=w@mail.gmail.com> <753d6823-e984-4730-a126-d66b65ea772c@ddn.com>
In-Reply-To: <753d6823-e984-4730-a126-d66b65ea772c@ddn.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 2 Feb 2024 21:40:39 +0200
Message-ID: <CAOQ4uxihgAGp+D3eqXeJy8fst7tFjVeJwhiupBPz2-WBJJqMLg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] fuse: introduce inode io modes
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 7:53=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> w=
rote:
>
> On 2/1/24 17:33, Amir Goldstein wrote:
> > On Thu, Feb 1, 2024 at 4:47=E2=80=AFPM Miklos Szeredi <miklos@szeredi.h=
u> wrote:
> >>
> >> On Thu, 1 Feb 2024 at 00:09, Bernd Schubert <bschubert@ddn.com> wrote:
> >>>
> >>> From: Amir Goldstein <amir73il@gmail.com>
> >>>
> >>> The fuse inode io mode is determined by the mode of its open files/mm=
aps
> >>> and parallel dio.
> >>>
> >>> - caching io mode - files open in caching mode or mmap on direct_io f=
ile
> >>> - direct io mode - no files open in caching mode and no files mmaped
> >>> - parallel dio mode - direct io mode with parallel dio in progress
> >>
> >> Specifically if iocachectr is:
> >>
> >>> 0 -> caching io
> >> =3D=3D 0 -> direct io
> >> < 0 -> parallel io
> >>
> >>>
> >>> We use a new FOPEN_CACHE_IO flag to explicitly mark a file that was o=
pen
> >>> in caching mode.
> >>
> >> This is really confusing.  FOPEN_CACHE_IO is apparently an internally
> >> used flag, but it's defined on the userspace API.
> >>
> >> a) what is the meaning of this flag on the external API?
> >> b) what is the purpose of this flag internally?
> >
> > The purpose is to annotate the state of direct io file that was mmaped
> > as FOPEN_DIRECT_IO | FOPEN_CACHE_IO.
> > An fd like this puts inode in caching mode and its release may get inod=
e
> > out of caching mode.
> >
> > I did not manage to do refcoutning with fuse_vma_close(), because those
> > calls are not balances with fuse_file_mmap() calls.
> >
> > The first mmap() of an FOPEN_DIRECT_IO file may incur wait for completi=
on
> > of parallel dio.
> >
> > The only use of exporting FOPEN_CACHE_IO to the server is that it could
> > force incurring this wait at open() time instead of mmap() time.
> >
> > I also considered for servers that advertise FUSE_PASSTHROUGH
> > capability to not allow open without specifying an explicit io mode,
> > that is one of  FOPEN_DIRECT_IO | FOPEN_CACHE_IO |
> > FOPEN_PASSTHROUGH, but I did not actually implement those
> > semantics ATM.
> >
> >>
> >>>
> >>> direct_io mmap uses page cache, so first mmap will mark the file as
> >>> FOPEN_DIRECT_IO|FOPEN_CACHE_IO (i.e. mixed mode) and inode will enter
> >>> the caching io mode.
> >>>
> >>> If the server opens the file with flags FOPEN_DIRECT_IO|FOPEN_CACHE_I=
O,
> >>> the inode enters caching io mode already on open.
> >>>
> >>> This allows executing parallel dio when inode is not in caching mode
> >>> even if shared mmap is allowed, but no mmaps have been performed on
> >>> the inode in question.
> >>>
> >>> An open in caching mode and mmap on direct_io file now waits for all
> >>> in-progress parallel dio writes to complete, so paralle dio writes
> >>> together with FUSE_DIRECT_IO_ALLOW_MMAP is enabled by this commit.
> >>
> >> I think the per file state is wrong, the above can be done with just
> >> the per-inode state.
> >>
> >
> > The per-file state is to taint the file is "has been mmaped".
> > I did not find another way of doing this.
> > Please suggest another way.
> >
> >>
> >>>
> >>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> >>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >>> ---
> >>>   fs/fuse/file.c            | 215 +++++++++++++++++++++++++++++++++++=
+--
> >>>   fs/fuse/fuse_i.h          |  79 +++++++++++++-
> >>>   include/uapi/linux/fuse.h |   2 +
> >>>   3 files changed, 286 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> >>> index 7d2f4b0eb36a..eb9929ff9f60 100644
> >>> --- a/fs/fuse/file.c
> >>> +++ b/fs/fuse/file.c
> >>> @@ -105,10 +105,177 @@ static void fuse_release_end(struct fuse_mount=
 *fm, struct fuse_args *args,
> >>>          kfree(ra);
> >>>   }
> >>>
> >>> +static bool fuse_file_is_direct_io(struct file *file)
> >>> +{
> >>> +       struct fuse_file *ff =3D file->private_data;
> >>> +
> >>> +       return ff->open_flags & FOPEN_DIRECT_IO || file->f_flags & O_=
DIRECT;
> >>> +}
> >>
> >> This is one of the issues with the per-file state. O_DIRECT can be
> >> changed with fcntl(fd, F_SETFL, ...), so state calculated at open can
> >> go stale.
> >>
> >
> > Ouch!
> > Actually, it may not matter much if we just ignore O_DIRECT
> > completely for the purpose of io modes.
>
> I had also missed that fcntl option :/
>
> >
> > The io mode could be determined solely from FMODE_* flags.
> >
> > Worst case is that if the server opens an O_DIRECT file without
> > FOPEN_DIRECT_IO, then this inode cannot do parallel dio
> > and this inode cannot be opened in passthrough mode.
> > I don't think that is such a big problem.
> >
> > Bernd, what do you think?
>
> Yeah, currently FOPEN_PARALLEL_DIRECT_WRITES does not have an effect
> without FOPEN_DIRECT_IO. In my fuse-dio consolidation branch that
> changes. For me it is ok that parallel dio requires
> FOPEN_DIRECT_IO, easy enough to set on the server side in open methods
> when O_DIRECT is set. We should just document it in fuse.h.
>

Ok. I removed the O_DIRECT code from the last version I pushed.
Please verify that it does not break anything in your dio tests.

> >
> > BTW, server can and probably should open O_DIRECT files
> > with FOPEN_PASSTHROUGH and that means something
> > completely different than O_DIRECT && FOPEN_DIRECT_IO -
> > it means that io is passed through to the backing file without
> > doing buffered io on the backing file.
> >
> >>> +
> >>> +/*
> >>> + * Wait for cached io to be allowed -
> >>> + * Blocks new parallel dio writes and waits for the in-progress para=
llel dio
> >>> + * writes to complete.
> >>> + */
> >>> +static int fuse_inode_wait_for_cached_io(struct fuse_inode *fi)
> >>> +{
> >>> +       int err =3D 0;
> >>> +
> >>> +       assert_spin_locked(&fi->lock);
> >>> +
> >>> +       while (!err && !fuse_inode_get_io_cache(fi)) {
> >>> +               /*
> >>> +                * Setting the bit advises new direct-io writes
> >>> +                * to use an exclusive lock - without it the wait bel=
ow
> >>> +                * might be forever.
> >>> +                */
> >>> +               set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
> >>> +               spin_unlock(&fi->lock);
> >>> +               err =3D wait_event_killable(fi->direct_io_waitq,
> >>> +                                         fuse_is_io_cache_allowed(fi=
));
> >>> +               spin_lock(&fi->lock);
> >>> +       }
> >>> +       /* Clear FUSE_I_CACHE_IO_MODE flag if failed to enter caching=
 mode */
> >>> +       if (err && fi->iocachectr <=3D 0)
> >>> +               clear_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
> >>> +
> >>> +       return err;
> >>> +}
> >>
> >> I suggest moving all infrastructure, including the inline helpers in
> >> fuse_i.h into a separate source file.
> >>
> >
> > OK. I can make those changes.
> >

moved to iomode.c

> >>> +
> >>> +/* Start cached io mode where parallel dio writes are not allowed */
> >>> +static int fuse_file_cached_io_start(struct inode *inode)
> >>> +{
> >>> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> >>> +       int err;
> >>> +
> >>> +       spin_lock(&fi->lock);
> >>> +       err =3D fuse_inode_wait_for_cached_io(fi);
> >>> +       spin_unlock(&fi->lock);
> >>> +       return err;
> >>> +}
> >>> +
> >>> +static void fuse_file_cached_io_end(struct inode *inode)
> >>> +{
> >>> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> >>> +
> >>> +       spin_lock(&fi->lock);
> >>> +       fuse_inode_put_io_cache(get_fuse_inode(inode));
> >>> +       spin_unlock(&fi->lock);
> >>> +}
> >>> +
> >>> +/* Start strictly uncached io mode where cache access is not allowed=
 */
> >>> +static int fuse_file_uncached_io_start(struct inode *inode)
> >>> +{
> >>> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> >>> +       bool ok;
> >>> +
> >>> +       spin_lock(&fi->lock);
> >>> +       ok =3D fuse_inode_deny_io_cache(fi);
> >>> +       spin_unlock(&fi->lock);
> >>> +       return ok ? 0 : -ETXTBSY;
> >>> +}
> >>> +
> >>> +static void fuse_file_uncached_io_end(struct inode *inode)
> >>> +{
> >>> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> >>> +       bool allow_cached_io;
> >>> +
> >>> +       spin_lock(&fi->lock);
> >>> +       allow_cached_io =3D fuse_inode_allow_io_cache(fi);
> >>> +       spin_unlock(&fi->lock);
> >>> +       if (allow_cached_io)
> >>> +               wake_up(&fi->direct_io_waitq);
> >>> +}
> >>> +
> >>> +/* Open flags to determine regular file io mode */
> >>> +#define FOPEN_IO_MODE_MASK \
> >>> +       (FOPEN_DIRECT_IO | FOPEN_CACHE_IO)
> >>> +
> >>> +/* Request access to submit new io to inode via open file */
> >>> +static int fuse_file_io_open(struct file *file, struct inode *inode)
> >>> +{
> >>> +       struct fuse_file *ff =3D file->private_data;
> >>> +       int iomode_flags =3D ff->open_flags & FOPEN_IO_MODE_MASK;
> >>> +       int err;
> >>> +
> >>> +       err =3D -EBUSY;
> >>> +       if (WARN_ON(ff->io_opened))
> >>> +               goto fail;
> >>> +
> >>> +       if (!S_ISREG(inode->i_mode) || FUSE_IS_DAX(inode)) {
> >>
> >> This S_ISREG check can also go away with separating the directory open=
s.
> >
> > OK. I will see if I can make that cleanup as well.
>

done.

Bernd,

I pushed branch with latest cleanup patches and addressed Miklos'
simpler review comments to:

https://github.com/amir73il/linux/commits/fuse_io_mode-020224/

The one thing I did not change is the FOPEN_CACHE_IO flag
and per-file state, because I have no idea how to fix this differently.
I can change the external flag to an internal state if that is the main
concern, but I had a feeling there was more to it.

If you get the chance, please review and re-run your tests.

Thanks,
Amir.

