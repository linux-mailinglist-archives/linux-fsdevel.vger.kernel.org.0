Return-Path: <linux-fsdevel+bounces-35734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F039D78EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 23:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42611B25A6D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 22:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFE916DEB3;
	Sun, 24 Nov 2024 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bmCUk95Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043AB17B50B
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 22:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732488260; cv=none; b=SwSWXSxXBw/h5LlUIFXTnRNzgepwYOPG0gED0aNzRq//S+2iTS/NPGRYTs/r6kwIOf9bZwemeZXo+5UuSTATQOwWzsyyQtYJVUpAMR2cXxjgnALF8Iq4Bv0sZQOXPEouSIvch4IB82R6zOpkfq4dXDCQU//++JUz35SRgBe8TJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732488260; c=relaxed/simple;
	bh=3s4l9EUOb159JQOwNguTdmw9Fzaozv+iX1wE3Tf2zE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pC7GcqGBxoXQMkHgXla9VpcOeOy0HSXIkbofC80SJZteF/6cExb3codgvkw0Wtv1XQA1Dw9iPwknQisw9x3vHOhXbmSj5njAfwQ63Undd2z/HmrIeL2uA7LdSyZ10LDxVG+BxkkvIsrAUCi2ICOGtMGH/QxRLyA9UdZa0ZHWXUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bmCUk95Y; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so4633145a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 14:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732488257; x=1733093057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qB+G6WrdsdoCxIwUW+ykYIm2moN5DapLNSVJz4cIiDg=;
        b=bmCUk95YZyxjBfGzaZTaAVanop0AqMsgzjwQdVYPcalgUtWAgkWexXU9Swt4WSYY+m
         PKYng/kiPowOQOo4O3AD4zRwmxJQW0LqesjxDR9jBu5K3y4Mcf5EkHn67R7Zelr2etXj
         Y+ugmmT5CyxUoRRNe9gq/gZRyuSvJSlxaW1GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732488257; x=1733093057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qB+G6WrdsdoCxIwUW+ykYIm2moN5DapLNSVJz4cIiDg=;
        b=rMGfzMNV0B75ys25yrGXxp2Xv8Rd1sdFXQ9qRU+3651ZUoLyYKZsGaUyiwbUGXDvN7
         DBeIQl5q/Vr3dE+z42tsnGMlRpKlCet0z1LH6iRj57Bbw9BIjhVYROPJnsV1JGmZ0Rgo
         i3mF7ux4hSvKAbDACthglKhUCRacLxu2/QUlvA+TChVhJ7HY7mhCMRmwTNAm+poADlEa
         4BRSRwTB0w+01sNVHrUtCgrYwALgMyQIvLubbl+hITRbmfGXHranE1HeL1pHSE8kXEW8
         IrIoqugCDzQ8M/S1DISRm4Nf/ZB0gABJ9AdQ1Nx8CjTMLTHzzUm1Flr5a/bdhuJl2V6O
         hImQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyL5lAQzBA5AaTXGtJTWFKdgGmpsZwZUxfotaMCUn31KQARVDBQM1UPQTnSIUB8+WuMPurAVKEe0pI+uRk@vger.kernel.org
X-Gm-Message-State: AOJu0YxdC30cBZTRZdc+KDupdh3q9gSo4faNrMkQTgAyX7MdfDBYKNgK
	A8nAbtOA8CofRxqVaPZEvMg8EBpQxkT6QKV0ilQrS1YHhpSy6XttajB6qdXddjWZ6eROR8eFYtF
	SK2ve+g==
X-Gm-Gg: ASbGncvTgI/b9GSKfZwun4eF9dhog0VO8755ERyWpcqR2s8LOHV/IC6H+bY3nWU4w1W
	D533Ajkf3KxzyrREBUuLwZcu/RIpjYPus8xUiol6jqNJu/LuJGxNuc+kSlS24ODiaHY2U/sZCrl
	nzM+qEl4cqj8unkOzSDJ1TsoOJ3PgTr4c1n/zo2zM7pgmY+IRM7jK1GENYUFfXzp4EUNVfGDrHK
	CNxSSEEm866bAnHErRFkc+4qMluGB+IVNkASx3yv7SEX/nh6uSJysKbj4KmBHavsUlBqGkBWnh5
	zPokSdEEYvEQjOF81NoAOJfD
X-Google-Smtp-Source: AGHT+IGEeZS+Ob6b10Ev27g67YRovvbi4m4F35LZkuvKj6/Mb6GtLmLHiAIJcRuBIfP8+nxJ0bTk3g==
X-Received: by 2002:a05:6402:518c:b0:5cf:abbb:5b4a with SMTP id 4fb4d7f45d1cf-5d020688560mr10942703a12.25.1732488257165;
        Sun, 24 Nov 2024 14:44:17 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01f9c2dd2sm3362247a12.18.2024.11.24.14.44.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 14:44:15 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso575617466b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 14:44:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhjNRYp8OozP+j9pODYi2U9P4oePp812FBeJU6hL5GifrmgL7sW7pPh6N5x6as+XrBOsOKWVxB1cP4mTGj@vger.kernel.org
X-Received: by 2002:a17:906:d511:b0:a99:e939:d69e with SMTP id
 a640c23a62f3a-aa509d790f8mr782019366b.51.1732488254135; Sun, 24 Nov 2024
 14:44:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
 <20241124094253.565643-1-zhenghaoran@buaa.edu.cn> <20241124174435.GB620578@frogsfrogsfrogs>
 <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
 <20241124215014.GA3387508@ZenIV> <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
 <20241124222450.GB3387508@ZenIV> <Z0OqCmbGz0P7hrrA@casper.infradead.org>
In-Reply-To: <Z0OqCmbGz0P7hrrA@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Nov 2024 14:43:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxZ=jgc7up5iNBVMhA0HRX2wAKJMNOGA6Ru9Kqb7_eVw@mail.gmail.com>
Message-ID: <CAHk-=whxZ=jgc7up5iNBVMhA0HRX2wAKJMNOGA6Ru9Kqb7_eVw@mail.gmail.com>
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
To: Matthew Wilcox <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Mateusz Guzik <mjguzik@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 14:34, Matthew Wilcox <willy@infradead.org> wrote:
>
> Could we just do:
>
> again:
>         nsec = READ_ONCE(inode->nsec)
>         sec = READ_ONCE(inode->sec)
>         if (READ_ONCE(inode->nsec) != nsec)
>                 goto again;

No. You would need to use the right memory ordering barriers.

And make sure the writes are in the right order.

And even then it wouldn't protect against the race in theory, since
two (separate) time writes could make that nsec check work, even when
the 'sec' read wouldn't necessarily match *either* of the matching
nsec cases.

So it might catch some case of value tearing, and make a "this happens
in once in a blue moon" turn into a "this happens once in five blue
moons" situation instead.

But anybody who really cares about this case would presumably still
care about the "once in five blue moons" case too.

             Linus

