Return-Path: <linux-fsdevel+bounces-56787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B71B1B9F1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 20:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51AE87A5F2A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 18:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7195D298242;
	Tue,  5 Aug 2025 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="LC0T23N7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A30454F81
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754418004; cv=none; b=LQXcctKvK5EJEEZhKcDUCgC5HZypVt1ewlPsDkDVOT2EAS9WC4OUKiUp+UxeEcJYC04c02Nag0nR5mzSccdB6hV1PhnRfeU09hxDXOqEfDRD14ntYGSkD+EIwKFAh8FJJbSAd/DOWGWUD88vWMGa7iesSRF3JYTfo7ZjtGQV6BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754418004; c=relaxed/simple;
	bh=SoWeAkL3iEjJwCLqt4FbJMg6xWcRvn6FBDhLLGVZRuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hw/0+q4KDo4k+g+gUUPqwcS7LAZ4kEfeVGewwVbDz2d5NxR0BCwLqcLGp1EjRLmrzzAU1uVWXaZwJWZnL4pT5spAPVKw51u8HfgIoIQrkHB3arafQ6bWUaxyp5DpUJ/RPrpMA79CTpZwiUM777weJ9eLb7lZPh0uAXGZ8TCyDag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=LC0T23N7; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b07275e0a4so25322791cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Aug 2025 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754418001; x=1755022801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJOL+OvU/nrmYX0+Cdrz/7P1lhjrc0IsETGcPgFQaaY=;
        b=LC0T23N7XDZDcA3ZTmS2aaM1uuXEP0PNwtmn/5qQBlZ4XNcZ4jlH81gFkv+LLw6QEA
         OATdrEEZ9tv4t6t3VMhNcaZtp7qd1tjc2Oxutg4mMg4kHu/YNspSa2AxVWPIXZzyfzog
         leVg2iXlyF34xsRrPguJANxh4fRuhNsWPL9306jdcuA5tNsqvSxiEQaBCD8NaG/W1fOp
         E0oqM2fhpTKVIU0VhDx+V99Yo83cGAIZbAqZf8/dB+qkdCnvInbESywwCCT/OvnHP1g1
         DxqeliAcC37JtAwreDCDEkuc3vXvObgTzliIF/e/4bmxigRsHZGlMOzxiZ4Q2I6W81oJ
         jVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754418001; x=1755022801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJOL+OvU/nrmYX0+Cdrz/7P1lhjrc0IsETGcPgFQaaY=;
        b=YcP2wKkoYQGnFWSOhzSXyjSwY0yusDSl0vIrMgoikNjOBREt8cGDrWRwM6VJ6oFTKL
         EoJBFUPqE52W+WKXdKJGQkyw0uZDgq5T0WiwuBdALXvVdRbctd50+ICUgaZVDNT5l9lt
         Ib1mtCZ1Omd5cwFYXY6JMqzmF0HzYRJ7rQqOCzrScrIZte1BXdUoC9ivwg/rzIkYN4Ny
         Gv5iIpOfzRq56deziKs35nhjtyoa5yX3ngJaqQ36FdMntNchxqI7UW6RwdFV2CLMubod
         pV5/FqVt/Oq82FZQRIxb8v3wnM/ZQvw9rjqb7xNBHwo07WMy+IU3TEEqGUM4bES5hKcD
         TcAg==
X-Forwarded-Encrypted: i=1; AJvYcCV5Z9xZ80vkpUOw8VXP2OmKPSKrz7DGdrjliugE7adlzyvRn9wWTmdtsfsfJW/Hk7l6b/4wyKMIK7Qc2Y/F@vger.kernel.org
X-Gm-Message-State: AOJu0YwsvtR7V5Ic6DUmCVseNtJMK53N/sneFIjtpkOt/BPotoCzH35a
	mas8oxJB7zdeqkb7lZ0t+X/Rdqqeilc3xPcIgJOpaW4aeMvhJjHbjx/3/vPhOUEfEfe01rI1h00
	tKucuy12Js7d3F2t1iNPEC/bAWKtAj6kJXXy7vCevkQ==
X-Gm-Gg: ASbGnctZgdO8c2dIVccmUF0phhXNMkX75uolYsLOvz2+4ENPo9Y4Veq+wnURfq4TttJ
	vUO68wLL+9F+jf5HtBFdjKP2Ah0VJSHmmMci8FV9CzMh45qiqzbmcztYqaPiTYfbyaXqwODyvJx
	hYSYM8pMj5Dol0QuE2wfoFbjgO+2URvflln3PGXq7GvaMynEJxHPSD5gvcfL+HUwmTaxLE3Y2cK
	JYE
X-Google-Smtp-Source: AGHT+IEw+lnJXb281yq+trj2cDJrjXcg+zACfYTXT195jbevAktpYuj5aCvlB20L+shR7ta89N5uGsQOoFo/By5YjC8=
X-Received: by 2002:a05:622a:5c94:b0:4b0:67b0:867 with SMTP id
 d75a77b69052e-4b067b02bd2mr149540751cf.27.1754418000991; Tue, 05 Aug 2025
 11:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-17-pasha.tatashin@soleen.com> <20250729163536.GN36037@nvidia.com>
In-Reply-To: <20250729163536.GN36037@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 5 Aug 2025 18:19:23 +0000
X-Gm-Features: Ac12FXz1LXAIJ7aYVxZ3KJkjC5AKnczPYVgMksSZ0RYc1suLLyDEIPbV7Oa9zmM
Message-ID: <CA+CK2bBOu9oRiO7gih7JpePXQjds2vN8uFXodgHU48fxpP_bVQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/32] liveupdate: luo_ioctl: add ioctl interface
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 12:35=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Wed, Jul 23, 2025 at 02:46:29PM +0000, Pasha Tatashin wrote:
> > Introduce the user-space interface for the Live Update Orchestrator
> > via ioctl commands, enabling external control over the live update
> > process and management of preserved resources.
>
> I strongly recommend copying something like fwctl (which is copying
> iommufd, which is copying some other best practices). I will try to
> outline the main points below.
>
> The design of the fwctl scheme allows alot of options for ABI
> compatible future extensions and I very strongly recommend that
> complex ioctl style APIs be built with that in mind. I have so many
> scars from trying to undo fixed ABI design :)

Thank you for bringing this up, I have reviewed fwctl ioctl
implementation, and also iommufd ioctl, and I made the necessary
changes to make luo similar.

> > +/**
> > + * struct liveupdate_fd - Holds parameters for preserving and restorin=
g file
> > + * descriptors across live update.
> > + * @fd:    Input for %LIVEUPDATE_IOCTL_FD_PRESERVE: The user-space fil=
e
> > + *         descriptor to be preserved.
> > + *         Output for %LIVEUPDATE_IOCTL_FD_RESTORE: The new file descr=
iptor
> > + *         representing the fully restored kernel resource.
> > + * @flags: Unused, reserved for future expansion, must be set to 0.
> > + * @token: Input for %LIVEUPDATE_IOCTL_FD_PRESERVE: An opaque, unique =
token
> > + *         preserved for preserved resource.
> > + *         Input for %LIVEUPDATE_IOCTL_FD_RESTORE: The token previousl=
y
> > + *         provided to the preserve ioctl for the resource to be resto=
red.
> > + *
> > + * This structure is used as the argument for the %LIVEUPDATE_IOCTL_FD=
_PRESERVE
> > + * and %LIVEUPDATE_IOCTL_FD_RESTORE ioctls. These ioctls allow specifi=
c types
> > + * of file descriptors (for example memfd, kvm, iommufd, and VFIO) to =
have their
> > + * underlying kernel state preserved across a live update cycle.
> > + *
> > + * To preserve an FD, user space passes this struct to
> > + * %LIVEUPDATE_IOCTL_FD_PRESERVE with the @fd field set. On success, t=
he
> > + * kernel uses the @token field to uniquly associate the preserved FD.
> > + *
> > + * After the live update transition, user space passes the struct popu=
lated with
> > + * the *same* @token to %LIVEUPDATE_IOCTL_FD_RESTORE. The kernel uses =
the @token
> > + * to find the preserved state and, on success, populates the @fd fiel=
d with a
> > + * new file descriptor referring to the restored resource.
> > + */
> > +struct liveupdate_fd {
> > +     int             fd;
>
> 'int' should not appear in uapi structs. Fds are __s32

done

>
> > +     __u32           flags;
> > +     __aligned_u64   token;
> > +};
> > +
> > +/* The ioctl type, documented in ioctl-number.rst */
> > +#define LIVEUPDATE_IOCTL_TYPE                0xBA
>
> I have found it very helpful to organize the ioctl numbering like this:
>
> #define IOMMUFD_TYPE (';')
>
> enum {
>         IOMMUFD_CMD_BASE =3D 0x80,
>         IOMMUFD_CMD_DESTROY =3D IOMMUFD_CMD_BASE,
>         IOMMUFD_CMD_IOAS_ALLOC =3D 0x81,
>         IOMMUFD_CMD_IOAS_ALLOW_IOVAS =3D 0x82,
> [..]
>
> #define IOMMU_DESTROY _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DESTROY)
>
> The numbers should be tightly packed and non-overlapping. It becomes
> difficult to manage this if the numbers are sprinkled all over the
> file. The above structuring will enforce git am conflicts if things
> get muddled up. Saved me a few times already in iommufd.

Done

>
> > +/**
> > + * LIVEUPDATE_IOCTL_FD_PRESERVE - Validate and initiate preservation f=
or a file
> > + * descriptor.
> > + *
> > + * Argument: Pointer to &struct liveupdate_fd.
> > + *
> > + * User sets the @fd field identifying the file descriptor to preserve
> > + * (e.g., memfd, kvm, iommufd, VFIO). The kernel validates if this FD =
type
> > + * and its dependencies are supported for preservation. If validation =
passes,
> > + * the kernel marks the FD internally and *initiates the process* of p=
reparing
> > + * its state for saving. The actual snapshotting of the state typicall=
y occurs
> > + * during the subsequent %LIVEUPDATE_IOCTL_PREPARE execution phase, th=
ough
> > + * some finalization might occur during freeze.
> > + * On successful validation and initiation, the kernel uses the @token
> > + * field with an opaque identifier representing the resource being pre=
served.
> > + * This token confirms the FD is targeted for preservation and is requ=
ired for
> > + * the subsequent %LIVEUPDATE_IOCTL_FD_RESTORE call after the live upd=
ate.
> > + *
> > + * Return: 0 on success (validation passed, preservation initiated), n=
egative
> > + * error code on failure (e.g., unsupported FD type, dependency issue,
> > + * validation failed).
> > + */
> > +#define LIVEUPDATE_IOCTL_FD_PRESERVE                                 \
> > +     _IOW(LIVEUPDATE_IOCTL_TYPE, 0x00, struct liveupdate_fd)
>
> From a kdoc perspective I find it works much better to attach the kdoc
> to the struct, not the ioctl:
>
> /**
>  * struct iommu_destroy - ioctl(IOMMU_DESTROY)
>  * @size: sizeof(struct iommu_destroy)
>  * @id: iommufd object ID to destroy. Can be any destroyable object type.
>  *
>  * Destroy any object held within iommufd.
>  */
> struct iommu_destroy {
>         __u32 size;
>         __u32 id;
> };
> #define IOMMU_DESTROY _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DESTROY)
>
> Generates this kdoc:
>
> https://docs.kernel.org/userspace-api/iommufd.html#c.iommu_destroy

Agreed, done the same as above.

>
> You should also make sure to link the uapi header into the kdoc build
> under the "userspace API" chaper.
>
> The structs should also be self-describing. I am fairly strongly
> against using the size mechanism in the _IOW macro, it is instantly
> ABI incompatible and basically impossible to deal with from userspace.
>
> Hence why the IOMMFD version is _IO().

Right, I came to the same conclusion while reviewing fwctl, I replaced
everything with pure _IO().

>
> This means stick a size member in the first 4 bytes of every
> struct. More on this later..
>
> > +/**
> > + * LIVEUPDATE_IOCTL_FD_UNPRESERVE - Remove a file descriptor from the
> > + * preservation list.
> > + *
> > + * Argument: Pointer to __u64 token.
>
> Every ioctl should have a struct, with the size header. If you want to
> do more down the road you can not using this structure.

Done

>
> > +#define LIVEUPDATE_IOCTL_FD_RESTORE                                  \
> > +     _IOWR(LIVEUPDATE_IOCTL_TYPE, 0x02, struct liveupdate_fd)
>
> Strongly recommend that every ioctl have a unique struct. Sharing
> structs makes future extend-ability harder.

Done

>
> > +/**
> > + * LIVEUPDATE_IOCTL_PREPARE - Initiate preparation phase and trigger s=
tate
> > + * saving.
>
> Perhaps these just want to be a single 'set state' ioctl with an enum
> input argument?

Added a IOCTL: LIVEUPDATE_SET_EVENT, and all events
PREPARE/FINISH/CANCEL are now done through it.

>
> > @@ -7,4 +7,5 @@ obj-$(CONFIG_KEXEC_HANDOVER)          +=3D kexec_handov=
er.o
> >  obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)   +=3D kexec_handover_debug.o
> >  obj-$(CONFIG_LIVEUPDATE)             +=3D luo_core.o
> >  obj-$(CONFIG_LIVEUPDATE)             +=3D luo_files.o
> > +obj-$(CONFIG_LIVEUPDATE)             +=3D luo_ioctl.o
> >  obj-$(CONFIG_LIVEUPDATE)             +=3D luo_subsystems.o
>
> I don't think luo is modular, but I think it is generally better to
> write the kbuilds as though it was anyhow if it has a lot of files:
>
> iommufd-y :=3D \
>         device.o \
>         eventq.o \
>         hw_pagetable.o \
>         io_pagetable.o \
>         ioas.o \
>         main.o \
>         pages.o \
>         vfio_compat.o \
>         viommu.o
> obj-$(CONFIG_IOMMUFD) +=3D iommufd.o

Done

>
> Basically don't repeat obj-$(CONFIG_LIVEUPDATE), every one of those
> lines creates a new module (if it was modular)
>
> > +static int luo_open(struct inode *inodep, struct file *filep)
> > +{
> > +     if (!capable(CAP_SYS_ADMIN))
> > +             return -EACCES;
>
> IMHO file system permissions should control permission to open. No
> capable check.

Removed

>
> > +     if (filep->f_flags & O_EXCL)
> > +             return -EINVAL;
>
> O_EXCL doesn't really do anything for cdev, I'd drop this.
>
> The open should have an atomic to check for single open though.

Removed, and added an enforcement for a single open.

>
> > +static long luo_ioctl(struct file *filep, unsigned int cmd, unsigned l=
ong arg)
> > +{
> > +     void __user *argp =3D (void __user *)arg;
> > +     struct liveupdate_fd luo_fd;
> > +     enum liveupdate_state state;
> > +     int ret =3D 0;
> > +     u64 token;
> > +
> > +     if (_IOC_TYPE(cmd) !=3D LIVEUPDATE_IOCTL_TYPE)
> > +             return -ENOTTY;
>
> The generic parse/disptach from fwctl is a really good idea here, you
> can cut and paste it, change the names. It makes it really easy to manage=
 future extensibility:
>
> List the ops and their structs:
>
> static const struct fwctl_ioctl_op fwctl_ioctl_ops[] =3D {
>         IOCTL_OP(FWCTL_INFO, fwctl_cmd_info, struct fwctl_info, out_devic=
e_data),
>         IOCTL_OP(FWCTL_RPC, fwctl_cmd_rpc, struct fwctl_rpc, out),
> };
>
> Index the list and copy_from_user the struct desribing the opt:
>
> static long fwctl_fops_ioctl(struct file *filp, unsigned int cmd,
>                                unsigned long arg)
> {
>         struct fwctl_uctx *uctx =3D filp->private_data;
>         const struct fwctl_ioctl_op *op;
>         struct fwctl_ucmd ucmd =3D {};
>         union fwctl_ucmd_buffer buf;
>         unsigned int nr;
>         int ret;
>
>         nr =3D _IOC_NR(cmd);
>         if ((nr - FWCTL_CMD_BASE) >=3D ARRAY_SIZE(fwctl_ioctl_ops))
>                 return -ENOIOCTLCMD;
>
>         op =3D &fwctl_ioctl_ops[nr - FWCTL_CMD_BASE];
>         if (op->ioctl_num !=3D cmd)
>                 return -ENOIOCTLCMD;
>
>         ucmd.uctx =3D uctx;
>         ucmd.cmd =3D &buf;
>         ucmd.ubuffer =3D (void __user *)arg;
>         // This is reading/checking the standard 4 byte size header:
>         ret =3D get_user(ucmd.user_size, (u32 __user *)ucmd.ubuffer);
>         if (ret)
>                 return ret;
>
>         if (ucmd.user_size < op->min_size)
>                 return -EINVAL;
>
>         ret =3D copy_struct_from_user(ucmd.cmd, op->size, ucmd.ubuffer,
>                                     ucmd.user_size);
>
>
> Removes a bunch of boiler plate and easy to make wrong copy_from_users
> in the ioctls. Centralizes size validation, zero padding checking/etc.

Yeap, implemented as  above.

>
> > +             ret =3D luo_register_file(luo_fd.token, luo_fd.fd);
> > +             if (!ret && copy_to_user(argp, &luo_fd, sizeof(luo_fd))) =
{
> > +                     WARN_ON_ONCE(luo_unregister_file(luo_fd.token));
> > +                     ret =3D -EFAULT;
>
> Then for extensibility you'd copy back the struct:
>
> static int ucmd_respond(struct fwctl_ucmd *ucmd, size_t cmd_len)
> {
>         if (copy_to_user(ucmd->ubuffer, ucmd->cmd,
>                          min_t(size_t, ucmd->user_size, cmd_len)))
>                 return -EFAULT;
>         return 0;
> }
>
> Which truncates it/etc according to some ABI extensibility rules.
>
> > +static int __init liveupdate_init(void)
> > +{
> > +     int err;
> > +
> > +     if (!liveupdate_enabled())
> > +             return 0;
> > +
> > +     err =3D misc_register(&liveupdate_miscdev);
> > +     if (err < 0) {
> > +             pr_err("Failed to register misc device '%s': %d\n",
> > +                    liveupdate_miscdev.name, err);
>
> Should remove most of the pr_err's, here too IMHO..

Removed.

>
> Jason

Thanks a lot for the thorough review!

Pasha

