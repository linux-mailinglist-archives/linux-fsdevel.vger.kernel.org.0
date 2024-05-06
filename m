Return-Path: <linux-fsdevel+bounces-18865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E550B8BD707
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 23:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228141C21C8A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 21:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA7815B993;
	Mon,  6 May 2024 21:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="b9etqhUY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBAB15B990
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 21:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032417; cv=none; b=lKHB4rLTpMBBQCYQvVzBDs0847Jvk9Qyg85cP8lX87tu/uAxcgR7I3GeJfiihm7mPOYoKLUHzncjTSqTlJwy+a9V7Ct4fQsd9iDoRq6a3cUOFcv1M2OAwJe2SiFO4PrzUPqD/31BUfjkgvWOBPhsD9kvLc9jUB1ASrn3j0Naa+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032417; c=relaxed/simple;
	bh=6z2N8CtrbVaimdDtZ0PAq6tAC1qn5J+ZvkytA5tacSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGqFgS33UWjcC26reFrw1NJoh+npZgtEZUA7zEH2OpnUjbsmCs5GKGBovrmOPzym6rC0y+t613UdtbC5Fj1bNR4OAZpYRPKsyX96aMUVbf+SsFt+ND+nc37lX/MGU02YA7zOEFEQNDDRkhaYWRpgUhALIru9zjdONyrzewfw22c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=b9etqhUY; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4df2fcafc19so646583e0c.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2024 14:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1715032414; x=1715637214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeUVpQq/22mOYcKReCK3JqvU1k/TRLUaHjaQZvRF2NE=;
        b=b9etqhUYq9W3jFOnartK2afBDMImdFDpjRaatf2DWlTDDyA1xcnQQiz2LkJVHLs8tW
         jYQN4mbotk1z7KLgDVp2dWsxEFKpyfbOiLsbJwmNH8r/wntd4XEujLjyfukjD/Ul/JyY
         vgdXTZkzFtiQG+/Ion8mI6XwrnvxIXUty0M81dND19jr5ybsPPqaVwETQVoi+ZP/DCC2
         Ij53kotdedrRJV/iWAoHodKJwpds5Jpe/nSm7J36zT9oGg1lwPI+pPtjZkZroUJdtLW1
         A+i/CiJrrX+OmHQ+yiQw/p3d97+aFCmWvJgeFGziFD69DQJkD0XA5ZDH3KqLB71+lQWt
         Fzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715032414; x=1715637214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeUVpQq/22mOYcKReCK3JqvU1k/TRLUaHjaQZvRF2NE=;
        b=srLHa8tebZq90qOhrDCpxKLS6N8qupH4Hh5e1iFjR99meHK40f2uAQ9rV6wtz6Roks
         OD+1EvC9YkeMD5aR2+HbdNhfoaI/4XBC6Q2LECBtV2JlnYpXQfnQJROp8RqlCatiQk04
         3HC2cTCo1qQ83mVtNtOWNF8Is1VI4gDu7RfTKsOnmtgIagb/NNR2BEMxmXyPpokLEKc9
         d4ROn/HOZBCqDEGkkC/wlY5IWkwFyNtG1cw2nUD2RXzD1JLC8L2ovbVCxY199qhmjE+N
         moPizrE7WAr593JWdLcp0ZR6Zbo72BhMqx4B6USCofCHjK8j+sabg0o2n9kLU77PD9Gb
         i7gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCCjGRZMT3RdZZrsTqL4a8NoO4+ndwc2otkGi7rtpR2GjHdJoTFsDqCXV5Ou9f+bNvtayaxNBmQLWUTRhYeYD7i3XT6zqTCqDlha8QBQ==
X-Gm-Message-State: AOJu0YyYANvIqdxxY9UtGUXOVuQjz+bxDX2/w/WiryEARZG1tIPOY14t
	vsfCxYKPhVxGSW4InmWiizvKR2E75BB7KKRSn3boSuHFbmdDDK2cBgl8mXxk1srkYJR+DwzcXQQ
	MEntPsATEjhgomOfO21Jk/natOt60+6WhWLun
X-Google-Smtp-Source: AGHT+IFFGjpc6gurEzgN72E+Wq4iiRoXg5mY38Fpox/mXhnM3mo9+hh8ShKzv7M/jZm4iGVJuVAQTPuxzjnTjoN24H8=
X-Received: by 2002:a05:6122:3089:b0:4da:9d3e:a7df with SMTP id
 cd9-20020a056122308900b004da9d3ea7dfmr11204998vkb.5.1715032414464; Mon, 06
 May 2024 14:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426133310.1159976-1-stsp2@yandex.ru> <CALCETrUL3zXAX94CpcQYwj1omwO+=-1Li+J7Bw2kpAw4d7nsyw@mail.gmail.com>
 <20240428.171236-tangy.giblet.idle.helpline-y9LqufL7EAAV@cyphar.com>
 <CALCETrU2VwCF-o7E5sc8FN_LBs3Q-vNMBf7N4rm0PAWFRo5QWw@mail.gmail.com> <f8fafe1953ed41828a4c98187964477b@AcuMS.aculab.com>
In-Reply-To: <f8fafe1953ed41828a4c98187964477b@AcuMS.aculab.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 6 May 2024 14:53:23 -0700
Message-ID: <CALCETrXU+F3cHR+RMvvypCPP3pBZK3WkS5sSEVqLp1rjK8yMpQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] implement OA2_CRED_INHERIT flag for openat2()
To: David Laight <David.Laight@aculab.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Stas Sergeev <stsp2@yandex.ru>, 
	"Serge E. Hallyn" <serge@hallyn.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stefan Metzmacher <metze@samba.org>, 
	Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andy Lutomirski <luto@kernel.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 12:35=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> ...
> > So I want a way to give *an entire container* access to a directory.
> > Classic UNIX DAC is just *wrong* for this use case.  Maybe idmaps
> > could learn a way to squash multiple ids down to one.  Or maybe
> > something like my silly credential-capturing mount proposal could
> > work.  But the status quo is not actually amazing IMO.
>
> Isn't that what gids are for :-)

I dunno.  How, exactly, is a regular non-root user of a Linux computer
supposed to configure gids in their home directory so that a container
(which uses subgids, possibly dynamically allocated) gets access to
the correct thing?  And why should that poor user need to think about
this at all?

--Andy

