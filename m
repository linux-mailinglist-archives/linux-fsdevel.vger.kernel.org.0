Return-Path: <linux-fsdevel+bounces-21868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1F890C79A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 12:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87134285BBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 10:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFE31BD4E7;
	Tue, 18 Jun 2024 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+Rp1Lgf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE25F1327E5;
	Tue, 18 Jun 2024 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701625; cv=none; b=Jn0wvKPF58IDg/plZ0pYBKre21IdKn5JuDmF1AwbRImmeL8vlfhqwBp6lNJfg5M0FlWaorT2j16wl9v9rNcSwHC+HC7ijsEBJ8hii3zLWaKwi4WO0/LhmPSVmkjQgC7OB5UjRkuAE0YX4GxgG+gcTBvHFFnpEDQWdLHdaa0LDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701625; c=relaxed/simple;
	bh=au8yhi+EmJrIbpHhK6erx6351t7jF0G+m5kzvhU0lhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsRg+54TQ9NGNO0rIzvFyIcLM4NTBqpXwx1Lh7T11ZAr6zLh9aP0uKe9rfmiZwvoUWo2g1mV75pALgpzjavMvZjy2CVDJMiOqQXEkduVfA0ZLOILQXZKqBr3piJ30HKiCE82GvBxBMwJc7gR/i9ByXZ7MV8Io74xkM0/lAkl0us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+Rp1Lgf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f7b785a01so280648266b.1;
        Tue, 18 Jun 2024 02:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718701622; x=1719306422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UbcOf0pxrejnIwiMiz1yEnw+fA4Gbsvc+uTFi94WOA=;
        b=O+Rp1LgfJOky4k3KzptwtNEAXll6Z6ivgNz3FQpmaFatzlI+XPBgdyQGy/jtrOrdDQ
         f7mYv/0cuD9brhzWRaUMSZIIphqyFkF9xgI0VdYd+AwPmwML/bbqTH/DcLtAVXzJ2e8O
         2CKIwJCwc1uUmuQQAEJS7uJ8DzSBo2JNaP7GWAQxe5HxyPBf5Vz8S/6S9CM9d99LJmEO
         emJ3MJIYDvzryb2hqaoHWAbZ/ejwGEzqr5/i9uQKjtiZmYM2p6clsGJfUm1bRrQxNlrO
         go77DqLn+0TmM9yPCEF6LefJg3tpiEYR728ykfU0LPMCfnXBe4cfGACQj64B8jFxnuW7
         M3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718701622; x=1719306422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UbcOf0pxrejnIwiMiz1yEnw+fA4Gbsvc+uTFi94WOA=;
        b=E2oFXbAieOTa1fp0g7zGrZQR9Zl6sppOdECyZk7tPwgjKaJII9VtythhI6j/ZVPwjB
         bC4fORFdScF/MO52hOTKBdKUJ6+A41LG5St6GE385WgIQJy1A31IkBqkPTssD+W/K/qu
         mcHtipXmudBzlu/thvAiHm/NchTXzY9xy41HxH0EiAwIBrkafP91tGjcYmWOqiAc4zdp
         AeCORtRy34gNDe7QdmTqTV6MOJTJvnE+lKYSnOKoT46ULR5ou+oe10jH6moBCJvwyijn
         m20YIJYYKV7Lfm3JMZuhWROHP5nvebeqW+cFf8zmhzFwupQuzz5v+vDHR+yOvpEewjJK
         nWOg==
X-Forwarded-Encrypted: i=1; AJvYcCUdkSvex5kzpdSU+gJe2tGO0TTdWi4x/XTi7qMuys0yz73Dmm1yscOqtUC7N99lIiTr9LFVn5SPhl3RgN8lDpfPzmSGHTG2BQ3C2Mni6m8SssLHSsy6sYD9DX8OejG1r/rJfJZubxtZY2GNWA==
X-Gm-Message-State: AOJu0Yw/Tpy0qMGYp0S055UDWWSP0uHN9e4hamtJDBpFCqGcux3azKsy
	xuxWcURHcG8Orx0r+uZr/A6wunGF2/L3PVvKhZGJiQaPHA5yPjEyXDmuMuESBbxV/ZpjmXsPJE4
	RW42puvmTWaZU9JOgxpv9E+paW1Y=
X-Google-Smtp-Source: AGHT+IF12XeEHiYb6oAXlGs3X906A3Hpl0vxdM8WrW3ESD2IlcRbjMqyZ9rtPT9hqCD2rLynX1q0MPAyWWXvar3ZWvA=
X-Received: by 2002:a17:906:255b:b0:a6f:5db5:71a0 with SMTP id
 a640c23a62f3a-a6f60cefe2emr715634866b.14.1718701621969; Tue, 18 Jun 2024
 02:07:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614163416.728752-1-yu.ma@intel.com> <20240614163416.728752-4-yu.ma@intel.com>
 <fejwlhtbqifb5kvcmilqjqbojf3shfzoiwexc3ucmhhtgyfboy@dm4ddkwmpm5i>
 <lzotoc5jwq4o4oij26tnzm5n2sqwqgw6ve2yr3vb4rz2mg4cee@iysfvyt77gkx>
 <fd4eb382a87baed4b49e3cf2cd25e7047f9aede2.camel@linux.intel.com>
 <8fa3f49b50515f8490acfe5b52aaf3aba0a36606.camel@linux.intel.com> <ZnFGy2nYI9XZSvMl@tiehlicka>
In-Reply-To: <ZnFGy2nYI9XZSvMl@tiehlicka>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 18 Jun 2024 11:06:49 +0200
Message-ID: <CAGudoHHaH8NgdxwC1gr-XdyFSzSfPsD__6jMymTC-FQ7=o_ERw@mail.gmail.com>
Subject: Re: [PATCH 3/3] fs/file.c: move sanity_check from alloc_fd() to put_unused_fd()
To: Michal Hocko <mhocko@suse.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Yu Ma <yu.ma@intel.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tim.c.chen@intel.com, pan.deng@intel.com, 
	tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 10:35=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Mon 17-06-24 11:04:41, Tim Chen wrote:
> > diff --git a/kernel/sys.c b/kernel/sys.c
> > index 3a2df1bd9f64..b4e523728c3e 100644
> > --- a/kernel/sys.c
> > +++ b/kernel/sys.c
> > @@ -1471,6 +1471,7 @@ static int do_prlimit(struct task_struct *tsk, un=
signed int resource,
> >                 return -EINVAL;
> >         resource =3D array_index_nospec(resource, RLIM_NLIMITS);
> >
> > +       task_lock(tsk->group_leader);
> >         if (new_rlim) {
> >                 if (new_rlim->rlim_cur > new_rlim->rlim_max)
> >                         return -EINVAL;
>
> This is clearly broken as it leaves the lock behind on the error, no?

As I explained in my other e-mail there is no need to synchronize
against rlimit changes, merely the code needs to honor the observed
value, whatever it is.

This holds for the stock kernel, does not hold for v1 of the patchset
and presumably will be addressed in v2.

Even if some synchronization was required, moving the lock higher does
not buy anything because the newly protected area only validates the
new limit before there is any attempt at setting it and the old limit
is not looked at.

I think we can safely drop this area and patiently wait for v2.

--=20
Mateusz Guzik <mjguzik gmail.com>

