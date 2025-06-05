Return-Path: <linux-fsdevel+bounces-50779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CAAACF812
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 21:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324C8189BCC1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 19:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E033527D776;
	Thu,  5 Jun 2025 19:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MqC43+xs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBC527CB28
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 19:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749152081; cv=none; b=Qwhn39hXYY2PfTL28JhuJDKqccQVEdwPngVSqWHs62bXNFfn/XiwcJXPs1R4Pr45uOjZlMQCKQ+Apvd4sqrJl2Qoh8YeysKEmRKodL1P+0NCLmaNr54GNyqkauCiktkNF7UvobxIygxZqkni/S3FZjf4xxhc7B1EPo8ZkTHxodk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749152081; c=relaxed/simple;
	bh=MLMRVT5KhSZX/zK3crana9aUgNm8mG8NxDX+aeJa4Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILVyHNawHWamieG2VJiVyI1Rnhd/U22OnCgpywD/y9CRhT0gpBrYA5HqGf9/IhB+6ceXGa99g6hswcTRCEy6xZdq47BDxbCju2QjVDkEcuiFQaTJHQ5dgQq71Nd3yUAtANgKJduQ2RwRfFbmTEbgtlxhvwBPvvXcIBvn7SLxzJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MqC43+xs; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-adb4e36904bso255802466b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 12:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1749152077; x=1749756877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=98kyb7DemcX1FyfLysJO1OG3WiC0g9CHbRupke5oLhw=;
        b=MqC43+xsf12tgStGS1mcZQxngmsvU2pTwWTAlwhNQ5Zv4PPhx1mU3ZGMHf+pWO1DvK
         N2mco9Sx+PNvdHEMPxFoqFtrbTWzA0NBj5q/E5wdo7Wh9DJrjUV+pAiRS2R6wJ0IOHNa
         +LEMpKz2uMtO9iuyc5mfbNDnqrrS15tXvXKrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749152077; x=1749756877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=98kyb7DemcX1FyfLysJO1OG3WiC0g9CHbRupke5oLhw=;
        b=Pt5nUhqsdleVlAJw04ROT7Z081zj3gCcR1mqJEk7gy8ytKGxbTwdV1H640TtIUIvmN
         V0etl4u23uevRoPHBFYmH0BWQ9IZCZMfbwHnox0oI7kP7oS3qPlX7d9V/RFZ2QksiQQr
         leUua/zx9DPuOfp2h4J2ibPNJEJDjnXeraucTzy6r5DXfuUhURohc8bdJiSEH9v/92FL
         S/i8P3C7PjUKY+7XgCaYTrChRUgh/UD9jjZ61i7gBAYDb8D9pNyihBAiqFLTB+4jwhj1
         gCftqpJzRS3Q+Ol9yAKvV7s8HCRyKmq9VxE5eU1X3VUVY7AgcCUxgRNGHCQCH0/gAoaf
         angA==
X-Forwarded-Encrypted: i=1; AJvYcCXPF17TLWZjeLkOeAiiTQCjfai5p8l0tgNfvT+Uicf/p5WMqVFE5bbonanr0QHNVNzaTm3vp3THqkTeGQiQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6/ADDFGgSldY30d/asQ+e4prH62X2Q57dcWiLHXe9UVRsXYrg
	1PqZObgNpQ64wxpD58ekAJc9/Cl1IqIeBJYr3CF18XrsdG4tRv0bQdCMPAr1P+r414aldyQupUk
	BVH9RNzI=
X-Gm-Gg: ASbGncuxYKXUGqq3vcNRKHPJgSyltu/CNUdKm52EoqSuGHDHjr6LFoTCMNQykqTsd/J
	U1Wuce7SJ3AKnC5cdZQbLmLWQLYoUTVJHmJRKpwFlMYQPYoNXm2//iQPHrQ/3PVPcNRkWhxn5za
	OrXsKSi5AC8rhk1riv7lH7766Unogu5TgK/i7Y363CByf+k1/zq+axlfg8gv8Ug418hP6rNzrWh
	SELFSYrkw9rEkuMWesFh2bX5jiFcfWxP71wYUHtlusLbzNg0XSRV36+LQtcekxxWFPPdcJCmxf6
	VaTd6OL/m3K80ffZwMYcRW/42J3vhiS8V3f93Sx2eJh3bl5WMYqOdDjt8lw0pcHm5FRHPk7TwIY
	ghxbp1G/zXuKRK768eyGTWy0ZgA==
X-Google-Smtp-Source: AGHT+IEKUXRU1GVifIetWGposW3jTncwd57qtk83Rpe0jXyvdIdHphqV/xMvyfEC67AJwxvMnerAyw==
X-Received: by 2002:a17:907:970c:b0:ad8:a935:b905 with SMTP id a640c23a62f3a-ade1a905ae2mr38633166b.22.1749152076729;
        Thu, 05 Jun 2025 12:34:36 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1db55d18sm893566b.67.2025.06.05.12.34.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 12:34:36 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60462e180e2so2562465a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 12:34:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOPjtKYqLs7xse+0rpzTVbkeOaCHtSFpdfRfRV3xVK4oZ229SZbEj65/BKf1aRBA1yd/xTGjgiyT95vKTF@vger.kernel.org
X-Received: by 2002:a05:6402:84d:b0:604:e85d:8bb4 with SMTP id
 4fb4d7f45d1cf-6077479a971mr360023a12.21.1749152075805; Thu, 05 Jun 2025
 12:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegvB3At5Mm54eDuNVspuNtkhoJwPH+HcOCWm7j-CSQ1jbw@mail.gmail.com>
In-Reply-To: <CAJfpegvB3At5Mm54eDuNVspuNtkhoJwPH+HcOCWm7j-CSQ1jbw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Jun 2025 12:34:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgH174aR4HnpmV7yVYVjS7VmSRC31md5di7_Cr_v0Afqg@mail.gmail.com>
X-Gm-Features: AX0GCFv9fwwJjQ-pdhMQFWakNA4mBQD7Vr_hXeTl3gorGhZitX74FYtkZ7ktqiE
Message-ID: <CAHk-=wgH174aR4HnpmV7yVYVjS7VmSRC31md5di7_Cr_v0Afqg@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs update for 6.16
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: overlayfs <linux-unionfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Jun 2025 at 07:51, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> - The above fix contains a cast to non-const, which is not actually
> needed.  So add the necessary helpers postfixed with _c that allow the
> cast to be removed (touches vfs files but only in trivial ways)

Grr.

I despise those "trivial ways".

In particular, I despise how this renames the backing_file_user_path()
helper to something actively *worse*.

The "_c()" makes no sense as a name. Yes, I realize that the "c"
stands for "const", but it still makes absolutely zero sense, since
everybody wants the const version.

The only user of the non-const version is the *ointernal*
implementation that is never exported to other modules, and that could
have the special name.

Although I suspect it doesn't even need it, it could just use the
backing_file(f) macro directly and that should just be moved to
internal.h, and then the 'const'ness would come from the argument as
required.

In fact, most of the _internal_ vfs users don't even want the
non-const version, ie as far as I can tell the user in
file_get_write_access() would be perfectly happy with the const
version too.

So you made the *normal* case have an odd name, and then kept the old
sane name for the case nobody else really wants to see.

If anything, the internal non-const version is the one that should be
renamed (and *not* using some crazy "_nc()" postfix nasty crud). Not
the one that gets exported and that everybody wants.

So I could fix up that last commit to not hate it, but honestly, I
don't want that broken state in the kernel in the first place.

Please do that thing properly. Not this hacky and bass-ackwards way.

             Linus

