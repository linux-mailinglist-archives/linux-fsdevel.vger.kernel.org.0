Return-Path: <linux-fsdevel+bounces-65585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A23C08375
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 23:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9663B4575
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 21:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AAA31D75D;
	Fri, 24 Oct 2025 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXujqaHH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFEB31327E
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761342935; cv=none; b=uvZ8d0gONbrRsbqThNUMFtzxnptH5NnuaTF9sSvCHBYATNDZAtjVJzF07odpJcxMqUnpvU+xy2PHILZYzCbIpRvP14vJl9LtmBCbHku1LXhCYpi9q06yT2CtJqXXkx/cMCJAxitBx7JOp95SunxP3cBnndRQNiVLjkCJJBlE6jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761342935; c=relaxed/simple;
	bh=wC7EWdMu8TCbiwfkl1JzO5dUEhdFwkEmCFpmoR8pDb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZm3mpVC45/t1UsUbgMxozQw7L+XsBhjltSbyZCnB61CAUQ14E9wvRfm6NZ7QMQrwT7SWo7xvehSOZvm1lVSRfFImaWVctk8WmRIOTq6VH6VYXZshSxUlGPGfKLtNsrFO8ku/T9ob1iWiVKNdEX0k+zQQruKgsCx1/iLjQ84xJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXujqaHH; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-89e73d9596dso78490285a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 14:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761342932; x=1761947732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YvpOr8s/TjVmUq+v8fVsH8wtK7O+G0e6B19n01EHTs=;
        b=CXujqaHHzR7aW0BG5paSK9BKzDPyODk75A0DO7Fqb8/MO4dLdU2vJsYT3jj65pW6bC
         LnbFBfngP6VtAJe/ABqKUV+RHi5sfYUHamxPKIYp06IUTDNoWokgQNC3m9iS6o7fDOAd
         8Nf8xraFaYqPVGM82dR7BBesrbXU4NB3iU9tP6QL4+iXy0fyq3tl2C12lw8dnklK8nDD
         594k38rjDHktRBPiwCfrWuPJqovTa4n81JTB/obifuLd/+mZkHBfLc+BJ/8TZJUeuLaG
         zcYpQcA8MrjWbC9t1fksG9beRo6BmsM5gBltCw4EbhtWnZlQhp/nsLwaLgK2kqRL5exu
         rOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761342932; x=1761947732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YvpOr8s/TjVmUq+v8fVsH8wtK7O+G0e6B19n01EHTs=;
        b=nBnaxuPJrUOS9sS1BsGNSuoIc+q/YevXPVNU5G2hiSbtOhCVltUPDOOlzFekjgswUU
         XRPYCLRiKQ9yuks5q8tTKQX7/mgHYypfQKp2dmw32jXmn9eZsJkozo5R3WG7cgN5FPTA
         f92Fonn4on0dOk9G7XlN4jDVLdZbzkWDrMaAA8+K3HLWordluvnitDVdihRR/t3/uMZj
         L+x6SeuGdzYNPpnYP83FXyciVSGJ15DAaUa/KxbbFslGYmjd4xM/0MkbFy41NUD7TnIC
         7pdmeAqRxiPKc9FzrqV+607NO87IApAy6FRB9pWafvrPtIsJ03no5G/aoh22drkL2lOn
         mkag==
X-Forwarded-Encrypted: i=1; AJvYcCXP+DXFHnPNwqnKUeUWtllMKx3ZgBGPvX2qjDx88PX6Lt+PsuZnnAea1EZGutn/FxSy45q3bt5HQGbRP0Ir@vger.kernel.org
X-Gm-Message-State: AOJu0YwP6mtk4+lVXpSBY8axtrthEIIewWbht7mdog4tlNkO0O9Hlv8L
	2tWECtxJPAaYsmGRhpDm4FyTMqIPD2JiFgt61sr7HDsm2ihJ90hoeHI/MQ/QVkVQei1eFto3X7M
	rr6aQzK1KH7TV2woOY8Ys4nu3H9fAw3E=
X-Gm-Gg: ASbGnctbRIW4shr5k0JZySw2FKhVTqE6FkXM1UQHU8V3Hz0SolQmcI87vMx8kUozG6v
	fndvODcrpG6k5tNtZwZj4bnKKelfdIYKn4SCDz6vuX9E3hFZFiI9B7HBJWfUqEP23meCkyHOL0F
	4p4hDQXHg1D4Rk+7qxKPZBSUJmjDN8Z6rUSD19CyNS6kATfLN4Ukdny5Okow0rSan0TzQNKs4tw
	F4AlRlQ3mR7BSXtTyjmABKTPukVvHI/BaZq7fPDvmjZa95P7LxD9Z2ay+wfPfnRRbC3EPZMSmLk
	fDouAmN+0UClp/cqlgmTt1qNPg==
X-Google-Smtp-Source: AGHT+IEQSVAURDkBQ3IdcXuh7PbR3FzYdfqjIX34uIqLXoPt4wY9kQXu1J/ROhFs5vB9bH5q0GoRU/87x6/cosrEMkU=
X-Received: by 2002:a05:622a:650:b0:4b7:b15b:65e7 with SMTP id
 d75a77b69052e-4eb92abbbd8mr55593411cf.5.1761342931696; Fri, 24 Oct 2025
 14:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
 <20250926002609.1302233-8-joannelkoong@gmail.com> <aPqDPjnIaR3EF5Lt@bfoster>
 <CAJnrk1aNrARYRS+_b0v8yckR5bO4vyJkGKZHB2788vLKOY7xPw@mail.gmail.com>
 <CAJnrk1b3bHYhbW9q0r4A0NjnMNEbtCFExosAL_rUoBupr1mO3Q@mail.gmail.com>
 <aPuz4Uop66-jRpN-@bfoster> <CAJnrk1bqjykKtpAdsHLPuuvHTzOHW0tExRZ8KKmKYyfDpuAsTQ@mail.gmail.com>
In-Reply-To: <CAJnrk1bqjykKtpAdsHLPuuvHTzOHW0tExRZ8KKmKYyfDpuAsTQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 24 Oct 2025 14:55:20 -0700
X-Gm-Features: AS18NWAiPqRmKD2ZStEg9XGOQK5dI-kBZGBA1zmsvwSEN_xjY1pzAFd6HNVd4rA
Message-ID: <CAJnrk1ZOcnOT77c2fCiqzV=ZiiNnxOcB7wXn4=V+VFijS+-2Rw@mail.gmail.com>
Subject: Re: [PATCH v5 07/14] iomap: track pending read bytes more optimally
To: Brian Foster <bfoster@redhat.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	hch@infradead.org, hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 12:48=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Fri, Oct 24, 2025 at 10:10=E2=80=AFAM Brian Foster <bfoster@redhat.com=
> wrote:
> >
> > On Fri, Oct 24, 2025 at 09:25:13AM -0700, Joanne Koong wrote:
> > > On Thu, Oct 23, 2025 at 5:01=E2=80=AFPM Joanne Koong <joannelkoong@gm=
ail.com> wrote:
> > > >
> > > > On Thu, Oct 23, 2025 at 12:30=E2=80=AFPM Brian Foster <bfoster@redh=
at.com> wrote:
> > > > >
> > > > > On Thu, Sep 25, 2025 at 05:26:02PM -0700, Joanne Koong wrote:
> > > > > > Instead of incrementing read_bytes_pending for every folio rang=
e read in
> > > > > > (which requires acquiring the spinlock to do so), set read_byte=
s_pending
> > > > > > to the folio size when the first range is asynchronously read i=
n, keep
> > > > > > track of how many bytes total are asynchronously read in, and a=
djust
> > > > > > read_bytes_pending accordingly after issuing requests to read i=
n all the
> > > > > > necessary ranges.
> > > > > >
> > > > > > iomap_read_folio_ctx->cur_folio_in_bio can be removed since a n=
on-zero
> > > > > > value for pending bytes necessarily indicates the folio is in t=
he bio.
> > > > > >
> > > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > > Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > > > ---
> > > > >
> > > > > Hi Joanne,
> > > > >
> > > > > I was throwing some extra testing at the vfs-6.19.iomap branch si=
nce the
> > > > > little merge conflict thing with iomap_iter_advance(). I end up h=
itting
> > > > > what appears to be a lockup on XFS with 1k FSB (-bsize=3D1k) runn=
ing
> > > > > generic/051. It reproduces fairly reliably within a few iteration=
s or so
> > > > > and seems to always stall during a read for a dedupe operation:
> > > > >
> > > > > task:fsstress        state:D stack:0     pid:12094 tgid:12094 ppi=
d:12091  task_flags:0x400140 flags:0x00080003
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  __schedule+0x2fc/0x7a0
> > > > >  schedule+0x27/0x80
> > > > >  io_schedule+0x46/0x70
> > > > >  folio_wait_bit_common+0x12b/0x310
> > > > >  ? __pfx_wake_page_function+0x10/0x10
> > > > >  ? __pfx_xfs_vm_read_folio+0x10/0x10 [xfs]
> > > > >  filemap_read_folio+0x85/0xd0
> > > > >  ? __pfx_xfs_vm_read_folio+0x10/0x10 [xfs]
> > > > >  do_read_cache_folio+0x7c/0x1b0
> > > > >  vfs_dedupe_file_range_compare.constprop.0+0xaf/0x2d0
> > > > >  __generic_remap_file_range_prep+0x276/0x2a0
> > > > >  generic_remap_file_range_prep+0x10/0x20
> > > > >  xfs_reflink_remap_prep+0x22c/0x300 [xfs]
> > > > >  xfs_file_remap_range+0x84/0x360 [xfs]
> > > > >  vfs_dedupe_file_range_one+0x1b2/0x1d0
> > > > >  ? remap_verify_area+0x46/0x140
> > > > >  vfs_dedupe_file_range+0x162/0x220
> > > > >  do_vfs_ioctl+0x4d1/0x940
> > > > >  __x64_sys_ioctl+0x75/0xe0
> > > > >  do_syscall_64+0x84/0x800
> > > > >  ? do_syscall_64+0xbb/0x800
> > > > >  ? avc_has_perm_noaudit+0x6b/0xf0
> > > > >  ? _copy_to_user+0x31/0x40
> > > > >  ? cp_new_stat+0x130/0x170
> > > > >  ? __do_sys_newfstat+0x44/0x70
> > > > >  ? do_syscall_64+0xbb/0x800
> > > > >  ? do_syscall_64+0xbb/0x800
> > > > >  ? clear_bhb_loop+0x30/0x80
> > > > >  ? clear_bhb_loop+0x30/0x80
> > > > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > RIP: 0033:0x7fe6bbd9a14d
> > > > > RSP: 002b:00007ffde72cd4e0 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00010
> > > > > RAX: ffffffffffffffda RBX: 0000000000000068 RCX: 00007fe6bbd9a14d
> > > > > RDX: 000000000a1394b0 RSI: 00000000c0189436 RDI: 0000000000000004
> > > > > RBP: 00007ffde72cd530 R08: 0000000000001000 R09: 000000000a11a3fc
> > > > > R10: 000000000001d6c0 R11: 0000000000000246 R12: 000000000a12cfb0
> > > > > R13: 000000000a12ba10 R14: 000000000a14e610 R15: 0000000000019000
> > > > >  </TASK>
> > > > >
> > > > > It wasn't immediately clear to me what the issue was so I bisecte=
d and
> > > > > it landed on this patch. It kind of looks like we're failing to u=
nlock a
> > > > > folio at some point and then tripping over it later..? I can kill=
 the
> > > > > fsstress process but then the umount ultimately gets stuck tossin=
g
> > > > > pagecache [1], so the mount still ends up stuck indefinitely. Any=
ways,
> > > > > I'll poke at it some more but I figure you might be able to make =
sense
> > > > > of this faster than I can.
> > > > >
> > > > > Brian
> > > >
> > > > Hi Brian,
> > > >
> > > > Thanks for your report and the repro instructions. I will look into
> > > > this and report back what I find.
> > >
> > > This is the fix:
> > >
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index 4e6258fdb915..aa46fec8362d 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -445,6 +445,9 @@ static void iomap_read_end(struct folio *folio,
> > > size_t bytes_pending)
> > >                 bool end_read, uptodate;
> > >                 size_t bytes_accounted =3D folio_size(folio) - bytes_=
pending;
> > >
> > > +               if (!bytes_accounted)
> > > +                       return;
> > > +
> > >                 spin_lock_irq(&ifs->state_lock);
> > >
> > >
> > > What I missed was that if all the bytes in the folio are non-uptodate
> > > and need to read in by the filesystem, then there's a bug where the
> > > read will be ended on the folio twice (in iomap_read_end() and when
> > > the filesystem calls iomap_finish_folio_write(), when only the
> > > filesystem should end the read), which does 2 folio unlocks which end=
s
> > > up locking the folio. Looking at the writeback patch that does a
> > > similar optimization [1], I miss the same thing there.
> > >
> >
> > Makes sense.. though a short comment wouldn't hurt in there. ;) I found
> > myself a little confused by the accounted vs. pending naming when
> > reading through that code. If I follow correctly, the intent is to refe=
r
> > to the additional bytes accounted to read_bytes_pending via the init
> > (where it just accounts the whole folio up front) and pending refers to
> > submitted I/O.
> >
> > Presumably that extra accounting doubly serves as the typical "don't
> > complete the op before the submitter is done processing" extra
> > reference, except in this full submit case of course. If so, that's
> > subtle enough in my mind that a sentence or two on it wouldn't hurt..
>
> I will add some a comment about this :) That's a good point about the
> naming, maybe "bytes_submitted" and "bytes_unsubmitted" is a lot less
> confusing than "bytes_pending" and "bytes_accounted".

Thinking about this some more, bytes_unsubmitted sounds even more
confusing, so maybe bytes_nonsubmitted or bytes_not_submitted. I'll
think about this some more but kept it as pending/accounted for now.

The fix for this bug is here [1].

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20251024215008.3844068-1-joannelk=
oong@gmail.com/

>
> Thanks,
> Joanne
>
> >
> > > I'll fix up both. Thanks for catching this and bisecting it down to
> > > this patch. Sorry for the trouble.
> > >
> >
> > No prob. Thanks for the fix!
> >
> > Brian
> >
> > > Thanks,
> > > Joanne
> > >
> > > [1] https://lore.kernel.org/linux-fsdevel/20251009225611.3744728-4-jo=
annelkoong@gmail.com/
> > > >
> > > > Thanks,
> > > > Joanne
> > > > >
> > >
> >

