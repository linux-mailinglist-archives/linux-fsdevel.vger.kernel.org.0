Return-Path: <linux-fsdevel+bounces-10890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F3E84F2A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF411C259EE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 09:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C7C67C67;
	Fri,  9 Feb 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Exd8fA8w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AA267C5D
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472229; cv=none; b=AMhJ/4daAxIpqgPY74oTsDvBYHf79ces3fVC1lp8GMngOgp6yT2+hMS1IF2N5jVYrbjXeg0Tbx/+SsvPH1Vm8IaQxY2Rjickg0ZR5JxtA/59iwiLbVFNBDUq6D/BpEJbJM6yMmmE50jpPbkT4LtybJDP9LTsE7Z3Viwu/pXobhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472229; c=relaxed/simple;
	bh=Bn5RkImYl8J6pTC20AM8lGVV4tK6w7pGgStnPFGpx20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzKaqVaOjaXMlR3jklN28QzadLbt6aB3X2AILLp3zTKx9DWrhNEeLvgf3v2nc8gj8h9pmLMAVlYo+Ix99uTxSs4HczqIbmGW4/NTvh4MAJ9W8EDt0EHuTK6RPTVbcdFiQnUfRvk/SB4eSWCWWV34xnJM8uzek3VGnyX1mvJbY9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Exd8fA8w; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55790581457so1198023a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 01:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1707472225; x=1708077025; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/JNRz50THrJhcBN3+4zL2hC4VNdKTNtkNYCxHgnlivw=;
        b=Exd8fA8wvCnbQhKgd8Hb/ypurZXbDpveXDh/2SBRpb7pmAu+zestYO8XpYDYn0L2v9
         jiWJekZivH3hSl9lvs7L3u6iVOJ0UGNJF2Ja400DIFoNg6nCBBSrDrgYb6TDyWJIzLh7
         wNlXJiX6nUr72MOoPhv4TwOH6O13agIMeVAJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707472225; x=1708077025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JNRz50THrJhcBN3+4zL2hC4VNdKTNtkNYCxHgnlivw=;
        b=rBOYfqKFHh5qfSlm13ph7Wk8l5yFZz0umfUEXJCPo+0OsecfUiZgkcYVVIMrYorIvA
         EK4MlZ0TQNZ/4SPrDv7XbrfBTOnmNyUBhhIAskUpctigIhUIW4uRkoq0GoTdzikRDakH
         EQa/6kV6jr/zPsIrGAvKsCEc8iUx/BkE/Zi/NTGY7sUPSUlhyVePWQji4gTvZ9qzGRiM
         pQ4GO/U0GDnqpxsCkFuCHFxQgjU3V6Vu6uLdTKI6LAyx1YJe9MSG6OH2v4bQN8ADxdsO
         bovepSex5Cc5AAgbzEkFXLC2YORvbPNl6q/6CgR+O2mCMlelqRP45RWaADL7mk0lu2Kp
         4P7A==
X-Gm-Message-State: AOJu0Yxw83hYVdR3+tQzavf3Eh3n3ESq2+z2Mpy+4I1d7KKFPHajDpeS
	5YiIJg/QboNRytPdNnLenSCX2QCkg6CtTQtA6our9AAaSWM1AFMFkwPVAP2ob4nNeNU/6+dkixm
	zQimOBB6Z6E72CKu3C3Wy7w0tAXla5tlD7BB/jw==
X-Google-Smtp-Source: AGHT+IGViPqvCwulF+cP8RnKGxNKMbtFfe+DXWnF0xKnYdw5cXFhSUbM7FlqyEjBKUQz4hvjed+1YTBpfnfHjo5GvFI=
X-Received: by 2002:a17:906:3415:b0:a3c:266:954b with SMTP id
 c21-20020a170906341500b00a3c0266954bmr261283ejb.22.1707472224711; Fri, 09 Feb
 2024 01:50:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208170603.2078871-1-amir73il@gmail.com> <20240208170603.2078871-3-amir73il@gmail.com>
In-Reply-To: <20240208170603.2078871-3-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 9 Feb 2024 10:50:13 +0100
Message-ID: <CAJfpegvzxAeq-mWJjwVNxi01zGXqUek7DZH3d0Kb0VO9FjGk3g@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] fuse: Create helper function if DIO write needs
 exclusive lock
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 18:08, Amir Goldstein <amir73il@gmail.com> wrote:
> @@ -2468,7 +2493,8 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
>                 return fuse_dax_mmap(file, vma);
>
>         if (ff->open_flags & FOPEN_DIRECT_IO) {
> -               /* Can't provide the coherency needed for MAP_SHARED
> +               /*
> +                * Can't provide the coherency needed for MAP_SHARED
>                  * if FUSE_DIRECT_IO_ALLOW_MMAP isn't set.
>                  */
>                 if ((vma->vm_flags & VM_MAYSHARE) && !fc->direct_io_allow_mmap)

This last hunk seems to belong in the previous patch.

Thanks,
Miklos

