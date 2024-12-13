Return-Path: <linux-fsdevel+bounces-37284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 331049F0BAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 12:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D8B16443A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 11:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B171DE8BF;
	Fri, 13 Dec 2024 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="raWqUJ71"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1051C3C16
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090779; cv=none; b=R4XwEVPu8HfDLIassFG/21A5XeqLpbY9Sx5BEmt3TggNjkY2hg4xxIBjLShGUrZ80UXPPVjCf6xXeYRjmTqANcH4gydqb0gC2NXoPY8K6CisE8VNhvKGcwa+dnv6zvmZhvKsZLZVBHuQo04L8PDKA5TsAbvUgkoeVBk73ndeLY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090779; c=relaxed/simple;
	bh=IuyO9UmeO6Xi3zEqcw2K2v8KP/IGrYUcYTzQKSGxXVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIIw58ImbJNqORFC5NKIC0Ykn3+zgqj8dtlVXaoIQeubdnFpGzCCpJsoWtK2A0watWT/DdytlgxTt4JVwwBszGLp+eby3T9HtL6MO890ZFT1InzCDIG1yfBKKpqTpdp/hdlO1uwQIeBmuMW9T/K4udbPX6pIjWIR+1EElNogn/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=raWqUJ71; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4677675abd5so9158891cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 03:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1734090775; x=1734695575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+NGPcY3l/EZhVhhJTmICKQCQuQuwzjLgNykHYWpY1Hk=;
        b=raWqUJ718tk3lbSZlHjFWresVkA+qYyQMCr8rpT53GrOHl98Hh9ELNVArvtT3MoPfm
         kJXO6VH8AufwP+2k9j5+ha+JX2KnClV4HiV1tjMgLJnLT2ZsOGqTFko9TbS+KCu3qBFV
         K+RWabqOC4RX7XZ0Qa29B88vpN2EUSX5ITjUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734090775; x=1734695575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NGPcY3l/EZhVhhJTmICKQCQuQuwzjLgNykHYWpY1Hk=;
        b=uaPiq+LWCIcdIaPy5OTCbK+p+cN9Tsm89cx8KbMfV4v5E1Gq9Qa1F21W747WQRoQD+
         94KI/mM9AMrp0rZLIzsOI/72L9f/+cRINCrdJnmhk2FOignE/610XVlaPCv+Cxp6S8C5
         NVSJ+uq7Txe0bklB8jpMZojONc0gUei/dMdH/b3bPRsJGRAEpCwu0kVKPzXEF74D9GVa
         KaJWT2P38KTtW/6ygmn69/YbVJ9Cdspjf+Dx5HsdxPtPCD92cMuA0s1Yx0//5l5ZHEuk
         r86/1NebWnJJd2IHbxnBhvC5vo7U7DboG8s/Sn/3y2rYsfkg5/txVCVhqy4iupjvwvvh
         dXZg==
X-Gm-Message-State: AOJu0YxRio+4VFlEVtxSzRZ4A8nI9+YXTQN+ghufg968h2sTj7/yDxNY
	F9IHgUUCKrGwuE80o1gjw8asJbwPLML/VZuUjMZQEJq1vJehennIPEuuyyetJZNRivdiAwjsDGi
	bEehbLWB5EyqAak8K5Pqkx8tKox/I+jM+J3cPvQ==
X-Gm-Gg: ASbGncvPNxmjxQzvi6sGXCzaB6tCazr3Q7ZPcOcQvSZZNczDQAu7cRv6186rRxpx+vi
	7q8zWpqOF0rlIPz5hqZnzqoaeKMjjT9GANjw=
X-Google-Smtp-Source: AGHT+IHQ5iKsRm70cezL/Fapc8X/4zOvwPT2o0pnkVRtQOL+nnzFvte3TJb9Lo3rtEwSs+SIsbmqp3YdxP3rEhAknrE=
X-Received: by 2002:ac8:59d2:0:b0:467:65d4:7e07 with SMTP id
 d75a77b69052e-467a585b61emr32037931cf.53.1734090775425; Fri, 13 Dec 2024
 03:52:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122232359.429647-1-joannelkoong@gmail.com>
In-Reply-To: <20241122232359.429647-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 13 Dec 2024 12:52:44 +0100
Message-ID: <CAJfpegtSif7e=OrREJeVb_azg6+tRpuOPRQNMvQ9jLuXaTtxHw@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] fuse: remove temp page copies in writeback
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, bernd.schubert@fastmail.fm, 
	linux-mm@kvack.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Nov 2024 at 00:24, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> The purpose of this patchset is to help make writeback-cache write
> performance in FUSE filesystems as fast as possible.
>
> In the current FUSE writeback design (see commit 3be5a52b30aa
> ("fuse: support writable mmap"))), a temp page is allocated for every dirty
> page to be written back, the contents of the dirty page are copied over to the
> temp page, and the temp page gets handed to the server to write back. This is
> done so that writeback may be immediately cleared on the dirty page, and this
> in turn is done for two reasons:
> a) in order to mitigate the following deadlock scenario that may arise if
> reclaim waits on writeback on the dirty page to complete (more details can be
> found in this thread [1]):
> * single-threaded FUSE server is in the middle of handling a request
>   that needs a memory allocation
> * memory allocation triggers direct reclaim
> * direct reclaim waits on a folio under writeback
> * the FUSE server can't write back the folio since it's stuck in
>   direct reclaim
> b) in order to unblock internal (eg sync, page compaction) waits on writeback
> without needing the server to complete writing back to disk, which may take
> an indeterminate amount of time.
>
> Allocating and copying dirty pages to temp pages is the biggest performance
> bottleneck for FUSE writeback. This patchset aims to get rid of the temp page
> altogether (which will also allow us to get rid of the internal FUSE rb tree
> that is needed to keep track of writeback status on the temp pages).
> Benchmarks show approximately a 20% improvement in throughput for 4k
> block-size writes and a 45% improvement for 1M block-size writes.
>
> With removing the temp page, writeback state is now only cleared on the dirty
> page after the server has written it back to disk. This may take an
> indeterminate amount of time. As well, there is also the possibility of
> malicious or well-intentioned but buggy servers where writeback may in the
> worst case scenario, never complete. This means that any
> folio_wait_writeback() on a dirty page belonging to a FUSE filesystem needs to
> be carefully audited.
>
> In particular, these are the cases that need to be accounted for:
> * potentially deadlocking in reclaim, as mentioned above
> * potentially stalling sync(2)
> * potentially stalling page migration / compaction
>
> This patchset adds a new mapping flag, AS_WRITEBACK_INDETERMINATE, which
> filesystems may set on its inode mappings to indicate that writeback
> operations may take an indeterminate amount of time to complete. FUSE will set
> this flag on its mappings. This patchset adds checks to the critical parts of
> reclaim, sync, and page migration logic where writeback may be waited on.
>
> Please note the following:
> * For sync(2), waiting on writeback will be skipped for FUSE, but this has no
>   effect on existing behavior. Dirty FUSE pages are already not guaranteed to
>   be written to disk by the time sync(2) returns (eg writeback is cleared on
>   the dirty page but the server may not have written out the temp page to disk
>   yet). If the caller wishes to ensure the data has actually been synced to
>   disk, they should use fsync(2)/fdatasync(2) instead.
> * AS_WRITEBACK_INDETERMINATE does not indicate that the folios should never be
>   waited on when in writeback. There are some cases where the wait is
>   desirable. For example, for the sync_file_range() syscall, it is fine to
>   wait on the writeback since the caller passes in a fd for the operation.

Looks good, thanks.

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

I think this should go via the mm tree.

Thanks,
Miklos

