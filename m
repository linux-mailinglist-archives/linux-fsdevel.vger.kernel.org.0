Return-Path: <linux-fsdevel+bounces-73922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 481E2D248FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 13:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4B103064A8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 12:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768B839901F;
	Thu, 15 Jan 2026 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="csraE9eB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39600395DA7
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480663; cv=none; b=ZMQ+pHMeMoMfqzQtsqyxRrYWRNYi/NGllv/jViWmVYRi4J2FRQII8TqpCSWuU3g237tT/kH6ayskSI39L6iaLIr4qG50AM3GP4IxHWuJMLO5pq0WVNAWvMjPYxYr6a3VsbSM2rmjhJuVbONPA/759cJUCfVD9uW4BnSqZcg0wyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480663; c=relaxed/simple;
	bh=VbUD7iSwLItxmTv8JnrqB8kYFgiuEOIQdz7wHmYhh9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUwPJp+VS9gnTtllQInmFTI9cE/nytNJZBjAbHFEqVOWdTLhfDWzU7fIs6FLWgagccFIjtXGDlzRQAEMv428aVDu4WIUgSg2dy2+gMTUhadhMOYDDnoc1/43VFPnmm9zaB+TQ4c8rxzZ4XWfTvm/U7CMm9mpnljTckvG4FBXSGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=csraE9eB; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4eda26a04bfso10131561cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 04:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1768480659; x=1769085459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aCCEknSUq5djGK8nutG9sVaUqWsyGM7tM3hgaDDU3oQ=;
        b=csraE9eBsWFBjQN5wTL8f+ffkLOCdgc2ULSCqer1LPLThcGmv90rTCCbqe6EPQ6uEG
         qSpEqCXbG38MHC6qcEOq26HCkX+2vfL9V/dZRFfa5iWVrw0MAGwD0cRCFsyh3Nas0M7j
         JD1Y9z9iDj0RO4wBYvUHTh5jZ8o7xhW5jBl54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768480659; x=1769085459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCCEknSUq5djGK8nutG9sVaUqWsyGM7tM3hgaDDU3oQ=;
        b=K9+ST54RUvADNvtz2AJpLP36xa0yZjuUnoB3Lrgl5FB4pr37QXM8M2jN019L4ABwvT
         BSEdh9Va9nD/9ysqVVH6ZVSogCw5AxxeapcwYtTkw+B9iPBURpFL3sMx7eMPbuTolvd5
         ToqjhlgYurlfwWf0hsx4o/qfLl7yDIDo5p6Qc9WqxZ0Xw8YzevOSTC74pKAPSYy5ZCMb
         kHK8L01Ia1RIFhSbBMKLajPbvpK+YxknIhavMnI9d7zyPEVZ1eS3QmqoGwbTSSnyaDe0
         qSBYdvsba9ZeZRYk7UBPzQmapq5+Ydzu8LXa/Cbq2PNeiZ6HJQLnJxqm4PWawF+uL5gC
         MZuA==
X-Gm-Message-State: AOJu0YytJrts1JhBktSOmSjgEiu2Ey4A8mlwZlEZE41JnTpXFDM+sE8S
	RGfBV1sQ0kIy9GCHcrJO60BZpy+dWL4tf0A0jHrDcujisx417CuHftvkjQdv/sqmr8NBjcMS7Es
	xTzsaQFpUw3YoA0wQhyF4S+5dzvRtS0Leu2BVcljjvg==
X-Gm-Gg: AY/fxX79StitC3uxEjwf9MVJZqlIkKPWKQXiVgUuOrKQv4QPKvn/sumuGl/afVeesIb
	KhmR9vFwWrQfZ5k4KbbMWTPQBIWiywqHTz2s7tFcJjmDYAptbhMniVlpvDvuEm+8C3QEEm3EIAf
	F8bxJyNDD9ii7On1W5ggzW7rJPUtsOoohizyP26dQoDp1JX+63iKpzrE6/XlbjdXv+S2MpK2xHM
	OXzJ3NUpoTi414EP2X8pZetIM23/YxuTVolYXD7YURaZT+LotE10jtrgATwltqA3jHmE+4=
X-Received: by 2002:a05:622a:5214:b0:4ee:4126:661c with SMTP id
 d75a77b69052e-5014a9cde40mr55088821cf.81.1768480658870; Thu, 15 Jan 2026
 04:37:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <195c9525-281c-4302-9549-f3d9259416c6@kernel.dk>
In-Reply-To: <195c9525-281c-4302-9549-f3d9259416c6@kernel.dk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 15 Jan 2026 13:37:27 +0100
X-Gm-Features: AZwV_Qgcjv1xM10RZ0dO-sBjd-ry8oclSloOksGU4028zhD7Cyk2LNV8KvQjUz8
Message-ID: <CAJfpegvp0Gt_5j05LZ+yFBLsOEaPru2xvOf4b3TkZW1BgzWGcg@mail.gmail.com>
Subject: Re: [PATCH] fuse: use private naming for fuse hash size
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Jan 2026 at 13:25, Jens Axboe <axboe@kernel.dk> wrote:
>
> With a mix of include dependencies, the compiler warns that:
>
> fs/fuse/dir.c:35:9: warning: ?HASH_BITS? redefined
>    35 | #define HASH_BITS       5
>       |         ^~~~~~~~~
> In file included from ./include/linux/io_uring_types.h:5,
>                  from ./include/linux/bpf.h:34,
>                  from ./include/linux/security.h:35,
>                  from ./include/linux/fs_context.h:14,
>                  from fs/fuse/dir.c:13:
> ./include/linux/hashtable.h:28:9: note: this is the location of the previous definition
>    28 | #define HASH_BITS(name) ilog2(HASH_SIZE(name))
>       |         ^~~~~~~~~
> fs/fuse/dir.c:36:9: warning: ?HASH_SIZE? redefined
>    36 | #define HASH_SIZE       (1 << HASH_BITS)
>       |         ^~~~~~~~~
> ./include/linux/hashtable.h:27:9: note: this is the location of the previous definition
>    27 | #define HASH_SIZE(name) (ARRAY_SIZE(name))
>       |         ^~~~~~~~~
>
> Hence rename the HASH_SIZE/HASH_BITS in fuse, by prefixing them with
> FUSE_ instead.
>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Thanks:

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Christian, can you please pick this into vfs.fixes?

Thanks,
Miklos

