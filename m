Return-Path: <linux-fsdevel+bounces-8081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B9182F38D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 18:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1DF285ACD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 17:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC7F1CD1E;
	Tue, 16 Jan 2024 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f/JUfKl5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BFF1CABE
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705427870; cv=none; b=d38soOGPi0MTdSpMTYum2eQyLgdF3PL14xk15axfUkeUKL9X5zpHeKn3IhRRnxsIiKo3JTeies0/nuadu+GUmOqrNWp6NpnREMP0huDYnOvj1E+epEVVxCbgkbh0E5kiG/KlxSd5A0CwPA0BLdWxOh/rLiHFecgTDTrPZMKX1y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705427870; c=relaxed/simple;
	bh=yUAHuj8vVj8IUFVbFycTjbLEQJVq0uuFYF6xO/bIKQk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=g6RFLDlnwI/NuCai2sVqm5jldrNa8BubfPihdlhIdDs+mJ3gdTueLJCDGht8bl98eZFEPZfwY7yKWYoSLhyQf/qYvv+oDHNLUOa988qXU6UJLZlgQkCGPb/8Ab7mibyJfbWn7GUI8PWY5SuKN0UERhRDnlM5ilffCkZ/5gKRmJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f/JUfKl5; arc=none smtp.client-ip=209.85.128.182
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5ebca94cf74so96960187b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 09:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705427867; x=1706032667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z9i/7IxW+vD8oAmdqNGi8gKSOYfLZrN80TxMX3ACrg=;
        b=f/JUfKl5Q1BxzhHkzXbL3WJzt9ong+kA44jQ8KmrFUrYr9Q64j5GLTjn0Kss9yGljz
         S6ygarJQQ/1DfIrA69jhT2ULQXWni2pp/dOEZO0dPx6o5O9Jrmwt8ZqZmzEeE5Rdhavp
         bwv7uPUALw+56Tid6hsMYGrewmR1pPsdQ2V08qaG33QdA2vNaySAa/it374iIwuFZoPe
         YV5dq3qZXE0rIoUsA1A4tJnGlRguql+StFakIrTfLDExs/d7CvxoCMpzdHXyQXGrG78Y
         v0Fnl93zQ5Bbqs+Lkqpdtro1eSVsM/TqCtd2z9squzkYG/W/GedcsvhiaCOC8NlkvTcT
         W+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705427867; x=1706032667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9z9i/7IxW+vD8oAmdqNGi8gKSOYfLZrN80TxMX3ACrg=;
        b=N5/ZDRCa2i+U5/u6NLHlimxuvxCttMLpYLL2VrYH2FltCKMVciYoaBkYTZeVjgn1ea
         674CInYHtRbQXF4whIAsm5r37jPXIIMFVBWXbYkcPoatnRLwaAXvjcL54tWZvCwYb4nL
         k/mjZflLgN1HFzEC4GDe3WQj7UojTChIJ5JuAJVcuUDL7FeZd4+zALE6C+BEBrl7+vpH
         /Ir+V06SyWy2T0ug0PA+OYm3mEDHYS534SYQoBawFG5BqJDGYaJMieN8H10JWCh09++M
         DcUpGt2Wbzwnf3WVnsnTa7a+IoCuK2w6fxINaGzNu+kK6j5X4teeRP+G6cCOYJczoval
         Gbug==
X-Gm-Message-State: AOJu0Yy7M7HZHRhi0tYhCMRWB6HIO8iB9rNsvVk1XipKXhQ7wuBKnsAB
	3APSFjOj4ducVqOW+MM3t+rQhNbLnaKupoMZxjn1DhzLHi+U
X-Google-Smtp-Source: AGHT+IFyVFz3b29oTWOr9F5UxV+4etmI5OtR+C0TA+Mosl5koGhrgqlF3uiF6vK/YTAobFtxglozaPMX3P532Tcex2E=
X-Received: by 2002:a81:ad5b:0:b0:5ff:6117:3df9 with SMTP id
 l27-20020a81ad5b000000b005ff61173df9mr263299ywk.71.1705427866742; Tue, 16 Jan
 2024 09:57:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115183837.205694-1-surenb@google.com> <1bc8a5df-b413-4869-8931-98f5b9e82fe5@suse.cz>
 <74005ee1-b6d8-4ab5-ba97-92bec302cc4b@suse.cz>
In-Reply-To: <74005ee1-b6d8-4ab5-ba97-92bec302cc4b@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 16 Jan 2024 09:57:31 -0800
Message-ID: <CAJuCfpGTVEy=ZURbL3c7k+CduDR8wSfqsujN+OecPwuns7LiGQ@mail.gmail.com>
Subject: Re: [RFC 0/3] reading proc/pid/maps under RCU
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, dchinner@redhat.com, casey@schaufler-ca.com, 
	ben.wolsieffer@hefring.com, paulmck@kernel.org, david@redhat.com, 
	avagin@google.com, usama.anjum@collabora.com, peterx@redhat.com, 
	hughd@google.com, ryan.roberts@arm.com, wangkefeng.wang@huawei.com, 
	Liam.Howlett@oracle.com, yuzhao@google.com, axelrasmussen@google.com, 
	lstoakes@gmail.com, talumbau@google.com, willy@infradead.org, 
	mgorman@techsingularity.net, jhubbard@nvidia.com, vishal.moola@gmail.com, 
	mathieu.desnoyers@efficios.com, dhowells@redhat.com, jgg@ziepe.ca, 
	sidhartha.kumar@oracle.com, andriy.shevchenko@linux.intel.com, 
	yangxingui@huawei.com, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 6:46=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/16/24 15:42, Vlastimil Babka wrote:
> > On 1/15/24 19:38, Suren Baghdasaryan wrote:
> >
> > Hi,
> >
> >> The issue this patchset is trying to address is mmap_lock contention w=
hen
> >> a low priority task (monitoring, data collecting, etc.) blocks a highe=
r
> >> priority task from making updated to the address space. The contention=
 is
> >> due to the mmap_lock being held for read when reading proc/pid/maps.
> >> With maple_tree introduction, VMA tree traversals are RCU-safe and per=
-vma
> >> locks make VMA access RCU-safe. this provides an opportunity for lock-=
less
> >> reading of proc/pid/maps. We still need to overcome a couple obstacles=
:
> >> 1. Make all VMA pointer fields used for proc/pid/maps content generati=
on
> >> RCU-safe;
> >> 2. Ensure that proc/pid/maps data tearing, which is currently possible=
 at
> >> page boundaries only, does not get worse.
> >
> > Hm I thought we were to only choose this more complicated in case addit=
ional
> > tearing becomes a problem, and at first assume that if software can dea=
l
> > with page boundary tearing, it can deal with sub-page tearing too?

Hi Vlastimil,
Thanks for the feedback!
Yes, originally I thought we wouldn't be able to avoid additional
tearing without a big change but then realized it's not that hard, so
I tried to keep the change in behavior transparent to the userspace.

> >
> >> The patchset deals with these issues but there is a downside which I w=
ould
> >> like to get input on:
> >> This change introduces unfairness towards the reader of proc/pid/maps,
> >> which can be blocked by an overly active/malicious address space modif=
yer.
> >
> > So this is a consequence of the validate() operation, right? We could a=
void
> > this if we allowed sub-page tearing.

Yes, if we don't care about sub-page tearing then we could get rid of
validate step and this issue with updaters blocking the reader would
go away. If we choose that direction there will be one more issue to
fix, namely the maple_tree temporary inconsistent state when a VMA is
replaced with another one and we might observe NULL there. We might be
able to use Matthew's rwsem_wait() to deal with that issue.

> >
> >> A couple of ways I though we can address this issue are:
> >> 1. After several lock-less retries (or some time limit) to fall back t=
o
> >> taking mmap_lock.
> >> 2. Employ lock-less reading only if the reader has low priority,
> >> indicating that blocking it is not critical.
> >> 3. Introducing a separate procfs file which publishes the same data in
> >> lock-less manner.
>
> Oh and if this option 3 becomes necessary, then such new file shouldn't
> validate() either, and whoever wants to avoid the reader contention and
> converts their monitoring to the new file will have to account for this
> possible extra tearing from the start. So I would suggest trying to chang=
e
> the existing file with no validate() first, and if existing userspace get=
s
> broken, employ option 3. This would mean no validate() in either case?

Yes but I was trying to avoid introducing additional file which
publishes the same content in a slightly different way. We will have
to explain when userspace should use one vs the other and that would
require going into low level implementation details, I think. Don't
know if that's acceptable/preferable.
Thanks,
Suren.

>
> >> I imagine a combination of these approaches can also be employed.
> >> I would like to get feedback on this from the Linux community.
> >>
> >> Note: mmap_read_lock/mmap_read_unlock sequence inside validate_map()
> >> can be replaced with more efficiend rwsem_wait() proposed by Matthew
> >> in [1].
> >>
> >> [1] https://lore.kernel.org/all/ZZ1+ZicgN8dZ3zj3@casper.infradead.org/
> >>
> >> Suren Baghdasaryan (3):
> >>   mm: make vm_area_struct anon_name field RCU-safe
> >>   seq_file: add validate() operation to seq_operations
> >>   mm/maps: read proc/pid/maps under RCU
> >>
> >>  fs/proc/internal.h        |   3 +
> >>  fs/proc/task_mmu.c        | 130 ++++++++++++++++++++++++++++++++++---=
-
> >>  fs/seq_file.c             |  24 ++++++-
> >>  include/linux/mm_inline.h |  10 ++-
> >>  include/linux/mm_types.h  |   3 +-
> >>  include/linux/seq_file.h  |   1 +
> >>  mm/madvise.c              |  30 +++++++--
> >>  7 files changed, 181 insertions(+), 20 deletions(-)
> >>
> >
>

