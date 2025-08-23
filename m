Return-Path: <linux-fsdevel+bounces-58874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 461F4B326D4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 06:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C471C88050
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 04:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4920212549;
	Sat, 23 Aug 2025 04:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbdGFDAZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BB7846F;
	Sat, 23 Aug 2025 04:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755923743; cv=none; b=J8dO6sbFctNmzSb+4CwGWLW8knuIQAdlUnW53zv2X4rIyxf+QgLmByjteSzFsUhWX7bJ//M/IhfJOVxjJnz46KuHPsGT0bVNuUOAaRiXlMP2Funi9B9YEx73kZUG3kAkfYaNbVSDkxDlM+5AfHRJEOGifymMfKlazHNp1uxJwnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755923743; c=relaxed/simple;
	bh=vLOUpS0c+16o4GUVU4uMlndQ3RpzzA05XwYUjRsY5sU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=QHw/t+yRD+y3wLVtasRh8ycoj+KRWGmPPQ3Eyej0XMThVmJNLmpKPzDHVEH1LJcH6Y+l8puIziDSWAQ7/d2K3xTrsEvJAVKJrbPoR+3wJGEVBFgF52+vOqZOBNOzQYvKxGsWS1at20JG2Yrmp/kW62b7BY49gEEuq1zqGrw1MwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbdGFDAZ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7704799d798so78982b3a.3;
        Fri, 22 Aug 2025 21:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755923741; x=1756528541; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fs7g43mtKgqeCDpzvEATjIv8lEXb98nEFJtwUsNE7jk=;
        b=FbdGFDAZw97Yr0OCODZNzmYcAvwx5UQ9dFrw/l2NyqJ6NJgbs032TzI0xtQkIwlSyp
         8HM9D39UZCpIzMXYdX3BRG+KATSPKC7UOUVTZFZMokdqenDdxzkrCVwpiuS/YxMgJJVS
         xuiizAZsGFBvrmRvWzRQCz398G2qt9vvszoNBb1o8qI0e/V35lts3aMkbrF9zLofU24W
         fjkDXxqIDKZtd+txJaOBkRmP8aXR056ll0jitgTNEDnzmpJQcJ85Qw0cX2y4orlhlX+E
         rTfghwrxxO+ia3LwGiGJpYost0bvoF96Ehj9qJUrjBzqJIC30Naexfk9xS9O+jPeT0Ox
         t/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755923741; x=1756528541;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fs7g43mtKgqeCDpzvEATjIv8lEXb98nEFJtwUsNE7jk=;
        b=M+NSex3WmPM63wNJwBIj4FXwRtRhEtLEisyt5xlqSLpUkQRyOG5hQgI17nvDF2LpA5
         JtJuEb+f1ULAfa4c/dnSAvQ5cb1hdGIadb0nG7wnc5KczeCBYPc5xJCG+c3JEVg8dfko
         8Hsiec16WC9PfxWEN2jRi+pnm4HZwT8HqSftQeL37D8ELwz7gFPX/a8dfKmKz6X7gute
         lgns16AzSjbJatOXBBJXiXES6yTYSzsg/Mse0dVW7urdgiWATRsgspzQXqh9u85sIx4u
         INBVvZsa1e3XQUdd1Mv0h+5OJoFxco73uaeWwwn4OAiC//2e2mTAZ99waTW57gMq24ns
         943w==
X-Forwarded-Encrypted: i=1; AJvYcCUDZTux8z5Q2kHLDYhSJ7vTDo0JdleyytQxFGddjUF868KGujCg+/eVjUHkGaudAL2OjwrlnVXE4RTc@vger.kernel.org, AJvYcCUf2qzj42VYj/82odqE0CEh7erRrn+SrWYNqKIjZBEmWtYFIGW6reSE0vm7th4MHszAdICtv7WoN9GtFw==@vger.kernel.org, AJvYcCW2l4XBK+WlXCkCq21YsBX21y+Fe8He4Zx10Pxa1lbH2AjV3OC7IiS9o1qmLCH5FFD1qQHsAeRdJEIqFAGxSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHgbQ0IgFOcxKY5hjrAW3mNqupZ9oM7ZGRDFsDIe8Jfu18OOne
	JmkPVxXGHif/InErFOjf7NkJaVEkOmB4i+7E6Pmt/TxVQ4RndOVnhfDYOdkTxA==
X-Gm-Gg: ASbGncvbqwFXvt8/EMwkn/NNWDku+Mt7Ry5rQaqsp9jERmscpE8MLH1cakXMtQsVw9o
	byPOGckidg34HIU943Z8o8Zs4V+lXzLXB/WM2fwJWtcmkDEpE5yyhTs2siCXPhC7IVBnnd0JhEm
	q1rzSM6fUNqYzlcix6p9OpaJuGsZg2snHmGy1/qWRGG/e/bhZ/GeHOy7jqzTbiGFRpmq1MdjNCF
	aguw2OWiSyhnD4MW67OsPk4myA557IcV5amiZARTmbpqkTleDLydK6XwhCK1tJ67ijTFdosqcsa
	5GaP5bQpLlXnPDQaUHfqeSo8nIR0E9B1Ukv+Zj86A0lW1ptf82pc8Zc9f1zm9XyENXGxkrmAiWo
	vE2VtQQBu+MHY+Q==
X-Google-Smtp-Source: AGHT+IGpH0q4iRdnF9pk8qFZlEdCpSCnZAqzLaID28PfTP5JpU+Y8WR0+8Qq9D0HksmyTFsSLhRSGA==
X-Received: by 2002:a05:6a20:3ca5:b0:220:78b9:f849 with SMTP id adf61e73a8af0-24340b89e47mr8804182637.24.1755923741069;
        Fri, 22 Aug 2025 21:35:41 -0700 (PDT)
Received: from dw-tp ([171.76.85.35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb9d226sm1228525a12.41.2025.08.22.21.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 21:35:40 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Fengnan Chang <changfengnan@bytedance.com>, brauner@kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] iomap: allow iomap using the per-cpu bio cache
In-Reply-To: <aKif_644529sRXhN@casper.infradead.org>
Date: Sat, 23 Aug 2025 09:45:58 +0530
Message-ID: <874ityad1d.fsf@gmail.com>
References: <20250822082606.66375-1-changfengnan@bytedance.com> <20250822150550.GP7942@frogsfrogsfrogs> <aKiP966iRv5gEBwm@casper.infradead.org> <877byv9w6z.fsf@gmail.com> <aKif_644529sRXhN@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Aug 22, 2025 at 09:37:32PM +0530, Ritesh Harjani wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> > On Fri, Aug 22, 2025 at 08:05:50AM -0700, Darrick J. Wong wrote:
>> >> Is there a reason /not/ to use the per-cpu bio cache unconditionally?
>> >
>> > AIUI it's not safe because completions might happen on a different CPU
>> > from the submission.
>> 
>> At max the bio de-queued from cpu X can be returned to cpu Y cache, this
>> shouldn't be unsafe right? e.g. bio_put_percpu_cache(). 
>> Not optimal for performance though.
>> 
>> Also even for io-uring the IRQ completions (non-polling requests) can
>> get routed to a different cpu then the submitting cpu, correct?
>> Then the completions (bio completion processing) are handled via IPIs on
>> the submtting cpu or based on the cache topology, right?
>> 
>> > At least, there's nowhere that sets REQ_ALLOC_CACHE unconditionally.
>> >
>> > This could do with some better documentation ..
>> 
>> Agreed. Looking at the history this got added for polling mode first but
>> later got enabled for even irq driven io-uring rw requests [1]. So it
>> make sense to understand if this can be added unconditionally for DIO
>> requests or not.
>
> So why does the flag now exist at all?  Why not use the cache
> unconditionally?

I am hoping the author of this patch or folks with io-uring expertise
(which added the per-cpu bio cache in the first place) could answer
this better. i.e. 

Now that per-cpu bio cache is being used by io-uring rw requests for
both polled and non-polled I/O. Does that mean, we can kill
IOCB_ALLOC_CACHE check from iomap dio path completely and use per-cpu
bio cache unconditionally by passing REQ_ALLOC_CACHE flag?  That means
all DIO requests via iomap can now use this per-cpu bio cache and not
just the one initiated via io-uring path.

Or are there still restrictions in using this per-cpu bio cache, which
limits it to be only used via io-uring path? If yes, what are they? And
can this be documented somewhere?

-ritesh


