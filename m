Return-Path: <linux-fsdevel+bounces-63944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CEBBD2942
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 12:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E123C20E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 10:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7142FF649;
	Mon, 13 Oct 2025 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIQhb/oU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DE72FF16A
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760351386; cv=none; b=r+Xne56VYuKNkgmse7fzBlPs+kW+NVHrmwJyGCo8rXuCb2/lbXUP9BqJ6r3Vw7h+AgYy534BnzbMMNfAEXNl+thcXTKWWGBmgxhPQuXFxnciga3cVfzv4lqRKQpi4B7gkgb3taOvwxx+dtPwY7u5bEx0KOdZgjmXOslTXlX9NZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760351386; c=relaxed/simple;
	bh=SVPUlK6sYHZahK5O3+GOTdw6Bx0G0qiDlm5PKLNZXQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMPEr+Ybd5Sb6a3aZjQyD04bXhejibpwnY1WtChMDasoNtKaLJUSvo255r0ehdACMz16x5r04hoZYnYwLH5nh0IEbv/7/T2y8M5IME1FPxrrSOLpen0a2GRa7YGv7SHB/ySKympkBz6zcrN1rnYguF/+A/KraN+ArHn0zHBUNKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIQhb/oU; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63cf0df1abbso2270105d50.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 03:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760351384; x=1760956184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVPUlK6sYHZahK5O3+GOTdw6Bx0G0qiDlm5PKLNZXQA=;
        b=ZIQhb/oUlO3F9MEPUxurf/mgWI7Y1g8uHfT6SNbxuv/4xY5+m/YraZW/5KqmjRIwzX
         rdTRUXUR5ZYcRqHAcjEXbyqp9QPzrQjcU/+tE2lLY7zsYf9eKvPgMh7Yb+eG+DeMYl1A
         NNkv7u+ELQLfd91UVqU5n/EDVbx6VQywzqTdWGNVo8cwyfdUj0VZFPUXp9En5uePFJsJ
         B8tJ7rKH5YlpW+Pq8nGhj+PB2fjPaXocpEbEosY0ETAXl+QzWKYisCRZclqHs3mpy0wb
         S17h9fT1i/DEuznIcB2PXT67kVi/TGa5zjTd/jM4v9YckG+ajQAB0eFRwEULsu95liHd
         eM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760351384; x=1760956184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVPUlK6sYHZahK5O3+GOTdw6Bx0G0qiDlm5PKLNZXQA=;
        b=dSVFn4p0L20SIJ+jRJ5KVXW+OwkW+ogqutoUo2bDxMMLNGQftiX7lCIeH5tjAqs+b6
         xJN+fzuKZlLBs4E8SYwgnNMAawfVbWhEZni6X9/ta4uqp8Lfwuxm5kkBLG1oGrSE6EZk
         gvDF3obPS5tAyNz2E6dSQHVRqIPrWyUgx2dUIgtdqQbNGcEr9Pk6zrLLeaXoguZ4sjEW
         1UBViGlJwiZEwvIS7+jXMU4FFbLr3SabasBQ80gq/Egz1vvLPschWZXsTY+HlgbO8Itw
         krtFz3/5IqkymyPbmWX2vPPYL7V7exlARxRofHAia8jS0jBLNcmbBNQgF0tNCfbQFMKu
         VFEA==
X-Gm-Message-State: AOJu0YxNJKZMUR5Qe0C5Yf2yzSjiTngC1HawqHlEG/NayOpm3Tt6YVKP
	TC7rXbFN9WKZe8YjTa7eVpZLqAAGLQkH9xe22ADsuxY2Ms8UdcWoqDzmCvnIaaIM1GLp82m0skA
	pS05GbxVMX3j0narxxmV2NTG9jyMBlLo=
X-Gm-Gg: ASbGncsFwIEXz9pUPpFzYuAHr2zSH8+GokUkrttp7nuh+cUCMRIRAPTY57is13Pb6gE
	xhL+vVZu9zWHU3xlY4jDiu8zYn12EATIO113V1UFRZJ5BVh+/mf3LZe+Fy+J3wvchrVadzyycha
	OVBI2cILBL11wdevBuHnypjTw+0rcJEd2/IFfM7P2f3+Ztw8yOph36mRMzE23Cf0UyEo+NPFYou
	63MlF+MeWiPcYDtnp6qQiFzJmhOWZuKlJkI
X-Google-Smtp-Source: AGHT+IF7gB/uIYJ4y7t+OLiZ00mCO9lllMt+QoIyqpZ385m2NgZqSy+lqlMIQpqL29tGtjodZ9h+RUr8WRjGSui6l/0=
X-Received: by 2002:a05:690e:4186:b0:63c:f5a6:f2f0 with SMTP id
 956f58d0204a3-63cf5a7080fmr6997775d50.66.1760351383745; Mon, 13 Oct 2025
 03:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010094047.3111495-1-safinaskar@gmail.com>
 <20251010094047.3111495-3-safinaskar@gmail.com> <07ae142e-4266-44a3-9aa1-4b2acbd72c1b@infradead.org>
In-Reply-To: <07ae142e-4266-44a3-9aa1-4b2acbd72c1b@infradead.org>
From: Askar Safin <safinaskar@gmail.com>
Date: Mon, 13 Oct 2025 13:29:07 +0300
X-Gm-Features: AS18NWAYGkNu7BjeCT0jHGno_eA5ARoSWF2j7yYdLIuVOnrJP74yF3CsWnjM_B4
Message-ID: <CAPnZJGDe+sDCsCngHyF6+=3=A9pYwQ1+N87jpq-ZdsSvVbQuNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] initrd: remove deprecated code path (linuxrc)
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Rob Landley <rob@landley.net>, Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	Michal Simek <monstr@monstr.eu>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dave Young <dyoung@redhat.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Jessica Clarke <jrtc27@jrtc27.com>, 
	Nicolas Schichan <nschichan@freebox.fr>, David Disseldorp <ddiss@suse.de>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 10:31=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
> There are more places in Documentation/ that refer to "linuxrc".
> Should those also be removed or fixed?
>
> accounting/delay-accounting.rst
> admin-guide/initrd.rst
> driver-api/early-userspace/early_userspace_support.rst
> power/swsusp-dmcrypt.rst
> translations/zh_CN/accounting/delay-accounting.rst

Yes, they should be removed.
I made this patchset minimal to be sure it is easy to revert.
I will remove these linuxrc mentions in cleanup patchset.

--=20
Askar Safin

