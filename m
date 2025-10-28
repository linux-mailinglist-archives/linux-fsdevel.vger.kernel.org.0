Return-Path: <linux-fsdevel+bounces-65969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8B8C1770D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379261A655A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 23:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DBC3563F8;
	Tue, 28 Oct 2025 23:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b5mm2fmB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5433290A
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 23:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695936; cv=none; b=au/X78iJQaVJ0BURRDAH087qYgeBA2DxnVhAXrzvx78KyldmO2DYRQLbV0Bb2/TzYnUMsR0okHQN8SORaINnMN7hLiyEZn18MlA3Tq5pb3cr7LmnG/po+U6fSMPsQYeMe8YxF5n6ZGUixQGnCU1MVPyONj6PKykqxswPGMrxcyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695936; c=relaxed/simple;
	bh=kk8zkzm83REChxkZSsstjBUXBS7wFfE2QPwc7AaZrqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4aiTSK2qzhLZQGaU4pZ3muCWFCIw1GkgQzNr3VqtD0bYk2HILwQwJsmwFDVdyvX695Hi+KXu+2vD1ccWPCq8OJU42JOFjzNulUrRm5Jt9bldKW2xDomZpS0K6QABOpje3WOAKCNDNMoItbRYxREnl0C/RnAs1SJWK1KYvbeP9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b5mm2fmB; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c11011e01so9709385a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 16:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761695933; x=1762300733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WE4n4TCb18hPsMXmSS/+ET4xqQfmAur/mQUYq6ibGY=;
        b=b5mm2fmB9zTSMmFv4iKcb4cYmBOnPB/Zy4oRNHUHZ2iikAuKggazvFoh6D8vH5ZaA9
         DhmA+LKcnFO/ZrtWv+2TA34YvpTl7erhnFKoSbM2HAtVpRNrZuJyEJhtkWIlZY9GLHks
         +/MXfaI5oLqKh5dze2y6Rt0r5nN8ipVqo9HD3i/WJISxOx+NS6+V0zoCuTSi9yCJkwlh
         lqEpqob3fsMnFyMfsJoSfvvOBZDCMfGFjBNH6d4vTByQp0KRH60bi9LyW2aLznonIwV+
         XUn44AEioKOrWDBMX7EER2Pxhi4Hytd2/q/OVHWxKd1TUG2EPGrQA6fIBm6xvgqMNQor
         I30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761695933; x=1762300733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WE4n4TCb18hPsMXmSS/+ET4xqQfmAur/mQUYq6ibGY=;
        b=EyOv7PAc1oUDAGxaMD53n3eD2vJp8d0vK4ASUjP8jXUB3oZ7GPx+0ux6ppHEoVZS5e
         ZETiklUBzJZtyDwjAdpICJY7xsDulPPHBaNAnQtN3FXs85sbX4mNjoZuDAkZPjQKU6jC
         mZ2zE+os3a9vejF4r5Yj6kKxwEAi2nRMD5/G/gjxLTzgC+7hRwRukCsaRZlhl3K37j+N
         I1ASga9ttZy0C82aoWf9toQ7UeuH/B4Smj0tBCF6Do4IVxfRCvDq/psSuXaT8upDzLrJ
         aEorexdUzKQHXi9NOMj5dWAhwpf4dE49Xr72qBqo5jKYUzp1QsvRbGMSS+GqXoMmznPP
         oNuw==
X-Gm-Message-State: AOJu0YyndzuTAM0hN0T8DE0gEq8BAYOtg8g1SaNrCEYOi+WkoYzl2MjT
	0atnR3ZnPv4xNtBuaxcXGlgoOSv/TkPBf6xAe81/xrjs2VcOHznjeMfMRWyhQDee31oToFwTRrY
	Wm17m/WSUB7vHYeo7SO3radj1nnG8pSKr5k9LEsyiuVPDjj/2B7dmWg==
X-Gm-Gg: ASbGncsyXTpZF322fL6jznTFS3eJZgoJ6ZJt5yWEKHyzVWJNCKilR0WIIyEgId+/HQQ
	9Vk4rLeM4EnVzcl/ITDnU2IRckqnalTFitsFVpDV406HkGH5IbriW7QwZB/UP5fTpJcrhE/9Qua
	BiGEzhTgsn8t1owc1+XhXvPdfEV8P8Hbkc0OFH2He9cgIbfxmrLYxvAQ45kYM3lv2Vri2bqiP5g
	Cktpq3KPl+FTUyjXg147xWkf+10TxQTjR9XHAO3F/25QTrmfrc4BVY8ysaS
X-Google-Smtp-Source: AGHT+IHvIzFCAVsIe9KLnMzhe7HeHw161tWjaGF8dq9LK8mHTJ5LNBNsg03z1RN2kv4hUoIzYntUB79AzDiL37F2WAo=
X-Received: by 2002:a05:6402:50d0:b0:638:74dc:cf78 with SMTP id
 4fb4d7f45d1cf-64044380bd9mr816143a12.34.1761695932545; Tue, 28 Oct 2025
 16:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk> <20251028004614.393374-11-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-11-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 19:58:33 -0400
X-Gm-Features: AWmQ_bnbOFuYYw7q6A3vKx1W9tiGVviHbdGsSFCW7Z6eJ8jFBd6mwoz2mbQdJG4
Message-ID: <CAHC9VhR4nO+TanWwz4R-RQijy9h5B2h6HuBDXxBNp0+kAE4Asw@mail.gmail.com>
Subject: Re: [PATCH v2 10/50] configfs, securityfs: kill_litter_super() not needed
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 8:46=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> These are guaranteed to be empty by the time they are shut down;
> both are single-instance and there is an internal mount maintained
> for as long as there is any contents.
>
> Both have that internal mount pinned by every object in root.
>
> In other words, kill_litter_super() boils down to kill_anon_super()
> for those.
>
> Reviewed-by: Joel Becker <jlbec@evilplan.org>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/configfs/mount.c | 2 +-
>  security/inode.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Paul Moore <paul@paul-moore> (LSM)

--=20
paul-moore.com

