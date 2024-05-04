Return-Path: <linux-fsdevel+bounces-18744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E15B8BBE51
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 23:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B515F282368
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 21:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA99F84DEE;
	Sat,  4 May 2024 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnnZkh41"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3511BF3F;
	Sat,  4 May 2024 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714859851; cv=none; b=HtzxmgfjqPZYNOb0RBpKht5b5X9JAM6RBp1t/ost+fNUJjGwnexsz350oIEtvIgaLPTGnGqvLEofK/eiiDkzvWFKDeOpqj19ym7u71+39+ipMrM6Dtmb/Hk8sJ9Hoq4Qw8S1Wqa2YRhl1xEBWZYCBRVnTuDjcxYKPfpEwBHQcOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714859851; c=relaxed/simple;
	bh=vLhwg+h7aqyOdPk697HtOoy0/FFWZ8axXimFiJyfjJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0kpI8Cf68Et428rEnPi/Ev0nCFji/tf1evvjb8wXimUxvmfwbct5mlZEcOHasqym60qoxSKlzYEV1RodL77CHuIUCbpK0LDR2g6Gr++ACw+6FvD5/b8gxyAPELd2fAMzqpvVdGO/qrt4kwDEZQJnGH8RDFACoNLX+DL8vdEPbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnnZkh41; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so411289a12.1;
        Sat, 04 May 2024 14:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714859849; x=1715464649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vr0WzAgqZQ7xcLK1USPbgE8wMONw4Q1nntWbGT+4brc=;
        b=RnnZkh419q7BCQB7MBKpaZGAv2bouKzEs5pCqu6VCjHummD4ejAH8bL4+qXIMqpke1
         CmVkgCVns3yV/qtIouBLER5v2Um8LrTtRC1J9Z5cRiw7NHIjSGyOf9zjsDDLaqmW0Atv
         Cl2ZkCR4RI9gQOay8nRL4d43fSJGKPxzkAsKIu2tTIvCYVKyLmFB1ZJrFrNKVQqP4NcU
         H7kNDhbgccxIRnIe3MRSQsxegDtMVb/3gJTeNzLUnvZKFy74PmEpatAUojq/5s1RIQ2Z
         Vrukq5EJ0h54OXrYdqEUv77lziPPAnXMYnNUB+0vX7TomY1o/YIy5bOE2JjX5LopILzZ
         u6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714859849; x=1715464649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vr0WzAgqZQ7xcLK1USPbgE8wMONw4Q1nntWbGT+4brc=;
        b=VeBZpGt0cCcY2Y+JvuTVdzCaQ9zkg0cxpVhu093ZNl+DoV8vyhExarW+0S98yWAI1B
         2iHBaqRumue2k5LHvfqvYW9o+8Sn0x83mxcvpmJlng366LLXgHL6jDb2+oTqfk0Live8
         vk4ASOcoZ2Nah3s0X2lC7BnUfRUqMUYE+jp6veBJjHaCoXYMawKFOYinDoooV1zbiAsB
         n3xzwSa6KSZKRycgG8PTIPqTH/g+Y/YG/VsebLjbjEkoZmiDYSHz02Ki6n7eAq1Kl3h8
         QmhktYAtU5zgQgxf0Jg2yE/cPcnaHTh09ZCvMSmf+TaSfgvKSsBiwvHhEBne3fTafU+p
         TNiw==
X-Forwarded-Encrypted: i=1; AJvYcCVayopG9EMBAhcruqe4rLLnCxQiUlBcwJ0dUTBJbw+djBiEewlyMR5XJOcnFlTxc92ML1AvAbLTemIk0vh1/W4VWJqdL1ZQSIDlsbiyfMIG9oZRWhk2xGwHdle0NJmDMXvqkZ4qJTuPtJaSRh18omHKixy/IeLdQBfMhrmEFCXWujvc5GTqBYri1/6NgC7xrF6c4elZn9f93RjxhetAdj4pBKY=
X-Gm-Message-State: AOJu0YxVcQI3cASLzVeu/haEnVDCiWVXKI7bLbDhLMmxcXICy2J/G0bq
	IWprJOErbicuCVWrJCKVx5CY3vFa86/VQCBH2qGG9EH1m/bFu6KfV7P2gaFYCehCk80ePCvMaKB
	lJoynLlllsMJ29+L2h1euLjMkGNw=
X-Google-Smtp-Source: AGHT+IFMx/po3MCuNgrp19VrE6Egvrp/t8LN5+yMt2RDi+MxC38dpPZiE3MXHhcWc5dPeAVfnEvpPaDHz/ahAu3kBsc=
X-Received: by 2002:a05:6a20:d80b:b0:1ad:6c5:4ea1 with SMTP id
 iv11-20020a056a20d80b00b001ad06c54ea1mr8771367pzb.41.1714859849188; Sat, 04
 May 2024 14:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org> <20240504003006.3303334-6-andrii@kernel.org>
 <2024050404-rectify-romp-4fdb@gregkh>
In-Reply-To: <2024050404-rectify-romp-4fdb@gregkh>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 4 May 2024 14:57:17 -0700
Message-ID: <CAEf4BzaUgGJVqw_yWOXASHManHQWGQV905Bd-wiaHj-mRob9gw@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: a simple benchmark tool for
 /proc/<pid>/maps APIs
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 8:29=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Fri, May 03, 2024 at 05:30:06PM -0700, Andrii Nakryiko wrote:
> > Implement a simple tool/benchmark for comparing address "resolution"
> > logic based on textual /proc/<pid>/maps interface and new binary
> > ioctl-based PROCFS_PROCMAP_QUERY command.
>
> Of course an artificial benchmark of "read a whole file" vs. "a tiny
> ioctl" is going to be different, but step back and show how this is
> going to be used in the real world overall.  Pounding on this file is
> not a normal operation, right?
>

It's not artificial at all. It's *exactly* what, say, blazesym library
is doing (see [0], it's Rust and part of the overall library API, I
think C code in this patch is way easier to follow for someone not
familiar with implementation of blazesym, but both implementations are
doing exactly the same sequence of steps). You can do it even less
efficiently by parsing the whole file, building an in-memory lookup
table, then looking up addresses one by one. But that's even slower
and more memory-hungry. So I didn't even bother implementing that, it
would put /proc/<pid>/maps at even more disadvantage.

Other applications that deal with stack traces (including perf) would
be doing one of those two approaches, depending on circumstances and
level of sophistication of code (and sensitivity to performance).

  [0] https://github.com/libbpf/blazesym/blob/ee9b48a80c0b4499118a1e8e5d901=
cddb2b33ab1/src/normalize/user.rs#L193

> thanks,
>
> greg k-h

