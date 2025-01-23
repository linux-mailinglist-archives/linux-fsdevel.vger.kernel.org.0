Return-Path: <linux-fsdevel+bounces-39927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CACCA1A1B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 11:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0309E188C84E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 10:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9056220D4FD;
	Thu, 23 Jan 2025 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ia+SSfkS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4354D194A74
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737627399; cv=none; b=FmUTHjksktnkXlll25qZOoPrJyXOVGdb5sfiEa8DwQMLjIbtClWD1tyz225DeWT7VfP8wegZbaNTHQoT4wAIFyvUFfFbyg5nZw1cnZ1SH8rIJGAQQiqjnY+tVzCloHi9H4NZnHL4zVzIMw7++3y+OM7nHrY/aeDauKpO6lKhA6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737627399; c=relaxed/simple;
	bh=oyiBUXpxwjadGkH/BfywnZJ42SK5qUCKgXDrhpe47d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+R3/v8eQgcGCgY+WqBsPrzoEJwnRbJTAH37PgHFaOzg5dMromyhgTUkFaTGuAH7vkMr5JTNwGzu6lH4IfC3tRrFgEkwak0tAwGX+gR1g6Yq72yZXZK+ZEp7wW3SAsaQmVyTRqxhddolmOIJbRZ7m9+ksiJ7Pk+4ZKoepAdTh+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ia+SSfkS; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b9ad0e84e6so83112385a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 02:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1737627394; x=1738232194; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fNIhMFoevwrK3tsrVxzp/SBrpbQ2kdIaXlVM8sgTWOc=;
        b=ia+SSfkSkZOjrhhBnwe2bhsTYVef4yPPzlNxbMTuKOGTXM2eOhIOUz6pC3XznPw5EI
         e11u1PjoIuoLWO3ETKqQnjQ+HbRKEG5nvOBapTLYLOWWdMxpwBi9sVa9YQd8q9Njwsld
         z/9QePPRkP5uDKe2GjKXwAKVMaZp16Q5DSA28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737627394; x=1738232194;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNIhMFoevwrK3tsrVxzp/SBrpbQ2kdIaXlVM8sgTWOc=;
        b=Gu80bsa14o6O1gJ89rHkK83mURY+hDBZELGaS44vfkjvb99N7nsLqidIOp8Igr3brF
         KfioVuq0NowAZ7UC1+4hocLLXjeCnjDFUmqc1Ig3umVzsCM/U23dRhp//3h7jkUEZaUp
         tpsJ2ylZ8ebZQaOD4e7whRxBrzY6zCMIuzBJwcfiW42YbHMnjNrecCdEUp4Eao0coNtD
         en/CkJtZmi9NEAxd4SaDHBt+nSmxBlxNiVwmNxK5TsZjfDyH0JJgG2//q2tAXRiooycz
         gJR4HHAF0VXYTzH63kh37NNYXvaxbU4D1fqMkXVDN+UU6614hfSMRPjNZdBZL65ba1Bz
         n6pA==
X-Gm-Message-State: AOJu0YxUZsnOuJYXUdIltTJ+Eq2Q65UhYEj0ImMx25bFlIa6Omr8G5xH
	pL7sZVLcQnfKKCZx6k2W1vl6MPvZmWJtDTHVx4kL9gah4DClF8sh34yKJvRRbXRtPCVJEk0lItt
	8dBhakGT0uHnnogaRYK/lj5SowiefPJ7KrOUPVcTllbQJK8isbfw=
X-Gm-Gg: ASbGncvAVPz6HGxJgKnHt3ANVcgwtn7FUHct0CAB+ZpYMiEooqeiqY/CTcWn+1MIjrC
	Q54V9PUPVQr7m/YUx8YvPmm7uy1oql+AMBy4d4P+CrrUsc+YwSYrWwDSCLQe4
X-Google-Smtp-Source: AGHT+IFpOeSgdOsTAg8qk2Xyp8BnlDFdbzPPQVcj9H3xQcRTgah8/Vc0cMMPvsIqYwGeEOxUg1B5MDY2jP8J6m+dBEI=
X-Received: by 2002:a05:622a:1314:b0:467:79b4:a103 with SMTP id
 d75a77b69052e-46e12bc61c8mr343367921cf.51.1737627393946; Thu, 23 Jan 2025
 02:16:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250119053956.GX1977892@ZenIV> <CAJfpegtxKLYe_-mkv31Ww_PD984YZyPsDuwS=46gbmEKq4-5yg@mail.gmail.com>
 <20250123020327.GB1977892@ZenIV>
In-Reply-To: <20250123020327.GB1977892@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 23 Jan 2025 11:16:23 +0100
X-Gm-Features: AbW1kvaXFT3Wr5d48yv2WGM69Plbgk2Wfl2ZmzSHgQGYv-yu0kbD_PJ50Fss8Tk
Message-ID: <CAJfpeguNxcJo1J9UMa_h=PM-fUDdeBUo0QeTUPyPxxXgHJqB-g@mail.gmail.com>
Subject: Re: [RFC] EOPENSTALE handling in path_openat()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Jan 2025 at 03:03, Al Viro <viro@zeniv.linux.org.uk> wrote:

> What's the point of re-walking the same trajectory in dcache again
> and why would it yield something different this time around?

Nfs4 skips revalidate on last component and returns EOPENSTALE from
its ->open() if it turned out to be wrong.  All components leading up
to that were revalidated and the invalid dentry dropped, so what's
really needed is just redoing the last component.

There was an optimization which tried to do this bug eventually got
removed because it was buggy (fac7d1917dfd ("fix EOPENSTALE bug in
do_last()")).   That leaves the choice of redoing the cached lookup
(which should succeed again) or starting from scratch.  I see no point
in doing the latter, although the rarity of this event probably means
that no one would ever notice the difference.

> IDGI.  We *can't* get to open callback without having already dealt
> with leaving RCU mode - any chance of having walked into the wrong
> place due to lack of locking has already been excluded when we'd
> successfully left RCU mode; otherwise we would've gotten to that
> check with error already equal to -ECHILD.

Right.  The point is to not do LOOKUP_REVALIDATE unless we really need
to.   Otherwise EOPENSTALE would just be equivalent to ESTALE.

Thanks,
Miklos



>
> What sequence of events do you have in mind?

