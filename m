Return-Path: <linux-fsdevel+bounces-12739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D49F866791
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 02:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C272D1F219A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 01:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62A0D50F;
	Mon, 26 Feb 2024 01:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J3LO/BcL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29463CA4E
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708911156; cv=none; b=X9Jsk5LRd7dp1Mb313ipwg2RBspTDNHBBZHMtfbcBiX1JtQDfl/rbzA+B+C5ICR3nXkT7iiqgRwIafjvGN8hEsc/s4J3MwMQdxiE8vKARNAY3/cEhT0xWdJWjnurm7B29dwSByG5L0y5lTZ5mUzDAkmlMwxD1nPYlbPG+onFMfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708911156; c=relaxed/simple;
	bh=X7KasYH+7XIJhoYk3gmCk1AohkHtIL0VTSzGtGTsxTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvXkd3KqFq6W7caHecWbPmeYRV91tAduCO17SxImIdS4bsYarPm7EhjjSu/630jV3pRqmCwltuW8BQv2aXEeGtbyIeHCOGgrQwKuz3M5lVP1i1fREjtmM8zyCMJiTsIKy/fTY1Wh6ChIw//Sv3D/Wg/rQueeyHQOMj9DzAFPVuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J3LO/BcL; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so38537881fa.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 17:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708911152; x=1709515952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LfKdOZfWTbECMYEk3NyBPikBNb6uqGRUe057sifTtwc=;
        b=J3LO/BcLYEd0XyLUhAJjrCFS7+TwamMQaw/aZ2KcPtVdf/ynXdb/Omiacc/s7Oc6Kt
         xArfJvMXx/NHPto5r47QPuNvzFdRattCZMIF4aVXfTFkKJw28klF6Eg2fsuttUqMuXdZ
         oHQMCJcwNo6I6DMqH0lZ+gsUxIHGX9deOrQEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708911152; x=1709515952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfKdOZfWTbECMYEk3NyBPikBNb6uqGRUe057sifTtwc=;
        b=savmNn8/f6qjGcCw+k8VvKxvJk+I3fjTLh6DBtrgxNkE0MAEaFtCWb6hmARKZTxwja
         oprIEdNwV6kSWk36jLbhTTuXAwnq7C7Ir6Gr7jkIgMOltNACFV21cbvXwk+R4oaB4DPX
         0WtObtpEVH1zkGG7Lq5BOyVsIue+C+pLHoomRtOKGMUOaxZW9SB2xqEJ3HmRUAyjFkbp
         yifNR+HuRh/P8F8gTa3AwJ8b1JlMg5nzKV0v60wMYFbQY8hFR5jsgrWgPijASB8Gwmi9
         E1MqPPIJ0Fmj1jwF2iJwpYDF8mWRuY6/qR6J+1/w4GLh9vI/WRhINpP16Cgp1Tvoaf/W
         cQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOWmAd1F2jMTCfODBCYKGmQZG/E0bVXM58NEyqqLIeioAXTolG1sh6WqQBu9fPSPDYvY2IduWxlkD9hbOAuSELCrGuf+xabpx7SR/f5A==
X-Gm-Message-State: AOJu0YycKr7e19JKBhrLGXBPk8VTdnT64WCWQ7TRGZKIB37s0FfoDq/n
	wZUcHgDy+vlQV/082SmSEgvWTY4WmHlcIiIXg1lohXx5YKUPK2esXbZ9aD21oMa38bVjbG2hFiI
	zaxqerA==
X-Google-Smtp-Source: AGHT+IF6IroTX/EOexKQbq3Ty3a7eVQAMrP7Xqr4aYa4p0T/jH0TNgW3pl1IQ30pBMFjE857zUgFqQ==
X-Received: by 2002:a2e:9556:0:b0:2d2:313c:3c0 with SMTP id t22-20020a2e9556000000b002d2313c03c0mr2861227ljh.27.1708911152023;
        Sun, 25 Feb 2024 17:32:32 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id k3-20020aa7c043000000b0055fe5a611f2sm1821980edo.20.2024.02.25.17.32.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 17:32:31 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso317667266b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 17:32:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXH48zuzMFfSzi4YiyE6hcvLIbIEqKWQlWuFRzXht34OZhLQ0TZppCPTuh7QUtv9XYcsi5PHHmbVQDOkzYFA9PML0PbBAql2o0vlt94JA==
X-Received: by 2002:a17:906:3c4d:b0:a3f:ab4d:f7e3 with SMTP id
 i13-20020a1709063c4d00b00a3fab4df7e3mr3051531ejg.0.1708911150763; Sun, 25 Feb
 2024 17:32:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org> <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
 <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb>
 <Zds8T9O4AYAmdS9d@casper.infradead.org> <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
 <Zduto30LUEqIHg4h@casper.infradead.org> <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
In-Reply-To: <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 25 Feb 2024 17:32:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
Message-ID: <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Feb 2024 at 17:03, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> We could satisfy the posix atomic writes rule by just having a properly
> vectorized buffered write path, no need for the inode lock - it really
> should just be extending writes that have to hit the inode lock, same as
> O_DIRECT.
>
> (whenever people bring up range locks, I keep trying to tell them - we
> already have that in the form of the folio lock, if you'd just use it
> properly...)

Sadly, that is *technically* not proper.

IOW, I actually agree with you that the folio lock is sufficient, and
several filesystems do too.

BUT.

Technically, the POSIX requirements are that the atomicity of writes
are "all or nothing" being visible, and so ext4, for example, will
have the whole write operation inside the inode_lock.

Note that this is not some kind of locking requirement coming from
some ext4 locking rule: it only does this for the buffered path, the
DIO path happily says "if I'm not extending the size of the inode,
I'll just take the lock for shared access".

So this is literally only about buffered writes, and the atomicity
within a folio is already dealt with with the folio lock (ext4 uses
"generic_perform_write()" to do the actual writing part, which does
*not* care about that lock).

IOW, the whole inode lock is pointless for any real uses, but exists
because _technically_ POSIX does not allow reads to see partial writes
(ie if you see *one* page change, you have to see all of them change,
so per-folio locking is not sufficient - you technically need to lock
the whole operations against readers too, not just writers).

Of course, in real life absolutely nobody cares, and you can see
partial writes in many other ways, so this is really a completely
"because of paper standards" serialization.

Several other filesystems do *not* do that serialization, and as
mentioned, the DIO paths also just said "hey, this isn't a normal
write, so we'll ignore POSIX because technically we can".

But to take a different example, ext2 just calls
generic_file_write_iter() *without* taking the inode lock, and does
locking one page at a time. As far as I know, nobody ever really
complained.

(It's not just ext2. It's all the old filesystems: anything that uses
generic_file_write_iter() without doing inode_lock/unlock around it,
which is actually most of them).

And I find that silly locking rule a bit offensive, because it
literally serializes accesses that shouldn't be serialized.

IOW, it *should* be a "you do stupid things, you get what you
deserve". Instead, it's a "everybody pays the price for giving stupid
things a pointless semantic guarantee".

Afaik, it has a purely historical reason for it - all the original
UNIX read/write calls used a per-inode lock, so they were all
serialized whether you liked it or not.

Oh well. It's a pet peeve of mine.

              Linus

