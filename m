Return-Path: <linux-fsdevel+bounces-35410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA269D4B3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F381CB21F6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14841D14E4;
	Thu, 21 Nov 2024 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEtqRIXZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D1F1CB515;
	Thu, 21 Nov 2024 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732187077; cv=none; b=LkA5dwcumM8or0KAFDdt22qRbgUF/XLJTpcwvMJFbgEIbpG3FmBK3l4p4rCJtdeI8KO5gRUZxwCdYuiCOzWKChzjtUrI6KQs+MFKjmOeGrBwAGgvwgOAtx2aCLJNDfHzxqcH5TzaC7/HsGlKt75hyYVjmhV/fu6YVckctgIa1Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732187077; c=relaxed/simple;
	bh=YgWq8GP1CiNveDGV8/qH0h5iO2E3LJwurLRSUmltGB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2LbOIWEsg6YDb6Vqx3hjRGkFt5UCjievonAy9wNoEYYpdFKIS62ig0wlhVFKp0wpvpf4mAE7C0Fa1WGLkry7PYlitNwECpGKA1e23Is+eivfxpAlMaDJQR+VL2qIlK3Ln7nICXFFC5Rn5hDbvzY+XYg3OClTtriv/WqE8QO+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEtqRIXZ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9ec267b879so134112566b.2;
        Thu, 21 Nov 2024 03:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732187074; x=1732791874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWLe/gk6n5WMpVM8HJR3stwF8Zq93MkvXhdaqi1d7jw=;
        b=DEtqRIXZ/jpHvftD+tbd0BqtR8h8ITKI+Afl3GjrysX0cIh9rSXNROEkyEKeUfsRxU
         NVCGaCf729eQDSTBEBDjt9GhFtQJbVVMZT4YWSy4pSo7j3cGxyLDXJB3Bn6Ikymgtgle
         BExzsytPCOjcaBT3AfIZNrl43zJfzXO23EC/UbZQ39nPUb1XNExyVzi89XKpF6J/1iyq
         w74EaUUpGty3lynTjhnrs04zMS+Kax9q3zJBrw0jf/otB18qz8Kq/rJ5ajZIydF6sC1o
         w6Do9BmBxif7WhL5mHnu2fHTqe+nmWNx+t6VkQxK/xQaYYu3fbCCv/79aMMf18Didp3q
         gGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732187074; x=1732791874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWLe/gk6n5WMpVM8HJR3stwF8Zq93MkvXhdaqi1d7jw=;
        b=ZRJeWVfAzkp5wbpejeO1BIkErq1/gpWCUQQdUwtkhbsvbhBqgQ6gaYjTFloKX0BX/C
         HLUShJOVtvJJCwXQRZ+64PWgpAxzqI5rdnd83QHR6EGd1lC1ICT88yV5RhlVCinwPHAY
         jw1aLkJsFnz8c8H2F0pwiSTh2X335hcvZ2wI8avcJ3Hm7PXqqjfyCK5vKjdXwqsNn7hu
         TG0QKeigzACMmSE5qoxeqPU7/w2RFkoTV3eN08/T0BHwRTSZQnyhXSsQmKhVNaEAiwe7
         EgCbM3RPklckKqIOzUEgVhhxche7QxzfmYykTe/rwSpHmiAj2qIl0J2gE4+5ncrShXHu
         8jYg==
X-Forwarded-Encrypted: i=1; AJvYcCUJianfOv7RsXfJp2qeDtGYbZBVBbwuYM2rEjRDh89OZ42YcMtQ1kHLCwUO8bCILY64iIWwSylCpAU4@vger.kernel.org, AJvYcCUxnYZzzCPgjxMlRq6BvvRWgX98caRA+YFvWvxUu9CheRg8OmsCIDL//OVcEhTILC07qu7WywbWnWTy5w==@vger.kernel.org, AJvYcCXDpsK8mawqnkncS/868CboEuio20XgO8uxi1zhcpGPuviei74fj2xEBLxTxeSkvssLY9IhRKzFgncdq00QwQ==@vger.kernel.org, AJvYcCXXMn4sSgqZh67DTSr2wA6hKsFlAWE0tbFrfTbSuttEuVk2lHUeUlPIWzMwiJN/OzD16hOq8MOIP+JPug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+kEiI0bpyP/0IMVkIneFH+i/5BfCGL/GSLUbAbYpSydi1Ebfd
	t7cU01s9Gn3I7THk4zZ9iWkbFElO+oE3wfVddv6+UjEp3JCKHwqVdOZKQZFTshl9wiHclp/Gp4X
	L+hoZWP2067gGK97vAb6bajgkAR0=
X-Google-Smtp-Source: AGHT+IGo1V0LUnv7NvqgfMaf1C8hEr3UYbvUtC1KgyBCabOlD4DOhJOY0ssHeuOlaKCL17yq+Twr91bvaNg7AVLf+i0=
X-Received: by 2002:a17:907:368a:b0:a9a:14fc:9868 with SMTP id
 a640c23a62f3a-aa4dd52d0d8mr643939966b.4.1732187073953; Thu, 21 Nov 2024
 03:04:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731684329.git.josef@toxicpanda.com> <5ea5f8e283d1edb55aa79c35187bfe344056af14.1731684329.git.josef@toxicpanda.com>
 <20241120155309.lecjqqhohgcgyrkf@quack3> <CAOQ4uxgjOZN_=BM3DuLLZ8Vzdh-q7NYKhMnF0p_NveYd=e7vdA@mail.gmail.com>
 <20241121093918.d2ml5lrfcqwknffb@quack3> <20241121-satirisch-siehst-5cdabde2ff67@brauner>
In-Reply-To: <20241121-satirisch-siehst-5cdabde2ff67@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 21 Nov 2024 12:04:23 +0100
Message-ID: <CAOQ4uxgL1p2P1e2AkHLHiicKXa9cwrFNkHy-oXsdGKA9EkDb6g@mail.gmail.com>
Subject: Re: [PATCH v8 02/19] fsnotify: opt-in for permission events at file
 open time
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, 
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 11:09=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> > It is not that I object to "two bit constants". FMODE_FSNOTIFY_MASK is =
a
> > two-bit constant and a good one. But the name clearly suggests it is no=
t a
> > single bit constant. When you have all FMODE_FOO and FMODE_BAR things
> > single bit except for FMODE_BAZ which is multi-bit, then this is IMHO a
> > recipe for problems and I rather prefer explicitely spelling the
> > combination out as FMODE_NONOTIFY | FMODE_NONOTIFY_PERM in the few plac=
es
> > that need this instead of hiding it behind some other name.
>
> Very much agreed!

Yes, I agree as well.
What I meant is that the code that does
    return FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;

is going to be unclear to the future code reviewer unless there is
a comment above explaining that this is a special flag combination
to specify "suppress only pre-content events".

Thanks,
Amir.

