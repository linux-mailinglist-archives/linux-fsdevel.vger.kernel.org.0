Return-Path: <linux-fsdevel+bounces-53224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0286CAEC9C2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jun 2025 20:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C086189F7C9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jun 2025 18:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D5125C827;
	Sat, 28 Jun 2025 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2ch9IT8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFB578F2E
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Jun 2025 18:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751136049; cv=none; b=MKf9okM7ifTwy5UBOayOK764+P1BJZhZIyRMv5em60oRRYAjz1AAgCyh1/JYpPzzw3j6Q3FJz6IArZZLa+ogS+qVfNhc9FCKUL0L8Lsr+OnsYAE8P08YACm4Gnr6vSKH6p4IUAMXHLHfTa+i0Iyd5u3/gh6lnjkE+M7dF9022qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751136049; c=relaxed/simple;
	bh=8bPLiSqpt3ecobYd+jSpJimKqexiPDuuAoHGz7kkaQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2J6BmDH3K6dRyPFWaZxBty4yRinC+HlWS2HLhiGl5472e73vJ/mL4fh386CbK0PiJjD1lul/S3luc6kY63aLj3B2eJLVGkUAaFQl6tHfjf7vUKHFzGmoBlOYIcmWtX7h7Uf3a9YuBusY6K5wklm5auYD7i9N2FQpAuZ8phRDwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2ch9IT8; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so503707766b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Jun 2025 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751136045; x=1751740845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HAHwCyMr1qsN3aqyFKC8Aa2HRQhr9hnVM/Z1t1rayO8=;
        b=j2ch9IT8bQ6stlw+2WaUvhGICoK6SveuTXlsmVTrnRrBQHXQl6+0a0rGnwTK5N2J19
         cBpU59bt0UPdykOUuiS1fWSMOgAOihKmtYQ3DhHEBjYDdDbHZI8/QLhRuVuNWzim5sbW
         jSJgNgBPeoJu+I6LqDGbTv1OwGKIHpMEsKupW2gcT0PgE/v2rIg92P5sNQr53rv4oqUE
         3ZPAobY+3LHKBZl9DBMhXIARXZ3ZuFnMrLCoHDbjfw/nA/N+gLmoauve1E6HhxZnceGI
         Kn0ASaln0J2FzDvzqaZjs04y5VMW152Mj9NOZRHyECuiU0mQq4aYNWvZcCintx3Txvek
         1E3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751136045; x=1751740845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAHwCyMr1qsN3aqyFKC8Aa2HRQhr9hnVM/Z1t1rayO8=;
        b=deyOGLN3cbjP3kcPOZReR9pxnLm6TqKoflyKN00hdWHYiTxepGqtPIh2ZOzDdfpBjC
         7vgAG/6jfgxcdm0iX9gHSVqMOyKMtIu2o/TAIc2oVVFdA9i9aqDXoc7TVLmLf9UtC4uw
         oMg1OqRLUC9Qt711r/D9lNQBL1x1Z7Y9uYPCYJB23CvzoY25k17RrcYpp+Py3je3iN/1
         Bgxn0udukZ6bEUID+pw+Myp4Gp/ALNDm7itvkbKWTYom9xKuZZLwHEjegMEaXZh1J/pZ
         B5MxNB2awM2nYDdXarenfMTyTUW2hyUV/cH2zDlHFEjqYeJYqLjWRZSxsg1ZCHFDUIut
         n1pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGrJ3Lta0qCXzFsYgOe5317eILRBWoIPMsLsExdf34/sLzhx0zHTIqqXJx/NoybcP61amNPaDMlbdz6/L2@vger.kernel.org
X-Gm-Message-State: AOJu0YzY5blRiN14j4tN8JOKK0IOwzBx91I1nTobF7clrkoPkLl0Ha6o
	pR2qIaNh7dRS/bNOdslkYKZ1mjXRoRlxxwEFBdawRtI7pZZVfnMP58plBZKJ6+inA//maMJQDnR
	KuP+ieZNG6o26W8JplVyZRE+g0POOibg=
X-Gm-Gg: ASbGncveBgQ9Xzp+93RGwDILZMShjbkkJ5mQO2skaIPTlMB79JQ9BdqW/R+HP0txf5W
	g8eQqhY2tGopRl3G8EPrUnZbr8glzo2LpPYEv1ASDAXaI7qjyIIPEJ2C14t8PnzmYNJeVAszkhz
	3xQBAtyRHXPN/UVP/eknMTU9YkII8qyxO57mJCTxAisXo=
X-Google-Smtp-Source: AGHT+IEUCijGi7pegoilv/1hj7kJtEVrytI0tvnrEJmrxzMbT4X7PW+xXZc3l5+UIWnuX/8p7NSTo/qpI2W6U/9kC3U=
X-Received: by 2002:a17:907:9713:b0:ae1:a6a0:f2fe with SMTP id
 a640c23a62f3a-ae35010fc9bmr851005266b.36.1751136045106; Sat, 28 Jun 2025
 11:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxjki2j7-XrK7D_13uftAi5stfRobiMV_TZkc_LRwQCqwg@mail.gmail.com>
 <20250627060548.2542757-1-ibrahimjirdeh@meta.com> <CAOQ4uxheeLXdTLLWrixnTJcxVP+BV4ViXijbvERHPenzgDMUTA@mail.gmail.com>
In-Reply-To: <CAOQ4uxheeLXdTLLWrixnTJcxVP+BV4ViXijbvERHPenzgDMUTA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 28 Jun 2025 20:40:33 +0200
X-Gm-Features: Ac12FXxiz9dIVTpreNkNDZeuq4hIbTsECGTKtFm4sms8lpIQy4U7oK72_PM0YDw
Message-ID: <CAOQ4uxivt3h80Vzt_Udc1+uYDPr_5HU=E6SB53WXqpuqmo5zEQ@mail.gmail.com>
Subject: Re: [PATCH] fanotify: introduce unique event identifier
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"

> > Do we prefer to scope this change to adding (s32) response id and not add new
> > event id field yet.
> >
> > > Thinking out loud, if we use idr to allocate an event id, as Jan suggested,
> > > and we do want to allow it along side event->fd,
> > > then we could also overload event->pid, i.e. the meaning of
> > > FAN_ERPORT_EVENT_ID would be "event->pid is an event id",
> > > Similarly to the way that we overloaded event->pid with FAN_REPORT_TID.
> > > Users that need both event id and pid can use FAN_REPORT_PIDFD.
> > >
> >
> > At least for our usecase, having event->fd along with response id available
> > would be helpful as we do not use fid mode mentioned above.
>
> You cannot use the fid mode mentioned above because it is not yet
> supported with pre-content events :)
>
> My argument goes like this:
> 1. We are planning to add fid support for pre-content events for other
>     reasons anyway (pre-dir-content events)
> 2. For this mode, event->fd will (probably) not be reported anyway,
>     so for this mode, we will have to use a different response id
> 3. Since event->fd will not be used, it would make a lot of sense and
>     very natural to reuse the field for a response id
>
> So if we accept the limitation that writing an advanced hsm service
> that supports non-interrupted restart requires that service to use the
> new fid mode, we hit two birds with one event field ;)
>
> If we take into account that (the way I see it) an advanced hsm service
> will need to also support pre-dir-content events, then the argument makes
> even more sense.
>
> The fact that for your current use cases, you are ok with populating the
> entire directory tree in a non-lazy way, does not mean that the use case
> will not change in the future to require a lazy population of directory trees.
>
> I have another "hidden motive" with the nudge trying to push you over
> towards pre-content events in fid mode:
>
> Allowing pre-content events together with legacy events in the same
> mark/group brings up some ugly semantic issues that we did not
> see when we added the API.
>
> The flag combination FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID
> was never supported, so when we support it, we can start fresh with new rules
> like "only pre-content events are allowed in this group" and that simplifies
> some of the API questions.
>
> While I have your attention I wanted to ask, as possibly the only
> current user of pre-content events, is any of the Meta use cases
> setting any other events in the mask along with pre-content events?
>
> *if* we agree to this course I can post a patch to add support for
> FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID, temporarily
> leaving event->fd in use, so that you can later replace it with
> a response id.
>

FWIW, here is that patch:
https://github.com/amir73il/linux/commits/fan_pre_content_fid/

And here is an LTP test which demonstrates how to use this API:
https://github.com/amir73il/ltp/commits/fan_pre_content_fid/

This kernel patch does not yet eliminate event->fd, but it makes it
optional because that file can be opened by handle as the test
demonstrates.

Thanks,
Amir.

