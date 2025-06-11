Return-Path: <linux-fsdevel+bounces-51324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42260AD5807
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 16:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91433173B69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 14:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6911D28C028;
	Wed, 11 Jun 2025 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tyz1HrJX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ECE2E6108
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650912; cv=none; b=NybHTvvKA4CdvD2zgclkcjqOTI4VrkailEO6y1CvhjPN7yEO1LNnAO3L8eTnQUfgY8oSvvyskqS7GdMzNJMCpVilxlJ3HzbxRhzIxWW4+4NQsskzaVdYfwMhttZz9KmiFPwCBtbYbi34GDmWxX0Wp4k4NFQ/2lZBF+oIVzivFtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650912; c=relaxed/simple;
	bh=crgnnjHZaqIsGOZjsjV7ZUBqvIC371P0i+OWUX75ppo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QI0U0kUkGeaWLYqi2YQPAYKDx7m/G+SzaNAUGjkBmUoFWRVwhCuntUxwlGkm2J+P9yvEcjnaxwnfGasLlYYLL7rJT8J/A+/c0LtHwd/TMhbLqA2GGrSghgWEccNc3AFG2pjhNTU5JyZHHMryge4zHScdig5UBd0BHaupXVa+emI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tyz1HrJX; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31223a4cddeso4757534a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749650911; x=1750255711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMCP5+i49Ei6OGx1t9OxUl2Teswzg233SMev8hs02gA=;
        b=Tyz1HrJXaNtSnTI9u3U6vU5kx2wYPs7tyOGXxLipKShJntEZ6FGUxAlbuJP2ltugaT
         TO8oDvo9UA0i/g2f45HikVOIFztT8DLUAcdZGmpS2qq845hom16gAZp7IXlhb6OZoyOf
         4/AwAbkIZcCIle91CTT6HZ7rYokpl1mMXJv+AIhhQYOHIJ9LUBqGDI2VLFcwIteA9weG
         dflO23yYTDvgF2sO4lLKDk4cahZKpIEPnvZHOvla9RnUNsMVwx3xvjp4XszKqL6A80cy
         hwr1scfSH6aU0Q1iuAPrxzKVjMbEAs2WtzrizflilOT5z3Chy3vLgifK6JaJRLt14u6z
         dqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749650911; x=1750255711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMCP5+i49Ei6OGx1t9OxUl2Teswzg233SMev8hs02gA=;
        b=HDTMmywGmD9uQ3p5/gdpKnvVWeTTv1aN7Sm8Zw2J288broimXkKaB7+XqRgtpP8WlU
         vm5typmzV1UBcQC7XloVRmwwowzINwvHS/dngVoJgaJUmwWDjJuCiGGtNmQTPiwgxf4Z
         NO21JrfTUYbdeOouAxHDjTKJ7E9T9z5Y+4zlJhkwEHm+z/ganQjc9PKVlhiF21OC1xRy
         dp0akV0gsBan/aIOBL2vrB3sA10wQCv4hrr7pVborTFUA2r3tSSpPheE/NsnJvYcXqyd
         afmTFT8f2BkLkfjSUGhFlfgHIEb8UDQ5ju1P4Rfq5jJFH34Sq+7sJNZDjYJsDiG7+VKn
         Ovcw==
X-Forwarded-Encrypted: i=1; AJvYcCXtu2JkDiKULZ3sqntlmHQYwQen+qNAxsoJ7SY+eq3zUctjukAcIaC/DfM6RjHHMrokPQv3rmWuuyhlAFDU@vger.kernel.org
X-Gm-Message-State: AOJu0YyjtUvGIwczKm35Rx9wgMblF9iGhJhHQ3X83ZdDs4YWyvGYzsSw
	+O5bEcBu9/K2oZm+wU/35kIVPRfuLaJeJsa73x6UYqpEhv5nL+zOSBYGanN9SD5vHSVni5VdVjQ
	QmbrqJhBMr2a+y9Y/4h8AEUfOWSuNGVeeNBEfjHsc
X-Gm-Gg: ASbGncs3RkRxVqEQMcnFLnDDNTzCSNzrRVVAupyrekWKirwTznWLPWHu3y6JVY9nUtA
	HBQ3vGHkoKOyQBEmBTcXao0o6NGo76J0nnMjRA90nCFPI6Xga+NG4lw/dkAWgMkOIAmrvLsjL+/
	xjYzBqFAoOiXTIniTRtxYdUG21XZ7BAx5HezihyrCIapU8JE6g7ie9S4vSzW7BCyICKODw9z7wN
	Q==
X-Google-Smtp-Source: AGHT+IE/zvALO/G36bMoEv9R3dBG9othx0hsbt6Wq2S7X1wCHNt0X1XpaAnFyLsBZjSEIc47LngfEr1Y5l2TxATtW/4=
X-Received: by 2002:a17:90b:3c0b:b0:312:1dc9:9f64 with SMTP id
 98e67ed59e1d1-313af26720fmr4514767a91.31.1749650910565; Wed, 11 Jun 2025
 07:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67b75198.050a0220.14d86d.02e2.GAE@google.com> <683b8ea2.a00a0220.d8eae.0020.GAE@google.com>
 <aDueHCMDLPs2UtY2@casper.infradead.org>
In-Reply-To: <aDueHCMDLPs2UtY2@casper.infradead.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 11 Jun 2025 16:08:18 +0200
X-Gm-Features: AX0GCFtUWXqinF3FxOk9yB1Et5-WWvCDPttaSsMJxKkZJmtGttcHC7lVof6yARE
Message-ID: <CANp29Y5H3VTZAVZjde5bVRajDUESAnCX+6H1wD90ArpT=EiU3Q@mail.gmail.com>
Subject: Re: [syzbot] [netfs?] kernel BUG in folio_unlock (3)
To: Matthew Wilcox <willy@infradead.org>
Cc: syzbot <syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com>, 
	asmadeus@codewreck.org, chao@kernel.org, dhowells@redhat.com, hch@lst.de, 
	hdanton@sina.com, jaegeuk@kernel.org, jlayton@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 2:26=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Sat, May 31, 2025 at 04:20:02PM -0700, syzbot wrote:
> > syzbot has bisected this issue to:
> >
> > commit 80f31d2a7e5f4efa7150c951268236c670bcb068
> > Author: Christoph Hellwig <hch@lst.de>
> > Date:   Thu May 8 05:14:32 2025 +0000
>
> That's not possible; this commit is after the original report.
>
> That said, there _is_ a double folio_unlock() in this patch, which
> I'm about to send a fix for.  It's just not fixing the original report.
>

Thanks for bringing this up!
The underlying problem is that syzbot has merged several unrelated
kernel crashes into one bug report (`kernel BUG in folio_unlock` is
just a too generic title). The reported bisection result seems to be
correct, but it refers to only one of those incorrectly merged bugs.

I've just sent a fix for the syzbot's crash report parsing code [1].
It won't affect this specific bug report, but once the new code is
deployed, syzbot will re-report the two underlying findings
separately.

[1] https://github.com/google/syzkaller/pull/6081

--=20
Aleksandr

