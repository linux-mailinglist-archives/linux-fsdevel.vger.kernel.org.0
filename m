Return-Path: <linux-fsdevel+bounces-18751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2768BBF85
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 08:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0141281FC0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 06:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480CE63A5;
	Sun,  5 May 2024 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1NV5ldG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1DB2F2E;
	Sun,  5 May 2024 06:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714892257; cv=none; b=RymCzIYldExoA2/hZw/5pqkGc+55xzLi08wUtptX6XKVJPBw9krN8nynzeQrXf/lhCMLsdAY6SZkBrOZ1IjIMTzcIHTL19ZdNYLigzT9Rpb6KK9p1oGbCByaI8bVjNSvVGQTEg4cACbm2uC+s9hUbSASCTke9g/swIDh9R8sVo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714892257; c=relaxed/simple;
	bh=rPYKWbw6mpc/6Z9Pr6SAf3qsbHVFx5dRNbBrmhKr1Pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4n9ypIYON5EGFPC0YfDbjPIrU4TKzJe/xBNh/F8uVZVCYgsKv+yoHvy2nVRYUS1Tw3AOWBLJbJPXrkIzw4CSXdcLneL6/8Ea6oA1r0ZaP5+lL6Uf6rEFDqZHoZ8VCOkffuyAppbDf8GEEaS2k+UEdyzg0at1GW6sUQgW9VqzGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1NV5ldG; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43d4c5f7b1bso1056651cf.1;
        Sat, 04 May 2024 23:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714892255; x=1715497055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPYKWbw6mpc/6Z9Pr6SAf3qsbHVFx5dRNbBrmhKr1Pk=;
        b=E1NV5ldGo16r3IFTAlbqqD7y72rkFo4rFHhRWNxCYZSNVBiIRpsJgB37Asl6kQDOzn
         RuPB5cDW7zLN72/O0Snpw5zC72DeT9lySjurb8h61nLVlofHEiCd2d/jBif4M/jf9wtT
         IHqaJY66EMR0L2rURwpIGu8ogNh5XD7oUQz1zEStQQbsAEF42FpgLpMA6ZlhDoQwDx2X
         8pUOl3pvpG2KwP1XvXSlW7dvB0k/XEtvnYqKKrV8VpHDpiF+WkPu3ETPb7hjyxKLpnId
         pr3TQ5BmOhQpFkzMoPxjIoUEOwwcVMy/FCbTuGA2D/tnK63W0JigriLjr2Sc0590EYw/
         KviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714892255; x=1715497055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPYKWbw6mpc/6Z9Pr6SAf3qsbHVFx5dRNbBrmhKr1Pk=;
        b=rbRbSMrCdJ4Cln5a3Wt4U36/+XgLSKLbCQYG6XXxGbyk5ygl18u4fvRgaaCNUXtHxn
         0jzOLc988RT1bZ6T86RIzU0f2r1bhLYM2Tq7NZr7Fnl8HmagOh1O1b3DtuCyANOwxfu0
         oPTSfu5VhO5FQxTrg0F2XcFUHyiqP+ECPoCIct1MfnjtqllN9ZZAVn3tfWHQJ7lY4b1E
         zHKGDzymWl0DQhQjh67D1YMREkSQ58uqOY4iv5auu9HuQH/vQ3W/9NfmIabxA06+bEwC
         LpvPKVf/elWWRvAA4LsTuvR/T/ZzJySMfmqcbYBGOFajC8B8vytGuzyAeuPRCVY0RVYS
         /9mA==
X-Forwarded-Encrypted: i=1; AJvYcCVnyDXl5viH+ch4vaBFwiQkjN2krzLwjnQuol6HpHo/GEBdfK2KIOCNEJVYFO2+UWCRfS3Xrr2jJKwbgrj2NyqXBCt7X/2rFIOGv+H/dZfMzki7xKerXwxmvvenbwUUBjhz38zJi5YHl9q3lg==
X-Gm-Message-State: AOJu0YygE/BLU5wt1hoZwya76DqCZFws4Zl5X7o4CW77y1BcgJwNm/UA
	7QDx12DNE2u6XNq4QhKw+lPAc9EZb/CVAKmbquGmbqMBrb3En+kisAJmoSWXlpskda/Zy09PoI8
	skApXeBWpo4k/QKOHsNJQxdb3Ed4=
X-Google-Smtp-Source: AGHT+IHMIar5qkt7K7JRjINCKZ22aXQO09DEOXtYscVzQFP3FlU/7M7jgEot7N+18mTrkGiD9s5UOLx5+qmTjbQeIzE=
X-Received: by 2002:ad4:4ee2:0:b0:6a0:b905:96ed with SMTP id
 dv2-20020ad44ee2000000b006a0b90596edmr9531257qvb.43.1714892254952; Sat, 04
 May 2024 23:57:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF+WW=oKQak6ktiOH75pHSDe7YEkYD-1ditgcsWB=z+aRKJogQ@mail.gmail.com>
 <CAOQ4uxjh5iQ0_knRebNRS271vR2-2f_9bNZyBG5vUy3rw6xh-g@mail.gmail.com> <CAF+WW=rRz0L-P9X2tV9svGdTbhAhpBea=huf-_DDfkz29fXUyQ@mail.gmail.com>
In-Reply-To: <CAF+WW=rRz0L-P9X2tV9svGdTbhAhpBea=huf-_DDfkz29fXUyQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 5 May 2024 09:57:23 +0300
Message-ID: <CAOQ4uxiGpShrki9dnJM1hvz1GPPcDos6P8pAkAz_jksy4gJdsw@mail.gmail.com>
Subject: Re: bug in may_dedupe_file allows to deduplicate files we aren't
 allowed to write to
To: Hugo Valtier <hugo@valtier.fr>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Mark Fasheh <mark@fasheh.com>, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[change email for Mark Fashe]

On Sat, May 4, 2024 at 11:51=E2=80=AFPM Hugo Valtier <hugo@valtier.fr> wrot=
e:
>
> > My guess is that not many users try to dedupe other users' files,
> > so this feature was never used and nobody complained.
>
> +1
>
> Thx for the answer, I'm new to this to be sure I understood what you mean=
t:
> > You should add an xfstest for this and include a
> > _fixed_by_kernel_commit and that will signal all the distros that
> > care to backport the fix.
>
> So right now I wait for 6.9 to be released soon enough then
> I then submit my patch which invert the condition.

There is no need to wait for the 6.9 release.
Fixes can and should be posted at any time.

> Once that is merged in some tree (fsdevel I guess ?) I submit a patch for

Yes, this is a good candidate for Christian Brauner's vfs tree.
Please CC the VFS maintainers (from MAINTAINERS file) and fsdevel.

A note about backporting to stable kernels.
stable maintainer bots would do best effort to auto backport
patches marked with a Fixes: commit to the supported LTS kernel,
once the fix is merged to master,
but if the fix does not apply cleanly, you will need to post the
backport yourself (if you want the fix backported).

For your case, the fix will not apply cleanly before
4609e1f18e19 ("fs: port ->permission() to pass mnt_idmap")
so at lease from 6.1.y and backwards, you will need to post
manual backports if you want the fix in LTS kernels or you can
let the distros that find the new xfstest failure take care of that...

> xfstest which adds a regression test and has _fixed_by_kernel_commit
> mentioning the commit just merged in the fsdevel linux tree.

Correct.
You may take inspiration from existing dedupe tests
[CC Darrick who wrote most of them]
but I did not find any test coverage for may_dedupe_file() among them.

There is one test that is dealing with permissions that you can
use as a template:

$ git grep -w _begin_fstest.*dedupe tests/generic/|grep perms
tests/generic/674:_begin_fstest auto clone quick perms dedupe

Hint: use $XFS_IO_PROG -r to open the destination file read only.

Because there is currently no test coverage for read-only dest
for the admin and user owned files, I suggest that you start with
writing this test, making sure that your fix does not regress it and
then add the other writable file case.

Thanks,
Amir.

