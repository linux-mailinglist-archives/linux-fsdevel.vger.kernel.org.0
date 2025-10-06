Return-Path: <linux-fsdevel+bounces-63504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A58B5BBE8D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 17:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99A618981BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 15:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD81F2D8DBD;
	Mon,  6 Oct 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ecV6VXC+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF822D879B
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759765878; cv=none; b=stMIS4a6yr52LD/kce7WtvP+oljAHdOgVGg6nj43SfuJti0enW/Q6gV6C09q0hvFP2Qybdm4rzNecvFkkZ2GZL8+c3Jw31C0AXCKRhmwCC6CcP82fC3n5uTMXhb5O7KAvOI/Gs7bxKbh0SYVoH0znBzagXD+r4+ynBRdIlX7RZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759765878; c=relaxed/simple;
	bh=eB34U1ni3DWg+YCHHtomG5k29cqI5tvTHpZiu6jVJDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZ5aqcLpOOFYytilspglNr0JAnO9Lg0xW0q/K2bGwdOspmULZF0DFF2f7UYRDhnIoOWNZHA7mAmpXGRZYim46OPczuptcwSt+fr6Iuwt8MnCoA6UOavTYmaFApzhslMHRlDloVH/+b0fmMvSjH3SMoocMGZKL60DmNmCRKJFpTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ecV6VXC+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3ee18913c0so796979466b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Oct 2025 08:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759765873; x=1760370673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sMoomnihbSwUNorrh09eu+PuWRV7U6fAeqINMFRwMBE=;
        b=ecV6VXC+Kfnr22zSM2KDsWtBNy/7p3NpQrRH+s6/5CYgqtyYgR7OqvdCvOAdPRZT6f
         c76EIYlV/IhFX2Nw1FfOTXt/3ortDsMD9wjTUY/OnxZ32ssSfw1AvWJmyDkzmP8hvJEe
         BD1RbmNF3tExosUGbhJMTHVAYyBw5GqAYb9YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759765873; x=1760370673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMoomnihbSwUNorrh09eu+PuWRV7U6fAeqINMFRwMBE=;
        b=S3tIF/SSQYgkq42YlCI6t8E4HrandafGTiKVFWRkhgDq98Odjv4xEX120Ac7ef+vU4
         aSpAp+/zNw0FsyyUllG2J08+2AwZ9/VDG8eSDRduDnIwW5YNBr9y/hICELANzNxaZ5LI
         qQ+VU6T94xwlWXMQkG8R6njug7XKdZXlJ+s0JwT6XOCKKGuV0qRnZSkk/ZGsdWmO5ocL
         IWCqscbj4LsfDMUiS6p5u2PPSDQysarOpsKjRAPz0brsdFzrJ4VjVvJCFklAb6IB4XGW
         CZKNh2GW5wR0XT2N2q70ssMp9DOyR8CzJR/Fr1ihIz18fafIqODJ1JxpxPk0sjuhEMD5
         fvaA==
X-Forwarded-Encrypted: i=1; AJvYcCXoiB5v2LwQWpfy8yonY/kXikSSsCD14c3pwNcmml4nJlI7j1PDoVgPK3ZNAojm6a2w60+rPbQPJINGmP35@vger.kernel.org
X-Gm-Message-State: AOJu0YyIB4+e6gs8QxWEmsmku4us1XR5GxDMPZFVe3Mo1tuaEFXNxieh
	5HaE//bAtwVgKHrQMH+PCzi3+Nb3pm4TCeD/37EhqZD3jLKWuF8AVz/Cc57qgkTv/MsAqguQssF
	z83G4Rio=
X-Gm-Gg: ASbGnctfk8p+kCkPsDZY/tWcdvkgad7/BgFbDJNv2tUsuVkqwl6EzuVsK0/+bUWIuK3
	aMC0fObvuvoI862tRrMDSS4amdSHxrNlXTLSZNX+0taNmGCT3jwQxWJfqvDwwqP6UJe8ZSjnshN
	XcDxoCKDC7RmFgfGb4T/umappeqiSvHb4v0emhKM7o3XgfmSx9198awNAz9nS3RVI43pPY7xTQT
	QlIxlbx84uhVMmzTph9izuqz6g7mCpUgXWUxNUVZRs/SEMb0DQYqs58ET9TPMqTmjCauNCLZvo9
	uiGGEpMOYON/G8kmdw0bSOUGkZYucA+rjaQcj6SgmxxuVbkK2eiJcqSVRNTS8gvTaNNxBxAjQVv
	Q2B/PnpGhZn8+Tf48oSOmfcHuUzqmHrV3W7IKAKBbpm7PLBj7ZNiC7nvk86L3UgorWYxKRr4MCY
	KDlXcStbpvD7oPZ/F/+eJjvMkaotp5PHU=
X-Google-Smtp-Source: AGHT+IEGovermZQm8jJ0UVmO5KYf4LzLYCOGwHISrNLCxQlLrk9UFfEaqroWE5SruE1uzGe2AkPiXg==
X-Received: by 2002:a17:907:944d:b0:b46:897b:d759 with SMTP id a640c23a62f3a-b49c3350408mr1685471166b.40.1759765873353;
        Mon, 06 Oct 2025 08:51:13 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b4f1d1sm1159726266b.71.2025.10.06.08.51.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 08:51:12 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso9290179a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Oct 2025 08:51:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQ92RF7Vn2+dpDeRvfzuvgi7fDbPsL6u78suDu8dQ66+CJ2st3zPei0sY4Z7rBB89YEluoJstSNzj2mUDV@vger.kernel.org
X-Received: by 2002:a17:907:3ea1:b0:b04:563f:e120 with SMTP id
 a640c23a62f3a-b49c3d71bbfmr1705204466b.53.1759765872029; Mon, 06 Oct 2025
 08:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wj00-nGmXEkxY=-=Z_qP6kiGUziSFvxHJ9N-cLWry5zpA@mail.gmail.com>
 <flg637pjmcnxqpgmsgo5yvikwznak2rl4il2srddcui2564br5@zmpwmxibahw2>
 <CAHk-=wgy=oOSu+A3cMfVhBK66zdFsstDV3cgVO-=RF4cJ2bZ+A@mail.gmail.com>
 <CAHk-=whThZaXqDdum21SEWXjKQXmBcFN8E5zStX8W-EMEhAFdQ@mail.gmail.com>
 <a3nryktlvr6raisphhw56mdkvff6zr5athu2bsyiotrtkjchf3@z6rdwygtybft>
 <CAHk-=wg-eq7s8UMogFCS8OJQt9hwajwKP6kzW88avbx+4JXhcA@mail.gmail.com> <4bjh23pk56gtnhutt4i46magq74zx3nlkuo4ym2tkn54rv4gjl@rhxb6t6ncewp>
In-Reply-To: <4bjh23pk56gtnhutt4i46magq74zx3nlkuo4ym2tkn54rv4gjl@rhxb6t6ncewp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Oct 2025 08:50:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4Cma0HL2DVLWRrvte5NDpcb2A6VZNwUc0riBr2=7TXw@mail.gmail.com>
X-Gm-Features: AS18NWDwictm2mx4ddQEHSIlRgCT4GuM73mcD9dZ1kxxXns9_MP73AOoOkea4BU
Message-ID: <CAHk-=wi4Cma0HL2DVLWRrvte5NDpcb2A6VZNwUc0riBr2=7TXw@mail.gmail.com>
Subject: Re: Optimizing small reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 04:45, Kiryl Shutsemau <kirill@shutemov.name> wrote:
>
> Below is my take on this. Lightly tested.

Thanks.

That looked even simpler than what I thought it would be, although I
worry a bit about the effect on page_cache_delete() now being much
more expensive with that spinlock.

And the spinlock actually looks unnecessary, since page_cache_delete()
already relies on being serialized by holding the i_pages lock.

So I think you can just change the seqcount_spinlock_t to a plain
seqcount_t with no locking at all, and document that external locking.

>  - Do we want a bounded retry on read_seqcount_retry()?
>    Maybe upto 3 iterations?

No., I don't think it ever triggers, and I really like how this looks.

And I'd go even further, and change that first

        seq = read_seqcount_begin(&mapping->i_pages_delete_seqcnt);

into a

        if (!raw_seqcount_try_begin(&mapping->i_pages_delete_seqcnt);
                return 0;

so that you don't even wait for any existing case.

That you could even do *outside* the RCU section, but I'm not sure
that buys us anything.

*If* somebody ever hits it we can revisit, but I really think the
whole point of this fast-path is to just deal with the common case
quickly.

There are going to be other things that are much more common and much
more realistic, like "this is the first read, so I need to set the
accessed bit".

>  - HIGHMEM support is trivial with memcpy_from_file_folio();

Good call. I didn't even want to think about it, and obviously never did.

>  - I opted for late partial read check. It would be nice allow to read
>    across PAGE_SIZE boundary as long as it is in the same folio

Sure,

When I wrote that patch, I actually worried more about the negative
overhead of it not hitting at all, so I tried very hard to minimize
the cases where we look up a folio speculatively only to then decide
we can't use it.

But as long as that

        if (iov_iter_count(iter) <= sizeof(area)) {

is there to protect the really basic rule, I guess it's not a huge deal.

>  - Move i_size check after uptodate check. It seems to be required
>    according to the comment in filemap_read(). But I cannot say I
>    understand i_size implications here.

I forget too, and it might be voodoo programming.

>  - Size of area is 256 bytes. I wounder if we want to get the fast read
>    to work on full page chunks. Can we dedicate a page per CPU for this?
>    I expect it to cover substantially more cases.

I guess a percpu page would be good, but I really liked using the
buffer we already ended up having for that page array.

Maybe worth playing around with.

> Any comments are welcome.

See above: the only think I think you should change - at least for a
first version - is to not even do the spinlock and just rely on the
locks we already hold in the removal path. That page_cache_delete()
already requires locks for the

        mapping->nrpages -= nr;

logic later (and for other reasons anyway).

And, obviously, this needs testing. I've never seen an issue with my
non-sequence case, so I think a lot of xfstests...

                     Linus

