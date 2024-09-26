Return-Path: <linux-fsdevel+bounces-30148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF00B986FC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 11:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15E05B25299
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 09:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A5E1AB6E3;
	Thu, 26 Sep 2024 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="YQG9FEOi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C17146596
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342196; cv=none; b=svS3DeuhmhLc5slKXlqG1VNQ3zKyYzvmb06U97Psbjv3GmuXNyQE6AKRZvUJMCG23t/0qgf08QFWXmcQPxcy8dJDK6ud20qIYqf7U+qrqrVtvPr+emAyshzshem2cEG2kjJmHVtPqtVMk/a9fBjHVjIr9oIMTmTQicglig3lPYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342196; c=relaxed/simple;
	bh=7PkzOUnuPkgQ3LtHursG8Iucx2zFyr8ihELw1sXDK/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBBatzccutsGj0k7y0rrkgakGhGIlvNz+EoddhVYzcd4r0n3U5Qb48+WtW/kLECUiD3Qfb3okk+CJ2x+KnDriPzZDOqlqw8G3dI443LIiMPts7OuwmxMcgIuIHA6eT7BHFJ8b+FLtMnyQK0zsK9vfY3BSUrjZ7NuCTJc7FTsPUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=YQG9FEOi; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 16DC63F2AD
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 09:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727342187;
	bh=kdMJjD4opcK8pwxBZ4G695jfmJjislpk7/g9KxdUbMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=YQG9FEOiOGEesE/vjhGrI/K7ngzkMv8d2Uxk3xLiIu7f3aXxEtqsbelUKPkbOgfYI
	 l7arXDJN9S+cB81ex8TTP/fVxUKp4oMh+Uwj0hYmlL1hNKnY3+B7dmP6AXSaOdhoaQ
	 HnUt4JEAlD3Pp1taM90NXj1hx1ljHtqQOSBBwx9yYE5Yg/8J2ABOdfwIL9cxxc0yEh
	 VRTRmwMhuGV2+MOESJyy8pZ7Bkc3IZgejl+e4OjxHV8jPdoCMfI5sTr8q9mPgYEXBV
	 6OP/xr462LiJLFaiV4Px5JkYOVI4Po4JBNPPlxnWWqblStya1wVK7+4xxFl5Je4f+v
	 M8RjBQCqbGWEw==
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5031d76bb88so245038e0c.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 02:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727342186; x=1727946986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdMJjD4opcK8pwxBZ4G695jfmJjislpk7/g9KxdUbMA=;
        b=iAbFAd/THeOSYBrkaslnC+QXGBZwdOpgSLOmWoT1RohUggbZqZI9+MxUUORowJgM+8
         hcFbx93/6JkRGguFgpCF4lONGi2LEtBmBxP/yh3K7xWdWCI3WmerpXeP3s3NHl5JJx0S
         JkmmHXIOC8PSiwYSQV/79KEekF8LTt4yE0/+0GBPtseCNCsK+IIG1sTed6H9wD1q7XSx
         Ne+ictCNWA8qcuNV/gNY7gGJwddFjuBCL3SlU5n/GufABOXJ5l0vwJite3Z7IHWPWzuy
         C0OTgFiXVVCeLHYoASjC582kGUgrnDgeEhvAnrJ8trNm77IC934nszbdqSQivVzPwGoD
         SJ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCViqGl6kXoiIWgjrmqa5/Mpsx8TD3yohIDiB0l/hM9dC6+HxV8aFYVnbeOR0Zmv2p4g4jbn1tyscCC+ve/u@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3NwIwEW9V/28Xuv43+VjUDD1l0LIuwQ8qNfEJCUXOOie4Uf1/
	yuJuQ2S1JARa+20ZUFRprec62LLB6wpc5L7wT4hdoR12mgoZayip+xK7qPHQHOkL8LLZs63MUQe
	ECs4GWY+9OQO9AOYzWR4PGbtvEAVt4osojvnawd1Fg7czcGdQNoX/aZOEjPHtLF1WojinxpMy4u
	LA7jP1X0fLhvISWqY51Dio1hWogy26ibczlvYbj0+vnZbL03KBGmoLvA==
X-Received: by 2002:a05:6122:1ad2:b0:4ef:53ad:97bd with SMTP id 71dfb90a1353d-505c1d785f8mr6687401e0c.3.1727342185766;
        Thu, 26 Sep 2024 02:16:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR3msiAwchookUE9Ihf5EsDoE38TLBraGCf/1zdqN40ufE7jE1N/koOITa7IqCiTgfKipTai/pknyfcKtKkPI=
X-Received: by 2002:a05:6122:1ad2:b0:4ef:53ad:97bd with SMTP id
 71dfb90a1353d-505c1d785f8mr6687385e0c.3.1727342185405; Thu, 26 Sep 2024
 02:16:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com>
 <20240925143325.518508-2-aleksandr.mikhalitsyn@canonical.com>
 <20240925155706.zad2euxxuq7h6uja@quack3> <142a28f9-5954-47f6-9c0c-26f7c142dbc1@huawei.com>
In-Reply-To: <142a28f9-5954-47f6-9c0c-26f7c142dbc1@huawei.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 26 Sep 2024 11:16:07 +0200
Message-ID: <CAEivzxc-b-QDx8AEdHEwa06Q2TYgZZkw2PWQ+K_Lyf+oyTM1Zg@mail.gmail.com>
Subject: Re: [PATCH 1/1] ext4: fix crash on BUG_ON in ext4_alloc_group_tables
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, stable@vger.kernel.org, 
	Andreas Dilger <adilger.kernel@dilger.ca>, =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	Wesley Hershberger <wesley.hershberger@canonical.com>, Yang Erkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 10:29=E2=80=AFAM Baokun Li <libaokun1@huawei.com> w=
rote:
>
> On 2024/9/25 23:57, Jan Kara wrote:
> > On Wed 25-09-24 16:33:24, Alexander Mikhalitsyn wrote:
> >> [   33.882936] EXT4-fs (dm-5): mounted filesystem 8aaf41b2-6ac0-4fa8-b=
92b-77d10e1d16ca r/w with ordered data mode. Quota mode: none.
> >> [   33.888365] EXT4-fs (dm-5): resizing filesystem from 7168 to 786432=
 blocks
> >> [   33.888740] ------------[ cut here ]------------
> >> [   33.888742] kernel BUG at fs/ext4/resize.c:324!
> > Ah, I was staring at this for a while before I understood what's going =
on
> > (it would be great to explain this in the changelog BTW).  As far as I
> > understand commit 665d3e0af4d3 ("ext4: reduce unnecessary memory alloca=
tion
> > in alloc_flex_gd()") can actually make flex_gd->resize_bg larger than
> > flexbg_size (for example when ogroup =3D flexbg_size, ngroup =3D 2*flex=
bg_size
> > - 1) which then confuses things. I think that was not really intended a=
nd
> > instead of fixing up ext4_alloc_group_tables() we should really change
> > the logic in alloc_flex_gd() to make sure flex_gd->resize_bg never exce=
eds
> > flexbg size. Baokun?
> >
> >                                                               Honza
>
> Hi Honza,
>
> Your analysis is absolutely correct. It's a bug!
> Thank you for locating this issue=EF=BC=81
> An extra 1 should not be added when calculating resize_bg in
> alloc_flex_gd().
>
>
> Hi Aleksandr,

Hi Baokun,

>
> Could you help test if the following changes work?

I can confirm that this patch helps.

Tested-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Kind regards,
Alex

>
>
> Thanks,
> Baokun
>
> ---
>
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index e04eb08b9060..1f01a7632149 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -253,10 +253,12 @@ static struct ext4_new_flex_group_data
> *alloc_flex_gd(unsigned int flexbg_size,
>          /* Avoid allocating large 'groups' array if not needed */
>          last_group =3D o_group | (flex_gd->resize_bg - 1);
>          if (n_group <=3D last_group)
> -               flex_gd->resize_bg =3D 1 << fls(n_group - o_group + 1);
> +               flex_gd->resize_bg =3D 1 << fls(n_group - o_group);
>          else if (n_group - last_group < flex_gd->resize_bg)
> -               flex_gd->resize_bg =3D 1 << max(fls(last_group - o_group =
+ 1),
> +               flex_gd->resize_bg =3D 1 << max(fls(last_group - o_group)=
,
>                                                fls(n_group - last_group))=
;
>
>          flex_gd->groups =3D kmalloc_array(flex_gd->resize_bg,
>                                          sizeof(struct ext4_new_group_dat=
a),
>

