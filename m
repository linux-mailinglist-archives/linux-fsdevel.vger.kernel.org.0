Return-Path: <linux-fsdevel+bounces-64411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD96BE6408
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 06:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B66019A7091
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 04:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1135F30BB84;
	Fri, 17 Oct 2025 04:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QF6h4O2m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960CD1C862E
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 04:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760673917; cv=none; b=CptdwrjdTw3EjW3KN9NeNdJYodXvRw2epOQBFa2mmkbm+sA3xC0HEcXqz8JIHR5FYYVdNDVF1j+b/KAOafHgpgpU360aazbfciJW8dk4Eg/DtKS5bqIviUDsbm96qHhOVu2xHoFw2tkOsohfT4spOylBUcvMcH6Y3/iuIoFq6+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760673917; c=relaxed/simple;
	bh=cvQluJV7xIjIxxOskG2eOwcuhqSyW0q2pqZeZeUaSRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGWkgyAdqlI3bjsUjQ0hRRzoOfG5/4UrngT8nkXX748Rjw+qyfKXCyh6vm/ufk7IuYV+lR86cPVX5IV28tEjFzaXI5eK8Nr0KTovl1oIl9GPQT4EsWdKD1b3djtc3jac1cB4hHj5G81sKXkugUf/KUOXL1pQzrssaq0ZdTdePEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QF6h4O2m; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7afbcf24c83so466403a34.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 21:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760673913; x=1761278713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8KuZXcKEHhZfDnYZoZGHNh74mX8QVLT2jYO4Hztxhg=;
        b=QF6h4O2muA6o/8P8pimdoTOUXZtzBizN16wTpp+d/TAds5RHTc/fGzO6X+V9vlvNH/
         7BaZ+UEVanV/e1Op51fc21p27yTDg0Ay1HM5WA9TuQmO9iIfX2fr6sHy/j+X+qnn0qtI
         o19E+fn0LH9pQqJxb7HYyPJ2EvPvmeeVoPxQe75/sMm+gBA2FNwsHaQNjmOD00X0zfI4
         t51EzWRfTo4yEr9Bm8tXvIj3FVrjWT1+4H+EtXphCxJE1KXICB4iSgqUg4ennrJitPg0
         V8aeP4U6laSvrKKqpHu3YuDHVPgWOCOxBNUpVv7o0XEiXlN3WGuZmq0XqvfMa6XYrScz
         CLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760673913; x=1761278713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8KuZXcKEHhZfDnYZoZGHNh74mX8QVLT2jYO4Hztxhg=;
        b=LCSjSDMKKZGKpC3FNhSjYG5cw1NQqQE2HFdTqWbDBaQpe5yDkd9r9dthRBEWkmmNas
         EXcw1QecYbZ1eRyc311Vyntx5ZVToiyOoVmgv/ZLOiYY9gARsiurt0Qkyty5Vaza1Nz/
         Em55Jnemfy2Hg4oTRiuN6EL2uwLWnQAoxAaI+o/YoUlyQ2pX1lJT+Wqj1VPAdj2vnBmV
         LRxtEeOl6bOE1Ym4Z45eO5hJz2ih1XSw/gqpfRGcp7CdW/Z2h8tHeVhlEA6H9h7vlJjl
         1GJ/sfu0/6htXCV+3dPNqluMLpRZPTK14sHgdWxqW+PtuftkEKfykoHcI2/07ZPQrfiE
         9G5g==
X-Forwarded-Encrypted: i=1; AJvYcCUiC7eBwngfS1h9J4Mx8Q7h8w079IQ0DCi2Ut1Q6uOqLuzy7sKG0fVtiZ/ELdzk8FrVbsR6zGpd/24iayfi@vger.kernel.org
X-Gm-Message-State: AOJu0YzdjhdRkCPw5LIPMWFdSHU8swWCa1o0SIXU/TTpwzaGiRa2Lmvl
	MPdsr9CAwKA05QZuIqHLcGyCPCWoGVQI1IjB+kGSdyQzPdCOfIkmOeFSojdDiUo5OxEeD8dQZJ/
	iXnMj1Sa80iF9iCFFUl4V0nE4+qDGdiI=
X-Gm-Gg: ASbGncuLM+foG3ctNKfPhk4I1p+FO7GqRoYHUhKhCkg5mE+9FP0wNYxJn0PwHFgUoBv
	GgCdvBcczaDkES4eIWleEyr9wMiVvCEuqpHKBuSFJixcYdICWargWKRPOJ53PHE7a6UfBnJhjQF
	gS/6yoXpxIlZ1xjDwMS8eVumR4/nuN+bDBV3I8XRK59Mu6YCNfnsOzt2llU1LknoI42Z2PH+mfH
	svIwQ9e9embJjljDWpn9SKOEeM1YObJnhQblX99QGFKKG/pkuLJgjKYSGlfvLmog5de
X-Google-Smtp-Source: AGHT+IElcPbZejHXTmYS0xQgIS+HovOpKnkRLpWl6VewNyKGydqvQs5cTrwgN7EhThWy/eqXScbWnFSAatqS3Zxwpwg=
X-Received: by 2002:a05:6808:2125:b0:441:8f74:f41 with SMTP id
 5614622812f47-443a31675e2mr1156242b6e.59.1760673913196; Thu, 16 Oct 2025
 21:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916133437.713064-1-ekffu200098@gmail.com>
 <20250916133437.713064-3-ekffu200098@gmail.com> <CABFDxMFtZKSr5KbqcGQzJWYwT5URUYeuEHJ1a_jDUQPO-OKVGg@mail.gmail.com>
 <CAOQ4uxgEL=gOpSaSAV_+U=a3W5U5_Uq2Sk4agQhUpL4jHMMQ9w@mail.gmail.com>
 <CABFDxMG8uLaedhFuWHLAqW75a=TFfVEHkm08uwy76B7w9xbr=w@mail.gmail.com> <CAOQ4uxj9BAz6ibV3i57wgZ5ZNY9mvow=6-iJJ7b4pZn4mpgF7A@mail.gmail.com>
In-Reply-To: <CAOQ4uxj9BAz6ibV3i57wgZ5ZNY9mvow=6-iJJ7b4pZn4mpgF7A@mail.gmail.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Fri, 17 Oct 2025 13:05:02 +0900
X-Gm-Features: AS18NWArpJxUwqt_SDWBO0ChRZSnjicjvs1MOkcjWVpw3-v1YoqP4SOAxMB1TQo
Message-ID: <CABFDxMFRhKNENWyqh3Yraq_vDh0P=KxuXA9RcuVPX4FUnhKqGw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] smb: client: add directory change tracking via
 SMB2 Change Notify
To: Amir Goldstein <amir73il@gmail.com>
Cc: sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	linux-cifs@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>, Stef Bon <stefbon@gmail.com>, 
	Ioannis Angelakopoulos <iangelak@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Amir

On Tue, Sep 30, 2025 at 2:06=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Mon, Sep 29, 2025 at 6:51=E2=80=AFPM Sang-Heon Jeon <ekffu200098@gmail=
.com> wrote:
> >
> > On Sat, Sep 27, 2025 at 5:39=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > On Sat, Sep 27, 2025 at 3:03=E2=80=AFAM Sang-Heon Jeon <ekffu200098@g=
mail.com> wrote:
> > > >
> > > > On Tue, Sep 16, 2025 at 10:35=E2=80=AFPM Sang-Heon Jeon <ekffu20009=
8@gmail.com> wrote:
> > > > >
> > > > > Implement directory change tracking using SMB2 Change Notify prot=
ocol
> > > > > to enable real-time monitoring of remote directories. Application=
s using
> > > > > inotify now receive immediate notifications when files are create=
d,
> > > > > deleted, or renamed on SMB2+ shares.
> > > > >
> > > > > This implementation begins by detecting tracking opportunities du=
ring
> > > > > regular SMB operations. In the current version, the readdir() ser=
ves as
> > > > > the detection point - when directory contents are accessed on SMB=
2+
> > > > > servers, we check the inode's fsnotify_mask for active inotify wa=
tches.
> > > > > If watches exist and directory is not already being tracked, we o=
btain a
> > > > > new FiieId and send a SMB2_CHANGE_NOTIFY request that waits for c=
hanges.
> > > > >
> > > > > Based on the server's response status, we convert CHANGE_NOTIFY r=
esponse
> > > > > to fsnotify events and deliver to application on success, mark fo=
r
> > > > > future reconnection on network errors, or discard the response an=
d
> > > > > marked entries for broken. If tracking can continue, we resend
> > > > > SMB2_CHANGE_NOTIFY for continuous monitoring.
> > > > >
> > > > > Entries marked for reconnection are restored during SMB2 reconnec=
tion.
> > > > > In the current version, smb2_reconnect() serves as restoration po=
int -
> > > > > when connection is reestablished, we obtain new FileIds and reque=
st
> > > > > Change Notify requests for these entries.
> > > > >
> > > > > Entries marked for unmount during unmount. In the current version=
,
> > > > > cifs_umount() serves as unmount marking point. Entries marked for=
 clean
> > > > > are remove as soon as possible by the worker. Workers also run
> > > > > periodically; currently every 30s; to check and remove untracking
> > > > > directories.
> > > > >
> > > > > This feature is controlled by CONFIG_CIFS_DIR_CHANGE_TRACKING wit=
h
> > > > > experimental.
> > > > >
> > > > > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > > > > ---
> > > > >  fs/smb/client/Kconfig   |  17 ++
> > > > >  fs/smb/client/Makefile  |   2 +
> > > > >  fs/smb/client/connect.c |   6 +
> > > > >  fs/smb/client/notify.c  | 535 ++++++++++++++++++++++++++++++++++=
++++++
> > > > >  fs/smb/client/notify.h  |  19 ++
> > > > >  fs/smb/client/readdir.c |   9 +
> > > > >  fs/smb/client/smb2pdu.c |   6 +
> > > > >  7 files changed, 594 insertions(+)
> > > > >  create mode 100644 fs/smb/client/notify.c
> > > > >  create mode 100644 fs/smb/client/notify.h
> > > > >
> > > > > diff --git a/fs/smb/client/Kconfig b/fs/smb/client/Kconfig
> > > > > index a4c02199fef4..0e3911936e0c 100644
> > > > > --- a/fs/smb/client/Kconfig
> > > > > +++ b/fs/smb/client/Kconfig
> > > > > @@ -218,4 +218,21 @@ config CIFS_COMPRESSION
> > > > >           Say Y here if you want SMB traffic to be compressed.
> > > > >           If unsure, say N.
> > > > >
> > > > > ++config CIFS_DIR_CHANGE_TRACKING
> > > >
> > > > I also found a typo here and I'll fix them.
> > > >
> > > > > +       bool "Directory change tracking (Experimental)"
> > > > > +       depends on CIFS && FSNOTIFY=3Dy
> > > > > +       default n
> > > > > +       help
> > > > > +          Enables automatic tracking of directory changes for SM=
B2 or later
> > > > > +          using the SMB2 Change Notify protocol. File managers a=
nd applications
> > > > > +          monitoring directories via inotify will receive real-t=
ime updates
> > > > > +          when files are created, deleted, or renamed on the ser=
ver.
> > > > > +
> > > > > +          This feature maintains persistent connections to track=
 changes.
> > > > > +          Each monitored directory consumes server resources and=
 may increase
> > > > > +          network traffic.
> > > > > +
> > > > > +          Say Y here if you want real-time directory monitoring.
> > > > > +          If unsure, say N.
> > > > > +
> > > > >  endif
> > > > > diff --git a/fs/smb/client/Makefile b/fs/smb/client/Makefile
> > > > > index 4c97b31a25c2..85253bc1b4b0 100644
> > > > > --- a/fs/smb/client/Makefile
> > > > > +++ b/fs/smb/client/Makefile
> > > > > @@ -35,3 +35,5 @@ cifs-$(CONFIG_CIFS_ROOT) +=3D cifsroot.o
> > > > >  cifs-$(CONFIG_CIFS_ALLOW_INSECURE_LEGACY) +=3D smb1ops.o cifssmb=
.o cifstransport.o
> > > > >
> > > > >  cifs-$(CONFIG_CIFS_COMPRESSION) +=3D compress.o compress/lz77.o
> > > > > +
> > > > > +cifs-$(CONFIG_CIFS_DIR_CHANGE_TRACKING) +=3D notify.o
> > > > > diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
> > > > > index dd12f3eb61dc..eebf729df16a 100644
> > > > > --- a/fs/smb/client/connect.c
> > > > > +++ b/fs/smb/client/connect.c
> > > > > @@ -51,6 +51,9 @@
> > > > >  #endif
> > > > >  #include "fs_context.h"
> > > > >  #include "cifs_swn.h"
> > > > > +#ifdef CONFIG_CIFS_DIR_CHANGE_TRACKING
> > > > > +#include "notify.h"
> > > > > +#endif
> > > > >
> > > > >  /* FIXME: should these be tunable? */
> > > > >  #define TLINK_ERROR_EXPIRE     (1 * HZ)
> > > > > @@ -4154,6 +4157,9 @@ cifs_umount(struct cifs_sb_info *cifs_sb)
> > > > >         cancel_delayed_work_sync(&cifs_sb->prune_tlinks);
> > > > >
> > > > >         if (cifs_sb->master_tlink) {
> > > > > +#ifdef CONFIG_CIFS_DIR_CHANGE_TRACKING
> > > > > +               stop_track_sb_dir_changes(cifs_sb);
> > > > > +#endif
> > > > >                 tcon =3D cifs_sb->master_tlink->tl_tcon;
> > > > >                 if (tcon) {
> > > > >                         spin_lock(&tcon->sb_list_lock);
> > > > > diff --git a/fs/smb/client/notify.c b/fs/smb/client/notify.c
> > > > > new file mode 100644
> > > > > index 000000000000..e38345965744
> > > > > --- /dev/null
> > > > > +++ b/fs/smb/client/notify.c
> > > > > @@ -0,0 +1,535 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Directory change notification tracking for SMB
> > > > > + *
> > > > > + * Copyright (c) 2025, Sang-Heon Jeon <ekffu200098@gmail.com>
> > > > > + *
> > > > > + * References:
> > > > > + * MS-SMB2 "2.2.35 SMB2 CHANGE_NOTIFY Request"
> > > > > + * MS-SMB2 "2.2.36 SMB2 CHANGE_NOTIFY Response"
> > > > > + * MS-SMB2 "2.7.1 FILE_NOTIFY_INFORMATION"
> > > > > + * MS-SMB2 "3.3.5.19 Receiving and SMB2 CHANGE_NOTIFY Request"
> > > > > + * MS-FSCC "2.6 File Attributes"
> > > > > + */
> > > > > +
> > > > > +#include <linux/list.h>
> > > > > +#include <linux/slab.h>
> > > > > +#include <linux/fsnotify.h>
> > > > > +#include "notify.h"
> > > > > +#include "cifsproto.h"
> > > > > +#include "smb2proto.h"
> > > > > +#include "cached_dir.h"
> > > > > +#include "cifs_debug.h"
> > > > > +#include "cifspdu.h"
> > > > > +#include "cifs_unicode.h"
> > > > > +#include "../common/smb2pdu.h"
> > > > > +#include "../common/smb2status.h"
> > > > > +
> > > > > +#define CLEANUP_INTERVAL (30 * HZ)
> > > > > +#define CLEANUP_IMMEDIATE 0
> > > > > +
> > > > > +enum notify_state {
> > > > > +       NOTIFY_STATE_RECONNECT =3D BIT(0),
> > > > > +       NOTIFY_STATE_UMOUNT =3D BIT(1),
> > > > > +       NOTIFY_STATE_NOMASK =3D BIT(2),
> > > > > +       NOTIFY_STATE_BROKEN_REQ =3D BIT(3),
> > > > > +       NOTIFY_STATE_BROKEN_RSP =3D BIT(4),
> > > > > +};
> > > > > +
> > > > > +struct notify_info {
> > > > > +       struct inode *inode;
> > > > > +       const char *path;
> > > > > +       __le16 *utf16_path;
> > > > > +       struct cifs_fid cifs_fid;
> > > > > +       atomic_t state;
> > > > > +       struct list_head list;
> > > > > +};
> > > > > +
> > > > > +static int request_change_notify(struct notify_info *info);
> > > > > +static void notify_cleanup_worker(struct work_struct *work);
> > > > > +
> > > > > +static LIST_HEAD(notify_list);
> > > > > +static DEFINE_SPINLOCK(notify_list_lock);
> > > > > +static DECLARE_DELAYED_WORK(notify_cleanup_work, notify_cleanup_=
worker);
> > > > > +
> > > > > +static bool is_resumeable(struct notify_info *info)
> > > > > +{
> > > > > +       return atomic_read(&info->state) =3D=3D NOTIFY_STATE_RECO=
NNECT;
> > > > > +}
> > > > > +
> > > > > +static bool is_active(struct notify_info *info)
> > > > > +{
> > > > > +       return atomic_read(&info->state) =3D=3D 0;
> > > > > +}
> > > > > +
> > > > > +static void set_state(struct notify_info *info, int state)
> > > > > +{
> > > > > +       atomic_or(state, &info->state);
> > > > > +       if (!is_resumeable(info))
> > > > > +               mod_delayed_work(cifsiod_wq, &notify_cleanup_work=
,
> > > > > +                       CLEANUP_IMMEDIATE);
> > > > > +}
> > > > > +
> > > > > +static void clear_state(struct notify_info *info, int state)
> > > > > +{
> > > > > +       atomic_and(~state, &info->state);
> > > > > +}
> > > > > +
> > > > > +static int fsnotify_send(__u32 mask,
> > > > > +                        struct inode *parent,
> > > > > +                        struct file_notify_information *fni,
> > > > > +                        u32 cookie)
> > > > > +{
> > > > > +       char *name =3D cifs_strndup_from_utf16(fni->FileName,
> > > > > +                               le32_to_cpu(fni->FileNameLength),=
 true,
> > > > > +                               CIFS_SB(parent->i_sb)->local_nls)=
;
> > > > > +       struct qstr qstr;
> > > > > +       int rc =3D 0;
> > > > > +
> > > > > +       if (!name)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       qstr.name =3D (const unsigned char *)name;
> > > > > +       qstr.len =3D strlen(name);
> > > > > +
> > > > > +       rc =3D fsnotify_name(mask, NULL, FSNOTIFY_EVENT_NONE, par=
ent,
> > > > > +                       &qstr, cookie);
> > > > > +       cifs_dbg(FYI, "fsnotify mask=3D%u, name=3D%s, cookie=3D%u=
, w/return=3D%d",
> > > > > +               mask, name, cookie, rc);
> > > > > +       kfree(name);
> > > > > +       return rc;
> > > > > +}
> > > > > +
> > > > > +static bool is_fsnotify_masked(struct inode *inode)
> > > > > +{
> > > > > +       if (!inode)
> > > > > +               return false;
> > > > > +
> > > > > +       /* Minimal validation of file explore inotify */
> > > > > +       return inode->i_fsnotify_mask &
> > > > > +               (FS_CREATE | FS_DELETE | FS_MOVED_FROM | FS_MOVED=
_TO);
> > > > > +}
> > > > > +
> > > > > +static void handle_file_notify_information(struct notify_info *i=
nfo,
> > > > > +                                          char *buf,
> > > > > +                                          unsigned int buf_len)
> > > > > +{
> > > > > +       struct file_notify_information *fni;
> > > > > +       unsigned int next_entry_offset;
> > > > > +       u32 cookie;
> > > > > +       bool has_cookie =3D false;
> > > > > +
> > > > > +       do {
> > > > > +               fni =3D (struct file_notify_information *)buf;
> > > > > +               next_entry_offset =3D le32_to_cpu(fni->NextEntryO=
ffset);
> > > > > +               if (next_entry_offset > buf_len) {
> > > > > +                       cifs_dbg(FYI, "invalid fni->NextEntryOffs=
et=3D%u",
> > > > > +                               next_entry_offset);
> > > > > +                       break;
> > > > > +               }
> > > > > +
> > > > > +               switch (le32_to_cpu(fni->Action)) {
> > > > > +               case FILE_ACTION_ADDED:
> > > > > +                       fsnotify_send(FS_CREATE, info->inode, fni=
, 0);
> > > > > +                       break;
> > > > > +               case FILE_ACTION_REMOVED:
> > > > > +                       fsnotify_send(FS_DELETE, info->inode, fni=
, 0);
> > > > > +                       break;
> > > > > +               case FILE_ACTION_RENAMED_OLD_NAME:
> > > > > +                       if (!has_cookie)
> > > > > +                               cookie =3D fsnotify_get_cookie();
> > > > > +                       has_cookie =3D !has_cookie;
> > > > > +                       fsnotify_send(FS_MOVED_FROM, info->inode,=
 fni, cookie);
> > > > > +                       break;
> > > > > +               case FILE_ACTION_RENAMED_NEW_NAME:
> > > > > +                       if (!has_cookie)
> > > > > +                               cookie =3D fsnotify_get_cookie();
> > > > > +                       has_cookie =3D !has_cookie;
> > > > > +                       fsnotify_send(FS_MOVED_TO, info->inode, f=
ni, cookie);
> > > > > +                       break;
> > > > > +               default:
> > > > > +                       /* Does not occur, so no need to handle *=
/
> > > > > +                       break;
> > > > > +               }
> > > > > +
> > > > > +               buf +=3D next_entry_offset;
> > > > > +               buf_len -=3D next_entry_offset;
> > > > > +       } while (buf_len > 0 && next_entry_offset > 0);
> > > > > +}
> > > > > +
> > > > > +static void handle_smb2_change_notify_rsp(struct notify_info *in=
fo,
> > > > > +                                         struct mid_q_entry *mid=
)
> > > > > +{
> > > > > +       struct smb2_change_notify_rsp *rsp =3D mid->resp_buf;
> > > > > +       struct kvec rsp_iov;
> > > > > +       unsigned int buf_offset, buf_len;
> > > > > +       int rc;
> > > > > +
> > > > > +       switch (rsp->hdr.Status) {
> > > > > +       case STATUS_SUCCESS:
> > > > > +               break;
> > > > > +       case STATUS_NOTIFY_ENUM_DIR:
> > > > > +               goto proceed;
> > > > > +       case STATUS_USER_SESSION_DELETED:
> > > > > +       case STATUS_NETWORK_NAME_DELETED:
> > > > > +       case STATUS_NETWORK_SESSION_EXPIRED:
> > > > > +               set_state(info, NOTIFY_STATE_RECONNECT);
> > > > > +               return;
> > > > > +       default:
> > > > > +               set_state(info, NOTIFY_STATE_BROKEN_RSP);
> > > > > +               return;
> > > > > +       }
> > > > > +
> > > > > +       rsp_iov.iov_base =3D mid->resp_buf;
> > > > > +       rsp_iov.iov_len =3D mid->resp_buf_size;
> > > > > +       buf_offset =3D le16_to_cpu(rsp->OutputBufferOffset);
> > > > > +       buf_len =3D le32_to_cpu(rsp->OutputBufferLength);
> > > > > +
> > > > > +       rc =3D smb2_validate_iov(buf_offset, buf_len, &rsp_iov,
> > > > > +                               sizeof(struct file_notify_informa=
tion));
> > > > > +       if (rc) {
> > > > > +               cifs_dbg(FYI, "stay tracking, w/smb2_validate_iov=
=3D%d", rc);
> > > > > +               goto proceed;
> > > > > +       }
> > > > > +
> > > > > +       handle_file_notify_information(info,
> > > > > +               (char *)rsp + buf_offset, buf_len);
> > > > > +proceed:
> > > > > +       request_change_notify(info);
> > > > > +       return;
> > > > > +}
> > > > > +
> > > > > +static void change_notify_callback(struct mid_q_entry *mid)
> > > > > +{
> > > > > +       struct notify_info *info =3D mid->callback_data;
> > > > > +
> > > > > +       if (!is_active(info))
> > > > > +               return;
> > > > > +
> > > > > +       if (!is_fsnotify_masked(info->inode)) {
> > > > > +               set_state(info, NOTIFY_STATE_NOMASK);
> > > > > +               return;
> > > > > +       }
> > > > > +
> > > > > +       if (!mid->resp_buf) {
> > > > > +               if (mid->mid_state !=3D MID_RETRY_NEEDED) {
> > > > > +                       cifs_dbg(FYI, "stop tracking, w/mid_state=
=3D%d",
> > > > > +                               mid->mid_state);
> > > > > +                       set_state(info, NOTIFY_STATE_BROKEN_RSP);
> > > > > +                       return;
> > > > > +               }
> > > > > +
> > > > > +               set_state(info, NOTIFY_STATE_RECONNECT);
> > > > > +               return;
> > > > > +       }
> > > > > +
> > > > > +       handle_smb2_change_notify_rsp(info, mid);
> > > > > +}
> > > > > +
> > > > > +static int request_change_notify(struct notify_info *info)
> > > > > +{
> > > > > +       struct cifs_sb_info *cifs_sb =3D CIFS_SB(info->inode->i_s=
b);
> > > > > +       struct cifs_tcon *tcon =3D cifs_sb_master_tcon(cifs_sb);
> > > > > +       struct smb_rqst rqst;
> > > > > +       struct kvec iov[1];
> > > > > +       unsigned int xid;
> > > > > +       int rc;
> > > > > +
> > > > > +       if (!tcon) {
> > > > > +               cifs_dbg(FYI, "missing tcon while request change =
notify");
> > > > > +               return -EINVAL;
> > > > > +       }
> > > > > +
> > > > > +       memset(&rqst, 0, sizeof(struct smb_rqst));
> > > > > +       memset(&iov, 0, sizeof(iov));
> > > > > +       rqst.rq_iov =3D iov;
> > > > > +       rqst.rq_nvec =3D 1;
> > > > > +
> > > > > +       xid =3D get_xid();
> > > > > +       rc =3D SMB2_notify_init(xid, &rqst, tcon, tcon->ses->serv=
er,
> > > > > +               info->cifs_fid.persistent_fid, info->cifs_fid.vol=
atile_fid,
> > > > > +               FILE_NOTIFY_CHANGE_FILE_NAME | FILE_NOTIFY_CHANGE=
_DIR_NAME,
> > > > > +               false);
> > > > > +       free_xid(xid);
> > > > > +       if (rc) {
> > > > > +               set_state(info, NOTIFY_STATE_BROKEN_REQ);
> > > > > +               return rc;
> > > > > +       }
> > > > > +
> > > > > +       rc =3D cifs_call_async(tcon->ses->server, &rqst, NULL,
> > > > > +               change_notify_callback, NULL, info, 0, NULL);
> > > > > +       cifs_small_buf_release(rqst.rq_iov[0].iov_base);
> > > > > +
> > > > > +       if (rc)
> > > > > +               set_state(info, NOTIFY_STATE_BROKEN_REQ);
> > > > > +       return rc;
> > > > > +}
> > > > > +
> > > > > +
> > > > > +static void free_notify_info(struct notify_info *info)
> > > > > +{
> > > > > +       kfree(info->utf16_path);
> > > > > +       kfree(info->path);
> > > > > +       kfree(info);
> > > > > +}
> > > > > +
> > > > > +static void cleanup_pending_mid(struct notify_info *info,
> > > > > +                               struct cifs_tcon *tcon)
> > > > > +{
> > > > > +       LIST_HEAD(dispose_list);
> > > > > +       struct TCP_Server_Info *server;
> > > > > +       struct mid_q_entry *mid, *nmid;
> > > > > +
> > > > > +       if (!tcon->ses || !tcon->ses->server)
> > > > > +               return;
> > > > > +
> > > > > +       server =3D tcon->ses->server;
> > > > > +
> > > > > +       spin_lock(&server->mid_queue_lock);
> > > > > +       list_for_each_entry_safe(mid, nmid, &server->pending_mid_=
q, qhead) {
> > > > > +               if (mid->callback_data =3D=3D info) {
> > > > > +                       mid->deleted_from_q =3D true;
> > > > > +                       list_move(&mid->qhead, &dispose_list);
> > > > > +               }
> > > > > +       }
> > > > > +       spin_unlock(&server->mid_queue_lock);
> > > > > +
> > > > > +       list_for_each_entry_safe(mid, nmid, &dispose_list, qhead)=
 {
> > > > > +               list_del_init(&mid->qhead);
> > > > > +               release_mid(mid);
> > > > > +       }
> > > > > +}
> > > > > +
> > > > > +static void close_fid(struct notify_info *info)
> > > > > +{
> > > > > +       struct cifs_tcon *tcon;
> > > > > +
> > > > > +       unsigned int xid;
> > > > > +       int rc;
> > > > > +
> > > > > +       if (!info->cifs_fid.persistent_fid && !info->cifs_fid.vol=
atile_fid)
> > > > > +               return;
> > > > > +
> > > > > +       tcon =3D cifs_sb_master_tcon(CIFS_SB(info->inode->i_sb));
> > > > > +       if (!tcon) {
> > > > > +               cifs_dbg(FYI, "missing master tcon while close");
> > > > > +               return;
> > > > > +       }
> > > > > +
> > > > > +       xid =3D get_xid();
> > > > > +       rc =3D SMB2_close(xid, tcon, info->cifs_fid.persistent_fi=
d,
> > > > > +               info->cifs_fid.volatile_fid);
> > > > > +       if (rc) {
> > > > > +               cifs_dbg(FYI, "cleanup pending mid, w/SMB2_close=
=3D%d", rc);
> > > > > +               cleanup_pending_mid(info, tcon);
> > > > > +       }
> > > > > +       free_xid(xid);
> > > > > +}
> > > > > +
> > > > > +static int setup_fid(struct notify_info *info)
> > > > > +{
> > > > > +       struct cifs_sb_info *cifs_sb =3D CIFS_SB(info->inode->i_s=
b);
> > > > > +       struct cifs_tcon *tcon =3D cifs_sb_master_tcon(cifs_sb);
> > > > > +       struct cifs_open_parms oparms;
> > > > > +       __u8 oplock =3D 0;
> > > > > +       unsigned int xid;
> > > > > +       int rc =3D 0;
> > > > > +
> > > > > +       if (!tcon) {
> > > > > +               cifs_dbg(FYI, "missing master tcon while open");
> > > > > +               return -EINVAL;
> > > > > +       }
> > > > > +
> > > > > +       xid =3D get_xid();
> > > > > +       oparms =3D (struct cifs_open_parms) {
> > > > > +               .tcon =3D tcon,
> > > > > +               .path =3D info->path,
> > > > > +               .desired_access =3D GENERIC_READ,
> > > > > +               .disposition =3D FILE_OPEN,
> > > > > +               .create_options =3D cifs_create_options(cifs_sb, =
0),
> > > > > +               .fid =3D &info->cifs_fid,
> > > > > +               .cifs_sb =3D cifs_sb,
> > > > > +               .reconnect =3D false,
> > > > > +       };
> > > > > +       rc =3D SMB2_open(xid, &oparms, info->utf16_path, &oplock,
> > > > > +                       NULL, NULL, NULL, NULL);
> > > > > +       free_xid(xid);
> > > > > +       return rc;
> > > > > +}
> > > > > +
> > > > > +static bool is_already_tracking(struct inode *dir_inode)
> > > > > +{
> > > > > +       struct notify_info *entry, *nentry;
> > > > > +
> > > > > +       spin_lock(&notify_list_lock);
> > > > > +       list_for_each_entry_safe(entry, nentry, &notify_list, lis=
t) {
> > > > > +               if (is_active(entry)) {
> > > > > +                       if (entry->inode =3D=3D dir_inode) {
> > > > > +                               spin_unlock(&notify_list_lock);
> > > > > +                               return true;
> > > > > +                       }
> > > > > +
> > > > > +                       /* Extra check since we must keep iterati=
ng */
> > > > > +                       if (!is_fsnotify_masked(entry->inode))
> > > > > +                               set_state(entry, NOTIFY_STATE_NOM=
ASK);
> > > > > +               }
> > > > > +       }
> > > > > +       spin_unlock(&notify_list_lock);
> > > > > +
> > > > > +       return false;
> > > > > +}
> > > > > +
> > > > > +static bool is_tracking_supported(struct cifs_sb_info *cifs_sb)
> > > > > +{
> > > > > +       struct cifs_tcon *tcon =3D cifs_sb_master_tcon(cifs_sb);
> > > > > +
> > > > > +       if (!tcon->ses || !tcon->ses->server)
> > > > > +               return false;
> > > > > +       return tcon->ses->server->dialect >=3D SMB20_PROT_ID;
> > > > > +}
> > > > > +
> > > > > +int start_track_dir_changes(const char *path,
> > > > > +                           struct inode *dir_inode,
> > > > > +                           struct cifs_sb_info *cifs_sb)
> > > > > +{
> > > > > +       struct notify_info *info;
> > > > > +       int rc;
> > > > > +
> > > > > +       if (!is_tracking_supported(cifs_sb))
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       if (!is_fsnotify_masked(dir_inode))
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       if (is_already_tracking(dir_inode))
> > > > > +               return 1;
> > > > > +
> > > > > +       info =3D kzalloc(sizeof(*info), GFP_KERNEL);
> > > > > +       if (!info)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       info->path =3D kstrdup(path, GFP_KERNEL);
> > > > > +       if (!info->path) {
> > > > > +               free_notify_info(info);
> > > > > +               return -ENOMEM;
> > > > > +       }
> > > > > +       info->utf16_path =3D cifs_convert_path_to_utf16(path, cif=
s_sb);
> > > > > +       if (!info->utf16_path) {
> > > > > +               free_notify_info(info);
> > > > > +               return -ENOMEM;
> > > > > +       }
> > > > > +       info->inode =3D dir_inode;
> > > > > +
> > > > > +       rc =3D setup_fid(info);
> > > > > +       if (rc) {
> > > > > +               free_notify_info(info);
> > > > > +               return rc;
> > > > > +       }
> > > > > +       rc =3D request_change_notify(info);
> > > > > +       if (rc) {
> > > > > +               close_fid(info);
> > > > > +               free_notify_info(info);
> > > > > +               return rc;
> > > > > +       }
> > > > > +
> > > > > +       spin_lock(&notify_list_lock);
> > > > > +       list_add(&info->list, &notify_list);
> > > > > +       spin_unlock(&notify_list_lock);
> > > > > +       return rc;
> > > > > +}
> > > > > +
> > > > > +void stop_track_sb_dir_changes(struct cifs_sb_info *cifs_sb)
> > > > > +{
> > > > > +       struct notify_info *entry, *nentry;
> > > > > +
> > > > > +       if (!list_empty(&notify_list)) {
> > > > > +               spin_lock(&notify_list_lock);
> > > > > +               list_for_each_entry_safe(entry, nentry, &notify_l=
ist, list) {
> > > > > +                       if (cifs_sb =3D=3D CIFS_SB(entry->inode->=
i_sb)) {
> > > > > +                               set_state(entry, NOTIFY_STATE_UMO=
UNT);
> > > > > +                               continue;
> > > > > +                       }
> > > > > +
> > > > > +                       /* Extra check since we must keep iterati=
ng */
> > > > > +                       if (!is_fsnotify_masked(entry->inode))
> > > > > +                               set_state(entry, NOTIFY_STATE_NOM=
ASK);
> > > > > +               }
> > > > > +               spin_unlock(&notify_list_lock);
> > > > > +       }
> > > > > +}
> > > > > +
> > > > > +void resume_track_dir_changes(void)
> > > > > +{
> > > > > +       LIST_HEAD(resume_list);
> > > > > +       struct notify_info *entry, *nentry;
> > > > > +       struct cifs_tcon *tcon;
> > > > > +
> > > > > +       if (list_empty(&notify_list))
> > > > > +               return;
> > > > > +
> > > > > +       spin_lock(&notify_list_lock);
> > > > > +       list_for_each_entry_safe(entry, nentry, &notify_list, lis=
t) {
> > > > > +               if (!is_fsnotify_masked(entry->inode)) {
> > > > > +                       set_state(entry, NOTIFY_STATE_NOMASK);
> > > > > +                       continue;
> > > > > +               }
> > > > > +
> > > > > +               if (is_resumeable(entry)) {
> > > > > +                       tcon =3D cifs_sb_master_tcon(CIFS_SB(entr=
y->inode->i_sb));
> > > > > +                       spin_lock(&tcon->tc_lock);
> > > > > +                       if (tcon->status =3D=3D TID_GOOD) {
> > > > > +                               spin_unlock(&tcon->tc_lock);
> > > > > +                               list_move(&entry->list, &resume_l=
ist);
> > > > > +                               continue;
> > > > > +                       }
> > > > > +                       spin_unlock(&tcon->tc_lock);
> > > > > +               }
> > > > > +       }
> > > > > +       spin_unlock(&notify_list_lock);
> > > > > +
> > > > > +       list_for_each_entry_safe(entry, nentry, &resume_list, lis=
t) {
> > > > > +               if (setup_fid(entry)) {
> > > > > +                       list_del(&entry->list);
> > > > > +                       free_notify_info(entry);
> > > > > +                       continue;
> > > > > +               }
> > > > > +
> > > > > +               if (request_change_notify(entry)) {
> > > > > +                       list_del(&entry->list);
> > > > > +                       close_fid(entry);
> > > > > +                       free_notify_info(entry);
> > > > > +                       continue;
> > > > > +               }
> > > > > +
> > > > > +               clear_state(entry, NOTIFY_STATE_RECONNECT);
> > > > > +       }
> > > > > +
> > > > > +       if (!list_empty(&resume_list)) {
> > > > > +               spin_lock(&notify_list_lock);
> > > > > +               list_splice(&resume_list, &notify_list);
> > > > > +               spin_unlock(&notify_list_lock);
> > > > > +       }
> > > > > +}
> > > > > +
> > > > > +static void notify_cleanup_worker(struct work_struct *work)
> > > > > +{
> > > > > +       LIST_HEAD(cleanup_list);
> > > > > +       struct notify_info *entry, *nentry;
> > > > > +
> > > > > +       if (list_empty(&notify_list))
> > > > > +               return;
> > > > > +
> > > > > +       spin_lock(&notify_list_lock);
> > > > > +       list_for_each_entry_safe(entry, nentry, &notify_list, lis=
t) {
> > > > > +               if (!is_resumeable(entry) && !is_active(entry))
> > > > > +                       list_move(&entry->list, &cleanup_list);
> > > > > +       }
> > > > > +       spin_unlock(&notify_list_lock);
> > > > > +
> > > > > +       list_for_each_entry_safe(entry, nentry, &cleanup_list, li=
st) {
> > > > > +               list_del(&entry->list);
> > > > > +               close_fid(entry);
> > > > > +               free_notify_info(entry);
> > > > > +       }
> > > > > +       mod_delayed_work(cifsiod_wq, &notify_cleanup_work, CLEANU=
P_INTERVAL);
> > > > > +}
> > > > > diff --git a/fs/smb/client/notify.h b/fs/smb/client/notify.h
> > > > > new file mode 100644
> > > > > index 000000000000..088efba4dce9
> > > > > --- /dev/null
> > > > > +++ b/fs/smb/client/notify.h
> > > > > @@ -0,0 +1,19 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > +/*
> > > > > + * Directory change notification tracking for SMB
> > > > > + *
> > > > > + * Copyright (c) 2025, Sang-Heon Jeon <ekffu200098@gmail.com>
> > > > > + */
> > > > > +
> > > > > +#ifndef _SMB_NOTIFY_H
> > > > > +#define _SMB_NOTIFY_H
> > > > > +
> > > > > +#include "cifsglob.h"
> > > > > +
> > > > > +int start_track_dir_changes(const char *path,
> > > > > +                           struct inode *dir_inode,
> > > > > +                           struct cifs_sb_info *cifs_sb);
> > > > > +void stop_track_sb_dir_changes(struct cifs_sb_info *cifs_sb);
> > > > > +void resume_track_dir_changes(void);
> > > > > +
> > > > > +#endif /* _SMB_NOTIFY_H */
> > > > > diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
> > > > > index 4e5460206397..455e5be37116 100644
> > > > > --- a/fs/smb/client/readdir.c
> > > > > +++ b/fs/smb/client/readdir.c
> > > > > @@ -24,6 +24,9 @@
> > > > >  #include "fs_context.h"
> > > > >  #include "cached_dir.h"
> > > > >  #include "reparse.h"
> > > > > +#ifdef CONFIG_CIFS_DIR_CHANGE_TRACKING
> > > > > +#include "notify.h"
> > > > > +#endif
> > > > >
> > > > >  /*
> > > > >   * To be safe - for UCS to UTF-8 with strings loaded with the ra=
re long
> > > > > @@ -1070,6 +1073,9 @@ int cifs_readdir(struct file *file, struct =
dir_context *ctx)
> > > > >         if (rc)
> > > > >                 goto cache_not_found;
> > > > >
> > > > > +#ifdef CONFIG_CIFS_DIR_CHANGE_TRACKING
> > > > > +       start_track_dir_changes(full_path, d_inode(file_dentry(fi=
le)), cifs_sb);
> > > > > +#endif
> > > > >         mutex_lock(&cfid->dirents.de_mutex);
> > > > >         /*
> > > > >          * If this was reading from the start of the directory
> > > > > @@ -1151,6 +1157,9 @@ int cifs_readdir(struct file *file, struct =
dir_context *ctx)
> > > > >                 cifs_dbg(FYI, "Could not find entry\n");
> > > > >                 goto rddir2_exit;
> > > > >         }
> > > > > +#ifdef CONFIG_CIFS_DIR_CHANGE_TRACKING
> > > > > +       start_track_dir_changes(full_path, d_inode(file_dentry(fi=
le)), cifs_sb);
> > > > > +#endif
> > > > >         cifs_dbg(FYI, "loop through %d times filling dir for net =
buf %p\n",
> > > > >                  num_to_fill, cifsFile->srch_inf.ntwrk_buf_start)=
;
> > > > >         max_len =3D tcon->ses->server->ops->calc_smb_size(
> > > > > diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> > > > > index 4e922cb32110..58a1ddc39ee6 100644
> > > > > --- a/fs/smb/client/smb2pdu.c
> > > > > +++ b/fs/smb/client/smb2pdu.c
> > > > > @@ -45,6 +45,9 @@
> > > > >  #include "cached_dir.h"
> > > > >  #include "compress.h"
> > > > >  #include "fs_context.h"
> > > > > +#ifdef CONFIG_CIFS_DIR_CHANGE_TRACKING
> > > > > +#include "notify.h"
> > > > > +#endif
> > > > >
> > > > >  /*
> > > > >   *  The following table defines the expected "StructureSize" of =
SMB2 requests
> > > > > @@ -466,6 +469,9 @@ smb2_reconnect(__le16 smb2_command, struct ci=
fs_tcon *tcon,
> > > > >                 mod_delayed_work(cifsiod_wq, &server->reconnect, =
0);
> > > > >
> > > > >         atomic_inc(&tconInfoReconnectCount);
> > > > > +#ifdef CONFIG_CIFS_DIR_CHANGE_TRACKING
> > > > > +       resume_track_dir_changes();
> > > > > +#endif
> > > > >  out:
> > > > >         /*
> > > > >          * Check if handle based operation so we know whether we =
can continue
> > > > > --
> > > > > 2.43.0
> > > > >
> > > >
> > > > To Reviewers.
> > > >
> > > > This is a gentle reminder on review requests.
> > > >
> > > > I would be very grateful for your feedback and am more than willing=
 to
> > > > revise or improve any parts as needed. And also, let me know if I
> > > > missed anything or made mistakes.
> > >
> > > Hi Sang,
> >
> > Hello, Amir
> >
> > > First feedback (value):
> > > -----------------------------
> > > This looks very useful. this feature has been requested and
> > > attempted several times in the past (see links below), so if you are
> > > willing to incorporate feedback, I hope you will reach further than t=
hose
> > > past attempts and I will certainly do my best to help you with that.
> >
> > Thanks for your kind comment. I'm really glad to hear that.
> >
> > > Second feedback (reviewers):
> > > ----------------------------------------
> > > I was very surprised that your patch doesn't touch any vfs code
> > > (more on that on design feedback), but this is not an SMB-contained
> > > change at all.
> >
> > I agree with your last comment. I think it might not be easy;
> > honestly, I may know less than
> > Ioannis or Vivek; but I'm fully committed to giving it a try, no
> > matter the challenge.
> >
> > > Your patch touches the guts of the fsnotify subsystem (in a wrong way=
).
> > > For the next posting please consult the MAINTAINERS entry
> > > of the fsnotify subsystem for reviewers and list to CC (now added).
> >
> > I see. I'll keep it in my mind.
> >
> > > Third feedback (design):
> > > --------------------------------
> > > The design choice of polling i_fsnotify_mask on readdir()
> > > is quite odd and it is not clear to me why it makes sense.
> > > Previous discussions suggested to have a filesystem method
> > > to update when applications setup a watch on a directory [1].
> > > Another prior feedback was that the API should allow a clear
> > > distinction between the REMOTE notifications and the LOCAL
> > > notifications [2][3].
> >
> > Current design choice is a workaround for setting an appropriate add
> > watch point (as well as remove). I don't want to stick to the RFC
> > design. Also, The point that I considered important is similar to
> > Ioannis' one: compatible with existing applications.
> >
> > > IMO it would be better to finalize the design before working on the
> > > code, but that's up to you.
> >
> > I agree, although it's quite hard to create a perfect blueprint, but
> > it might be better to draw to some extent.
> >
> > Based on my current understanding, I think we need to do the following =
things.
> > - design more compatible and general fsnotify API for all network fs;
> > should process LOCAL and REMOTE both smoothly.
> > - expand inotify (if needed, fanotify both) flow with new fsnotify API
> > - replace SMB2 change_notify start/end point to new API
> >
>
> Yap, that's about it.
> All the rest is the details...
>
> > Let me know if I missed or misunderstood something. And also please
> > give me some time to read attached threads more deeply and clean up my
> > thoughts and questions.
> >
>
> Take your time.
> It's good to understand the concerns of previous attempts to
> avoid hitting the same roadblocks.

Good to see you again!

I read and try to understand previous discussions that you attached. I
would like to ask for your opinion about my current step.
I considered different places for new fsnotify API. I came to the same
conclusion that you already suggested to Inoannis [1]
After adding new API to `struct super_operations`, I tried to find the
right place for API calls that would not break existing systems and
have compatibility with inotify and fanotify.

From my current perspective, I think the outside of fsnotify (like
inotify_user.c/fanotify_user.c) is a better place to call new API.
Also, it might lead some duplicate code with inotify and fanotify, but
it seems difficult to create one unified logic that covers both
inotify and fanotify. With this approach, we could start inotify first
and then fanotify second that Inoannis and Vivek already attempted.
Even if unified logic is possible, I don't think it is not difficult
to merge and move them into inside of fsnotify (like mark.c)

Also, I have concerns when to call the new API. I think after updating
the mark is a good moment to call API if we decide to ignore errors
from new API; now, to me, it is affordable in terms of minimizing side
effect and lower risk with user spaces. However, eventually, I believe
the user should be able to decide whether to ignore the error or not
of new API, maybe by config or flag else. In that case, we need to
rollback update of fsnotify when new API fails. but it is not
supported yet. Could you share your thoughts on this, too?

If my inspection is wrong or you might have better idea, please let me
know about it. TBH, understanding new things is hard, but it's also a
happy moment to me.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjvbcM9GKgs=3DKPNcH9PmtFJEi=
LY9O_ZHS7qeXrtUn=3D4yw@mail.gmail.com/

> Thanks,
> Amir.

Best Regards.
Sang-Heon Jeon

