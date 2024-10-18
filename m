Return-Path: <linux-fsdevel+bounces-32288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADAA9A3216
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 03:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFB61F22E0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 01:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2782126BFF;
	Fri, 18 Oct 2024 01:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkBwLtI6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4D126BED
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 01:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729215023; cv=none; b=RNLfPzIQrxe0DNUnO/eKuT6IioPpMm3EAF0sk8GEixpLSxxD/f1R5MLe2DpPTkpNcQc/wnYOU2czDcFXXlA0xc+BwEjlgYCkeWdeK66BtN+4zhf30ptO9CpHxuJOxxWMrBES87VL1hIJ3YjrFZVd9b9LEmIuTojeg0bRwfofaeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729215023; c=relaxed/simple;
	bh=Oikk8egNw843p8tlbOYelraySMbZ/cwwY+bx+67Y8wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5WkzvrVnCUtnpnEBHm9DsnVQl2ExR07SQPaucES5r1IDV1bdos0+3R+ekPUULAiUBvv31PXbH/vr9l+fzEnDUImBM6P2OJld22tvGGAiaAIUFarIGn+eBtrPyYKWskUfgMQgk1gp1csoLCdO1GkQgLeGUmFvQTAwyfJxMdxbyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkBwLtI6; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460963d6233so9500111cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 18:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729215019; x=1729819819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZVKNx7iYNwMmxwNVimUKiG1hoYsVLPRoG+wE2ltw4A=;
        b=HkBwLtI6wW8A5DqC44j4u055ooSN2bAR8w+UzwAuRNb4XCNr5bC2U1IFczg7IGgS25
         GyTW5Jnt0UOGhnJG1/86U4A8mgMwZbwni0r+ZkpOhQ9pQUGtNMeC2+rClhdxrVbioMMM
         Nivig8pvfTtTfE2mlrgYHP9/KWGE2t32ilIh6cJj8IHZmNGcfO93iEQCFYFsvaqVEpCb
         wWhV6e7kfqFMoj1EO8LG4m+oB/XjxZ27cvSw0YLVagPkICa4+XQ9S8ilSv3kOwUsA+qQ
         ZawzLqID6RKisi7bFSubZSHtXqmdDBLJYTAcofryAm8pkBKIZ693st2VNeg3aM3ZTJeJ
         H07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729215019; x=1729819819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZVKNx7iYNwMmxwNVimUKiG1hoYsVLPRoG+wE2ltw4A=;
        b=nduMtXHAfkbp9tZQmTnyhh3tVS81poRi7OfYyVUlMdsvrIdhvghI7kcoFtFZhbvlNZ
         LweDXe1TFtIt//40TZ5+UiTDdVwgdsvMEqWZAGuSGR+ianfDLN4uxM61xLtpzjP8ec/m
         hik9O3IRQpZzoG3k2H1Dhzg3bTTCIoky3UHU6BYx75hTCTCBLJ3wQADHBztRL4VKF4Ft
         VcnffEOB8OyCZs4a44hXnIkQ+lMxCJJcbrzZq/YFaZ7fZXehOe5FSyrXOEb4djCQ2S9d
         4W02LOVDUUx8VqYP0IBfEFgVZlBo5MiF5WjSZeqtsqpmzcqJluPssAT5DMFJckF47MNH
         hQNw==
X-Gm-Message-State: AOJu0Ywfj2AEX/fGxzeDVfUxjSL5zH79Lpw81cE4D55waS9HEsXNu6xV
	7BFQIXfujMYxO+c4WNGWI5QrkaVf5EuJO6ZwQtaS2s10CWnJOCvV9RkROb0fMkqX8SdOX4J0WNL
	lfM5l+tY71b8ibReKvKjqQ9vgyTY=
X-Google-Smtp-Source: AGHT+IE5fksQ1BrS7z7aksxC8DURy773ccdhGVAUL/r/qAEcI1JUs2Tovnh/yMNza0jhPUj84BirK1Rt1XM706Ijiy4=
X-Received: by 2002:ac8:5952:0:b0:460:948c:d546 with SMTP id
 d75a77b69052e-460aee41a37mr8823421cf.50.1729215019226; Thu, 17 Oct 2024
 18:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com> <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
In-Reply-To: <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 17 Oct 2024 18:30:08 -0700
Message-ID: <CAJnrk1bByc+qJTAvfJZxp5=o=N8EdgKWxQN-jWOW8Rv-PZMZRA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, linux-mm@kvack.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 3:01=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Mon, 14 Oct 2024 at 20:23, Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> > This change sets AS_NO_WRITEBACK_RECLAIM on the inode mapping so that
> > FUSE folios are not reclaimed and waited on while in writeback, and
> > removes the temporary folio + extra copying and the internal rb tree.
>
> What about sync(2)?   And page migration?
>
> Hopefully there are no other cases, but I think a careful review of
> places where generic code waits for writeback is needed before we can
> say for sure.

The places where I see this potential deadlock still being possible are:
* page migration when handling a page fault:
     In particular, this path: handle_mm_fault() ->
__handle_mm_fault() -> handle_pte_fault() -> do_numa_page() ->
migrate_misplaced_folio() -> migrate_pages() -> migrate_pages_sync()
-> migrate_pages_batch() -> migrate_folio_unmap() ->
folio_wait_writeback()
* syscalls that trigger waits on writeback, which will lead to
deadlock if a single-threaded fuse server calls this when servicing
requests:
    - sync(), sync_file_range(), fsync(), fdatasync()
    - swapoff()
    - move_pages()

I need to analyze the page fault path more to get a clearer picture of
what is happening, but so far this looks like a valid case for a
correctly written fuse server to run into.
For the syscalls however, is it valid/safe in general (disregarding
the writeback deadlock scenario for a minute) for fuse servers to be
invoking these syscalls in their handlers anyways?

The other places where I see a generic wait on writeback seem safe:
* splice, page_cache_pipe_buf_try_steal() (fs/splice.c):
   We hit this in fuse when we try to move a page from the pipe buffer
into the page cache (fuse_try_move_page()) for the SPLICE_F_MOVE case.
This wait seems fine, since the folio that's being waited on is the
folio in the pipe buffer which is not a fuse folio.
* memory failure (mm/memory_failure.c):
   Soft offlining a page and handling page memory failure - these can
be triggered asynchronously (memory_failure_work_func()), but this
should be fine for the fuse use case since the server isn't blocked on
servicing any writeback requests while memory failure handling is
waiting on writeback
* page truncation (mm/truncate.c):
   Same here. These cases seem fine since the server isn't blocked on
servicing writeback requests while truncation waits on writeback


Thanks,
Joanne

>
> Thanks,
> Miklos

