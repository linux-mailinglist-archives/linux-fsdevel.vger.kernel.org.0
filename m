Return-Path: <linux-fsdevel+bounces-63041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1598BBAA199
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 19:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D8BB7A4A26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 17:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75B521257F;
	Mon, 29 Sep 2025 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxGLCLlM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF9A1F5827
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759165620; cv=none; b=dsimfJ2ECGqCer6EdLLubXODHADZUS2Ib0BSpnhdtgDgJJl+iZOjgTS6SAomMryhk9mtSAp1SdkQHQev5cy9mZMa4vkifagdwKOOJIZnK0IP/T+evMxa11EmqX6s89zEz2zDKdPrM0I5XPcZCpCFn3DBeBTxAXP9/Ogjr9S9QmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759165620; c=relaxed/simple;
	bh=xLKW67yp/URbQiFm1WXYRqt3wOkBe5PdtI2/uyWbAoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+JKXQ/FaabJwt46xJInTrxVqPtGusA9vGExMxy7yKh2T1J5lP8IyE6vB3EkFQVnlQrLW82FH0rcfEyas798nZqqhr2eCkOrXWfUpiZ9yPtRLYrOOWqii+FK711+RPrgSFMtQxihmxxjObCkasngZCqUCmYh2JTtOKSmIw82NPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxGLCLlM; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6364eb32535so1599549a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 10:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759165615; x=1759770415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdiqMKaoSrf7wCjdFkVOykMt8j6/c3wxB3qUI1QKrvo=;
        b=cxGLCLlMg24jMLfX3aTdV2Bei9DqsjYKRrSaVbuhYgBkY0sC2gvXvk7rfEI2kzAJKX
         AJgsgEOZGdsHoAJdePH+9Mp2YB7YPrveix9VYoBMiWpgHt9joHsTCSBYwRBaT1LqOrhO
         /PHuszFgPYITbdL2soK7ryIzF0mvZevTQxOoUF2+FvsyfPBhONGA802UAfu1q4L9LihQ
         JF122f15BuvdRLb/KQzqyptVopt33X3/RUyI4+QpNUWOTLxKE6danC/vdFsEcjDWX9R8
         LZ5iImHN4z497keSWDnbA60Dw4baTQuPF1PcLltIs4wGfLWyFR8L8QZI6/+I+TPfCk8j
         BjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759165615; x=1759770415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdiqMKaoSrf7wCjdFkVOykMt8j6/c3wxB3qUI1QKrvo=;
        b=E3RYq1x5FzlCQamr0tg9Kud5maBRxCgkXSi03fYf5xJcQYfhpiJBnCMjdwAqh6+zKX
         7PTlskR0kmGIIHhTfnl/8iWb/yH0ljnKNuN7/QkkgzZzs2sRc1XG5Fm9P4Nq4ErUH9A+
         pMGyVoJj2D9cwvu6UU9Ml8Id0IilMJn9gitulFpWwEAwFqvffZp7C5U6SSZpuBqZncYf
         KdCBEOr+x8immIzlktcyNakFoXMHVGSGOK7qnHX5ZXS3+8Yf4UoFsCidneApP0RaB5tr
         vIiqgEiAamGrcafQbuoq/vHwKgDC5bzlGr6hgVAZZCgR5hqI9sekg20IHswnRt/iVmJg
         nGcw==
X-Forwarded-Encrypted: i=1; AJvYcCXkHIjR9WLch63AJdp5bnIt81Nr+IQIB0fQeWEgar/3g2GAVaYKSs9Ha3kJ+yHcq7c9g3ul6D4JmHzc/Ec3@vger.kernel.org
X-Gm-Message-State: AOJu0YycozTbWHAlAVCeQhN+yPZrpRwaon7QffYghHfdbb/B4mrw10Al
	EoYwdDfdlkvrF3QXTSTkWun9OKFQOTOrVCHjuF0VlIISJqDPLI2fB4/wpR1xIPN+4ZJl3Lt2UJB
	Yy3LFJewQ7Rd7d4PJrfCFvpTOCHXLq3E=
X-Gm-Gg: ASbGncshcpbn7ViYGfNdw4oor+rz8h6dSDL2SPyZvq3fvE4reEvscmAVsUtnZ09wgx8
	sABTmrB3HfeO7Z3gg/oLg4vzt7fSBPEzM/DQp6ZfcQEdFssa9lG8DzU2AVqW3e9G7SdPrWO5Bme
	LFhBEyBbq5JFlbPFrWgTop6kprGBC1x0AGfbu7+DfoAAGvkLKNMBoPuvDJi5Lzm+VtOln6Uya2A
	K4ktsrT+mqFo2bANiJXYhx4lpzFANR+gD29S2k9nA==
X-Google-Smtp-Source: AGHT+IGY/yplAoO8hU4i/dTf8JIPe9FIbUxSEWdP7OQI8bpHRv6UIh8ojnOZJkDBD+NsHFv5G2NcdtGbuYBdnqVLocA=
X-Received: by 2002:aa7:c6ca:0:b0:62f:d87d:c36d with SMTP id
 4fb4d7f45d1cf-6349f9cb520mr12427993a12.8.1759165615125; Mon, 29 Sep 2025
 10:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916133437.713064-1-ekffu200098@gmail.com>
 <20250916133437.713064-3-ekffu200098@gmail.com> <CABFDxMFtZKSr5KbqcGQzJWYwT5URUYeuEHJ1a_jDUQPO-OKVGg@mail.gmail.com>
 <CAOQ4uxgEL=gOpSaSAV_+U=a3W5U5_Uq2Sk4agQhUpL4jHMMQ9w@mail.gmail.com> <CABFDxMG8uLaedhFuWHLAqW75a=TFfVEHkm08uwy76B7w9xbr=w@mail.gmail.com>
In-Reply-To: <CABFDxMG8uLaedhFuWHLAqW75a=TFfVEHkm08uwy76B7w9xbr=w@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 29 Sep 2025 19:06:43 +0200
X-Gm-Features: AS18NWBSsTkedC9k66FRcP54LFjB1pRMoBw4NxeME3T6glKYnufioAaObBcn3c8
Message-ID: <CAOQ4uxj9BAz6ibV3i57wgZ5ZNY9mvow=6-iJJ7b4pZn4mpgF7A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] smb: client: add directory change tracking via
 SMB2 Change Notify
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	linux-cifs@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>, Stef Bon <stefbon@gmail.com>, 
	Ioannis Angelakopoulos <iangelak@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 6:51=E2=80=AFPM Sang-Heon Jeon <ekffu200098@gmail.c=
om> wrote:
>
> On Sat, Sep 27, 2025 at 5:39=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Sat, Sep 27, 2025 at 3:03=E2=80=AFAM Sang-Heon Jeon <ekffu200098@gma=
il.com> wrote:
> > >
> > > On Tue, Sep 16, 2025 at 10:35=E2=80=AFPM Sang-Heon Jeon <ekffu200098@=
gmail.com> wrote:
> > > >
> > > > Implement directory change tracking using SMB2 Change Notify protoc=
ol
> > > > to enable real-time monitoring of remote directories. Applications =
using
> > > > inotify now receive immediate notifications when files are created,
> > > > deleted, or renamed on SMB2+ shares.
> > > >
> > > > This implementation begins by detecting tracking opportunities duri=
ng
> > > > regular SMB operations. In the current version, the readdir() serve=
s as
> > > > the detection point - when directory contents are accessed on SMB2+
> > > > servers, we check the inode's fsnotify_mask for active inotify watc=
hes.
> > > > If watches exist and directory is not already being tracked, we obt=
ain a
> > > > new FiieId and send a SMB2_CHANGE_NOTIFY request that waits for cha=
nges.
> > > >
> > > > Based on the server's response status, we convert CHANGE_NOTIFY res=
ponse
> > > > to fsnotify events and deliver to application on success, mark for
> > > > future reconnection on network errors, or discard the response and
> > > > marked entries for broken. If tracking can continue, we resend
> > > > SMB2_CHANGE_NOTIFY for continuous monitoring.
> > > >
> > > > Entries marked for reconnection are restored during SMB2 reconnecti=
on.
> > > > In the current version, smb2_reconnect() serves as restoration poin=
t -
> > > > when connection is reestablished, we obtain new FileIds and request
> > > > Change Notify requests for these entries.
> > > >
> > > > Entries marked for unmount during unmount. In the current version,
> > > > cifs_umount() serves as unmount marking point. Entries marked for c=
lean
> > > > are remove as soon as possible by the worker. Workers also run
> > > > periodically; currently every 30s; to check and remove untracking
> > > > directories.
> > > >
> > > > This feature is controlled by CONFIG_CIFS_DIR_CHANGE_TRACKING with
> > > > experimental.
> > > >
> > > > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > > > ---
> > > >  fs/smb/client/Kconfig   |  17 ++
> > > >  fs/smb/client/Makefile  |   2 +
> > > >  fs/smb/client/connect.c |   6 +
> > > >  fs/smb/client/notify.c  | 535 ++++++++++++++++++++++++++++++++++++=
++++
> > > >  fs/smb/client/notify.h  |  19 ++
> > > >  fs/smb/client/readdir.c |   9 +
> > > >  fs/smb/client/smb2pdu.c |   6 +
> > > >  7 files changed, 594 insertions(+)
> > > >  create mode 100644 fs/smb/client/notify.c
> > > >  create mode 100644 fs/smb/client/notify.h
> > > >
> > > > diff --git a/fs/smb/client/Kconfig b/fs/smb/client/Kconfig
> > > > index a4c02199fef4..0e3911936e0c 100644
> > > > --- a/fs/smb/client/Kconfig
> > > > +++ b/fs/smb/client/Kconfig
> > > > @@ -218,4 +218,21 @@ config CIFS_COMPRESSION
> > > >           Say Y here if you want SMB traffic to be compressed.
> > > >           If unsure, say N.
> > > >
> > > > ++config CIFS_DIR_CHANGE_TRACKING
> > >
> > > I also found a typo here and I'll fix them.
> > >
> > > > +       bool "Directory change tracking (Experimental)"
> > > > +       depends on CIFS && FSNOTIFY=3Dy
> > > > +       default n
> > > > +       help
> > > > +          Enables automatic tracking of directory changes for SMB2=
 or later
> > > > +          using the SMB2 Change Notify protocol. File managers and=
 applications
> > > > +          monitoring directories via inotify will receive real-tim=
e updates
> > > > +          when files are created, deleted, or renamed on the serve=
r.
> > > > +
> > > > +          This feature maintains persistent connections to track c=
hanges.
> > > > +          Each monitored directory consumes server resources and m=
ay increase
> > > > +          network traffic.
> > > > +
> > > > +          Say Y here if you want real-time directory monitoring.
> > > > +          If unsure, say N.
> > > > +
> > > >  endif
> > > > diff --git a/fs/smb/client/Makefile b/fs/smb/client/Makefile
> > > > index 4c97b31a25c2..85253bc1b4b0 100644
> > > > --- a/fs/smb/client/Makefile
> > > > +++ b/fs/smb/client/Makefile
> > > > @@ -35,3 +35,5 @@ cifs-$(CONFIG_CIFS_ROOT) +=3D cifsroot.o
> > > >  cifs-$(CONFIG_CIFS_ALLOW_INSECURE_LEGACY) +=3D smb1ops.o cifssmb.o=
 cifstransport.o
> > > >
> > > >  cifs-$(CONFIG_CIFS_COMPRESSION) +=3D compress.o compress/lz77.o
> > > > +
> > > > +cifs-$(CONFIG_CIFS_DIR_CHANGE_TRACKING) +=3D notify.o
> > > > diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
> > > > index dd12f3eb61dc..eebf729df16a 100644
> > > > --- a/fs/smb/client/connect.c
> > > > +++ b/fs/smb/client/connect.c
> > > > @@ -51,6 +51,9 @@
> > > >  #endif
> > > >  #include "fs_context.h"
> > > >  #include "cifs_swn.h"
> > > > +#ifdef CONFIG_CIFS_DIR_CHANGE_TRACKING
> > > > +#include "notify.h"
> > > > +#endif
> > > >
> > > >  /* FIXME: should these be tunable? */
> > > >  #define TLINK_ERROR_EXPIRE     (1 * HZ)
> > > > @@ -4154,6 +4157,9 @@ cifs_umount(struct cifs_sb_info *cifs_sb)
> > > >         cancel_delayed_work_sync(&cifs_sb->prune_tlinks);
> > > >
> > > >         if (cifs_sb->master_tlink) {
> > > > +#ifdef CONFIG_CIFS_DIR_CHANGE_TRACKING
> > > > +               stop_track_sb_dir_changes(cifs_sb);
> > > > +#endif
> > > >                 tcon =3D cifs_sb->master_tlink->tl_tcon;
> > > >                 if (tcon) {
> > > >                         spin_lock(&tcon->sb_list_lock);
> > > > diff --git a/fs/smb/client/notify.c b/fs/smb/client/notify.c
> > > > new file mode 100644
> > > > index 000000000000..e38345965744
> > > > --- /dev/null
> > > > +++ b/fs/smb/client/notify.c
> > > > @@ -0,0 +1,535 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Directory change notification tracking for SMB
> > > > + *
> > > > + * Copyright (c) 2025, Sang-Heon Jeon <ekffu200098@gmail.com>
> > > > + *
> > > > + * References:
> > > > + * MS-SMB2 "2.2.35 SMB2 CHANGE_NOTIFY Request"
> > > > + * MS-SMB2 "2.2.36 SMB2 CHANGE_NOTIFY Response"
> > > > + * MS-SMB2 "2.7.1 FILE_NOTIFY_INFORMATION"
> > > > + * MS-SMB2 "3.3.5.19 Receiving and SMB2 CHANGE_NOTIFY Request"
> > > > + * MS-FSCC "2.6 File Attributes"
> > > > + */
> > > > +
> > > > +#include <linux/list.h>
> > > > +#include <linux/slab.h>
> > > > +#include <linux/fsnotify.h>
> > > > +#include "notify.h"
> > > > +#include "cifsproto.h"
> > > > +#include "smb2proto.h"
> > > > +#include "cached_dir.h"
> > > > +#include "cifs_debug.h"
> > > > +#include "cifspdu.h"
> > > > +#include "cifs_unicode.h"
> > > > +#include "../common/smb2pdu.h"
> > > > +#include "../common/smb2status.h"
> > > > +
> > > > +#define CLEANUP_INTERVAL (30 * HZ)
> > > > +#define CLEANUP_IMMEDIATE 0
> > > > +
> > > > +enum notify_state {
> > > > +       NOTIFY_STATE_RECONNECT =3D BIT(0),
> > > > +       NOTIFY_STATE_UMOUNT =3D BIT(1),
> > > > +       NOTIFY_STATE_NOMASK =3D BIT(2),
> > > > +       NOTIFY_STATE_BROKEN_REQ =3D BIT(3),
> > > > +       NOTIFY_STATE_BROKEN_RSP =3D BIT(4),
> > > > +};
> > > > +
> > > > +struct notify_info {
> > > > +       struct inode *inode;
> > > > +       const char *path;
> > > > +       __le16 *utf16_path;
> > > > +       struct cifs_fid cifs_fid;
> > > > +       atomic_t state;
> > > > +       struct list_head list;
> > > > +};
> > > > +
> > > > +static int request_change_notify(struct notify_info *info);
> > > > +static void notify_cleanup_worker(struct work_struct *work);
> > > > +
> > > > +static LIST_HEAD(notify_list);
> > > > +static DEFINE_SPINLOCK(notify_list_lock);
> > > > +static DECLARE_DELAYED_WORK(notify_cleanup_work, notify_cleanup_wo=
rker);
> > > > +
> > > > +static bool is_resumeable(struct notify_info *info)
> > > > +{
> > > > +       return atomic_read(&info->state) =3D=3D NOTIFY_STATE_RECONN=
ECT;
> > > > +}
> > > > +
> > > > +static bool is_active(struct notify_info *info)
> > > > +{
> > > > +       return atomic_read(&info->state) =3D=3D 0;
> > > > +}
> > > > +
> > > > +static void set_state(struct notify_info *info, int state)
> > > > +{
> > > > +       atomic_or(state, &info->state);
> > > > +       if (!is_resumeable(info))
> > > > +               mod_delayed_work(cifsiod_wq, &notify_cleanup_work,
> > > > +                       CLEANUP_IMMEDIATE);
> > > > +}
> > > > +
> > > > +static void clear_state(struct notify_info *info, int state)
> > > > +{
> > > > +       atomic_and(~state, &info->state);
> > > > +}
> > > > +
> > > > +static int fsnotify_send(__u32 mask,
> > > > +                        struct inode *parent,
> > > > +                        struct file_notify_information *fni,
> > > > +                        u32 cookie)
> > > > +{
> > > > +       char *name =3D cifs_strndup_from_utf16(fni->FileName,
> > > > +                               le32_to_cpu(fni->FileNameLength), t=
rue,
> > > > +                               CIFS_SB(parent->i_sb)->local_nls);
> > > > +       struct qstr qstr;
> > > > +       int rc =3D 0;
> > > > +
> > > > +       if (!name)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       qstr.name =3D (const unsigned char *)name;
> > > > +       qstr.len =3D strlen(name);
> > > > +
> > > > +       rc =3D fsnotify_name(mask, NULL, FSNOTIFY_EVENT_NONE, paren=
t,
> > > > +                       &qstr, cookie);
> > > > +       cifs_dbg(FYI, "fsnotify mask=3D%u, name=3D%s, cookie=3D%u, =
w/return=3D%d",
> > > > +               mask, name, cookie, rc);
> > > > +       kfree(name);
> > > > +       return rc;
> > > > +}
> > > > +
> > > > +static bool is_fsnotify_masked(struct inode *inode)
> > > > +{
> > > > +       if (!inode)
> > > > +               return false;
> > > > +
> > > > +       /* Minimal validation of file explore inotify */
> > > > +       return inode->i_fsnotify_mask &
> > > > +               (FS_CREATE | FS_DELETE | FS_MOVED_FROM | FS_MOVED_T=
O);
> > > > +}
> > > > +
> > > > +static void handle_file_notify_information(struct notify_info *inf=
o,
> > > > +                                          char *buf,
> > > > +                                          unsigned int buf_len)
> > > > +{
> > > > +       struct file_notify_information *fni;
> > > > +       unsigned int next_entry_offset;
> > > > +       u32 cookie;
> > > > +       bool has_cookie =3D false;
> > > > +
> > > > +       do {
> > > > +               fni =3D (struct file_notify_information *)buf;
> > > > +               next_entry_offset =3D le32_to_cpu(fni->NextEntryOff=
set);
> > > > +               if (next_entry_offset > buf_len) {
> > > > +                       cifs_dbg(FYI, "invalid fni->NextEntryOffset=
=3D%u",
> > > > +                               next_entry_offset);
> > > > +                       break;
> > > > +               }
> > > > +
> > > > +               switch (le32_to_cpu(fni->Action)) {
> > > > +               case FILE_ACTION_ADDED:
> > > > +                       fsnotify_send(FS_CREATE, info->inode, fni, =
0);
> > > > +                       break;
> > > > +               case FILE_ACTION_REMOVED:
> > > > +                       fsnotify_send(FS_DELETE, info->inode, fni, =
0);
> > > > +                       break;
> > > > +               case FILE_ACTION_RENAMED_OLD_NAME:
> > > > +                       if (!has_cookie)
> > > > +                               cookie =3D fsnotify_get_cookie();
> > > > +                       has_cookie =3D !has_cookie;
> > > > +                       fsnotify_send(FS_MOVED_FROM, info->inode, f=
ni, cookie);
> > > > +                       break;
> > > > +               case FILE_ACTION_RENAMED_NEW_NAME:
> > > > +                       if (!has_cookie)
> > > > +                               cookie =3D fsnotify_get_cookie();
> > > > +                       has_cookie =3D !has_cookie;
> > > > +                       fsnotify_send(FS_MOVED_TO, info->inode, fni=
, cookie);
> > > > +                       break;
> > > > +               default:
> > > > +                       /* Does not occur, so no need to handle */
> > > > +                       break;
> > > > +               }
> > > > +
> > > > +               buf +=3D next_entry_offset;
> > > > +               buf_len -=3D next_entry_offset;
> > > > +       } while (buf_len > 0 && next_entry_offset > 0);
> > > > +}
> > > > +
> > > > +static void handle_smb2_change_notify_rsp(struct notify_info *info=
,
> > > > +                                         struct mid_q_entry *mid)
> > > > +{
> > > > +       struct smb2_change_notify_rsp *rsp =3D mid->resp_buf;
> > > > +       struct kvec rsp_iov;
> > > > +       unsigned int buf_offset, buf_len;
> > > > +       int rc;
> > > > +
> > > > +       switch (rsp->hdr.Status) {
> > > > +       case STATUS_SUCCESS:
> > > > +               break;
> > > > +       case STATUS_NOTIFY_ENUM_DIR:
> > > > +               goto proceed;
> > > > +       case STATUS_USER_SESSION_DELETED:
> > > > +       case STATUS_NETWORK_NAME_DELETED:
> > > > +       case STATUS_NETWORK_SESSION_EXPIRED:
> > > > +               set_state(info, NOTIFY_STATE_RECONNECT);
> > > > +               return;
> > > > +       default:
> > > > +               set_state(info, NOTIFY_STATE_BROKEN_RSP);
> > > > +               return;
> > > > +       }
> > > > +
> > > > +       rsp_iov.iov_base =3D mid->resp_buf;
> > > > +       rsp_iov.iov_len =3D mid->resp_buf_size;
> > > > +       buf_offset =3D le16_to_cpu(rsp->OutputBufferOffset);
> > > > +       buf_len =3D le32_to_cpu(rsp->OutputBufferLength);
> > > > +
> > > > +       rc =3D smb2_validate_iov(buf_offset, buf_len, &rsp_iov,
> > > > +                               sizeof(struct file_notify_informati=
on));
> > > > +       if (rc) {
> > > > +               cifs_dbg(FYI, "stay tracking, w/smb2_validate_iov=
=3D%d", rc);
> > > > +               goto proceed;
> > > > +       }
> > > > +
> > > > +       handle_file_notify_information(info,
> > > > +               (char *)rsp + buf_offset, buf_len);
> > > > +proceed:
> > > > +       request_change_notify(info);
> > > > +       return;
> > > > +}
> > > > +
> > > > +static void change_notify_callback(struct mid_q_entry *mid)
> > > > +{
> > > > +       struct notify_info *info =3D mid->callback_data;
> > > > +
> > > > +       if (!is_active(info))
> > > > +               return;
> > > > +
> > > > +       if (!is_fsnotify_masked(info->inode)) {
> > > > +               set_state(info, NOTIFY_STATE_NOMASK);
> > > > +               return;
> > > > +       }
> > > > +
> > > > +       if (!mid->resp_buf) {
> > > > +               if (mid->mid_state !=3D MID_RETRY_NEEDED) {
> > > > +                       cifs_dbg(FYI, "stop tracking, w/mid_state=
=3D%d",
> > > > +                               mid->mid_state);
> > > > +                       set_state(info, NOTIFY_STATE_BROKEN_RSP);
> > > > +                       return;
> > > > +               }
> > > > +
> > > > +               set_state(info, NOTIFY_STATE_RECONNECT);
> > > > +               return;
> > > > +       }
> > > > +
> > > > +       handle_smb2_change_notify_rsp(info, mid);
> > > > +}
> > > > +
> > > > +static int request_change_notify(struct notify_info *info)
> > > > +{
> > > > +       struct cifs_sb_info *cifs_sb =3D CIFS_SB(info->inode->i_sb)=
;
> > > > +       struct cifs_tcon *tcon =3D cifs_sb_master_tcon(cifs_sb);
> > > > +       struct smb_rqst rqst;
> > > > +       struct kvec iov[1];
> > > > +       unsigned int xid;
> > > > +       int rc;
> > > > +
> > > > +       if (!tcon) {
> > > > +               cifs_dbg(FYI, "missing tcon while request change no=
tify");
> > > > +               return -EINVAL;
> > > > +       }
> > > > +
> > > > +       memset(&rqst, 0, sizeof(struct smb_rqst));
> > > > +       memset(&iov, 0, sizeof(iov));
> > > > +       rqst.rq_iov =3D iov;
> > > > +       rqst.rq_nvec =3D 1;
> > > > +
> > > > +       xid =3D get_xid();
> > > > +       rc =3D SMB2_notify_init(xid, &rqst, tcon, tcon->ses->server=
,
> > > > +               info->cifs_fid.persistent_fid, info->cifs_fid.volat=
ile_fid,
> > > > +               FILE_NOTIFY_CHANGE_FILE_NAME | FILE_NOTIFY_CHANGE_D=
IR_NAME,
> > > > +               false);
> > > > +       free_xid(xid);
> > > > +       if (rc) {
> > > > +               set_state(info, NOTIFY_STATE_BROKEN_REQ);
> > > > +               return rc;
> > > > +       }
> > > > +
> > > > +       rc =3D cifs_call_async(tcon->ses->server, &rqst, NULL,
> > > > +               change_notify_callback, NULL, info, 0, NULL);
> > > > +       cifs_small_buf_release(rqst.rq_iov[0].iov_base);
> > > > +
> > > > +       if (rc)
> > > > +               set_state(info, NOTIFY_STATE_BROKEN_REQ);
> > > > +       return rc;
> > > > +}
> > > > +
> > > > +
> > > > +static void free_notify_info(struct notify_info *info)
> > > > +{
> > > > +       kfree(info->utf16_path);
> > > > +       kfree(info->path);
> > > > +       kfree(info);
> > > > +}
> > > > +
> > > > +static void cleanup_pending_mid(struct notify_info *info,
> > > > +                               struct cifs_tcon *tcon)
> > > > +{
> > > > +       LIST_HEAD(dispose_list);
> > > > +       struct TCP_Server_Info *server;
> > > > +       struct mid_q_entry *mid, *nmid;
> > > > +
> > > > +       if (!tcon->ses || !tcon->ses->server)
> > > > +               return;
> > > > +
> > > > +       server =3D tcon->ses->server;
> > > > +
> > > > +       spin_lock(&server->mid_queue_lock);
> > > > +       list_for_each_entry_safe(mid, nmid, &server->pending_mid_q,=
 qhead) {
> > > > +               if (mid->callback_data =3D=3D info) {
> > > > +                       mid->deleted_from_q =3D true;
> > > > +                       list_move(&mid->qhead, &dispose_list);
> > > > +               }
> > > > +       }
> > > > +       spin_unlock(&server->mid_queue_lock);
> > > > +
> > > > +       list_for_each_entry_safe(mid, nmid, &dispose_list, qhead) {
> > > > +               list_del_init(&mid->qhead);
> > > > +               release_mid(mid);
> > > > +       }
> > > > +}
> > > > +
> > > > +static void close_fid(struct notify_info *info)
> > > > +{
> > > > +       struct cifs_tcon *tcon;
> > > > +
> > > > +       unsigned int xid;
> > > > +       int rc;
> > > > +
> > > > +       if (!info->cifs_fid.persistent_fid && !info->cifs_fid.volat=
ile_fid)
> > > > +               return;
> > > > +
> > > > +       tcon =3D cifs_sb_master_tcon(CIFS_SB(info->inode->i_sb));
> > > > +       if (!tcon) {
> > > > +               cifs_dbg(FYI, "missing master tcon while close");
> > > > +               return;
> > > > +       }
> > > > +
> > > > +       xid =3D get_xid();
> > > > +       rc =3D SMB2_close(xid, tcon, info->cifs_fid.persistent_fid,
> > > > +               info->cifs_fid.volatile_fid);
> > > > +       if (rc) {
> > > > +               cifs_dbg(FYI, "cleanup pending mid, w/SMB2_close=3D=
%d", rc);
> > > > +               cleanup_pending_mid(info, tcon);
> > > > +       }
> > > > +       free_xid(xid);
> > > > +}
> > > > +
> > > > +static int setup_fid(struct notify_info *info)
> > > > +{
> > > > +       struct cifs_sb_info *cifs_sb =3D CIFS_SB(info->inode->i_sb)=
;
> > > > +       struct cifs_tcon *tcon =3D cifs_sb_master_tcon(cifs_sb);
> > > > +       struct cifs_open_parms oparms;
> > > > +       __u8 oplock =3D 0;
> > > > +       unsigned int xid;
> > > > +       int rc =3D 0;
> > > > +
> > > > +       if (!tcon) {
> > > > +               cifs_dbg(FYI, "missing master tcon while open");
> > > > +               return -EINVAL;
> > > > +       }
> > > > +
> > > > +       xid =3D get_xid();
> > > > +       oparms =3D (struct cifs_open_parms) {
> > > > +               .tcon =3D tcon,
> > > > +               .path =3D info->path,
> > > > +               .desired_access =3D GENERIC_READ,
> > > > +               .disposition =3D FILE_OPEN,
> > > > +               .create_options =3D cifs_create_options(cifs_sb, 0)=
,
> > > > +               .fid =3D &info->cifs_fid,
> > > > +               .cifs_sb =3D cifs_sb,
> > > > +               .reconnect =3D false,
> > > > +       };
> > > > +       rc =3D SMB2_open(xid, &oparms, info->utf16_path, &oplock,
> > > > +                       NULL, NULL, NULL, NULL);
> > > > +       free_xid(xid);
> > > > +       return rc;
> > > > +}
> > > > +
> > > > +static bool is_already_tracking(struct inode *dir_inode)
> > > > +{
> > > > +       struct notify_info *entry, *nentry;
> > > > +
> > > > +       spin_lock(&notify_list_lock);
> > > > +       list_for_each_entry_safe(entry, nentry, &notify_list, list)=
 {
> > > > +               if (is_active(entry)) {
> > > > +                       if (entry->inode =3D=3D dir_inode) {
> > > > +                               spin_unlock(&notify_list_lock);
> > > > +                               return true;
> > > > +                       }
> > > > +
> > > > +                       /* Extra check since we must keep iterating=
 */
> > > > +                       if (!is_fsnotify_masked(entry->inode))
> > > > +                               set_state(entry, NOTIFY_STATE_NOMAS=
K);
> > > > +               }
> > > > +       }
> > > > +       spin_unlock(&notify_list_lock);
> > > > +
> > > > +       return false;
> > > > +}
> > > > +
> > > > +static bool is_tracking_supported(struct cifs_sb_info *cifs_sb)
> > > > +{
> > > > +       struct cifs_tcon *tcon =3D cifs_sb_master_tcon(cifs_sb);
> > > > +
> > > > +       if (!tcon->ses || !tcon->ses->server)
> > > > +               return false;
> > > > +       return tcon->ses->server->dialect >=3D SMB20_PROT_ID;
> > > > +}
> > > > +
> > > > +int start_track_dir_changes(const char *path,
> > > > +                           struct inode *dir_inode,
> > > > +                           struct cifs_sb_info *cifs_sb)
> > > > +{
> > > > +       struct notify_info *info;
> > > > +       int rc;
> > > > +
> > > > +       if (!is_tracking_supported(cifs_sb))
> > > > +               return -EINVAL;
> > > > +
> > > > +       if (!is_fsnotify_masked(dir_inode))
> > > > +               return -EINVAL;
> > > > +
> > > > +       if (is_already_tracking(dir_inode))
> > > > +               return 1;
> > > > +
> > > > +       info =3D kzalloc(sizeof(*info), GFP_KERNEL);
> > > > +       if (!info)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       info->path =3D kstrdup(path, GFP_KERNEL);
> > > > +       if (!info->path) {
> > > > +               free_notify_info(info);
> > > > +               return -ENOMEM;
> > > > +       }
> > > > +       info->utf16_path =3D cifs_convert_path_to_utf16(path, cifs_=
sb);
> > > > +       if (!info->utf16_path) {
> > > > +               free_notify_info(info);
> > > > +               return -ENOMEM;
> > > > +       }
> > > > +       info->inode =3D dir_inode;
> > > > +
> > > > +       rc =3D setup_fid(info);
> > > > +       if (rc) {
> > > > +               free_notify_info(info);
> > > > +               return rc;
> > > > +       }
> > > > +       rc =3D request_change_notify(info);
> > > > +       if (rc) {
> > > > +               close_fid(info);
> > > > +               free_notify_info(info);
> > > > +               return rc;
> > > > +       }
> > > > +
> > > > +       spin_lock(&notify_list_lock);
> > > > +       list_add(&info->list, &notify_list);
> > > > +       spin_unlock(&notify_list_lock);
> > > > +       return rc;
> > > > +}
> > > > +
> > > > +void stop_track_sb_dir_changes(struct cifs_sb_info *cifs_sb)
> > > > +{
> > > > +       struct notify_info *entry, *nentry;
> > > > +
> > > > +       if (!list_empty(&notify_list)) {
> > > > +               spin_lock(&notify_list_lock);
> > > > +               list_for_each_entry_safe(entry, nentry, &notify_lis=
t, list) {
> > > > +                       if (cifs_sb =3D=3D CIFS_SB(entry->inode->i_=
sb)) {
> > > > +                               set_state(entry, NOTIFY_STATE_UMOUN=
T);
> > > > +                               continue;
> > > > +                       }
> > > > +
> > > > +                       /* Extra check since we must keep iterating=
 */
> > > > +                       if (!is_fsnotify_masked(entry->inode))
> > > > +                               set_state(entry, NOTIFY_STATE_NOMAS=
K);
> > > > +               }
> > > > +               spin_unlock(&notify_list_lock);
> > > > +       }
> > > > +}
> > > > +
> > > > +void resume_track_dir_changes(void)
> > > > +{
> > > > +       LIST_HEAD(resume_list);
> > > > +       struct notify_info *entry, *nentry;
> > > > +       struct cifs_tcon *tcon;
> > > > +
> > > > +       if (list_empty(&notify_list))
> > > > +               return;
> > > > +
> > > > +       spin_lock(&notify_list_lock);
> > > > +       list_for_each_entry_safe(entry, nentry, &notify_list, list)=
 {
> > > > +               if (!is_fsnotify_masked(entry->inode)) {
> > > > +                       set_state(entry, NOTIFY_STATE_NOMASK);
> > > > +                       continue;
> > > > +               }
> > > > +
> > > > +               if (is_resumeable(entry)) {
> > > > +                       tcon =3D cifs_sb_master_tcon(CIFS_SB(entry-=
>inode->i_sb));
> > > > +                       spin_lock(&tcon->tc_lock);
> > > > +                       if (tcon->status =3D=3D TID_GOOD) {
> > > > +                               spin_unlock(&tcon->tc_lock);
> > > > +                               list_move(&entry->list, &resume_lis=
t);
> > > > +                               continue;
> > > > +                       }
> > > > +                       spin_unlock(&tcon->tc_lock);
> > > > +               }
> > > > +       }
> > > > +       spin_unlock(&notify_list_lock);
> > > > +
> > > > +       list_for_each_entry_safe(entry, nentry, &resume_list, list)=
 {
> > > > +               if (setup_fid(entry)) {
> > > > +                       list_del(&entry->list);
> > > > +                       free_notify_info(entry);
> > > > +                       continue;
> > > > +               }
> > > > +
> > > > +               if (request_change_notify(entry)) {
> > > > +                       list_del(&entry->list);
> > > > +                       close_fid(entry);
> > > > +                       free_notify_info(entry);
> > > > +                       continue;
> > > > +               }
> > > > +
> > > > +               clear_state(entry, NOTIFY_STATE_RECONNECT);
> > > > +       }
> > > > +
> > > > +       if (!list_empty(&resume_list)) {
> > > > +               spin_lock(&notify_list_lock);
> > > > +               list_splice(&resume_list, &notify_list);
> > > > +               spin_unlock(&notify_list_lock);
> > > > +       }
> > > > +}
> > > > +
> > > > +static void notify_cleanup_worker(struct work_struct *work)
> > > > +{
> > > > +       LIST_HEAD(cleanup_list);
> > > > +       struct notify_info *entry, *nentry;
> > > > +
> > > > +       if (list_empty(&notify_list))
> > > > +               return;
> > > > +
> > > > +       spin_lock(&notify_list_lock);
> > > > +       list_for_each_entry_safe(entry, nentry, &notify_list, list)=
 {
> > > > +               if (!is_resumeable(entry) && !is_active(entry))
> > > > +                       list_move(&entry->list, &cleanup_list);
> > > > +       }
> > > > +       spin_unlock(&notify_list_lock);
> > > > +
> > > > +       list_for_each_entry_safe(entry, nentry, &cleanup_list, list=
) {
> > > > +               list_del(&entry->list);
> > > > +               close_fid(entry);
> > > > +               free_notify_info(entry);
> > > > +       }
> > > > +       mod_delayed_work(cifsiod_wq, &notify_cleanup_work, CLEANUP_=
INTERVAL);
> > > > +}
> > > > diff --git a/fs/smb/client/notify.h b/fs/smb/client/notify.h
> > > > new file mode 100644
> > > > index 000000000000..088efba4dce9
> > > > --- /dev/null
> > > > +++ b/fs/smb/client/notify.h
> > > > @@ -0,0 +1,19 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +/*
> > > > + * Directory change notification tracking for SMB
> > > > + *
> > > > + * Copyright (c) 2025, Sang-Heon Jeon <ekffu200098@gmail.com>
> > > > + */
> > > > +
> > > > +#ifndef _SMB_NOTIFY_H
> > > > +#define _SMB_NOTIFY_H
> > > > +
> > > > +#include "cifsglob.h"
> > > > +
> > > > +int start_track_dir_changes(const char *path,
> > > > +                           struct inode *dir_inode,
> > > > +                           struct cifs_sb_info *cifs_sb);
> > > > +void stop_track_sb_dir_changes(struct cifs_sb_info *cifs_sb);
> > > > +void resume_track_dir_changes(void);
> > > > +
> > > > +#endif /* _SMB_NOTIFY_H */
> > > > diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
> > > > index 4e5460206397..455e5be37116 100644
> > > > --- a/fs/smb/client/readdir.c
> > > > +++ b/fs/smb/client/readdir.c
> > > > @@ -24,6 +24,9 @@
> > > >  #include "fs_context.h"
> > > >  #include "cached_dir.h"
> > > >  #include "reparse.h"
> > > > +#ifdef CONFIG_CIFS_DIR_CHANGE_TRACKING
> > > > +#include "notify.h"
> > > > +#endif
> > > >
> > > >  /*
> > > >   * To be safe - for UCS to UTF-8 with strings loaded with the rare=
 long
> > > > @@ -1070,6 +1073,9 @@ int cifs_readdir(struct file *file, struct di=
r_context *ctx)
> > > >         if (rc)
> > > >                 goto cache_not_found;
> > > >
> > > > +#ifdef CONFIG_CIFS_DIR_CHANGE_TRACKING
> > > > +       start_track_dir_changes(full_path, d_inode(file_dentry(file=
)), cifs_sb);
> > > > +#endif
> > > >         mutex_lock(&cfid->dirents.de_mutex);
> > > >         /*
> > > >          * If this was reading from the start of the directory
> > > > @@ -1151,6 +1157,9 @@ int cifs_readdir(struct file *file, struct di=
r_context *ctx)
> > > >                 cifs_dbg(FYI, "Could not find entry\n");
> > > >                 goto rddir2_exit;
> > > >         }
> > > > +#ifdef CONFIG_CIFS_DIR_CHANGE_TRACKING
> > > > +       start_track_dir_changes(full_path, d_inode(file_dentry(file=
)), cifs_sb);
> > > > +#endif
> > > >         cifs_dbg(FYI, "loop through %d times filling dir for net bu=
f %p\n",
> > > >                  num_to_fill, cifsFile->srch_inf.ntwrk_buf_start);
> > > >         max_len =3D tcon->ses->server->ops->calc_smb_size(
> > > > diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> > > > index 4e922cb32110..58a1ddc39ee6 100644
> > > > --- a/fs/smb/client/smb2pdu.c
> > > > +++ b/fs/smb/client/smb2pdu.c
> > > > @@ -45,6 +45,9 @@
> > > >  #include "cached_dir.h"
> > > >  #include "compress.h"
> > > >  #include "fs_context.h"
> > > > +#ifdef CONFIG_CIFS_DIR_CHANGE_TRACKING
> > > > +#include "notify.h"
> > > > +#endif
> > > >
> > > >  /*
> > > >   *  The following table defines the expected "StructureSize" of SM=
B2 requests
> > > > @@ -466,6 +469,9 @@ smb2_reconnect(__le16 smb2_command, struct cifs=
_tcon *tcon,
> > > >                 mod_delayed_work(cifsiod_wq, &server->reconnect, 0)=
;
> > > >
> > > >         atomic_inc(&tconInfoReconnectCount);
> > > > +#ifdef CONFIG_CIFS_DIR_CHANGE_TRACKING
> > > > +       resume_track_dir_changes();
> > > > +#endif
> > > >  out:
> > > >         /*
> > > >          * Check if handle based operation so we know whether we ca=
n continue
> > > > --
> > > > 2.43.0
> > > >
> > >
> > > To Reviewers.
> > >
> > > This is a gentle reminder on review requests.
> > >
> > > I would be very grateful for your feedback and am more than willing t=
o
> > > revise or improve any parts as needed. And also, let me know if I
> > > missed anything or made mistakes.
> >
> > Hi Sang,
>
> Hello, Amir
>
> > First feedback (value):
> > -----------------------------
> > This looks very useful. this feature has been requested and
> > attempted several times in the past (see links below), so if you are
> > willing to incorporate feedback, I hope you will reach further than tho=
se
> > past attempts and I will certainly do my best to help you with that.
>
> Thanks for your kind comment. I'm really glad to hear that.
>
> > Second feedback (reviewers):
> > ----------------------------------------
> > I was very surprised that your patch doesn't touch any vfs code
> > (more on that on design feedback), but this is not an SMB-contained
> > change at all.
>
> I agree with your last comment. I think it might not be easy;
> honestly, I may know less than
> Ioannis or Vivek; but I'm fully committed to giving it a try, no
> matter the challenge.
>
> > Your patch touches the guts of the fsnotify subsystem (in a wrong way).
> > For the next posting please consult the MAINTAINERS entry
> > of the fsnotify subsystem for reviewers and list to CC (now added).
>
> I see. I'll keep it in my mind.
>
> > Third feedback (design):
> > --------------------------------
> > The design choice of polling i_fsnotify_mask on readdir()
> > is quite odd and it is not clear to me why it makes sense.
> > Previous discussions suggested to have a filesystem method
> > to update when applications setup a watch on a directory [1].
> > Another prior feedback was that the API should allow a clear
> > distinction between the REMOTE notifications and the LOCAL
> > notifications [2][3].
>
> Current design choice is a workaround for setting an appropriate add
> watch point (as well as remove). I don't want to stick to the RFC
> design. Also, The point that I considered important is similar to
> Ioannis' one: compatible with existing applications.
>
> > IMO it would be better to finalize the design before working on the
> > code, but that's up to you.
>
> I agree, although it's quite hard to create a perfect blueprint, but
> it might be better to draw to some extent.
>
> Based on my current understanding, I think we need to do the following th=
ings.
> - design more compatible and general fsnotify API for all network fs;
> should process LOCAL and REMOTE both smoothly.
> - expand inotify (if needed, fanotify both) flow with new fsnotify API
> - replace SMB2 change_notify start/end point to new API
>

Yap, that's about it.
All the rest is the details...

> Let me know if I missed or misunderstood something. And also please
> give me some time to read attached threads more deeply and clean up my
> thoughts and questions.
>

Take your time.
It's good to understand the concerns of previous attempts to
avoid hitting the same roadblocks.

Thanks,
Amir.

