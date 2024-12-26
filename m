Return-Path: <linux-fsdevel+bounces-38145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FD19FCD9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 21:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893381882C8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 20:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0414E18C939;
	Thu, 26 Dec 2024 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GbdCQ3fL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661FA145FE0
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 20:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735245019; cv=none; b=saWe7Hjbb20xHDZ+gnDuUJO4qHU1iq3HYvhgoPIiT3fL+H9z90UGlI93t89VtizpVS6oRAwEqkIWj7x8bPvigeeyZHEfTipm+90YVr6iE/W2Ml1kWavBu0SSTOMwJ5q9nKamzXZXDP1kofieWLdIEtMF9mzflRgtbbZEjqQsDLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735245019; c=relaxed/simple;
	bh=x3GQ20IITnIK+0VjdSMAExgtL4Fcz2/tgn4c5zvMUyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pi06pxFotAUoQCJPe4h+Q2hzEEkI+j56VeHa+qXSzuh5qbZF4mwzsYb5zX5LBiaWJzpkFXEvz8s5Lj18BNzhnKKorbJSPGsaICmiSLC4LuwG0G658/SQSlYWa7o/he6HTr6rt2k1z9sN6i5YNMDv+PoPlB0Cs6IS3GI9IJWgMMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GbdCQ3fL; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so11174455a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 12:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1735245014; x=1735849814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=76g5jbblZAFt6ue8WxziTb/lz6ErIkBiME9S1f67sp0=;
        b=GbdCQ3fL2/CkeFP6/PODjOKkh/xjAXAIl0cHqFny4FQIvm8/J2tE1Za6qmYW7nR+IY
         6Wydb+ZYRynGKGJBNwC5X9/sEvAxlXF972Hgw5RZzogNc7WloI4kxllxns9nunYMjJoW
         Dm2SkP+w9/02Y6wFXgZDzQ5xwYw6XqKlFIRXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735245014; x=1735849814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76g5jbblZAFt6ue8WxziTb/lz6ErIkBiME9S1f67sp0=;
        b=RMS9uCD/9qcnQ34Nfz91MU2LU075r1KP5noLxiw3n7G8jAEgKjhin2lqceltLG/gev
         kPzSj4hAcz7ebg0nOBo4IJS83T/dACjQAkMH/39IgyhPXvwhJPQbuG5Jm+gVljrm99em
         IGbyLNn43uxcFIvFuENkDxKumcVZEPJPqgRdp0mUrxib5Vz9S3UhKitCmiFx38+t8Whe
         pVU0qD01k45CNmpJA4zhBhN6Thy6ZYhr9alBb6o04PAWYNsWA8DoqR4YvufH+39kdOcT
         4YMUHKMLm4DiNLU2+fC6zGLsJizcuxbi/2HGrBEd97NGBRCP+EJm72il8gfCIZitpd8u
         nFrA==
X-Gm-Message-State: AOJu0YxWxj/S3KuXSj1Rj33o2JkbdETIOd2V3qFPwVqYn4sbX7wHW31p
	TVPoRZwsAyYVHErGVBYID1iit7yheP+FeJxzqWW5mZ/n0gGXokH11AF4g34cftYLlMTr4bhTwpL
	1UuFSkQ==
X-Gm-Gg: ASbGnctb4z0NcCDET03giNzyfY89NJqflxMgj7P4Zw/Jbce03L8y7Wz0/1GbTcbb9Kk
	hxW5PO3VTH1LAyONvre7AIhP7sgHmbk0s4+gRa6CwyMlQvtFZahHn7PkIALBepS8/i+OijaKsQf
	CdwUWBNGY4p9bwEIRQIshoNdv+Zh/MOPFuzn3z3vyYUiFucmR6RS2MnCKZDOV+H+SA0IlttXVuF
	4e97YIwmDpX9pMLkeF85zoW/8t1Na+Zgj5PoI9oggC/deIv89kW+smnsYVc4IGKH4Qn/4M/i8el
	s3/xb5ccHT9MjtsABBSu2EL1r8W++WE=
X-Google-Smtp-Source: AGHT+IHsJtRurcBu7fUWaDC7xOkcihm4V7grbHTw2PbDUqdOs7cq0rZSNH1qpm8Z6xw8aDLHFUvRhg==
X-Received: by 2002:a05:6402:270d:b0:5d2:7396:b0ce with SMTP id 4fb4d7f45d1cf-5d81dd84643mr20082160a12.3.1735245014525;
        Thu, 26 Dec 2024 12:30:14 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f303sm9964254a12.24.2024.12.26.12.30.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2024 12:30:13 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso1233772966b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 12:30:12 -0800 (PST)
X-Received: by 2002:a17:906:7311:b0:aab:75f1:e51f with SMTP id
 a640c23a62f3a-aac2ad84e3dmr2221671866b.18.1735245012373; Thu, 26 Dec 2024
 12:30:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <CAHk-=wj5A-fO+GnfwqGpXhFbfpS4+_8xU+dnXkSx+0AfwBYrxA@mail.gmail.com> <20241226201158.GB11118@redhat.com>
In-Reply-To: <20241226201158.GB11118@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Dec 2024 12:29:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=whRnW3e3g5PkEtH6geVVYZO2MPUH4ZV5a=khePC9evY4g@mail.gmail.com>
Message-ID: <CAHk-=whRnW3e3g5PkEtH6geVVYZO2MPUH4ZV5a=khePC9evY4g@mail.gmail.com>
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
To: Oleg Nesterov <oleg@redhat.com>, WangYuli <wangyuli@uniontech.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

[ Ugh, removed the crazy cc list with tons of old addresses ]

On Thu, 26 Dec 2024 at 12:13, Oleg Nesterov <oleg@redhat.com> wrote:
>
> I _think_ that
>
>         wait_event_whatever(WQ, CONDITION);
>
> vs
>
>         CONDITION = 1;
>         if (wq_has_sleeper(WQ))
>                 wake_up_xxx(WQ, ...);
>
> is fine.

Hmm. I guess wq_has_sleeper() does have a memory barrier, so that
worry of mine was wrong.

So the optimization may be valid (the config option definitely is
not), but I think it needs to be explained much better.

I end up being very nervous about this code because we've had bugs in
this area, exactly because people optimize this code for the unixbench
pipe benchmark.

And then very few real loads have that behavior, although there are
some cases where people really use a pipe as a kind of "token
mechanism" (ie GNU make will do that, I think a few others do too).

                Linus

