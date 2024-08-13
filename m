Return-Path: <linux-fsdevel+bounces-25755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D937B94FC15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 05:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3651F229BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 03:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8191B948;
	Tue, 13 Aug 2024 03:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MK2AdNSr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157058F5A;
	Tue, 13 Aug 2024 03:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723518401; cv=none; b=HOsX2mDZOkjw7/gdFAYM/WxB8ZaUHdk+IJxB78esLfeD67W0wLGkUCWLbGR3F44CJaQRih/NcM9nW9ToFaVcJiFOmV013Qe9Qgkl8MeTzYlUySXJIY7ni8S7WKgqg7KhVK+ilRMXKPsWOPlPyJprfuOUguTns5IjIDZG9obnywY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723518401; c=relaxed/simple;
	bh=qLgp+FDIk5aX+U95eCZREPh/C34i0ltAR44kl+Z1Hvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwX3MumE2wfCBDQAoplI1S90rCZ2tUAGfnhKasnDnELL0/bANggFX2781/xfjUdRtp/b0qPQCHL8YtUTh4BTKorK3Xy0yUWjzlWl0rdFGUyKPeTSIPKgqPjhOxeQtVEcE9Cd/mX67TNnGZWG7EAcuk+EgC84RVhPnhQwtoPQmB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MK2AdNSr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7107b16be12so4158913b3a.3;
        Mon, 12 Aug 2024 20:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723518399; x=1724123199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoKhZzfJJfzz5NYdN/8JKDEU39D5A8RsoqhUzJC6Q7w=;
        b=MK2AdNSrBa1q4PxGq0RHox7rHgOFsoIVFeboz6rcaVyUeqhmgVAKevaoQGIrfLkRAr
         LrUAs7XMPCoPMm7jJNBEBFzIHi476EP2+Kh3e73drdivEytZ14T4KalY/DvfcIGHaJ3l
         Lp1IAWLkGS0UmWLEt9Tdc3a6dM+cOD+9/nKcStwmbrQ/+ACrUvnVD3CZHQ+AN20mbYBk
         1S1utkNJYvVOrMbEpu/kPLTz1flDYGhg+JijNotaJ3EmFhx0o3Rzr0zku5CNBH1ZJXfl
         G+7LmFX/lPXF2Fl/HQLZ9I8fg5sf4L5okYO+y8zU624NGxovWSNTAJ8RkIofONbWYRO0
         Qwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723518399; x=1724123199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PoKhZzfJJfzz5NYdN/8JKDEU39D5A8RsoqhUzJC6Q7w=;
        b=F615EP02j7ioyow+lL6yezhwCTEkZcQYGjjtQ4sIlgd6TCvkIFZpIas0vxVBL2S9Ir
         +ziB+ybC2svu01N1KJd0jo/AD4kenQhrBjnLPBkmcuDGDNXRg8Uemjy4jXrnZ/xjaxdQ
         hoDwiCE8M3h8d1pkkhl0y+kS4/GHC/SoU94hmiqD0OxrbbeQKHKDspYcIRXh1f2T3h6J
         DxdzlqsIlMSMbzIRNJZRVpl7NqAV9x7GyPJD0+H5kqar0UpIFWE5nxZN6fzXV1UEzS96
         4SdNBySbTLAJdufAh1b7rH2cj4c2o013i2nsi+eZnPdi81Zyl5/CiVgGnYeus7KjTfvL
         d95w==
X-Forwarded-Encrypted: i=1; AJvYcCVUd0Kqb3GLA8jq/p0zusZ3OFHA43JrGr/99Ey9e2soLjij8mVjUZZPjD3cspYPQL+KSHiYzhEaj3FulVceCY1HmaBbajVo7ZUx4fcpj5OzRBBne5dXZ7sb9DDoYJdg6P3VL9SlJOxQwk8j/6zNcNX2/5e9ztY9UqvCVA==
X-Gm-Message-State: AOJu0YyvGB1Et+YOQPBdLuFOix3AksIT2ttk9/sOvnsxZplIs1bGyogw
	OqNimhf920E65kFM3Vmjp1ZRnnrQNJJe1nh5gkkj8NDg+Nj1q3yHHsCzQXKz9tUN5gkou0wiNmW
	UXadOlKmJVHBVtF5UDM/fFQntXgo=
X-Google-Smtp-Source: AGHT+IHX8wZ/bPU/GlY6AQHbS7k7uR+QrtnEQNfEaBVgSMhUvVXsqF1j4Vx8qbOq3HDY0vOjZUETY+EVV21p/TXBeu0=
X-Received: by 2002:a05:6a21:1813:b0:1c4:d8ec:b59f with SMTP id
 adf61e73a8af0-1c8d74c5a2dmr2691569637.25.1723518399241; Mon, 12 Aug 2024
 20:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813002932.3373935-1-andrii@kernel.org> <20240813002932.3373935-2-andrii@kernel.org>
 <ZrquMOQc8vAjYxIB@tassilo>
In-Reply-To: <ZrquMOQc8vAjYxIB@tassilo>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Aug 2024 20:06:27 -0700
Message-ID: <CAEf4BzZPUJCqdtnhKNW=fJ7DDGvGFsARN0JXM_DnbPCRqrXZag@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 01/10] lib/buildid: harden build ID parsing logic
To: Andi Kleen <ak@linux.intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, osandov@osandov.com, song@kernel.org, jannh@google.com, 
	linux-fsdevel@vger.kernel.org, willy@infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 5:52=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> > @@ -152,6 +160,10 @@ int build_id_parse(struct vm_area_struct *vma, uns=
igned char *build_id,
> >       page =3D find_get_page(vma->vm_file->f_mapping, 0);
> >       if (!page)
> >               return -EFAULT; /* page not mapped */
> > +     if (!PageUptodate(page)) {
> > +             put_page(page);
> > +             return -EFAULT;
> > +     }
>
> That change is not described. As I understand it might prevent reading
> previous data in the page or maybe junk under an IO error? Anyways I gues=
s it's a
> good change.

From what I understood, one can get a valid page from the
find_get_page() (same for folio), but it might not be yet completely
filled out. PageUptodate() is supposed to detect this and prevent the
use of incomplete page data.

>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>
> -Andi

