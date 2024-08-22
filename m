Return-Path: <linux-fsdevel+bounces-26848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C29CE95C149
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 01:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99811C220AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 23:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788751D1F78;
	Thu, 22 Aug 2024 23:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8jsm1LY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB01CFEB3;
	Thu, 22 Aug 2024 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724368036; cv=none; b=nvDVs4Lr70V9927WUnKBd1l8DkQCYN78XHUUtRHaIQVk7nTIzsj/FT4JucQcKib8uCrVJ6UEMP7Zb1owx4DaqVtWRrdac8CsyWs9E2xcb+PA2gI5JPyCKiCZjkq9AGZjLk8EZMEVjZ41c8CBGxHqEMqVHLIv3Akzq8m6Iag+MtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724368036; c=relaxed/simple;
	bh=g/yR1oyuW5dUfE1pGvUUNWlna3e+UQ6zvNvV2ID79dw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jCqcVJ4NwUcf9AFr/fgAEQZSGNNdi8lzDkGc7tTVGEeNSBGly0yDySjibcE9/nT4t1h/2ZFiAAIw3JJ4YqRs9gthPI/kO6ZUBKI71Sof4Pa5StEgbsbP5qVX1c5p6IbXx2BPAEo/k6h/NRcOpoWyPNP+P/LrJRNFU1E7CH2IjiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8jsm1LY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20231aa8908so12568725ad.0;
        Thu, 22 Aug 2024 16:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724368035; x=1724972835; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=25rria9l2Vxvu8mBrpTAlGGFpCc8saIzLflzJLJIDtk=;
        b=O8jsm1LYJdFzo3Hcx14m5vJHZIMKKi7WQ0+9HGwEfFYgSCvJC/86o+4Oy4jYzxq0Jh
         CSL00roDC0VaIPXzqjJhOPpGzIkIhskPXh0xAd4+bikHNF5Q219CwW3ouPbRPyPC0i4G
         WyJ2EZ7lWFsKr/7dxsgkQ69ZltN382FCp7NW3dqwgRgjU1/gs6cW5YER35d7uRpxvYI4
         ZuDDgkj4YfLK0SRJsjgmnbngLFqU86LcaCx/xzL3opGd/MydA2ov8YiGl5TexX67C2Xa
         YtCh1VoQfsj6euaBI1xKEgFak2qJfHpuloTCEbFrbxVm9K5fXwPdwth+FuNn79ymeQG2
         U7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724368035; x=1724972835;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=25rria9l2Vxvu8mBrpTAlGGFpCc8saIzLflzJLJIDtk=;
        b=DjW/5w3GT448AoI+sTojkjZEhiwA8huIjDTdSitzf/Iz981QW5a8T59JBUgk7WbxYC
         0LmjGy1SoWgGU/AmCF1Lof5c6zdccULaeWq/q+/6wk3SliyJP6PeN3Fz2Qx/tgTrhZ1v
         mofai/GvCvU96cpv2Oqz6iLTtZd3fQAxWO+AborCVHb1A41vIpPn8d0++r8lnZ2TT+rl
         hYuXNKJtj0ftC4ZUFRwNqmTGRmd5CIS/O+Kgn/D7XrkaSvoqk9k+5J5Ucrs8qyD1WSGi
         XoN++uinhIY8DquaINQo8BIsFFcaSyGdoV5diOXiylKupG9/vHmpVN8T34uiqLJ/LE3s
         ftag==
X-Forwarded-Encrypted: i=1; AJvYcCVDgQ9mWTlEpxi55JhiAKt6P6UKFDDZZ9RxugkZdO7T8oibxnihrwNh35zM2hWuGX0KldY=@vger.kernel.org, AJvYcCW6OkuATcxw16JwMkw/JqZUPhQ5PqVTomcMdpTZxbPVBQfDJ7hXgAv3eTX1Eb+1/egbSrSCd43MjFextgNGIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYYgtOMdCVN6/xpfWBLmPqznRs9me9XdpVSI/mPwYBKos2jopj
	+AM4fpOxyx0LCUWzN6kIP1WHXBdFdPHtqIhorJ8I0w7QfZ3LqhA6
X-Google-Smtp-Source: AGHT+IFCVbd+O3+tHUHIumODpX/x3CNRWRbS+1Xjcmu9d5sXHxkUM1SuMaz4FJz3A96sMQasxNxBSA==
X-Received: by 2002:a17:902:ea03:b0:201:f8b4:3e3c with SMTP id d9443c01a7336-2039e4a7777mr3572875ad.12.1724368034736;
        Thu, 22 Aug 2024 16:07:14 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203859f0121sm17496865ad.246.2024.08.22.16.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 16:07:14 -0700 (PDT)
Message-ID: <bb022c5f9672c0c54303cee5465e3a4542f73cdf.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 10/10] selftests/bpf: add build ID tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, adobriyan@gmail.com, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, ak@linux.intel.com, 
	osandov@osandov.com, song@kernel.org, jannh@google.com, 
	linux-fsdevel@vger.kernel.org, willy@infradead.org
Date: Thu, 22 Aug 2024 16:07:09 -0700
In-Reply-To: <CAEf4BzZULffF9_6Mz4dxm=owvSkyErt3kShZpxjFnCySzGDWNw@mail.gmail.com>
References: <20240814185417.1171430-1-andrii@kernel.org>
	 <20240814185417.1171430-11-andrii@kernel.org>
	 <e973f93d1dc2ebf54de285a7d83833ea6c47f2a2.camel@gmail.com>
	 <CAEf4BzZULffF9_6Mz4dxm=owvSkyErt3kShZpxjFnCySzGDWNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-22 at 15:55 -0700, Andrii Nakryiko wrote:

> > > +     madvise(addr, page_sz, MADV_POPULATE_READ);
> >=20
> > Nit: check error code?
>
> Well, even if this errors out there is no one to notice and do
> anything about it, given this is in a forked process. The idea,
> though, is that if this doesn't work, we'll catch it as part of the
> actual selftest.

Ok.

[...]

> In my QEMU I only get 3:
>=20
> FRAME #00: BUILD ID =3D d370860567af6d28316d45726045f1c59bbfc416 OFFSET =
=3D 2c4156
> FRAME #01: BUILD ID =3D d370860567af6d28316d45726045f1c59bbfc416 OFFSET =
=3D 393ac7
> FRAME #02: BUILD ID =3D 8bfe03f6bf9b6a6e2591babd0bbc266837d8f658 OFFSET =
=3D 27cd0
>=20
> But see below, for my actual devserver there are 4 frames. My bet
> would be that 568ef is libc. A bit confused why you get frame 04 from
> uprobe_multi, but maybe that's how things work with musl or whatever?
> Don't know. Check libc.so.

Oh, right, I had to check libc build-id inside QEMU, not outside...
Yes, this is libc signature.
This figures, thank you for explaining.

[...]


