Return-Path: <linux-fsdevel+bounces-24217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C4793BAD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 04:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0367CB22667
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 02:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B7811CA9;
	Thu, 25 Jul 2024 02:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0jwu6Xu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F221103;
	Thu, 25 Jul 2024 02:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721874669; cv=none; b=Q9gO8V9ZYAwpvXg6wZiCA9o7HrpkCLMTR3gi9ghBMx1WukGXR2orBjpFZ/UZVR7MGPwAZe9+Oi/losGf0jzMRGODWS+j+dbj6L8sksdrou2Rdjt5jpXd1wafoJqWMPz+hYAyjTPRVcX3qMZ7tz3aZq92L1FyKachWOvyGr7jSJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721874669; c=relaxed/simple;
	bh=rHYP/JZ0qZvQC5t0SD4oF84A3HWmyGiBcpwoL0QLn5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBtb/Ryec2kpF3oZJFKjkjovc4Ztmm7jVAIoJcPkqNPV1fiGC+Pg6IsBa9JNtnLbypXTQv8z9rYERH7VVw4xgvXCI5fzR6LEWHVngSJWHrv1zSAtMEVcCebBDCK3f+Qe03Qbn/NKYebZrtEqnUTCn4DJxN4t2QNI8BIZLCOuY7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0jwu6Xu; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a22f09d976so2667967a12.1;
        Wed, 24 Jul 2024 19:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721874663; x=1722479463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8h8nTzUAl1WcARF1hup8Fyq1znnGzBKQRxAU25hgOQ=;
        b=g0jwu6Xuz5/dt2G82sRNt0XLY7gFsh1nMZ8Xr1rFA35ccPexUdpZmilMuZvXtLHWni
         z9lJVH9exZZj8tMFF2sGtOMKd97r6MQCaI4PtVz80Es6bZWHoezwW611ImtP3zX7Uoh8
         +U2cFyjTRuCq+5dOL2f7p8xC6jNlHmheinEkIs8WdL9lDAiF4F7jzBcBDc93ARSNZVGo
         ycJsRxgb4DOvW7TOIuOiA553EeKzHBj02iFOGD03xFMo+ntEF+xCfsfF5ugjUPnVeH1o
         FcYBgFPifuQfluB7lEPXHf8lY02nqoJ6lXmBatAkd7ivxCdwMqTZ6t+UyBJaJdbTUjlS
         b1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721874663; x=1722479463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8h8nTzUAl1WcARF1hup8Fyq1znnGzBKQRxAU25hgOQ=;
        b=d8Z2FziZzV1csjKIC1MrkpVNA8koox3Nh20a/U0mtIeA4RbvnEh6Oru/pt8YQZaP9/
         Ug2A3Zlof6O1ZTtn0niXTe+4BmmseJVCWwfx3StxRIGXP3eKtJITw1C0AjDsnOw3sa6v
         m/Afpc+JWbjluCvGUntMPAH2n0e4jp0uF8S1b0vGzNaOOj9/bgZy9Ruk/m+LVEVDg+RC
         FFz9fu51Kw4iPRTboFMToMtKeB+gJGgyp3+2yMm5p7AUR3SAFtunoIoclmEUxSBCalJF
         +w2JRNhLM4+L4lL5DoYgQdZYpOZzUKwtoSHcqci32ujNB8ZcsNWaiiATaYd0PxfuXtw5
         42NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgD51lhsauLQvpQk3ozlRcedcQB6uiqOViZnOVWSWXq1hKRSq71tONdoyEqan5b3n6ZAMQ2OsnVHESf6UDoMejS2cKyXttHY+4pGmESsCVDoAvQNjJMkF5XgcUSZJa+9qRbzZ5LAZNxl0X8w==
X-Gm-Message-State: AOJu0YyaHv/yiHZndPjMkAyTwoBFmSCVEF4XfIEHc1frSnER66znf6i3
	f4il+p4QOuGgb+qNLIQCZljusVVor6W3aO40tr4L6fNb2gnyF6t8YIp7z9dImR8gW+e7ZXTZeGx
	s+VkL1HbJgwCXtbBpAs/8vKi6otw=
X-Google-Smtp-Source: AGHT+IGdGx4ySUzJGl9EnTZK8v8wPNb/wvPcHHbBXF7mKGm9VIRFhtNhDoDoxxMpcTzBRbKe6/wPyWylfhzTadLKR+4=
X-Received: by 2002:a05:6402:50cf:b0:58c:b2b8:31b2 with SMTP id
 4fb4d7f45d1cf-5ac148aa56dmr1404524a12.17.1721874662401; Wed, 24 Jul 2024
 19:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723091154.52458-1-sunjunchao2870@gmail.com> <20240723150931.42f206f9cd86bc391b48c790@linux-foundation.org>
In-Reply-To: <20240723150931.42f206f9cd86bc391b48c790@linux-foundation.org>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Wed, 24 Jul 2024 22:30:49 -0400
Message-ID: <CAHB1NagAwSpPzLOa6s9PMPPdJL5dpLUuq=W3t4CWkfLyzgGJxA@mail.gmail.com>
Subject: Re: [PATCH] scripts: add macro_checker script to check unused
 parameters in macros
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, masahiroy@kernel.org, n.schier@avm.de, 
	ojeda@kernel.org, djwong@kernel.org, kvalo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I noticed that you have already merged this patch into the
mm-nonmm-unstable branch. If I want to continue refining this script,
should I send a new v2 version or make modifications based on the
current version?

Andrew Morton <akpm@linux-foundation.org> =E4=BA=8E2024=E5=B9=B47=E6=9C=882=
3=E6=97=A5=E5=91=A8=E4=BA=8C 18:09=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 23 Jul 2024 05:11:54 -0400 Julian Sun <sunjunchao2870@gmail.com> =
wrote:
>
> > Hi,
> >
> > Recently, I saw a patch[1] on the ext4 mailing list regarding
> > the correction of a macro definition error. Jan mentioned
> > that "The bug in the macro is a really nasty trap...".
> > Because existing compilers are unable to detect
> > unused parameters in macro definitions. This inspired me
> > to write a script to check for unused parameters in
> > macro definitions and to run it.
>
> Seems a useful contribution thanks.  And a nice changelog!
>
> >  scripts/macro_checker.py | 101 +++++++++++++++++++++++++++++++++++++++
>
> Makes me wonder who will run this, and why.  Perhaps a few people will
> run ls and wonder "hey, what's that".  But many people who might have
> been interested in running this simply won't know about it.
>
> "make help | grep check" shows we have a few ad-hoc integrations but I
> wonder if we would benefit from a top-level `make static-checks'
> target?


Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

