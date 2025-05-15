Return-Path: <linux-fsdevel+bounces-49104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E19CAB8115
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 10:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A03861A0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 08:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E902882CC;
	Thu, 15 May 2025 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CQUkciTF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC29E21773F
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298322; cv=none; b=RaHYw5XdQiyQ2CI7Up5wQSr2/GzJqw3yr77RbgQd6EMef3jN7hPFLzJfyKecVSNpVxONihupWdyiuI+LqzS4cJ24jSuyjvvXuHeiW+lSHNs1+/p2aXrtn+EisT+gn3/msKfTY/1jklWUotZjN40r9wFqlrrUCgJ80w+JESB1yAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298322; c=relaxed/simple;
	bh=0PdTTQT20quX7wXDMvkZ3ogq5W5Chx/Z0jUjneUvm90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSr9drRxvIc1gEgxw1iFaoNLd9YHzWbeeAzYyVzze452GocjxHKEttQ5JZ+2GpyKwxQHkAp9nCXOJQDN1fiYTeRc0nH+7HEAXHD6raTIl+8JOcwou28oV1LIX18GIqCMKHqhUQ0q8NcZ0PaQyVyEDKpGiZtOB33IwCk0vtMD+/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CQUkciTF; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4769b16d4fbso4030481cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 01:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747298318; x=1747903118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0PdTTQT20quX7wXDMvkZ3ogq5W5Chx/Z0jUjneUvm90=;
        b=CQUkciTFjip8UFUKKwsh0pLjC1S0UT4nY/j0UfGNYKthy/wwaOGXqVLP1qRuAu8Nj6
         iNZwMFxwSlkpMQLTt5cKTgweLY/1tV1TKxLqPRUkY0t2aiXT5Qn4Kn73eNVqXLE/n3JF
         HwyfpxtyyW0CqE5JvSifNGF0GwsZ0uUt7HY9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747298318; x=1747903118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0PdTTQT20quX7wXDMvkZ3ogq5W5Chx/Z0jUjneUvm90=;
        b=DsyBF6LDSY9eRGmcuAVySWPN5JBAeaCizvYhXv/gqx5J5Xj4LJ0E9tj2+V87Lv4FKw
         S6tT67FqEf98WRPKWR5fnjLY85axWuelS6MGswV3M7UEsAD7NF+vjC619iHV7sMi5GmD
         0BWYhvjFkwUvTb8SaPaaMZXCP5NJn/TknuiKfriWGXEIcf8kWtSxdN/hODksxIzPEvYH
         DHt8XwwxNvM+pSZi8KgkpusBApiqbkAoAo49rhlLYkMHbEUvv69To9ONH9pucVpTm+v7
         llOlj33ik9FVguyt6DPY5zNhX/fSTAQuhOv5aE+mKdbnGNZ25ULHi2e4VN9Ea4OkENtH
         QRjA==
X-Gm-Message-State: AOJu0YzaWcWcBFxEirI0Td/MINHncVMMk8tfg3aqatUHcM2DGwHAUk+l
	1J5OaS8VYT3C0PYMREpHi7A9XPaJS5vqKm7Yg/IpSbUY8x+/UO3oP4c0at30L4rEiQZrSc1BAkT
	QjsUJhwQaAn4kc8lJW36tQNYlH8AtoLiK54xhHA==
X-Gm-Gg: ASbGncsEaAsCJ2PTvlpfiCPz6m/Vtd+YdGqWlQPMhnvNKA74dhdgxCtJvykVKitqrDA
	CpP3BrsEzbCDuVqcCVk8S5qm3QpRtpdxOne+LRE4Suq+SXj0pG56W4qOkEUp8PeGRzZOVt00t/7
	QaVlI7Ce0U21dygYad+YKYbrDj1zfrcQk=
X-Google-Smtp-Source: AGHT+IH68fce/VSGVLlGZmWK50I7mS4fL4GcOIZJtNf7vOBRoAC+zaRourNzh19RRcVW6URcn7YD9tWDTMRTbkqEE8s=
X-Received: by 2002:a05:622a:248:b0:494:990f:9817 with SMTP id
 d75a77b69052e-494990fb3f1mr61498831cf.26.1747298318557; Thu, 15 May 2025
 01:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422235607.3652064-1-joannelkoong@gmail.com>
 <CAJfpegsc8OHkv8wQrHSxXE-5Tq8DMhNnGWVpSnpu5+z5PBghFA@mail.gmail.com>
 <CAJnrk1ZXBOzMB69vyhzpqZWdSmpSxRcJuirVBVmPd6ynemt_SQ@mail.gmail.com>
 <CAJfpegsqCHX759fh1TPfrDE9fu-vj+XWVxRK6kXQz5__60aU=w@mail.gmail.com>
 <CAJnrk1Yz84j4Wq_HBhaCC8EkuFcJhYhLznwm1UQuiVWpQF8vMQ@mail.gmail.com>
 <CAJfpegv+Bu02Q1zNiXmnaPy0f2GK1J_nDCks62fq_9Dn-Wrq4w@mail.gmail.com> <CAJnrk1aX=GO07XP_ExNxPRj=G8kQPL5DZeg_SYWocK5w0MstMQ@mail.gmail.com>
In-Reply-To: <CAJnrk1aX=GO07XP_ExNxPRj=G8kQPL5DZeg_SYWocK5w0MstMQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 15 May 2025 10:38:27 +0200
X-Gm-Features: AX0GCFvUpGn26R9Xi06NrqNcXENaH_igFmqTI1x40QkJpJ57YaaMa2GF7wPpuqs
Message-ID: <CAJfpegvayjALR9F2mYxPiM2JKuJuvDdzS3gH4WvV12AdM0vU7w@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: use splice for reading user pages on servers
 that enable it
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	jlayton@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 May 2025 at 01:17, Joanne Koong <joannelkoong@gmail.com> wrote:

> No. The server copies the buffer to another buffer (for later
> processing) so that the server can immediately reply to the request
> and not hold up work on that libfuse thread. Splice here helps because
> it gets rid of 1 copy, eg instead of copying the data to the libfuse
> buffer and then from libfuse buffer to this other buffer, we can now
> just do a read() on the file descriptor returned from splice into the
> other buffer.

Yeah, splice is neat, but that pesky thing about the buffer liftimes
makes it not all that desirable.

So I'm wondering if the planned zero copy uring api is perhaps a
better solution?

In theory there's nothing preventing us from doing it with the plain
/dev/fuse interface (i.e. read the FUSE_WRITE header and pass a
virtual offset to the libfuse write callback, which can read the
payload from the given offset), but perhaps the uring one is more
elegant.

Thanks,
Miklos

