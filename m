Return-Path: <linux-fsdevel+bounces-36547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3326E9E59DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 16:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78CE289AFC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 15:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8491622256F;
	Thu,  5 Dec 2024 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1mz6iC5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ED0222560;
	Thu,  5 Dec 2024 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413016; cv=none; b=oXywfXwNS3Wjohd8zxfE37BaCUiWufgZND397CAmxFkEnWPxk0Ix+G2nExNZKxtl9XlM6gwGZfoC62uhY/PWbw6TbOHLZbQ3MXZWUZdLzvTOlSbPxOOl9glnZRirngHnfUtYbmrM3MrzE+giYgRogw2P5rX+vR+b1mr+uptDJt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413016; c=relaxed/simple;
	bh=9z94k45yOGWBlzaO/l8bkxtHvEoE/wCOjiuqlO3pBEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nemP4BFeff36tPKuSnhqFYy0ICar+LJ6ByO1yo0KJl6oNmdRqW1az7qOeJkyL2lKFpEsHW/MlrW3S5m+XoGpy7Ny7s+Wx25w1NDXQh9Upi42I39WU6TA85lqC5LtCr4u8g+Nm6s9P2y+4O83rYqgZu2SDizefNeGi60MMTGVCUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1mz6iC5; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so1676212a12.1;
        Thu, 05 Dec 2024 07:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733413013; x=1734017813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z94k45yOGWBlzaO/l8bkxtHvEoE/wCOjiuqlO3pBEo=;
        b=G1mz6iC5IvClfMTCn7VLBkV5ux5W62hWfod9mrXE0cDxbkd8ddMVVXtudmGMz/ObgY
         wXWml9nw6Z9Vym9voY2MsItgl7ZoGnrhj9VE9BydxdhP57xLN7zqqnqXlEcJS7EeCJgY
         d1/YF79I0xe6vFArNCVmPpEAbQRKAouBe5oR8yVYRrsDjsQj8vJuooMlbv6w3geQDFl5
         1HpqDFxZnW3vp4cBYX1an2xdC20D8lIWQQJOiAJ0R5odkvQ+QsIrCqKtZSqw6qc7Hn77
         /+yXuBthFDEhMXaToIraOsLzsxwpCuKKED9+Cb1V5idEKj9T44VrzUL64Kp0zyswSyeL
         sE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733413013; x=1734017813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9z94k45yOGWBlzaO/l8bkxtHvEoE/wCOjiuqlO3pBEo=;
        b=t49z6KuItil8QaK1MdMAH+xbSZRM0UsIjqoeYQ8wtWmtF9a7EmHpcaKDyeUzkAMjW5
         oF4roYmf5f19X3prgLJg/9HrzgLCE0uPbFHQjbhU+0QMDoZGfyoJsRr5sE1JHSwLjcnB
         pu86WXSp4WIdRJgGuVy0xcbDTE/C6o9cYWHHaqmCQhXR+4k+HBVLo95JuZqIHdE9FgQc
         TBeR98GYpgBx/lS5eAwOTL57Z+DCYbuizSRoIhLjUM8gg2VIoM3M08+v7J0KexaWkTq4
         WfR8G1el72RS/k+aJYwIk9JfNBQw76fPhjAy1RnUZO7b3P5btEjz3/vAySZp5czASLYT
         iVCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBzX9gAavV9AQ5F+/oJduLbRdFt074QfrQGQe5Xv8eMCV2OaIWd1dP5pRVnMZreGu68I54q06jCXhdqurT@vger.kernel.org, AJvYcCXlf1nWU8S9rN5qIPKM6iwQ7tGlPAMgZTWnYnX3HIBAUs9RowUb5ZRq2LQZq3frlJO3sEdCVjTEwpGZ2TFa@vger.kernel.org
X-Gm-Message-State: AOJu0YyxU1AFI9gr0QAyyfpQkGhHJMiRIV9+UFDgYiVgsJGHa+gsLOUc
	9xeUPFmhApuqQelbvr1nm/v1kUjH65XHCzUf5hha7c/0WUTCJaMKKRbNRcUmkvTP05QWA6dHiIH
	O1StL/wwn0/BPkUxiM8qQdRRZXesnFg==
X-Gm-Gg: ASbGnctxpRpfChhlbGlKk0hJL0d84xPBbu3AodWYCWlY0dUg6epL/FFr2B5D9DZpm4e
	j94MQznTFRejO1NRx/4eVW/wqYk+rZQ==
X-Google-Smtp-Source: AGHT+IFFkS7ODa/d6Tyg4TwSlGSOoT1sH+VQ2gp9vQS+9CNj9Uyz1+3GOCJUEwhMgjQ4FbBk/9dEPq9Ebx+clhDLpIk=
X-Received: by 2002:aa7:cd6b:0:b0:5d2:723c:a577 with SMTP id
 4fb4d7f45d1cf-5d2723ca981mr2130672a12.14.1733413013473; Thu, 05 Dec 2024
 07:36:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
 <20241205120332.1578562-1-mjguzik@gmail.com> <20241205144645.bv2q6nqua66sql3j@quack3>
 <CAGudoHGtOX+XPM5Z5eWd-feCvNZQ+nv0u6iY9zqGVMhPunLXqA@mail.gmail.com> <20241205152937.v2uf65wcmnkutiqz@quack3>
In-Reply-To: <20241205152937.v2uf65wcmnkutiqz@quack3>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 5 Dec 2024 16:36:40 +0100
Message-ID: <CAGudoHGyFVCjSTjenyO8Y+uPHyhkOCwZrvBW=FyQRDundntFdw@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: elide the smp_rmb fence in fd_install()
To: Jan Kara <jack@suse.cz>
Cc: paulmck@kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	edumazet@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 4:29=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> On Thu 05-12-24 16:01:07, Mateusz Guzik wrote:
> > Suppose the CPU reordered loads of the flag and the fd table. There is
> > no ordering in which it can see both the old table and the unset flag.
>
> But I disagree here. If the reads are reordered, then the fd table read c=
an
> happen during the "flag is true and the fd table is old" state and the fl=
ag
> read can happen later in "flag is false and the fd table is new" state.
> Just as I outlined above...

In your example all the work happens *after* synchronize_rcu(). The
thread resizing the table already published the result even before
calling into it. Furthermore by the time synchronize_rcu returns
everyone is guaranteed to have issued a full fence. Meaning nobody can
see the flag as unset.

--=20
Mateusz Guzik <mjguzik gmail.com>

