Return-Path: <linux-fsdevel+bounces-44665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D224CA6B2E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 03:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5472B8804A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 02:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D042F1E32B7;
	Fri, 21 Mar 2025 02:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtJ9l5E/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624731DFD86;
	Fri, 21 Mar 2025 02:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742523981; cv=none; b=Ti/grBoOKJm88/DewMoI0K8atdgYjGKEozKVfrswQj7E1+qFxkmkT/7nb/rxkfyhu6ijLOAftjDZWNsAVCROpgWd1kirlsjM+AjZo/QhIRnnKtlOxgYPlI8zxJrs3RhV6OccZjU+Ht/5AmXnNDg3fwU9ZMzP7KjT3pcgpvF20xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742523981; c=relaxed/simple;
	bh=kt6DEIy5XfQ+fDd75wWZx2oy3Ba8UMBH4YasfJH1fgw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ACdlMd/e6N31/tqy6xqHQgk6bQG/vm152sscmT9zaN5AcOxy8oI/ZsMVq5tO3vaEK0DUV8YwwSP8jpGj3InSI/p/0CkKX5fKG7YLZrZBElR6Ax1alMBkQEboRuQg9Ri74Z+BBc/7KRAAlWYb/h56lyFCNysAU8B3Ld6F4a+BUHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtJ9l5E/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-226185948ffso29257815ad.0;
        Thu, 20 Mar 2025 19:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742523976; x=1743128776; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GXCXUHTUv85OtHijOMda+VCkM60vFQI9b1pD1y/4h8s=;
        b=OtJ9l5E/zslcY/VN0CpsSAlPBPkGHrs3FAiVmr2IpxKH1NJuHT690SpwxYg9jzLUe5
         EVPbEidSryDF13w9i1VSqNZhi6LNI9+OFy4+q3ZcefUzaw3QhdjqOEa2GA+Qz3SEHPYQ
         5kkPmZFskAvsgjzKmNiXJtAcz9Mebag+pPJsvCE8CjBJgk0457JE6Wt+58X8jw6qpi0u
         fBglJ7hMQSadCoF7J3IN50uCAshuLkOWqfjZhznLLQtFn8OxX2tNmlXrxMNujehWdRkJ
         Pcc9hI0i0ngrvZxm82j/dnsnJgNMmLN3KcD6XNEJwb81IN6BZZ5oylHladIugGM/5a8F
         tuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742523976; x=1743128776;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GXCXUHTUv85OtHijOMda+VCkM60vFQI9b1pD1y/4h8s=;
        b=MO1CM/31g9W3xoaj8Z41Aibq5QlvBHtw82eTjGMYdklLSX2G+VWZ5XHTeeOzZy8G02
         OS3LuwyOjJOL5qCUuHvxmVOynS/kDIrpmrKvrxJ/r/Kcnxxib/lX3Llz63qLfcsMS0Ju
         r3qldaRtK828+2ujEKnYMeNmca2+znHQI4CdZ28Ko04+jK53Gslmhn7cA+NzmLmaNuQ3
         nKSACs0nmFavFFVidEAhrRhlgyJt5vVZhq3tXKe1vBiG7Gr7LJdgcOLfNCJi4VVSTzel
         skg2UhDdi4C/2LmRVqAHFRYgPoE2nywamCN9AwGVXrUwKTa3Cv+/Esm8P+TBfwDBb3Jp
         VYtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyDOHzE6U1PNFL730YdmNbcxHXFTEKIQ77x2shzEZcBU3M7GRaUfW98gRcAiT0jf9VZjTrpGFxY6CmqbUB9g==@vger.kernel.org, AJvYcCV2NjVhU1DA6CciA4LDv6/I7oF3fsH8G60MBsSey3lyKY7y60c6/c5vO9fFt19GVnNeNZ14MsFQakH6Ng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yys9bWXnyj927RMyX7o3SUjuY/SniI1cFuuXjzO6htgazO7oqS7
	RSSBc0NrmkS6ze+Mj4f9pSY4wofGN3EPxANk9ajeEBznw6futeyu
X-Gm-Gg: ASbGncvkO+7WcJY0QjLAhJ0+K5VGxIxmsxSr4E78RT4pB7HspBn+GNcq7sgH1UMdPvQ
	SLLZYAXqKAR1yMYV5fsm3gG84WQ9j0+UUexodHC2uunq8Kl0cyEEeFwm+C8H3oGAV7m9r/u0OKU
	ylIp3VNaLovUnNeKQIb66TH/7aXfMNlvVMDF8UPOlb1QcRS8VgY9+iKEj8iWODQ9BBQcZbY3fz3
	iwYCnZ4GDgQ4J10S+aEMOwumW5m02PvvKovdtIhRQkP1Y3zLmr+CduEG1b7SlNmzSnOtKnfLfqM
	1X+Mgxkb8U0N5fluwuJX8GzNlfC20EdyEKOqZg==
X-Google-Smtp-Source: AGHT+IFqmFLsmg9/ahn7SjRWI3Rn/0OLHyEDGSMmYz4To8UsuGaDaTjz2ptscspGRtgdnCPweTQAog==
X-Received: by 2002:a17:902:f64b:b0:220:c4e8:3b9f with SMTP id d9443c01a7336-22780bb1312mr26955965ad.0.1742523976363;
        Thu, 20 Mar 2025 19:26:16 -0700 (PDT)
Received: from dw-tp ([171.76.82.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811da561sm5313945ad.185.2025.03.20.19.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 19:26:15 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org, david@fromorbit.com, leon@kernel.org, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk, joro@8bytes.org, brauner@kernel.org, hare@suse.de, willy@infradead.org, john.g.garry@oracle.com, p.raghav@samsung.com, gost.dev@samsung.com, da.gomez@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
In-Reply-To: <20250320213034.GG2803730@frogsfrogsfrogs>
Date: Fri, 21 Mar 2025 07:43:09 +0530
Message-ID: <87jz8jrv0q.fsf@gmail.com>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org> <87o6xvsfp7.fsf@gmail.com> <20250320213034.GG2803730@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Fri, Mar 21, 2025 at 12:16:28AM +0530, Ritesh Harjani wrote:
>> Luis Chamberlain <mcgrof@kernel.org> writes:
>> 
>> > We've been constrained to a max single 512 KiB IO for a while now on x86_64.
>> > This is due to the number of DMA segments and the segment size. With LBS the
>> > segments can be much bigger without using huge pages, and so on a 64 KiB
>> > block size filesystem you can now see 2 MiB IOs when using buffered IO.
>> > But direct IO is still crippled, because allocations are from anonymous
>> > memory, and unless you are using mTHP you won't get large folios. mTHP
>> > is also non-deterministic, and so you end up in a worse situation for
>> > direct IO if you want to rely on large folios, as you may *sometimes*
>> > end up with large folios and sometimes you might not. IO patterns can
>> > therefore be erratic.
>> >
>> > As I just posted in a simple RFC [0], I believe the two step DMA API
>> > helps resolve this.  Provided we move the block integrity stuff to the
>> > new DMA API as well, the only patches really needed to support larger
>> > IOs for direct IO for NVMe are:
>> >
>> >   iomap: use BLK_MAX_BLOCK_SIZE for the iomap zero page
>> >   blkdev: lift BLK_MAX_BLOCK_SIZE to page cache limit
>> 
>> Maybe some naive questions, however I would like some help from people
>> who could confirm if my understanding here is correct or not.
>> 
>> Given that we now support large folios in buffered I/O directly on raw
>> block devices, applications must carefully serialize direct I/O and
>> buffered I/O operations on these devices, right?
>> 
>> IIUC. until now, mixing buffered I/O and direct I/O (for doing I/O on
>> /dev/xxx) on separate boundaries (blocksize == pagesize) worked fine,
>> since direct I/O would only invalidate its corresponding page in the
>> page cache. This assumes that both direct I/O and buffered I/O use the
>> same blocksize and pagesize (e.g. both using 4K or both using 64K).
>> However with large folios now introduced in the buffered I/O path for
>> block devices, direct I/O may end up invalidating an entire large folio,
>> which could span across a region where an ongoing direct I/O operation
>
> I don't understand the question.  Should this read  ^^^ "buffered"?

oops, yes.

> As in, directio submits its write bio, meanwhile another thread
> initiates a buffered write nearby, the write gets a 2MB folio, and
> then the post-write invalidation knocks down the entire large folio?
> Even though the two ranges written are (say) 256k apart?
>

Yes, Darrick. That is my question. 

i.e. w/o large folios in block devices one could do direct-io &
buffered-io in parallel even just next to each other (assuming 4k pagesize). 

           |4k-direct-io | 4k-buffered-io | 


However with large folios now supported in buffered-io path for block
devices, the application cannot submit such direct-io + buffered-io
pattern in parallel. Since direct-io can end up invalidating the folio
spanning over it's 4k range, on which buffered-io is in progress.

So now applications need to be careful to not submit any direct-io &
buffered-io in parallel with such above patterns on a raw block device,
correct? That is what I would like to confirm.

> --D
>
>> is taking place. That means, with large folio support in block devices,
>> application developers must now ensure that direct I/O and buffered I/O
>> operations on block devices are properly serialized, correct?
>> 
>> I was looking at posix page [1] and I don't think posix standard defines
>> the semantics for operations on block devices. So it is really upto the
>> individual OS implementation, correct? 
>> 
>> And IIUC, what Linux recommends is to never mix any kind of direct-io
>> and buffered-io when doing I/O on raw block devices, but I cannot find
>> this recommendation in any Documentation? So can someone please point me
>> one where we recommend this?

And this ^^^ 


-ritesh

>> 
>> [1]: https://pubs.opengroup.org/onlinepubs/9799919799/
>> 
>> 
>> -ritesh
>> 
>> >
>> > The other two nvme-pci patches in that series are to just help with
>> > experimentation now and they can be ignored.
>> >
>> > It does beg a few questions:
>> >
>> >  - How are we computing the new max single IO anyway? Are we really
>> >    bounded only by what devices support?
>> >  - Do we believe this is the step in the right direction?
>> >  - Is 2 MiB a sensible max block sector size limit for the next few years?
>> >  - What other considerations should we have?
>> >  - Do we want something more deterministic for large folios for direct IO?
>> >
>> > [0] https://lkml.kernel.org/r/20250320111328.2841690-1-mcgrof@kernel.org
>> >
>> >   Luis
>> 

