Return-Path: <linux-fsdevel+bounces-17416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F2D8AD1EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 18:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD3E282BB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 16:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9157152165;
	Mon, 22 Apr 2024 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WSWPtTaj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61271E520
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Apr 2024 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803518; cv=none; b=MQvYCo1Z/1atwKeaxBrbSw6msTW9kJWwxnTkD1Es37aAlWdDPMLnijrmopCjLa+njaZ1klFKld/RmeMppF+RVmTXt3E4bElHlOpM23Xda+bSU/5N4Flz7okJLiVgeA0CyXDnlqDsUI9NeDCVnFNbXkE/HdFJYuiO1S7qdlx0VAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803518; c=relaxed/simple;
	bh=+TaqdCEjgZxSTyKsejhTTHIW8R6Lq3G+0wjBonZ0Klg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8kid4E8XjpwaNhrwTPm0YI2HgWsOcHBNXAmShp/t50tJ7GZRdsfmA/cqFhP1xbpm/3UrHC4FjvwTiaO6EeWr7n5DxiVVMDUOhxNlydkGBA3nHPWq3bonrF3JLuvuXhMwfp9Ut+gMFT5KEDRW5D8HmV6RrWhdU8EQLanOxhDvyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WSWPtTaj; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-69b6d36b71cso21693056d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Apr 2024 09:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713803516; x=1714408316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpNxvF9YaOAaBGXSdu/sPdghPX7QEhR2xbCvRx+SLLQ=;
        b=WSWPtTaj11PvpVpv+Y0VYdIMi1YyV6AAWGdgp1uPdPWDUhMjLju6O/4DRhZ7wPAg7I
         JFuCjQhhzDBpE4jEsRh9B4j8ohjyBVJiV2v70+EC9NxlAGH2gshJMDFj00FSTj+qxwCB
         mclKKzWZeHfjXZFu5QBBr/IECFwAQliR4nzDJMrA7BtFpgUKkKmJbIqdFA0BMmT+xslH
         jR5s+70vpmdKmhDbcc83Gi1PrrO/gap4Y8EQ/H+KZ05Mg0agTkc59KFoKmSfDvR+dv2S
         8+lLf1yTbrshHMVsfJbsZN7AgVArbJwKM4nIOszzys/Puu3+I0Lk6C81F7q4EahbutrK
         4gwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713803516; x=1714408316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpNxvF9YaOAaBGXSdu/sPdghPX7QEhR2xbCvRx+SLLQ=;
        b=EDhK7CZ9ZgO+WR4zPTFaSVZG6Wwj8M+/k6uvStR+zUUoo2LDHonCEWOLGebEv+H3XL
         57JomhU+A7hXDdESa3zouv5qjUyW5CdH2jDYgoBUweKOCVWMk15/50LVtxYNfY7WbGIj
         GVhxknr7vdlzYtihC36ErNqvEZZlQQ5NbjKJOTkaDkFLPA4amsgotqmKcvzep5uzxhlJ
         KQBhS9JCOQ0plAdM6KWF3YO36OQy4RXwMeaxzmJcYl018cQZ/CHgh01fZcK1T1vTrsxI
         fDwzlpPuOcDeUPOFmX/5/abpvK8+Bk5BhwQd2xF8f5d2YOJpFqzvWZ7K5pDp14gMKjxp
         tMxA==
X-Forwarded-Encrypted: i=1; AJvYcCXPbn2lEnoj2zpv6C2EfqGbdHqfSnEnoy/MCCL4d8WTETn826WH4rs0QZs5EJLgM6F/IAGJ4d5F8A+fhs7PgVBQoql9OXkc92pkvv0eWg==
X-Gm-Message-State: AOJu0Yx2KVmgtJxfm2vTnbFLks7ZyxpzN35zYxUgDXnwSlRTdg7a9zjZ
	AICrnIZ0Lnups0oQc87mxjpN5mYtbW+7IIKuIutjqHh+vu6m0QUPOw3FdjQRam8p6+ItOr1KLsF
	OcoSJHdgOvX5raGyjKxj6Y6sli4woQ5aTMDbf
X-Google-Smtp-Source: AGHT+IFnJOkEklXHQvKFZWs/xYZscnLoS3JOz6nX6Or789idWhJIUZ/20YX+D4TEwqAJMsA6gMAQ27Ha+D/wSSVvbYg=
X-Received: by 2002:ad4:5a4e:0:b0:69b:3a49:106f with SMTP id
 ej14-20020ad45a4e000000b0069b3a49106fmr9367033qvb.15.1713803515798; Mon, 22
 Apr 2024 09:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328205822.1007338-1-richardfung@google.com>
 <20240416001639.359059-1-richardfung@google.com> <20240419170511.GB1131@sol.localdomain>
In-Reply-To: <20240419170511.GB1131@sol.localdomain>
From: Richard Fung <richardfung@google.com>
Date: Mon, 22 Apr 2024 09:31:17 -0700
Message-ID: <CAGndiTNW=AAy8p6520Q2dDoGJbstN5LAvvbO9ELHHtqGbQZAzQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Add initial support for fs-verity
To: Eric Biggers <ebiggers@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, ynaffit@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 10:05=E2=80=AFAM Eric Biggers <ebiggers@kernel.org>=
 wrote:
> It's a bit awkward that the ioctl number is checked twice, though.  Maybe=
 rename
> the new function to fuse_setup_special_ioctl() and call it unconditionall=
y?
>
> - Eric

I'm happy to change it but the benefit of the current iteration is
that it's much more obvious to someone unfamiliar with the code that
code path is only used for fs-verity. Admittedly, I may be
overindexing on the importance of that as someone who's trying to
learn the codebase myself.

Let me know if you still prefer I change it

