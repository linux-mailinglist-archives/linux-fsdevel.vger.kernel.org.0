Return-Path: <linux-fsdevel+bounces-19988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC4A8CBD16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 10:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FBD41F223FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 08:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6965C7FBBD;
	Wed, 22 May 2024 08:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o896LBsQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF6C7710B
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716367066; cv=none; b=HoWU2Jw/B2Wfxk75c01K01eHmksM/fsZOH9SUgy70ptSNt4hvnQbAQDnQKe74wTdG6sUpqVw6ZSeHc0OPoYJxznCoOpZIAPdPvqXzAVLYZo+0WMauAQn1NPtV+/TI6W4SAMAjhOCnP/ubqLjP1TKa/zOylA/epogVDYATE7hoJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716367066; c=relaxed/simple;
	bh=gViipR0aoHspEq+mMM1VX2DizsB7l/GY0qFHEDlX30A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hABrjmx8OjsaiU+UzCkqesPnPjmlFnAIpyZvqIc2rYDfPa8zIqziH6AgUXw4gNaS+FjzdxU8ELFXE0Ny0pZo/Ugnu6r/5SFWgdcPGin6/ii71okmyscl28zKMj9fiMyXd83gyT1uC9jNCiutvxRe5RMTUGu+nn6dC2OOvFnW0g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o896LBsQ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43dfe020675so381511cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 01:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716367064; x=1716971864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gViipR0aoHspEq+mMM1VX2DizsB7l/GY0qFHEDlX30A=;
        b=o896LBsQc1eg2Dx81kTgmlbhLXIuHnoFBaz9ncIU4tIxDI7+/GXaEI/ejmtLysJlHJ
         5/Xs4RIZxbD1a9QUQ0p1NctTb9WLS4B70c4z609RBVMUKT1VukF5MXE0s4yn5sRqwsL1
         wilMknVJ3XDAQH3wrczTn3/jJKXsrhEg67y0Xq111JcP9HfP6OpEv5dFygb86iJxmNF2
         koM71bZcMX6YMKTgVIxr5kabTZUqwkKJqLB3Vo+EhO3D85FYPlx+s7vbNINDLqSG82jC
         IB5VKw9ALTrFL3UrGMgK3b2zZ4ivi0kAV3Y3ZO3eYkNv7aAF3uC1v7eQC/GQ11DGKrNg
         YFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716367064; x=1716971864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gViipR0aoHspEq+mMM1VX2DizsB7l/GY0qFHEDlX30A=;
        b=wnaNnrAimzbk9q0GyWbrHg516qMxjV/AHMaRUp2FhQGVEsTUUbEKjxnLyOvsJsi8Jn
         7Aw2HYf+OPL1PXLmkLuHBFsIs53c49zcaQH1B46SCSLZlsfoZ3y0x9sB5PCRUj3+YQu9
         8bgB4+UuJnfdQ6KFTsLCpZoVlnK5JdIUMsczCqSXIe3ZshFNPlVOxQLKcFfq7+zLJulW
         xZr1G7CTHAk9s/1rASSZYkQGC6Ji0H/cCgZ9zRWMDnuCfQFqna1SiQ5CkepgZnpPy1Dk
         wgPPQ9dVovtG7LuwFx1a2AY3dJE7ljN6Joec8vsyhHQfBrsMJdvDUf5B7Yww3XDTaeiT
         6pDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0eLWOGjxIYbnvmboqg77xki/kmnYMFghUwWVgqKUnBRp2uDQOYuRcWImJSAva0MJpa45x93YLFM7Wv1GmdhbwC18qMyEbgN4q+wTljA==
X-Gm-Message-State: AOJu0YxMnwf6a0ZKSePoKzNNdyFTheaYBNAYprfZqOL0chQULtejJKIy
	0D+RGZacv9SdsyviLi71Z1loNLO9oVikTIK/aR8SMXkvWSktJ8+KS3KDXlqbBwUMLB7jRYxzuiR
	Xj1nCylaDYrPhsT7JjVyhVbrAEoKaTPyscJuF
X-Google-Smtp-Source: AGHT+IGprLvaYe+qHSu6TTn5MUJntUl0VrZQahqHOY3uDjYVE33MM1kRNnpFP6Qyc1Z/gxjxIikyxDq80lGa1qHiRDI=
X-Received: by 2002:a05:622a:6088:b0:43a:f42f:f0b4 with SMTP id
 d75a77b69052e-43f9e54a565mr1586941cf.13.1716367064252; Wed, 22 May 2024
 01:37:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zktnt7rjKryTh9-N@arch>
In-Reply-To: <Zktnt7rjKryTh9-N@arch>
From: David Gow <davidgow@google.com>
Date: Wed, 22 May 2024 16:37:30 +0800
Message-ID: <CABVgOS=xA15qTL1Uqcxe6+uLubRHCLt5+me9ykV9_gOXhvXQtA@mail.gmail.com>
Subject: Re: First Contributions for KUnit
To: Artur A C de Barros <arturacb@gmail.com>
Cc: willy@infradead.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 20 May 2024 at 23:09, Artur A C de Barros <arturacb@gmail.com> wrot=
e:
>
> Hi all,
>
> We are students from the State University of Campinas with an interest in=
 contributing to the kernel. We are part of LKCAMP, a student group that fo=
cuses on researching and contributing to open source software. Our group ha=
s organized kernel hackathons in the past [1] that resulted in sucessful co=
ntributions, and we would like to continue the effort this year.
>
> This time, we were thinking about writing KUnit tests for data structures=
 in `lib/` (or converting existing lib test code), similarly to our previou=
s hackathon. We are currently considering a few candidates:
>
> - lib/kfifo.c
> - lib/llist.c
> - tools/testing/scatterlist
> - tools/testing/radix-tree
>
> We would like to know if these are good candidates, and also ask for sugg=
estions of other code that could benefit from having KUnit tests.
>
> Thanks!
> Artur Alves
>
> [1] https://lore.kernel.org/dri-devel/20211011152333.gm5jkaog6b6nbv5w@not=
apiano/
>

Hi Artur,

Thanks for reaching out: the contributions from LKCAMP in the past
have been great, so we'd love to see more from you!

Data structures do tend to be an excellent starting point for new
contributors, so I think you're on the right track. As the maintainer
of the other linked list tests (lib/list_test.c), I think llist (and
probably also kfifo) could be great starts. I'm not very familiar with
the scatterlist and radix-tree code myself, but it could also be
useful.

Otherwise, a couple of suggestions would be:
- As you've already done, look for standalone files in lib/ or in the
headers (include/). There are almost certainly more self-contained
data structures to work with.
- The FAT filesystem (fs/fat/) has some basic tests, but could use
some more advanced ones using the KUnit function redirection features.
This would be more complicated than simple data-structure work, but
could be interesting.
- Otherwise, lots of other drivers, filesystems, subsystems, etc will
have need of tests. The tricky bit is that you'll need to have some
way of stubbing/mocking out their interactions with actual hardware
and the rest of the kernel.
- If you've got anyone who's an expert in Rust, some of the KUnit rust
bindings[1] could use reworking. if you want to work on test
infrastructure as well as the tests themselved.

I'm sure there are other people on the list with more suggestions:
there's a lot of room for more tests in the kernel, after all!

Cheers,
-- David

[1]: https://patchwork.kernel.org/project/linux-kselftest/list/?series=3D76=
7643

