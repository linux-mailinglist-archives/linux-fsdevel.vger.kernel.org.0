Return-Path: <linux-fsdevel+bounces-32379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6524E9A4775
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 21:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D6C1C21E19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 19:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E5C204940;
	Fri, 18 Oct 2024 19:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEHKhzYt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB21316EB4C
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729281442; cv=none; b=YYy7zGQMB0jh1WPBlaPFJRC4oheaNyPsgHC+mbLsiG30nKo66LDWrtJ8f05IS2eEtGrEiu93VGld4byRmMf8yvacqlyaKuOOm8ZVMtfUx19kMhsm5UOMHdxy0ap33fzfIC7jCM7OUegw4tzwSCcqsK6U3xSrceRLu93RFtV+0ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729281442; c=relaxed/simple;
	bh=RV+vl5MliGAoe8/4lKF3znerh+1UUE8f/SNzEUl/byg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0sd/xxb9qruME9NiUXomoUKVZ7EwmRmr3Th4fYvLDSC6sgW1lEVzu4KNTLNMYSttW+ht6DGTNTWFPo8qgdRZMymQwF+Op2JzS/vVJvL2lPwmW+PH7bkp/7e2xMF+HZfgI8D4udtM+xWf0Ix+GURljF0BP6FurlcXTjDE4L7Dgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEHKhzYt; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e29687f4cc6so2555626276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 12:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729281440; x=1729886240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nthzttf7hHxZuUwI9LqlfkzYylX0BTNzIEepU14wscY=;
        b=JEHKhzYt/Qo6VA9/aP0yE/1/rwPcFTDr5S8J7CZqZzZ9hM4tqH85aiiG1Nkj4nj4s8
         h6x87QKXtLRMAZ022B1PZ7r8fq29V4rCAdfgoi4iIi+578ZqNNWhcMgVUjmngM4i/2ut
         pX6PEK0G3cjBJyMXL/bwqAQWlYeGSGYO3pXZVhPRkuamA8pX39cZstMtd33OEgEJZvWG
         +R2bXIkFeROBBslZHq2JGrL/MC+bRqMlh3F9qVfx7b/asgdJJPARhWgQNNX44JQYYXGX
         DBjsbSKKvV9nqWQePT/5IoNUTpT0jj0ajguR6M70hzT01zD3G3hHxshwEEjpdw6mrbOd
         bzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729281440; x=1729886240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nthzttf7hHxZuUwI9LqlfkzYylX0BTNzIEepU14wscY=;
        b=b8i3Fi9qrnl07PSwLZyQ9OJ+yHvA7lZI/tl3HvlnzPAPHN7Ha/RIiY5gGhpnxrn1VI
         EVIxG1RTyHHkCWKZEURxXo/4tecHVntg6G6/079esmHa0HSmYzCnLrTvVM1SGx6PwIR0
         P/D54B2qVncJGeTfKN2TfP9triLQ+ZXvx1gc9//pvOo3t9fSrWpOc064I1IJLdPP8fmF
         UQStIuR2OqDde/D3QViaM9IRP8196VSy5GD3CypJmC6e8IgsakPnVKliAPK0MWoioVhr
         O2Xl1RHlMEgb1ll1G5O93RKlLDtqBWUkHmyrCmszHRPvUE7j2w9P2xLOllm4Ly9DoYXj
         AKCw==
X-Forwarded-Encrypted: i=1; AJvYcCXxngI0PRjkEaBhsFLYpF5KP000jGIy6SS8Pog2I0bb+/NWVlj6kt7FNuOd2nuacmRq05gUpSQh8awUO+xA@vger.kernel.org
X-Gm-Message-State: AOJu0YxR65M6h3oQY7/be5V3y7RePLnelHwY6kZTABD59mk/35UUc/ep
	xFo+8OM7mrg1LCo7lH/EkcQyxEbg10o1rETG67TRKhnGKKhlRdv3R4SO3C9kl1Eu6ZUf1GhtcdB
	6Nuhk9o8tzWAWxULHSwavZItAYUM=
X-Google-Smtp-Source: AGHT+IHIeAhOi4GBxuJbnNsTN1AgC2ZkkGsQl0gP94YS48WpeZHMlQvoiCNcpndXySdHlY5BiWefOluPtr/oGYadYmQ=
X-Received: by 2002:a05:6902:2847:b0:e28:eb16:dd5e with SMTP id
 3f1490d57ef6-e2bb16c3a1fmr3434978276.52.1729281439728; Fri, 18 Oct 2024
 12:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com> <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1bByc+qJTAvfJZxp5=o=N8EdgKWxQN-jWOW8Rv-PZMZRA@mail.gmail.com> <tbkfwtebn4l46cnwoqrf2cm7e5r5ndy7zj2bvdnk4n2q7yk5xh@gmno3qfufaur>
In-Reply-To: <tbkfwtebn4l46cnwoqrf2cm7e5r5ndy7zj2bvdnk4n2q7yk5xh@gmno3qfufaur>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 18 Oct 2024 12:57:08 -0700
Message-ID: <CAJnrk1ak-rVG2tthwkNd-PPVD6hVH_Vczye1Z2OYfvtDLiZEFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 10:57=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Thu, Oct 17, 2024 at 06:30:08PM GMT, Joanne Koong wrote:
> > On Tue, Oct 15, 2024 at 3:01=E2=80=AFAM Miklos Szeredi <miklos@szeredi.=
hu> wrote:
> > >
> > > On Mon, 14 Oct 2024 at 20:23, Joanne Koong <joannelkoong@gmail.com> w=
rote:
> > >
> > > > This change sets AS_NO_WRITEBACK_RECLAIM on the inode mapping so th=
at
> > > > FUSE folios are not reclaimed and waited on while in writeback, and
> > > > removes the temporary folio + extra copying and the internal rb tre=
e.
> > >
> > > What about sync(2)?   And page migration?
> > >
> > > Hopefully there are no other cases, but I think a careful review of
> > > places where generic code waits for writeback is needed before we can
> > > say for sure.
> >
> > The places where I see this potential deadlock still being possible are=
:
> > * page migration when handling a page fault:
> >      In particular, this path: handle_mm_fault() ->
> > __handle_mm_fault() -> handle_pte_fault() -> do_numa_page() ->
> > migrate_misplaced_folio() -> migrate_pages() -> migrate_pages_sync()
> > -> migrate_pages_batch() -> migrate_folio_unmap() ->
> > folio_wait_writeback()
>
> So, this is numa fault and if fuse server is not mapping the fuse folios
> which it is serving, in its address space then this is not an issue.
> However hugepage allocation on page fault can cause compaction which
> might migrate unrelated fuse folios. So, fuse server doing compaction
> is an issue and we need to resolve similar to reclaim codepath. (Though
> I think for THP it is not doing MIGRATE_SYNC but doing for gigantic
> hugetlb pages).

Thanks for the explanation. Would you mind pointing me to the
compaction function where this triggers the migrate? Is this in
compact_zone() where it calls migrate_pages() on the cc->migratepages
list?

>
> > * syscalls that trigger waits on writeback, which will lead to
> > deadlock if a single-threaded fuse server calls this when servicing
> > requests:
> >     - sync(), sync_file_range(), fsync(), fdatasync()
> >     - swapoff()
> >     - move_pages()
> >
> > I need to analyze the page fault path more to get a clearer picture of
> > what is happening, but so far this looks like a valid case for a
> > correctly written fuse server to run into.
> > For the syscalls however, is it valid/safe in general (disregarding
> > the writeback deadlock scenario for a minute) for fuse servers to be
> > invoking these syscalls in their handlers anyways?
> >
> > The other places where I see a generic wait on writeback seem safe:
> > * splice, page_cache_pipe_buf_try_steal() (fs/splice.c):
> >    We hit this in fuse when we try to move a page from the pipe buffer
> > into the page cache (fuse_try_move_page()) for the SPLICE_F_MOVE case.
> > This wait seems fine, since the folio that's being waited on is the
> > folio in the pipe buffer which is not a fuse folio.
> > * memory failure (mm/memory_failure.c):
> >    Soft offlining a page and handling page memory failure - these can
> > be triggered asynchronously (memory_failure_work_func()), but this
> > should be fine for the fuse use case since the server isn't blocked on
> > servicing any writeback requests while memory failure handling is
> > waiting on writeback
> > * page truncation (mm/truncate.c):
> >    Same here. These cases seem fine since the server isn't blocked on
> > servicing writeback requests while truncation waits on writeback
> >
> >
> > Thanks,
> > Joanne
> >
> > >
> > > Thanks,
> > > Miklos

