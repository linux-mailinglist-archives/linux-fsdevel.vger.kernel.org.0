Return-Path: <linux-fsdevel+bounces-25144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C932949671
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 19:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092861F217A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 17:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D7153E24;
	Tue,  6 Aug 2024 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaLMy5ka"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2FB4D8A7
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 17:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964150; cv=none; b=YK1hFuV2C2Az7w2IHrsyJRfYHJITF6DMzGTRQq0AQzSjBqtuaGhEieCGDeFGL8j+1znwNfJq1MG7oLJXO0b6hSPMfzdNhSstUPASgM0gSpZ96V7GZr2H/1eV0Zdr6LsuH9gX1Iq0ltLUSy2ICUqugQ2XyVvk0Uo7tBFlm0P40sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964150; c=relaxed/simple;
	bh=iTv7VusLnJQG0b2DdOnzt+B5JI0SZtaI/vz+di93xLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5OlIUeZ1EhtaiHXfNmmsNI3Sk4koj3dEaa965vvIRD1Imm30XgAr9aCms6Xen0loQ7KigXz8EiXXtNBTVPX8XGWUecRcRiHVbr919cFvUmuz67Ji7xpIVTCLFMuC2WPklcvPa7HhNbUv2PerSiCNCTWDIU0FrUhDrQN63tjw7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaLMy5ka; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44ff50affc5so4401921cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 10:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722964148; x=1723568948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaEGFkNNtvdFJZqVj7vl6IXomRQ5Gahyrt6fl34HbHo=;
        b=YaLMy5kaVUDGee3gru3vRXPrL03GHe3LHkpBbeh+LMcE5zD9CcqUJKKCCYU41h278P
         wgsY214XQH++WNde1F55KEueDd8v3G+IElEpbBMIABsMjz5zgMfxeqklPtm2TdZIBg1C
         tZ6oFqQONbnfS0TAvocPKog/a+YROGC2dV/Y1pHBKn5ri1uoqvvwIFnDPtB5JLHYkIdO
         mWIe3I0h9xycGYqstBNuJ2bdFuRNY6GE24dE+XqNe4wwffZrQQkxFDNGYK+GeU/8y4zv
         F+6OZVBGPhncSu3NQ7idad68M+2LJnKfFF+y92xTMTDydbkAMvYmDG1pLU+pixoLHOyD
         /ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722964148; x=1723568948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaEGFkNNtvdFJZqVj7vl6IXomRQ5Gahyrt6fl34HbHo=;
        b=WYtRDKfbJ9vSxUOCSms3vBAIoSRNrC5O1o2u9B6ZazCov8XlSnZ+1OYwUnE3Of9sfr
         igy6ix3V8E42cPWjgYZIOAdSJoNzgpr9DCZT5v63gqaUnyR+037/CBv7T4XaZgCCttFb
         YBOdgUJpnBcwMtijhxY89pHXBKoHymomrvX5MCWt92f7pnEipNAiN7ce7+/UICvLciDS
         lgBHIR0nK29CCop1cwY1eresrK0i8y5iSjXbw9hjNtYzUO9KjqGi/9x3b2NIyabjokCN
         wK7YhDHCvK9AG+j92qjppjUUOVK8atnLUYaoUmZbNQRgZWJ1rGpCzHYF9o0P+9rcwtG8
         3b2w==
X-Forwarded-Encrypted: i=1; AJvYcCXpM8/NkXXSKV9t8+O3KwHzUk2/DT02qPHgDb3aoKqAtop9hPmN4f/pvGJH/ap2ibllqNF6tLJcBR7135m9zIWNwBGYbMfq6cRgzfqcFw==
X-Gm-Message-State: AOJu0Yzve6HJ3nU2WmRk2aj9yapvHKMcpyaWvpC25DHNw0Z9gKpuvE0M
	+K16eYwe59q2bRdLbITz8jFOlK0V2Aqbs3L5q9IVqwVMQlK7iQyb0pcBXO96Kf9CUmEhBz7y4XC
	RHy2cpbT3KEdZJ8Xw7aO3RptmmEg=
X-Google-Smtp-Source: AGHT+IHLAXJk7wc6zdqSLXMcFiX2zC8h+SvXtFpHEx8Et2oN0W1GXscqvLVlA9bIG8HsTkWBGlKXWeOaRw7Woum2EXY=
X-Received: by 2002:ac8:5f95:0:b0:451:8d59:9c29 with SMTP id
 d75a77b69052e-4518d59a9a2mr133266221cf.22.1722964147614; Tue, 06 Aug 2024
 10:09:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
 <20240730002348.3431931-2-joannelkoong@gmail.com> <CAJnrk1Yf68HbGUuDv6zwfqkarMBsaHi1DJPdA0Fg5EyXvWbtFA@mail.gmail.com>
 <fc1ed986-fcd6-4a52-aed3-f3f61f2513a7@fastmail.fm> <CAJnrk1YVC58PiU6_gJno7i439uHUkcLDzKY4mXmupybeDO7LWQ@mail.gmail.com>
 <1dd58650-0704-4974-a0d7-765aaaca53fc@fastmail.fm>
In-Reply-To: <1dd58650-0704-4974-a0d7-765aaaca53fc@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 6 Aug 2024 10:08:56 -0700
Message-ID: <CAJnrk1YX6fhhoHbW=0WDKpVfHB+52+s-cndQ5vp9y0cJBtLkoA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fuse: add optional kernel-enforced timeout for requests
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	laoar.shao@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 8:43=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 8/6/24 00:10, Joanne Koong wrote:
> > On Mon, Aug 5, 2024 at 6:26=E2=80=AFAM Bernd Schubert
> > <bernd.schubert@fastmail.fm> wrote:
> >>>> @@ -1280,6 +1389,7 @@ static ssize_t fuse_dev_do_read(struct fuse_de=
v *fud, struct file *file,
> >>>>                  if (args->opcode =3D=3D FUSE_SETXATTR)
> >>>>                          req->out.h.error =3D -E2BIG;
> >>>>                  fuse_request_end(req);
> >>>> +               fuse_put_request(req);
> >>>>                  goto restart;
> >>>
> >>> While rereading through fuse_dev_do_read, I just realized we also nee=
d
> >>> to handle the race condition for the error edge cases (here and in th=
e
> >>> "goto out_end;"), since the timeout handler could have finished
> >>> executing by the time we hit the error edge case. We need to
> >>> test_and_set_bit(FR_FINISHING) so that either the timeout_handler or
> >>> dev_do_read cleans up the request, but not both. I'll fix this for v3=
.
> >>
> >> I know it would change semantics a bit, but wouldn't it be much easier=
 /
> >> less racy if fuse_dev_do_read() would delete the timer when it takes a
> >> request from fiq->pending and add it back in (with new timeouts) befor=
e
> >> it returns the request?
> >>
> >
> > Ooo I really like this idea! I'm worried though that this might allow
> > potential scenarios where the fuse_dev_do_read gets descheduled after
> > disarming the timer and a non-trivial amount of time elapses before it
> > gets scheduled back (eg on a system where the CPU is starved), in
> > which case the fuse req_timeout value will be (somewhat of) a lie. If
> > you and others think this is likely fine though, then I'll incorporate
> > this into v3 which will make this logic a lot simpler :)
> >
>
> In my opinion we only need to worry about fuse server getting stuck. I
> think we would have a grave issue if fuse_dev_do_read() gets descheduled
> for a long time - the timer might not run either in that case. Main
> issue I see with removing/re-adding the timer - it might double the
> timeout in worst case. In my personal opinion acceptable as it reduces
> code complexity.
>

Awesome, thanks for this suggestion Bernd! I'll make this change for
v3, this will get rid of having to handle all the possible races
between dev_do_read and the timeout handler.

I'm planning to rearm the timer with its original req->timer.expires
(which was set to "jiffies +  fc->req_timeout" at the time the timer
was started the first time), so I think this will retain the original
timeout and won't add any extra time to it. And according to the timer
docs, "if @timer->expires is already in the past @timer will be queued
to expire at the next timer tick".

Thanks,
Joanne
>
> Thanks
> Bernd

