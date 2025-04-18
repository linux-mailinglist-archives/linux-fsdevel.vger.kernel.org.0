Return-Path: <linux-fsdevel+bounces-46700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E51DA93EA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 22:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E7E46816D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 20:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE882248A8;
	Fri, 18 Apr 2025 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j6J+k3TH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFB8CA5E
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745006608; cv=none; b=qb+y5AlwTQ12fOTQyEDxjKQUPrCPl/7RBHUK4CkxAQbhcZYwdIY0rV+h0YreoIfqKI88mpiATLYq0anhLPK0grpi8dGQ0bGD/spJAD5qKk/oSLWqJOhIWgfvkw3J5DFPLfkat3TEJN6W3/FC2VyXMv3uUf+rprDw+5+qQoavQwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745006608; c=relaxed/simple;
	bh=yA/T7O4DUU89cahtyYsKA6d+y8ammt9lMcd1G0ztWT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpyVmmBY7hm2fBcuJJjF0r87jpzs31uCljomniDAgmaCpaCGE462p18QuwA4tcpJOr7dRQiWfcFxBUxUZsko9gH+Wt+LsQ7fTR1uICmoh+suPlS7K3THcr1Xf/eAWHxMSl7R6rbwiPu9BlhXvk4EwtwsBTXO2nEkGjWV4fXZ9nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j6J+k3TH; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4769e30af66so513621cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 13:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745006606; x=1745611406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+oOpqVmU39D7pSdmadeSMDPqu3kAnHCqdURVPU0NY8=;
        b=j6J+k3THLPTYaB5oHWEZ49Yz961fki+268FnpW28n+qUt8b6xySUHxOO0ATBSr2c5Z
         f5Wij4zjZhI2OWTcZPQZsCT1Fu0sFR0Uh2lfhBINvrB8KydNbZGUWgEIWDU6gn3BwLmu
         K+90uwI+xGxaEEfNnTHKDVofjNzE8Bwd3LAFGwwGuSoRK9JopSDX4CmB5x3GbysXcPQe
         VBW4Df3E2kKP2kQSqV1g31rjs5DXj05HIjJ16G6Vv4E8DtsdRbf9bepWs3a4tggzf7Su
         KuHk3yUQWeRcEiGZz6T8Lqurnza+eExd6luZ197I7wGNAMClGYS2qtzIqRKjZRQFHQXp
         sDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745006606; x=1745611406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+oOpqVmU39D7pSdmadeSMDPqu3kAnHCqdURVPU0NY8=;
        b=Fa8mdOj1ZWaV8dLoHNpS4oTn/OLseI5kBAd1yCMwvcgGVRtFT+s2RCnpx7Bb2s0H8T
         TSwU1rBBo7htwfngnJHi7rl89YWWiQXeEvP9FWXC2mXLG//3om07oU3NHg6qS18Y/lMN
         vNtaEb68CIhNs2xtc6FQMbErApVrRDNYvrw8F8g829FK34fGiOQuoY4XrDLtDNHifBCk
         S7LZ30m212aPng+wFArWdPd3OiKNcvEXhUeIxYEYtheZamerYvuV3jgn8XXiz7eGB1Dl
         vELjEEAb4JmwtWqesvdQx6O51koSxHZCjGza2k06lf6IRrrzcSc0sy6Zbl4nXfcOB4j9
         VMuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFP1ychx+D1isKt35e3yFkBrCPthg74iDVhYUwF1fL9NKuFGmP6IlP5Uu4GZPQXvJd4w+n9JvIH1u6wF5Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4cNW36PfQFrxCycQQ1hMytKR06fUjlqRv3j+Pup3RYtYKT0+H
	g8xNPo0vYLcTwrheNkUujGLdzs15TeC2eoKr04lbYgnk/SQtaTf96CiTBFPMyBdF+5fCBIunntF
	wvlTv1hMdAa/Z/3wytWD6E2hF+t56V7bYY7bq
X-Gm-Gg: ASbGncvojvOTmY+fy4UR060cf14nJjraYrQR57sM+N2BgQORRMHadDeB1HKxjPZJW8n
	MiZUYvJ6LO7Ytt29jlZCCwrKmC9Y25A9sWlumAMqAuhnlL/CT3zUOfF7Zr/vwyAlzCBXF26L2zl
	s9tpHdzHHUYmntLNFnDeW+
X-Google-Smtp-Source: AGHT+IEp1qePU0PupxqAwvljmN3koti1+LUS4DXKxAoFbiSXRYU93X8EtDbhsmQD9vTQaLe5ynHWCwoNQz4TkmLkIk8=
X-Received: by 2002:a05:622a:491:b0:476:f4e9:314e with SMTP id
 d75a77b69052e-47aecc92a27mr4420151cf.25.1745006605364; Fri, 18 Apr 2025
 13:03:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-4-surenb@google.com>
 <5958fb2d-a2ac-4a24-8595-222d7e298951@lucifer.local> <CAJuCfpEwnbKA1y-iMs+ky465-Ok5j_f4ojaZV60yap2QGbfpmQ@mail.gmail.com>
 <361e32be-7faa-41e5-a64f-fa95317abdb8@lucifer.local>
In-Reply-To: <361e32be-7faa-41e5-a64f-fa95317abdb8@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 18 Apr 2025 13:03:14 -0700
X-Gm-Features: ATxdqUEenzbjQtOpE6Q6rVXg11gqNC0rtlK0DuSQk3YtHt5FbZ3QGSYLe-E2TGU
Message-ID: <CAJuCfpHLMErQTwfZyLRVn+Rg5zYEHQK34dbX-QxavqUJYek=OQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] selftests/proc: extend /proc/pid/maps tearing test
 to include vma remapping
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 12:56=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Apr 18, 2025 at 12:31:29PM -0700, Suren Baghdasaryan wrote:
> > On Fri, Apr 18, 2025 at 11:30=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Fri, Apr 18, 2025 at 10:49:54AM -0700, Suren Baghdasaryan wrote:
> > > > Test that /proc/pid/maps does not report unexpected holes in the ad=
dress
> > > > space when we concurrently remap a part of a vma into the middle of
> > > > another vma. This remapping results in the destination vma being sp=
lit
> > > > into three parts and the part in the middle being patched back from=
,
> > > > all done concurrently from under the reader. We should always see e=
ither
> > > > original vma or the split one with no holes.
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >
> > > Umm, but we haven't fixed this in the mremap code right? :) So isn't =
this test
> > > failing right now? :P
> > >
> > > My understanding from meeting was you'd drop this commit/mark it skip=
ped
> > > for now or something like this?
> >
> > After you pointed out the issue in mremap_to() I spent some time
> > investigating that code. IIUC the fact that mremap_to() does
> > do_munmap() and move_vma() as two separate operations should not
> > affect lockless reading because both those operations are done under
> > mmap_write_lock() without dropping it in between. Since my lockless
> > mechanism uses mmap_lock_speculate_xxx API to detect address space
> > modifications and retry if concurrent update happen, it should be able
> > to handle this case. The vma it reports should be either the version
> > before mmap_write_lock was taken (before the mremap()) or after it got
> > dropped (after mremap() is complete). Did I miss something more
> > subtle?
>
> Speaking to Liam, seems perhaps the implementation has changed since we f=
irst
> started looking at this?
>
> I guess it's this speculation stuff that keeps you safe then, yeah we hol=
d the
> write lock over both.
>
> So actually ideal if we can avoid having to fix up the mremap implementat=
ion!
>
> If you're sure that the speculation combined with mmap write lock keeps u=
s safe
> then we should be ok I'd say.

Yeah, I tested that quite rigorously and confirmed (using the
mm->mm_lock_seq) that mmap_write_lock is not dropped somewhere in the
middle of those operations. I think we should be safe.

>
> >
> > >
> > > > ---
> > > >  tools/testing/selftests/proc/proc-pid-vm.c | 92 ++++++++++++++++++=
++++
> > > >  1 file changed, 92 insertions(+)
> > > >
> > > > diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/tes=
ting/selftests/proc/proc-pid-vm.c
> > > > index 39842e4ec45f..1aef2db7e893 100644
> > > > --- a/tools/testing/selftests/proc/proc-pid-vm.c
> > > > +++ b/tools/testing/selftests/proc/proc-pid-vm.c
> > > > @@ -663,6 +663,95 @@ static void test_maps_tearing_from_resize(int =
maps_fd,
> > > >       signal_state(mod_info, TEST_DONE);
> > > >  }
> > > >
> > > > +static inline void remap_vma(const struct vma_modifier_info *mod_i=
nfo)
> > > > +{
> > > > +     /*
> > > > +      * Remap the last page of the next vma into the middle of the=
 vma.
> > > > +      * This splits the current vma and the first and middle parts=
 (the
> > > > +      * parts at lower addresses) become the last vma objserved in=
 the
> > > > +      * first page and the first vma observed in the last page.
> > > > +      */
> > > > +     assert(mremap(mod_info->next_addr + page_size * 2, page_size,
> > > > +                   page_size, MREMAP_FIXED | MREMAP_MAYMOVE | MREM=
AP_DONTUNMAP,
> > > > +                   mod_info->addr + page_size) !=3D MAP_FAILED);
> > > > +}
> > > > +
> > > > +static inline void patch_vma(const struct vma_modifier_info *mod_i=
nfo)
> > > > +{
> > > > +     assert(!mprotect(mod_info->addr + page_size, page_size,
> > > > +                      mod_info->prot));
> > > > +}
> > > > +
> > > > +static inline void check_remap_result(struct line_content *mod_las=
t_line,
> > > > +                                   struct line_content *mod_first_=
line,
> > > > +                                   struct line_content *restored_l=
ast_line,
> > > > +                                   struct line_content *restored_f=
irst_line)
> > > > +{
> > > > +     /* Make sure vmas at the boundaries are changing */
> > > > +     assert(strcmp(mod_last_line->text, restored_last_line->text) =
!=3D 0);
> > > > +     assert(strcmp(mod_first_line->text, restored_first_line->text=
) !=3D 0);
> > > > +}
> > > > +
> > > > +static void test_maps_tearing_from_remap(int maps_fd,
> > > > +                             struct vma_modifier_info *mod_info,
> > > > +                             struct page_content *page1,
> > > > +                             struct page_content *page2,
> > > > +                             struct line_content *last_line,
> > > > +                             struct line_content *first_line)
> > > > +{
> > > > +     struct line_content remapped_last_line;
> > > > +     struct line_content remapped_first_line;
> > > > +     struct line_content restored_last_line;
> > > > +     struct line_content restored_first_line;
> > > > +
> > > > +     wait_for_state(mod_info, SETUP_READY);
> > > > +
> > > > +     /* re-read the file to avoid using stale data from previous t=
est */
> > > > +     read_boundary_lines(maps_fd, page1, page2, last_line, first_l=
ine);
> > > > +
> > > > +     mod_info->vma_modify =3D remap_vma;
> > > > +     mod_info->vma_restore =3D patch_vma;
> > > > +     mod_info->vma_mod_check =3D check_remap_result;
> > > > +
> > > > +     capture_mod_pattern(maps_fd, mod_info, page1, page2, last_lin=
e, first_line,
> > > > +                         &remapped_last_line, &remapped_first_line=
,
> > > > +                         &restored_last_line, &restored_first_line=
);
> > > > +
> > > > +     /* Now start concurrent modifications for test_duration_sec *=
/
> > > > +     signal_state(mod_info, TEST_READY);
> > > > +
> > > > +     struct line_content new_last_line;
> > > > +     struct line_content new_first_line;
> > > > +     struct timespec start_ts, end_ts;
> > > > +
> > > > +     clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
> > > > +     do {
> > > > +             read_boundary_lines(maps_fd, page1, page2, &new_last_=
line, &new_first_line);
> > > > +
> > > > +             /* Check if we read vmas after remapping it */
> > > > +             if (!strcmp(new_last_line.text, remapped_last_line.te=
xt)) {
> > > > +                     /*
> > > > +                      * The vmas should be consistent with remap r=
esults,
> > > > +                      * however if the vma was concurrently restor=
ed, it
> > > > +                      * can be reported twice (first as split one,=
 then
> > > > +                      * as restored one) because we found it as th=
e next vma
> > > > +                      * again. In that case new first line will be=
 the same
> > > > +                      * as the last restored line.
> > > > +                      */
> > > > +                     assert(!strcmp(new_first_line.text, remapped_=
first_line.text) ||
> > > > +                            !strcmp(new_first_line.text, restored_=
last_line.text));
> > > > +             } else {
> > > > +                     /* The vmas should be consistent with the ori=
ginal/resored state */
> > > > +                     assert(!strcmp(new_last_line.text, restored_l=
ast_line.text) &&
> > > > +                            !strcmp(new_first_line.text, restored_=
first_line.text));
> > > > +             }
> > > > +             clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
> > > > +     } while (end_ts.tv_sec - start_ts.tv_sec < test_duration_sec)=
;
> > > > +
> > > > +     /* Signal the modifyer thread to stop and wait until it exits=
 */
> > > > +     signal_state(mod_info, TEST_DONE);
> > > > +}
> > > > +
> > > >  static int test_maps_tearing(void)
> > > >  {
> > > >       struct vma_modifier_info *mod_info;
> > > > @@ -757,6 +846,9 @@ static int test_maps_tearing(void)
> > > >       test_maps_tearing_from_resize(maps_fd, mod_info, &page1, &pag=
e2,
> > > >                                     &last_line, &first_line);
> > > >
> > > > +     test_maps_tearing_from_remap(maps_fd, mod_info, &page1, &page=
2,
> > > > +                                  &last_line, &first_line);
> > > > +
> > > >       stop_vma_modifier(mod_info);
> > > >
> > > >       free(page2.data);
> > > > --
> > > > 2.49.0.805.g082f7c87e0-goog
> > > >

