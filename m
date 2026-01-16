Return-Path: <linux-fsdevel+bounces-74030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1058D299D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 02:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A0363038F16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 01:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18D1336EF9;
	Fri, 16 Jan 2026 01:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZ9o0m8C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF5D334C25
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768527168; cv=none; b=GyeXWzeT/M+qwJoPLY2pBpoz1a9JNGWCyyQYHrTULjJ5CJPBjDQ3HDUObYxPrUs1VTp1AmKkxiWGqeX77od6l6eOU+julrPaAaqegWghdBBi+vTqHWKlQsavDEJS+L0TqfR4LA7IjVVVWDC3s1cUw2vANmC7qB5fp9dBRAHFoWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768527168; c=relaxed/simple;
	bh=LfR05fBaCT7z+zJ8nmfKehGrnlWR+0uK2dHZOAS3nLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKYHlvPi6M+g84rpyT3GRUB26gTgyv2y+1xUrHjuwzg1QvYyH0eBLT3XwR+IVrnkshFO7EStJIkJeWao6PrS1IKQiaD3ZxraqrOmVQSZAbMxyvZtTAvSmH8Dd/Al6SVRYeOuG0+ODarlc/2XlYcJr8riaqTPjAMu+KRZzolCazY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZ9o0m8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3352DC19421
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 01:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768527166;
	bh=LfR05fBaCT7z+zJ8nmfKehGrnlWR+0uK2dHZOAS3nLs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MZ9o0m8CQqDUMwnXS+JpGm95Wq+U0v1pagmUMW9jNSkaGI16lW9lmOkcJwrh/GGYF
	 TZGkhVRbKIGVG/iAy5VsrB/LJxDcnmgxoRsWJ/el/rZ67TGo3DI4zrP4uVlR5f4ztv
	 govnS+C3XrOkzDuiG9fRfqu2Mu/XA5mNc4WXdh6+gtxViSerUEK2ltZcuXjuxJaZ4X
	 AE36VgrUoWv16jegAGBk2pEJ7pRaZ1SM/OROu8rQLYUsZj6WqxH7CsyiivgUCylUUP
	 JMeBej/Mn2TYCrbkP0F63UDmHSKPgdM6a/MLbvo09dEwMblaaMjaH10GV+mGixgu1J
	 Rhrmly96tkSog==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so368055566b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 17:32:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJIHF+hKL3XvbjatO+6T9e0qYqQb3FzkIstMTD7ucZBZ2S51t4jb+8+knBv09sZ319lkpaEQ8O7AQ0+ft1@vger.kernel.org
X-Gm-Message-State: AOJu0YyAJRSmKe8dR6ghKXu+gH+P1D6/QMT0s1z++u7JqgD7aHC13Gh8
	HSW8mbN7qJOu/MlijxgzrgDSbnzGsC/KvIaekMM7ioDAVuIR5ldwkj8VWYErMJyYQTh1LYoxnrV
	8VWmpLcLPlYpQFf/XPCeo0IRJUCtnaw4=
X-Received: by 2002:a17:907:8e96:b0:b87:33f3:605b with SMTP id
 a640c23a62f3a-b8792f3b19cmr125505566b.27.1768527164736; Thu, 15 Jan 2026
 17:32:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_193FC4B3056834124EE55CC25255FCE4D309@qq.com>
In-Reply-To: <tencent_193FC4B3056834124EE55CC25255FCE4D309@qq.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 16 Jan 2026 10:32:32 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-=nf617i=KHhkUPWD22BTsBoC5yKDSUAjdi-Ag=4Z6Tw@mail.gmail.com>
X-Gm-Features: AZwV_Qha4IUdbQkIjdk2sahhFeVGUzn0An5hzro6vJU8QqTh86VMMBgfbtyDIJc
Message-ID: <CAKYAXd-=nf617i=KHhkUPWD22BTsBoC5yKDSUAjdi-Ag=4Z6Tw@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: reduce unnecessary writes during mmap write
To: yuling-dong@qq.com
Cc: Yuezhang.Mo@sony.com, sj1557.seo@samsung.com, 
	linux-fsdevel@vger.kernel.org, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 2:07=E2=80=AFPM <yuling-dong@qq.com> wrote:
>
> From: Yuling Dong <yuling-dong@qq.com>
>
> During mmap write, exfat_page_mkwrite() currently extends
> valid_size to the end of the VMA range. For a large mapping,
> this can push valid_size far beyond the page that actually
> triggered the fault, resulting in unnecessary writes.
>
> valid_size only needs to extend to the end of the page
> being written.
>
> Signed-off-by: Yuling Dong <yuling-dong@qq.com>
Applied it to #dev.
Thanks!

