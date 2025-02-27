Return-Path: <linux-fsdevel+bounces-42790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB471A48B1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 23:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4943D7A5915
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 22:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A659F271824;
	Thu, 27 Feb 2025 22:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhpYy57d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8D626E968;
	Thu, 27 Feb 2025 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694082; cv=none; b=GTcIg0cWF+uFCZOKm9zDlDTWARsGa8PxbllhHWEkjQH2MR29dHciBtLoZ8qp57vsSVN4RS4HQC/LZ2mxnjxSq2ILeLA5utjksznk+z06gn1xN/j4J6SMKBwU8bSkMv4anudl9FrrMDWPegcFjQVq2Dqi0AyEAvv45aluF5HfIGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694082; c=relaxed/simple;
	bh=UN+Ru2yjqJrkcSVGik6SXxWdueMW66UZG8XnISR/UP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5r0ePeealrT7vE7fpanMSYFkHnhX+NP3tI1J3uaQSJp0A1FtNYFQmssrf4MI/C8m4/I9LoW+nticZz//o8dGKNsFR7oijzW64hBOTRwNGUVw/5EtChyM8gsGw+AN7YnPcVVbalRzOH9657rt6p1DJizM3mD5dncxFlGqNAlE5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhpYy57d; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abb892fe379so206176066b.0;
        Thu, 27 Feb 2025 14:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740694079; x=1741298879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADjzqVu0rQMGccp4tlner6D96WtUA+UNr/2jIh2K1oc=;
        b=nhpYy57dLJH1uPapQI7VnXH1HZpEkA4pWhCcg8ejbk5k7VSzfZokdbiZ5OA9YC10cE
         L8WWibF6EYYyjJZSygxVWd5GUXsaITlN85fJtjgJFO/i9y4AhklroffS2bcHtAgckpGh
         p6uZ2vDixkuJDv7q57KIIk+JfHG/X11fZFAKObCab8rx45rAPSZbY8h2bSquqBt6KPF0
         Nam3Jb1s/FGOK+FFNJGfaffIxT6AjrhAQ9jaCuyTpZHBfoQkEEQxYj53XnINu9eNuXHX
         ScVKgSgQ4OHHtnbNqlVGd7Aw3pXlefhif269O8U8pzcxGIiji8VwQ7nP6Fum2N9IC1hq
         Lo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694079; x=1741298879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADjzqVu0rQMGccp4tlner6D96WtUA+UNr/2jIh2K1oc=;
        b=LI8CsWzJ7kvh3ezXpDM2d/iuwSwPp7MmADVHgPQq/Pvt0DABfgJRagEKoqy6WEn8yB
         hLzKMwPtENFvsGI1nGqKGjCYzt2t3qjk9HPDravQx55Vt+/WTKZr/qRg+xkEXMZ+2mKh
         uAroUeiGXxNX1/IxVGj0G3Lgg+nqYq1nrR2oaYla9A47IdVxVujaOfPLXittmTwdZrwI
         S+QVw98a3xZ6pydw9shAWJQ9KdXOs7hDBtgdNj9LaYO6iGnxnPdyz2rwpPNnOhs2qU3i
         ohsIwJBmHhrqUf0iXgalFOYLIq+r+pllL8RV9jjsOhEhaqEuCiBx2+m2iSvx6nfRn2EL
         gtIw==
X-Forwarded-Encrypted: i=1; AJvYcCUVVhv9IOZbwmXAFCXnx3SnIp2NVENVXjbks7cWg+/I6vXQk+AsTOpHmYu8OSl++z2yUBMeZx5DDLMsttNS@vger.kernel.org, AJvYcCWnS0zVR4l7O7YQJ+wBadtQxvw20ijwv8OpdIFGDK2GZKpLkKHaMZQkDJMIg7CLkMc/RQPSUyIMylzH6ixp@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv8nBQt+chqmVS1Vk7Hy4QBCAtjmBZZUAXN8Je7sz/7JX395gN
	mk59Hi7KFd8Q5Jc7vcOMNXpN/6VwEkvDvXva0s8OJHydd/VXgy1QId7aG2MyDJ1A9ZMBmKE67W8
	MtNA2dLBYT9DigMQ5KKnRqoiH+1c=
X-Gm-Gg: ASbGncsleKffVWeH/iO0hATIaYzRNrTzcCW1WS9QF1uz1gN5nwnLqAwG9ITmB8KZya3
	yTFwbaVHXUv5CyDDH441qMP+HYxjKy1+lj/iurCeT89v3gIaw7H6StJNVISZjHRPJSDn22SKTa1
	nRGSz6c7A=
X-Google-Smtp-Source: AGHT+IEBd5l3TXoINUYoCqfpZdrHIWch7LPPU/DVCUKfuAbX+iDCrpluTBxuviWEJtgjZj47tQXm4fxrqHTF+kGUQeE=
X-Received: by 2002:a05:6402:34c6:b0:5de:4a8b:4c9c with SMTP id
 4fb4d7f45d1cf-5e4d6b62f6emr1432015a12.32.1740694078277; Thu, 27 Feb 2025
 14:07:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227180407.111787-1-mjguzik@gmail.com> <20250227215834.GE25639@redhat.com>
In-Reply-To: <20250227215834.GE25639@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 27 Feb 2025 23:07:45 +0100
X-Gm-Features: AQ5f1JpvudCDW09pKlncHJMvLXGsrmhmZGJuFrf5IBX_27iIWhHqMRNvU_zS9vU
Message-ID: <CAGudoHG7EF5_wnNhsyFoiRtU-qW1b=vUaVaFk7TKnqeSjC6sOg@mail.gmail.com>
Subject: Re: [PATCH] pipe: cache 2 pages instead of 1
To: Oleg Nesterov <oleg@redhat.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 10:59=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wr=
ote:
> > +static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe)
> > +{
> > +     struct page *page;
> > +
> > +     if (pipe->tmp_page[0]) {
> > +             page =3D pipe->tmp_page[0];
> > +             pipe->tmp_page[0] =3D NULL;
> > +     } else if (pipe->tmp_page[1]) {
> > +             page =3D pipe->tmp_page[1];
> > +             pipe->tmp_page[1] =3D NULL;
> > +     } else {
> > +             page =3D alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
> > +     }
> > +
> > +     return page;
> > +}
>
> Perhaps something like
>
>         for (i =3D 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
>                 if (pipe->tmp_page[i]) {
>                         struct page *page =3D pipe->tmp_page[i];
>                         pipe->tmp_page[i] =3D NULL;
>                         return page;
>                 }
>         }
>
>         return alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
> ?
>
> Same for anon_pipe_put_page() and free_pipe_info().
>
> This avoids the code duplication and allows to change the size of
> pipe->tmp_page[] array without other changes.
>

I have almost no opinion one way or the other and I'm not going to
argue about this bit. I only note I don't expect there is a legit
reason to go beyond 2 pages here. As in if more is warranted, the
approach to baking the area should probably change.

I started with this being spelled out so that I have easier time
toggling the extra slot for testing.

That said, I don't know who counts as the pipe man today. I can do the
needful(tm) no problem.
--=20
Mateusz Guzik <mjguzik gmail.com>

