Return-Path: <linux-fsdevel+bounces-44875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016EDA6DF35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 17:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A053189164D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BB826158F;
	Mon, 24 Mar 2025 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2OaV9kH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE6613C3F2;
	Mon, 24 Mar 2025 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832202; cv=none; b=avEPrDt8r8didP77yyP+XP6sZcgzRp7OYvbuWxaOr5kizdmpJqlQgqTd6u/9pv9vd+ARnwWngeW+PNno6bstiQy2NDB6Bu1dYeW8QuDuIjt8vbeRPL3A929yXxPqUBHqdfRY9QsSPkSNHzILBUo/OtZnrzTPYsmFkxLiNBANWk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832202; c=relaxed/simple;
	bh=9FU0ifTamX5piTP5b4Ro9Ugpo0FdpNJ35VxXTjvf2j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/OyfRSAkdeBIOo9Pm6yz7ANfAk0DoE7efRitbjafqdVwrwYw5RzCbX2tVQqztEnjGnSIol6S1oEv2FMo7rg9PjRMKfruSYQspkzjiuvj3ZrC9ywzvaqB9CWx2awXgi/IC/lmCoPYsKS9wPXzboB8eXCjYwnUJhh2H92eLjuBt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2OaV9kH; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso8201530a12.3;
        Mon, 24 Mar 2025 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742832198; x=1743436998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QWkU/bMqwAqGIllPSmXgHuefvas1isqn0786Bpkz2M=;
        b=g2OaV9kHkO83Dn2DI6LEhOT6RgxJJib8uu60UGdkp3AWbymg2anPg7Ik+pEoNBcnK4
         TU4L1iIoCGxqahrwmZFU8mifCTul0WpixjhnWHoXiReky5W9iUWq8znm5Z0JnLvMd5PE
         vSA9g2stzijvICOxjZor/7W2eMIztWGurFvJQNwpiXl2Mx/f3Bxg93jGZ43eiN7eLroj
         cFDT7tZJ9IP5N7Vk8fQNneNWntYrRqwv+w9pkfqlXv8Kwun8p21WvAmSrnUmf4JUmOaQ
         pKnppIdAY9d4hCxV/tu1ecj0oH69PQpgcZMwt3ktAy6CSrugVgTqBk01dQ5JAg2P0O7y
         5LKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742832198; x=1743436998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QWkU/bMqwAqGIllPSmXgHuefvas1isqn0786Bpkz2M=;
        b=Rrvhy2HkXCIrVtANWO3qncnvwMoO0YEOs2ytKjDsWSq/oliC8KEZD6ztIIpZdqrWDt
         qXBE3HK6CIc+YJw0Ewt7BaiEmEu14jk/XurWJGmNVzK/ALwL5ll/v2jYo8l4BMfNN+W/
         cmYdXqW0DDPUwsCnWB7kaJPtFEwEqIOD+rXDjq5MZOsNYA0giC65uUCjwveoKbdQ3Ou5
         4jzGQRuqbgr6XSXDHkmWHhwJoUVZEmqYn1nuEivTzvsu6kH+IxmaWFpW2OQD8msqV7ot
         TAESUUOOnImWyvQEgbyOIZ9Wu04d8sSaaaaMddP7OXCQyPqjqxRckCjwNZU7rvaonbE/
         MlEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV243aPXUJpKKBm61pkVYG0GRLIDv/ick4ZmoXhx8Ws8NISrRN6iJHXm9wwsVJXoPApZOz/o0H/zfK0Xe5J@vger.kernel.org, AJvYcCWrhcOC2wvRzH5CYr2OzPcBWcEoL5zFb8OT0KkE56U4Nkn/yFkVw5OwKh2xidOya5ZhLC0vKzaRUd3YvYcR@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoc1akZmXz55HVN71y3uHK3OrwId/W5/SQ1L1wAzAPIdfEl0Cc
	upmfyOln+37cyem/IniX+kn0vsVerFH08Gxu3AuLNjyiWoak55qoyJiLasUDBaTaZvwmCUKCxOT
	1pupC5cNCu6hTaTLBdw7XqEeS1hA=
X-Gm-Gg: ASbGnctKkenny7C9n+dUTe7OWnuIGitTO5BqlpG/PjDWpFcb6KguPMUfc7y5cyitNAG
	+vAD3fTMemjr7JM7B6bl9tBfyD+/mYJ17JpJkPAbpCMuBYpqor7/un71A39AdAj4Fm7+/6Tmh3Y
	aZ5xRVLh5x05a+QQYxgw5XbtZqpg==
X-Google-Smtp-Source: AGHT+IG2+OeCLLVerEDx+IngTZJIlJRTqun6x/Jhs9u5Ler7WQckD41CQaVLpBgtja/BwNKAX/6oWi8OAjVk+dSeKpw=
X-Received: by 2002:a17:907:bc8b:b0:ac3:3e40:e181 with SMTP id
 a640c23a62f3a-ac3f1e04bfdmr1370423866b.0.1742832197605; Mon, 24 Mar 2025
 09:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250323184848.GB14883@redhat.com> <67e05e30.050a0220.21942d.0003.GAE@google.com>
 <20250323194701.GC14883@redhat.com> <CAGudoHHmvU54MU8dsZy422A4+ZzWTVs7LFevP7NpKzwZ1YOqgg@mail.gmail.com>
 <20250323210251.GD14883@redhat.com> <af0134a7-6f2a-46e1-85aa-c97477bd6ed8@amd.com>
 <CAGudoHH9w8VO8069iKf_TsAjnfuRSrgiJ2e2D9-NGEDgXW+Lcw@mail.gmail.com>
 <7e377feb-a78b-4055-88cc-2c20f924bf82@amd.com> <f7585a27-aaef-4334-a1de-5e081f10c901@amd.com>
In-Reply-To: <f7585a27-aaef-4334-a1de-5e081f10c901@amd.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 24 Mar 2025 17:03:03 +0100
X-Gm-Features: AQ5f1JqcXy-bG1AdbIVqBBipWfJLjXRMqOFRTPcGpSJ3frxXEsEwWshQXjEegpw
Message-ID: <CAGudoHGdOf35YM013VjGKQJF81OeMN6XQfkx8oF7PKLe08CjDQ@mail.gmail.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>, brauner@kernel.org, 
	dhowells@redhat.com, jack@suse.cz, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, swapnil.sapkal@amd.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 3:52=E2=80=AFPM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
> So far, with tracing, this is where I'm:
>
> o Mainline + Oleg's optimization reverted:
>
>      ...
>      kworker/43:1-1723    [043] .....   115.309065: p9_read_work: Data re=
ad wait 55
>      kworker/43:1-1723    [043] .....   115.309066: p9_read_work: Data re=
ad 55
>      kworker/43:1-1723    [043] .....   115.309067: p9_read_work: Data re=
ad wait 7
>      kworker/43:1-1723    [043] .....   115.309068: p9_read_work: Data re=
ad 7
>             repro-4138    [043] .....   115.309084: netfs_wake_write_coll=
ector: Wake collector
>             repro-4138    [043] .....   115.309085: netfs_wake_write_coll=
ector: Queuing collector work
>             repro-4138    [043] .....   115.309088: netfs_unbuffered_writ=
e: netfs_unbuffered_write
>             repro-4138    [043] .....   115.309088: netfs_end_issue_write=
: netfs_end_issue_write
>             repro-4138    [043] .....   115.309089: netfs_end_issue_write=
: Write collector need poke 0
>             repro-4138    [043] .....   115.309091: netfs_unbuffered_writ=
e_iter_locked: Waiting on NETFS_RREQ_IN_PROGRESS!
>   kworker/u1030:1-1951    [168] .....   115.309096: netfs_wake_write_coll=
ector: Wake collector
>   kworker/u1030:1-1951    [168] .....   115.309097: netfs_wake_write_coll=
ector: Queuing collector work
>   kworker/u1030:1-1951    [168] .....   115.309102: netfs_write_collectio=
n_worker: Write collect clearing and waking up!
>      ... (syzbot reproducer continues)
>
> o Mainline:
>
>     kworker/185:1-1767    [185] .....   109.485961: p9_read_work: Data re=
ad wait 7
>     kworker/185:1-1767    [185] .....   109.485962: p9_read_work: Data re=
ad 7
>     kworker/185:1-1767    [185] .....   109.485962: p9_read_work: Data re=
ad wait 55
>     kworker/185:1-1767    [185] .....   109.485963: p9_read_work: Data re=
ad 55
>             repro-4038    [185] .....   114.225717: netfs_wake_write_coll=
ector: Wake collector
>             repro-4038    [185] .....   114.225723: netfs_wake_write_coll=
ector: Queuing collector work
>             repro-4038    [185] .....   114.225727: netfs_unbuffered_writ=
e: netfs_unbuffered_write
>             repro-4038    [185] .....   114.225727: netfs_end_issue_write=
: netfs_end_issue_write
>             repro-4038    [185] .....   114.225728: netfs_end_issue_write=
: Write collector need poke 0
>             repro-4038    [185] .....   114.225728: netfs_unbuffered_writ=
e_iter_locked: Waiting on NETFS_RREQ_IN_PROGRESS!
>     ... (syzbot reproducer hangs)
>
> There is a third "kworker/u1030" component that never gets woken up for
> reasons currently unknown to me with Oleg's optimization. I'll keep
> digging.
>

Thanks for the update.

It is unclear to me if you checked, so I'm going to have to ask just
in case: when there is a hang, is there *anyone* stuck in pipe code
(and if so, where)?

You can get the kernel to print stacks for all threads with sysrq:
echo t > /proc/sysrq-trigger

--=20
Mateusz Guzik <mjguzik gmail.com>

