Return-Path: <linux-fsdevel+bounces-49658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4100FAC048E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 08:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2FB27A2082
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 06:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A689221D9B;
	Thu, 22 May 2025 06:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijio7bIj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE231990C7;
	Thu, 22 May 2025 06:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747895291; cv=none; b=R5luMJwSL1b05zFa1jwQnQEMEmBBWx3m7/W0oz2O87VZHePgZzTT30Aff406I7Mcvr60DglaPzjSv0hrHZpKw105dPP1jPbzBLHaFdHGBzvAl0rwvb9u3+BNzN1kzvgmVnrtXE8gwmvsdgontxmxrqq5UZtl4Idkhoe4ZAtr/AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747895291; c=relaxed/simple;
	bh=IIJCYP06utjIpQePw7Ee28zeTx591O6yUKU04K0rZgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rluotKtb/KkYXGb7FykQHGYI0BCq2OYakwHqsr6gBwU4YTnIjbq/HNkLSe+RAJCf9JvNW50hdLrZQZ52N0/zr9a4jK2HjXkOTRt7xWFIbSIBdKCpeXL9GZDs8pBNNGfdok6vUCcVC07kxWwhc4ihwOQBCitZEQUL1hHkHEH1Ajc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijio7bIj; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4766cb762b6so81223051cf.0;
        Wed, 21 May 2025 23:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747895289; x=1748500089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHD6lCcHX2Pr8p6sdmSMfutAANjYi9IRIcXl5X7HkKk=;
        b=ijio7bIjzxIUN8LUYwBKktIAiat02/jCKYAAbd1oUdm20NHr6+FeWa88u+XIGmaClI
         1rmCyYleMF8zc1PfAaSJKq2qLh8lgK4v6Y6j/JVC5mT3/kRf29IN6LcisJhgjAlMCZiU
         2eixnk4MQc9HKn2fF6jO4wPeyIp/7uoupPzlLiLo86DBCQYPp/rqzbFFf00xH0Pe+6Rv
         DfznijtCKiTpqmWUHgPZGpncStcaY41OfsbHCqdf7VN9FLfkCPBxXoPWt+imxOJQr3hn
         9WFSuHSH77UKNCCM+bTkz0WruD+ljWp/TiJTXLB8M28FWthngXp7shvV5MpyTpubE0e7
         YQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747895289; x=1748500089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHD6lCcHX2Pr8p6sdmSMfutAANjYi9IRIcXl5X7HkKk=;
        b=nFgsf8OxEcjgiMaWwiD+H7WNwWfXAYoWYPw/ldDWfTrRrKFm8AVzxu2jN+XFntSEFD
         CXhBWiVRj12dr0vzBqb5dt79lSC7IdW7qnN7cAVPbv87UN6hdMAlcbYxpM0HxyJA13oS
         COOMW8Yc6TEhW0c6hyvxX0mrr0wi5NiLvGt6AxrsWZaJ74yLQz9Nn1ND3U5WkK/ZrJg3
         PrZPpmZCsyFbGta0x0GHuuexuWfqkYdy4N+AEzEgKRrsCXwgJYzpY5/fEJ2JbrRPfJ50
         nGK6LidXSBBm1YQAVDN0Fg2hBj7HEGgOrCoHNk+EFkj9RRrDvQ9TFIDNbNKpnF/XB2XQ
         669w==
X-Forwarded-Encrypted: i=1; AJvYcCUsbCrOPWSAgrbOZH/304DS73SFBnyJGC43FleB+HHs+HBowWbpxtiZb3IxsG/vhIhtdnk0l8wUSvl8WM/r@vger.kernel.org, AJvYcCV7UOdDitrm3Q+/pM3dsultxjcKsveXsp+EprxQMB26vZkUwNk53yo9DGNmR54H4Q/ajNPniFpEWuhwTuM0ccstcj9H@vger.kernel.org, AJvYcCWztYPlx7xwUfgfC3Lz9Eh4V4NdrmjNuUV5Wp7ZP74HjG5HoXakPg/lkeYOI32Dr8TcMre2iwFay4yDku+t8HgE9Q==@vger.kernel.org, AJvYcCX8fDk8lS+IERD4rrYrKMfB5BYxJRoogFcXMy8Imrv8QzH+0BqGnR22dMD5bJDm/JG0bZo=@vger.kernel.org, AJvYcCXERnl2ZdkW27GpICKBcp/vkXxxFb9A/B+bwQPW9fd5+vaKBImGum9SrP9Kjn36rn4Oa7GBl4VqvGqzaCo3bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFfc2BbJt7SbZJKGtZo5Lw8b39k8f7l730oC5Ww6wLWD7Hfor2
	aMm2o9Id2B9WYAQywZh0Pe5uMAa0hotLPfZoY9itL4Lrx0wTCxgdMZgTCMk24aMKQEGkMO+s3VW
	0yiS653AKTKPj2sQU9MLbaFlsKApA/9w=
X-Gm-Gg: ASbGncsQQJasCwy0dPuEcNJIg6bcjvONzPg65Gs0JccQWbxT/IG7xK5GiGoBv7gVplt
	if/adz1EkyQoZ8BnpXbaSEQI6ZJXzXy0B+boh3Elyp9AI56VcUttX3ufeoWZcibEw9mlzG0mV6/
	W0KnRm3cFaYzUh2PVUzCNL3VRHTv6Fm+Q6sw1ju46m+bBj
X-Google-Smtp-Source: AGHT+IEbl6ReOpb49RwwL8AZJ/9Sol4SvQN4M0UGm1K51odVAmk0xoRFec0CSuR4PFQ6HC9MD2pnvl3mwXOmXHsstbQ=
X-Received: by 2002:a05:622a:1e8b:b0:48d:66ee:662a with SMTP id
 d75a77b69052e-494ae58b769mr436574031cf.26.1747895289152; Wed, 21 May 2025
 23:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521062337.53262-1-bhupesh@igalia.com> <20250521062337.53262-3-bhupesh@igalia.com>
 <CALOAHbCm_ggnxAtHMx07MUgnW01RiymD6MpR7coJOiokR4v52A@mail.gmail.com>
In-Reply-To: <CALOAHbCm_ggnxAtHMx07MUgnW01RiymD6MpR7coJOiokR4v52A@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 22 May 2025 14:27:33 +0800
X-Gm-Features: AX0GCFsGdF0c_dPvPXc154mXKd8pL9O5JIppXmD9XtCHG7b0h4OOt3XBeUQIsTU
Message-ID: <CALOAHbDNBQN6m9SzK6MegwapUQ9vm4NgcZgyp=aepG8RA8J7UA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] treewide: Switch memcpy() users of 'task->comm' to
 a more safer implementation
To: Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com, pmladek@suse.com, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com, 
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com, 
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org, 
	david@redhat.com, viro@zeniv.linux.org.uk, keescook@chromium.org, 
	ebiederm@xmission.com, brauner@kernel.org, jack@suse.cz, mingo@redhat.com, 
	juri.lelli@redhat.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 2:15=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Wed, May 21, 2025 at 2:24=E2=80=AFPM Bhupesh <bhupesh@igalia.com> wrot=
e:
> >
> > As Linus mentioned in [1], currently we have several memcpy() use-cases
> > which use 'current->comm' to copy the task name over to local copies.
> > For an example:
> >
> >  ...
> >  char comm[TASK_COMM_LEN];
> >  memcpy(comm, current->comm, TASK_COMM_LEN);
> >  ...
> >
> > These should be modified so that we can later implement approaches
> > to handle the task->comm's 16-byte length limitation (TASK_COMM_LEN)
> > is a more modular way (follow-up patches do the same):
> >
> >  ...
> >  char comm[TASK_COMM_LEN];
> >  memcpy(comm, current->comm, TASK_COMM_LEN);
> >  comm[TASK_COMM_LEN - 1] =3D '\0';
> >  ...
> >
> > The relevant 'memcpy()' users were identified using the following searc=
h
> > pattern:
> >  $ git grep 'memcpy.*->comm\>'
>
> Hello Bhupesh,
>
> Several BPF programs currently read task->comm directly, as seen in:
>
> // tools/testing/selftests/bpf/progs/test_skb_helpers.c [0]
> bpf_probe_read_kernel_str(&comm, sizeof(comm), &task->comm);
>
> This approach may cause issues after the follow-up patch.
> I believe we should replace it with the safer bpf_get_current_comm()
> or explicitly null-terminate it with "comm[sizeof(comm) - 1] =3D '\0'".
> Out-of-tree BPF programs like BCC[1] or bpftrace[2] relying on direct
> task->comm access may also break and require updates.
>
> [0]. https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tre=
e/tools/testing/selftests/bpf/progs/test_skb_helpers.c#n26
> [1]. https://github.com/iovisor/bcc
> [2]. https://github.com/bpftrace/bpftrace

Hmm, upon checking, I confirmed that bpf_probe_read_kernel_str()
already ensures the destination string is null-terminated. Therefore,
this change is unnecessary. Please disregard my previous comment.

--=20
Regards
Yafang

