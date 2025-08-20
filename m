Return-Path: <linux-fsdevel+bounces-58394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA92B2E0E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 17:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43EC87A6CDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 15:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD84033437C;
	Wed, 20 Aug 2025 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPnjKtZA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DF92E3AE0
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703058; cv=none; b=PVrwJZAH3prwgIjlwq5RRTsmTCUKK41O5YQ88nuSx1yuYjxJwDjFUgdwk+tAJuOHjaEW4IMk0ZCWAJ+tuwxJMSw4W5ZiTTdlQaC4j3OOxENl4Lvnj+a/nGTk/FHe+CGrwGKuwfWBAdff3+aGkjcGNZIG5iuQQNSLUkNxw0DW5CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703058; c=relaxed/simple;
	bh=W4duEWOlM+udE5VNJ/zPTR+3z61gEew4hVyTyQpHZM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aa7o3/hJXhJcj8Lq6ZxSM1eZIOprkicIkxuY7PnptbxCeOnsPkzMUfPURJmH8Z03JWAhmXZ2YZUMXxJDvD4xxl6bNpY3tYJVKEx0HzcPuqaMlFF9I43XQvr/YoqG3DA+DEw2jPjvWSfal/GSB7PnsZ6KZNPCW4g1DnB32J95sEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XPnjKtZA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755703054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwfU+IsVElt3h1n12yQUuhxkyKNo90VrK/DGR70vyVI=;
	b=XPnjKtZACGjNqU2LY+VCKreoDDF6wSndHvqXVaBNUco1cSqLuhAF44oScNKH6ehZ3UHI8f
	fDb0sKziN9t3UqSJsK4QWRYkzKnzqQpwmRafUTlE/ElSOgkVtgb0ie3QvMu1pHJBhWpbD7
	LymjE4/RftnBue+nAE/7iSPsOdWRr4g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-RCg3EsBQO2-QyhCRNUGVHw-1; Wed, 20 Aug 2025 11:17:32 -0400
X-MC-Unique: RCg3EsBQO2-QyhCRNUGVHw-1
X-Mimecast-MFC-AGG-ID: RCg3EsBQO2-QyhCRNUGVHw_1755703052
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a8b32a6e3so726756d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 08:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755703052; x=1756307852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwfU+IsVElt3h1n12yQUuhxkyKNo90VrK/DGR70vyVI=;
        b=Sdz+rNhc0OjK7dzHuYmOgQNnt6mQMx1upmb0/yKXIb2QScNtmLWM1VNiBfzr5ndegi
         b1Xi4v4GgK6Qpxc2g07vVz5K80BKfYBTqreDbazbPO6wgE49DzzMGlNo8GNWpM3/Uyy1
         O8VE181JM5gaRh7SxRSR3hBLnPTZOr4GPwEowhwANKolrSXd7gNyDwPcv/YlRvvQxJaJ
         uj4MCpHO8DKXo0iG0RAEmmsluCSb++5Clp57wcNu8LX20BGGegu6Fha0D1By61sD57L1
         r0tSu2VYCVfKJF7af6FelmN1WpYnUxJOvm1NnhUA1Ai3r7/4Xnf94/2jvT/2uoxYZdi8
         wIFQ==
X-Gm-Message-State: AOJu0YyflmmCLwIxcLBgC7KNB1K7FzoIBjwWJXLBAb4gHzeJembGykGC
	64h9QUx0Esc0DZEseYNc/IXe4XCui47mfxGHdvQ7ZdmleQ/tZBpuSUoFvIH7qZRSRVuJye0vi4k
	K40SJBC5vjP3JHNv19+h+XSbTOw92NeeL7/FKKjjBH/0em27mxwqSG+NtFQbJz5Qjk4wYxChcdF
	r/gnjYbS3XfuXQ+BKXO0Nkq0Tv8X+aC0BLETKXF6XwxQ==
X-Gm-Gg: ASbGncuYOOmWVhFfxlF5W8X9gTBfAgc+cjZ1r4D/og81lkH1UFAJnpy/x9A5wOxxV4Q
	WdYDjF/PnclAZnqUdPilEx9e6Cdl62bCef9EmHwI9Ky6JK4F3Xsj/kH9962Ewmxi4ZytTYTTzMu
	cAF7krXqqDYgHYOLk6PxJpwamf3YnSqgT1nBS6XwhVpbn9UN5/Knk8
X-Received: by 2002:a05:622a:5c93:b0:4af:203f:73e9 with SMTP id d75a77b69052e-4b291a45948mr38268911cf.3.1755703051798;
        Wed, 20 Aug 2025 08:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgNNXQPsAlJCg5PdYpqbUQjKk2La90rXTiB/Xg+AFCp6PDdl0eXQ9VodkzneYLfMLO6npPB65IGBnQ/QO7tyQ=
X-Received: by 2002:a05:622a:5c93:b0:4af:203f:73e9 with SMTP id
 d75a77b69052e-4b291a45948mr38268261cf.3.1755703051224; Wed, 20 Aug 2025
 08:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815121459.3391223-1-lichliu@redhat.com>
In-Reply-To: <20250815121459.3391223-1-lichliu@redhat.com>
From: Lichen Liu <lichliu@redhat.com>
Date: Wed, 20 Aug 2025 23:17:20 +0800
X-Gm-Features: Ac12FXz5J-qsSNe_dCy4Is9oFh6XR_1xsHJhV6_kkHN0LaUVbdz8uoGPSmN-wtU
Message-ID: <CAPmSd0OHB3orya=3V1icz4ZzOoAwHuWTqON_Dk+EaEcACtVtbg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: Add 'rootfsflags' to set rootfs mount options
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	safinaskar@zohomail.com, kexec@lists.infradead.org, rob@landley.net, 
	weilongchen@huawei.com, cyphar@cyphar.com, linux-api@vger.kernel.org, 
	zohar@linux.ibm.com, stefanb@linux.ibm.com, initramfs@vger.kernel.org, 
	corbet@lwn.net, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all, do you have any comments for this v2 patch?

Thanks,
Lichen

On Fri, Aug 15, 2025 at 8:15=E2=80=AFPM Lichen Liu <lichliu@redhat.com> wro=
te:
>
> When CONFIG_TMPFS is enabled, the initial root filesystem is a tmpfs.
> By default, a tmpfs mount is limited to using 50% of the available RAM
> for its content. This can be problematic in memory-constrained
> environments, particularly during a kdump capture.
>
> In a kdump scenario, the capture kernel boots with a limited amount of
> memory specified by the 'crashkernel' parameter. If the initramfs is
> large, it may fail to unpack into the tmpfs rootfs due to insufficient
> space. This is because to get X MB of usable space in tmpfs, 2*X MB of
> memory must be available for the mount. This leads to an OOM failure
> during the early boot process, preventing a successful crash dump.
>
> This patch introduces a new kernel command-line parameter, rootfsflags,
> which allows passing specific mount options directly to the rootfs when
> it is first mounted. This gives users control over the rootfs behavior.
>
> For example, a user can now specify rootfsflags=3Dsize=3D75% to allow the
> tmpfs to use up to 75% of the available memory. This can significantly
> reduce the memory pressure for kdump.
>
> Consider a practical example:
>
> To unpack a 48MB initramfs, the tmpfs needs 48MB of usable space. With
> the default 50% limit, this requires a memory pool of 96MB to be
> available for the tmpfs mount. The total memory requirement is therefore
> approximately: 16MB (vmlinuz) + 48MB (loaded initramfs) + 48MB (unpacked
> kernel) + 96MB (for tmpfs) + 12MB (runtime overhead) =E2=89=88 220MB.
>
> By using rootfsflags=3Dsize=3D75%, the memory pool required for the 48MB
> tmpfs is reduced to 48MB / 0.75 =3D 64MB. This reduces the total memory
> requirement by 32MB (96MB - 64MB), allowing the kdump to succeed with a
> smaller crashkernel size, such as 192MB.
>
> An alternative approach of reusing the existing rootflags parameter was
> considered. However, a new, dedicated rootfsflags parameter was chosen
> to avoid altering the current behavior of rootflags (which applies to
> the final root filesystem) and to prevent any potential regressions.
>
> Also add documentation for the new kernel parameter "rootfsflags"
>
> This approach is inspired by prior discussions and patches on the topic.
> Ref: https://www.lightofdawn.org/blog/?viewDetailed=3D00128
> Ref: https://landley.net/notes-2015.html#01-01-2015
> Ref: https://lkml.org/lkml/2021/6/29/783
> Ref: https://www.kernel.org/doc/html/latest/filesystems/ramfs-rootfs-init=
ramfs.html#what-is-rootfs
>
> Signed-off-by: Lichen Liu <lichliu@redhat.com>
> Tested-by: Rob Landley <rob@landley.net>
> ---
> Changes in v2:
>   - Add documentation for the new kernel parameter.
>
>  Documentation/admin-guide/kernel-parameters.txt |  3 +++
>  fs/namespace.c                                  | 11 ++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index fb8752b42ec8..0c00f651d431 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6220,6 +6220,9 @@
>
>         rootflags=3D      [KNL] Set root filesystem mount option string
>
> +       rootfsflags=3D    [KNL] Set initial root filesystem mount option =
string
> +                       (e.g. tmpfs for initramfs)
> +
>         rootfstype=3D     [KNL] Set root filesystem type
>
>         rootwait        [KNL] Wait (indefinitely) for root device to show=
 up.
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 8f1000f9f3df..e484c26d5e3f 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -65,6 +65,15 @@ static int __init set_mphash_entries(char *str)
>  }
>  __setup("mphash_entries=3D", set_mphash_entries);
>
> +static char * __initdata rootfs_flags;
> +static int __init rootfs_flags_setup(char *str)
> +{
> +       rootfs_flags =3D str;
> +       return 1;
> +}
> +
> +__setup("rootfsflags=3D", rootfs_flags_setup);
> +
>  static u64 event;
>  static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
>  static DEFINE_IDA(mnt_group_ida);
> @@ -5677,7 +5686,7 @@ static void __init init_mount_tree(void)
>         struct mnt_namespace *ns;
>         struct path root;
>
> -       mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
> +       mnt =3D vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", rootfs_flags=
);
>         if (IS_ERR(mnt))
>                 panic("Can't create rootfs");
>
> --
> 2.47.0
>


