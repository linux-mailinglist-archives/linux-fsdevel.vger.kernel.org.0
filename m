Return-Path: <linux-fsdevel+bounces-23414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21FB92C0D5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 18:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F363F1C238C7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7DE185637;
	Tue,  9 Jul 2024 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ArsdhXo7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D21185602
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542290; cv=none; b=GTUWSyIOw+qGHTAr5JozLzIxwAihAHNNtu11FXQDu8ZV/VwEPxzFEwejWMUdqWw54GnnaYuuO+5JgcHYic+AJZHAXbwS4jCuDvL0v9dkY27MKJ7jyyTPCPaR5+7ovXn4dGhQejbpNhQxDjMqObmHJIwqE3XMiS54dK52re7A51k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542290; c=relaxed/simple;
	bh=GQWEaiUiwKONAlIFbIU4AqVczL/Fs+cS33mEhUh4nww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlNb5BJCm6/bjKCg+1RCqSDynmxzMjR4efw4qE6qzSzmb5KDerJGnPXrN/tRaaszPOP7eM8p8vMN0LFvQjwd5Hnqz2biZ0j/RVSr7iE5YK2h2XXG47ZcNbNzMMvv+W4DEYQge+m0888mpa72vvyJzgGDUHYnwjcyzbRI74lZbyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ArsdhXo7; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77c9d3e593so472975166b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jul 2024 09:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720542285; x=1721147085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8dI++N7oMKnriEvMop9NM+PwKTIvjTbwj0rulahrYm0=;
        b=ArsdhXo7B/MMDfzSd3XmJo9nuwURQSylhqXUdQrc8uIwVk4PyOIN6cNIDFbWLAn0aL
         bdKFFexIWjQVIWNueN0y7WPVEL3LR1/RiMko67vmXjYgloFTil2uXmvKuXlAsb9d62Av
         P2Cs+12Qa9tZ/kX8F6TqIjbKQeCP8B+MZ4jTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720542285; x=1721147085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8dI++N7oMKnriEvMop9NM+PwKTIvjTbwj0rulahrYm0=;
        b=Njj+qlKlHF/hxvkVRTI7D088HfZWF4pYf5wvtZCT04BisaJ8SxICMWeOFAg7IQIToj
         16ffULthBbt6v6DOhrD40l1J350c2UKg1czQ4nJ89PukSgYEiqB4v31RskoZtw+qzDn6
         /s28VtwMO+6HhdFSeyhElrLHKJ2PAS+2RiJpTrH66ov97kGMPlJqt7SUviz8mVhYaZok
         1UBdBGo6TUh9rxpvCctpkrEF1V68IQd+o+YNvAne3myLmrrwDSbEC3BD9dYKpe1IAt1b
         hzuaer+IbEr4j92vYRtxVCL1ZfrSmNtvnjKy0ltyc7z2HWERGpohXW+ZB2n2nubZWxqo
         Ygkw==
X-Forwarded-Encrypted: i=1; AJvYcCWDWD8w+4Yc4M6dpEwrYZH/EiIyMMkkdyOGNBdpMJRinGo7GGHwwwsiakwePqJ3IAkyntDX4cCnYTJr+7rSh8EmAi23Us9cTRewsZu4Lw==
X-Gm-Message-State: AOJu0YyYAVCgwGnuyDmkWt3iKGd+wxBPT2uFhvWhy6kbCQ5MmHXr8o9b
	rKBPWmlPtvmkyucwYpjSV8sUAggpXUxud32qsEY9zUSu9dEPCFabAUs43Gfgb3T+bujwleqaEHq
	hsGc=
X-Google-Smtp-Source: AGHT+IF2/7AJ2O3smb/dfL+PehsD5ZCc4J+INa4nOfkDl0q2iJIvpxgbT7UGZlSYWc/SGEByA+a4XQ==
X-Received: by 2002:a17:906:278b:b0:a77:d52c:c431 with SMTP id a640c23a62f3a-a780b6b1789mr191523566b.22.1720542285165;
        Tue, 09 Jul 2024 09:24:45 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a853a62sm87627166b.157.2024.07.09.09.24.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 09:24:44 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58b966b41fbso6781783a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jul 2024 09:24:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnEj12hSvQm7qEl9JM2Pp/FePlL76brvWCKKSzg07KRzbAM8eJhI6qKhDkoOI5J22iljS9+RP194DZaNWkUi6S/wY65dKmg/rua+7PPg==
X-Received: by 2002:a50:ee12:0:b0:57c:4875:10a9 with SMTP id
 4fb4d7f45d1cf-594bb674a54mr1638342a12.24.1720542284159; Tue, 09 Jul 2024
 09:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>
 <Zo0LECcBUElkHPGs@J2N7QTR9R3> <CAHk-=wgAKfXySpKFcJUdv97Rqz7RxPF-uc6xsue6Oiy=tP65oA@mail.gmail.com>
In-Reply-To: <CAHk-=wgAKfXySpKFcJUdv97Rqz7RxPF-uc6xsue6Oiy=tP65oA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Jul 2024 09:24:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKCppvYcjHRivLbw2uPELEuEdythi_bkK9P7oF0wJ4Yw@mail.gmail.com>
Message-ID: <CAHk-=wiKCppvYcjHRivLbw2uPELEuEdythi_bkK9P7oF0wJ4Yw@mail.gmail.com>
Subject: Re: FYI: path walking optimizations pending for 6.11
To: Mark Rutland <mark.rutland@arm.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 07:28, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> > For the sake of review, would you be happy to post the uaccess and
> > runtime-constants patches to the list again? I think there might be some
> > remaining issues with (real) PAN and we might need to do a bit more
> > preparatory work there.
>
> Sure. I'll fix that silly left-over store, and post again.

I only posted the (unchanged) arm64-uaccess series and the (fixed,as
per your comment today) runtime-constants one. And I only posted it to
the linux-arm-kernel list, not wanting to bother everybody.

I have two other branches in my git tree if people care:
link_path_walk and word-at-a-time. The word-at-a-time one does touch
arm64 files too, but it's pretty trivial:

 arch/arm64/include/asm/word-at-a-time.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

and really only involves a better instruction choice. It really only
matters if you end up looking at the generated code of link_path_walk
and strncpy_from_user().

The commit message at the top of that branch is a lot more verbose
than the actual change, because I ended up just explaining the
different phases of the zero detection more than the actual trivial
change to it.

All four branches are available in my regular tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

as 'arm64-uaccess', 'link_path_walk', 'runtime-constants', and 'word-at-a-time'.

But unlike my normal mainline branch, I still rebase these based on
feedback, so consider them unstable.

IOW, don't pull them into any tree to be used: just use "git fetch" to
look at the branches in your local tree instead, or use it for some
ephemeral testing branch.

                 Linus

