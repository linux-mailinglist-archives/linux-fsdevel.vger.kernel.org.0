Return-Path: <linux-fsdevel+bounces-19458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 378018C5942
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 18:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9BA1C21E2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 16:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0872017F36C;
	Tue, 14 May 2024 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y1SrnPTH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6721F17EBB3
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702678; cv=none; b=dFT2XLJjVTl0PCjKE1gHHoYAbZzBBDTWMoy357pXxZImHp+eIl8JpAUlhIDu7GNzdVZfJgG6VfLa8E7mumCxoLJURqmZApBWKA9cdOk1YunLQ3tFklkQv7yD8sYW0tEpDwTD/uLeEqW65sjS+dUG/QMJUZVF5vkvyLzOZ9Q7Ps8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702678; c=relaxed/simple;
	bh=rhheKrC5UqwGfzlHmmzvDF6q/Ca5re/Q43B50P5u1WA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCnlzyqwEkcqcqpTprK5dJZtXLE+iQfwhJwZGXpVFiYoMEGmR/cnxDrhXlUKJaNpwpg25Ib7sxxrWdbN/sFVbjE4t11lv3DRbexe0hng39wx9TRZ0fSNVn0SWF1Ui0ds2W8nVPBItUEVz/7g5MSOVqam3wzuVubFaMAafBWCTTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y1SrnPTH; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59cf8140d0so34796266b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 09:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715702674; x=1716307474; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qi9NdQSYjzvcYW1qTjhLADvpJxotWIcZlhNFh3W+v4A=;
        b=Y1SrnPTHceqOa5/5UZ1BZfYe3/38wmVC2i2ZjxzB4b2RqJfWUlSyYatHIAk91bfNYD
         JYoru11TEk1wSm3w1jx90Q/rAyXqDOdjAEwBAf4x68D/DUMUydKaQZUVh4L51ZQTREQ3
         L9krat8MuS7PqQvOIldMTtKCYMxfu+oLfU4bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715702674; x=1716307474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qi9NdQSYjzvcYW1qTjhLADvpJxotWIcZlhNFh3W+v4A=;
        b=UYuWxnbZ9rA861H3CIODhiMbaGJDYcojvwtKLmYDEn5zSemBQGG5FeEX0HTFNqGfxR
         zjVUQxZBoqtBvwbNdnFvJBOvfB/G3MB2zBoOPUtffhqRVIXhWrY3qlg2Xa234mYfF4R5
         xSBqqJS1y9crEnj/YA3n3y7HSVY9zonxPAITTh1OW+nV1DL3LdXppwr+5Tri2t8lSdeT
         7+XDXz1cLf2AUl/MbbVofGKNbfGndWV0DjtpQpUpFOFzPr/g2uWyX6ce8PRTIy/GgmBk
         YsA/fC4uwBMUESS9/FJwXm/hAjUpLt0ZGguKDF3u2PpWc4HEezSUnb5KPv+VJmOOchNt
         ruWA==
X-Forwarded-Encrypted: i=1; AJvYcCUiz0AgNPGni6uJr2eOElD+4NDrC0QrIX3y5tilcyrPC/0/OXguRHyFwjqx0cdOp/n6PKCvVbxZV9ASi1QHAhfQLA7PK4bQTNVJAgeBZw==
X-Gm-Message-State: AOJu0Yyps/ohJ4JS0v9ayNURjf07WYd8MUXi4EdRYwetJFqEuKRN5Nnk
	KP7vG1okYslsMnmRj41MPW+nyz2GUf9atoVNF7eId03m+UFp3tG/MVAavnoanN7UpydAVvLXXqO
	ne2MJQQ==
X-Google-Smtp-Source: AGHT+IF0hwpGVBuf3mQVs8I5pVTJicBKAHXZXxRhWF5qHHGapiMY80RU+pVzXpLyF2l3R8x9sAU+WQ==
X-Received: by 2002:a17:906:3618:b0:a59:9c14:a774 with SMTP id a640c23a62f3a-a5a2d680d90mr863778766b.74.1715702674568;
        Tue, 14 May 2024 09:04:34 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17a06sm728482166b.219.2024.05.14.09.04.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 09:04:33 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5a89787ea4so38909866b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 09:04:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXiIrQdc1WKRecEjmLxV2fRMLgCSW/sZQYwccl5yDPzLdagbwX/CELvt8JPY5ulvTgKgVKaR710V68mMiWoMC73CGS/UZq9QYt5c+wLCg==
X-Received: by 2002:a17:906:81cf:b0:a59:a7b7:2b8e with SMTP id
 a640c23a62f3a-a5a2d5853b3mr843134566b.29.1715702673387; Tue, 14 May 2024
 09:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb>
 <Zds8T9O4AYAmdS9d@casper.infradead.org> <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
 <Zduto30LUEqIHg4h@casper.infradead.org> <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home> <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
 <CAHk-=wjOogaW0yLoUqQ0WfQ=etPA4cOFLy56VYCnHVU_DOMLrg@mail.gmail.com> <ZkNQiWpTOZDMp3kS@bombadil.infradead.org>
In-Reply-To: <ZkNQiWpTOZDMp3kS@bombadil.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 09:04:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whob6O3m8KUJjnGzFDVHwb_PLueMP-YMtX1PxE9awTxcw@mail.gmail.com>
Message-ID: <CAHk-=whob6O3m8KUJjnGzFDVHwb_PLueMP-YMtX1PxE9awTxcw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Al Viro <viro@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Matthew Wilcox <willy@infradead.org>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, 
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 04:52, Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Feb 26, 2024 at 02:46:56PM -0800, Linus Torvalds wrote:
> > I really haven't tested this AT ALL. I'm much too scared. But I don't
> > actually hate how the code looks nearly as much as I *thought* I'd
> > hate it.
>
> Thanks for this, obviously those interested in this will have to test
> this and fix the below issues. I've tested for regressions just against
> xfs on 4k reflink profile and detected only two failures, generic/095
> fails with a failure rate of about 1/2 or so:
>
>   * generic/095
>   * generic/741

Funky.

I do *not* see how those can fail due to the change, but that's the
point of testing.

Somebody who knows those two tests better, and figures out what the
difference is would have to get involved.

One different thing that my fast-read case does is that it does *NOT*
do the crazy dcache coherency thing that the "full" case does, ie the

                writably_mapped = mapping_writably_mapped(mapping);
                ...
                        /*
                         * If users can be writing to this folio using arbitrary
                         * virtual addresses, take care of potential aliasing
                         * before reading the folio on the kernel side.
                         */
                        if (writably_mapped)
                                flush_dcache_folio(folio);

but that shouldn't matter on any sane architecture. Sadly, even arm64
counts as "insane" here, because it does the I$ sync using
flush_dcache_folio().

I can't tell what architecture the testing was done on, but I assume
it was x86, and I assume the above detail is _not_ the cause.

               Linus

