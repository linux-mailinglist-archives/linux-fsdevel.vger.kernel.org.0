Return-Path: <linux-fsdevel+bounces-47283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48B2A9B597
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 19:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63A54C0C54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 17:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3E128DF0B;
	Thu, 24 Apr 2025 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfgest+e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BE7288CAF;
	Thu, 24 Apr 2025 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745516674; cv=none; b=gwsBk5LW3c+epYrari1pdBdH1F3TA26T9jPMiRC4gFvyh0fdT4CzIF+mYhIsAbOnaUOQn5MQXty6VRDC0rQI3IpZDd975sr9UCFgrKTyoKUc+gJr3DOwplWSRL6uLxTt3BPIr+93R6cON3K52awPulE/7riZrmfxcRKhAqa8dSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745516674; c=relaxed/simple;
	bh=mI3TaOY4zVaD8dsCUeprbP96juwMm2SKYnaVvR6aaX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jwKOXAlRK72weUyfu+Oa2Q3pGdnX7m82oAfzblqFNQxESWL7jR7vXP7u5r6UG5dxRQL1XWagVcHDrwD0kwdpmAkuXXxU6Xb1LVta4mfaglABE7wlyK6KhLkaxee3Q4yBYMfrCUmy/EIFqGejWFixE6qU6bHxeTqxJQQm8Mjln4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfgest+e; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-301cda78d48so1626787a91.0;
        Thu, 24 Apr 2025 10:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745516671; x=1746121471; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mffAT54qMPQbjpYgx52ilpx2rHU47fkXThvhDlA6gFI=;
        b=kfgest+eNT+HtSglfF3Irmd+HPFEDGtyZlb8LZMEoZL7dnpObe8JiNkKDcOcm9s8jE
         cQTcM/ToWdUayShXb1vbU1Ut3v0zlNLD9Wj2TNgvX8TpG9U6+0b0KOj7aNMpptsqm1YR
         aWL5e33zf86sBJHaC4QZGv8qUeZZLJKhly4eAyhzlDEg5BoOkBMKIERiM07KbIyipVjY
         +e5AK/mMpKkjCUEP11O+8J4w35I112pI0dsZDaWklybRIajTIlZ+mQbAC8k800cSac++
         Pwj1d1FAKd+ubFPveXROhCMxcRfylszX5u9WgUmwSAqgwQnGcnnd/KM1JoJ9Pp0TDkfy
         fTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745516671; x=1746121471;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mffAT54qMPQbjpYgx52ilpx2rHU47fkXThvhDlA6gFI=;
        b=EEMwYYHri35yfznVpXj8GurcWJJIoUl2jQc3FxI40IEuEuv5/ypFDMlFuNe3WbLdhf
         Wbsh84dcFJcl4BY2Bbf06VJtGAAufgAxPh4CMYSbu4UNBanwbx1pCTyivm/IuYXCPXly
         AaebFP+XLU5HUDLrMbZ+qY+zJtPoF94lN9DdIkf7QPZ7+3V9Um4pCVUvIiFibA2vqPtC
         b/4cvVOC6FQp+JPzLqq6QZE08Rkoc7nviZaOK2HZNKrOYn9zoh828EvV8w+W/q53UOkH
         IlR2mkSthq+5093DuSHQ/huJgwMSEoHlfftT9Yv9AoCdUb8EAo5WgjXa3WihG/seQlhd
         +t0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtSqNGLcrWLXrSVI71CMgZcKYcLMObhea8aBOEdfCV47g9bkgCW0AajpnaCZUglZ4JZNlUjJbqwa9gd//V@vger.kernel.org, AJvYcCVKigMAlGaPdN3SoUcyjoqSOivtLmXNj99X8rmK/poLe/UY5Pl2Vq6R3/CuA1KEABVKtMJICkktvMWF+aCG1v33@vger.kernel.org, AJvYcCWL1vCUH6fijJGyCVkMLuWI4Y7bJkoAtpZX8OuwIuOVXrwGl0VPd72pw+/WyaIlvMjHoxgOM0JLb5+knQjl@vger.kernel.org
X-Gm-Message-State: AOJu0YzsValBbmCch9AyiACKq1IoWNI/js0hFcDo5U1ZYHqSyNyvmsWX
	xJWMnfY2g2E6/SA6MWIITJ1TkgkL98NV3hzzXeFLySGtQMxsLWQjRnw+ph32/yTRVC0old1dnTc
	AgmIf2yZv3tZswqB6gqpM+ZVY9nM=
X-Gm-Gg: ASbGnctAXBMvja+RFA7E7iKy+We+yJDGBKNI/UecoXFAm/DHhezYuYFarY4/vh7TFRQ
	UtSbsfmXf9D9UNh9wsOoTrORy3+mKgAABR3UFN/1FRedx5LnDBkoGQUFJ9wHdgbQM0Edl5nM8D3
	t0+4tzfu7rv/mda5IseMGE1EVmcSq328+8DXn07w==
X-Google-Smtp-Source: AGHT+IEbC9MfH5k//FpLzbteCvNMZEOW+FW4qBhgPMfH21QiQKG25C2OHUzSRugHR0yrctME3aO8CzTi/i+3qJY7ijY=
X-Received: by 2002:a17:90b:37ce:b0:2ee:45fd:34f2 with SMTP id
 98e67ed59e1d1-309f551b2f5mr761953a91.6.1745516671386; Thu, 24 Apr 2025
 10:44:31 -0700 (PDT)
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
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Apr 2025 10:44:19 -0700
X-Gm-Features: ATxdqUERQdGbt6np1cB_OGPNOZCBsAnzZeDlTy6xzP7Epb6E5SYubXPJlY8PLHw
Message-ID: <CAEf4BzY10_NdGOcQMZo2On3VnE3DRTiGDb5JydtAzw2AVQHAgQ@mail.gmail.com>
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

I'm assuming that the common case is there is no writer, we attempt
lockless vma read, but then (very rarely) writer comes in and starts
to change something, disrupting the read. In uprobe vma lookup
speculation case we don't even attempt to do lockless read if there is
an active writer, we just fallback to mmap_read_lock.

So I guess in that case we don't really need many retries. Just check
if there is active writer, and if not - mmap_read_lock. If there was
no writer, speculate, and when done double-check that nothing changed.
If something changed - retry with mmap_read_lock.

Does that sound more reasonable?

>
> Assuming there is a backup caused by a writer, then I don't know if the
> retry is going to do anything more than heat the data centre.

In this scenario, yes, I agree that retrying isn't useful, because
writer probably is going to be quite a lot slower than fast readers.
So see above, perhaps no retries are needed beyond just lockles ->
mmap_read_lock retry. Just a quick mmap_lock_speculate_try_begin()
check at the start.

BTW, I realized that me referencing uprobe speculation is done with no
context or code pointers. I'm talking about
find_active_uprobe_speculative() in kernel/events/uprobes.c, if you
are curious.

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

I think so, though not 100% sure I got all the points you are raising.
But see above if my thoughts make sense to you :)

>
> Thanks,
> Liam
>
>

