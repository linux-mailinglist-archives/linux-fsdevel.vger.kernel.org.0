Return-Path: <linux-fsdevel+bounces-21646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DDE90745B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 15:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37932286518
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 13:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCAB145346;
	Thu, 13 Jun 2024 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYHM4seq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF56145323;
	Thu, 13 Jun 2024 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286657; cv=none; b=jo/ojfxM9atoN4DNVwDBPOsAyO+i3GWcv+QBRi6j6j1fMVTeTbi8pB/3DdY28yoDfugi1HYDumSUrCMtC3mA5JjHBFNyRsSGnAVylRO8OybbsPEcXgeEzSTENpqdwce4aIabmOSmgg5/HllLUYF3ISyjlluenF9KongpUtv3AP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286657; c=relaxed/simple;
	bh=9F9GZvswwYDVFAbbt3vHvH8lDLTQkljjJ35nSXn/t4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/4nOe737bGchqT6IbuoDeGC55ZeB76dVTphY/l1P7p+/GYeiysByF/ppoYlsgVAhrzbJyij9R9TIVNv7rEAYH8PymBtBVEuBAKdyKUIntvQioBGzqmND/4L00oR7hEJpDu6NLQ9JCk5UW3rXb49BSYmYcJ1Y+kCOyChhXB0WU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYHM4seq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52c82101407so2077668e87.3;
        Thu, 13 Jun 2024 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718286654; x=1718891454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9F9GZvswwYDVFAbbt3vHvH8lDLTQkljjJ35nSXn/t4Y=;
        b=KYHM4seqSirUqdPIjhmsfpeJBTqZKjTfeB+xzt0cWg1cKH8K5Z8WdDaHeUsfcEifhP
         yXuu1EfNZM00tMQaVTSfSQ5uN1eWz+UIUJhRd9qlzJyM3IO7lPdjyrRFMayokmGo6qfN
         t8VwI7ZAb2VEHIDBtBVivGZTwxQ5PMDN8syDkG0nuEW7frIdCMzqgbLr58ZZQdX2xziU
         2ZxD8QZwMmqcHy4S3Hs0j8SCgS+znAT/51THkZo3ZtYs5YDRsee7II+vSuH25haOpQlS
         L5HQVNUM6zskjvWhK0X0MIDIZMiUzuh5k7dKWbhxf8VHXY94Kzu9GxZ00b+qENSMPOwp
         Obrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718286654; x=1718891454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9F9GZvswwYDVFAbbt3vHvH8lDLTQkljjJ35nSXn/t4Y=;
        b=M6oY5E5zWH4CDb5cK4+c+0ZnaQOZYuhU9S+ZrCy7Hs2MkYrNnoCt3kH+Q+AGuVqyMO
         46bry6qkPoYxiZYYK9QWlYHghitFkyY34+1AQ1y9ZVr2BG6Jt3BPEj0C86BtLaPS3iIl
         RoNudbYBTUL2dkqeKizEA2rLnjWUzuPvYpVcxePtC4D/+XIIYwfX4lX82ttEla53UHu/
         jmzN6NAk/dwIxo/y/Bu525pDKlRahovI61bGabUmaxZXYBAXzMSpOSJxEGWeOBmKZDDE
         nWY4vRXFT3rS6yrsFuVokR0O/tryXECw4T3eWI/ExvBNdtAUNUSBrkZFXtjVxtd5xZcW
         9YwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmcoMjP23eGRwndIK01m+W3E/DxK3GecCSwlmojA3gCQtAvhYGdxCvG0G4EPtW1LHS24PHaQA10tAW/rezyW7uzM+vBYpOrBxjDpPwkSriEZjB8zDdsxmtwOvHHYNToNsNAXBTOXFVoR63kA==
X-Gm-Message-State: AOJu0YzOe3H0ZMQKYxQNRe2qFjTDfvZ2iVVHE+IQ8cX9aSfS2qpRdYNo
	w9Sq69Qqgbk+RC090lEZxu9Al41K2InVaZJrAs0KwIN0qzNrapWA+3+FG5+rIH1v7N1Vx7V3K7f
	KgGzPTqDHIrVWZXYEaysEhQd9LuA=
X-Google-Smtp-Source: AGHT+IGZN8t8ue/zUqid27C61dRQ0yw20F4gYn1EJB4PKwUVZ9Zto5bkDepGGNJi8JMi7LcM1ivhQvPi1EqhTl2iuMk=
X-Received: by 2002:ac2:5de6:0:b0:52c:8b69:e039 with SMTP id
 2adb3069b0e04-52c9a3bfabbmr3601833e87.4.1718286653650; Thu, 13 Jun 2024
 06:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613001215.648829-1-mjguzik@gmail.com> <20240613001215.648829-2-mjguzik@gmail.com>
 <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
 <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com>
 <5cixyyivolodhsru23y5gf5f6w6ov2zs5rbkxleljeu6qvc4gu@ivawdfkvus3p> <20240613-pumpen-durst-fdc20c301a08@brauner>
In-Reply-To: <20240613-pumpen-durst-fdc20c301a08@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 13 Jun 2024 15:50:41 +0200
Message-ID: <CAGudoHEPRrxGnhsztCOQKajXKFqu3oVcQEWgwmvYcpdfocvSKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 3:46=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > All that aside, you did not indicate how do you want to move forward
> > regarding patch submission.
>
> I've picked Linus patch and your for testing into the vfs.inode.rcu branc=
h.
> Was trivial to fix your typo and to add Linus as author with your commit
> message. Let's see what syzbot and that perf bot have to say.

sounds good to me, thanks

--=20
Mateusz Guzik <mjguzik gmail.com>

