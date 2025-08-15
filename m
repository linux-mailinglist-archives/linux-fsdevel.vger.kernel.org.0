Return-Path: <linux-fsdevel+bounces-58001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B158B27FC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 14:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24AAB1CC4092
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 12:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624A7301479;
	Fri, 15 Aug 2025 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayJHVm8T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA281684B0
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755259967; cv=none; b=G+fpp/hh3CqgTcHT6Ao3SO+J4Bp7YlGGJUgTXpA3IhTdYLXEFJR4y5KAEOcUygkR1hJ1dfis2qqDJVhxDT0KDPHAVOpJYkEB/Y7WVGnjnjbdupO5CYM/Eu6PThvgd/t7hNkYs8FXL33e477C+AIwaxpy9DrYO5JM+9X7kQ+hejY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755259967; c=relaxed/simple;
	bh=RupsilpKIyJKD6xVBtFhDOFiNYQdWmcA4JoYQiiXKxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5FM76GLkBhiBEqkUi6erGI2GJU59iKd5xKSFaTazOtSEwWCYSludIHoHOA0cCXGRrjRt+NhjBWkIvqtWlcee3YZaYV4LeYsGazrY7xavTiRgvZh2rqKkK7Mv1cSbWXQHrjrEWnIVOR5dJyVvQmbDJXvI/zPX5/LudzCPqMTHGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ayJHVm8T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755259965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpW1qwORrP/cLl209Z3R2SRZq+lx8ZmrbQjvosYUqoI=;
	b=ayJHVm8TGRdDuaJVqLRnGFqJren+aiWaUythYFh+8EnxNzhgJOICFN8TJxzpMAIf8siQxu
	4rND1tFRmkS65OSxaOW5zw4GuSRombrAq/ebOtBhZV4P0/ZJ2Wq02mYhrwXngy9nr3RFtq
	V+3eo9re8vLwo5S4IZ9YX3UhzifwOkc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-hpvq8zF0PyqXRkU6xAmzIQ-1; Fri, 15 Aug 2025 08:12:42 -0400
X-MC-Unique: hpvq8zF0PyqXRkU6xAmzIQ-1
X-Mimecast-MFC-AGG-ID: hpvq8zF0PyqXRkU6xAmzIQ_1755259962
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b1098f6142so36481411cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 05:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755259961; x=1755864761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpW1qwORrP/cLl209Z3R2SRZq+lx8ZmrbQjvosYUqoI=;
        b=Igkat8/dLzy9KomfYULDE6wtIctVyztT6Rks4+Fz3SDVdFwuT3Ua7eFREfbHy5y/G2
         a7Hvv+r4ojT5Bv7FpovUmAUGXe9XzuDQQFGslt4X78RQ6G4IlCDfHY4eHuN7Ortfdr8D
         QQj2BvIzUrrr9dhXYd4Fslpu5z1fxsveFtDKfNWW0XRqfhs9jlWLyeBcr7BM0/96EojC
         JvSfh5hcDsvOTn0x1Dc986uqLK42HTB+wNACBNBYpd82AiFMiG44dEgOrg5kPsMkfTxq
         pcfzSXcOJPPV2v14DP3YQFhqtW7Ps1GJLxZHkXfUPMET8/MIyFnC4WRbHDcQXt6QRwDF
         TYQA==
X-Forwarded-Encrypted: i=1; AJvYcCX7euBxqTYpVw/jxxSCdmiLBXSVpKKy6llvRFDsDL7myy8J5cdjuKYXdaFBqkg7JfYLVSW79kLnQkFTdC20@vger.kernel.org
X-Gm-Message-State: AOJu0YzbW9j0w1GfRTyyf3rfF/Cg11kmfdEu5xOkki3paUR/560sTyJm
	g4cXszG3UCeY0JtxjD+xAsnBjmsSFV8HdpoCpZrze9oBZ79JOj/Xkkda+o+TXp9WpgVn7wK2hYQ
	hChK8fFFqjYRM+AzId8Gw5zbY172kva1ZixRG56DUSysSz+We9w3opn1AL8oJA8XmL1xncEwZA7
	SCR5ZShGx2huyk+s6BxQXGdVMO3koS5fItoR0hjzWRCA==
X-Gm-Gg: ASbGncuBPVy4XUx/iUgbGcwNlfoO0GAAhXlBRV4pPdacI0PNWNx+8hJdYxzH/fE/Q+r
	j2ljAs/xLgYWdJ13bL57RBZ6A3z5jbM54sor6VI3VUHQqGkXmSKr+9ssROMLjBKoXejccnCkB7G
	y7zaU6oilET3irfpz1GGOXRMzFPGMFWK6a2dm89LsfT3V/Zlz8Gb42
X-Received: by 2002:ac8:58d6:0:b0:4b0:6d72:58da with SMTP id d75a77b69052e-4b11e27e336mr21593971cf.40.1755259961357;
        Fri, 15 Aug 2025 05:12:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUnPnvMwLbNdtzAW+0roAeIZqivH1p27UtKqFsGOF6SNMkniTfnNu9dyNXw9EPSCCREzSVauEw0aVkW+ujZac=
X-Received: by 2002:ac8:58d6:0:b0:4b0:6d72:58da with SMTP id
 d75a77b69052e-4b11e27e336mr21593341cf.40.1755259960870; Fri, 15 Aug 2025
 05:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814103424.3287358-2-lichliu@redhat.com> <dd25041f-98e0-4bb5-bcd5-ba3507262c76@infradead.org>
In-Reply-To: <dd25041f-98e0-4bb5-bcd5-ba3507262c76@infradead.org>
From: Lichen Liu <lichliu@redhat.com>
Date: Fri, 15 Aug 2025 20:12:30 +0800
X-Gm-Features: Ac12FXz8u1gnW3sWaPY_5ktKOWU5Gtqqb7XQcSSDytiYY6c-gGJc-TBLcG6Iyzc
Message-ID: <CAPmSd0O=f24o0J6Q202qFv09YrvvAtVryLk68RbU9ncfMTS0Vw@mail.gmail.com>
Subject: Re: [PATCH RESEND] fs: Add 'rootfsflags' to set rootfs mount options
To: Randy Dunlap <rdunlap@infradead.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	safinaskar@zohomail.com, kexec@lists.infradead.org, rob@landley.net, 
	weilongchen@huawei.com, cyphar@cyphar.com, linux-api@vger.kernel.org, 
	zohar@linux.ibm.com, stefanb@linux.ibm.com, initramfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Randy,

I will send a v2 with documentation.

On Fri, Aug 15, 2025 at 12:27=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Hi,
>
> On 8/14/25 3:34 AM, Lichen Liu wrote:
> > When CONFIG_TMPFS is enabled, the initial root filesystem is a tmpfs.
> > By default, a tmpfs mount is limited to using 50% of the available RAM
> > for its content. This can be problematic in memory-constrained
> > environments, particularly during a kdump capture.
> >
> > In a kdump scenario, the capture kernel boots with a limited amount of
> > memory specified by the 'crashkernel' parameter. If the initramfs is
> > large, it may fail to unpack into the tmpfs rootfs due to insufficient
> > space. This is because to get X MB of usable space in tmpfs, 2*X MB of
> > memory must be available for the mount. This leads to an OOM failure
> > during the early boot process, preventing a successful crash dump.
> >
> > This patch introduces a new kernel command-line parameter, rootfsflags,
> > which allows passing specific mount options directly to the rootfs when
> > it is first mounted. This gives users control over the rootfs behavior.
> >
> > For example, a user can now specify rootfsflags=3Dsize=3D75% to allow t=
he
> > tmpfs to use up to 75% of the available memory. This can significantly
> > reduce the memory pressure for kdump.
> >
> > Consider a practical example:
> >
> > To unpack a 48MB initramfs, the tmpfs needs 48MB of usable space. With
> > the default 50% limit, this requires a memory pool of 96MB to be
> > available for the tmpfs mount. The total memory requirement is therefor=
e
> > approximately: 16MB (vmlinuz) + 48MB (loaded initramfs) + 48MB (unpacke=
d
> > kernel) + 96MB (for tmpfs) + 12MB (runtime overhead) =E2=89=88 220MB.
> >
> > By using rootfsflags=3Dsize=3D75%, the memory pool required for the 48M=
B
> > tmpfs is reduced to 48MB / 0.75 =3D 64MB. This reduces the total memory
> > requirement by 32MB (96MB - 64MB), allowing the kdump to succeed with a
> > smaller crashkernel size, such as 192MB.
> >
> > An alternative approach of reusing the existing rootflags parameter was
> > considered. However, a new, dedicated rootfsflags parameter was chosen
> > to avoid altering the current behavior of rootflags (which applies to
> > the final root filesystem) and to prevent any potential regressions.
> >
> > This approach is inspired by prior discussions and patches on the topic=
.
> > Ref: https://www.lightofdawn.org/blog/?viewDetailed=3D00128
> > Ref: https://landley.net/notes-2015.html#01-01-2015
> > Ref: https://lkml.org/lkml/2021/6/29/783
> > Ref: https://www.kernel.org/doc/html/latest/filesystems/ramfs-rootfs-in=
itramfs.html#what-is-rootfs
> >
> > Signed-off-by: Lichen Liu <lichliu@redhat.com>
> > Tested-by: Rob Landley <rob@landley.net>
> > ---
> > Hi VFS maintainers,
> >
> > Resending this patch as it did not get picked up.
> > This patch is intended for the VFS tree.
> >
> >  fs/namespace.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 8f1000f9f3df..e484c26d5e3f 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -65,6 +65,15 @@ static int __init set_mphash_entries(char *str)
> >  }
> >  __setup("mphash_entries=3D", set_mphash_entries);
> >
> > +static char * __initdata rootfs_flags;
> > +static int __init rootfs_flags_setup(char *str)
> > +{
> > +     rootfs_flags =3D str;
> > +     return 1;
> > +}
> > +
> > +__setup("rootfsflags=3D", rootfs_flags_setup);
>
> Please document this option (alphabetically) in
> Documentation/admin-guide/kernel-parameters.txt.
>
> Thanks.
>
> > +
> >  static u64 event;
> >  static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
> >  static DEFINE_IDA(mnt_group_ida);
> > @@ -5677,7 +5686,7 @@ static void __init init_mount_tree(void)
> >       struct mnt_namespace *ns;
> >       struct path root;
> >
> > -     mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
> > +     mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", rootfs_flags=
);
> >       if (IS_ERR(mnt))
> >               panic("Can't create rootfs");
> >
>
> --
> ~Randy
>
>


