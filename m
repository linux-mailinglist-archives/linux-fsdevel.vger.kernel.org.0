Return-Path: <linux-fsdevel+bounces-36102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4124C9DBB99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 17:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B04284205
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 16:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FE91BFE10;
	Thu, 28 Nov 2024 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2HnhepJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019EA1917F1
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732813036; cv=none; b=hQYuwEIjY+5q4/pHgy/E1D3PPKAgV/Jo7TcTq1ZVkmjoLCwOhQgVnTAdmW73Yg6Je4Fp8jZJqV6qSZlZBEO6/4b1kwNcEHUi0Lo1u3acqFOHGV66L9TXtGjMldvpQWaEQU/J7kVVkXU25/B8flwCSUKEjulazat/fxpCUIqDTSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732813036; c=relaxed/simple;
	bh=3kObXSvqOEgnrKyu4I6UUSQxfI1JM+qosi4DvERku0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCZhS6m/10jlUtX9texSnuL/wyNsZFkFuSDUq0XbQ8rLZttuopTAGbIbEOJvqX0c0L7W3Yo0q7iPg8Vm4OgxPSvU8mnNNwu17Xh0ulDk8gf7wTaXJZDtOl/5x37ItKGyir1iwt87R8uu1lvAGMJOiCiN5cMrYY5FkuB2VT3EK/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2HnhepJ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so11437871fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 08:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732813033; x=1733417833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9AYjFbGiNbuPPvCM5aAexVUmpxvaVBdp/l6EFo3zmQ=;
        b=I2HnhepJ+BGB6Rv4iuaFYjKhxrW9BnMhdIppUP67V3S8xn/jirHqa4T47pDF1WU1NI
         zpE2ETDrq9BCkFlLyMtB78wtuAlSgd+vT+kSTr4UY0/6P2Up/61cTj/WJtzctvBPjDL/
         ypfnesCAX57cLFXiBdan5K3Mh7GDx9+PLR+Z2hFtN9LAixH90M/fUVWZQlaow90jHWgc
         MR4zkNCWwb1Wp1/SdU4HYFpHXaOFBFl9Jtqw1GPZdnoDwjbzRyk3qv+9VbwW/mFqcn6S
         Db+IlCUiQmGe8MRCh6gFjPZrKMmNapEu8m+dOnf3FvhYxG6P/ZzOQPd1qDGXccVURjBk
         ZeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732813033; x=1733417833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9AYjFbGiNbuPPvCM5aAexVUmpxvaVBdp/l6EFo3zmQ=;
        b=OiIA3orrQXLO70ySzcRHQI2HRQYiRB57puh986yySPu2cGz3mUCUiJbBtm/8dKDJh1
         ZY/X7bg+E+t43SIcxNqDUBHEoH45Z/rFuytQsWhITPzSIuF4lZrzzLxC8iuI7gYoc2y/
         UDv+4U762DIr7R6yGKE2xKA0TbizpHxlgiVFW7RMiYKgHRkm+YgMsnY+TKPj3dhAI+yV
         pU6/pG8zwRVADw7BpSdH0xR+G7Qs1Qvv/oGIxjMkO8MP7dz9hnP3Tm3PCjpGxD/xiDer
         dW0qgQnpULLQeD1UXxeiMb5TrhY1iUNL0OBy47VuDB+RUNnQ/h8CGWbfxpgc3kwKdQL/
         sKPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI3lUikj+lZj8crgkWf8HGsmYfgn2at14pSN2qu9+FIQrNeNNNOnrJ4HL8zElV2GHrT+rYrKAKidZwTg/o@vger.kernel.org
X-Gm-Message-State: AOJu0YwspnjiAk9DlqJgClm6tt8TotW3X5vfETy2i7KtrrStVSRMZJwP
	rLXXbgRlT7VCsVuxJb/moOdsYbx2I/WhNrf2ybXNjodpqhBBACsLrGJIKt13TzLyF+sk4mZijYb
	REf7AEjvv+IPcFrfUmrPAe2NErUs=
X-Gm-Gg: ASbGncucOEyqq1NcYtSlcLsV1gerE/3+pHap3uKTOPfNLNolqFPyBAX2uyf+wqigg4I
	eMyANYrsjpa/0nxp790QUj2Xj9G0nhMo=
X-Google-Smtp-Source: AGHT+IGvYsW+KYZzLQB4NgNrdClqkS+IxCDED9hLrptUonPdKbcFbd6K9Tbk9kUWYoOO8IwPv5MZD24KzcMtc50kQ/Q=
X-Received: by 2002:a05:6512:124e:b0:53d:e4d2:bb3 with SMTP id
 2adb3069b0e04-53df0114870mr5004380e87.50.1732813032617; Thu, 28 Nov 2024
 08:57:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128142532.465176-1-amir73il@gmail.com> <wqjr5f4oic4cljs2j53vogzwgz2myk456xynocvnkcpvrlpzaq@clrc4e6qg3ad>
In-Reply-To: <wqjr5f4oic4cljs2j53vogzwgz2myk456xynocvnkcpvrlpzaq@clrc4e6qg3ad>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 28 Nov 2024 17:57:01 +0100
Message-ID: <CAOQ4uxiqbSFGBoCzg44t4DM=uvJ3zbev_wbSot4i5C8jQW_t7Q@mail.gmail.com>
Subject: Re: [PATCH] fs: don't block write during exec on pre-content watched files
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 3:34=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Thu, Nov 28, 2024 at 03:25:32PM +0100, Amir Goldstein wrote:
> > Commit 2a010c412853 ("fs: don't block i_writecount during exec") remove=
d
> > the legacy behavior of getting ETXTBSY on attempt to open and executabl=
e
> > file for write while it is being executed.
> >
> > This commit was reverted because an application that depends on this
> > legacy behavior was broken by the change.
> >
> > We need to allow HSM writing into executable files while executed to
> > fill their content on-the-fly.
> >
> > To that end, disable the ETXTBSY legacy behavior for files that are
> > watched by pre-content events.
> >
> > This change is not expected to cause regressions with existing systems
> > which do not have any pre-content event listeners.
> >
> > +
> > +/*
> > + * Do not prevent write to executable file when watched by pre-content=
 events.
> > + */
> > +static inline int exe_file_deny_write_access(struct file *exe_file)
> > +{
> > +     if (unlikely(FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
> > +             return 0;
> > +     return deny_write_access(exe_file);
> > +}
> > +static inline void exe_file_allow_write_access(struct file *exe_file)
> > +{
> > +     if (unlikely(FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
> > +             return;
> > +     allow_write_access(exe_file);
> > +}
> > +
>
> so this depends on FMODE_FSNOTIFY_HSM showing up on the file before any
> of the above calls and staying there for its lifetime -- does that hold?

Yes!

>
> I think it would be less error prone down the road to maintain the
> counters, except not return the error if HSM is on.

Cannot.
The "deny write counter" and "writers counter" are implemented on the
same counter, so open cannot get_write_access() if we maintain the
negative deny counters from exec.

Also, note that there are still calls to {allow,deny}_write_access() that
are not bypassed even with HSM, so for example, mixing fsverity and
HSM is probably not a good idea...

Thanks,
Amir.

