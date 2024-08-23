Return-Path: <linux-fsdevel+bounces-26864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB49095C36C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 04:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178541C20C04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 02:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F06D20B33;
	Fri, 23 Aug 2024 02:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rd8TW0Sd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF06117C66
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 02:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724381590; cv=none; b=bZmywOhGyPlcPtdNikG4Q5YQqVRpWM/mTmFzAJv2gBZe0pD1ujMV/VMcqk44aDdScqbHP9moIzwYhriBjS6uStD6RiWVLZRC6jJKj75NB1mh5GyGE6SPG/3QVlMmsxstNtbv/MeZgXlOk3sjHmi/IdFrH1kFMsDVqh+Nvlh4sGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724381590; c=relaxed/simple;
	bh=7PRkr6VvPFYyLoCXiGAEOnb+Y78pc/uxRrFjOz6Mw9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jR4xe3RSeeG25QpWTQ03qnRYkb04NHM5ss3qoSo7xIazwhItDxSsUzVQ2v6u7tCbGlMkjI9SmyK0gMM2S9rdjwrtKHQzlM2wMJTMk8qcMfQsY1DBAcubdvE5XnnV7sHYWaESemILvT3KMY+eSij6L7kC8YXGCPiXDnBAeC3t/YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rd8TW0Sd; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-533521cd1c3so1665382e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 19:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724381586; x=1724986386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kF1+47TlUU/uK1fjiDCNYBGiVa//PsIDCiNE7w2PM7s=;
        b=Rd8TW0Sdgm92YqbypEECv5E/ycs9XGMqv0R/okhmCjSZN+CHqt7lMv3CmAw8Tq+KWL
         hhwznRacc/HS5UO1DVUndR6mnkcRr/Co4ieTgovIV8kwfDPSKfL7p+aV40C4b2iI2MxD
         Ln+HFKJ+/EpSjZ7QidTgs4AelUbA7mg5fXvw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724381586; x=1724986386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kF1+47TlUU/uK1fjiDCNYBGiVa//PsIDCiNE7w2PM7s=;
        b=N9SSyAgzDPmvxGZRH9mxJ5NHuOlNk6/f3Jb6DqgTi56D++YDtEIXhocEi4ov/Wyu/g
         TeicmyZlGszZHLVww8fAaQlORphymPa0exyyoRKekvfM4l2Ke+cEbGVYlibRYip3Xo2O
         NotmmYQPLiOg4P1mU19yBWNkp/UgToDfEFYyCvONikxYLm5FSheNWv860bPxsJBq8d1W
         uslu266CNY9E2/PNAQCos/orbZfTyC0JJOKN8bVf+LmGQeimRKRUJ3keNUW5tzA75q+5
         8A936OLZEthfhoQzgNJv1ud0ofeg8BWpvkbgF5GCmPmOkPfvzI4eMmm975K7YiiAxKWb
         k/ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCURrmaQi0XPvc0E7p4ZFWuSKOUok5wOOsP4giKuUUwvV+CuAYCrb7JBq+bygAKlmDXRWBqJvBOvat+Si8k7@vger.kernel.org
X-Gm-Message-State: AOJu0YyXn7zD2TSp2SK/iBRUwIpCZhWBeD1zMqBSdlrB38RGHVg06KfV
	IO4Nz/ovNXsp8+kAAb3tdFzdkEoTmEP7XLtiiZBsn0SANzLYk2Oa4+dPbyg3Um0rDIaOiGkczQO
	DVWZ+qA==
X-Google-Smtp-Source: AGHT+IGL84vN2iXy6BSd+Wusqc+0vEiKPeUuw6fOx6vye61IN2ewk58Sb6MAXl/JqDAKmU8TixzNqg==
X-Received: by 2002:a05:6512:1596:b0:52c:deb9:904b with SMTP id 2adb3069b0e04-5343887e17bmr707018e87.38.1724381586070;
        Thu, 22 Aug 2024 19:53:06 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f826dsm190833466b.223.2024.08.22.19.53.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 19:53:05 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a83856c6f51so105187666b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 19:53:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAqXKEns7OHmXf+n+fVnTfl7cIITAOtQ/cham81qwdFWq87MSK7k7CZKca+XUJqYByamSLwdXjJkIoCRgx@vger.kernel.org
X-Received: by 2002:a05:6402:2811:b0:5bf:13df:1580 with SMTP id
 4fb4d7f45d1cf-5c0891756d9mr528887a12.18.1724381584716; Thu, 22 Aug 2024
 19:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822-knipsen-bebildert-b6f94efcb429@brauner> <172437209004.6062.17184722714391055041@noble.neil.brown.name>
In-Reply-To: <172437209004.6062.17184722714391055041@noble.neil.brown.name>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Aug 2024 10:52:48 +0800
X-Gmail-Original-Message-ID: <CAHk-=wjTYN4tr9cjc2ROA1AJP5LzMh6OoNAz8pVSUMP0Kd7AFA@mail.gmail.com>
Message-ID: <CAHk-=wjTYN4tr9cjc2ROA1AJP5LzMh6OoNAz8pVSUMP0Kd7AFA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/6] fs: add i_state helpers
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Aug 2024 at 08:14, NeilBrown <neilb@suse.de> wrote:
>
> Maybe inode_wake_up_bit() should not have a barrier and the various
> callers should add whichever barrier is appropriate.  That is the model
> that Linus prefers for wake_up_bit() and for consistency it should apply
> to inode_wake_up_bit() too.

I think that for the wake_up_bit() cases in particular, it's fairly
easy to add whatever "clear_and_wakeup()" helpers. After all, there's
only so much you can do to one bit, and I think merging the "act" with
the "wakeup" into one routine is not only going to help fix the memory
ordering problem, I think it's going to result in more readable code
even aside from any memory ordering issues.

The wake_up_var() infrastructure that the inode code uses is a bit
more involved. Not only can the variable be anything at all (so the
operations you can do on it are obviously largely unbounded), but the
inode hack in particular then uses one thing for the actual variable,
and another thing for the address that is used to match up waits and
wakeups.

So I suspect the inode code will have to do its thing explcitly with
the low-level helpers and deal with the memory ordering issues on its
own, adding the smp_mb() manually.

                  Linus

