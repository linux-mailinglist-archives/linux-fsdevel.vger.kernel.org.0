Return-Path: <linux-fsdevel+bounces-28704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456BF96D21E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 10:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27F1286655
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 08:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2407F194AC7;
	Thu,  5 Sep 2024 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AR5c9YsQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216D615B541;
	Thu,  5 Sep 2024 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524959; cv=none; b=Qy6CAeJENPFDpyWdZyYZKUe9T8V01HGMDwlhNE7B0BIJ5kP3S5bDBn4AIibqz5bG9mdS9h6/x2LtPwpQ1pbeggSi0W03/rnn/ptN+veVIXPiffkzsR2Xnf7yGh7VeNUOtqj2R7OqZPstoUoI7mpYLbJHvH6ZlVR82J07UBJNAVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524959; c=relaxed/simple;
	bh=964yTuR9TbzIAm3GHI4rZir3hp6DrIJlfd66XkQRloE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIcdfZ5TXbOPWgNwxuMI20TOXpvVqvLjmc+uil85UnQXptVG1zBCEgXvI1jEqPldjlm7OCUJorulcF9Mpvc6fms8WvsvdmQ6IifD4pa5cZcgv1i0AG0GOH+kE+lSpLxIazIFdew1mmyb5slQc39VnOvd+g1oW2TqX4Yvf8rFBws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AR5c9YsQ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a802deea39so33711585a.2;
        Thu, 05 Sep 2024 01:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725524957; x=1726129757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQ+fDR63qG5ONZINOJ6uvtkYLtiYBt9ojM8SX48oAdk=;
        b=AR5c9YsQ34bB/lFobloaizZtilr7b9GWU/QvHelCc0UFaTcPcXTQpjQ3R2w5PKL5Wf
         BIhf7CIoOQoI5gn6CiB8EyYV1u3Es5ST4TTLBcnJBGh2aw4NwJuBvyamWca7JD1H7Qur
         jKR/6+Y36jZ/GR5Lv1u2bc/4IiWrhxk1JIyIKe0nM4544/+1VFx6RaSqBEaz+EOvLR8f
         okcw0Z9DB39D+aJPB84faYtZqoLrr3b4iwJO1EFoA5YRGJgzjRwaXMGWPzgxFhGtxgzq
         8Eu9g2osf82fLtoAWODiRyCAgbIwEtEwBI3tZbo8/CSMPKiDIkHNgc1SAkXObYuBUhjP
         NJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725524957; x=1726129757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQ+fDR63qG5ONZINOJ6uvtkYLtiYBt9ojM8SX48oAdk=;
        b=DwRRha6bLmjuPbPS4LqmT8Rmi/g81Wz1TWLTaNIzGjiiKhSgMXYJInZ5r9rzXHhSzx
         BFDbeck5xvi3NUn3qrXC52LECe1VEF2s5rDQNTP+s/dkzIYnr2KkV50HFCRyLUV5Nkcz
         NXj5unC+hSL+yuERkijgaYR6X0XNi31P41voxspNJyebEvXPpb2xH/LppMFhh21Nhk45
         7dzZr2clT71VmNuiuYiGtgerd6dyVGjiJ9auOVXIyPjRst722M8T5LKhV6cBvldqdaAr
         BKlKBW21pACdfraVIOCBh5wINXmpPHnosdf1Tef0CNfmouUxVdN80iIbMGTZ2xBLhIfU
         uYIA==
X-Forwarded-Encrypted: i=1; AJvYcCU3Ln6v4TZShO+adpS0s1m7lXTzKOpayDjsDmGASSjQTteumRUfZ75Uv/R/bkc/8/nRGm8REp+kYrW212E=@vger.kernel.org, AJvYcCVmYANElYlsDjSrov8nXmpk8SegzgCkB5kYMsFVIcx6PRLZ2SZ6m1OINzmc5dAvqQm/r8lE2SQFiqBsXUXPkA==@vger.kernel.org, AJvYcCWMI+W2Ac+4WDndA57bWNF9CEfEo1k04LNd9kNbKfREmpP221f3HPXhdDkjZekw4q0NLNfnd4FLiSYk@vger.kernel.org, AJvYcCXRi2HHmXs8ArEPtlIXgg3HVEeUzqJ05SbsItp5dsIOc7o2cIusnvTHItC7Ly6m/kXD1NwaStSbsQk0J/3Ldg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuxENOgwrkQvRj18zyoOgIwjhuCC477fgIe4nTuh0AQrrxzgku
	j55HrE20M3f7dCAcWFOpliYcJbYgkPgCvxa4WhPhJwU4i0PR3108lpmMKR8t0rCaJVOXD+t1Lp6
	hDIpmqI9GeiM7RS4Wovr0RxPvg1QlQ8osxubaCA==
X-Google-Smtp-Source: AGHT+IGZ0AETQxfdaEvxYsfVejWywusSIHZm4WCYr1dgsHKToFW8X9SeSMNoiE3iG3b6zr9Wtdecd+e5Vlv4wJ+sLRU=
X-Received: by 2002:a05:620a:1901:b0:7a3:524f:7ef7 with SMTP id
 af79cd13be357-7a80418135emr2520162785a.12.1725524956906; Thu, 05 Sep 2024
 01:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725481503.git.josef@toxicpanda.com> <12aebe1a4f039d0234ea74393a39614c0244f7e0.1725481503.git.josef@toxicpanda.com>
In-Reply-To: <12aebe1a4f039d0234ea74393a39614c0244f7e0.1725481503.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Sep 2024 10:29:06 +0200
Message-ID: <CAOQ4uxgnm3a7vF2gtYaUBNGO+t1eM2OvHAhM-SkK2Qsrifb8vw@mail.gmail.com>
Subject: Re: [PATCH v5 16/18] xfs: add pre-content fsnotify hook for write faults
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	brauner@kernel.org, linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:29=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> xfs has it's own handling for write faults, so we need to add the
> pre-content fsnotify hook for this case.  Reads go through filemap_fault
> so they're handled properly there.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/xfs/xfs_file.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 4cdc54dc9686..3e385756017f 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1283,6 +1283,10 @@ xfs_write_fault(
>         unsigned int            lock_mode =3D XFS_MMAPLOCK_SHARED;
>         vm_fault_t              ret;
>
> +       ret =3D filemap_fsnotify_fault(vmf);
> +       if (unlikely(ret))
> +               return ret;
> +
>         sb_start_pagefault(inode->i_sb);
>         file_update_time(vmf->vma->vm_file);
>
> --
> 2.43.0
>

The end result is so much nicer than early sketches ;)

 Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

