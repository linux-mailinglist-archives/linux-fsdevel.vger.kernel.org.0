Return-Path: <linux-fsdevel+bounces-39767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9D2A17CCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 12:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE6B164355
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 11:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1EB1F151A;
	Tue, 21 Jan 2025 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTzACL/u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFEF1F1514;
	Tue, 21 Jan 2025 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737458083; cv=none; b=SlD5/Ch/sfpfbhsmx22RQzzPdaLcbinB5yGxV0DEwEt1eG28BqVhlVzAjvVao6XagBjvr6KmjtOxH+w6/Fc5HOY0qyEzZssRq4PbmU4Tyiy8Hl0STsrYO/wv5JkH8S5nlRdx6i5Ug3frls7iRvz/ceBt7fHjebNksMZnfQWhmW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737458083; c=relaxed/simple;
	bh=irCW3h1QxLaI8q46pNPNTc+3wQCFUYHnIIDbFy1fLJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVg3lTzl1Iz+fj+wA5Xcp0qiZbz0qUAEd96SvEmJX4lheCtChJzw84yqWpTc1jCgSV+V6joWytoXx4i1I76aY4YMeDyUqYCzyve8yZ2YhMhZKjIyO764+3NLIq7VHxhQKdgPCv3ay34/Ew85C0Pqd/lchwQPmTOHjlQq2Uo0s/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTzACL/u; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso927806666b.1;
        Tue, 21 Jan 2025 03:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737458079; x=1738062879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfL31C5SkfpnPUklSIvB0X0xW2/MmtrNueBSnIvz/YA=;
        b=OTzACL/uV4GC3r+Z6kM3byTmxb5T4vBeYtfjrlQE8wQg+3TtY9TQikSeI05XWNIdOU
         9Uj7tTWOoYkDrkbPR7RQZ2RJGacykIluh+shnJtOg180lU6s1DMtM3oXWGjelns008i2
         RKuw1j8m8bDQlukb7+txPy0Wl0uPppA5cY3UXs3fuBjQNDRzZC2BoJsoZ3zylibR0oon
         t4Frg+d+LeYf/Rb8FyCYLXxyaXywRGcIql1zoB/35e18pjwlnVso6TtHOsseQSe1U7u9
         cVW49OFh0wBNxz6UTHDQHpdbLqpKpCqU8vIkHKdpf56aXdPntnbDG9fhGg7ThDv6pphg
         OcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737458079; x=1738062879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfL31C5SkfpnPUklSIvB0X0xW2/MmtrNueBSnIvz/YA=;
        b=VFu13M9JBfVl3zuVFB9j4/PEQ9G/eRGgtzGiXHj+1+9xlVZ3+F9W3yVP33NFjpD9T+
         Rs/mFyoyMCO7skV5OdLAzRIP6ksyyXHZFgMj6M4J8KKot7c01ipip/GbHvemVG0QzDox
         AEp9WDRxBGj0mg/gMABUgjOmUzk5WTzG47JMiNwjNPuvQuz7TEG56hWu7qPzqn9yq3zS
         Uu3ZNRRTa7IAFfezefZUDDornflN5ArkXVimok3cq9j1oz9Yy/88AUoR7buZJczqg5Fq
         4yWfVZyvGjHA9a5MYuy1lPVNLVnrnjASgorQX2VUTrTtJKQp+pOml6KHhg/PRg1VlX0l
         aF1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBBJhjZiQFPgwrgR4aJizT0vzLK0Z0xj6G45e+NW7oExaPXVXzsB+ziWCrH5chgConDawASqxYNMgiwctx@vger.kernel.org, AJvYcCX3gpVPSxFMdENa2JzNwbJAaRxMAfRPgFe9GYz171LbaPvg9WgHRrPs2BblE+QxDnE30kNc54tjMIXA58DJYA==@vger.kernel.org, AJvYcCXZnPkWrpsFYDndUaY+hIvH7mPUVASjUMIGBZE7E13aXnVwIay+pSl4WksqNNyNCzn3tBLtwMma@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9IYonUu7/dqFF7wkHqLv7kC9kbWv+LIBAAFDBGgifl9RBvDYt
	K2ledHXB/EjueUVs8YezeXzmA8jwWxhhb32cgUN8CizM73zgeZctGrI2QoVeZ2KkNNaKQm09QDl
	AqUsKb0GAP6izGuFtR+3gIUCxxes=
X-Gm-Gg: ASbGncsjYGqSrCJ20iTR4oddoF+Db3jXfHoceiQSscH3cK6v2YmHSQDKQQy7k+Olm4E
	jMABYI+f6T0VE+JCNN8wS72kZ322XRGm/flu7Uio1f+HndPXR3Y8=
X-Google-Smtp-Source: AGHT+IFJIxWSVZE0dlP2IniBWyiO3x4ZjBobjyj7voUHXif4tJdvAl/FWXsgEg8Fy369LfQVWzoY++jE50xRxTzaZTs=
X-Received: by 2002:a17:907:1c8b:b0:ab3:83c2:755a with SMTP id
 a640c23a62f3a-ab38b402651mr1575817566b.49.1737458079107; Tue, 21 Jan 2025
 03:14:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121110815.416785-1-amir73il@gmail.com>
In-Reply-To: <20250121110815.416785-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Jan 2025 12:14:28 +0100
X-Gm-Features: AbW1kvbNw22VX20HmoC_SNhy14TG3L-nywgI3RoArCS5Xpk4sf1STkqh6Wd08v8
Message-ID: <CAOQ4uxj+LF602e3ypBHLpgWhO46CUaqn+sQ6Fcbq8r2cLJu8iA@mail.gmail.com>
Subject: Re: [PATCH 6.6 0/3] Manual backport of overlayfs fixes from v6.6.72
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, 
	Dmitry Safonov <dima@arista.com>, Ignat Korchagin <ignat@cloudflare.com>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 12:08=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> Greg,
>
> Per your request, here is a manual backport of the overlayfs fixes that
> were applied in v6.6.72 and reverted in v6.6.73.
>

Forgot to mention that I backported one extra patch from 6.12.y.
It is not an overlayfs patch, but it fixes in a more generic way
(removing an unneeded assertion) the same bug report that the
overlayfs patches fix.

Both fixes are needed, because the assertion could have been hit
without overlayfs and because the overlayfs fixes are needed to
fix bugs other than the assertion.

Thanks,
Amir.

> For the record, this overlayfs series from v6.7 [2] changes subtle
> internal semantics across overlayfs code, which are not detectable by
> build error and therefore are a backporting landmine.
>
> This is exactly what happened with the automatic apply of dependecy
> patch in v6.6.72.
>
> I will try to be extra diligent about review of auto backports below
> v6.7 from now on.
>
> Luckily, the leaked mount reference was caught by a vfs assertion and
> promptly reported by Ignat from Cloudflare team.
>
> Thanks!
> Amir.
>
> [1] https://lore.kernel.org/stable/2025012123-cable-reburial-568e@gregkh/
> [2] https://lore.kernel.org/linux-unionfs/20230816152334.924960-1-amir73i=
l@gmail.com/
>
> Amir Goldstein (3):
>   ovl: pass realinode to ovl_encode_real_fh() instead of realdentry
>   ovl: support encoding fid from inode with no alias
>   fs: relax assertions on failure to encode file handles
>
>  fs/notify/fdinfo.c       |  4 +---
>  fs/overlayfs/copy_up.c   | 16 ++++++-------
>  fs/overlayfs/export.c    | 49 ++++++++++++++++++++++------------------
>  fs/overlayfs/namei.c     |  4 ++--
>  fs/overlayfs/overlayfs.h |  2 +-
>  5 files changed, 39 insertions(+), 36 deletions(-)
>
> --
> 2.34.1
>

