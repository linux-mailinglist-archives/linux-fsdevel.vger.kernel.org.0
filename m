Return-Path: <linux-fsdevel+bounces-70743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AB8CA5C1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 01:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF176316E35A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 00:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33BE1E376C;
	Fri,  5 Dec 2025 00:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="34DqmuTQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C818D1448E0
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 00:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764895137; cv=none; b=Ehq0+WwCmBjhSAta7Hi46bDA/gPyMdmg/J/FayA3J1xLY6kx2KTV/YhyOzPXIiNpyH1kLD+q4gvHZL9SJ8qjxOOFcUyK69UKmk/Mq2AdKLKbtdxVYw9krS6f2yAyPz84Q9Fc3Hf2rpPuqBYimqxrFAi890LKkLYsVbkn6e8BgzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764895137; c=relaxed/simple;
	bh=jRGGucjhuVnCsCWM106TPSms/6ZdG6m5JJbmww1ag3Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lxHwTdNjcgihsyR5xJUj0Fu7OzWKUTpIM0CIIrLDZijaaypsVSqZgQ7fHCW5W8YZIqxyJguyegOmnkrF9BoAg5VChtQaFmvNNTEO4lL0qnICRPV8rpLPjOgG1HGE8WjIVSbudqO/E489C6kocHRmxdIz9uj9Ei1GVOmy+FegPnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=34DqmuTQ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2958c80fcabso35511575ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 16:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764895135; x=1765499935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jRGGucjhuVnCsCWM106TPSms/6ZdG6m5JJbmww1ag3Y=;
        b=34DqmuTQAOYTwBw4QGQbiZFFYau25ZdxDBIuUKPDl29jr5DbkOdflQD5MBNBv7VJlh
         LBkUde0mBfwk1WIY3gP+ApUPEcyhQrk4rakNiMVY2tvSIc1LxNv336I8s4V9iHKsh7x6
         c6gzxPs7zfmCkdVejY5cQwgI4RECFXVMCaUUF1zTX0qlkOT9Di3UCnBcecgwbRkbMQFj
         TzwFNn+xYmBoH8lcbExrgfW7U3t7N6OtRpFW/fZMRuTNavsSoVcRSXdTt8SA+kZy+t6J
         bjmZGF+UZ0oVwx1eK69MA0YVIQyF/YECJPqlU8RCi3a/Jpj/F09+SMYzubJ9zcYX5JAC
         Ch/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764895135; x=1765499935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRGGucjhuVnCsCWM106TPSms/6ZdG6m5JJbmww1ag3Y=;
        b=X9M9VV8MwhfTHihvEPbSvSZfmi3HnRRK808de9QB6ocbV7+u3IFJvKr5FnoyRE8jnZ
         5aPZ+SzcNLhVoBui/WWLtt8rPB2fFn6ZsEctYMq20i8Ze+m9olkcx8FfqNl0jeJw38UX
         CP294/YX0NPeGpXYbjqMH5EWg+Xj/iOWcV4/8aFK1q2HcgSmvb42XY+t8uifOLs2YoZq
         Xzs43Oki2S0479KWgaXelyCzxALfVQJ5wJCVYCC/ng6x/99KeZkTulQnHNZANPuiwufl
         Cudn41rWqpKAvXNFR+d6bSREe28igBm7ACtcQpZ2ImUuNyp7mP9tDSnKgyzOmrzJV/Ir
         2mCg==
X-Forwarded-Encrypted: i=1; AJvYcCVybkJINt11iwqAcmBwEPD9LnFCg4z42zUeNqv6bN1X2WRVJTgXom7nX8bMrgPMRaycp3g0fo9F4eASIX4H@vger.kernel.org
X-Gm-Message-State: AOJu0YyTxMpIBssBp4qm+YvfCOcoA8t6hAZIJMrCRCtCTxE0uuLAb3sb
	A4VcHnCYbHn6c/rd3BkDTDDYIt8k6co79hIEuxgcaKkX2tu7JxCek2+s35/6RqR5DfeJ0LSeqz8
	ZvtN5bPvWF0XwSQFx4WT7R0/v/A==
X-Google-Smtp-Source: AGHT+IEI+4QWSaT65yNp/2TgxcZCaFaqgv6I/9Ib9/x1qCnTFXLErIvauCddCu2q9NT77PNc/mruEXOJV7Fmqs3GVw==
X-Received: from pgjr9.prod.google.com ([2002:a63:ec49:0:b0:bac:a20:5f05])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3387:b0:342:352c:77e5 with SMTP id adf61e73a8af0-363f5ea890bmr9279671637.54.1764895135064;
 Thu, 04 Dec 2025 16:38:55 -0800 (PST)
Date: Thu, 04 Dec 2025 16:38:53 -0800
In-Reply-To: <diqztsysb4zc.fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251117224701.1279139-1-ackerleytng@google.com>
 <aRuuRGxw2vuXcVv6@casper.infradead.org> <diqztsysb4zc.fsf@google.com>
Message-ID: <diqz8qfh69uq.fsf@google.com>
Subject: Re: [RFC PATCH 0/4] Extend xas_split* to support splitting
 arbitrarily large entries
From: Ackerley Tng <ackerleytng@google.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com, 
	michael.roth@amd.com, vannapurve@google.com
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

> Matthew Wilcox <willy@infradead.org> writes:
>
>> On Mon, Nov 17, 2025 at 02:46:57PM -0800, Ackerley Tng wrote:
>>> guest_memfd is planning to store huge pages in the filemap, and
>>> guest_memfd's use of huge pages involves splitting of huge pages into
>>> individual pages. Splitting of huge pages also involves splitting of
>>> the filemap entries for the pages being split.
>
>>
>> Hm, I'm not most concerned about the number of nodes you're allocating.
>
> Thanks for reminding me, I left this out of the original message.
>
> Splitting the xarray entry for a 1G folio (in a shift-18 node for
> order=18 on x86), assuming XA_CHUNK_SHIFT is 6, would involve
>
> + shift-18 node (the original node will be reused - no new allocations)
> + shift-12 node: 1 node allocated
> + shift-6 node : 64 nodes allocated
> + shift-0 node : 64 * 64 = 4096 nodes allocated
>
> This brings the total number of allocated nodes to 4161 nodes. struct
> xa_node is 576 bytes, so that's 2396736 bytes or 2.28 MB, so splitting a
> 1G folio to 4K pages costs ~2.5 MB just in filemap (XArray) entry
> splitting. The other large memory cost would be from undoing HVO for the
> HugeTLB folio.
>

At the guest_memfd biweekly call this morning, we touched on this topic
again. David pointed out that the ~2MB overhead to store a 1G folio in
the filemap seems a little high.

IIUC the above is correct, so even if we put aside splitting, without
multi-index XArrays, storing a 1G folio in the filemap would incur this
number of nodes in overheads. (Hence multi-index XArrays are great :))

>> I'm most concerned that, once we have memdescs, splitting a 1GB page
>> into 512 * 512 4kB pages is going to involve allocating about 20MB
>> of memory (80 bytes * 512 * 512).
>
> I definitely need to catch up on memdescs. What's the best place for me
> to learn/get an overview of how memdescs will describe memory/replace
> struct folios?
>
> I think there might be a better way to solve the original problem of
> usage tracking with memdesc support, but this was intended to make
> progress before memdescs.
>
>> Is this necessary to do all at once?
>
> The plan for guest_memfd was to first split from 1G to 4K, then optimize
> on that by splitting in stages, from 1G to 2M as much as possible, then
> to 4K only for the page ranges that the guest shared with the host.

David asked if splitting from 1G to 2M would remove the need for this
extension patch series. On the call, I wrongly agreed - looking at the
code again, even though the existing code kind of takes input for the
target order of the split though xas, it actually still does not split
to the requested order.

I think some workarounds could be possible, but for the introduction of
guest_memfd HugeTLB with folio restructuring, taking a dependency on
non-uniform splits (splitting 1G to 511 2M folios and 512 4K folios) is
significant complexity for a single series. It is significant because in
addition to having to deal with non-uniform splits of the folios, we'd
also have to deal with non-uniform HugeTLB vmemmap optimization.

Hence I'm hoping that I could get help reviewing these changes, so that
guest_memfd HugeTLB with non-uniform splits could be handled in a later
stage as an optimization. Besides, David says generalizing this could
help unblock other things (I forgot the detail, maybe David can chime in
here) :)

Thanks!

