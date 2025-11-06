Return-Path: <linux-fsdevel+bounces-67275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E5CC3A32A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 11:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6EB51A468BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 10:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C4330F94F;
	Thu,  6 Nov 2025 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QveKRI3R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD7030C601
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423522; cv=none; b=Rx+QM58/QAXn7A6SjtpW188TYV7NBVwXUmIrJtQUM0lV7sIAAHDJRnRuIpQcui7wXUsoAkBL49Zkt6jegbU3xv+aKOyL7ULXbP9gMSMEZ+d5dkkgn+OmLaW7j3vtLjKbN8r8f/PrpfufTH3FF0tDBmMpbdz9njFuJNHlps/NrC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423522; c=relaxed/simple;
	bh=Z9SBcCPeaeM8jmEuFyY3d76OUpSiPVaODHhAyJ2j1XY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=AywYcs6S8rnyQs8qbRGmbml3HFuXuBbi8Ts1tG0tOEHC1LOZhtgOsDw8DufelYLxaE41qcceS8XLnNRGyReSl306LzkMdWKcD7Qn14k/2eti7sxuXQilLF8p2N7oroOJdJGEA+Q2i/udwRukDrT2scKVoHlZxIhponSZtS1KAiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QveKRI3R; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640e9a53ff6so1451348a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 02:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762423519; x=1763028319; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z9SBcCPeaeM8jmEuFyY3d76OUpSiPVaODHhAyJ2j1XY=;
        b=QveKRI3R0EDG5txIUE7GuidMBk96gBt/THfeG5MOQA8c7A1ancImnJ9of3SC4srJ2S
         jju6SXHJARUk2x42uxFhWS7rqCR657xZVdFQUIlmKu4PxZuZa6OiyzzcsLCozQzgb02t
         h4vrJr0drBQm9yDQxkZp01C7vecFadOEkegS3VTHKvqfFt0tbQj5yX6KRi4CSaJeoCmE
         wSF5EWMrrwPs8lT0wx2BgFBIeZIEu1CNCTkgeYdALnNPepXzNNOWoqK66vhl3b8XowAv
         7T/lKt5SMkE03aa8prngljgO5PkUtWbNcTLzIVn2mrlDEYUqss/dk6hUf3LB3wo1jdKy
         w8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762423519; x=1763028319;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9SBcCPeaeM8jmEuFyY3d76OUpSiPVaODHhAyJ2j1XY=;
        b=vUXB8LEz1oz3v3tKn21i1kg4Ac2YrkFEpWHSZCCabGDfg+IkOqTpCinBGedG9fATQs
         xRlwb+/rr4OKH9O8kpfEtTzQYo9TUNUnIMTvJ5JO0TOUOWDPbdMY4uCgtAJx8xHwVp0q
         LKu2q7iwq0Cop5a7y/VshNYoFjp+OnXKFqgmI9wWo6rDo/ZBRgmcA8rjE/IdX3AkJ9GS
         nZUzsicKdb/DjUtUN7s2POPKBQCM0u6VALii/d7fTYGkPAgsY8Kw2sOWOBKu4Rsdawh6
         QwSEGk88pA6uIqfsDlfVlV8deLt7ayRAh7+AldKj9xIddb5BbJIaCUuEwVB0cMdDQLqP
         qk8w==
X-Forwarded-Encrypted: i=1; AJvYcCUuXzMJZDfBAnGzGTr12UWE77yeSUZWYRbgFXFyclw0eZw6kPVgRnstduSk/zwrffM1foC5OayPyABNbtu3@vger.kernel.org
X-Gm-Message-State: AOJu0YyswWNUfKMvfOjhZgYBixsMzgIJxIGuyycVoVI1b6xvPCrXWAuT
	u4kC2e7j6AlO8raEk5H59CTGgNJWge6aDov2WZQ4AKRkAMiT14QnU9TRysZxm0oKLytuDMpVY0E
	Lo6vhirYeXk/mQlknHYPdReVbvmdRJik=
X-Gm-Gg: ASbGncvV04e+Ue++zZY4nNL/RsPoUnrK/7LwsRkmdPjS97/2EDgAfKcKlOkaIBffXoN
	dXoC9a9A2SoDyDwveKyQmrZPENoft33awclt0FAZZaw/bPLqzFj4eFNtXp8ETsSHz9oKSj18VOh
	aRppJdsPTrvrdp5D20fbsB/beO6ukyMS8DjCsVN8vU/tHJ/3/iClb5D9PWgxM8yoYt0GLk/t7K7
	nxb2cwfdeC24cqOzaXsw4nftkEoL3jgz+bBYE9vkD5lojkggnIMdAHQJ+vHnxulZxjlPaVH4qUA
	G8okFXO5a/qNQb7XOz02zQr9jw==
X-Google-Smtp-Source: AGHT+IGe+sITW7EViPAVEP0paiHz+gRzBRFhkCWl5QvuF4/OUXBi+vRvX2YBLwHzJntVrW4DzB00Ptw1LCFAE4hHslc=
X-Received: by 2002:a05:6402:3553:b0:641:2cf3:ec3e with SMTP id
 4fb4d7f45d1cf-6412cf3eeedmr511684a12.11.1762423518683; Thu, 06 Nov 2025
 02:05:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dileep Sankhla <dileepsankhla.ds@gmail.com>
Date: Thu, 6 Nov 2025 15:41:52 +0530
X-Gm-Features: AWmQ_bnIbwi2CybsHNWHjzZRoRFY2_e7hTFYFWfFID5l6rYIL9fGocbZD84KG-k
Message-ID: <CAHxc4bug3HOPd1i2coqyJz_gRNGyeCpqiYo0UWV-w6cAAtD5KQ@mail.gmail.com>
Subject: on solving syzkaller bug in __filemap_add_folio function
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

I am solving my first kernel bug. As far as I understood, the
syzkaller bug I am solving (please see [0] below) is about a crash
during synchronous readahead when the folio order of the allocated
folio is less than the mapping's minimum folio order. On debugging, I
found out that the folio order was greater than or equal to the
minimum order when the readahead was initiated, but the minimum order
somehow changed (increased) while the readahead was in progress.
Actually the set_blocksize() function (inside file block/bdev.c) is
setting the new value for minimum order. This function was called as
the result of handling ioctl() system call invoked from the C
reproducer.

Both readahead and changing minimum order are done under
mapping->invalidate_lock (readahead acquires it in read mode and
set_blocksize() acquires it in write mode). In my patch [2] tested
against the upstream commit [1] taken from the syzkaller crashes,
during readahead, I am acquiring the lock first before initializing
the min_order variable with mapping's minimum folio order. This solves
the original syzkaller bug but another crash [3] occurs after running
the C repro for a while. Actually this crash occurs in
__readahead_folio() function (file include/linux/pagemap.h):

BUG_ON(ractl->_batch_count > ractl->_nr_pages);

The condition is being true during runtime. From what I understood, it
is impossible to have the current batch greater than the number of
pages in a readahead request. This means we are somehow altering the
current readahead request improperly somewhere in the code. How to go
about this bug?

P.S. The same crash was reported as another syzkaller bug [4] (kernel
BUG in mpage_readahead), however, its call trace is different.

Best Regards,
Dileep

Links:
[0]: https://syzkaller.appspot.com/bug?extid=4d3cc33ef7a77041efa6
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9dd1835ecda5b96ac88c166f4a87386f3e727bd9
[2]: https://syzkaller.appspot.com/text?tag=Patch&x=103ee342580000
[3]: https://syzkaller.appspot.com/x/report.txt?x=14cdc114580000
[4]: https://syzkaller.appspot.com/bug?extid=fdba5cca73fee92c69d6

