Return-Path: <linux-fsdevel+bounces-34573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D23ED9C6603
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 01:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B283EB28CFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 00:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6A6F9E4;
	Wed, 13 Nov 2024 00:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WVp4cncE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F0B23AB
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 00:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457431; cv=none; b=WfOFpvEqRLLFK94suXai6QaBuULdx6+v3flza+mPXIlJUX6CXV8QYYaiyV0lcEge5oQa0xKFQArUsgaMle3Vr6pJ+KaNVNR9gPh2fnHHa5J5Wa/D/NdDofej5P3a0MF3b1qhUaxvd0H27pg9araGOFxiMJeIpLNCYNGLh5t7LDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457431; c=relaxed/simple;
	bh=3EvWd7pwnGEo7dSfx/lB6lTVU0t1HY+pMEl3MV/3ACE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dT1VHsuMuT1QfqTkqZMsoUJTFqm7g5HgMLffiuOd1kAoV+gpjhwViNSNwxmaEVrQntFJHTp+Zt1DCqaPG6hccGeDP8ET7TZFUQzDaOCMCMn2F4lU41TQ6jkV6qpD601wqbqqFnpN+4Mf5dbag8Rjm4KF0yYTN4JYfV1kHqQQcyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WVp4cncE; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ceb75f9631so7721245a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 16:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731457428; x=1732062228; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WupZbUO57pzsyzLIiF16uH4yNUQCRicfvRdbxH31iT8=;
        b=WVp4cncE1JjYTY3RFs0ZXvzwBSBqsIuKlxRwgNo33U/lNyBVZwg4cc/Hth3l+j0LPC
         bzXFqOHs6fYQ9Tcak5U1lVygLrpL4oc0J89F4zF3MoIFfLpK+myPYHikaYbqan+COEPS
         azb90zGQADpW9pgPv42MixN5pjx3Hb2avKq5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731457428; x=1732062228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WupZbUO57pzsyzLIiF16uH4yNUQCRicfvRdbxH31iT8=;
        b=YKEi9jRa6aARoJuPRo5ggzl8dMA7pb8V+3B/+Ll6pXMH1nygmPlAQapq4RMNKQVbUf
         RAsx+ZV1WzalwQ1uylyCpqcaxBJK7mhU07ALm0EiGSD/SLga4mPOys+Sqesr8adTmuaM
         lQC9hmnle5Td7x+GMkLwFmylNjzzUvoXwG6B4e8vpvAtr89Zfh5Ul2p5Psg08m+E9Gfm
         QLv+MTOyqbYM+iqox9SwqmRjpiRQfIKKmP+V1kSqJdsFJ+H0Yig49B7aJjHjvsG5maFn
         PNJ4bvpa3FpLezaCqCxSGcXF30kkYAYtc1xwRk/rmJ7RcyoQ+CSJHFjvlvGS4lCHnjQW
         Kk/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaWFV+6uioCcbChEt+e4c+2mt8l7nkWOCteSU7N9oSsERGnlJPqKb1fj7ydsyns+UeH+Iu8QNXaaMK7qaO@vger.kernel.org
X-Gm-Message-State: AOJu0YyJYJ0vaVqTt57PgmAGQz1yNqdEMPCKo30nbJnBXmwwneCep0vH
	mCd0aONZqJqHpsxWTBJQX2LRZkHFS3HqxlrpAhqlflx44ks6MY8M7F00zZreQQfMYjOw9OTDmyN
	BBktTyg==
X-Google-Smtp-Source: AGHT+IGN3s7ESbR4VKTsnt2Ge1sQ4cLbVgUVbcnqCp71TMdSHRXRjIP7WQZKRXbAWp53WIvg009aeA==
X-Received: by 2002:a05:6402:1ed4:b0:5cf:4455:77ed with SMTP id 4fb4d7f45d1cf-5cf44557803mr6182503a12.12.1731457427829;
        Tue, 12 Nov 2024 16:23:47 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4ecd5sm6541476a12.59.2024.11.12.16.23.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 16:23:46 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso1063501966b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 16:23:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2h1GBJVtyv3beY+qBZEVqD4reBhy5y3Ae8bkO2yvFVJAUyA+jmV27g9SGaaU0DLvmTB3yymvE8pUaH71H@vger.kernel.org
X-Received: by 2002:a17:907:94c4:b0:a9e:8522:1bd8 with SMTP id
 a640c23a62f3a-a9eefebd13bmr1910160166b.6.1731457424914; Tue, 12 Nov 2024
 16:23:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
 <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com> <20241113001251.GF3387508@ZenIV>
In-Reply-To: <20241113001251.GF3387508@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 16:23:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg02AubUBZ5DxLra7b5w2+hxawdipPqEHemg=Lf8b1TDA@mail.gmail.com>
Message-ID: <CAHk-=wg02AubUBZ5DxLra7b5w2+hxawdipPqEHemg=Lf8b1TDA@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 16:12, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Ugh...  Actually, I would rather mask that on fcntl side (and possibly
> moved FMODE_RANDOM/FMODE_NOREUSE over there as well).

Yeah, that's probably cleaner. I was thinking the bitfield would be a
simpler solution, but we already mask writes to specific bits on the
fcntl side for other reasons *anyway*, so we might as well mask reads
too, and just not expose any kernel-internal bits to user space.

> Would make for simpler rules for locking - ->f_mode would be never
> changed past open, ->f_flags would have all changes under ->f_lock.

Yeah, sounds sane.

That said, just looking at which bits are used in f_flags is a major
PITA. About half the definitions use octal, with the other half using
hex. Lovely.

So I'd rather not touch that mess until we have to.

                Linus

