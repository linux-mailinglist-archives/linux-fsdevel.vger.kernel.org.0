Return-Path: <linux-fsdevel+bounces-36231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DB69DFEA0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 11:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4FCBB293DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 10:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9761FC7CC;
	Mon,  2 Dec 2024 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEJGHqZT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A21FBEB7;
	Mon,  2 Dec 2024 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134144; cv=none; b=kPHSKX5YtZTUpDdPT/PQmgtqk9WdqsXtA2thVTAequiRZI3Py8EjwVos5eeTAbuaKldek4ivT22lC6QpU/Oco07+fX3U0V9QAWrtFRQki8BqWFdUr/viX4+vCvhkUBex+CjRtaVmX+0fKJvUG4U4dQ1GswrJo170T+KNCHLVbJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134144; c=relaxed/simple;
	bh=ajyrKmGV561uwWTJ/tDNEYu+vUAXYt5wPMCzkc3ibJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tessqezndE32+h+XTWwNvZ5gLtZpS0QGtoeM9RZbC1OmUmZhwCoEqz0l1wITUG9kkX8shkSw2a0XYmm/Jfkw/k0TrOcDEXGMeaI0f1rM8g2SohHshXnYXXuJ/sVsf/9S/CAP55t+fRLNnOPLPdPzcJJMLXEuPr/H7vuz9Mv0ulw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEJGHqZT; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffbf4580cbso40120261fa.2;
        Mon, 02 Dec 2024 02:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733134141; x=1733738941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4NNvOJJAFb7gWh45cMCB0OahqHzhiov+bSRfiIxLhM=;
        b=ZEJGHqZTfYTBe3cXcs9glQj0NHmuxUQCeIWM5aiEHKofUjJsD0MtseWrAoWq6lr3F9
         jLHAyY8s+0IkZuqBh57moVNXgLVIJBG5E/e0Y8Y657jmQDpaubnSmwMsp+/J3jWxb44c
         unje8GA6sdcZua1V1pXBAR/FMZuut0rkuNrORTsJWiD48YQPsjJoeVvCo6FN/xyvv3IN
         0CRJy7g/1xv5CBldrITgw+I5Qkpswc9ISK8W8/U9Ixeo3eUadUw66lCwEqeaee1GLGnW
         OTDL5wKMXdVZIp3h32samlV+b1Im2bkIE/P7nQNTmgyU2QFHC860NLKY/7f89oqhGJfS
         ZCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733134141; x=1733738941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4NNvOJJAFb7gWh45cMCB0OahqHzhiov+bSRfiIxLhM=;
        b=AqtPQwTj+c3YDPOhVHQZnLJRRd7PUkGJ7GOywL66d1lprMM3Ynrm7Qvrwh56Crwmor
         dBkqy8W6go30Fpwq6hxifplS/vrgfeSWTBfz/o+DvoVfOyI1ioC8IXCWTOtIwL9KP1IL
         6IgOEapdGcDa00VWUxwkDOhbtAqGGw7qWCkl2ojzEp6R0X2MtrqTlUeytOm+OB4L5Hm/
         KQYJYpUHLOVgTsPHGcKMIbSMxiJ212hDuh9ZCxvF7FdijVhQlC9rJ7da+k29RgEwktya
         crAEJ3+DQxT9LaOgjzIAs99Vo9YM9VO5ThZZKyTVqzeJwLIKSwG19SfUE6Yg4p7SgpTu
         KPqw==
X-Forwarded-Encrypted: i=1; AJvYcCWsqO3M51G7ySfGEhI/GkCRmSXbnuq9UrDMYOcJRZtD/XDOZfRvMFvD4i+ikj9dfhibGa1dlB9o9dyy5G3e@vger.kernel.org, AJvYcCXJ/tAfpdKOtTXf41vZMdX/ie/yuTOq6cxi2f7xqlkQv+z3qnuyQrXg2RGJlzbUmZ9+zJxDyWxKloHiUQsf@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/mEyeGVFlzR8S6ZwekUyCyJ36JsayiB9JWD70/k2EDVe9wb9x
	/NawvrH7pZSvGXOMtfUSfnIOPYfZLbKpvEohYjxn2YQLcwaUUgDMlTGYHaM9kBj+zU1d0DPpO2T
	7Z8c6vQJaeqsHsafz+iYZ35yYj2c5LA==
X-Gm-Gg: ASbGncv+0C530mjYip/fqq7O6gy41hC8tMxc3AM7aaYLi8TXME41TK0IsP8raQKPHQk
	Q/Tmx10gLWz/6X4QKQIbaj+mijgVXBZs=
X-Google-Smtp-Source: AGHT+IG26j68pI4k1yVg7x/t1okfJCIfJVjhCHEFTgI6YjHyL8yJfau7Pddyfxa2H15uxcTjc35rs/eZZYLehrc/xQI=
X-Received: by 2002:a05:651c:2225:b0:2fb:45cf:5eef with SMTP id
 38308e7fff4ca-2ffd6120fa0mr118846671fa.30.1733134140934; Mon, 02 Dec 2024
 02:09:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127054737.33351-1-bharata@amd.com> <CAGudoHGup2iLPUONz=ScsK1nQsBUHf_TrTrUcoStjvn3VoOr7Q@mail.gmail.com>
 <CAGudoHEvrML100XBTT=sBDud5L2zeQ3ja5BmBCL2TTYYoEC55A@mail.gmail.com>
 <3947869f-90d4-4912-a42f-197147fe64f0@amd.com> <CAGudoHEN-tOhBbdr5hymbLw3YK6OdaCSfsbOL6LjcQkNhR6_6A@mail.gmail.com>
 <5a517b3a-51b2-45d6-bea3-4a64b75dfd30@amd.com> <CAGudoHHBu663RSjQUwi14_d+Ln6mw_ESvYCc6dTec-O0Wi1-Eg@mail.gmail.com>
 <CAGudoHHo4sLNpoVw-WTGVCc-gL0xguYWfUWfV1CSsQo6-bGnFg@mail.gmail.com> <2220e327-5587-4d3c-917d-d0a2728a0f73@amd.com>
In-Reply-To: <2220e327-5587-4d3c-917d-d0a2728a0f73@amd.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 2 Dec 2024 11:08:47 +0100
Message-ID: <CAGudoHFSUoLXjEh8bvULXe2bysiW8S6yTcpgzCAgkuPuJxD6_Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Large folios in block buffered IO path
To: Bharata B Rao <bharata@amd.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nikunj@amd.com, 
	willy@infradead.org, vbabka@suse.cz, david@redhat.com, 
	akpm@linux-foundation.org, yuzhao@google.com, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, joshdon@google.com, 
	clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 10:37=E2=80=AFAM Bharata B Rao <bharata@amd.com> wro=
te:
>
> On 28-Nov-24 10:01 AM, Mateusz Guzik wrote:
>
> > WIlly mentioned the folio wait queue hash table could be grown, you
> > can find it in mm/filemap.c:
> >    1062 #define PAGE_WAIT_TABLE_BITS 8
> >    1063 #define PAGE_WAIT_TABLE_SIZE (1 << PAGE_WAIT_TABLE_BITS)
> >    1064 static wait_queue_head_t folio_wait_table[PAGE_WAIT_TABLE_SIZE]
> > __cacheline_aligned;
> >    1065
> >    1066 static wait_queue_head_t *folio_waitqueue(struct folio *folio)
> >    1067 {
> >    1068 =E2=94=82       return &folio_wait_table[hash_ptr(folio, PAGE_W=
AIT_TABLE_BITS)];
> >    1069 }
> >
> > Can you collect off cpu time? offcputime-bpfcc -K > /tmp/out
>
> Flamegraph for "perf record --off-cpu -F 99 -a -g --all-kernel
> --kernel-callchains -- sleep 120" is attached.
>
> Off-cpu samples were collected for 120s at around 45th minute run of the
> FIO benchmark that actually runs for 1hr. This run was with kernel that
> had your inode_lock fix but no changes to PAGE_WAIT_TABLE_BITS.
>
> Hopefully this captures the representative sample of the scalability
> issue with folio lock.
>

I'm not familiar with the off-cpu option, fwiw does not look like any
of that time got graphed. The thing that I know to work is
offcputime-bpfcc.

Regardless, per your own graph over half the *on* cpu  time is spent
spinning on the folio hash table locks.

If bumping the size does not resolve the problem, the most likely
contention shifts again to something else. So what we need is some
profiling data from that state.

--=20
Mateusz Guzik <mjguzik gmail.com>

