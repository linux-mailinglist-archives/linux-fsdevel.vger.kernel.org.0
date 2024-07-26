Return-Path: <linux-fsdevel+bounces-24291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C1B93CE13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 08:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6D61F21B95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 06:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E6D175548;
	Fri, 26 Jul 2024 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERsUYtmY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDD02557F;
	Fri, 26 Jul 2024 06:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721974701; cv=none; b=J5wAhzew9NrClrbiKVUFKqIf7HPRfDxvN8JaeIQ6nL3jE3auigcg+8yR0P9XTNtgkiHJyp+XILxLL0F63ZXgYeWgAr/vO/qjPlsCmsdlOOoKXwER/rIyYLUximBnmYMk99ZelvmPpuyeZOju9m0l6QdEIR4laqM6OByMzsvzvpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721974701; c=relaxed/simple;
	bh=ZXIUgYpqW9FcDD4A0sqXP0ScftGO8Wc+4lYkidVXkpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moj6PUj98fiO0d6hMlmy9oG8qkTBawGgFWxLAnprSvzjHhaCZiEVU3971a7Joegkx/iJoM9n+bXI2YlbGNKDd7zgzcYeRldBFgjzl3kiHV+HIAP4ujMqxkeDmjrTaYoh3bK9xGa9YhohbOjCyHmoQXrpTguooUbQIPAnD4WSnic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERsUYtmY; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1d7bc07b7so24923685a.0;
        Thu, 25 Jul 2024 23:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721974698; x=1722579498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IY+VivhMLGx+CDmmORg6086EMcWgTnl4FbE0K8BcNMs=;
        b=ERsUYtmYvw48qO6oa/mr/YdadUN0LW63G2oRAZRFf82dRdbsY2iLflTjlQcbtUtCwp
         xVGFy4PlgKAhMudkomya15mvP3wxctppg4V1sJXoYUYiYNM4pHEnA2dMXb23wnrqxAG1
         lvpUFSX93uJObSecfnyIPP09QlilCOxUVz5mvSvmIzbaH+45Xwg+4Ip5reNZkhWRf9fA
         VTGGw0XUuUS4zl4Ae6UgJB5x/0wJ1RWg4QjB41ZR8a6+5u9sFPcvzFqteNhKMIE41fxg
         EFnrNkT/4m+4jQBMCzD2Wott0Z7LUYN9Grkb39LEcEjFu7lLayg18CksRQ3iIWGeka9b
         TJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721974698; x=1722579498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IY+VivhMLGx+CDmmORg6086EMcWgTnl4FbE0K8BcNMs=;
        b=QYoBc7LqRC801pZ19zy0c42cdjX3smnakmCosZpTMWl1s72F9uBIIBlDvYgsZJNhb2
         qalf1uaGRHv2NaEjGwWi59IUkTSs3+0R7j68jkjKXzPG2Y7+autsReti8yuZ8MIx+hwb
         ujqupRANedNJEQhYR9NSFdK+dHRHF+TK6C1SVq7tHGnnfF2Yi+TDULeUusPdQDXdSNUd
         87tX4Mrzyxf25J4Mr49flocLycc8VVQlrHL+5qXtKVEpbywxY1sEPCtYBdmpOT0eo6zO
         pbToeOn4+8vnJpnd+PCfcf9phTJ9XvknyHeSjjZaBirJZmzjP5ZPhYkCw8edvIrf0LHf
         kFPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX4WkermcV5HhlBGzY1q+yXK8y3/0k90dkzlSpMp/QPaxJttBgXmWe/Dft84jNmQUnNvAlunQ3TTpgy2uCXe3cYo5pkNpDskKIMifXlGf4pGD3uSpRiVnuOVtpgjqYqcY3iluI4J4pesKf/Q==
X-Gm-Message-State: AOJu0YzJtEHa/ihtz7srqFGI46dAG8ept0BXnlmQY31yu16NX+yCGiHQ
	vsEp8sXUcnHjKkv5Yh6lgflB+TIMMXORlISvpjfca7qnBVQw/ZDpBXmB7nnNjI7wI9nErPRxG38
	4ZH6b1fINz9n7QjdSuTodotRkaW8=
X-Google-Smtp-Source: AGHT+IEMgqIyemQNZIPGNn3zmpc0yTL+Qy0QT5+Ynrqd1xHnU5wNXIeXtCHJLsHZ42sdus18A3VvZCDuYGLPTkU/tbk=
X-Received: by 2002:a05:620a:f15:b0:79d:7a40:1bde with SMTP id
 af79cd13be357-7a1d7ef9aa9mr439852485a.45.1721974698478; Thu, 25 Jul 2024
 23:18:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723105412.3615926-1-dongliang.cui@unisoc.com>
 <CGME20240724130711epcas1p3a6b887e2f40e3430e22d739093485cc6@epcas1p3.samsung.com>
 <ZqD8dWFG5uxmJ6yn@infradead.org> <17d6401dade58$0287e640$0797b2c0$@samsung.com>
In-Reply-To: <17d6401dade58$0287e640$0797b2c0$@samsung.com>
From: dongliang cui <cuidongliang390@gmail.com>
Date: Fri, 26 Jul 2024 14:18:07 +0800
Message-ID: <CAPqOJe1xp-9snhvz7x+K6-wstLntNLdaYb9X7sLAzrP1EEzYbQ@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: check disk status during buffer write
To: Sungjong Seo <sj1557.seo@samsung.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dongliang Cui <dongliang.cui@unisoc.com>, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	niuzhiguo84@gmail.com, hao_hao.wang@unisoc.com, ke.wang@unisoc.com, 
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 2:00=E2=80=AFPM Sungjong Seo <sj1557.seo@samsung.co=
m> wrote:
>
> > > +static int exfat_block_device_ejected(struct super_block *sb)
> > > +{
> > > +   struct backing_dev_info *bdi =3D sb->s_bdi;
> > > +
> > > +   return bdi->dev =3D=3D NULL;
> > > +}
> >
> > NAK, file systems have no business looking at this.  What you probably
> > really want is to implement the ->shutdown method for exfat so it gets
> > called on device removal.
>
> Oh! Thank you for your additional comments. I completely missed this part=
.
> I agree with what you said. Implementing ->shutdown seems to be the
> right decision.
>
Thank you for your suggestions. I'll test it out this way.

