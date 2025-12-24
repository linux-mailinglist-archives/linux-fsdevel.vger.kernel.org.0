Return-Path: <linux-fsdevel+bounces-72027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A965CDB809
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 07:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07123300BD9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 06:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD4B329C43;
	Wed, 24 Dec 2025 06:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cABr1VWN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84112E0916
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 06:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766557934; cv=none; b=gtxH7YxURDBs1+Bsabq6W8Qn371iPgsSqLu+pw8CUpTjjNGHNYMlwfnRgp/thigE3x3++80dtpVyQHr+5pe2kG02qLRML7Hphsjq1OsV3Nr7xcp6fJ++84rN07T+ixRBRXiY9HS5D1iGgIg9cR7uBpcgBSRJEqO0a57OSLfQ8FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766557934; c=relaxed/simple;
	bh=1uKvSx8GPclRpAHaq5nkAFgGmVYzZkjqW0QbtatV/JQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVo6abaSMUy5h8m9XeIkfJzykQpO6QW6+63D8NM9Ixy+U5qhqyjNXHj7nxdttuA9zcJQpDvNfOMfuYVfBHjS99Q8mbZTJkpA1xMM2GyZezyVzDrVbMVwShWx4mw9uMQlfbiNkE8KTEOyZqkI0GKkVgbnP/x9oGiFSO7Hq32RI/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cABr1VWN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7ce5d6627dso920102066b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 22:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766557931; x=1767162731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uKvSx8GPclRpAHaq5nkAFgGmVYzZkjqW0QbtatV/JQ=;
        b=cABr1VWNJZlERfmPvcL5ZTRBOoc0nh4plU0wVu7poaxv0k+wp9tVCz9UEusA6Bw3Xk
         9eR9u6Zr25me9l13uXoa/ljIpcgTOdFJPzvUjqYFMdicmy4rxRFIu8GRmjiY9V4Jhn/+
         /knu79H1SbtwcTqO4GzeCcxhCVz6U0kI6f8ku0JhUONyG5WduOrXdBZ16Ms6xrV+I52e
         PMWPhkoMVPhgsbXPXhnCl4uUJ1ICg8/YHF6X7o8G8ENqD6TDnkhWQ7poaKiTlnwZKS9k
         to8DAUwHtzBEi2IwgrfuqKTMesGbsXvQeGo6bi+m9+2fWYPCRrJE9qOn2C6KWTgw2SwG
         Z0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766557931; x=1767162731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1uKvSx8GPclRpAHaq5nkAFgGmVYzZkjqW0QbtatV/JQ=;
        b=UzkMuA1aVKlq5OmeXehIfVuGOEXwReZ+OFnMEyqLKC9i2MoSsEBVM/hkIIKk3oafUR
         zOqnUczghKHVZ4Bxo8QBL86RrIJ3wlYMjed7QFtymnV40qwm4pmNHdLNsdA2mtWjpj5k
         Us3mQ2o5MUj6cOLSkkOXbGWXLAv9VBlk9K6xnQDMcytSZtbmEbYZ5qRczHTpQwpRD2GR
         RaQUI2d4DzXXqeeCnQWxPC7SizoeLgpcldHXv3AVpO1ZCjJ1pqmM2ylVQPsXssDy2AyI
         9jis/a3LS3/q4moKrWgbuhX6XZAzSnTpVnD3htU9IPrjhWsYZbn97jIR0iZ9dWK16vxQ
         dL1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5MrAiZccoyjh6s+ReuXkqEhPFYdPh404a5LETxU4MRgYeDfMRwmW5+4+iJ9JoOgwhUguygwvnwmFufFgv@vger.kernel.org
X-Gm-Message-State: AOJu0YxF3nY/MSiKbqMpbyFUKJyOxa+FKGiFCE8AnvxRuuoAxG+NZJya
	P7jyNvoQzHvhT9B8Pt/uR7+VULUt188MvMZRA54nGTI/lXJmv/T6VGT4nccHHK7HGu0XU0/HNcR
	L5vemrnhgLDUFn4RSxrKjJZXRbMq7Qjg=
X-Gm-Gg: AY/fxX5AjbicUGtaMhO0r0qUlobVeeNgR/dYwMh6bOdET/Hp0Qhafa4RI3AgmhzrF3x
	lGmX3+YBukpXZZ4RNTrfbpfiolwY8nuegsdrAtc8EowurqhJsKzGKnnimp5FN4Pahe1Mp7PI8mr
	Hkq5lUCiy79h6BEerOwWZQXmQUzCJnrFDLJrOdlBLvkPYWiKKku7tUIMsifgRUigubTvVNF/K51
	q1IUPTaKHo2zC2qjOhiAINqyviBGw/61SvwBUIqX66PL0SAZsQkZShuLK+CleAjzrO7pEWpUh0V
	6sjZ/CUNrMmNg+W4shczd67mI4lxww==
X-Google-Smtp-Source: AGHT+IGmJVMeYigFDymdUe/6mHZ/HJiHYfzqfl9VBpWdyLYJMGAbhMPbzcvXggOcLw+GiuN1JxDw9RsWKjCIvLcK4fg=
X-Received: by 2002:a17:907:1c27:b0:b75:7b39:847a with SMTP id
 a640c23a62f3a-b80372228e5mr1842969866b.60.1766557930625; Tue, 23 Dec 2025
 22:32:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223194153.2818445-1-code@tyhicks.com>
In-Reply-To: <20251223194153.2818445-1-code@tyhicks.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 24 Dec 2025 07:31:59 +0100
X-Gm-Features: AQt7F2oRXnzj07uSDlnyIY1XRSS9cYyN-Y5WQrjvs27faDAkUwQ6idplvFpdkLw
Message-ID: <CAOQ4uxg5Qbkt2WzfXojzCNUYwj9BsW6vzKEL4265PQxBgNkdeA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix two regressions from start_creating()/start_removing()
 conversion
To: Tyler Hicks <code@tyhicks.com>, Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, ecryptfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 9:42=E2=80=AFPM Tyler Hicks <code@tyhicks.com> wrot=
e:
>
> When running the eCryptfs test suite on v6.19-rc2, I noticed BUG splats
> from every test and that the umount utility was segfaulting when tearing
> down after a test. Bisection led me to commit f046fbb4d81d ("ecryptfs:
> use new start_creating/start_removing APIs").
>
> This patch series addresses that regression and also a mknod problem
> spotted during code review.
>

Ouch!

Christian,

In retrospect, it's a shame that patches get merged with zero test coverage
and no ACK from the maintainer.

OTOH, relying on ACKs from all fs maintainers will seriously impair
the ability to make vfs wide changes like this one.

Feels like we need to find a better balance.

At least for ecryptfs, if we know that Tyler is at least testing rc1
regularly (?) that's a comfort.

Thanks,
Amir.

