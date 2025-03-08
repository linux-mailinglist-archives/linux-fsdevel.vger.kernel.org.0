Return-Path: <linux-fsdevel+bounces-43505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAFEA57832
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 05:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E633B6772
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 04:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC4815DBB3;
	Sat,  8 Mar 2025 04:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQHgK/4T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E1F2CAB;
	Sat,  8 Mar 2025 04:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741406524; cv=none; b=sGWY2l801ktn6mP+K4LjCmLD9/Su1SoLUtxKcJA8/+ZQ0e8FL1/rAZYgOdU40+vKAbR3nVPuA7V7NVgpJ7pfLo9RPov8mc/2Z+YGKMkf4nz98yRdUL0aw8hHLnOGhtqEV/SPCUg6k5iOU0kDTKeJ9mbn6fH9ckaIVLgy9/mEEkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741406524; c=relaxed/simple;
	bh=hfr0wyaEzKkKUizNbHZm47nBjBY3n3rm0ugk61spGZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMfVZ5BMP9es7TR0f6GFJeT2Jvwe/nylQk6ZjQuJtIAje3TfVHY8wYJRF5YIEXlLmIW/8wZ+MwXMNMgeYc0cOpi6eFSdyfe378SEUEoxBq5G/80y1fQnCIMvqWYKRI3SCvM+8NFuliG7eYtDfgo410loPDJV3OTLkl3HhLFVA0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQHgK/4T; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86d42f08135so507782241.0;
        Fri, 07 Mar 2025 20:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741406521; x=1742011321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iKLKDs+XpuTh+JgpV5e/BN3OOcF0PeT+I5vPrC6fpg=;
        b=FQHgK/4TvngGHFJ8tmuL+s+htS7mmSXwU/oLNbhy0BXVlb79EulF9uM+3MCNOKJ+Tf
         0JGLxDqgyWZfwFL+8FD/uwBKkZkDkvVQUD6l6MqZP3HxgXJ+6JsU12E4OG2qQPnPsM4r
         lIzJvfo2YiTTGe+wKuvuEsgjIVTuVqe6w3LhXJ19sxRYbrRn9pNb9o6IRjWsGO6PLJOh
         HNDnmWn7NYaherLAAl4q78f+bUnEPw17qg0VdwyugCK9GeGfgtj90Hy6oPulww6Djqm3
         HhOjdc9VUbezkO2Yv7roS9C6eGzN7z6X6f9a76zgB4d19PqHE6nu4Tb6SE25C+bQSRm7
         rbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741406521; x=1742011321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iKLKDs+XpuTh+JgpV5e/BN3OOcF0PeT+I5vPrC6fpg=;
        b=PtsOaIsb8e4DoJBeEK6gHxTQNuUTljwhzhj6F2z+wE6j+fnnGRPEDKwo6QC7bo1lMb
         n5a7Wr1BoV8AyZZOxSR+3EUS0ApsQyw8VepkMRrVSG/PwzSCEpc5mNdHVkBi0za6Q05A
         jzpMfs2eKG/c4DQCHxsOm2guO+oFrOHNiNMSg1vEDsSkXBN+lx4LaeZ855zRnvkJNVzf
         JKG8Rg6iMeVF+IB/0VRLSgESLvfSxcAiFb+fFIuUdGM8zZpxuA9PNK3z0rh2GBctOo96
         sQLoMmOIQpeTo8gO6LsgLQi2wFayow4/h8dR6BjrZ56IgiqZvHspD/Zs3EzBGqTtARWi
         wZqA==
X-Forwarded-Encrypted: i=1; AJvYcCVWKimBPDsVdJ5Vo1jnWyH/3I2K+4DdptbOXmQ6BThMSZlcERIfdQTmEM207w4xkNmBklIV7K+B/Edu4i9P@vger.kernel.org, AJvYcCWQl9QEp5zUV38TwyKa3ovhrkVb9Y++u686k6EW/QrtaC4fTt/Xqlhtgz/00vvEOxDIRWDfYVvQm/IDtLi3@vger.kernel.org
X-Gm-Message-State: AOJu0YwHb2TTquwvkrY00pex6Y43kXfJ1b02nccGAJxUil4A23jjD0iv
	j3uuIpuY1NHdfzS0iFoOH2kXYj91oEY/D4KyNRbVzA1HrTFGr1JFDbdVvGUYux5C1ujPLcRePqw
	H52nxIhU4lB7MggkWJJYvxK1GaG4E6oss
X-Gm-Gg: ASbGncvzQuZ7R6AuxR7NAuuddraEiren9NGKJeSo3OLFJfkxCfbR9HrAq6bQHCEQsnB
	UwC0RPnkK561cBiMih13j4i6+HX+aclpW/HoLNe87GRIDbG75X11b1FComtuACnOmelUKayHrph
	jvx+u7+94ZCJPB7x35qImq88JSQ/HRJvfOycjB2Op0s7EFRfwbxbGbmFVUoo7lXOWAEzfO
X-Google-Smtp-Source: AGHT+IGaKKGjYHdm9qJTvxbsOhzY0wfi2YMgm1Hb1u4ej5s1SpkgK27wCmqULUNQ+ZRXFJuhoDX7necVXr/jpfkcw+Y=
X-Received: by 2002:a05:6102:f0d:b0:4bb:c527:aacd with SMTP id
 ada2fe7eead31-4c30a71a88bmr4033061137.23.1741406521409; Fri, 07 Mar 2025
 20:02:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308022754.75013-1-sunliming@linux.dev> <174140535640.1476341.8645731807830133176.b4-ty@kernel.org>
In-Reply-To: <174140535640.1476341.8645731807830133176.b4-ty@kernel.org>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Sat, 8 Mar 2025 04:01:50 +0000
X-Gm-Features: AQ5f1JoC6zLZwSj-S6sQ5ahAOKdFVqxIaOTWC65exX-gSgT0gEc8578Z-BCtIW0
Message-ID: <CAKbZUD1ieaVVD9A9CG=5oCacud4JqnxzYgMv=fiQK=2zT_y10w@mail.gmail.com>
Subject: Re: [PATCH V2] fs: binfmt_elf_efpic: fix variable set but not used warning
To: Kees Cook <kees@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	ebiederm@xmission.com, sunliming@linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, sunliming@kylinos.cn, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 3:45=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Sat, 08 Mar 2025 10:27:54 +0800, sunliming@linux.dev wrote:
> > Fix below kernel warning:
> > fs/binfmt_elf_fdpic.c:1024:52: warning: variable 'excess1' set but not
> > used [-Wunused-but-set-variable]
> >
> >
>
> Adjusted Subject for typos.
>
> Applied to for-next/execve, thanks!
>
> [1/1] binfmt_elf_fdpic: fix variable set but not used warning
>       https://git.kernel.org/kees/c/7845fe65b33d
>

FYI, there's a typo so this patch won't compile

>+ unsiged long excess1
>+ =3D PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);

s/unsiged/unsigned/

:)

--=20
Pedro

