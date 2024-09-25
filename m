Return-Path: <linux-fsdevel+bounces-30023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C63985092
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 03:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84DAF2845E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 01:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3BA5336B;
	Wed, 25 Sep 2024 01:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R6R4BsjJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD8FC125
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 01:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727226975; cv=none; b=CeoUkrOfFQuWpBI+Df/R5OCnqeoAfRa+W+7Wt4eq/on/aJrQGKXJ5qtX7dokIa/0T6GclnGgi9YU9kBoE+Txo9unwvlPo/+UrETu6kEvejBmCX9cBZnBkgJpbBwXEo56fa0mcIb6PKrv7r1aONTIe4dHy6DB0Nv9oCCvB3B5Gto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727226975; c=relaxed/simple;
	bh=vh2TH83YCXTMOH05ROzZPU/h+fvjKHzM5/n35e+icgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtRIlxjEHMvTtdAcxl9gKBqzGCBCdgSi6Kgku3BspNmNm3pqOaRW3ujFWVSCSqPlyHejDwL8gaogCEx/9AYcN30UTwqZ0R4ZN4yRgHF+29BXCDN6BW6LUvTcWsC2SphjoTOTREAlV95ek4u9NX+1XUqLG5yokh5m4sxAJu6SZuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R6R4BsjJ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f75c205e4aso62745311fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 18:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727226971; x=1727831771; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rP5UEZj8/eIFu1VunDWZBA5Lphgz0Xtk0V0wSkkJdvU=;
        b=R6R4BsjJYdsgZYuRh1KtAhdQPzD9k6J0lmP0IKrT6XYM1lG+BdDBtluEsVBxXhRFhX
         kziiAn8MjLJfGYhaOPSkg9JOJyzjYoBwsmm0UOnuQEj0jcJaQVTbpIomlj4qDSBlF+mY
         C1Hiz5/aVfxg5TRigWsG+1fvrcB6SCsFEdI/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727226971; x=1727831771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rP5UEZj8/eIFu1VunDWZBA5Lphgz0Xtk0V0wSkkJdvU=;
        b=hbw2iEMdJM8n6yfGHDxB4JImRwfNXgI51GpDXkaGkeveZEixGX9slvnFXT0Yg21deJ
         r/OJgVeo/VbIRuuuRyq8745f6UC7fqTnjvpvPeNirTBbm04RpD5p3V6WzI1GlMTHIp78
         +vY9eH/80O/Wotxk07swbG+Cf8FG+P+bPLkfjLw0b+7Y5ipboPynGmR+fLZRpmdZDgay
         Ka5vgNOQ2Re+HqoqKIGHo/pX6YiQ8n26u3NQwNe81SKpulrpOD0vOdrtRn6ZxW+/wXtA
         7ii681RPJOlUGYThREdNZlhmmEfmILpRaVlLmUvXU7QhJmBuN+HJgEyPm2rTyoSqEv1/
         N2UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdNbMclVdT0VKp8DE6O2RLacNzFJzBFzeG4DIs+jC0NjIss3n5vAFxI0QDyBhCcoNG944/6hvWDv4xUnq1@vger.kernel.org
X-Gm-Message-State: AOJu0Yzftt3f8xKzH2A1rOikL/iRtRqOfWfZbNPYBF788T8vWFZsVIg8
	UJpHbHGhtLYYQ220akqPoq3XW9bmpeubDW/hnHG0dANAVDKZ/GD67XTJ1NUMP0/Ew58AR3mZqh3
	89f0Uyw==
X-Google-Smtp-Source: AGHT+IEyEO6f2sJfKBhmdN8BoJK6eZw29zpiVmQPKpDdfZN1TyLoSyDur6yr92fbHMo2PNIEs36X5g==
X-Received: by 2002:a2e:515a:0:b0:2f7:65b0:ff29 with SMTP id 38308e7fff4ca-2f91ca5cec6mr5186171fa.38.1727226970749;
        Tue, 24 Sep 2024 18:16:10 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4d7461sm1345551a12.79.2024.09.24.18.16.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 18:16:09 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c5bca6603aso3593452a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 18:16:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW7DereRazVco+DYGNrlBEEkcBhxPDugNKaG5L7a4E1dX1fI0XKJhQzEb+0eJbseKimbVaq1kyDaZahd1nM@vger.kernel.org
X-Received: by 2002:a17:907:1b16:b0:a8a:7bed:d327 with SMTP id
 a640c23a62f3a-a93a03c2dd5mr73811766b.36.1727226968434; Tue, 24 Sep 2024
 18:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923110348.tbwihs42dxxltabc@quack3> <CAHk-=wiE1QQ-_kTKSf4Ur6JEjMtieu7twcLqu_CH4r1daTBiCw@mail.gmail.com>
 <20240923191322.3jbkvwqzxvopt3kb@quack3> <CAHk-=whm4QfqzSJvBQFrCi4V5SP_iD=DN0VkxfpXaA02PKCb6Q@mail.gmail.com>
 <20240924092757.lev6mwrmhpcoyjtu@quack3> <CAHk-=wgzLHTi7s50-BE7oq_egpDnUqhrba+EKux0NyLvgphsEw@mail.gmail.com>
 <e46d20c8-c201-41fd-93ea-6d5bc1e38c6d@linux.alibaba.com>
In-Reply-To: <e46d20c8-c201-41fd-93ea-6d5bc1e38c6d@linux.alibaba.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Sep 2024 18:15:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijqCH+9HUkOgwT_f1o4Tp05ACQUFG9YrxLpOVdRoCwpw@mail.gmail.com>
Message-ID: <CAHk-=wijqCH+9HUkOgwT_f1o4Tp05ACQUFG9YrxLpOVdRoCwpw@mail.gmail.com>
Subject: Re: [GIT PULL] Fsnotify changes for 6.12-rc1
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 17:17, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> Just side note: I think `generic_file_vm_ops` already prepares this
> feature, so generic_file_mmap users also have fault around behaviors.

Hmm. Maybe. But it doesn't really change the fundamental issue - the
code in question seems to be just *random*.

And I mean that in a very real and very immediate sense: the
fault-around code and filemap_map_pages() only maps in pages that are
uptodate, so it literally DEPENDS ON TIMING whether some previous IO
has completed or not, and thus on whether the page fault is handled by
the fault-around in filemap_map_pages() or by the filemap_fault()
code.

In other words - I think this is all completely broken.

Put another way: explain to me why random IO timing details should
matter for the whether we do __filemap_fsnotify_fault() on a page
fault or not?

So no. I'm not taking this pull request. It makes absolutely zero
sense to me, and I don't think it has sane semantics.  The argument
that it is already used by people is not an argument.

The new fsnotify hooks need to make SENSE - not be in random locations
that give some kind of random data.

             Linus

