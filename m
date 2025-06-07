Return-Path: <linux-fsdevel+bounces-50902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6002AAD0CE7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 12:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BA93AF80A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 10:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A47220D4E3;
	Sat,  7 Jun 2025 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kf3uHbTc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9F41F8F04
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Jun 2025 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749293776; cv=none; b=DH9GkhF799Dd/Bzx6lBgNIqcGiaoXnLez/DfjlDWsXq7DAxH/5T2d6/IWvlUthMPO3RnxX1VUilUMVG+HDupzS6Lt6JJ1X1Imz8TSTCKNfs0O6WoMQBECLt5BvOzP8onqE2OZtkkW/QhNqFI9EyFn5lIi3uH6tQxDOIb1GtqlGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749293776; c=relaxed/simple;
	bh=68rbpBQntvRcLdwmciMsOOGxiqZt+GYzERpOZRjnwLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMzl0GFLzCltuG3woewBayUl526FEcEMjP5JuhVl44QYs5UKz30TgU33+DES5rqSyHFY6ANkvRA1ONUclOaBibhTSmrI0ZHCiExA7In3JkFIYp44I2zAvU88TsgqC9xkfXdcdholr1yeshYqjJWvExqVFHQOFmXS0pgDx/14758=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kf3uHbTc; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so2671354a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Jun 2025 03:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749293773; x=1749898573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68rbpBQntvRcLdwmciMsOOGxiqZt+GYzERpOZRjnwLk=;
        b=kf3uHbTciYYum1VC5+Ukq84VCs3GRk64RGMjOQ/fHHNECbSNZItrWdXcAmBf2aOyQ4
         OfKwVURPvubUyoKHshwyA0nuRtskdKBe+VOxb3Tg45aYViHmM+uG4ytP9qRF8vXeZTxf
         q7luxWHOgZzUWM9Yi3HV+iX/HNUzY7X27i2ZLcSTi7eJ3NblLAZk9mVw0HSJsUOE4wET
         83yHyO2JZbF5be2sbvI5fb+4zkXwlcN7GiUm/bvJOSj2FyrjwW3MDFafJYQTc5G+Gdt2
         lgtkgzenxlWRTqm2HVRU8emRsz9YtkeMVMxhC+cdz80LCT9Hq8Iwz2jw2QdB1BhTTJsM
         Ohuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749293773; x=1749898573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68rbpBQntvRcLdwmciMsOOGxiqZt+GYzERpOZRjnwLk=;
        b=AsBDOGNCasoxDZcbJ7xwGDTBLqo9OtuK+7PAZJmJJ2EA8oJyBGIt993bnYcg2IA+Dc
         K34idj8KbzFyw06vLsZLq5xDdopQraZTwctraDDiqyT0GTTxf5jyfqk8OfpIChe8ZeE4
         jQoz6vsNIVLfL7p0ivsVjW/1jyY2I+WN22B9H2tny2M8g1FmbMhMnt8bHmclAtD5LZMs
         RNdNW3xUv+0HWhXdIXGWGcNfvkQwgp4IphsKecp8lREyMiFih/VyNAlqCtJ6dI/qtP/x
         nKOqraKNFAxZsmwN6nJCg/7fcO0+Xtfpaml49m/WgDdRapt2Vd24lq+S1uVu+WuHJA/r
         Iebw==
X-Forwarded-Encrypted: i=1; AJvYcCV1gdxIer4GGEUOBWEJb8zB0HwkOrT9GMWmYoFPOenpxQFqkXvt170MDLIHCSCTTZlKc/0moGTjC4LhQdbh@vger.kernel.org
X-Gm-Message-State: AOJu0YyvCt6Ud823z/s0vi2YuMEGGNCLT2+uEG2vFNTPLlqPNy1Pku2j
	v2bsCxHvVbu6ro5RuHmbI+E/Fz4IbUpDvtw8JT3h69cUKdpdGWmiAPkA4lcwNVmA7zyPdFNgTcJ
	RNcWRnvWa2zrfy8N0s+8dbZS8AhePQnU=
X-Gm-Gg: ASbGncuo9579Zp+FxyMk3lUR/Z3oq06ig+yDv037VCurmCYhPY0j1mwfE1Sz6fJ6yjg
	07TwLH8hql5URUAhMYMCx057/NXVOPEc2f9r0vNj8R/sBo3Yu7y/nA256Brcock9n89CSRBqJGB
	wB9TDjm/VziXsMtBjRAAeP87QxG6H8cUC2
X-Google-Smtp-Source: AGHT+IF7O75XkIpr3WO+ut3OtUvj97hBLSDQsafVQE0iGQX6b3ZyPuOr2/r2i+1Uv9QivnPIwi3rtTHKM+t4A4uMeEA=
X-Received: by 2002:a17:907:c22:b0:ad8:87a0:62aa with SMTP id
 a640c23a62f3a-ade1aab90f1mr648992866b.27.1749293773034; Sat, 07 Jun 2025
 03:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605101530.2336320-1-amir73il@gmail.com> <20250605-bogen-ansprachen-08f6b5554ad4@brauner>
 <CAOQ4uxgf+0B5vy1ObhLqeRNmW8JzdotqHAwG7qS3xBZmfAABvQ@mail.gmail.com> <20250605-futter-harfe-67c3532e6021@brauner>
In-Reply-To: <20250605-futter-harfe-67c3532e6021@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 7 Jun 2025 12:56:01 +0200
X-Gm-Features: AX0GCFu_g4lwqKjwKvfq87bL8KvS99mT1AXqM9mi_5HndbYJbzAhXfXsT6U3cFg
Message-ID: <CAOQ4uxiOVpByoqmbuHz-RinO-k3-U1TfmtZPhVu05DQjkCGBng@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix regression caused for lookup helpers API changes
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 1:50=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Thu, Jun 05, 2025 at 01:14:20PM +0200, Amir Goldstein wrote:
> > On Thu, Jun 5, 2025 at 1:00=E2=80=AFPM Christian Brauner <brauner@kerne=
l.org> wrote:
> > >
> > > On Thu, 05 Jun 2025 12:15:30 +0200, Amir Goldstein wrote:
> > > > The lookup helpers API was changed by merge of vfs-6.16-rc1.async.d=
ir to
> > > > pass a non-const qstr pointer argument to lookup_one*() helpers.
> > > >
> > > > All of the callers of this API were changed to pass a pointer to te=
mp
> > > > copy of qstr, except overlays that was passing a const pointer to
> > > > dentry->d_name that was changed to pass a non-const copy instead
> > > > when doing a lookup in lower layer which is not the fs of said dent=
ry.
> > > >
> > > > [...]
> > >
> > > Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> > > Patches in the vfs.fixes branch should appear in linux-next soon.
> > >
> >
> > Could you fix the grammatical mistake in my commit title:
> >
> > s/caused for/caused by/
>
> Already done including the ones in the comments to your fix. ;)

Great!
Only I don't see that it was pushed to vfs.fixes yet. forgot?
It's quite an ugly regression so I was hoping it would get in before rc1,
but no real harm if it makes it only to rc2.

Thanks,
Amir.

