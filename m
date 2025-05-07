Return-Path: <linux-fsdevel+bounces-48382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F62AADF48
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270C11C25827
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE783280028;
	Wed,  7 May 2025 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="FGi89wX8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260CA231A3B;
	Wed,  7 May 2025 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621277; cv=none; b=GtFdYTQ06KIlg5AuGYenFmItH+2k4CsbNcLsfxvPqiSTGesTjp290eP9Oui155s+txpzs2k2noisLI36GIb+HwSo4qgOXgVG6KbB1kh+b90/BPg3cqhVCWlA1X56IWsX9o9B8J4vuzcnHx6rjyO5gpFIEP70itXBMqPKo3+aRXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621277; c=relaxed/simple;
	bh=Zihm2h4tk2G5LNf5qRRKhNOja0uqU0XEtHT0Nq7ohQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzHo+EzkYM60laUrc8OO/fUeNikSufdPQdV97pwTgBZShltFKbbO+d7Vd50LNToVyF1ZfgZwSyG7zexNMsgM8StzKqEPdTi/fKNF6sgQas+knMZycJFKHIBOYWu1JQruyvJGUWZNQ2ZWvuPrQywjoMKFrNYfW39sxuikPo0C6lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=FGi89wX8; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1746621253;
	bh=4vsbxRRKnv1g+7sUbJ0j4DWeU+4ZHqGmtuozwEkD8TQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=FGi89wX8G0UrMe/02jnnNDqXKt5oilegAsBE0FIIiPhMN+tJCcF2LnIiSEwZGlUzY
	 N0APXqTXGjBS2YtbR+ctKNBXqPseVTVuiLKKe0VcFl4fRWWRbZHZMH9Zr9rAz9MbWs
	 4GEP6uPwZvyqxrkWTtg8zfZiXKmx46sYNDkBkynA=
X-QQ-mid: zesmtpgz5t1746621250t499dc0c2
X-QQ-Originating-IP: JixwxS5jDxwyM9a487Z7kh8JjRNry0gyFMbU+61m1qI=
Received: from mail-pl1-f175.google.com ( [209.85.214.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 07 May 2025 20:34:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15413479754048293537
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-224171d6826so99993965ad.3;
        Wed, 07 May 2025 05:34:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaP3MLP+QMBXwU6PIfwDRi06EAGlJ6lVE4eZ0uE2ecVZ7fqpU5+GCBr8cI3DJOAKF8y8g3v6+JbXOQM5Ij@vger.kernel.org, AJvYcCUmOWZgPCVjK1X8e1RDcUEY6ZdIYCUoc1TJbbVLeqgpLrNxk43zqp96ddoO3WzDxvdtuFZ4VZzGcqOo39B+@vger.kernel.org
X-Gm-Message-State: AOJu0YwiDtDTfyadYOVwqEioJpSqpYa5TBxWhW3YJke9k75b+EaLVpF5
	lpVgx2KYtdcOujbSXnXmWH1+4TEoHKZ+oxK2rTRHtzDg5tO1rtTa5PCcTZvM7kY2RBUwMkL/NSn
	Z9xUCnLKeWg8J3w22x0c+rbH4acs=
X-Google-Smtp-Source: AGHT+IG+VAMZ2gWrcB4H4gABdFMIxdjqtRWF4hIsZ93JGf34+00BNcvMIA5GJ86DKdPa+Oi5Mn3uluZLYZH+90grYyM=
X-Received: by 2002:a05:6902:1009:b0:e78:178e:fab6 with SMTP id
 3f1490d57ef6-e7880e70bf9mr3437268276.1.1746621237307; Wed, 07 May 2025
 05:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507032926.377076-2-chenlinxuan@uniontech.com> <CAOQ4uxjKFXOKQxPpxtS6G_nR0tpw95w0GiO68UcWg_OBhmSY=Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxjKFXOKQxPpxtS6G_nR0tpw95w0GiO68UcWg_OBhmSY=Q@mail.gmail.com>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Wed, 7 May 2025 20:33:45 +0800
X-Gmail-Original-Message-ID: <5BC18C24710A619B+CAC1kPDP4oO29B_TM-2wvzt1+Gc6hWTDGMfHSJhOax4_Cg2dEkg@mail.gmail.com>
X-Gm-Features: ATxdqUFXGFq5UyScT8CIOVyLihpwuVTP23JQH51epEWdrsJW4NHv4R2aNgwfQKU
Message-ID: <CAC1kPDP4oO29B_TM-2wvzt1+Gc6hWTDGMfHSJhOax4_Cg2dEkg@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: fuse: add backing_files control file
To: Amir Goldstein <amir73il@gmail.com>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MepcA1DNNFMh2VTy1ERzQZWy3/JbbpP9RbJfm1r0wqjakzzWxuMObTPK
	NIUqX0QdeQkJ6kRsKgYHs5hWHUY5pJW/6D5jWW7Gfy6XdEHgT9WvUvY/GcAJtsWX6h6uE4H
	KZh/xNrcyNLK0qrffrV6Z3UmF7Xblpn+vlPQGpuQB3iiSSp65g6JjT9tMfx40VC40H2IEEn
	av5MGe7wlsm6C8qcdkCqEdaQqoF5nh0N6xHFUDsaA1CM6d9glJKYG69ZMU2VZnMx0AzwrgD
	aK93OmVLtjbKJ2AafFEz/7Tl8Sfs+3H23tAO8ZEtuRX5f5oSa77KGODq9Gvwd46iU3u8uAe
	9fH29VdxFqt71tZ4OEkm+cOCEI45cH63FnfSQ9cBqMUmFbYkjYg3NQMfG4svYnzgzKAXyc/
	cWr/Qld3JihAkKoUATVC3UQ7AmiN010kFTeP7K+D8y/aF+XTSa2pQ288QyGOydyQ0TufYre
	kXHefypGVzQTZh7yBT0JHZ6+PoAwnASis0r1qvefEQREWLL157Yg6vvIhJialZopSx4EGuC
	7U4tO5rZ4O0TaZpzxZGhrE66QhfzBPTL3qwooXuwG7s7EQAbQ3S5sQ1dJ4jqMcEoYwLjJ3S
	FnYsC06JTUCv7qrmZ+YFGRrqMq4mZv2PnYVA91rCzHSjmhRO9jfRvWJadQhRpcGIfehHNnu
	0EuGg64Bo/dxv2aEOy4zjV8vJ5tziKkK2pEjIbeszUknJoFeYNFsH4SMKI5bEDS8Y6C2CyX
	Pj7XCfM/lgWt7QAxcLg0qxxg6hvSkcgqce+7QZ5p+pEV9XD23qXwezsHi4xedOFvqVoeQSJ
	C878ZRCL5QaxQE33cwMQWfqGvJLFGt5yMja6fEDe33MuKIyAFngAZoEPWy8xidwwkJUVHO/
	hgqZyngYQyQ+dDY2ugXwT8DVWB0LmamU8XHkLgaBu/4bLSRBcyOJajkESZbosXY4p1va42p
	2CMThc0H4IclhbZqC0hDwmbIQUIJSa6u3Yay38StKTVzaD+hVin5mm6RKbfTAm8U/zLmZKJ
	F5VqMYuW0aBpFfISbJLVltu2Ibm46HY7C64Wre3gGFdfQRzRfOAFIfct/PqYtEWiniWhHSm
	Q==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Wed, May 7, 2025 at 7:03=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Wed, May 7, 2025 at 5:29=E2=80=AFAM Chen Linxuan <chenlinxuan@uniontec=
h.com> wrote:
> >
> > Add a new FUSE control file "/sys/fs/fuse/connections/*/backing_files"
> > that exposes the paths of all backing files currently being used in
> > FUSE mount points. This is particularly valuable for tracking and
> > debugging files used in FUSE passthrough mode.
> >
> > This approach is similar to how fixed files in io_uring expose their
> > status through fdinfo, providing administrators with visibility into
> > backing file usage. By making backing files visible through the FUSE
> > control filesystem, administrators can monitor which files are being
> > used for passthrough operations and can force-close them if needed by
> > aborting the connection.
> >
> > This exposure of backing files information is an important step towards
> > potentially relaxing CAP_SYS_ADMIN requirements for certain passthrough
> > operations in the future, allowing for better security analysis of
> > passthrough usage patterns.
> >
> > The control file is implemented using the seq_file interface for
> > efficient handling of potentially large numbers of backing files.
> > Access permissions are set to read-only (0400) as this is an
> > informational interface.
> >
> > FUSE_CTL_NUM_DENTRIES has been increased from 5 to 6 to accommodate the
> > additional control file.
> >
> > Some related discussions can be found at:
> >
> > Link: https://lore.kernel.org/all/4b64a41c-6167-4c02-8bae-3021270ca519@=
fastmail.fm/T/#mc73e04df56b8830b1d7b06b5d9f22e594fba423e
> > Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhAY1m7ubJ3p-A3rSufw_=
53WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com/
> >
>
> remove newline
>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> >
> > ---
> > Please review this patch carefully. I am new to kernel development and
> > I am not quite sure if I have followed the best practices, especially
> > in terms of seq_file, error handling and locking. I would appreciate
> > any feedback.
>
> Very nice work!
>
> >
> > I have do some simply testing using libfuse example [1]. It seems to
> > work well.
>
> It would be great if you could add basic sanity tests to libfuse
> maybe in test_passthrough_hp(), but I do not see any tests for
> /sys/fs/fuse/connections.
>
> I also see that there is one kernel selftest that mounts a fuse fs
> tools/testing/selftests/memfd
> maybe that is an easier way to write a simple test to verify the
> /sys/fs/fuse/connections functionally.
>
> Anyway, I do not require that you do that as a condition for merging this=
 patch,
> but I may require that for removing CAP_SYS_ADMIN ;)
>
> >
> > [1]: https://github.com/libfuse/libfuse/blob/master/example/passthrough=
_hp.cc
> > ---
> >  fs/fuse/control.c | 129 +++++++++++++++++++++++++++++++++++++++++++++-
> >  fs/fuse/fuse_i.h  |   2 +-
> >  2 files changed, 129 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> > index 2a730d88cc3bd..4d1e0acc5030f 100644
> > --- a/fs/fuse/control.c
> > +++ b/fs/fuse/control.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/init.h>
> >  #include <linux/module.h>
> >  #include <linux/fs_context.h>
> > +#include <linux/seq_file.h>
> >
> >  #define FUSE_CTL_SUPER_MAGIC 0x65735543
> >
> > @@ -180,6 +181,129 @@ static ssize_t fuse_conn_congestion_threshold_wri=
te(struct file *file,
> >         return ret;
> >  }
> >
> > +struct fuse_backing_files_seq_state {
> > +       struct fuse_conn *fc;
> > +       int pos;
>
> It will be more clear to call this 'backing_id'.
> It is more than an abstract pos in this context.
>
> > +};
> > +
> > +static void *fuse_backing_files_seq_start(struct seq_file *seq, loff_t=
 *pos)
> > +{
> > +       struct fuse_backing_files_seq_state *state =3D seq->private;
> > +       struct fuse_conn *fc =3D state->fc;
> > +
> > +       if (!fc)
> > +               return NULL;
> > +
> > +       spin_lock(&fc->lock);
> > +
> > +       if (*pos > idr_get_cursor(&fc->backing_files_map)) {
>
> This won't do after the ida allocator has wrapped up back to 1,
> it will not iterate the high ids.
>
> Please look at using idr_get_next() iteration, like bpf_prog_seq_ops.
>
> With that change, I don't think that you need to take the spin lock
> for iteration.
> I think that you can use rcu_read_lock() for the scope of each
> start(). next(), show()
> because we do not need to promise a "snapshot" of the backing_file at a s=
pecific
> time. If backing files are added/removed while iterating it is undefined =
if they
> are listed or not, just like readdir.
>
> > +               spin_unlock(&fc->lock);
> > +               return NULL;
>
> Not critical, but if you end up needing a "scoped" unlock for the
> entire iteration, you can use
> the unlock in stop() if you return ERR_PTR(ENOENT) instead of NULL in
> those error conditions.
>
> > +       }
> > +
> > +       state->pos =3D *pos;
> > +       return state;
> > +}
> > +
> > +static void *fuse_backing_files_seq_next(struct seq_file *seq, void *v=
,
> > +                                        loff_t *pos)
> > +{
> > +       struct fuse_backing_files_seq_state *state =3D seq->private;
> > +
> > +       (*pos)++;
> > +       state->pos =3D *pos;
> > +
> > +       if (state->pos > idr_get_cursor(&state->fc->backing_files_map))=
 {
> > +               spin_unlock(&state->fc->lock);
> > +               return NULL;
> > +       }
> > +
> > +       return state;
> > +}
> > +
> > +static int fuse_backing_files_seq_show(struct seq_file *seq, void *v)
> > +{
> > +       struct fuse_backing_files_seq_state *state =3D seq->private;
> > +       struct fuse_conn *fc =3D state->fc;
> > +       struct fuse_backing *fb;
> > +
> > +       fb =3D idr_find(&fc->backing_files_map, state->pos);
>
> You must fuse_backing_get/put(fb) around dereferencing fb->file
> if not holding the fc->lock.
> See fuse_passthrough_open().
>
> > +       if (!fb || !fb->file)
> > +               return 0;
> > +
> > +       seq_file_path(seq, fb->file, " \t\n\\");
>
> Pls print the backing id that is associated with the open file.

Does the backing id means anything in user space?
I think maybe we shouldn't expose kernel details to userspace.

>
> I wonder out loud if we should also augment the backing fd
> information in fdinfo of specific open fuse FOPEN_PASSTHROUGH files?

Or do you mean that we should display backing id and fuse connection id her=
e?

>
> I am not requiring that you do that, but if you want to take a look
> I think that it could be cool to display this info, along with open_flags
> and other useful fuse_file information.
>
> Thanks,
> Amir.
>
> > +       seq_puts(seq, "\n");
> > +
> > +       return 0;
> > +}
> > +
> > +static void fuse_backing_files_seq_stop(struct seq_file *seq, void *v)
> > +{
> > +       struct fuse_backing_files_seq_state *state =3D seq->private;
> > +
> > +       if (v)
> > +               spin_unlock(&state->fc->lock);
> > +}
> > +
> > +static const struct seq_operations fuse_backing_files_seq_ops =3D {
> > +       .start =3D fuse_backing_files_seq_start,
> > +       .next =3D fuse_backing_files_seq_next,
> > +       .stop =3D fuse_backing_files_seq_stop,
> > +       .show =3D fuse_backing_files_seq_show,
> > +};
> > +
> > +static int fuse_backing_files_seq_open(struct inode *inode, struct fil=
e *file)
> > +{
> > +       struct fuse_conn *fc;
> > +       struct fuse_backing_files_seq_state *state;
> > +       int err;
> > +
> > +       fc =3D fuse_ctl_file_conn_get(file);
> > +       if (!fc)
> > +               return -ENOTCONN;
> > +
> > +       err =3D seq_open(file, &fuse_backing_files_seq_ops);
> > +       if (err) {
> > +               fuse_conn_put(fc);
> > +               return err;
> > +       }
> > +
> > +       state =3D kmalloc(sizeof(*state), GFP_KERNEL);
> > +       if (!state) {
> > +               seq_release(file->f_inode, file);
> > +               fuse_conn_put(fc);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       state->fc =3D fc;
> > +       state->pos =3D 0;
> > +       ((struct seq_file *)file->private_data)->private =3D state;
> > +
> > +       return 0;
> > +}
> > +
> > +static int fuse_backing_files_seq_release(struct inode *inode,
> > +                                         struct file *file)
> > +{
> > +       struct seq_file *seq =3D file->private_data;
> > +       struct fuse_backing_files_seq_state *state =3D seq->private;
> > +
> > +       if (state) {
> > +               fuse_conn_put(state->fc);
> > +               kfree(state);
> > +               seq->private =3D NULL;
> > +       }
> > +
> > +       return seq_release(inode, file);
> > +}
> > +
> > +static const struct file_operations fuse_conn_passthrough_backing_file=
s_ops =3D {
> > +       .open =3D fuse_backing_files_seq_open,
> > +       .read =3D seq_read,
> > +       .llseek =3D seq_lseek,
> > +       .release =3D fuse_backing_files_seq_release,
> > +};
> > +
> >  static const struct file_operations fuse_ctl_abort_ops =3D {
> >         .open =3D nonseekable_open,
> >         .write =3D fuse_conn_abort_write,
> > @@ -270,7 +394,10 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
> >                                  1, NULL, &fuse_conn_max_background_ops=
) ||
> >             !fuse_ctl_add_dentry(parent, fc, "congestion_threshold",
> >                                  S_IFREG | 0600, 1, NULL,
> > -                                &fuse_conn_congestion_threshold_ops))
> > +                                &fuse_conn_congestion_threshold_ops) |=
|
> > +           !fuse_ctl_add_dentry(parent, fc, "backing_files", S_IFREG |=
 0400, 1,
> > +                                NULL,
> > +                                &fuse_conn_passthrough_backing_files_o=
ps))
> >                 goto err;
> >
> >         return 0;
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index d56d4fd956db9..2830b05bb0928 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -46,7 +46,7 @@
> >  #define FUSE_NAME_MAX (PATH_MAX - 1)
> >
> >  /** Number of dentries for each connection in the control filesystem *=
/
> > -#define FUSE_CTL_NUM_DENTRIES 5
> > +#define FUSE_CTL_NUM_DENTRIES 6
> >
> >  /* Frequency (in seconds) of request timeout checks, if opted into */
> >  #define FUSE_TIMEOUT_TIMER_FREQ 15
> > --
> > 2.43.0
> >
>
>

