Return-Path: <linux-fsdevel+bounces-16954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B19068A56C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 17:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5591C20F33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 15:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BC07E576;
	Mon, 15 Apr 2024 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J4q/wv/L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4943C78C8A
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196294; cv=none; b=tdGodiUFfGut7Zhs1uIdptKEVE14tR0UduTj8SfYLRfG+ra11EUFrxRoo4ybARBboc9kKqy+7T6xq454oqnGMWU/Xeb7s9FTMqpLZ7j6UOwwJZvzumnefwXY7QlfOxmMJAkTNZO/UkWKwrIXucWT06t7L7eaEN36NexflaaljAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196294; c=relaxed/simple;
	bh=09xE/LFlf8yGYO0Vt3dT8wJS2zUG1ebrtZmNDTnLH1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzyfR45+OVUPhCyuGj4AZpY6dg4pP0HkO7UheZdfI2Yfo9m0v3tQQRBnljk2HIl9f3rxekQdEmngc6MOaD8jpet79xLR1r0RF5e4TmkyISCDYi0P2VtdOBfgkcpAF4iJEzdhMp0qpPjkqMYStiiw03kpqbMRmmKVNxRCjHPylYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J4q/wv/L; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso3311041e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 08:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713196291; x=1713801091; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SUbBz+0Pa/+6Pdxji7ckXlL4204e0k2uOmCa11XX1Xk=;
        b=J4q/wv/LydA/JLf15o9eqZFU9bJZpQG1fSkPEAH228hCVlNyJhbIe9uCBzhyO+n9o4
         qCsZWx+u/f5GvFYtkb9fqtwQbS5Vs0u34poTsFiLwsoOuMl3FiSPae8B2dfb8ovTsXev
         AymyNhk+WJFQawpUJmtT+3OfcEfNCO0Z26oqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713196291; x=1713801091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SUbBz+0Pa/+6Pdxji7ckXlL4204e0k2uOmCa11XX1Xk=;
        b=vr238Tw73KCStwsmmyx0pKPzuCT+l5wGi6f6eS4aUdOZOR4EjkdqPZvtbX0oOhjY7o
         6xI6wLy/QjC7n65VTDN9qgIyu7hXSSSLxJ67T4KBQsrKkA8e+W2jhIyeAYgwW6MEjPLr
         ZCwx+VNB2fy4FAvSMsLg6DfhWaZ7uzcuKxTfN6qmXPqSa5eGbXYI1+yQMPuhUqlIMiu0
         u4+RTKt1rj8CFK7fOHJaHOFldESZfGIxRmtvrD1c5y+ZPWrhLgRqp7j2t4Y2hmHHyZNg
         JcTtdoXDXAK1qCLkSH0NuXdn4I59V5GVI+7NX07r8aPQs5mxJWutokXFlKA9WLjHnNAm
         C31g==
X-Forwarded-Encrypted: i=1; AJvYcCXveG1ZgnUkuTGidkZLG04VuiFAsN+DMgPDGpS2mNSDNtQQ+Ne2M+D163gXrDvvDxlJoYa6GXfhEU66SWtbhTbCl7zxV911jF/zfLgEaw==
X-Gm-Message-State: AOJu0YwZoWY+N2O1l6UEA4RMDyvRooTu4PgizlN73SRa8VVdg6X+zzrZ
	4Hdgo4xQiXkG+MQuhULPhCn5sqYSunAJEphNVRljRBMXY1cxmw1J3SQ1q9AkxjS+VOXfnkGvgB7
	NuazNVg==
X-Google-Smtp-Source: AGHT+IH7PeC6gfcCrcbmEiMqD376bnZv+Tg2tG1/SJBTHyYov/fd7DgDrarw2OrAGrJ5Gj9B5KHnug==
X-Received: by 2002:ac2:4888:0:b0:518:d376:3c6 with SMTP id x8-20020ac24888000000b00518d37603c6mr2884156lfc.45.1713196291250;
        Mon, 15 Apr 2024 08:51:31 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id m6-20020ac24ac6000000b00517737b4d5dsm1289490lfp.151.2024.04.15.08.51.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 08:51:30 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso3310949e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 08:51:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXo10SJxCHaicHQxv24/KOKwOCl3jreTbHxIEc98fJqIFqMQta8oIvpdeSWhOWzL4BBAbf23YP9tMOGZX5HIXOE0qOSSkeowFaCSCTqUg==
X-Received: by 2002:a05:6512:110d:b0:518:b409:ba09 with SMTP id
 l13-20020a056512110d00b00518b409ba09mr5784322lfg.19.1713196289845; Mon, 15
 Apr 2024 08:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZgFN8LMYPZzp6vLy@hovoldconsulting.com> <20240325-shrimps-ballverlust-dc44fa157138@brauner>
 <a417b52b-d1c0-4b7d-9d8f-f1b2cd5145f6@leemhuis.info> <b0fa3c40-443b-4b89-99e9-678cbb89a67e@paragon-software.com>
 <Zhz5S3TA-Nd_8LY8@hovoldconsulting.com> <Zhz_axTjkJ6Aqeys@hovoldconsulting.com>
 <8FE8DF1E-C216-4A56-A16E-450D2AED7F5E@tuxera.com> <Zh0SicjFHCkMaOc0@hovoldconsulting.com>
 <20240415-warzen-rundgang-ce78bedb5f19@brauner> <CAHk-=whPTEYv3F9tgvJf-OakOxyGw2jzRVD0BMkXmC5ANPj0YA@mail.gmail.com>
 <Zh1MCw7Q0VIKrrMi@hovoldconsulting.com>
In-Reply-To: <Zh1MCw7Q0VIKrrMi@hovoldconsulting.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 Apr 2024 08:51:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whN3V4Jzy+Mv8UZGTJ5VEk_ihCS8tu3VskW-HCfBg6r=g@mail.gmail.com>
Message-ID: <CAHk-=whN3V4Jzy+Mv8UZGTJ5VEk_ihCS8tu3VskW-HCfBg6r=g@mail.gmail.com>
Subject: Re: [PATCH 2/2] ntfs3: remove warning
To: Johan Hovold <johan@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Anton Altaparmakov <anton@tuxera.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	"ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>, 
	Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, 
	"linux-ntfs-dev@lists.sourceforge.net" <linux-ntfs-dev@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Apr 2024 at 08:47, Johan Hovold <johan@kernel.org> wrote:
>
> I think the "ntfs" alias must always be mounted read-only because you
> can currently have an fstab entry which does not specify "ro" and this
> mount would suddenly become writeable when updating to 6.9 (possibly by
> a non-privileged user, etc).

Well, it would be fairly easy to do particularly if we just do it for
the old legacy case.

Of course, even the legacy case had that CONFIG_NTFS_RW option, so
people who depended on _that_ would want to be able to remount...

               Linus

