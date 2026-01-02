Return-Path: <linux-fsdevel+bounces-72325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBBACEF042
	for <lists+linux-fsdevel@lfdr.de>; Fri, 02 Jan 2026 18:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 514F2300A9DC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jan 2026 17:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8911D5CD9;
	Fri,  2 Jan 2026 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDQJtJs9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A167220F2A
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jan 2026 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767373212; cv=none; b=OQe/ZIbpRTUbqFUeWJptI1oOVH08KGFH/fMfmHhbSZSB0Ht5TJb77FS2oh0mDbNRjEDag+nsd4uFwpVKDyhbohzKCKkbGqf6jrLGJAofBNRRglMr8MqAUHQ5QSZnvUG+46RczcELK8f8t+wljpa4HB3rTqjO1ZpNOVNWAgv0rzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767373212; c=relaxed/simple;
	bh=271HDQg7KAMmLVb4GHnWSPuJJvZm638/dCDPMmQguBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+BrGQVTzA8RGkyuA7pSZnGcveloWhHYhOm5TUZkLAz/tsTYeX2uLA7U+D3F1ZKrG+4iXfednN0acHuoThcW+cVWatb3gTKLTU0fbVAtnwhwFA2ASDNqBL7yxlvnMCTb0QFTe6YddahgxEFhb8Pwhh7+Bv5ftOsLdxhkQa6xgM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDQJtJs9; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4f4c89f8cc6so104149021cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jan 2026 09:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767373210; x=1767978010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPORR//yLhKtURxEdxNYpWsQMSHp0+QYYBgi9vT3P7E=;
        b=PDQJtJs9Dv6tdlkSlxULlaAxMn2qBRXaDAIWKk7LaYlb7hks5+tyuhG3Q0ah4YsNLz
         kc4fkrKK+bdmFncYzLW9b5M3aqTxFwZrh+g8qfMdKjdInDywAbFO0CuSi7gna+lH7ZqK
         0xIhof4QWk2W/UGnvm6nXerKyg8G4TwgR+dGLp4AEhAPSt7nbxsoJxtamtAr83QDzz19
         RRiWvzGJmRbS/I5uUSkBmVyuAOEGzXxINL/F7PG5/Qoy7p2HOoSRN74sG1nMZBsDPc95
         FP4HHoaYlQOMHn9/HT/J0Ai1x40CVJZvK8365XxPgwrNE6QZrFW/Dait1oUNEsn9m9AD
         KdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767373210; x=1767978010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zPORR//yLhKtURxEdxNYpWsQMSHp0+QYYBgi9vT3P7E=;
        b=hbw4e2OwRCe07l0yy6VMFTHgIaghwsxWEqfBaX6zqngSMfKu5DLR5WJTU7e0jj1ZEs
         2Pr70A7OCeImWJ5pMCKkgV8QGPcPyGJbwEmQq+nByDl8/KYavEDRkZ/L87f8XNsLczd5
         U8OtSrotWTeKYUdkPJhBRICizZOQLwRRROUd6ybS1N6hQ7ExkjPF88jrbCmqocuCtRYA
         rOORVIUquKPHK159CRvKt2tV0M34a5LDWD6PO7rXUr+IAbxHQgH3R1Rwlem3fK6YKge5
         k84lI40wj0LW709Q+JwVP8+NC1xhNc6t9ilusyCh+Y47rG0iu59ohIcL21gDYITcxKtg
         k8GA==
X-Gm-Message-State: AOJu0YxSVTFVnGvr+YCAdPP12uaFZxx6J74OkjknQDUGY5SJpZXuCXAB
	R5HDlGmG082illhIOyORlG3Ry5xTfAbOg8hs9K8Vjr2YKB0GSCJkS4OGn9331mOmc1/FcRuYRka
	m2+arHn6wC9a3ploPGBva3PCXQvrAdquX9jNLpS0=
X-Gm-Gg: AY/fxX7qOHEJxwQKZwVtc+0XcWB10ARinY0V3R0NiB9/zgUIdJyWL1J9mD3jz+qKqYe
	nUhvuxIj2xQ1UKNPLPZHs63CbP1TzZcVIMJkx/EvrVrC3LZ8yZ8reHbTqMv7IX/li62mjIyNYPt
	OCVcoOx71aGSTxfchryQ/7vfRDemOB0c33VluRN2Iocld+PTXrjKTQEbzlUMiyNDBMaZPZgvufK
	KJR1u8dieTPlQMQt492kcOl07kOMwZZI/lo2OpysRQOY0c7bG48/lZXtHR7eGXZ/r55Vg==
X-Google-Smtp-Source: AGHT+IElOqesN4GTeANM4Uuikc4nhQZO5D4daSEat10ExUO3JvYo7EwyinyU7BMgyVdOq6EoSzR/0ZNqThChc1s3yDs=
X-Received: by 2002:a05:622a:5a15:b0:4ed:3e3e:a287 with SMTP id
 d75a77b69052e-4f4abcf3e29mr602170141cf.24.1767373209698; Fri, 02 Jan 2026
 09:00:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGmFzSc=YbHdaFbGQOrs_E4-MBXrM7QwXZ0DuKAGW1Ers2q=Rg@mail.gmail.com>
 <CAJnrk1ZOYnXpY0qf3yU41gQUHjyHOdBhAdyRPt_kaBmhvjr_9g@mail.gmail.com>
 <CAGmFzSdQ2Js5xUjb-s2vQkNB75Y5poOr_kTf4_8wqzeSgA6mJg@mail.gmail.com>
 <CAJnrk1Z=kqQc5SM2Z1ObgEMeCttT8J83LjeX19Ysc1jCjvA79A@mail.gmail.com> <CAGmFzSe3P3=daObU5tOWxzTQ3jgo_-XTsGE3UN5Z19djhYwhfg@mail.gmail.com>
In-Reply-To: <CAGmFzSe3P3=daObU5tOWxzTQ3jgo_-XTsGE3UN5Z19djhYwhfg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 2 Jan 2026 08:59:58 -0800
X-Gm-Features: AQt7F2pz7NHotNcBll7SsN98gNCcFC7i0fuqmfZdIaOrPy3ZuFVm1Lfhth2E_5I
Message-ID: <CAJnrk1a1aT77GugkAVtUixypPpAwx7vUd92cMd3XWHgmHXjYCA@mail.gmail.com>
Subject: Re: feedback: fuse/io-uring: add kernel-managed buffer rings and zero-copy
To: Gang He <dchg2000@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 10:55=E2=80=AFPM Gang He <dchg2000@gmail.com> wrote=
:
>
> Hi Joanne,
>
> I used the latest kernel(v6.19-rc2) + your 25 patches, removed the
> original liburing2,  installed your liburing(kmbuf branch).
> Then, built you libfuse code(zero_copy branch).
> I ran the mount commands like "./passthrough_hp --nopassthrough -o
> io_uring -o io_uring_bufring -o io_uring_zero_copy /mnt/xfs/
> /mnt/fusemnt/"
> or "./passthrough_hp -o io_uring -o io_uring_bufring -o
> io_uring_zero_copy /mnt/xfs/ /mnt/fusemnt/".
>
> But, I encountered a hang problem when I tried to list /mnt directory.
> it looks there are still some problems for this feature, or I missed
> any important steps?

Hi Gang,

Are you passing in a queue depth? If you pass in your queue depth
through -o (eg " -o io_uring_q_depth=3D8"), does that work for you now?
On my end, I'm running " sudo ~/libfuse/build/example/passthrough_hp
~/src ~/mounts/tmp --nopassthrough -o io_uring  -o io_uring_bufring -o
io_uring_zero_copy -o io_uring_q_depth=3D8" on my VM and I'm not seeing
the hang. I'm running on top of commit 40fbbd64bba6 (in the io-uring
tree) with the 25 patches applied.

Thanks,
Joanne

