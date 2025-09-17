Return-Path: <linux-fsdevel+bounces-62036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F87B822C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 00:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BFE1C23A7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 22:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64E430FC13;
	Wed, 17 Sep 2025 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo40RZj8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8581430F52D
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758148722; cv=none; b=lzv3hAZsKETWpCdWzmlcJNtzM0ime+N6yXyY+qnYppbjBDotI5Fi6iA1Hyvq+HW2QAYuiAN50AEKpjcPAq0+ELgSohPGsrSD+rzgboew2pfPuDUYKWiHTH6k1oslsA/5wzMF9x/u8fiv3S2aFL785dw+v4MAYlIBqN1mzy4wQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758148722; c=relaxed/simple;
	bh=/ThNkGr+ZEjqTZAQF+vgJk0idxNVNcO73FYaVFQDEHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qteIHMYPEbtQBs8BZugeX0XPmCgzOdmro8Hx3wxWxDduqwpZ9Xb8YGirTM9WX7Ra8/OyOuAoURqgJo3eE+SAl4mJnE6R3nMHRN/uN80WGMuMOhnCeWGJYL4VaiWpQPdEzzxVD914WpeFxzRj8A4Y2WKkOxLUPgW0DqWYPgGVh6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jo40RZj8; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso424044a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 15:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758148719; x=1758753519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ThNkGr+ZEjqTZAQF+vgJk0idxNVNcO73FYaVFQDEHs=;
        b=Jo40RZj8Y+fSh8WxQwb4kkcp03yvJIUpOWA9cdy7FWTd6uFBhU1hZS90MJGxe9XEoc
         yAOJ547sKIMtJgLajvQ1VkSS9XqPlLkkbrg7/U4iSkFFJ8vW1tK91wcUTyfwsjTGqHZl
         7/4pbwhK/iReSUvORozQL71GgfoNSOm7T9+8hK5vYa0Fj9SsyWmlVhb60xVUH9209Zu6
         Mb6ka2sT1xRD7SquiptIIRE5CHOYNWld0RMeEG8EPN8whZU7Ob7Xd8R7/ibvDS2cCR1z
         UpeQBYc/XWZuiNOp9viNOYHbFLLoe/sPmIfsrhLrIWTob0MfH3E9+S4LgcKZcapAq6Tj
         twRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758148719; x=1758753519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ThNkGr+ZEjqTZAQF+vgJk0idxNVNcO73FYaVFQDEHs=;
        b=Zi2qHcdDYRtsRO73LVGso8wKBajaansLPxVaw0aQy/GsFjP+02UrMl9gEnIqkaXAkM
         VRxJLT9PZtAzuc3JJAC+TDWKWXeEAGv1jxEzjfyA4Pq+je0p/khy/q7oYvasE2gKpJQ2
         T1RFgRN6RfC6FZC/eSV3zomDzHqrMokr6owAb0CHOuf5QQer9E8eJzl80eevM3tHaEAU
         SeU9jSPwrz6xvE2aLvDMi481IXApdSrvNCKZ7oDA/FYinLmlQpo8TeoBoM53j3g6/ND+
         jgUXI+IJZEnp9kg20NMMZinOCgPLO+TbKOnK5AYO5ozWx+70twFH7HTb6AOFovK7Nocz
         dR+A==
X-Forwarded-Encrypted: i=1; AJvYcCUL5zjPFYw3sMxIjpNfKA5nbdOzfFXeCjm8qVqEx2LtcJ4WbnjerB5NfR3t392d3rv4hTOiYKL7+Qh9e7M7@vger.kernel.org
X-Gm-Message-State: AOJu0YyBFWIQlaovPO2MoXwtxUzSYERHSKZvk/70xFSDlygYJZ95A7yo
	xmtj1O9hrutEYMJNaji493x7Weu0Y2ydIuIGgXZ0d+cfl2ME854RA0eupP+YTLO6WG/P4Lfsvj+
	06wcgiDY94KPvvmUYuvEJoLyBws+xSAU=
X-Gm-Gg: ASbGncuV9kyVA9bsgtHJZE8dwe75E2jyxhKHVkVQZhm2Jvtt/GKfp5aQHxLdUAXZkBB
	4iDln0PJRbvjDhWw/rBRueZusEbjuHp4WQYG2nKspHv/Tp//zJZyLAhSWhYNoqm5HV4vHg9BC+4
	Ze2hKUDTdl9JdEdko6nWVI3AvSvT+h011erVjWYY+RtBwxZT0iDWSdfZsmpp/uX+GIb/60a65rz
	qNlPkOT3mH6OosYS7x/sRHouF+3sjbBIGX/z8BfwAHpwe3CvajrfjMVvA==
X-Google-Smtp-Source: AGHT+IEfSJAKNHpWgZVUf8o+j/Jls/Qpg0S3h5SUv32JXiLjp2fei3IxBHlxD5hh5CStRz/jkhZR5P7q7aYPIS20EDs=
X-Received: by 2002:a17:907:7b8d:b0:b04:3623:a9fc with SMTP id
 a640c23a62f3a-b1bbd3a68ffmr460226666b.30.1758148718744; Wed, 17 Sep 2025
 15:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752824628.git.namcao@linutronix.de> <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
 <87zfat19i7.fsf@yellow.woof> <CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
 <CAGudoHE=iaZp66pTBYTpgcqis25rU--wFJecJP-fq78hmPViCg@mail.gmail.com>
 <CACGdZYKcQmJtEVt8xoO9Gk53Rq1nmdginH4o5CmS4Kp3yVyM-Q@mail.gmail.com> <CACGdZYLByXsRruwv+BNWG-EqK+-f6V0inki+6gg31PGw5oa90A@mail.gmail.com>
In-Reply-To: <CACGdZYLByXsRruwv+BNWG-EqK+-f6V0inki+6gg31PGw5oa90A@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 18 Sep 2025 00:38:25 +0200
X-Gm-Features: AS18NWA4pOwDUosllJlj4H9gooia92TA6PwJgeXuzaDepx3vHsHzDeL6mCXiLr0
Message-ID: <CAGudoHF8pKE3ODqY-WnbV=ZpjC9hH+U+COq_KE=aH7mEW8fsKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
To: Khazhy Kumykov <khazhy@chromium.org>
Cc: Nam Cao <namcao@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 12:34=E2=80=AFAM Khazhy Kumykov <khazhy@chromium.or=
g> wrote:
>
> On Wed, Sep 17, 2025 at 11:03=E2=80=AFAM Khazhy Kumykov <khazhy@chromium.=
org> wrote:
> >
> > One ordering thing that sticks out to me is
> (ordering can't help here since we'll rapidly be flapping between
> ovflist in use and inactive... right)

a sequence counter around shenanigans will sort it out, but I don't
know if it is worth it and don't really want to investigate myself.

