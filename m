Return-Path: <linux-fsdevel+bounces-26144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CCE955057
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 19:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1650B287891
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 17:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4731C37B7;
	Fri, 16 Aug 2024 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XQD3/Ufi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258D81BE22D
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830953; cv=none; b=Nae70bYykQJnanrtEV9gjfGRHj6vxBov6QU4PT97f6Xh8z3OjSiLlgiaqTANt+MFktJ343AMeIcvgTmJGp8zNE824euFtEdrxxMlIBFrWICmBdHedwblnfYsd5X0nwRCwGGxe8WJccSSOZCzSyhohTtHH06/Lr77HVZ1uu6bjeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830953; c=relaxed/simple;
	bh=AWTKE4rGnr7kEezD/HwaTefRMpxDaj9O3tUOgq9aXQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RN15Y86o0gNdwqDR9EOirqy/0vsn1nkhoCYyJPDg1jSIwX7MKm39WNILjwbjTsQ36+ECJW3jmD67H321w9ZnISbUuOaCyO7aI6O1P85kFybH1HOPDOALVGZFKyA5CJtAvwVoYHRERiA+USOvSJshEfv/G9wQo+rNetAhmKlM5V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XQD3/Ufi; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f0dfdc9e16so26102781fa.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 10:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723830949; x=1724435749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JsRgxkokO1/8xV4hNS+4Va4SrJsyUDUb9cmLcxFUkm0=;
        b=XQD3/UfifaErKl5aYCYk2YyTGvuBzctEcFyoOe2Odlfyb+Pag+wwrONiuLVOOP2PQU
         cZ8TKhDuOp+Lk/T5D7z1MR9o7JLaSjmXLxGpX0veHxfb+TCOCOOgRhoIii3tzxXjAiOh
         Buns4uxkX8QV9+FX9ueKlCYkajICr9lY6i/08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723830949; x=1724435749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JsRgxkokO1/8xV4hNS+4Va4SrJsyUDUb9cmLcxFUkm0=;
        b=G1TNF7sZcp90gk9IjVM/KtrwIPOAZLvR2vXB7C/UTwhSbPDM+XtmR5NBcF9DwTMAKq
         X9ujBjuwslZSbyarBmRN9jJ76Xw8h8MMw1dYtSkG/+wVjcrVxaJCZ0X2rPPfeVpeB9ge
         MFVB9xV34b36uYRUU+ESJN4AY0J6hfKnVciePj3lzaIHrviobrSzikXjdIGuUa2pcckH
         kbJHFpaADzO888ogBLRstZdTjOcIdgaMWeLKemKbSr7MjCjdQtrX02PhAPE+Wwa8WMvJ
         Mp+Ka46noZx1HwafME6Dd/4iWPsuvNpWLzzDQX7Zrh6hDX44DfBbW6sE6YvHd78djDRa
         Rktg==
X-Gm-Message-State: AOJu0Yy4CekdoMwvAJ5avk4DxWjyXwrYzBZp//CZ8jSuWnMS+/qhzPj8
	oRrpNKdjdCrdRkTq7dRPo+ICYgSimifHatDiPhZpTs5d8VEGw36bnY62sF2neMgFIPULWFMzR1U
	fa+A=
X-Google-Smtp-Source: AGHT+IH1lBtQD5kEn7rMsAji7ot3TnfBHmReg5n84mFlh40ZO2mq1YhuAnTTm5cgd+CoE/CkfTJU9A==
X-Received: by 2002:a05:651c:1545:b0:2f0:1e0a:4696 with SMTP id 38308e7fff4ca-2f3c8eb1607mr2222621fa.7.1723830948456;
        Fri, 16 Aug 2024 10:55:48 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f3b774af9asm6291211fa.134.2024.08.16.10.55.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 10:55:47 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52efd8807aaso3073752e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 10:55:47 -0700 (PDT)
X-Received: by 2002:a05:6512:1289:b0:52e:fefe:49c9 with SMTP id
 2adb3069b0e04-5332df51660mr174463e87.36.1723830947291; Fri, 16 Aug 2024
 10:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816030341.GW13701@ZenIV> <CAHk-=wh_K+qj=gmTjiUqr8R3x9Tco31FSBZ5qkikKN02bL4y7A@mail.gmail.com>
 <20240816171925.GB504335@ZenIV>
In-Reply-To: <20240816171925.GB504335@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Aug 2024 10:55:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh7NJnJeKroRhZsSRxWGM4uYTgONWX7Ad8V9suO=t777w@mail.gmail.com>
Message-ID: <CAHk-=wh7NJnJeKroRhZsSRxWGM4uYTgONWX7Ad8V9suO=t777w@mail.gmail.com>
Subject: Re: [RFC] more close_range() fun
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Aug 2024 at 10:19, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> All it takes, and IMO it's simpler that way.

Hey, if it' simpler and gives more natural semantics, I obviously
won't argue against it.

That said, I do hate your "punch_hole" argument. At least make it a
'struct' with start/end, not a random int pointer, ok?

Oh, and can we please make 'dup_fd()' return an error pointer instead
of having that other int pointer argument for the error code?

I wonder why it was done that way - it goes back to 2006 and commit
a016f3389c06 ("unshare system call -v5: unshare files"), it's not like
it's some ancient interface that predates that model.

                Linus

