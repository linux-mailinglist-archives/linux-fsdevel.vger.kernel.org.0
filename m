Return-Path: <linux-fsdevel+bounces-32108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E119A0ABE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 14:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58C51C25F65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6584E208D70;
	Wed, 16 Oct 2024 12:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/0xL7y8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447DC20720B;
	Wed, 16 Oct 2024 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083110; cv=none; b=ZQSZ4kJb3PgFvO64EvZ3uuVF8uxa9L9fp1iJftJuTS0cmtbZidVOqzoQ50cO6Vu1dB3f30kep3B2IDPDyHox9aq8rLaBXRTvF7C8DhIhF+jpVpnrckvSzT64oNaTCPEHbtwe6e8ZjVqVFSiSO84+occ9lZISE3aRQ0P8oEwhtaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083110; c=relaxed/simple;
	bh=MsFlfE6EEyoolbOu5ThNzvmPVhQqOx2UrWc9FkCVBwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHwTHfNmfZNyPXKLwQMJka3DUh2qTh+4rElEZ1AnhpzBWcrGpQ9Hjw3x0HMZ+Jh3Vl/eWhkeHhuK5sOmjFLKe2FsEzp3h74oWknvuHWG4Se7/gj9xGAGdvwmh3W+/TNVawqWM5u6dAoD0cqsixcTVq1zmrNk2qwnr/TqIjZRfFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/0xL7y8; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso23733351fa.2;
        Wed, 16 Oct 2024 05:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729083107; x=1729687907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsFlfE6EEyoolbOu5ThNzvmPVhQqOx2UrWc9FkCVBwM=;
        b=P/0xL7y80bG8He7ah+Ca0hof9UnGsyY8OQMiD7r8Rf+LlD9em85GSI09m/FKUtEKMt
         JI5N4lwDa1HKMuyRlu7xnlS71brA5QxRXTXVGqMgK/TgoqqnOZmqvJQ3hLSZbYI1Moer
         rPCio+Z8ZiWnvOqCk7o2jSBgjU+lW4RnNZTxOHFaJHDCQiUMBhlbG1zIu8nc59hlzg76
         8bHd5NWS83BaGy6RQoCUYcsN0PnsYLtW6XwpLYcNO6eOcBpkNu035fHxyWTrDO1WGFrk
         fCKJBAAh0Vq4YEAIwScrgqNfWRm8PuNXMBBgHI/uARSdfIUecCblcWmXbQ2Qoz0txUrN
         JQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729083107; x=1729687907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsFlfE6EEyoolbOu5ThNzvmPVhQqOx2UrWc9FkCVBwM=;
        b=o/CMvFLW5LOGvyzUP2O+L2l7M2T7Fo3qqjm3PbRmPC1xS4X87EWJn6c97RgDjEzWvi
         gMMcWvdFarjbkfhoPKcwvDf0FbMGAQKO69oRhc9ix9xYjXQ8k/uxMAaHZ4uzf2yOsW+q
         3jUBzsBBhr3iV9EC6FF3chJPQEWFLJNxuvPb5zw3TPiWIUjNFPLx0iPCfZLjY3XZgQmG
         VRnKTwtFsZmSgWUWhV7kGmUmeUcq47KbiH4rcOCDweDubN4SVsyeI/AvkkRKqsqv9G+5
         /3bYBJYsT0yqY5L6Vf+nckv5NGrrUin413icqhja7JjVLSQ5MBNRtt28XX3HSvJzz/YU
         wCTw==
X-Forwarded-Encrypted: i=1; AJvYcCWr+U+M0OqQ7Zbt1QaXzuMhNyuxCg5xhfL4/wbPg1La1eNZYoZ6jZZXzjjbNLdHrm90OzG2CT750Ca47k15@vger.kernel.org, AJvYcCWzW67nOv0zBbnoEUn7WTrbwpGXSBll6T9KGoougieincm21TVqyWHOotV6bM09WHFYMySNwTsCRQrsKrLKTg==@vger.kernel.org, AJvYcCXbCJZTKZgJmwRAchfpx6b0hLKUsF425DeAO6OASScpux0rD3jkaSJdMay9fN8L+O4uI8mwM+AM1Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDuPec4hZTyGkPdygV6K0urtNTxG+k/sYAwjA0inOKIPmUUDB8
	UvFwe91otXecGG87oVQz0NmD2GaudlrRNu4iiT3b/9S9R7FMKmtuWgsBdyDspNBB3RXY6SwovdS
	bwulNYc57LDUEfLTV+1/bQ95NZ/M=
X-Google-Smtp-Source: AGHT+IG/F+4W/xGDVo8sibF8LS49bZTWv0Q3Dz5aacy7bn21xkXE+77k963/zvvSa4ma0YgSoW4MTa9g2cEfkpkZ47M=
X-Received: by 2002:a2e:a991:0:b0:2fb:61c0:137 with SMTP id
 38308e7fff4ca-2fb61c003d1mr32074651fa.40.1729083107048; Wed, 16 Oct 2024
 05:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ-ks9mz5deGSA_GNXyqVfW5BtK0+C5d+LT9y33U2OLj7+XSOw@mail.gmail.com>
 <20241010214150.52895-2-tamird@gmail.com> <1f10bfa9-5a49-4f9b-bbbd-05c7c791684b@infradead.org>
 <ZwhYDsBczHnS7_4r@casper.infradead.org>
In-Reply-To: <ZwhYDsBczHnS7_4r@casper.infradead.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 16 Oct 2024 08:51:10 -0400
Message-ID: <CAJ-ks9mpZc703=Y1_H6FeaUrAmhKC9bKP886M5KNjw85Mwi14w@mail.gmail.com>
Subject: Re: [PATCH v4] XArray: minor documentation improvements
To: Matthew Wilcox <willy@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 6:41=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Oct 10, 2024 at 02:50:24PM -0700, Randy Dunlap wrote:
> > I'm satisfied with this change although obviously it's up to Matthew.
>
> Matthew's on holiday and will be back on Tuesday, thanks.

Hi Matthew, could you give this a look please? Thank you.

