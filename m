Return-Path: <linux-fsdevel+bounces-50114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2B0AC84F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 01:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0454A37A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 23:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A8F23278D;
	Thu, 29 May 2025 23:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CD6kGZbm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547CE1AAE28;
	Thu, 29 May 2025 23:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748560573; cv=none; b=B35ettONoShFArZtdX0JIt5Cn8ZX9YOCt1zwsJJTi1WnDUT+DM5V4aHVoOneG5dn58L3JNr5me+iu7YKOEwkJunZtJPzmSbjOdBSOHf9jGhtKH1lVFzCCHVXkB8Mch2ZX350gKo7j+GpA0K+P2ifSX6rVLhuBUQZsHZ+a9FMK9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748560573; c=relaxed/simple;
	bh=uN2v3UTbEty8/RR+P2U4P987E1Lnoe4g4hD5/MHnefg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0tkliqX646ao2RZ68uttOd3c86mtyUjKD6vhVJ1Oi9wl3lRVwPmo+9V7ufqqHd8dvOeBw4nHTs85CeRIawNfoOjl7MybbZJg50CfOGmRioEXL5p/yPs/5hJUsqagH6cV85xB1FVKmBiFftd+SZ/24o91SUQqAysmgvBvsv9P1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CD6kGZbm; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476a720e806so12740641cf.0;
        Thu, 29 May 2025 16:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748560569; x=1749165369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wS0nP8SmvkY9o+OxO2Dpp0pXbkQSsrL7lfI+o9vESoc=;
        b=CD6kGZbm7+s1CiCGd5bb8pHj59I5m+NwLpc93NhdKlceex5uxMUUeZlqTimWSs/0+O
         jyjVQpHySvL2Jhp7jDPWGtPNvv+6zBnMBI1Z26dp3mDjxVxyuor9Nv49b58W4IQV2eHF
         bZdsVfQy3DlTDZuEdRBUBYkplfviHHyiEy8gLJu9USG/XNq3xwCz8i1yAqbY4jOlnP9C
         Bypoxj5tJgwgLc36KbOdjGtxNg3F2gdLbeip9ssuT3GVkZNPZuDnBNIPXMIs7nnk+XOS
         OvSOKj1Pba0xOvv3kokdXLqJZTNgGX7u3GyaLMQdKDIrZ2uA56Nd4MpQCl8/e6iK0eAH
         WbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748560569; x=1749165369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wS0nP8SmvkY9o+OxO2Dpp0pXbkQSsrL7lfI+o9vESoc=;
        b=BCh4JJ/c4HKJhYhzO7VV9G5yZJxr1B1HDR0lTclBfbcdCOuER9TZZTHi87QqdZonpS
         dGqRYhZ19Jt3u6rqBRAXYjwXEoDDGoPXUYQTp8XN3DLoFOGDsyM3rbllmCrxc1ru9JlT
         jJxgrl7n32TkrLmx1keMM8Hw8bW6nQxA7cxhwsV4wboW3a9rB92gZh/6XkA8+kPexroE
         wgbF+rlYOcn52bIpvAYPF69+au7sX9AIMG2Nzq4IJK+kREs/Br9rMAHN61+eSFg72aRS
         yWu0BbS90woJ3cYqlymkDsjxzONlbF7OeqGm5OD6/uJx1XIkgDIEwTR0mVuPSwutIixn
         ISnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIeWbBwVXJtY1pisNBUUIIFMav0vcVjtb7uzIfkjmbIRxZU1kxqvaCgxF+a9cq0IFmkL6FhLDTS70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww+w2c8id5dOEFxUx9AdneFrcKrckGHs2tsekbOTafVC1d88Dv
	9v+gnr7bRDH27hq5Jkftuf26YeZo6bblnf/k7FAZFqmCe0/2tlkonnrFQvt4O2+DVOsGOayiPaC
	XZTjfinCn5MLBL9ZIClyyUMR9jFzrloZ0ng==
X-Gm-Gg: ASbGncvoWCvSXplieYkmeadrXH8w396xtNUCCESGYDYyiYtXhF8gjs3WR+rtdg16/QB
	OrE6YmnqyldMtBcTGiXIW+S4RRIggcWsNlhi4Gu5u3i/YBO5TpCpNFM7/j0Rab+kBDXlFOydY4D
	avWRedkKv8rdDITfHNthu8GiUIkLMOK2rEWiRumTC1ytMZeulzcX/AqZB2v9xg6KruM0LPVg==
X-Google-Smtp-Source: AGHT+IEZeIUQLwv/7iZFp88gVmM5+jxb2YibShcifxR9NaP2bZvIslNAlAv/2LkK/Cs+lZG+M/f9g58a+zIEr3eh964=
X-Received: by 2002:a05:622a:c87:b0:494:adff:7fe2 with SMTP id
 d75a77b69052e-4a4400ada9dmr25506941cf.43.1748560568993; Thu, 29 May 2025
 16:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
 <174787195629.1483178.7917092102987513364.stgit@frogsfrogsfrogs> <CAJnrk1ZEtXoMKXMjse-0RtSLjaK1zfadr3zR2tP4gh1WauOUWA@mail.gmail.com>
In-Reply-To: <CAJnrk1ZEtXoMKXMjse-0RtSLjaK1zfadr3zR2tP4gh1WauOUWA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 29 May 2025 16:15:57 -0700
X-Gm-Features: AX0GCFuG9IkAkb_NwffqnSorzyDBmtvh_DfpUQi35Ja7cU3JgWRX5cTdsMeO78g
Message-ID: <CAJnrk1YDxn0ZMk0BrTnNStkXErjY_LSGYHgdsRjiiZ2dTpftAA@mail.gmail.com>
Subject: Re: [PATCH 03/11] fuse: implement the basic iomap mechanisms
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, 
	linux-xfs@vger.kernel.org, bernd@bsbernd.com, John@groves.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 3:15=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Wed, May 21, 2025 at 5:03=E2=80=AFPM Darrick J. Wong <djwong@kernel.or=
g> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Implement functions to enable upcalling of iomap_begin and iomap_end to
> > userspace fuse servers.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/fuse_i.h          |   38 ++++++
> >  fs/fuse/fuse_trace.h      |  258 +++++++++++++++++++++++++++++++++++++=
++++
> >  include/uapi/linux/fuse.h |   87 ++++++++++++++
> >  fs/fuse/Kconfig           |   23 ++++
> >  fs/fuse/Makefile          |    1
> >  fs/fuse/file_iomap.c      |  280 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  fs/fuse/inode.c           |    5 +
> >  7 files changed, 691 insertions(+), 1 deletion(-)
> >  create mode 100644 fs/fuse/file_iomap.c
> >
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index d56d4fd956db99..aa51f25856697d 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -895,6 +895,9 @@ struct fuse_conn {
> >         /* Is link not implemented by fs? */
> >         unsigned int no_link:1;
> >
> > +       /* Use fs/iomap for FIEMAP and SEEK_{DATA,HOLE} file operations=
 */
> > +       unsigned int iomap:1;
> > +
> >         /* Use io_uring for communication */
> >         unsigned int io_uring;
> >
> > @@ -1017,6 +1020,11 @@ static inline struct fuse_mount *get_fuse_mount_=
super(struct super_block *sb)
> >         return sb->s_fs_info;
> >  }
> >
> > +static inline const struct fuse_mount *get_fuse_mount_super_c(const st=
ruct super_block *sb)
> > +{
> > +       return sb->s_fs_info;
> > +}
> > +
>
> Instead of adding this new helper (and the ones below), what about
> modifying the existing (non-const) versions of these helpers to take
> in const * input args,  eg
>
> -static inline struct fuse_mount *get_fuse_mount_super(struct super_block=
 *sb)
> +static inline struct fuse_mount *get_fuse_mount_super(const struct
> super_block *sb)
>  {
>         return sb->s_fs_info;
>  }
>
> Then, doing something like "const struct fuse_mount *mt =3D
> get_fuse_mount(inode);" would enforce the same guarantees as "const
> struct fuse_mount *mt =3D get_fuse_mount_c(inode);" and we wouldn't need
> 2 sets of helpers that pretty much do the same thing.
>
> >  static inline struct fuse_conn *get_fuse_conn_super(struct super_block=
 *sb)
> >  {
> >         return get_fuse_mount_super(sb)->fc;
> > @@ -1027,16 +1035,31 @@ static inline struct fuse_mount *get_fuse_mount=
(struct inode *inode)
> >         return get_fuse_mount_super(inode->i_sb);
> >  }
> >
> > +static inline const struct fuse_mount *get_fuse_mount_c(const struct i=
node *inode)
> > +{
> > +       return get_fuse_mount_super_c(inode->i_sb);
> > +}
> > +
> >  static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
> >  {
> >         return get_fuse_mount_super(inode->i_sb)->fc;
> >  }
> >
> > +static inline const struct fuse_conn *get_fuse_conn_c(const struct ino=
de *inode)
> > +{
> > +       return get_fuse_mount_super_c(inode->i_sb)->fc;
> > +}
> > +
> >  static inline struct fuse_inode *get_fuse_inode(struct inode *inode)
> >  {
> >         return container_of(inode, struct fuse_inode, inode);
> >  }
> >
> > +static inline const struct fuse_inode *get_fuse_inode_c(const struct i=
node *inode)
> > +{
> > +       return container_of(inode, struct fuse_inode, inode);
> > +}
> > +
> >  static inline u64 get_node_id(struct inode *inode)
> >  {
> >         return get_fuse_inode(inode)->nodeid;
> > @@ -1577,4 +1600,19 @@ extern void fuse_sysctl_unregister(void);
> >  #define fuse_sysctl_unregister()       do { } while (0)
> >  #endif /* CONFIG_SYSCTL */
> >
> > +#if IS_ENABLED(CONFIG_FUSE_IOMAP)
> > +# include <linux/fiemap.h>
> > +# include <linux/iomap.h>
> > +
> > +bool fuse_iomap_enabled(void);
> > +
> > +static inline bool fuse_has_iomap(const struct inode *inode)
> > +{
> > +       return get_fuse_conn_c(inode)->iomap;
> > +}
> > +#else
> > +# define fuse_iomap_enabled(...)               (false)
> > +# define fuse_has_iomap(...)                   (false)
> > +#endif
> > +
> >  #endif /* _FS_FUSE_I_H */
> > diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> > index ca215a3cba3e31..fc7c5bf1cef52d 100644
> > --- a/fs/fuse/Kconfig
> > +++ b/fs/fuse/Kconfig
> > @@ -64,6 +64,29 @@ config FUSE_PASSTHROUGH
> >
> >           If you want to allow passthrough operations, answer Y.
> >
> > +config FUSE_IOMAP
> > +       bool "FUSE file IO over iomap"
> > +       default y
> > +       depends on FUSE_FS
> > +       select FS_IOMAP
> > +       help
> > +         For supported fuseblk servers, this allows the file IO path t=
o run
> > +         through the kernel.
>
> I have config FUSE_FS select FS_IOMAP in my patchset (not yet
> submitted) that changes fuse buffered writes / writeback handling to
> use iomap. Could we just have config FUSE_FS automatically opt into
> FS_IOMAP here or do you see a reason that this needs to be a separate
> config?

Thinking about it some more, the iomap stuff you're adding also
requires a "depends on BLOCK", so this will need to be a separate
config anyways regardless of whether the FUSE_FS will always "select
FS_IOMAP"


Thanks,
Joanne

>
>
> Thanks,
> Joanne
> > +
> > +config FUSE_IOMAP_BY_DEFAULT
> > +       bool "FUSE file I/O over iomap by default"
> > +       default n
> > +       depends on FUSE_IOMAP
> > +       help
> > +         Enable sending FUSE file I/O over iomap by default.
> > +
> > +config FUSE_IOMAP_DEBUG
> > +       bool "Debug FUSE file IO over iomap"
> > +       default n
> > +       depends on FUSE_IOMAP
> > +       help
> > +         Enable debugging assertions for the fuse iomap code paths.
> > +
> >  config FUSE_IO_URING
> >         bool "FUSE communication over io-uring"
> >         default y

