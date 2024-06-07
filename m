Return-Path: <linux-fsdevel+bounces-21203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77256900528
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4D27B29E63
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 13:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E401194C6A;
	Fri,  7 Jun 2024 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="af0/R9R3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4C215B54A;
	Fri,  7 Jun 2024 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767416; cv=none; b=U1kDyAQsOuKe10tpq65odbEUwQ027sM5vQToY8oxB5WJEpAmJXPCjMVu/DowCb9XdG1C2vJQcYqpiLmSubOs6TfoNi7j8ndiidReIcfaz/Ej5bIXkaxsIAkIbrObxqzMJlzNOhwV4JOMKcVXZuDzPluwkCqdMf35Kerr/BuSyLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767416; c=relaxed/simple;
	bh=aTqDPs2BV1TkSSf7DvtFtL1V0gHpXhKpZ4wD3WJPDVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bF0Wguu2ifoh8AsyI8HaAtGQyaE7ignVdj/rt+b8pa1MrhA3oikaKKbM/vLaZb2pi66VCNIwJt5OOBIKcDTgJ62aNLF+AUhrwKpZ+IkRj80xJqOMcM3YbnT42A+lZAirp2Dm0IelftEn3euY/U1X8Ufw+Hjv1m9N8MXC++lpBBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=af0/R9R3; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d1ffa16080so317169b6e.2;
        Fri, 07 Jun 2024 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717767414; x=1718372214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsnPTo/8GBKfAm5hQE1/ElT4VESU6abIi/S302Yoa/A=;
        b=af0/R9R3mDpuB8ZFPLusmdPtNUss5tCutbO17vRKBa/l3Ci5m1NVBObLZt6gqlT5h/
         g3JJh74JUvt6jvy1qBR1M4NG6NWlBs8wdkmLD77NmM63aslXAFGktpVsMFB8q1WKvjn4
         PhkTV9jOyJIF/7n9fLXfgezzTnAiq0MFVb3JkO4lauJVhhHjZ5K+GhTx5gwSR6un/m8+
         skJT/vNIjwxF0J+dr7cYMRXKHjutQ6K2UR8WakfE7JyhHi/sOZwxLZahQloAWroDF9NY
         nBfaEvbjFFFL1KNiU5S3CQ3llGubgVjifUh60m2FeAYXSMn6NKawP3qBKe8Zh6oHDef5
         ouRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717767414; x=1718372214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsnPTo/8GBKfAm5hQE1/ElT4VESU6abIi/S302Yoa/A=;
        b=KDkhpr4HnspWu6Whpgxm6RZ9h8j3gT4nJfTWDmjnLYnfMh4bbWhFx5+LiLJs2JuEQ8
         Fp9RcSeN4vpwAGAA0tzPD6rmQb48lpa1OKble4di079DX69muipdKXQzTT5TQfOwRHKM
         HGuaYq/jzl4urebZwovL7Cr9TArXOnFSDXg+2WZ2l3/+dwo6eYh2/v11128Xyw0Ig5+e
         urSlDUyfzrIrf6KXwUdga4vdd+VcCpWqZ1K0LM73R1pI22+aMPGImKKJfTXM2Ozfbhhi
         4KmCkxCA9yvjHUrFcA74neAeVZjIYsEzDYuiib/NRVm2ZaXnCOwSoOIZBFLf0TpJFchs
         NK8w==
X-Forwarded-Encrypted: i=1; AJvYcCU8ja98orwGriMUWPd9puF1UDCkPbU1NeUnO59UbzF3AOrf3gE2i7isRKZsdCkvDvdqRvACNZDGSILDVhGRypA3XCTVHNVNiSIr0MPu1mkJfRpTtix45efoU3jJNiaIOOrOSW3lmwABTg==
X-Gm-Message-State: AOJu0YxJTgpTTxap7NwYyi93LDur5X94px36I1WHND2b0foyAb5djc01
	k00DMd+xyVY86jrcX/vq+B8iM77bIPGKZdwDsCDpuJafnecRUFI6M95hwm17aZZ2lxDkV9KeeO9
	1SpXJu4hK2bAUq3AW3Cf4HSyKz7U=
X-Google-Smtp-Source: AGHT+IEojVhe1VE2I9tkYeYFprnJEtgfGkdfoWwK5O0NK2oo8xUNetmXenf1UiYpFdw8PyEET/QaYELWmnmu1A9VAqA=
X-Received: by 2002:a05:6808:21a0:b0:3c8:64b7:7814 with SMTP id
 5614622812f47-3d210f98377mr2592800b6e.5.1717767413813; Fri, 07 Jun 2024
 06:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607122357.115423-1-david@redhat.com> <20240607122357.115423-2-david@redhat.com>
In-Reply-To: <20240607122357.115423-2-david@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 7 Jun 2024 21:36:42 +0800
Message-ID: <CABzRoyYer2Bb-yLXJAafqpxG5p+aZhnxoxq2v5KLY3JswpnX0A@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] fs/proc/task_mmu: indicate PM_FILE for PMD-mapped
 file THP
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:24=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> Looks like we never taught pagemap_pmd_range() about the existence of
> PMD-mapped file THPs. Seems to date back to the times when we first added
> support for non-anon THPs in the form of shmem THP.
>
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

LGTM. Feel free to add:
Reviewed-by: Lance Yang <ioworker0@gmail.com>

Thanks,
Lance

> ---
>  fs/proc/task_mmu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 5aceb3db7565e..08465b904ced5 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1522,6 +1522,8 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned =
long addr, unsigned long end,
>                 }
>  #endif
>
> +               if (page && !PageAnon(page))
> +                       flags |=3D PM_FILE;
>                 if (page && !migration && page_mapcount(page) =3D=3D 1)
>                         flags |=3D PM_MMAP_EXCLUSIVE;
>
> --
> 2.45.2
>
>

