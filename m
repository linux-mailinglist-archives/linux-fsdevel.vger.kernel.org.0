Return-Path: <linux-fsdevel+bounces-63088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28850BABA8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 08:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E5B192524B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 06:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D0C284B2F;
	Tue, 30 Sep 2025 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bhefpngH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09F42581
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 06:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759213484; cv=none; b=aCzZeFODrzfoTVKS4t/KkyIazb6DrsUU4JAc2AmXnliqoeyFDbSF27vke5giEU49L5g70mO/w857s1yRemdp+lhBSHakC/YrQ2Vnp4A2VpTz4LHRUivN4A4lKkbSxIP9gTbw8ue5qrSaWMSu8m1LdUdS049UZpQWiekq4/DIiHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759213484; c=relaxed/simple;
	bh=gKpmOq7vTkV3GS2wp11XTlgszn61/lcw9HGnb+2GRJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOYrrK4APtIMs1l6hc7sajlbltSvMzqCvlqqsjUe+0LpUISFoDemepwNW/gj7VsoldLKAK7EJFLnGL8FgszjCE7yg3EUILDoXrCEAxjnbqw8UCQTIY7V1IT9S2afI1pZy6+GAPUFrCwsuUumAdBHirPHjfgvTFDn0P2ZwaT74QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bhefpngH; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d5fb5e34cso76158267b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 23:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759213482; x=1759818282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3T7bvWF1MMkR4cjUbls4qMw34SN3zPaa/y8HZGsbsl4=;
        b=bhefpngHqQUj78wdErISEDOaCr1XHTMfvftMCK/gRbIFjixPEW+sRUAIk94lY2CZMv
         HAzmMWbDCNdruiz9WYxtULjy1fHG5WYEgjT7CwQ6lArW5heeI7b4OOLWJ2BCysFRxpaq
         XXa2vM3OYc01aOzyUxFWOH7Pc++KkluxrCEP6dnyeeBLT1n+zm3nrTS0Gy60WBCrNncT
         xomGfacyaKxgdRV5jdyCwCAJfvHIfUbPuOmMN5alIscJGHFc1f05UDXxD31HgxjygmxY
         o6dcydnR46eNlLPHLtg2FvMCePN5vF9oO6UG/hX8KmmqryaLcM64rHufO0jbgGREhQHU
         dWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759213482; x=1759818282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3T7bvWF1MMkR4cjUbls4qMw34SN3zPaa/y8HZGsbsl4=;
        b=eKCCKilT7WyYj1vHkw8FnZjY9b1cpnrzqYJPzW9EtRkH8hCCblsDv4lLkI9tEQYHe8
         Cmpf1g2CkUQN3MOQTvjY5q598JjDSXWXbL5SQocefCh0zvBp1qDAERkCaWtSBGdd5jCS
         XZhxO1shTnd+Gv7llYSMX8aFyPJ5shg0eFSujEfCuWJcvKx6ToY/xyNdjla/auVMWdev
         ZhMUBTfC0T8wsyEjgs0CVAyTrPx1T19NUjlI62SwOdd7rmqNmHwmdL4qZLg3TtTyTcnW
         baqRccn24ryy2mHaVlsLogzr1foiC77qtYKBO5dJ3NzZGmwFfvUx46gmSfxJyOxWLJKK
         XsJg==
X-Gm-Message-State: AOJu0Yyfy3XBK95AABkOMbeEA0OzJIMpT7rgvE+ux/4uc9qXzKgT+ev7
	MGYdiX8XBJcPMlW3fBnyaZcFqxv8lC8rmB5KG2iL8E5gayAIcucTlt5ek0elEpNJ9D65M7oSW1E
	jtFFj+qm7+lprVmAjFcLN8aEIkO+3dTAu5i0EJ9N/Lw==
X-Gm-Gg: ASbGncsrsVF/1TkRmue023GiLGCMjQ0FpE6DiPwSijI44H5/5KlTQk401+pG93XRVbO
	sNuZVmkhPgvHIT2upNDYxEhbnpVU0a7m+H+7TJ89FpZnwti9XlelTwR36Nszzjj9mu/VtDVIKu6
	4ab/or3wTlzTwXsg90Cvati04s/6cXcuGfVT7X/jyDSXNxHBsYe3mxsMfz5PHquj1jiz5DCLhMc
	7ZIzcAkrD2+sMvpKZJwdbWGsZGtczBwvqUEiOXPiJE+Qf0+BfHXMJ60mBPtSHzpyEHbSKlA
X-Google-Smtp-Source: AGHT+IE7m7INFUE9QvrSVE5DoS870xV9RrYEkgoanY6yrpEQRZGsLzxu09HsavWG0Q8d/HeT757nV4uUKbTzqd064ak=
X-Received: by 2002:a05:690e:cf:b0:635:4637:116b with SMTP id
 956f58d0204a3-63b59836d7emr2752555d50.9.1759213481665; Mon, 29 Sep 2025
 23:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929122850.586278-1-sunjunchao@bytedance.com>
 <20250929122850.586278-2-sunjunchao@bytedance.com> <ehjjehcopkhidopj676n5hl2etdsl6lxdhgzhsz2f3rgfaxtwd@cqgb6xry3jho>
In-Reply-To: <ehjjehcopkhidopj676n5hl2etdsl6lxdhgzhsz2f3rgfaxtwd@cqgb6xry3jho>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Tue, 30 Sep 2025 14:24:30 +0800
X-Gm-Features: AS18NWC1ktwwAgzcx5746C1bgTIDgRsOJSqFj_-YZYYYogapjHFUD0OlWFOXIAo
Message-ID: <CAHSKhtf3F2CCU088EgAzrK_mg5GPgpuRuait6fwS-yHsx=hwng@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 2/2] writeback: Add logging for slow
 writeback (exceeds sysctl_hung_task_timeout_secs)
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	mjguzik@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 11:51=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 29-09-25 20:28:50, Julian Sun wrote:
> > When a writeback work lasts for sysctl_hung_task_timeout_secs, we want
> > to identify that it's slow-this helps us pinpoint potential issues.
> >
> > Additionally, recording the starting jiffies is useful when debugging a
> > crashed vmcore.
> >
> > Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
>
> So this works but I'd rather do:
>
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 61785a9d6669..131d0d11672b 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -213,6 +213,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
> >   */
> >  void wb_wait_for_completion(struct wb_completion *done)
> >  {
> > +     done->wait_stamp =3D jiffies;
> >       atomic_dec(&done->cnt);         /* put down the initial count */
> >       wait_event(*done->waitq,
> >                  ({ done->progress_stamp =3D jiffies; !atomic_read(&don=
e->cnt); }));
>
> static bool wb_wait_for_completion_cb(struct wb_completion *done,
>                                       unsigned long wait_start)
> {
>         done->progress_stamp =3D jiffies;
>         if ((jiffies - wait_start) / HZ > sysctl_hung_task_timeout_secs)
>                 pr_info(dump here kind of hang check warning);
>
>         return !atomic_read(&done->cnt);
> }
>
> void wb_wait_for_completion(struct wb_completion *done)
> {
>         unsigned long wait_start =3D jiffies;
>
>         atomic_dec(&done->cnt);         /* put down the initial count */
>         wait_event(*done->waitq, wb_wait_for_completion_cb(done, wait_sta=
rt));
> }
>
> This way we can properly dump info about blocked task which is IMO more
> interesting than info about BDI.

Indeed, this makes more sense. Thank you for your suggestion.
>
>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR



--=20
Julian Sun <sunjunchao@bytedance.com>

