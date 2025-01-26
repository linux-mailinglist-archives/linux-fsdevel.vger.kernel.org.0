Return-Path: <linux-fsdevel+bounces-40132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C407A1CE34
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2025 20:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129FD3A30B9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2025 19:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ABE181B8F;
	Sun, 26 Jan 2025 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfAFrqLY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2C3156C74;
	Sun, 26 Jan 2025 19:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737920989; cv=none; b=GyIRTv+VuSr0ObHA6DFFpYbu599KAtbilNr7VtQt7+5wTWpPLiaZdXpJiHlKMxYuzY7cZbECyJF0T1wZ2TkE1PJltm68NJ+ApeEpIH62iThsj9n6o09vw+0Sw8r/Cku4NZGYeHeq4pGSTCD051/9w3/Xw7He2FjuDOOkzE5/mE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737920989; c=relaxed/simple;
	bh=GcwoshmOOGzCPPXI74r4+ais1yOs4mo5qrCkhgVYg7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIhWtRU6vMvSf5bQpOSc/b820TEMwcqG+0qLeQHIEiTPs8rir/vquZaAKVidLVYIdcmNlflMDKnLwTTRKch608Gg4V38D3lT4QyBUkqgZk7pQg1VFuPHQDzFtITGsFSk8qrT+9qSDbzWDxTy1qJ+RpyArLSn0nQhPpqWRERAPZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfAFrqLY; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5db689a87cbso7582026a12.3;
        Sun, 26 Jan 2025 11:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737920986; x=1738525786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqI1kHeWPWrCyTnOSeUds7kEDq7fRa1RZJfOowRJew8=;
        b=mfAFrqLY/MWfGU5DfP17h1xGBLm2vWY6VAxM73HDFuvQavgdvpJVUpU7fsggIZGmbN
         17WW5Ekk5G/TrSwnmXOPokzf6x8iUJ2tjdb6beFWTtA1vZ4zE/PM393sFDdtZyUoAyVn
         DuprztwUVqkj9q6sWc1HKq9OuX3zuHaBqZdwWcVeF/gxShuFxe2468xKpyE6Hz4dEzUW
         Q5o0ihwKBzmSlIoduXnsUiOypFuDHawTCOH240GCk8gvRCx4/JV5/O4j3Xalh4fX/Qz8
         aVu9X+HLtPbIIFsOajMfJ0njF9oQDyPE5PfbcHk7FaGQmSVCOwN9pPtzdq13SAwM9CZe
         R7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737920986; x=1738525786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqI1kHeWPWrCyTnOSeUds7kEDq7fRa1RZJfOowRJew8=;
        b=oBLBdaKESmg9KumaGEPkus6SqFwn54VCKxpONH9X2nkk6KCDBYUeNx1O6AIxeFw3Y0
         yKvYN+GHNfWFW8NTW0/JUIxsTkTwJLaIRerHrxrANODO8qlXQHkxSNDcublQ+jeaVfgM
         7sRw6ubL7xgL0sD2ZqurLkLD+ZsXO0Wsrv7CB1AlQnKhehp6DQ8Lt5f0mAsRSzBC+FQj
         WoHWoSLqG3JSLAv/ebWnmx0gzjubVh1bpKiCcasLipfOfVqz7iS6lft/er4aofaw/iH/
         CL39Xg/y/3uAEvvjycT/qoHmUowmUSPJINEJOGCrXqcz0TfsEYPJptZq94GGZrhvvJmq
         PPKw==
X-Forwarded-Encrypted: i=1; AJvYcCVgAewYN2gxJKL1sOM35v6cPiMyOcEfn8GAQkmT/i9yvfRiwJ0NdbU5rkx9I+hjfui3FhUVm29vYJXk@vger.kernel.org, AJvYcCVod9FASW0nsSCKL9OC2AeWmzNxC2rI7llFHZR2jJId7eIEbV4qiMef10Bx80VHQEtdFssNBKMWxWtWMDHn@vger.kernel.org, AJvYcCWBDPSxSvMZupIBDrnr1jWMMZN1dsJBiHf5fTQcL4NDy3tp9PLgj3SoDxgQ8ZMw3/G8FyI7HdvTFQJxLja4lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUACtKyhMrzEdDiadqrdRu3hRouatgxPyw4Zjkc08M3g566Jad
	yql0ahQdttd+Bmtl/GfRns4ZFGpzOIV4zHXfwR/WAfwC5Bil+23i4MWrRqa0COvIOvvQEQiNMlB
	jSODdlvRjIiJNM78kdZGG6SN7eftnLJ1h
X-Gm-Gg: ASbGncs8izlXmBZ8DnPMAW4dIlejEyNEPynyFUoDK/6177atX8vf+6r+o9qbb/49iDt
	+QEiXeiRjgdpsKVkNq4qHAKENEuZFPEJXQqw35Spiyt3lEr5xc38dVEEOOV2T
X-Google-Smtp-Source: AGHT+IFR3ZOWaL1ZZyVBJnaoNIX+Mk4OdxmB5ASBcX4nq1Pp1/14gTf5J+OU03nOmMVoQivWH2h0UNmCP3iM9p+scVY=
X-Received: by 2002:a05:6402:26c6:b0:5dc:545:40a7 with SMTP id
 4fb4d7f45d1cf-5dc05454350mr15543192a12.12.1737920985784; Sun, 26 Jan 2025
 11:49:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20151007154303.GC24678@thunk.org> <1444363269-25956-1-git-send-email-tytso@mit.edu>
 <yxyuijjfd6yknryji2q64j3keq2ygw6ca6fs5jwyolklzvo45s@4u63qqqyosy2> <CAHk-=wigdcg+FtWm5Fds5M2P_7GKSfXxpk-m9jkx0C6FMCJ_Jw@mail.gmail.com>
In-Reply-To: <CAHk-=wigdcg+FtWm5Fds5M2P_7GKSfXxpk-m9jkx0C6FMCJ_Jw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 26 Jan 2025 20:49:34 +0100
X-Gm-Features: AWEUYZkRUt4Q96YY3VUUfuaDjDzMU8nahImwbqqrQdGaxaA1WItxAT9WDS0Ez6g
Message-ID: <CAGudoHGJah8VNm6V1pZo2-C0P-y6aUbjMedp1SeAGwwDLua2OQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: use private version of page_zero_new_buffers() for
 data=journal mode
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Ext4 Developers List <linux-ext4@vger.kernel.org>, 
	Linux Kernel Developers List <linux-kernel@vger.kernel.org>, dave.hansen@intel.com, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 7:49=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 26 Jan 2025 at 09:02, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > Hello there, a blast from the past.
> >
> > I see this has landed in b90197b655185a11640cce3a0a0bc5d8291b8ad2
>
> Whee. What archeology are you doing to notice this decade-old issue?
>

Me? Archeology? Not even once!

I was curious what's up with this very much *fresh* sucker:
https://lore.kernel.org/oe-lkp/202501261527.c3bf4764-lkp@intel.com/

> > I came here from looking at a pwrite vs will-it-scale and noticing that
> > pre-faulting eats CPU (over 5% on my Sapphire Rapids) due to SMAP trips=
.
>
> Ugh. Yeah, turning SMAP on/off is expensive on most cores (apparently
> fixed in AMD Zen 5).
>

Interesting, I thought it sucks everywhere.

Anyhow it definitely still sucks on Sapphire Rapids which is pretty
high up there as far as Intel goes, so...

> > It used to be that pre-faulting was avoided specifically for that
> > reason, but it got temporarily reverted due to bugs in ext4, to quote
> > Linus (see 00a3d660cbac05af34cca149cb80fb611e916935):
>
> Yeah, I think we should revert the revert (except we've done other
> changes in the last decade - surprise surprise - so it would be a
> completely manual revert).
>
> If you send me a tested revert of the revert (aka re-do) of the "don't
> pre-fault" patch, I'll apply it.
>

:( ok

This being your revert I was lowkey hoping you would do the honors.

I'll sort it out if Ted confirms that as far as he knows this is fixed in e=
xt4.

> Note that the ext4 problem could exist in other filesystems, so we
> might have to revert (again).  It's not necessarily that ext4 was
> _particularly_ buggy, it's quite possible that the problem was
> originally found on ext4 just because it was more widely used than
> others.

Indeed. Or they might have regressed since, which is why I mentioned
-next for testing.

--=20
Mateusz Guzik <mjguzik gmail.com>

