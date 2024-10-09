Return-Path: <linux-fsdevel+bounces-31462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0059970AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 18:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A301C20DD4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 16:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC001E3DD5;
	Wed,  9 Oct 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdbYAXJc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8431E32B7;
	Wed,  9 Oct 2024 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488969; cv=none; b=kvH4xneH7PBcom6oduyOVUFvO/IJDogSqWVZld5KHBi4z+GRb07ERD+5KFB/Ub/0CV5oOUy5jzCaOQ5BWEeLoqEzQf+rpQdZm7ITGqHOLQL+t5Ds8P11C62d4GrdIiyH1xJPARewnsr/tfE2yVjXaPUwp/lkFacbw5Hr4md58N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488969; c=relaxed/simple;
	bh=pliWJTowb4v36/oVVcDzs8wkhL4uPEIgll194fN9VUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlfwEYSfchj75DtChA5bMF2+I+kfSEMd6Eb7qgj8b5o2tDw7U7k0kI0JfG4f0MBnyCiXgTJv6ItjHxfiJdSFpf784crXDFxK0XUTjQGZjSaRLmKcZQ5hMUFovDDlWlzl2kt7kW6+VW9OLfPPZaQQCfu/r3CwQsN4A1PRpLjDOzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdbYAXJc; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7ac83a98e5eso94547285a.0;
        Wed, 09 Oct 2024 08:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728488967; x=1729093767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pliWJTowb4v36/oVVcDzs8wkhL4uPEIgll194fN9VUc=;
        b=kdbYAXJcOebn8/ovWpXCZCieWcbc/nHNZGI7AYi+Nmttkwsb0HRjF+s+n3fwAq9chs
         tTBG0U2KavFKXdkcVo3jG7VFYCGZ0QUEKkccfKKn/+FSk/gO2Tq9+EpQLqoMwrQKduQl
         XczjLBeABF7SWviaq8cUGnQFOdnGG4up+WRsRrE2tq893e7y5Ltp60LYZGyEhDuI1kp7
         NejIc+dDdT4rMQ6b/cROEdWj9y1Uwxv7AhEmFIPEDR5XWyAd03Ur1nvHqjcWNq8ec/I7
         8mycC6Gn9j/7Zse+CrTLuzMacENt162LGWmuizJi+JAKjU8Ftrc3f6bG8H4xAUO2T2O2
         kRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488967; x=1729093767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pliWJTowb4v36/oVVcDzs8wkhL4uPEIgll194fN9VUc=;
        b=HlubbNPzFm/nRXklV0tXy7KUrdOb+Tc0hh0bG2CwD1KeccrrQT9DoiMdz4mlgKK2Xu
         66uzEvAcm6MPLTJrN3K0w+C9hPucuIQ5IND6qui5HOZe0w3Pb38MMeZR36dxI0N0utts
         L3aMG1zM0Fy9oWB33Vp5xOA6kFCVq/xGLb/EVWXybMTlbxRRUq3xIixRLLL7LqfpLuUp
         az/3xr6BM8cB5GaIRePqf1jvlgqEb/T53zOpsg93kd4CeSoZSncY4aGa30E7VYLctxXm
         pq5/amYbP5AVUBSlQiCNhHOR+HpYOAr/TWGWnx8DGuwqmCM6U2/VnYjlYH/+BTiZDNCS
         rIpg==
X-Forwarded-Encrypted: i=1; AJvYcCWIoZtoVzKrpLvzjcJElD3Ih/UIjZcFQYJezuTPV7kKtYl3Hq9/0MwHRnu7Uqb2f6Ww+c2kiny19BwE5Cc4@vger.kernel.org, AJvYcCWe0j7CFAPoW/JF195KayX9/KjlEP15h/w/K0uVyATimBjORBsllaZYSZn4nwT+NKLGLWrHEaTk4mJp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6cyjX3fXNyug7D1m8G1PHAtXCXJ8j5E+A1l3hclII6/xZbDB6
	YWMXJzeLCKPTUoApoVXZtsLMUO5FiXvut2vNqm7IH/YTUZ+9HT+t1YKE2FN/eMIdsz72Fx/FYgL
	28kF/EqtuJv03+TkB5glACIkLxvI=
X-Google-Smtp-Source: AGHT+IGMWQNHaR/4azYk0DF/AU8GCtoRx1sTy3DKtQgllhYjDTmOFNXxXvFTkWQtwx/j1GnQsB1vRoCD0jKJq6V6FeA=
X-Received: by 2002:a05:620a:2802:b0:7ac:9bdd:6e78 with SMTP id
 af79cd13be357-7b1124d215amr12267385a.14.1728488967058; Wed, 09 Oct 2024
 08:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008094503.368923-1-amir73il@gmail.com> <20241009153836.xkuzuei2gxeh2ghj@quack3>
In-Reply-To: <20241009153836.xkuzuei2gxeh2ghj@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 9 Oct 2024 17:49:15 +0200
Message-ID: <CAOQ4uxiNJ9a40fWzH09pXC7u0OuCqQPLuMJ8Yku+1Qww_Kc7KQ@mail.gmail.com>
Subject: Re: [PATCH] fanotify.7,fanotify_mark.2: update documentation of
 fanotify w.r.t fsid
To: Jan Kara <jack@suse.cz>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 5:38=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 08-10-24 11:45:03, Amir Goldstein wrote:
> > Clarify the conditions for getting the -EXDEV and -ENODEV errors.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Looks good. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> But I've read somewhere that Alejandro stepped down as manpages maintaine=
r
> so they are officially unmaintained?

Yes, I just caught up with this news.
Anyway, it's good to have the patch on the list.
I will be maintaining the fanotify man pages queue
until manpages are back to maintenance.

Thanks,
Amir.

