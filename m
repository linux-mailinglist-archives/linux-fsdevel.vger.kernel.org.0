Return-Path: <linux-fsdevel+bounces-60940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C50FB5315E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 13:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552571C88460
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE6E31CA4C;
	Thu, 11 Sep 2025 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnPnn9lN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA913191C7
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757591308; cv=none; b=nqB+f3X+q7ON4MrKzs0yo2qW0SPGbG2hQmVC2l/bqUBuRmTnV4UjuXpq7mCC7rIL138jP/VdQSMc6tI/m7/ot5InNSU5z9P2t6dJXQzoBVJ/YEpPZOSgTy0JmqRKA+bgOsgtVcFpmlVNj8dI22BWW5/FEYCVy/rGCpuBGKFFuc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757591308; c=relaxed/simple;
	bh=EkTK2XTSrHY3G5pm+FqDACFPq7N6pH7nHaRPNHNccS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fb8qt/z4+NdPF/45cVfZAuOW/KxjaP7AcZr2RpfK00aTdXv5KwwCAKBrmyl8S5cHEC5I7ipSutYCFNWNThlhqpDPhEpRuC3uI2DWIKj/8PwI2giFlAcvyDB6NyB0CDkG37i7GS9eApIsDjlv9/mQAXHuu/gB2NiMz9anGpAibHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnPnn9lN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b042cc3954fso112737766b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 04:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757591304; x=1758196104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkTK2XTSrHY3G5pm+FqDACFPq7N6pH7nHaRPNHNccS8=;
        b=WnPnn9lN6UEVALTkokHcSJwnGGCtTn2FndHOFVjUteY97stitD0fRCzqDQ0CuW0suu
         bnab8Xl22IG1J3rTS3LjYh4TPcO8KG1xSKh401ZBxtn4pCMI3lZe6+B1taDKxNGzcLBU
         jdm7/TkBM+ZobyrdQ+l0lyNwolYvSD7eJi2IPKaA04QjUkJyViB/DExHxD2KrQEdEQsm
         TEo8FTuZhY+yvchYdh4Okg+H4kyievNtVumu8rfeBJPqWTy9wzV05JJL+95FY1OZupxC
         /72RUfh7HZADmoAg7W3eUYtIWh0hDSxfCYwKn9xbZ84gSR0mMuf9XGAGnVZT3/zzB0gD
         gmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757591304; x=1758196104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkTK2XTSrHY3G5pm+FqDACFPq7N6pH7nHaRPNHNccS8=;
        b=xOLx6loCRJeeD0hJ4+Cjgp3D6A5uSZy6oQjaSjrEXHySJBgs+XoYD3d2lPk8tIxiT4
         zFxy8ce11BnOd5ySxX2zmaGVM8bgp2a64wckDoRaDILPUW/lADZKAeSVmyZFl39klmHw
         k9S/Zbn0pXvE4eUxXvZhhgI6aUuY34RN7144x5cobnXaOuH8BOTE0FuGWR5uO/B9UJ8D
         mIJFWicEzx8Mp4aXADqvIOySKFDUfhNBHxJRpp3emvp28Z4kfrrEaqYoC/Doof7k0Ti8
         I7msY9hSgP44Nye3S43xBfYLUB6xAdV/vxCG8Hhwpr+Niky1Yap53sgFXG2J9opUse4A
         jsjA==
X-Forwarded-Encrypted: i=1; AJvYcCUcqgpZQuLXUlrfMTviRqyNqfAKNa8g/a+SWedHheCtNwauTiLqcpRUdOv2rW15G1wafrcFyD1BThiiJ81Q@vger.kernel.org
X-Gm-Message-State: AOJu0YwfoMUTyOYXdwbIQQqoEagyvbUbEDvYenIR2BE3VpJuIXlv6NdZ
	Sr91tGOSwHCQaBTlrNVRlR/wWWS6stB2i25IjODzQVE2y85ALSo/kmEDZNSJUweUsL0xAjgYzu7
	QrN4Ea2102Qvgc8f5FT+3c6FPCX1P3kg=
X-Gm-Gg: ASbGnctKjxN4/912huRcwegv5duxQ+0PffAZSzH/Cenwq75zDo8kcD/HYzQc+/KyoWm
	iFEANhjZc39/YCPrsMOUcV7aSmSD81DsiJSLVcbYM1BG5v1o1v5cXKhZqNeybrG4iDM70nOV4o2
	GAWHNchDsGOtFsGTd0hdFJYfv8xUzo6Gu+kt57JQJZQ/9p1+V3ME1ZXZFRN087aspoVTrnFeYg0
	br7kbYuCWDD7RbzEw==
X-Google-Smtp-Source: AGHT+IFo70V+ej40+aX5Z/eRHJRCaW/Iqhahk/Ha781IK84/veOVnzt9N3EBI1U+cUalJ9ig/yIFZ2KLCeQ+wQEV8Cg=
X-Received: by 2002:a17:907:e98b:b0:b04:85bc:a926 with SMTP id
 a640c23a62f3a-b04b13fe4efmr1871379366b.11.1757591304254; Thu, 11 Sep 2025
 04:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-32-4dd56e7359d8@kernel.org> <CAOQ4uxhwJBLCzfKs0dVFOpcgP=LQU5hkRxVeLLR6g-qOxb9ocQ@mail.gmail.com>
 <20250911-ergriffen-autopilot-7e0488c135c7@brauner>
In-Reply-To: <20250911-ergriffen-autopilot-7e0488c135c7@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 11 Sep 2025 13:48:12 +0200
X-Gm-Features: Ac12FXzjtgrAdVd9rTS0ov85U74TI4ZgGunYM07J1bauwFv-Hur8qy96NfA8slA
Message-ID: <CAOQ4uxh9mWHYtP6JdvW6HEPgCqe4=3pcJ0V4SVa__8i_EFxUmw@mail.gmail.com>
Subject: Re: [PATCH 32/32] selftests/namespaces: add file handle selftests
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	Lennart Poettering <mzxreary@0pointer.de>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 11:15=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Wed, Sep 10, 2025 at 07:30:03PM +0200, Amir Goldstein wrote:
> > On Wed, Sep 10, 2025 at 4:40=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > Add a bunch of selftests for namespace file handles.
> > >
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> >
> > Obviously, I did not go over every single line, but for the general
> > test template and test coverage you may add:
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >
> > However, see my comment on file handle support patch.
> > The test matrix is incomplete.
>
> I mean, I'll just drop to non-root in the non-cross ns tests:
>
> /* Drop to unprivileged uid/gid */
> ASSERT_EQ(setresgid(65534, 65534, 65534), 0); /* nogroup */
> ASSERT_EQ(setresuid(65534, 65534, 65534), 0); /* nobody */
>

That would be good I think.

> > Maybe it would be complete if test is run as root and then
> > as non root, but then I think the test needs some changes
> > for running as root and opening non-self ns.
> >
> > I am not sure what the standard is wrt running the selftests
> > as root /non-root.
> >
> > I see that the userns isolation tests do:
> > /* Map current uid/gid to root in the new namespace */
> >
> > Are you assuming that non root is running this test
> > or am I missing something?
>
> No, I'm not assuming that. I just need a new user namespace and become
> root in it to assume privilege over it so I can test that decoding
> doesn't work from an ancestor userns owned namespace.
>

With dropping to unprivileged uid/gid in parent, I understand it should wor=
k.
I guess I wasn't sure if dropping to unprivileged uid/gid was required for =
the
test to pass when the test is run as root user, but with the addition of
dropping to unprivileged uid/gid - feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>


Thanks,
Amir.

