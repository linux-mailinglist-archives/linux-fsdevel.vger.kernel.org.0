Return-Path: <linux-fsdevel+bounces-29092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3681975177
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 14:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2FFA1C22AB6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 12:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DA9187553;
	Wed, 11 Sep 2024 12:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blkznUX+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4460018733C
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056545; cv=none; b=hEaRRm1W0kYRSOHThu0/1etuxba4h9OG0HPCf1KoVfMEbU4u0+NFl0pRxoReavPvhIIdZkhLMcYyUEidBAb8PvDaykX9VsFmgsQ+Go0okUoKZldnvLLk2LVTzDQ1fqFOPByDln2aw67ePSn6e2bHfqaC048l5UhlXZknQO0Rzus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056545; c=relaxed/simple;
	bh=tSzsgUvT72TTn/sTBSrT0UapSwQIdvqp/6Px+0zZVYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FL2dvUB/dbgTzXdq8LAVEaAYllkIjvSdXkkoaOKzujTPSCHYlhCmCZbkLoiCtbv2ZH+XRT9qqvy6yZQFrX96RKB4x3XtO5QaGZotxHFfNkahnKll+hWPqL9+3i/YlneExO2OpWfB6ZvaC9F1jSsKtZ2dhKIXyscdTQgoIzT0fQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blkznUX+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d87a1f0791so4273534a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 05:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726056543; x=1726661343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSzsgUvT72TTn/sTBSrT0UapSwQIdvqp/6Px+0zZVYE=;
        b=blkznUX+gADl1MPPrPB5vVYZTgbeFYN8BOzPYCkUOxaNDYdZY9kQSi0x/747iZlbDU
         xD3OdZZN0VD1xtNTmQwXVm0Ikc4kzCfCML5+mPLGSL6ZoccmiAJNtZhUHBuORFTtVm1n
         met1+SRGWADHB7F7aHb55tPAIxcGx/x3fHtynqNyOikuWwC9F8TWdw3KCqamYeZf9IuJ
         xF80IVT4mYJsYxDOFhj04soJXMCEI7iOctWmKj1vDlSnqH34oArXt20laj8erVRaLfIy
         ksRblHVvPzE2NR1AhRA8OTfnDgjaX6upcDdakqnCpPiaf+tUtiifnyZ15B0PtS2+/3G+
         9YPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726056543; x=1726661343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSzsgUvT72TTn/sTBSrT0UapSwQIdvqp/6Px+0zZVYE=;
        b=R0SLh4sJ+PKP5H4JyzMEW9rKrO/De+fZ+JFJcjqJwdg2SM2Bg0i8o8GQQ5oIBqNOhH
         RyN1yW8r9rnVeGHqF/5+9D99aULIT9xVxgEl5bS5Q2PlxKFjJo0kEyOxSekHw6999bek
         u0gnN5RlSiPzbWjuQ6jwCInCTXRr1buCt7sGhIzkuURBPKDtG+9x1BeuL6bQIkepH78r
         zmTThqNB+kWF5MgYB9NYEAKB3fFpVPJbVGep6ZqBDPVYzfy/guQFQ4xKxQqpxandBFje
         rQBWT5V74zYTMQoj+jrW1DTtuAid6KD4R80IfpdVJeCHM8nR/O2VruhANKTI6R7whgpy
         2qzA==
X-Forwarded-Encrypted: i=1; AJvYcCUt68uvYNyYl8W8BRLcowv1fCbZAuhtvtXqwQIJeMVsbZog2AucV1gY12y8V4nfXvAqneZk45szioMM570/@vger.kernel.org
X-Gm-Message-State: AOJu0YxRw+69PDx5cKJm7dp5LxChNEObwFTTW6lyrgdG2zW8RLSU1oUA
	wVqgp+nfw5MK51OuKVdBVhCTd7zZ+ByRS1ZzGQXl9HQ+gVounrmGZLBq7gDNCEFLbPERAKz3dCF
	h7/uX2urZl4T/g2miQlnDSDLhP7zhNg==
X-Google-Smtp-Source: AGHT+IHWZYFiXIbczniCH3KEAgn0U9aKAW5olzFXxUoTOXMsR0uYhX5PhmEH+7FQkIe11IlUXo4+LcfPuyY+WH3n+5g=
X-Received: by 2002:a17:90b:314b:b0:2d8:8d61:8a50 with SMTP id
 98e67ed59e1d1-2dad50f129dmr17436717a91.32.1726056543238; Wed, 11 Sep 2024
 05:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7bqrAkZtUcY=Q6ZSeh_bKo+jyQ=oNfuzKCJpRT=5s-Yqg@mail.gmail.com>
 <5012b62c-79f3-4ec4-af19-ace3f9b340e7@fastmail.fm> <CAOw_e7Yd7shq3oup-s3PVVQMyHE7rqFF8JNftnCU5Fyp8S5pYQ@mail.gmail.com>
 <CAJnrk1YxUqmV4uMJbokrsOajhtwuuXHRpB1T9r4DY-zoU7JZmQ@mail.gmail.com>
 <CAOw_e7YSyq8C+_Qu_dkxS2k4qEECcySGdmAtqPcyTXBtaeiQ7w@mail.gmail.com>
 <0a122714-8835-4658-b364-10f4709456e7@fastmail.fm> <CAOw_e7YvF5GVhR1Ozkw18w+kbe6s+Wf8EVCocEbVNh03b23THg@mail.gmail.com>
 <be572f0c-e992-4f3f-8da0-03e0e2fa3b1e@fastmail.fm>
In-Reply-To: <be572f0c-e992-4f3f-8da0-03e0e2fa3b1e@fastmail.fm>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Wed, 11 Sep 2024 14:08:51 +0200
Message-ID: <CAOw_e7aDMOF7orJ5eaPzNyOH8EmzJCB42GojfZmcSnhg_z2sng@mail.gmail.com>
Subject: Re: Interrupt on readdirplus?
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 12:31=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
> Ok, it was a bit hard to extract that information. Basically kernel
> behavior doesn't match your expectations and causes overhead. As I wrote
> in the evening, I think the behavior comes from static bool filldir64()
> (or other filldir functions) in fs.readdir.c. Oh, I just notice I had
> posted the wrong line, correct one should be here
>
> https://elixir.bootlin.com/linux/v6.10.9/source/fs/readdir.c#L350

Ah, I was already wondering, as I couldn't understand why your
previous code link was relevant.

> As you can see, that is fs/readdir.c - not fuse alone. And I guess it is
> right to stop on a pending signal. For me a but surprising that the
> first entry is still accepted and only then the signal is checked.

Do you know how old this behavior is? It would be great to not have to
write the kludge on my side, but if it has been out there for a long
time, I can't pretend the problem doesn't exist once it is fixed, as
it will still crop up if folks run things on older kernels. The
runtime for Go has been issuing SIGURG for preempted goroutines since
~2020.

> One option would be to ignore that signal in userspace before readdir
> and to reset after that?

I am not sure what change you are suggesting here. Can you clarify?

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen

