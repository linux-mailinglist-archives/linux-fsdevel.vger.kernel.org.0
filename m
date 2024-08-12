Return-Path: <linux-fsdevel+bounces-25717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D6094F7E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 22:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 856B2B2207E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 20:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D772194A65;
	Mon, 12 Aug 2024 20:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/B89nmS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588EF190079;
	Mon, 12 Aug 2024 20:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493134; cv=none; b=R90nkxIftYCck3s7l+Ohc0pTRVOuxc+63WAUmErZ9A4bKfx69UMTryWdzDH2TfQyUPfCDyNrgvZKWFyQaI1a/BWsvJBlnnjhMN8CA5icSZmZBoduAFPM8KCJ+Km08C6c+h6cW+iB3ZmJbMrVbsGkhfN80Teo+do5/wbOVyVPogY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493134; c=relaxed/simple;
	bh=VVu+KZSQsorUfB0SZirPjH/lXsE4flsSEaW8bF6PkNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yyj7V4ZW+dTvIB8v9YavMDkB0yo//IuCAuAUaCgGNQqNV7RGK9xKbcNT3p+Dbg2zn69NwFEWJNqsIN2i4ecIrb/qN1X0AH60l1IGK9FNYxG97829ZlD4J7bI9olHrpJcUHqQg8pN8wiFp1eWP55ojOnJhzwoIA6mSjogZm/XCHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/B89nmS; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cd34c8c588so3145122a91.0;
        Mon, 12 Aug 2024 13:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723493131; x=1724097931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVu+KZSQsorUfB0SZirPjH/lXsE4flsSEaW8bF6PkNw=;
        b=U/B89nmSiK245IxUnGrIbJEy/gYzutwZWzegSqpLBDRWyI+7nVSq4sYytl/hFeUpsY
         23C61q3J/Frdc8+xuRewLMoqFWrT0A7C9ZHTm9vt1YAtLm1zsmtAQwlKsuHtTmz9xMLL
         B/G1pqoqAc+Xxrx9z/EqiLN0VvtM3QUXKVeOhoLglLEu91UdU4/ziov3HoYd+sz8oQrn
         pV0tziNG9ryXkKhStIIOfS/e9nufX2EVhj8Pr6jIUKqun4NMj8hYo6Sx1w2fLhBf/1MR
         B8NKJdMyE7m+G6O6Q61ul6VH2DGDCqgGwyH1DGLm/AhznBXxga/YdauC9dTDl/8/fBQs
         hYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723493131; x=1724097931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVu+KZSQsorUfB0SZirPjH/lXsE4flsSEaW8bF6PkNw=;
        b=QZUijWcOrx68Cl30jG+8rUSNpf4ZsIknianaBS+ygtpSJmx+WZXba1edKwSk//MsNy
         vPyCnWTC6VSxU2VETGphBeLv5wcLtqCgfH82spI+BpyDg4tiKW7+QaJ9Oywqfu8Tj+XB
         weaptQsTutJiNgxSuuS1VsGQqIcd2Xs/k5hmZiM9ZuPBynioNO2sq8IEmsGqkYmiywHl
         GeFF6temiapzy3x02AqxYXXpw6BrryphkYsOEJWKTamBKDR6CdJ5KYIaNvq2cGDOeCi8
         pHpesM4s1kv7PyHBBDYO2YwmUo+GcLmgnzGmXwz7NrkACNbrI1ThX/ySqsDAN+HATwFW
         0fbg==
X-Forwarded-Encrypted: i=1; AJvYcCX8rpQkdDCmqh4YSSdOohTOvnUjflyP5d2HJeRfitpJ+R8MXwQUuQ9swvYftcdfNaj8sV5ZkurHM9yLe7ssXjkOL44/bJXfsGQwOI1p+DjqDFVBTlHhgrzjn6h92A/xKdf0DMM7yK4eenZewA8BwmtjCWN5qb+J6F7Ie19MuS/VCgvGKWxo2bjOnl+Lz+iorVTfQ4u2Bpy55cXnHbyvRc14lv93FivAlIk=
X-Gm-Message-State: AOJu0YyvL30+rz8Ge1vgcvwll9Q21hGWpHAcUKFmiDm5yW1fLq8x9aKH
	bc7D1ICoTBt2s9oFUxT8KUcjZTvZ2Re66mB3JDXSnZGZrMyuf16WWpx4NImGFPGNb8FvR7y0DtR
	xJRmlFzZgWkl3qFzeY8UvMxkf3B2ina/q
X-Google-Smtp-Source: AGHT+IHz+aAA83Gm+taaLfYraLEur6TUFDXGJd8A/3O3VjbNsRj7u2VfGxSpn4DmYnPJwdOzH/t3d0GqStcPj6jZJbM=
X-Received: by 2002:a17:90b:4f8b:b0:2c9:81c6:b0eb with SMTP id
 98e67ed59e1d1-2d3924d607fmr1490575a91.5.1723493131549; Mon, 12 Aug 2024
 13:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730050927.GC5334@ZenIV> <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-17-viro@kernel.org> <CAEf4BzZipqBVhoY-S+WdeQ8=MhpKk-2dE_ESfGpV-VTm31oQUQ@mail.gmail.com>
 <20240807-fehlschlag-entfiel-f03a6df0e735@brauner> <CAEf4BzaeFTn41pP_hbcrCTKNZjwt3TPojv0_CYbP=+973YnWiA@mail.gmail.com>
 <CAADnVQKZW--EOkn5unFybxTKPNw-6rPB+=mY+cy_yUUsXe8R-w@mail.gmail.com> <20240810032952.GB13701@ZenIV>
In-Reply-To: <20240810032952.GB13701@ZenIV>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Aug 2024 13:05:19 -0700
Message-ID: <CAEf4Bzb=yJKSByBktNXQDd8rqWPNCU9EWziqQhFBnCVuTGKCdg@mail.gmail.com>
Subject: Re: [PATCH 17/39] bpf: resolve_pseudo_ldimm64(): take handling of a
 single ldimm64 insn into helper
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Christian Brauner <brauner@kernel.org>, viro@kernel.org, 
	bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, kvm@vger.kernel.org, 
	Network Development <netdev@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 8:29=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Thu, Aug 08, 2024 at 09:51:34AM -0700, Alexei Starovoitov wrote:
>
> > The bpf changes look ok and Andrii's approach is easier to grasp.
> > It's better to route bpf conversion to CLASS(fd,..) via bpf-next,
> > so it goes through bpf CI and our other testing.
> >
> > bpf patches don't seem to depend on newly added CLASS(fd_pos, ...
> > and fderr, so pretty much independent from other patches.
>
> Representation change and switch to accessors do matter, though.
> OTOH, I can put just those into never-rebased branch (basically,
> "introduce fd_file(), convert all accessors to it" +
> "struct fd representation change" + possibly "add struct fd constructors,
> get rid of __to_fd()", for completeness sake), so you could pull it.
> Otherwise you'll get textual conflicts on all those f.file vs. fd_file(f)=
...

Yep, makes sense. Let's do that, we can merge that branch into
bpf-next/master and I will follow up with my changes on top of that.

Let's just drop the do_one_ldimm64() extraction, and keep fdput(f)
logic, plus add fd_file() accessor changes. I'll then add a switch to
CLASS(fd) after a bit more BPF-specific clean ups. This code is pretty
sensitive, so I'd rather have all the non-trivial refactoring done
separately. Thanks!

