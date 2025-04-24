Return-Path: <linux-fsdevel+bounces-47282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23B3A9B58A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 19:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F084A7B97C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 17:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104E128E5F4;
	Thu, 24 Apr 2025 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pYnBL/zS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEBE280A20
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745516345; cv=none; b=gCqb213lw5dbW6JI5ZzN9B5Vmmn7E9ghAnWqP4IHyGpUGfXKhTWVNTsCgRyw4sClrwIWmWyRPceogWjO3fRsP09sb8gqNbzzrvoDnJnjKS9aRg3kmwxkCwTcuJUPhxsI63/eOS75g42w3aSEvByEUPdPYs+nlzRJu0mDaiM6tR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745516345; c=relaxed/simple;
	bh=778C7L6jHkuS9sL9E7t1piWeaUfftWC+i44EveEJyWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=tyhknqg0uFY4luKc3tGjK2pk6AhvKG4y1ki0CH5MJ9/YsAMKLSTqG7AG+ESCK6SnCiYpy+oCI3L6DIE++eEixlsjd/JIYlz9czMQU6rfvqkw8zq4wVANf0S0t5hTcHiFqxWEDhNngs0hDj5+Ma9kHUk0GoGYJEKzqv6ky9QRZ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pYnBL/zS; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4774611d40bso22891cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 10:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745516342; x=1746121142; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQve8Z1vW/P2YOkExAreJok4GWtTgHefYj/Q8y+Ff4I=;
        b=pYnBL/zSIYqy9Sse3HvCyIqFQ2uctO9G9wxJVgR+0lid9MuT6p0IntTRBYANzZIoIi
         rjA8xdTXcqL7K2LSm+R4LW/1o305PZP0u9qvZ6moqQp4ML8XG8PDUhBSvO7WIe+d1B2p
         PhlR7PQTt1WGnl7xV76tAjHxqGCwX76ZS6vaMoTqau4UqJJUrTaQaZR5ncqEcDUR2zCN
         YJGFwO9y+NCzndYbTf0HA2PafUBaSp4CnKspAzSMMhC+PR0ZIU0ehDMGYTJgJ5RAAxRF
         XRbXcNqhMm8mMBxe1EPYyPuvsOSI4B6OxRNar8iUKzwQqr4GQcEAkB/JX0X9bSG9AxPC
         3yMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745516342; x=1746121142;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQve8Z1vW/P2YOkExAreJok4GWtTgHefYj/Q8y+Ff4I=;
        b=RIoUS4i/ClQd9VeFBO2b9301ipYSmBY25DsW3mKq0HX7M7C0mFn2kZc1QamGuGm2lt
         aF16HFGJW0IGXmY8UvjXNMMcN/zTNk2eZjakleJuGkkQaKbCnCZCZQVrhGpFn5244AMv
         KzUw3ReIybmgs3cM4bTqCEHrtCgjOwroDE6wcKJH7qeYDWnWG1fZac7CjLBn9jvZ97Ka
         /UydmLwWQH6UwpXIaG8zu734nD1USvKKw1MN3xldV2O+GorjzdrT4y5eWY3NPvDwWTFQ
         teY7zjOrQV7/YVNzunJG2gFEp3kxQ2k8hgTzKW93AsL92mei4VRfEU1BGfYZV9xFdfkt
         vq4A==
X-Forwarded-Encrypted: i=1; AJvYcCV+LIO9JgD9IszEDSLnVeAxURQwEkGkMPo8dBD6xdDKM418IXjCSUXjUqT1oY8pOEQq+X6jTUCodWqb1+Uo@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf66eKqlfSLL2GHa0/oEpY4QQywPpIKxKkrntJT7J2hDC0gCON
	wAdD60A6WsTy0fp3y3aNJDA28ABm9pkY1nd7h38eoDEKxUkyH7KkU4pOeVgzlid4/LsaelAcM7X
	qc244TQ+EwrrZvZc6eDOiY0kqnrtDiJq3Ucbk
X-Gm-Gg: ASbGncsYJHgxaVekPHQZ0H2EMEXIKIoCtTwA9OkktORp4gCcaCLqzWpWebxDaTkPjEH
	wPnHBSmPc4G9QUlKLMI/gA825SN59N9dtACwduRILWLqO9CFPOW57YjWkfJcYGZaWAqWu3UVeIb
	mysmgx5DS/c7K6hEkhoYb3YZq79DJ6teB9AKxkuDWpNEenaCKw16Eg
X-Google-Smtp-Source: AGHT+IEaeLExckdIth/b7h0UkPH6TCrtID8z1DnhzMSXKNMJB5xFB7I7YwWnciAgMdM0WUca1IkmZJFJkD5T7GZBSZ8=
X-Received: by 2002:a05:622a:5a95:b0:47d:cd93:5991 with SMTP id
 d75a77b69052e-47ea4e482fcmr4499751cf.21.1745516342030; Thu, 24 Apr 2025
 10:39:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-8-surenb@google.com>
 <CAEf4BzYuA3ZRCwPsAxhQZDOOpjSTrphKEsgPAqgRP8Ly7+fTWw@mail.gmail.com>
 <CAJuCfpE_jJ0Xq5T0HcLpquRzO+NdvN3T3_JXEwSjt2NG9Ryy5g@mail.gmail.com>
 <CAEf4BzYctDuS4DRTzdRQyyhCYvFTggOz=wcbizXEYvC_z_SSng@mail.gmail.com>
 <6ay37xorr35nw4ljtptnfqchuaozu73ffvjpmwopat42n4t6vr@qnr6xvralx2o>
 <CAJuCfpGc-23xpEYZQQevkzx+iN3AAqXXzbyqJAQjd4TQP9j9Dg@mail.gmail.com>
 <CAEf4BzYBdG95Zhi0M0CDTHAU6V9sF+kGSLB+346dq0Aa4Timmg@mail.gmail.com> <by4pd6zomtvo64vjddthqu3ps2n7fqzaeqttinmy5nzttxjjd6@ch2uxmy2bgks>
In-Reply-To: <by4pd6zomtvo64vjddthqu3ps2n7fqzaeqttinmy5nzttxjjd6@ch2uxmy2bgks>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 24 Apr 2025 10:38:50 -0700
X-Gm-Features: ATxdqUHNYGXmEC72FqW87V5mUP50xMoSw_i6A76PXBjs9grB8Rv_KLgtJdCe72k
Message-ID: <CAJuCfpEAJGwCTUcQx1wjKkE2PJTf_EtX=xAwxLSdVqWn-cQTGw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] mm/maps: read proc/pid/maps under RCU
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, vbabka@suse.cz, peterx@redhat.com, jannh@google.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, 
	adobriyan@gmail.com, brauner@kernel.org, josef@toxicpanda.com, 
	yebin10@huawei.com, linux@weissschuh.net, willy@infradead.org, 
	osalvador@suse.de, andrii@kernel.org, ryan.roberts@arm.com, 
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 9:42=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Andrii Nakryiko <andrii.nakryiko@gmail.com> [250424 12:04]:
> > On Thu, Apr 24, 2025 at 8:20=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Wed, Apr 23, 2025 at 5:24=E2=80=AFPM Liam R. Howlett <Liam.Howlett=
@oracle.com> wrote:
> > > >
> > > > * Andrii Nakryiko <andrii.nakryiko@gmail.com> [250423 18:06]:
> > > > > On Wed, Apr 23, 2025 at 2:49=E2=80=AFPM Suren Baghdasaryan <suren=
b@google.com> wrote:
> > > > > >
> > > > > > On Tue, Apr 22, 2025 at 3:49=E2=80=AFPM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > >
> > > > > > > On Fri, Apr 18, 2025 at 10:50=E2=80=AFAM Suren Baghdasaryan <=
surenb@google.com> wrote:
> > > > > > > >
> > > > > > > > With maple_tree supporting vma tree traversal under RCU and=
 vma and
> > > > > > > > its important members being RCU-safe, /proc/pid/maps can be=
 read under
> > > > > > > > RCU and without the need to read-lock mmap_lock. However vm=
a content
> > > > > > > > can change from under us, therefore we make a copy of the v=
ma and we
> > > > > > > > pin pointer fields used when generating the output (current=
ly only
> > > > > > > > vm_file and anon_name). Afterwards we check for concurrent =
address
> > > > > > > > space modifications, wait for them to end and retry. While =
we take
> > > > > > > > the mmap_lock for reading during such contention, we do tha=
t momentarily
> > > > > > > > only to record new mm_wr_seq counter. This change is design=
ed to reduce
> > > > > > >
> > > > > > > This is probably a stupid question, but why do we need to tak=
e a lock
> > > > > > > just to record this counter? uprobes get away without taking =
mmap_lock
> > > > > > > even for reads, and still record this seq counter. And then d=
etect
> > > > > > > whether there were any modifications in between. Why does thi=
s change
> > > > > > > need more heavy-weight mmap_read_lock to do speculative reads=
?
> > > > > >
> > > > > > Not a stupid question. mmap_read_lock() is used to wait for the=
 writer
> > > > > > to finish what it's doing and then we continue by recording a n=
ew
> > > > > > sequence counter value and call mmap_read_unlock. This is what
> > > > > > get_vma_snapshot() does. But your question made me realize that=
 we can
> > > > > > optimize m_start() further by not taking mmap_read_lock at all.
> > > > > > Instead of taking mmap_read_lock then doing drop_mmap_lock() we=
 can
> > > > > > try mmap_lock_speculate_try_begin() and only if it fails do the=
 same
> > > > > > dance we do in the get_vma_snapshot(). I think that should work=
.
> > > > >
> > > > > Ok, yeah, it would be great to avoid taking a lock in a common ca=
se!
> > > >
> > > > We can check this counter once per 4k block and maintain the same
> > > > 'tearing' that exists today instead of per-vma.  Not that anyone sa=
id
> > > > they had an issue with changing it, but since we're on this road an=
yways
> > > > I'd thought I'd point out where we could end up.
> > >
> > > We would need to run that check on the last call to show_map() right
> > > before seq_file detects the overflow and flushes the page. On
> > > contention we will also be throwing away more prepared data (up to a
> > > page worth of records) vs only the last record. All in all I'm not
> > > convinced this is worth doing unless increased chances of data tearin=
g
> > > is identified as a problem.
> > >
> >
> > Yep, I agree, with filling out 4K of data we run into much higher
> > chances of conflict, IMO. Not worth it, I'd say.
>
> Sounds good.
>
> If this is an issue we do have a path forward still.  Although it's less
> desirable.
>
> >
> > > >
> > > > I am concerned about live locking in either scenario, but I haven't
> > > > looked too deep into this pattern.
> > > >
> > > > I also don't love (as usual) the lack of ensured forward progress.
> > >
> > > Hmm. Maybe we should add a retry limit on
> > > mmap_lock_speculate_try_begin() and once the limit is hit we just tak=
e
> > > the mmap_read_lock and proceed with it? That would prevent a
> > > hyperactive writer from blocking the reader's forward progress
> > > indefinitely.
> >
> > Came here to say the same. I'd add a small number of retries (3-5?)
> > and then fallback to the read-locked approach. The main challenge is
> > to keep all this logic nicely isolated from the main VMA
> > search/printing logic.
> >
> > For a similar pattern in uprobes, we don't even bother to rety, we
> > just fallback to mmap_read_lock and proceed, under the assumption that
> > this is going to be very rare and thus not important from the overall
> > performance perspective.
>
> In this problem space we are dealing with a herd of readers caused by
> writers delaying an ever-growing line of readers, right?

I don't know if we have a herd of readers. The problem statement was
for a low-priority reader (monitors) blocking a high-priority writer.
Multiple readers are of course possible, so I think as long as we can
guarantee forward progress we should be ok. Is that reasonable?

>
> Assuming there is a backup caused by a writer, then I don't know if the
> retry is going to do anything more than heat the data centre.
>
> The readers that take the read lock will get the data, while the others
> who arrive during read locked time can try lockless, but will most
> likely have a run time that extends beyond the readers holding the lock
> and will probably be interrupted by the writer.
>
> We can predict the new readers will also not make it through in time
> because the earlier ones failed.  The new readers will then take the
> lock and grow the line of readers.
>
> Does that make sense?

Yeah. I guess we could guarantee forward progress if the readers would
take mmap_read_lock on contention and produce one page worth of output
under that lock before dropping it and continuing with speculation
again. If contention happens again it grabs the mma_read_lock and
repeats the dance. IOW, we start with speculation, on contention we
grab the lock to produce one page and go back to speculation. Repeat
until all vmas are reported. OTOH I guess Paul's benchmark would show
some regression though... Can't have everything :)

>
> Thanks,
> Liam
>
>

