Return-Path: <linux-fsdevel+bounces-34871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD189CD9E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 08:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE011F2241D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 07:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8F0189B91;
	Fri, 15 Nov 2024 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C01/zWLd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED3D523A;
	Fri, 15 Nov 2024 07:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655604; cv=none; b=m7357zmzPNfXaY0t0vfnX3jIZzJ9wQgIL4tjJA+F/NRUr2JeRHf9Xd3btthNImO8UXzIeew7R1xTiLE3b/ZnyFFgILb6fAOiQ9nfmYIwpJLi8njikHHNGZhzE4K6ae8psHbtcQFvwJqvAbZf9/EzIPb/QqZnKI9Gablwv/ojm5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655604; c=relaxed/simple;
	bh=H5go3CSHFDvv97STC33zwmw/ZiDdwPPvJhjZM8cCTNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAXgW4OqDDH8eOuKyajOPxYhOt29SXL8SOQrB98x9nTTse+9o6VkVGKr4k5jZmQMhlhp/m8ndB4o2JScTlRkWp/U8Jfb6JEMcpvZwFjrp3rqOakH8Zw8qWfXSCKEewH4LOanUj3xHZuYHoyBkf2NtXb8Vj7MW8AEUgA9yx8zQAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C01/zWLd; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cf8593ca4bso1383743a12.1;
        Thu, 14 Nov 2024 23:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731655601; x=1732260401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HJY4DnCd4JaTTdiuzlxUyMGg9/JMjaTBkeusliEvn0=;
        b=C01/zWLdHyPzq7HdWoZGukZ6/Kl6NnhoYAs8PUBBlUxVJHPjYHhMeHlbaHunzINpzE
         jPf07kwhXZNQ5J7NkO/xp+U7GUSM/2ysIBfxkZvM1wIi8ROtPyRYFvjGVCRId3+XZBDo
         20IhnaDfoqsrApk4gsy+lZq+f+BVwbPRTslYv4ZtfYicgNnmGKUKmfjnh1c2YbaNyDiy
         al4MLuynNfY2uyqFmdg7Cbdqr9nFQyXy3zzI7inqxyJH7affAcSTZxpglsxVfP7liLDH
         jVgdZhtEPJVmY2jgOSvpdSzbjTaeSCDOLV1lf52t6MWB3q7HnH4toNm4A8fS7C/owR3q
         yKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731655601; x=1732260401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HJY4DnCd4JaTTdiuzlxUyMGg9/JMjaTBkeusliEvn0=;
        b=vB6H/WIRGNj6Lopwo9Ab1V8bUSyUxH3Ighu6TdZc3GW8adJfjGdO559CJHMcIqhlYA
         hyVIeWb4lcvrlhC56cZvWG9oQg3sScwP7qt29zJHHzYSkZR5qfM6/lLkOFW+9OuygI0q
         +0BjQnRXYM0Hv3aAUb2cOM64xl4qj4WusL7tK97FW63xwZxsvzPzpNPK1yIprnzeCN52
         7e478CJ0mV+G27IsGwJthCHRaWGbtcAHp0J1DWrrq+xL3TGLlfZIVyLIKsha9kZjR1o5
         Ouu46A58i75iPj0VlYTuPBoWNp3Frge83MA3OL9Lw3BE+SHXoS5MyTffgNkj+uEy2qdS
         00Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVGWVHLzEQcYcgMnC8N5+xAwKhslWVyV8YD0wcXqzdmtL20fI77O6/rG79ZHEHjHKWzcrVYavlUU4SIQmoZ@vger.kernel.org, AJvYcCVNZnzkxusd5L5iX4X2r2C56cqVm07941UB4SqrdmzsaHCinv8/TTB/CDqkKpXf1tNU0BiR/hhbbAi9IYS6Zh79yqqpqk5o@vger.kernel.org, AJvYcCW2msMKMsCfBxmCtXIdqkPF1C93SVqFL9Q8UdhdzP7huiQuwct6W6sGUOpvfYWBRb2XSTA=@vger.kernel.org, AJvYcCXnnOggJp5LNLZzqYrVfHuqwy8bNIF0zSXTbRmiVtP3lMmRHxiSYk+pDmhE0prUE/6Ty1dGAcCVzcv4bW0lEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9S2ETDGS/OwAPVSg9u/I0OUibBmgDPTS14CKeF2njSgfBW2nU
	MlVE1uZdJJjO0wemCNCepmZhdPuv2w+UzjEKbqDNMTS/Jviwl2NtTQitrKrItvUDu1b/ytrcgCd
	xV3vz8PkM25zFYkngqzPYRCTer/M=
X-Google-Smtp-Source: AGHT+IECnxX84rmDYRbGoACKCtzyjmf9T/Bx+Ja9+VuTlkmw+cp/0WfDRxRiUouh39hBJbR/b14OXUe2YjAz0OT1iE4=
X-Received: by 2002:a17:906:9c82:b0:aa3:49b6:243 with SMTP id
 a640c23a62f3a-aa4833f66dbmr118929766b.9.1731655599606; Thu, 14 Nov 2024
 23:26:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114084345.1564165-1-song@kernel.org> <20241114084345.1564165-8-song@kernel.org>
 <CAADnVQK6YyPUzQoPKkXptLHoHXJZ50A8vNPfpDAk8Jc3Z6+iRw@mail.gmail.com>
In-Reply-To: <CAADnVQK6YyPUzQoPKkXptLHoHXJZ50A8vNPfpDAk8Jc3Z6+iRw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 Nov 2024 08:26:28 +0100
Message-ID: <CAOQ4uxhnBRs2Wtr7QsEzxHrkqOtkh9+xxDuNRHxxFY0ih-543g@mail.gmail.com>
Subject: Re: [RFC/PATCH v2 bpf-next fanotify 7/7] selftests/bpf: Add test for
 BPF based fanotify fastpath handler
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, repnop@google.com, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 9:14=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 14, 2024 at 12:44=E2=80=AFAM Song Liu <song@kernel.org> wrote=
:
> >
> > +
> > +       if (bpf_is_subdir(dentry, v->dentry))
> > +               ret =3D FAN_FP_RET_SEND_TO_USERSPACE;
> > +       else
> > +               ret =3D FAN_FP_RET_SKIP_EVENT;
>
> It seems to me that all these patches and feature additions
> to fanotify, new kfuncs, etc are done just to do the above
> filtering by subdir ?
>
> If so, just hard code this logic as an extra flag to fanotify ?
> So it can filter all events by subdir.
> bpf programmability makes sense when it needs to express
> user space policy. Here it's just a filter by subdir.
> bpf hammer doesn't look like the right tool for this use case.

Good question.

Speaking as someone who has made several attempts to design
efficient subtree filtering in fanotify, it is not as easy as it sounds.

I recently implemented a method that could be used for "practical"
subdir filtering in userspace, not before Jan has questioned if we
should go directly to subtree filtering with bpf [1].

This is not the only filter that was proposed for fanotify, where bpf
filter came as an alternative proposal [2], but subtree filtering is by far
the most wanted filter.

The problem with implementing a naive is_subtree() filter in fanotify
is the unbounded cost to be paid by every user for every fs access
when M such filters are installed deep in the fs tree.

Making this more efficient then becomes a matter of trading of
memory (inode/path cache size) and performance and depends
on the size and depth of the watched filesystem.
This engineering decision *is* the userspace policy that can be
expressed by a bpf program.

As you may know, Linux is lagging behind Win and MacOS w.r.t
subtree filtering for fs events.

MacOS/FreeBSD took the userspace approach with fseventsd [3].
If you Google "fseventsd", you will get results with "High CPU and
Memory Usage" for as far as the browser can scroll.

I hope the bpf-aided early subtree filtering technology would be
able to reduce some of this overhead to facilitate a better engineering
solution, but that remains to be proven...

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20220228140556.ae5rhgqsyzm5djbp@q=
uack3.lan/
[2] https://lore.kernel.org/linux-fsdevel/20200828084603.GA7072@quack2.suse=
.cz/
[3] https://developer.apple.com/library/archive/documentation/Darwin/Concep=
tual/FSEvents_ProgGuide/TechnologyOverview/TechnologyOverview.html#//apple_=
ref/doc/uid/TP40005289-CH3-SW1

