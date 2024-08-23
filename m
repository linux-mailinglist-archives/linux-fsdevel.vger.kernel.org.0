Return-Path: <linux-fsdevel+bounces-26867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCDA95C3CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 05:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 456EAB23512
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 03:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616C9381DF;
	Fri, 23 Aug 2024 03:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dGJi1/wQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41D526AF6
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 03:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724384662; cv=none; b=Ya/61cBZD1IItrUq+fxD+wEEY9ogIlBs0bsd7nE04BbkIzalGf272eEVGEvFePjcZAq5DmzS9SisAyR6NhOy5vCO7+LbHXQw/HOlly/isTD5gI1uIL3ReIDaI9U7y4cu6LRp2oHaSl+wLSgzkEQGQ5Rfh8cwRt380omQtB1r2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724384662; c=relaxed/simple;
	bh=K7XUBvIcffkDENv0k3JUCNCc7LPF+KMwVcee3iFantw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nr86btvUxn+KNcufGrfelG32rplV0FKZe1n5Xiy22WO8/Vk67JfM9cOvnj6xtITSuXwt4p1CMeCrwaU7pXpkIDu/AWkrG4EfFyzHqylnIjxr87He5Dyr3rNGe/KnHYXFecHlQI/J+ti3bIRVyp/xV8DoD1lq8yjzoJ4hjwg5nYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dGJi1/wQ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f406034874so14225171fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 20:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724384658; x=1724989458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4pW6m8K+8rrPrJlQ1KXmNt0s9lfIMD1mZ59Ud+lBb9I=;
        b=dGJi1/wQliXn693KNZRhjwWiF7loH9SRweJQpLqLq0vAXsJLXBnPSlJR4QFD1UazRR
         XI3UtFeBAvMjJiX+QXNj2NaIek+foKly2h6e3l0H/ltSFmdvmXEEjXGqEmfM+yPyYyJA
         fT0q1MtPDqaFfq2a0WbCA9gOcJ3hMtnYO0HDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724384658; x=1724989458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pW6m8K+8rrPrJlQ1KXmNt0s9lfIMD1mZ59Ud+lBb9I=;
        b=L7lstShD93zFHx4mCqAy+24K7OrcOpjt3XVfW08vYKUyvws45NFGDxuwhblsroIG9T
         52g2kNRz6ykjq+estjd/xQpcbKJ88Ygr06gMuZt6H6jcneuoj09jqR+BGIUA410CJueq
         zAsSJ/HnWH9C3A0owNriajmPTP5+kV3r0AKjEUJ238+yYdZNsq/69eXgcONw/VXKhFdq
         uCH0QVHfzMW6mfs2jvLykH6+4WuVdljcACuWjZyIpxNC4uPisPMIXicW8QY7nRV5y59H
         YfbmROgdTJvcOdk3acPwi0vlOy9kMlfFmckp91o/DawKLy3m4fPTn2hCQn8RaD1db67K
         ZbkA==
X-Forwarded-Encrypted: i=1; AJvYcCXBFMdDpZtoJ0e2mh5NmD8oEbJyURCNaqK3+gxWH1WKcQqsb0LMr1BJ2Lv7ro+1c9GCeG+g0ObgJ9gVy0cb@vger.kernel.org
X-Gm-Message-State: AOJu0YwStpDCDK8pS3R4xVLk6Grprx2LpM8QuMNYZyi3dCw3X6dQLA93
	eptm4b+V9nwncEpBA8x2YeESsotFNO84oAqkGF3AotKjQylKaNF3rSYRt8nEKEeTjSS3zHR984B
	Ylwwvig==
X-Google-Smtp-Source: AGHT+IEr8hgE0DpOqYeAvVUfqRCnf2z6mtTE9vyEo4kqxRkDG1FDr16rMslKRtLo3FwAgi9Fc4Vxvg==
X-Received: by 2002:a2e:d11:0:b0:2f0:1f06:2b43 with SMTP id 38308e7fff4ca-2f4f49425aemr4411971fa.41.1724384658020;
        Thu, 22 Aug 2024 20:44:18 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f40484a8d4sm3727691fa.95.2024.08.22.20.44.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 20:44:17 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f3cb747fafso16572341fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 20:44:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXhFjidaV83TAkU4iLlJCz1MVooQNiV3tdbA6//AlbGbIL6HvlCSa+ikX8nL1jPKKxLD3GXmPlSVNW69UgY@vger.kernel.org
X-Received: by 2002:a2e:bc18:0:b0:2ef:1784:a20 with SMTP id
 38308e7fff4ca-2f4f4938683mr5722151fa.38.1724384656962; Thu, 22 Aug 2024
 20:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822-knipsen-bebildert-b6f94efcb429@brauner>
 <172437209004.6062.17184722714391055041@noble.neil.brown.name>
 <CAHk-=wjTYN4tr9cjc2ROA1AJP5LzMh6OoNAz8pVSUMP0Kd7AFA@mail.gmail.com> <CAHk-=wjwOFTLviM2zB9M-BtsK7spLP9XYZ=bAL_Pospi--QyPg@mail.gmail.com>
In-Reply-To: <CAHk-=wjwOFTLviM2zB9M-BtsK7spLP9XYZ=bAL_Pospi--QyPg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Aug 2024 11:44:00 +0800
X-Gmail-Original-Message-ID: <CAHk-=wg6P6ANhbSynbzrzRxkZCj46TQjKAfAfhf0+PDp3atrkw@mail.gmail.com>
Message-ID: <CAHk-=wg6P6ANhbSynbzrzRxkZCj46TQjKAfAfhf0+PDp3atrkw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/6] fs: add i_state helpers
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Aug 2024 at 11:05, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Looking around, we do seem to have a pattern of
>
>    smp_store_release() -> wake_up_var()
>
> instead of a memory barrier. I don't think that actually works.

Hmm. It might not work for the wakeup race, but it might be a good
idea to do the store_release anyway, just for the actual user (ie then
the *use* of the variable may start with a "smp_load_acquire()", and
the release->acquire semantics means that everything that was done
before the release is visible after the acquire.

Of course, the smp_mb() will force that ordering too, but for a true
concurrent user that doesn't actually need waking up, it might see the
newly stores var value before the smp_mb() happens on the generating
side.

End result: those code paths may want *both* the smp_store_release()
and the smp_mb(), because they are ordering different accesses.

Just goes to show that this whole thing is more complicated than just
"wait for a value".

                Linus

