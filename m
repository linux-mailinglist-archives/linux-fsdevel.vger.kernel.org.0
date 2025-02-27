Return-Path: <linux-fsdevel+bounces-42764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF115A4855D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 17:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E9E18897FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 16:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13BB1C3C14;
	Thu, 27 Feb 2025 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkinSEJ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD471B3957;
	Thu, 27 Feb 2025 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674100; cv=none; b=BZBZdDlZ+UMeWdWBo3cUMyimdZ4CE1cF7UJdhGp5HyDAORWHe0vQwfkQuwb9w/YRCPDScnZhnJbqggr9xsM2lH5TqRtg52dP4SpxRSBsx/NsVWRrhuCWkqck5Pi3nGrXaNBRMKn3EVChziwfpiFf6mDqEOvnAptE9xVfTRknvyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674100; c=relaxed/simple;
	bh=EGEx+qSgNbIjemQu1AK11Jy/RH7gU+sLNaplsoeAgAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svkrOT/2whqHayA7NeFE4dBfjA7ssgm9ccFOttSldx3FBjGgQ5UxNte3YoH/v7sjy8mnwT5MEkgctsizF4MsflvLiBHwhGd/tG6wDuXyF2XSCqfB4wFgTOsWEyF1t++XpI7wIqu7KHK5FTJimsvcvAdD8htwx9sbFDuLfp8UQbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkinSEJ/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so1762574a12.0;
        Thu, 27 Feb 2025 08:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740674097; x=1741278897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGEx+qSgNbIjemQu1AK11Jy/RH7gU+sLNaplsoeAgAE=;
        b=JkinSEJ/dmE9gGI6RYjvg1n/VdT+bpLucH6eztJHcoKUVu5v+oQGLndvus7QucEQhH
         SrzviJ1wvUWIUfslGEVAdpoWb0mDgXyBnbDZ1xBg/qkaXKM844wjTWvWYf7bP7mFdTOA
         AgopkaU2+SUfOs+wQJ8AJ3PrBvYnPJFKNCHTrT4dOwTcLcoSBotej8rhb76930XFHcnA
         d29xWD5klym8jASQU6eV72g/z+rRIbIvHr1pdiC8WUx/yvsIeNycsYKlj32af589Tmaz
         hZBwdRLTv6ovjx9wTxfx+RFpqE4QU1UUpZABlrZvp6Nc98MU8lkwEymWE/rHnPo6lB3R
         s6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674097; x=1741278897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGEx+qSgNbIjemQu1AK11Jy/RH7gU+sLNaplsoeAgAE=;
        b=As7Hgs+nHT+Qn/MMWL24SYLpRiErLoTAvf4sqZ/sld/eFBQyKs4cclp25eYjHqB+Vq
         Qr7CuGn+AFSSLXN45DMKfvIC8PEgZsNvS5E8Nm/lbKYefIFvf9qs3yfWsxOa9R+g7FaK
         S1uueLX1yHSEv6/5hJECoaKul5keHeH2pg6sbWkbo7B+Oe9R2DerhFqkY/9d6HXIwfYb
         g3JkHgnnSwD7kA5UknnqXFYK/CNw4QViQ0Wt4Xlf3jjP76ytV30GjlMnVbhoYSZMWf/+
         BnoIv8PWwV5324FDXR3/4k/IWVoIng7PRDBBdwkg9xAPgUZmR/9VunEx4niknoTMFVyI
         cgTw==
X-Forwarded-Encrypted: i=1; AJvYcCWShSsaWrMw3I8E9SJeyeFm5xv15hY8eIxRR8xZ8VREzS9Ghvh+Kr0sHQ0djsht9+ELO47hG8AEerzcAkHO@vger.kernel.org, AJvYcCX81PrMUskocqp/ad1A9qmzMRGt32ADv0IQckY1J8KGE+A+XmRZ7AwPjJubAlJPheKdnQMSZ6XEKz3PoTl+@vger.kernel.org
X-Gm-Message-State: AOJu0YzI2KM1XMZQPCnRbWtwjeeOu+fvwAuZf+vKa6dUAxl8e+oIU1Xj
	q4MbgGhDgdXM2rbTaGaUqHi7qeMX4mrLWrC3wlduxmd+PPq7Z79FuiwxSlhKeAX2k1pZGw81Jmx
	Wd2Q4bzsSl9OSPtyNky60Jxi3t3A0c55c
X-Gm-Gg: ASbGncstA7HSgXA0a8PVc5XzAncLKFSLS7vYRbpFmnh5AP6jzSJ7lcSMwezK21BYcb8
	n5dFo9M1g7uPDrg5qu7W11DkDMaH34KagLqdsiN88UEpJMNe17yJShKMhKJK8c7KVV3dZTLbXG3
	AowwAbwBM=
X-Google-Smtp-Source: AGHT+IFhwVZ111475mJm6DaLSMZ9gw2d46Eb85IFRZSPUaXWAt78hPFLL7a1jQlWJzYM4Fv7ozom5m4bq1ZRpjR20zA=
X-Received: by 2002:a17:907:dac:b0:ab9:63bd:91be with SMTP id
 a640c23a62f3a-abf25f8fe96mr12030666b.3.1740674096614; Thu, 27 Feb 2025
 08:34:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102140715.GA7091@redhat.com> <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com> <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
 <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com>
In-Reply-To: <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 27 Feb 2025 17:34:43 +0100
X-Gm-Features: AQ5f1JqQcpINTG9HHBc_x7lQCNL3TbSACZXkwjeiTyGjjppBVCI8xi8zy05zmBM
Message-ID: <CAGudoHHWP2o+sqih1Ra4WVAW4Fvoq9VSufRA6j7Ex4F1RJ66sw@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>, WangYuli <wangyuli@uniontech.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	K Prateek Nayak <kprateek.nayak@amd.com>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 5:20=E2=80=AFPM Sapkal, Swapnil <swapnil.sapkal@amd=
.com> wrote:
> I tried reproducing the issue with both the scenarios mentioned below.
>
> > 1. with 1 fd instead of 20:
> >
> > /usr/bin/hackbench -g 16 -f 1 --threads --pipe -l 100000 -s 100
> >
>
> With this I was not able to reproduce the issue. I tried almost 5000
> iterations.
>

Ok, noted.

> > 2. with a size which divides 4096 evenly (e.g., 128):
> >
> > /usr/bin/hackbench -g 1 -f 20 --threads --pipe -l 100000 -s 128
>
> I was not able to reproduce the issue with 1 group. But I thought you
> wanted to change only the message size to 128 bytes.

Yes indeed, thanks for catching the problem.

> When I retain the number of groups to 16 and change the message size to
> 128, it took me around 150 iterations to reproduce this issue (with 100
> bytes it was 20 iterations). The exact command was
>
> /usr/bin/hackbench -g 16 -f 20 --threads --pipe -l 100000 -s 128
>
> I will try to sprinkle some trace_printk's in the code where the state
> of the pipe changes. I will report here if I find something.
>

Thanks.

So to be clear, this is Oleg's bug, I am only looking from the side
out of curiosity what's up. As it usually goes with these, after the
dust settles I very much expect the fix will be roughly a one liner.
:)

--=20
Mateusz Guzik <mjguzik gmail.com>

