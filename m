Return-Path: <linux-fsdevel+bounces-30197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0314987868
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 19:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99ECBB24E58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 17:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BD915E5BB;
	Thu, 26 Sep 2024 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX1OnYmF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76844C79;
	Thu, 26 Sep 2024 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372147; cv=none; b=Sll4TQMiAh0z4Ogss6WrulZivrRvvXNYz2Qv3K+bzGywJM3VZySp92GAH//kOjzJYYUBHGK3bXdUaIpWM8FK/yX1AFEMYH75tkF6LVTwU4vccp76aSrCe0OtAt5C1dUbNVyEjpLbFVAN1gEAcTGr0iNQplEuGpj5aJhyZeBN22k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372147; c=relaxed/simple;
	bh=U7kLN438v59+Z6AGiLMsMxCLMWGxpOJ5pYyQL7QdSjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tu1q+HdLYa8LYz4ETt9JZTPaaQAn7x+LjoF2e4fvuAq2hL4wRoM9rqysecdwMkzhJFDeJOyOrpibwZAZOflL9xLNNAj19uW3R2ALwwaPmn6+oBXKKGZjDCr7ihBEKvu0lweh5wKVoYZZhR27uTjpuWHH8pum2jRKUnizf52oph0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DX1OnYmF; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5367ae52a01so1601127e87.3;
        Thu, 26 Sep 2024 10:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727372144; x=1727976944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtR89bH5Z//239xnT5kCrki/umqFGhowZSxev9N5vn4=;
        b=DX1OnYmFwLAAXrch0nD8zY1dtr22TL5cJWbSyZdXxPRBkmPyVhdBugbdbbLqWEcyK6
         aKlhuThAhl896s6DFtIObCKMpp6OiCvgckK86H4bqPnkrIOGha7TET0NBNrBp5qkBfdJ
         R+73lIa8qL4in+GX3vdT3MWO5F++s1wWQtEbKooH0mQ9A8mlW/+JQBwi72vITrvyNvbv
         tqUpDz2M4Rl1Jr7PSQTu9v3NIVGFhSg9fYcKQB62QZWWwXNzqg4Io6mBUsV8H4uYUXcN
         /eqr1gpznWIRI2eLiUkYZAky80Gp4rCJMcLuM4FtHymLpXCb+kdhJj45JHPJY6HcATSy
         vWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372144; x=1727976944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtR89bH5Z//239xnT5kCrki/umqFGhowZSxev9N5vn4=;
        b=PsQpW7GyofaGsG7Mz3FpD64YZuKGcjeH+Kv4Kv9QKf0AM4MPBhqwqIkLNRGvJ/jm+F
         4dn+1DMkr9dGD4PXrqjyKcDRSYWTusTZcc0AfIpBrDsnw0cj6wO+UTwhvkjmUhI0ZIGh
         GIWPLmDAXXd7eH38FUBjBqZE+nw/Hga9dbEJPP9c74ChqrJwqcj5Ci0cNvQb51aNtYOn
         2LUmgdzjMiLrIqC2NCIeOCAJS47z7SuyBcqPcDCHmP6YEe3jrSKhY8xsDIONWxFRbJz9
         4nWBYPg46+bqHkbWUYzU5d3r1FE5LuIg/zzPBFyYxblWo7h7S05udGhR585BiCvRdZ2c
         7MjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3fpgDS787ZLbsfEaoRtJH+BJJlM4FMluV1HGdIK2ma+z301pmMwivwqYGnwiuRInqv3IVwQ==@vger.kernel.org, AJvYcCUrZi7Oeiv1vZiXMokJYaT7QAHMydX7bB6pspRwXSK0pR8Vq/i77omSPq0N/dewqac9ELIjTebIU5R+aiiLtxqdKufs@vger.kernel.org, AJvYcCV7FTW4WLS8HGiKpa5mQRfQlAqYOenoiUcFlSjYJlSnBTKdXBu6QETICM8VnsoWA+kqipfZhuq4@vger.kernel.org, AJvYcCVDAj4AtlAHFM7sd4jAtuuos4B+TEubXf32H0pgQ/MziYzTYywIVZt0q9xdsan3LMsItWxPFQTS4A==@vger.kernel.org, AJvYcCVManuayS0CKeBQf7+DEuiNXlnFOHGQd3uiPXG6/yKWhcvwKbW9ejM22pHRgtNBNSEbOonpdUnIEcSXZbOigvRZ6KEwtgSo@vger.kernel.org, AJvYcCVbt5jf6ZQEAPt0CHCKQwa7KNcIsKtsDRxHxTh4W3pNIXly1Ygv2AeHLTCqDKpBHMR4oLk77/ghpulJJSR4BQ==@vger.kernel.org, AJvYcCWDPWcSzMk8u+hCo0VG8JFsgwdHuiRBg2oHK/S/Vc8fcgjDkJXgVls/TzMYl8WQigkoCFOh@vger.kernel.org
X-Gm-Message-State: AOJu0YxOYMyNRnubNHDPe6ODjKeYsOZy1CqYp46ND91Gh6TYpK/013rT
	ZZZwXzFSTNzLy2GT6KAwaJAox8fpJk7bUi/2YY67toy33fE8hlCyTdbnq91OBtErgYzR136TdRL
	6SZSKF53aoUR8TsYNofduktW10kA=
X-Google-Smtp-Source: AGHT+IHf75DxkntTvBkZGDev4x95K+giFUe8FZhnZLvsyGMJj8v524+ofSRAoRSBODfKCXI8yelsxdzzM7LxitSB/UQ=
X-Received: by 2002:a05:6512:2310:b0:536:536a:3854 with SMTP id
 2adb3069b0e04-5389fc70f56mr217205e87.60.1727372143545; Thu, 26 Sep 2024
 10:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817025624.13157-1-laoar.shao@gmail.com> <20240817025624.13157-6-laoar.shao@gmail.com>
In-Reply-To: <20240817025624.13157-6-laoar.shao@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 26 Sep 2024 20:35:06 +0300
Message-ID: <CAHp75VdpG=yQVaJLR3J5puwj4FYWtXzaHkC1TdmiqfJu1s9PpA@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] mm/util: Fix possible race condition in kstrdup()
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, alx@kernel.org, 
	justinstitt@google.com, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 7:44=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> In kstrdup(), it is critical to ensure that the dest string is always
> NUL-terminated. However, potential race condidtion can occur between a

condition

> writer and a reader.
>
> Consider the following scenario involving task->comm:
>
>     reader                    writer
>
>   len =3D strlen(s) + 1;
>                              strlcpy(tsk->comm, buf, sizeof(tsk->comm));
>   memcpy(buf, s, len);
>
> In this case, there is a race condition between the reader and the
> writer. The reader calculate the length of the string `s` based on the

calculates

> old value of task->comm. However, during the memcpy(), the string `s`
> might be updated by the writer to a new value of task->comm.
>
> If the new task->comm is larger than the old one, the `buf` might not be
> NUL-terminated. This can lead to undefined behavior and potential
> security vulnerabilities.
>
> Let's fix it by explicitly adding a NUL-terminator.

memcpy() is not atomic AFAIK, meaning that the new string can be also
shorter and when memcpy() already copied past the new NUL. I would
amend the explanation to include this as well.

...

> +               /* During memcpy(), the string might be updated to a new =
value,
> +                * which could be longer than the string when strlen() is
> +                * called. Therefore, we need to add a null termimator.

/*
 * The wrong comment style. Besides that a typo
 * in the word 'terminator'. Please, run codespell on your changes.
 * Also use the same form: NUL-terminator when you are talking
 * about '\0' and not NULL.
 */

> +                */


--=20
With Best Regards,
Andy Shevchenko

