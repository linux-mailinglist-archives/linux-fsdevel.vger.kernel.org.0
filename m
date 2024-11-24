Return-Path: <linux-fsdevel+bounces-35729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EACAD9D7879
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 23:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0334282BA9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 22:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F7F17E900;
	Sun, 24 Nov 2024 22:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K8CsOkcF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A64117C225
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 22:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732486253; cv=none; b=FdlJlMhrwGye7xf9wCtL/Q69RQiBlaYfUM2oerysyqX+qf3tzNWusHdQkOwfeNpvAITBP5QqFcPxVDP7Ooi3fzbLZ1aKB7KwqF6gU241+3JOnvF3JPJJVrkjHbS+nV3gM8Dig4GvKrGEK8k2svbKug75XOfbqcu8eR/dZLO/Nfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732486253; c=relaxed/simple;
	bh=ar6ihNUcFRCpnCKKIRY6+U2tgcXR92DIV5BH0jFQKIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDUNIkOBPWUvWkGcSZuH+sqVUsQ2fGgaBXrUztvRog7HS+jak2Tks53frAK9PAIpZ40s+vORuhDGx8E2IAqp5NfMMbJM7CPhE93Rw8x72k9E/hSn1XbWPYzb7S93HRM/sOKt6LfEInoDKYcGv+WZKggtLKUww6WF+ogQU5YWL6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K8CsOkcF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa5325af6a0so201513566b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 14:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732486249; x=1733091049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=beVYaMmi0kkfaJKysIZgs/e3pXIwB76xz9Hg+r2NEqw=;
        b=K8CsOkcFTlHIpIbqKvJMBnPwTVzdXyYTKfjDnmbsq+cyNCtp2gMks6Fu+vriNT1JIJ
         BYZkDmoIAAIn0AGKGrJK3eqnxa3HQ3k+fBhSFr2Tv0TcFFTHX4oC4puKQZ1WvwHlpPhG
         uckfV6QY8aw9/MMDaoq78xxMkY7EHFGbe7XgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732486249; x=1733091049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=beVYaMmi0kkfaJKysIZgs/e3pXIwB76xz9Hg+r2NEqw=;
        b=wUWSc/U+xMwRAUihJ8U/d92ggLzmnA6AEffgwx7nnLHG7vneZlnuMDaDjUf2DXS5ol
         FZroqYRvI5u5Yvsw7E7rKmhF2c75nlGz4gdzlZXS93R0XvcQY2KA9dz+yBpl9qYYrAzz
         nGAnTbl0xuvj3hVXF3c2cyh4cOIx0N/ZWKy/axdqTEvd06kOYZb/axb64WotrsTZc5Kg
         AqHYsKQ1/KgULekMvy/NLxx/IEIeHF9mEI2pZA7Vwx7Ozv9Jf7Jh7wr38SfXZQUd93l8
         yNzMIeZG3fuVmHBh2wFgtPfmcyjmCSvp+9400ntV+S9HZGlM/LnT2MBfvjnIiatU3o4v
         YQUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtn4AgdkZ7OGqxwmd6t1cX+M6YpIPQpo9cuAfCWTklkOuw4LBrzrUwK/6Ps1fwnn8qE50WJ3AXza4mwo4O@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9StUk/fIhHSt2DUZc/gMV0kJxrGD9nxKgGSfwpIzSvWMGeeh3
	2TBV4S9jIMpJNGkKmOoH/fxMgB64x2/O+IOIoKjqm6JzF1uCnDagyPfK2G0hRRSkOjMbM8slZ0k
	7ZdMyCw==
X-Gm-Gg: ASbGncutb2HHlS2IAkOFNjjD9R6n1msCIeTPFUi6aSEdtd8wpexGMvRGJlKlqtJ84XY
	wZ9Z0OLOkJSCLs/7amnYrObddhQazHPJyleYzcW3QpR3+j1+NtFt5dKgewlxi+CEQ+q4PMmPRnu
	1HBmONP1WJNw+xYPTpe2l1XtCEHUHb5K+oe2bv0BPSQHl52LOdM62OMw4loGGqtfVDq3UCYiR+M
	PQ/AZrt0S/psgKv8BKzVIfOIS/veOU8AN7bvnz+fBIhDmT+v+hRabZpyEGb3vFLOfyJQ8tRjjcN
	ynS8O5Lsyl+eBxuSEj+aPIrr
X-Google-Smtp-Source: AGHT+IFA4YNOsO/bNwjgOXrULkR6Q6Pq8cW/OlzoRzk5ZK/gtfiEhESYwdEUrh3dZcoY7cvz+z7Q9g==
X-Received: by 2002:a17:907:28c9:b0:a9a:10c9:f4b8 with SMTP id a640c23a62f3a-aa509d49eddmr903869366b.61.1732486249594;
        Sun, 24 Nov 2024 14:10:49 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52f949sm392488666b.129.2024.11.24.14.10.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 14:10:48 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa5325af6a0so201509966b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 14:10:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXn8M/aaomniffh+CzpJa3hWMn/3Pzv4UiArDQVZqwMHy6gwxaCKOlERk1xewMU0ACNXBaCs17KqwXbxQK0@vger.kernel.org
X-Received: by 2002:a17:906:3194:b0:aa5:274b:60ee with SMTP id
 a640c23a62f3a-aa5274b69famr809208366b.39.1732486246942; Sun, 24 Nov 2024
 14:10:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
 <20241124094253.565643-1-zhenghaoran@buaa.edu.cn> <20241124174435.GB620578@frogsfrogsfrogs>
 <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa> <20241124215014.GA3387508@ZenIV>
In-Reply-To: <20241124215014.GA3387508@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Nov 2024 14:10:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
Message-ID: <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Mateusz Guzik <mjguzik@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 13:50, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Linus, do you see any good reasons to bother with that kind of stuff?
> It's not the first time such metadata update vs. read atomicity comes
> up, maybe we ought to settle that for good and document the decision
> and reasons for it.
>
> This time it's about timestamp (seconds vs. nanoseconds), but there'd
> been mode vs. uid vs. gid mentioned in earlier threads.

I think the only one we ended up really caring about was i_size, which
had the 32-bit tearing problem and we do i_size_read() as a result.

I *do* think that we could perhaps extend (and rename) the
inode->i_size_seqcount to just cover all of the core inode metadata
stuff.

And then - exactly like we already do in practice with
inode->i_size_seqcount - some places might just choose to ignore it
anyway.

But at least using a sequence count shouldn't make things like stat()
any worse in practice.

That said, I don't think this is a real problem in practice. The race
window is too small, and the race effects are too insignificant.

Yes, getting the nanoseconds out of sync with the seconds is a bug,
but when it effectively never happens, and when it *does* happen it
likely has no real downsides, I suspect it's also not something we
should worry over-much about.

So I mention the "rename and extend i_size_seqcount" as a solution
that I suspect might be acceptable if somebody has the motivation and
energy, but honestly I also think "nobody can be bothered" is
acceptable in practice.

              Linus

