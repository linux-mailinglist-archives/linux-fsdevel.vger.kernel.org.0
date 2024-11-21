Return-Path: <linux-fsdevel+bounces-35464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375149D5079
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 17:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7818B265E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 16:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F283C19E971;
	Thu, 21 Nov 2024 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKrTf+uS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B09156225;
	Thu, 21 Nov 2024 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732205201; cv=none; b=euTitAKqqwuzVHiFe5xjTCtt8IEI9F4v4Vt6xRl5QjQ8/kdPFOSPOVezK/MiIxQpSkSEb/cA7ExvnNXvupGrreTB4GCTQsib/3uNJTwhrFLpefW0ryBJqTkHeJSvkUU1SAVIF4sLP1EMbMgEOXeJ8p9+JvcOsug0Wx2EuVsX0QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732205201; c=relaxed/simple;
	bh=C8T8mYqrzwRHWqyx+aUozIQZh0FIc2juAi/4cJz/SjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKQJ1vKehQxbNfZoJPfcKOoZban+KZ5qswehn/EJk4aWBcwoiRBox1d9kTF/Erexn/NXgxxQIsQ7yWhQPsyMQM7ds7Jxk/8DsljQYdfUA22zQZAJdd1ijeT2+EtMFdF71+py1oYQS5lEPCTS2NbSBEZ1st/RucogPu3W0jZtu5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKrTf+uS; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9ed0ec0e92so143537766b.0;
        Thu, 21 Nov 2024 08:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732205198; x=1732809998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8T8mYqrzwRHWqyx+aUozIQZh0FIc2juAi/4cJz/SjY=;
        b=CKrTf+uSfss8vs9bhqZf3NZzPL35HkchduaT0C/8EtnRVQ5ayyfnIoyEu06zlwe1CD
         CM/M3n14IO80fcGfuNKwCMgJIN3tgJzAO4FXrV5TUT7CVnBkihRAa8TnRy0kMqhn1UTm
         pWlz2Eag/63z4fjG2C/QJPan0G9pa1DgUA5STxmCgTVWCtWgMfQlNAOxwFOG4wD5djdc
         CxG0afbvUxIwW2HrWCISPZUDBKaAvHhBi6Q5+ArnjB4b7E6NrDbspbI8V9Bvh4FNezhf
         0on+rW48C9tQz/9QJtxrR2UnaSPsQ0Ejokei3H/eIdYDmq+YYMBKwX4S6vk52/401f92
         /Arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732205198; x=1732809998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8T8mYqrzwRHWqyx+aUozIQZh0FIc2juAi/4cJz/SjY=;
        b=TL0NXqribOK2opvTt1Cjjdg939tQy5IxMSt2O6vQhSSlQE6ZPkIGAfW97aP0EuCp7z
         tDRvmvEFJ1pSQ1pu2uZj49QP3UbXEY4wYZrJWsaci7ND3f9chYVP0GWwIGqHWiqwgGnI
         V7eGvz1dfphrPGsf9hOkeHu6b4ly8RsIEC3ac45sJQJbvHpeCkm6Seklp1VaRDFLhsyR
         fz64DN+PQ5xa5eiX6MpFvRDosvDXLcXACDQRJwQaE4azJkIDMVLfVf4BiISq15ueFZBr
         DvNvuxifGIdn0fK53dQfaxFwHHvcmCX3MeAowvBk4ec5t/6fPQuHY7iWEkaKOq+m3ccJ
         crYw==
X-Forwarded-Encrypted: i=1; AJvYcCU8pMCszTS4lCJFzpfCVt7Jm5YaGn2B96qT9xfLFxjJYNC84pMkBNUUzV10aNsudEP/C3LS+3BgcR2LVA==@vger.kernel.org, AJvYcCUv4n74iyuWHhb8MieVDkFkmm9TF7mzKpdwagM1yiTeZag2IQOoqVETWu0LPo0qSRPfG1Urt+MilBCTfQ==@vger.kernel.org, AJvYcCVX8iXEfIpDIg7BCrFpDOPTk0qGWgStM8TdkY7AsYKsfVNDZ2aIZ3/da0BNXW8VipAwQGGht9yZuILx@vger.kernel.org
X-Gm-Message-State: AOJu0YyB0wVGslz3SqoUyPEr4P6uuZ1/YQdo80uMMrnny3r/42//wPv2
	VOGh4cgg5EOGebqQbTiOgUhOuJ4Ks0uW4mBBaxmQakAHfvvFmKXKSS0c9RX7yL2uL4c69jKC2kY
	79ufLTM9z1XnnEazY1wPxyZXzTBc=
X-Gm-Gg: ASbGncukjB5AEr8G6KZTfdZP4J/M24q9tHRigiAz9sRXYGhG/c+9hvnRNuMzYQ1BUs0
	it5dLiZ7QUG+8QRHOvMMc5FNlNkB/s3M=
X-Google-Smtp-Source: AGHT+IGVjwdOPsUK3V0cbw4K6xWRphkCK0DuGSlSpsCdCyu66o84N965jp+z0T5f9wyLT78CKZbCDsxh+FlsY3vu8CM=
X-Received: by 2002:a17:907:7ba3:b0:a9e:b471:8308 with SMTP id
 a640c23a62f3a-aa4dd764962mr570109266b.49.1732205197592; Thu, 21 Nov 2024
 08:06:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121112218.8249-1-jack@suse.cz>
In-Reply-To: <20241121112218.8249-1-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 21 Nov 2024 17:06:26 +0100
Message-ID: <CAOQ4uxjEc+YZaOqWvSDsQUvnAjfBpP++FSGvvk0+-ZeSuwsBWw@mail.gmail.com>
Subject: Re: [PATCH v9 00/19] fanotify: add pre-content hooks
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, brauner@kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 12:22=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> I'm posting here the series I'm currently carrying in my tree [1]. The ch=
anges
> from v8 Josef posted are not huge but big enough that I think it's worth =
a
> repost. Unless somebody speaks up, the plan is to merge into fsnotify bra=
nch
> after the merge window closes.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git/log=
/?h=3Dfsnotify_hsm
>
> v8:
> https://lore.kernel.org/all/cover.1731684329.git.josef@toxicpanda.com
> v7:
> https://lore.kernel.org/linux-fsdevel/cover.1731433903.git.josef@toxicpan=
da.com/
> v6:
> https://lore.kernel.org/linux-fsdevel/cover.1731355931.git.josef@toxicpan=
da.com/
> v5:
> https://lore.kernel.org/linux-fsdevel/cover.1725481503.git.josef@toxicpan=
da.com/
> v4:
> https://lore.kernel.org/linux-fsdevel/cover.1723670362.git.josef@toxicpan=
da.com/
> v3:
> https://lore.kernel.org/linux-fsdevel/cover.1723228772.git.josef@toxicpan=
da.com/
> v2:
> https://lore.kernel.org/linux-fsdevel/cover.1723144881.git.josef@toxicpan=
da.com/
> v1:
> https://lore.kernel.org/linux-fsdevel/cover.1721931241.git.josef@toxicpan=
da.com/
>
> v8->v9:
> - fix DAX fault handling for ext4 & xfs
> - rework FMODE_ constants a bit to keep FMODE_NONOTIFY a single bit
> - move file_set_fsnotify_mode() out of line as it's quite big
> - fold fsnotify_file_object_watched() into the single caller

I tested this with my new test cases on LTP branch fan_hsm.
One test broke, I posted a suggested fix for patch 3/19.

> - use explicit f_mode checks instead of fsnotify_file_has_pre_content_wat=
ches()
> - fix compilation breakage with CONFIG_NOMMU
> - fixed up some changelogs
>

Other than patch 3, all looks good to me.

Thanks,
Amir.

