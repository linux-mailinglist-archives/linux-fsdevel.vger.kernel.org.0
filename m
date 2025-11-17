Return-Path: <linux-fsdevel+bounces-68767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1821C65B4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 19:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 94DF428BFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 18:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C66831327A;
	Mon, 17 Nov 2025 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="JeQjlk53"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D4827FB32
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403946; cv=none; b=RKghycBYqX3wNFHHr7RvPR7ciN6aHbvTzO5xCepMig9klTgDJebcGbjDAARWuQXN61kNwZHsQqEwwDN9omVnj3iGbGQ+S4qzLDCWi/UQZxLH0gTU4P9h9Nm3cZc/VDysVs3Vmevysuw4w5q3YE8Cw3AND3uInTkFqM9Gi9blskU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403946; c=relaxed/simple;
	bh=dMycsWk6alcimZ9cye+sIiGHVio6V3dIKHH3BxJbFzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7+nFxKo1jpDKig/fig8JPITXYDILQVauhuaAMGLXho9meB4VGXTXvb8BmXHPUlFR3XzleVwJKs7CWwg9O8qoFvgIsJ1BOsR+jsBp0PpMS414k+WiNSlunaXfg3EKNFD3AgP/Fjtuu4xJCQFnas3ecEOIRrESTZW+HwVVqsywNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=JeQjlk53; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so7849911a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 10:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763403943; x=1764008743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMycsWk6alcimZ9cye+sIiGHVio6V3dIKHH3BxJbFzo=;
        b=JeQjlk53pq2zJjWMlm1xSgj7kGKmc5aUKot2CX4cKkELU/EEVPJhKR2EBqlXCae62H
         Q5OQMucd7llOJItyTh7wjKn0xn8Tv2/pdb29l8JqeniatA7lqmQnlsy+9Lz9fJefWIZj
         ohRtOO6qC3C4yDxmZhxEe08vq72Nn6/XiuXWrA0kn4yLxeDr3n9rTyJIk1cA/293oWSR
         rHO/wdIcRZmkbETgJN9MFNeqyPNL1R14An0FPBEMK+Y9mltcU+XiExEGWiYZ+SoWYSE8
         cNWVCvJ+3bZmtZe8hl+3lvFp1IdqEBr2BY2Jbg4K5jwzT+ESwa1Luzu0v4eyPLDOvHZi
         v4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763403943; x=1764008743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dMycsWk6alcimZ9cye+sIiGHVio6V3dIKHH3BxJbFzo=;
        b=GM+MeRwYRrJipGVzWGQpkU5VSQMXW8kyTFZpP5xb0stSMU5zJK3Get+mpv4MMnG9F1
         AoAfFiapPz6XuR7J/SzGER2vc3vg0OnOdlKvCvrtcDxTXA8gnNwVj7D2iWg4cxAQIbP0
         aPurkQ944/NKkzCWn6CaIT1LtPQXjEMFJnZFcvZfBBZfUdeyauEMny/VeykkRuIGPRWU
         bo4IFMHKFrJpBbHVxDfu/YDUL6iJXaF/3f0uUkfQBqHqUABocWbTg/XoGQHI2dBnMLyV
         SnCtacUqGt5v9XIKnrB3kDh7hFb2kHT57sCLwZBisMTFYi/zpFqUvpeoH8kDR3rc9kJy
         PD3w==
X-Forwarded-Encrypted: i=1; AJvYcCXZOaaRjF0I6x8A7y1At0GIyhLV544KqbP0nWpvLO9TFHD+1+26icoibPDVl1ilfHTuC0fD2rHFkreHezun@vger.kernel.org
X-Gm-Message-State: AOJu0YzQncwHNumChR+OtRBRVk1yeNW/e6DTt4/22GXdHfUS9iqcRQGn
	wxsEqo4yf8+eq7sBSLaSiLlHjP8V4c2nz1cL+oyUjar/Z440NMuVVjemQOdUFOKbVayLynDJw8G
	m0019rPfi424eXmA6vehPlmrBMVAcIHk16j0tgy3uPg==
X-Gm-Gg: ASbGncsUPdjT4uLP0SFJEAFBZVweQi7kJjy+NwcuTCo4Kstv3mB0Le6g0OU6+tYg83V
	EFa/kzGQHL2iSGa8Ph9U9/l5LfjbYjTmFBrkWvetvnQbpCH3vWoGU9BPCxij7oF86Y4KCZYrKQY
	HE5DlkU0SO0XaLmv48Rq1evv8iAd5GNWYV/rFrjq9ozhDu31bxGHJMixeIdpSi4WYjmQqrTk8uk
	4NCHjDgIPK3gTF+rspZjMDav/sF/BUw+ySFabwaMCp5+wXzY7O5oDcAxoLxIju60kEJkhQ3FBIn
	4rQ=
X-Google-Smtp-Source: AGHT+IFhDEducLN7T5Jy1DwFvPprFdHcnJ42WfejgEYNti2gLXiHYmpyBjQ/4t56trSFuAgRCxac7v4hY1mMU4Ka3uY=
X-Received: by 2002:a05:6402:23cc:b0:640:b497:bf77 with SMTP id
 4fb4d7f45d1cf-64350e9eb61mr11509176a12.35.1763403943114; Mon, 17 Nov 2025
 10:25:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-12-pasha.tatashin@soleen.com> <aRrvaHh-cP8jygAF@kernel.org>
In-Reply-To: <aRrvaHh-cP8jygAF@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 13:25:05 -0500
X-Gm-Features: AWmQ_blTQifSbVFjHBESf3b3IYzXXqzrvc6uwjRPXvt2KinsJtxmdBdOtqW5SFc
Message-ID: <CA+CK2bD_a=C0h-y4HDWPYV1VOWjM7V4gcocwekA6M9h5WbiqSg@mail.gmail.com>
Subject: Re: [PATCH v6 11/20] mm: shmem: use SHMEM_F_* flags instead of VM_* flags
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
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
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 4:48=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, Nov 15, 2025 at 06:33:57PM -0500, Pasha Tatashin wrote:
> > From: Pratyush Yadav <ptyadav@amazon.de>
> >
> > shmem_inode_info::flags can have the VM flags VM_NORESERVE and
> > VM_LOCKED. These are used to suppress pre-accounting or to lock the
> > pages in the inode respectively. Using the VM flags directly makes it
> > difficult to add shmem-specific flags that are unrelated to VM behavior
> > since one would need to find a VM flag not used by shmem and re-purpose
> > it.
> >
> > Introduce SHMEM_F_NORESERVE and SHMEM_F_LOCKED which represent the same
> > information, but their bits are independent of the VM flags. Callers ca=
n
> > still pass VM_NORESERVE to shmem_get_inode(), but it gets transformed t=
o
> > the shmem-specific flag internally.
> >
> > No functional changes intended.
> >
> > Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thank you.

Pasha

