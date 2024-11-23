Return-Path: <linux-fsdevel+bounces-35637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CE39D6930
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 14:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D805A281EE9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 13:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AB0185B72;
	Sat, 23 Nov 2024 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="aXvwhWgi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B168A183CBE
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Nov 2024 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732367378; cv=none; b=H5ApJfkHF38R8OkphpsJbMCBsE5BbmBMHUgjIzL6pS5hqOJXaAZ3iJ7lPZhBIKEhpo8PzFmeKi6f0MPn8KcsZ3AnDxiJlhaI7kCu7E9s37TDq+x1+6Jgdi+RCUbuPsKyRruOtUezIvDo+II+s3+9FJBww+YHGUHbieNqVWFVWqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732367378; c=relaxed/simple;
	bh=cFHTZsyHjeipydo3w6s8MY+BuZDLN/iw6QtX3hfM0QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPyzUxM23X4cmiK2Ag0U5zuJeFlU8pJNEhP1xWV5NyBq1zUDyvvg9pLydXzTBZ6ebWbkGXWvRqjXmR+R/3aEQxLDXors5xC7/jlngyGTxceXYolbHZXc86CO9USxcMsK2RBMEAl7TmizJrXlLXwFsoM4Sl6Dmv+wgGuRf/8Info=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=aXvwhWgi; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4609e784352so20240621cf.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Nov 2024 05:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1732367375; x=1732972175; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nwjn8ShKFOcX5C5BheoU0O4GenhfSSBb9I7QpKsITtA=;
        b=aXvwhWgixfTGlK4ZmFvKLO9dJADNb+QXeIsqrUmaZVY7UfkRu/BctSFgJ8+aJ3AZBc
         khOlRdnmppoODc3ITO/xtAqsKaTODSkHFl4ksn8XBkwsWrh/lSUe2xkfQQmtSGhorFxx
         tZ3GYb3Nfiu/JEuZHCzXAAvPQj1M5xPbH71vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732367375; x=1732972175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nwjn8ShKFOcX5C5BheoU0O4GenhfSSBb9I7QpKsITtA=;
        b=rIyJMbaZUQoYUle9Oy9792NEa9rgQkpR0EUvfYJIA3Dc87s34oNGwKtaP2yypcxm7F
         NTcej42WAI2+aciAXNFPU0hb4MF2y8I0j/K7iDzb/sXzz5fqfqk5NFW6S6OOeymRkQPb
         anE6/3tfKGgTGqJ6VlaD7rMpGTNturyf77fs9sFDEudKHuIc4iZEaPUo96IplrplBEgl
         5D9wLOQqdwjL2MyhGOMTTB2DBKWhX7ztd4DUTn6R0K+UOeF6vjGG93EE2VyiFq3XUbLH
         I6Pj2B6HB29ST/PjmxShw6wyn9U5mr9s1EoWD7L3vDh1s3VcAPdT7APMPzTWuUHoR8ZR
         N8QA==
X-Forwarded-Encrypted: i=1; AJvYcCXEJfZq7vyTBftWchwfs7uO0t+wXN+tekfEq4XSnJiyb0o3FsrVUYLQHXKJpSvHNlXxJo1APBlGaJiGDjUW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/1Vx+1syr5GxXkCPIrqmbjin6w91qaKnObCPHB14F2GkV/OkI
	yiGb3RCxmil/CXofA5Wdlew9idqxVS2HgXy0eqPmdUmnS0CA5IBMcly0RqJ6aDTIJ37gaeQ+snz
	GHO0EpkhhsSbQiutNycGp6BwgrVjQhODJKQqvAQ==
X-Gm-Gg: ASbGnctjSgZgkqhPNXhjNfco1C8+l/W+zVDHq5INCRw9AUrE9y9K89lQsaeP6f8VMdI
	iKTn6sehLnj0jCY/S4P0NwrcO+jN+dwP27w==
X-Google-Smtp-Source: AGHT+IHvnC/a2xW3Q3klkTHdR9rS8s5K/zPgxzJX6JSdpaRAc97xP/gUZymSqhT5s2mkoav2T/UwWjVigUoY/FdMnZU=
X-Received: by 2002:ac8:5815:0:b0:463:1677:c09 with SMTP id
 d75a77b69052e-4653d5cd228mr78272881cf.23.1732367375658; Sat, 23 Nov 2024
 05:09:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-fuse-uring-for-6-10-rfc4-v6-0-28e6cdd0e914@ddn.com>
 <20241122-fuse-uring-for-6-10-rfc4-v6-6-28e6cdd0e914@ddn.com>
 <CAJfpegtih77CpuSQAOkUaKRMPj44ua65+_MUMa3LqgYjLFofqg@mail.gmail.com> <e1f3cbf0-eedf-41a9-9689-5eda56e06216@fastmail.fm>
In-Reply-To: <e1f3cbf0-eedf-41a9-9689-5eda56e06216@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 23 Nov 2024 14:09:25 +0100
Message-ID: <CAJfpegt=CxhYSyxWVBAWnf2S926Vj+1yEF_GPkOJYRMN_XbkSQ@mail.gmail.com>
Subject: Re: [PATCH RFC v6 06/16] fuse: {uring} Handle SQEs - register commands
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Amir Goldstein <amir73il@gmail.com>, Ming Lei <tom.leiming@gmail.com>, David Wei <dw@davidwei.uk>, 
	bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Nov 2024 at 13:42, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 11/23/24 10:52, Miklos Szeredi wrote:
> > On Fri, 22 Nov 2024 at 00:44, Bernd Schubert <bschubert@ddn.com> wrote:
> >
> >> +static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
> >> +{
> >> +       struct fuse_ring *ring = NULL;
> >> +       size_t nr_queues = num_possible_cpus();
> >> +       struct fuse_ring *res = NULL;
> >> +
> >> +       ring = kzalloc(sizeof(*fc->ring) +
> >> +                              nr_queues * sizeof(struct fuse_ring_queue),
> >
> > Left over from a previous version?
>
> Why? This struct holds all the queues? We could also put into fc, but
> it would take additional memory, even if uring is not used.

But fuse_ring_queue is allocated on demand in
fuse_uring_create_queue().  Where is this space actually gets used?

> there you really need a ring state, because access is outside of lists.
> Unless you want to iterate over the lists, if the the entry is still
> in there. Please see the discussion with Joanne in RFC v5.
> I have also added in v6 15/16 comments about non-list access.

Okay, let that be then.

> Even though libfuse sends the SQEs before
> setting up /dev/fuse threads, handling the SQEs takes longer.
> So what happens is that while IORING_OP_URING_CMD/FUSE_URING_REQ_FETCH
> are coming in, FUSE_INIT reply gets through. In userspace we do not
> know at all, when these SQEs are registered, because we don't get
> a reply. Even worse, we don't even know if io-uring works at all and
> cannot adjust number of /dev/fuse handling threads. Here setup with
> ioctls had a clear advantage - there was a clear reply.

Server could negotiate fuse uring availability in INIT, which is how
all other feature negotiations work.

> The other issue is, that we will probably first need handle FUSE_INIT
> in userspace before sending SQEs at all, in order to know the payload
> buffer size.

Yeah.

Thanks,
Miklos

