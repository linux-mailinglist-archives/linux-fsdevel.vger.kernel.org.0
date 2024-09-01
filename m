Return-Path: <linux-fsdevel+bounces-28142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77E3967466
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 05:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934C1281E6C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 03:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83682C190;
	Sun,  1 Sep 2024 03:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ACIgYOOK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6642317BA6
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Sep 2024 03:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725161151; cv=none; b=KSZMqAUCL61Hs0CMx+z1tqCKxbH5JXY8kW47ljMvm6s5CnUDLT31neL8ZnMhfsPwpjSfDWUYnZI6tn6o0WuBl6SwYdwjrF+gEgYoj7WehPF2gvc/XBG5LrskDiS4nEckPfTwuzjyVFRRxPsLt1+J4CTSacR371tMLwBo2wifNxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725161151; c=relaxed/simple;
	bh=tcx579kBQXIkUt0k10DF9rAN3Ao81wX5xr2qhmf8S40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNgYKVIWZ3mqKBi5hpu+6NcA8wFfl7lWa3EGJUmVsGs63T9rOKYQNlw4UCyBZ5MrLQPtZ/Iw8fFCZ/82awfLMmGuLFOAoU1mgxq9uAlJYVEggdea568qOZH4qL5vqbbAiq3qopnNZyoDithNjBS9uNAAM15MmT02Kt4PDCTEvag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ACIgYOOK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a866cea40c4so351959966b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Aug 2024 20:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725161147; x=1725765947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HC1nsfFJXyTdVWcxISQi1WPBRNOn9dIaZqfB6NKeE50=;
        b=ACIgYOOKxHcEjiUQ+JneiTl/a8T8++SJHdwc5uHKsS+40zSOpl5dyeQudpIif14SO0
         0vXUMtEFOWKGMpA7yQ5T7qO4TrsipEx2VLGP49tV/BNrwDe108NfrlkHf0qsqTrPNfAU
         5Cb38C0Qyxt1reRCkoOR/meIzkfEKQnm592Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725161147; x=1725765947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HC1nsfFJXyTdVWcxISQi1WPBRNOn9dIaZqfB6NKeE50=;
        b=d2iF1ntC9mB6C2OwvQEIWeOOTzCivu4+ntnDB9UjIuEQ6vNmwHu/VcgVWePrEHWDRr
         SLqJrOXodVBlQ+BLJsfiYeR4permRAvhpr0w/sIJOKB3BlmfkVZtjT6KJykK6Om6OoHy
         bJI0RgAbvV8gC+bK+IiXoJPqnJdczsp77WuyS7v4Jy2NHd/vAjlL8ezIxDnAb+0zvUNy
         0VmSI6AkKwF1NCwdn1lrzQ2+h705NYl/5U54bf7+hkOtLrb0Yfe9ImuQpYEofbRIYbNr
         4RlrVdIHVD6DI5dGSSAHcEvpZF7lVDTL2oD4kdfjZwkFkgSX0f9DCsJskcVYl+H1HLtU
         2Tew==
X-Forwarded-Encrypted: i=1; AJvYcCUOobCCwlJJjQXw1Wuq+Qph5/snsH0gvfuveOJVnLgRec6RfPUKMM3GALctk619/AimE9Vw6UmfjLBYsUV7@vger.kernel.org
X-Gm-Message-State: AOJu0YxIOI7JmUvnARDkhgEDJUGscAxLhFEYYZaUOWRQAJTvzx1NAcY8
	IAfkJFX4dwN92bQyZ4KGJVSHJC5ZEoyrIXeevEWgzVEW3vERzQRDXCHA4wOhFhbqWDOKe+XvbTe
	B2fFNzg==
X-Google-Smtp-Source: AGHT+IFaF5c+8YDBwxAxAwBImCDubJHYKWgdo44CkukBXnK98dKcGrU7MsNscV4SwVmiZ/o0IQld8A==
X-Received: by 2002:a17:907:3daa:b0:a86:a73e:7ec9 with SMTP id a640c23a62f3a-a897fa6b574mr771815666b.46.1725161147253;
        Sat, 31 Aug 2024 20:25:47 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb072sm386404966b.28.2024.08.31.20.25.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 20:25:46 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso4177449a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Aug 2024 20:25:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZNvKztCxXnIrd+MYKdq5UtUcWMcHB1Ujv7rdpZ7Yvsywq5ncTSGfJlvtUkbf4wnHGcZcAX5qVBzVL0YTu@vger.kernel.org
X-Received: by 2002:a05:6402:42c7:b0:5be:e9f8:9bbf with SMTP id
 4fb4d7f45d1cf-5c21ed406dbmr7079645a12.9.1725161146176; Sat, 31 Aug 2024
 20:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <erydumpfxcjakfllmh3y4d7wtgwz7omkg44pyvpesoisolt44v@kfa4jcpo7i73>
 <CAHk-=wjBNzWL5MmtF86ETJzwato38t+NDxeLQ3nYJ3o9y308gw@mail.gmail.com> <5q6h447wzxlskkvgygm3xb2tasbbgmmtxsxd6m4jtygpwsf47b@hxdqfn3nxqzo>
In-Reply-To: <5q6h447wzxlskkvgygm3xb2tasbbgmmtxsxd6m4jtygpwsf47b@hxdqfn3nxqzo>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 1 Sep 2024 15:25:22 +1200
X-Gmail-Original-Message-ID: <CAHk-=wjPQWyYf0Jg6KG2gUYz4HEPq5BT0N=Vx6ECOx41TGvZiA@mail.gmail.com>
Message-ID: <CAHk-=wjPQWyYf0Jg6KG2gUYz4HEPq5BT0N=Vx6ECOx41TGvZiA@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc6
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Sept 2024 at 15:19, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> odd, everything looks quiet on it, but it was acting funny earlier today
>
> I do have a github mirror though:
> https://github.com/koverstreet/bcachefs/ tags/bcachefs-2024-08-21

That works. Thanks,

                  Linus

