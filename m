Return-Path: <linux-fsdevel+bounces-57771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 849DAB24FC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE461C27907
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C2D285C97;
	Wed, 13 Aug 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjfjjjTU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E561D54D8
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102122; cv=none; b=QiIOTvezvb6xymIlSQPAAn9jHamt00BnnJ9wkjcQU/YD1Iuatp/7CPMMeBR2dsEgX8XUqxBeAKFqAKaps63d8H0mhYtayN5pe85ZEJAtxxA3pUNLXzXsxC6rGKeG2a/e+EZfWH2T5hlV+FsVisBhoaT5mlPURnK/qmNx8DFNDtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102122; c=relaxed/simple;
	bh=FCtBWS7G7QSfGS21fNpnoOvL2XzwY20HFRw2SobIDWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOeDWOInZd+V9MpRAvKeGUCKfI+MZue9fpnLKB4GTBXZY5srmYvkg4/40nXmLtzStGflQWsvWemttAUtTBXYx2S9rG4LjZjFQPlfeslG9CD0dvqd2IhXvohQk7yCCYfq/5PqlKdhh6yFLJQThOTq3GENqB12r9cYzhKl3Lnm+XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjfjjjTU; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b0bd871d9aso403181cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 09:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755102119; x=1755706919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QinmQQFXomCWAaJH8CKN0I0il8aAmJNtIteVH369jE=;
        b=hjfjjjTUXhEx74ETrH26k53+U9I45rcNMOqNAot3nLQdCc1C2ebG1u60Q+j6AVYxEq
         o4fYN+V+2rbZdn7xM16NFlWL/195RPaTKYyzUCzECK9Xr15ZzHcNcK19Q4QvWi52F3Qk
         JPToC2+Cd2MXhKkfpR1aY787na+MLSz2IY84myNPxQ3NFUJ2+473c9K+R0H7LW5e8lFD
         pTAqL3H+NJJp44WOfNLejv2vPhhFXZbWe2h8j8HccQKO86dEZQWGoVcXlMM13bW4gOl+
         luwYpmPJ0X6RVk7zCqJL0bP9FFxweSVyg+KChB90SFf812c/J9C0rrvsSB4aviuzVF5R
         3sNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755102119; x=1755706919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QinmQQFXomCWAaJH8CKN0I0il8aAmJNtIteVH369jE=;
        b=u21RY3mJ3NbxRnP0aLA1aSZZZHqmBhHvtDppTdVulEs4sHZT4IbkwvnyhrHgMpakOd
         sURzXdFIjktzblT5NeJCDcO9b5PX5HhKnnryxzUXCfU1mCzql5VY8YXCOinZE7zETFRl
         Djffa9daYbFZnehxgrtYBwajJrITk1VsJEHgn/2zF4rF6sm6rkNtbMZAr1xlxuhiYdgs
         4hfuQDqAGsUuRCBQflrkr8XnIKhW/s079rODqW5Y9F1gLq6vRTrqTOLKq4XPj120qgSX
         a7qDrWk8z49y/s8tWwlEPTlZvHBgIhJAekhEFlL0Y1nZHOHHhHBNAhC3/LeT7D4N3GrJ
         rN8A==
X-Forwarded-Encrypted: i=1; AJvYcCVS973HH2qvkUjBiYnqLsf3lL7KKUo1jkJ54QBP8noFOgx7HWvwJ3yu8fV1iJhNrZxS3oXu/NGb1TiZ5J1L@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8RNB7kH2QJulSzFDRd/4JMdv0dqH4TYVO+1KIXA4hGrO0cTKe
	KR/JXg6VU6SpYuHQLbW6TEzrlUTb2/OHcclvY9+2ctE/z00dnHmp5zhKi7eMmL+6VKLTJ38OlAr
	762bN2gHkUQ4ngxoRdIE23HqkbFkMrbd4zp2iynfV
X-Gm-Gg: ASbGncse7UcwZSxw0Zk0u7M7nl2iNzNN5WEp7KSKRyytrymUTEMo4sW0Fr+Oyvt976w
	G+sfIIeX2KdR3qOVetyVOsZfssB1BDn+dEWOmE1AtiaIitsju4/BVRbSwH45WipYjLf2FdCGouh
	0nFUztZZt1dWeIsY4EmC8PIC+3Zef1wIOEmOBeNfxG+yZdGYMRpI7A/m31bMDGb0gCZF0Tb10EH
	rvztaLJ9jAeAcfqQZ3/vXeg7WTt+SycnTXuGtm65GacbOjKdmj3hRZT
X-Google-Smtp-Source: AGHT+IGGAjAQlJAs/6fOMgvF3DcusMKTQOaQbjz9ZrFKQ1wo0Qm87n6yg3dhd+rsJGWsOVYpbpOk1wnlAHiH0dZ6fyQ=
X-Received: by 2002:ac8:7f92:0:b0:4b0:83a3:9bac with SMTP id
 d75a77b69052e-4b0fdbc7fc6mr3865131cf.17.1755102118775; Wed, 13 Aug 2025
 09:21:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808152850.2580887-1-surenb@google.com> <20250808152850.2580887-2-surenb@google.com>
 <7d3b4b0c-f905-4622-95a8-e4d076dc71d4@lucifer.local>
In-Reply-To: <7d3b4b0c-f905-4622-95a8-e4d076dc71d4@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 13 Aug 2025 16:21:47 +0000
X-Gm-Features: Ac12FXycH4KgQhHe2VKUKoPE6OrMOaMbLer1JM-gxVxQlhmfWUD7HLZEVfP2gtE
Message-ID: <CAJuCfpH+Mg7P--sP7LmhhUgGSU0AwmoJLYGyvft5fPC0Mz1P6w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] selftests/proc: test PROCMAP_QUERY ioctl while vma
 is concurrently modified
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	SeongJae Park <sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:39=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Aug 08, 2025 at 08:28:47AM -0700, Suren Baghdasaryan wrote:
> > Extend /proc/pid/maps tearing tests to verify PROCMAP_QUERY ioctl opera=
tion
> > correctness while the vma is being concurrently modified.
> >
>
> General comment, but I really feel like this stuff is mm-specific. Yes it=
 uses
> proc, but it's using it to check for mm functionality.
>
> I mean I'd love for these to be in the mm self tests but I get obviously =
why
> they're in the proc ones...
>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Tested-by: SeongJae Park <sj@kernel.org>
> > Acked-by: SeongJae Park <sj@kernel.org>
>
> The tests themselves look good, had a good look through. But I've given y=
ou
> some nice ASCII diagrams to sprinkle liberally around :)

Thanks for the commentary, Lorenzo, it is great! I think I'll post
them as a follow-up patch since they do not change the functionality
of the test.

>
> Anyway for tests themselves:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks!

>
> > ---
> >  tools/testing/selftests/proc/proc-maps-race.c | 65 +++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >
> > diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/test=
ing/selftests/proc/proc-maps-race.c
> > index 94bba4553130..a546475db550 100644
> > --- a/tools/testing/selftests/proc/proc-maps-race.c
> > +++ b/tools/testing/selftests/proc/proc-maps-race.c
> > @@ -32,6 +32,8 @@
> >  #include <stdlib.h>
> >  #include <string.h>
> >  #include <unistd.h>
> > +#include <linux/fs.h>
> > +#include <sys/ioctl.h>
> >  #include <sys/mman.h>
> >  #include <sys/stat.h>
> >  #include <sys/types.h>
> > @@ -317,6 +319,25 @@ static bool capture_mod_pattern(FIXTURE_DATA(proc_=
maps_race) *self,
> >              strcmp(restored_first_line->text, self->first_line.text) =
=3D=3D 0;
> >  }
> >
> > +static bool query_addr_at(int maps_fd, void *addr,
> > +                       unsigned long *vma_start, unsigned long *vma_en=
d)
> > +{
> > +     struct procmap_query q;
> > +
> > +     memset(&q, 0, sizeof(q));
> > +     q.size =3D sizeof(q);
> > +     /* Find the VMA at the split address */
> > +     q.query_addr =3D (unsigned long long)addr;
> > +     q.query_flags =3D 0;
> > +     if (ioctl(maps_fd, PROCMAP_QUERY, &q))
> > +             return false;
> > +
> > +     *vma_start =3D q.vma_start;
> > +     *vma_end =3D q.vma_end;
> > +
> > +     return true;
> > +}
> > +
> >  static inline bool split_vma(FIXTURE_DATA(proc_maps_race) *self)
> >  {
> >       return mmap(self->mod_info->addr, self->page_size, self->mod_info=
->prot | PROT_EXEC,
> > @@ -559,6 +580,8 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split=
)
> >       do {
> >               bool last_line_changed;
> >               bool first_line_changed;
> > +             unsigned long vma_start;
> > +             unsigned long vma_end;
> >
> >               ASSERT_TRUE(read_boundary_lines(self, &new_last_line, &ne=
w_first_line));
> >
> > @@ -595,6 +618,19 @@ TEST_F(proc_maps_race, test_maps_tearing_from_spli=
t)
> >               first_line_changed =3D strcmp(new_first_line.text, self->=
first_line.text) !=3D 0;
> >               ASSERT_EQ(last_line_changed, first_line_changed);
> >
> > +             /* Check if PROCMAP_QUERY ioclt() finds the right VMA */
>
> Typo ioclt -> ioctl.
>
> I think a little misleading, we're just testing whether we find a VMA at
> mod_info->addr + self->page_size.
>
>
> > +             ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr +=
 self->page_size,
> > +                                       &vma_start, &vma_end));
> > +             /*
> > +              * The vma at the split address can be either the same as
> > +              * original one (if read before the split) or the same as=
 the
> > +              * first line in the second page (if read after the split=
).
> > +              */
> > +             ASSERT_TRUE((vma_start =3D=3D self->last_line.start_addr =
&&
> > +                          vma_end =3D=3D self->last_line.end_addr) ||
> > +                         (vma_start =3D=3D split_first_line.start_addr=
 &&
> > +                          vma_end =3D=3D split_first_line.end_addr));
> > +
>
> So I'd make things clearer here with a comment like:
>
>         We are mmap()'ing a distinct VMA over the start of a 3 page
>         mapping, which will cause the first page to be unmapped, and we c=
an
>         observe two states:
>
>                 read
>                   |
>                   v
>         |---------|------------------|
>         |         |                  |
>         |    A    |         B        | or:
>         |         |                  |
>         |---------|------------------|
>
>                   |
>                   v
>         |----------------------------|
>         |                            |
>         |              A             |
>         |                            |
>         |----------------------------|
>
>         If we see entries in /proc/$pid/maps it'll be:
>
>         7fa86aa15000-7fa86aa16000 rw-p 00000000 00:00 0  (A)
>         7fa86aa16000-7fa86aa18000 rw-p 00000000 00:00 0  (B)
>
>         Or:
>
>         7fa86aa15000-7fa86aa18000 rw-p 00000000 00:00 0  (A)
>
>         So we assert that the reported range is equivalent to one of thes=
e.
>
> Obviously you can mix this in where you feel it makes sense.
>
> >               clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
> >               end_test_iteration(&end_ts, self->verbose);
> >       } while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
> > @@ -636,6 +672,9 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resiz=
e)
> >       clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
> >       start_test_loop(&start_ts, self->verbose);
> >       do {
> > +             unsigned long vma_start;
> > +             unsigned long vma_end;
> > +
> >               ASSERT_TRUE(read_boundary_lines(self, &new_last_line, &ne=
w_first_line));
> >
> >               /* Check if we read vmas after shrinking it */
> > @@ -662,6 +701,16 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resi=
ze)
> >                                       "Expand result invalid", self));
> >               }
> >
> > +             /* Check if PROCMAP_QUERY ioclt() finds the right VMA */
> > +             ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr, =
&vma_start, &vma_end));
>
> Same comments as above.
>
> > +             /*
> > +              * The vma should stay at the same address and have eithe=
r the
> > +              * original size of 3 pages or 1 page if read after shrin=
king.
> > +              */
> > +             ASSERT_TRUE(vma_start =3D=3D self->last_line.start_addr &=
&
> > +                         (vma_end - vma_start =3D=3D self->page_size *=
 3 ||
> > +                          vma_end - vma_start =3D=3D self->page_size))=
;
>
>
> So I'd make things clearer here with a comment like:
>
>         We are shrinking and expanding a VMA from 1 page to 3 pages:
>
>        read
>         |
>         v
>         |---------|
>         |         |
>         |    A    |
>         |         |
>         |---------|
>
>         |
>         v
>         |----------------------------|
>         |                            |
>         |              A             |
>         |                            |
>         |----------------------------|
>
>         If we see entries in /proc/$pid/maps it'll be:
>
>         7fa86aa15000-7fa86aa16000 rw-p 00000000 00:00 0  (A)
>
>         Or:
>
>         7fa86aa15000-7fa86aa18000 rw-p 00000000 00:00 0  (A)
>
>         So we assert that the reported range is equivalent to one of thes=
e.
>
>
> > +
> >               clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
> >               end_test_iteration(&end_ts, self->verbose);
> >       } while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
> > @@ -703,6 +752,9 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap=
)
> >       clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
> >       start_test_loop(&start_ts, self->verbose);
> >       do {
> > +             unsigned long vma_start;
> > +             unsigned long vma_end;
> > +
> >               ASSERT_TRUE(read_boundary_lines(self, &new_last_line, &ne=
w_first_line));
> >
> >               /* Check if we read vmas after remapping it */
> > @@ -729,6 +781,19 @@ TEST_F(proc_maps_race, test_maps_tearing_from_rema=
p)
> >                                       "Remap restore result invalid", s=
elf));
> >               }
> >
> > +             /* Check if PROCMAP_QUERY ioclt() finds the right VMA */
> > +             ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr +=
 self->page_size,
> > +                                       &vma_start, &vma_end));
>
> Same comments as above.
>
>
> > +             /*
> > +              * The vma should either stay at the same address and hav=
e the
> > +              * original size of 3 pages or we should find the remappe=
d vma
> > +              * at the remap destination address with size of 1 page.
> > +              */
> > +             ASSERT_TRUE((vma_start =3D=3D self->last_line.start_addr =
&&
> > +                          vma_end - vma_start =3D=3D self->page_size *=
 3) ||
> > +                         (vma_start =3D=3D self->last_line.start_addr =
+ self->page_size &&
> > +                          vma_end - vma_start =3D=3D self->page_size))=
;
> > +
>
> Again be good to have more explanation here, similar comments to abov.
>
>         We are mremap()'ing the last page of the next VMA (B) into the
>         midle of the current one (A) (using MREMAP_DONTUNMAP leaving the
>         last page of the original VMA zapped but in place:
>
>       read
>         |
>         v             R/W                            R/O
>         |----------------------------| |------------------.---------|
>         |                            | |                  .         |
>         |              A             | |              B   .         |
>         |                            | |                  .         |
>         |----------------------------| |------------------.---------|
>
>         This will unmap the middle of A, splitting it in two, before
>         placing a copy of B there (Which has different prot bits than A):
>
>         |
>         v   R/W       R/O      R/W                   R/O
>         |---------|---------|--------| |----------------------------|
>         |         |         |        | |                            |
>         |    A1   |    B2   |   A2   | |              B             |
>         |         |         |        | |                            |
>         |---------|---------|--------| |----------------------------|
>
>         But then we 'patch' B2 back to R/W prot bits, causing B2 to get
>         merged:
>
>         |
>         v             R/W                            R/O
>         |----------------------------| |----------------------------|
>         |                            | |                            |
>         |              A             | |              B             |
>         |                            | |                            |
>         |----------------------------| |----------------------------|
>
>         If we see entries in /proc/$pid/maps it'll be:
>
>         7fa86aa15000-7fa86aa18000 rw-p 00000000 00:00 0  (A)
>         7fa86aa19000-7fa86aa20000 r--p 00000000 00:00 0  (B)
>
>         Or:
>
>         7fa86aa15000-7fa86aa16000 rw-p 00000000 00:00 0  (A1)
>         7fa86aa16000-7fa86aa17000 r--p 00000000 00:00 0  (B2)
>         7fa86aa17000-7fa86aa18000 rw-p 00000000 00:00 0  (A3)
>         7fa86aa19000-7fa86aa20000 r--p 00000000 00:00 0  (B)
>
>         We are always examining the first line, so we simply assert that
>         this remains in place and we observe 1 page or 3 pages.
>
> >               clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
> >               end_test_iteration(&end_ts, self->verbose);
> >       } while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
> > --
> > 2.50.1.703.g449372360f-goog
> >

