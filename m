Return-Path: <linux-fsdevel+bounces-66416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E2BC1E5F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 05:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BBADE34BFE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 04:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E4130CDA9;
	Thu, 30 Oct 2025 04:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bikLm5pD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D8D2DECDE
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761799234; cv=none; b=Pg/HOkh6U5BDS/jRJ3OAH2N2X5qoq4x7q9ovXdynKh7J+DVfP6dNhpmTwOUvdCHjAgg5DIpp9l1Ptkp8PllQMUavdZvsMQ3viJgj4fUI1oz5vbIwdM23DlBnf1kLjDrPxi+JuX0Rhz9wmUtheT0kR28rNAwDPSQCQoJvq6Jg95s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761799234; c=relaxed/simple;
	bh=y/Np7fA5qgpmYmsQXNaY/VIJLvPs0XEv4eWAJTcrQ+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eApQcOdwyc376Lrru5c6Gefio0XWp0L3fDOzKf8TxUZCLT/TRIDVdlX+TE1NxycTYeZnZH+NlTg1wvoece/e7MeViKYm2Zu3PFPRpo5HzmfiGDH6pj5GkUNkA61wp2B7EKjkfmEmOa42yIzgbZMoAwparXcCNDX+PzxoNnjvRbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bikLm5pD; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ed0c8e4dbcso136781cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 21:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761799231; x=1762404031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQ/blAUtd3RJvFkaQNVmmQwc7XQHf3yHIB6Jvobdagw=;
        b=bikLm5pDK2Ro1WCJJRxxCd5s61D6L7+z0m8SzBwEntjMuDjjaOCL0vI4ljLlAxU5O2
         drpmE78HNpCYMi1J5cSgwaR2c6xLZNsT1wDr4NOnfEHq2ABnhNjESSwsIZbBXeuNBQy1
         NU41iO5JPD/mE1+bT3cZcCaiMuKNu86ywyDix6fAESEhODq142jRas4POI86D2qdOR/J
         q49on8Hugrkfpy98vDZbQVeMbKnioo7jtkYmL4kknsHLH/JLne7vJMSdE4lohSZtJWm4
         Ai7el0c2qIyJc/RgMMweJSYNItjqDtCZik51J1RqX1QkHw78NW6Y9j4/QCR7G2j9lwlf
         0nFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761799231; x=1762404031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQ/blAUtd3RJvFkaQNVmmQwc7XQHf3yHIB6Jvobdagw=;
        b=ejCagrg9OPEIxtO7y3nfqE7gp/WwcikRUVLsxOu8r1zdYX1GZIrtrguCQNNPbxHPif
         Tf+jP7mOum5zAUmThiubTsnNZ/DpaTIiCmw1JAChDrOWItEFh+FObKTGcl/K0nkPN/2e
         ijNxcIZG3id5Qp31gVqNezz9jlYfkgHdN8QzOMHztpQNtKf5XN8xFi0nQrvUishjyyx+
         SVOYqc+3OcaZbxtAqXqpUVdDjpUMXRPIZrGyNlQXjcdIrvXE1vy5bg1+nkQw2d2FANco
         OjtONMYwbQlqd/hHFzdsC9HcLFyfho7eRV94YNrXgAmGr4M4yOzDU4qioBuPMT6URbR4
         T31w==
X-Forwarded-Encrypted: i=1; AJvYcCWTKAdxCV0ZCVdB+iPA1n1gVWlQxih2AbkFxLRV6whW3qANAdPkVINfSKYlBjmW26wkd9nD6qwXF2z0HLjz@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPMIzHj7huZG6xgCo0kAP2mRJuSKvqR4EhCQeqx4zEiUMBJ0a
	wp+qtvSOpGOc908Nv1J4p767xb6l+6J3/NxrVp5DSZhCjHk7WdjrXEkvb95glqY6fDLnOD6mFpq
	t7ng3Qc5IxoOUfynjBY0o4vkqSM35m6lrsgDXcPQt
X-Gm-Gg: ASbGncuNSW+omQr/iCc+H4d4B731QVcXsWNe13yuOXOI/6UGhiBnNTWisBdVXMxIbDH
	t7LpfMNMpugv4/kiHNZblM456jNNUKEfj8ILAl+tpXJF/22nAGYH2ex12TbCbu8U9JSuOR9up4Q
	79XcmmW2E1yzt3/ml0BQiIdxkGnF5PJf81iXFHZuRUGBic2lPfUyA/nfGX4SiD+usC4immolrvU
	T4lZmM4q/UUnMOjW5T8fOozXpnDJDkX8betBfBhpeHTg+vYJV4jf62g7RRB+dh4p6peGA==
X-Google-Smtp-Source: AGHT+IHUTVIoMGgym7Rl26g/BilUAT4CgTBJK8bytma8Yytb4fFlVaJbZIP7eL03YRO77BOZ2/iZU2Eddn/9UG3dHtw=
X-Received: by 2002:a05:622a:1790:b0:4b7:9a9e:833f with SMTP id
 d75a77b69052e-4ed240d674amr2436531cf.7.1761799230462; Wed, 29 Oct 2025
 21:40:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com> <9e5ef2bedbff6498d7e5122421f0ea5ff02236b7.1761756437.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <9e5ef2bedbff6498d7e5122421f0ea5ff02236b7.1761756437.git.lorenzo.stoakes@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 29 Oct 2025 21:40:19 -0700
X-Gm-Features: AWmQ_bk_ynX9lneWpHBfJJexvgQjPhSl6AaFwMQbkIx85JwpdO8ydosQokMaIkg
Message-ID: <CAJuCfpGFAv9DizXOzCn1Qi5=NDyHh6XyxpmsQr0K45LS6x4igg@mail.gmail.com>
Subject: Re: [PATCH 3/3] selftests/mm/guard-regions: add smaps visibility test
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Hildenbrand <david@redhat.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 9:51=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Assert that we observe guard regions appearing in /proc/$pid/smaps as
> expected, and when split/merge is performed too (with expected sticky
> behaviour).
>
> Also add handling for file systems which don't sanely handle mmap() VMA
> merging so we don't incorrectly encounter a test failure in this situatio=
n.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  tools/testing/selftests/mm/guard-regions.c | 120 +++++++++++++++++++++
>  tools/testing/selftests/mm/vm_util.c       |   5 +
>  tools/testing/selftests/mm/vm_util.h       |   1 +
>  3 files changed, 126 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/s=
elftests/mm/guard-regions.c
> index 8dd81c0a4a5a..a9be11e03a6a 100644
> --- a/tools/testing/selftests/mm/guard-regions.c
> +++ b/tools/testing/selftests/mm/guard-regions.c
> @@ -94,6 +94,7 @@ static void *mmap_(FIXTURE_DATA(guard_regions) * self,
>         case ANON_BACKED:
>                 flags |=3D MAP_PRIVATE | MAP_ANON;
>                 fd =3D -1;
> +               offset =3D 0;
>                 break;
>         case SHMEM_BACKED:
>         case LOCAL_FILE_BACKED:
> @@ -260,6 +261,54 @@ static bool is_buf_eq(char *buf, size_t size, char c=
hr)
>         return true;
>  }
>
> +/*
> + * Some file systems have issues with merging due to changing merge-sens=
itive
> + * parameters in the .mmap callback, and prior to .mmap_prepare being
> + * implemented everywhere this will now result in an unexpected failure =
to
> + * merge (e.g. - overlayfs).
> + *
> + * Perform a simple test to see if the local file system suffers from th=
is, if
> + * it does then we can skip test logic that assumes local file system me=
rging is
> + * sane.
> + */
> +static bool local_fs_has_sane_mmap(FIXTURE_DATA(guard_regions) * self,
> +                                  const FIXTURE_VARIANT(guard_regions) *=
 variant)
> +{
> +       const unsigned long page_size =3D self->page_size;
> +       char *ptr, *ptr2;
> +       struct procmap_fd procmap;
> +
> +       if (variant->backing !=3D LOCAL_FILE_BACKED)
> +               return true;
> +
> +       /* Map 10 pages. */
> +       ptr =3D mmap_(self, variant, NULL, 10 * page_size, PROT_READ | PR=
OT_WRITE, 0, 0);
> +       if (ptr =3D=3D MAP_FAILED)
> +               return false;
> +       /* Unmap the middle. */
> +       munmap(&ptr[5 * page_size], page_size);
> +
> +       /* Map again. */
> +       ptr2 =3D mmap_(self, variant, &ptr[5 * page_size], page_size, PRO=
T_READ | PROT_WRITE,
> +                    MAP_FIXED, 5 * page_size);
> +
> +       if (ptr2 =3D=3D MAP_FAILED)
> +               return false;
> +
> +       /* Now make sure they all merged. */
> +       if (open_self_procmap(&procmap) !=3D 0)
> +               return false;
> +       if (!find_vma_procmap(&procmap, ptr))
> +               return false;
> +       if (procmap.query.vma_start !=3D (unsigned long)ptr)
> +               return false;
> +       if (procmap.query.vma_end !=3D (unsigned long)ptr + 10 * page_siz=
e)
> +               return false;
> +       close_procmap(&procmap);
> +
> +       return true;
> +}
> +
>  FIXTURE_SETUP(guard_regions)
>  {
>         self->page_size =3D (unsigned long)sysconf(_SC_PAGESIZE);
> @@ -2138,4 +2187,75 @@ TEST_F(guard_regions, pagemap_scan)
>         ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
>  }
>
> +TEST_F(guard_regions, smaps)
> +{
> +       const unsigned long page_size =3D self->page_size;
> +       struct procmap_fd procmap;
> +       char *ptr, *ptr2;
> +       int i;
> +
> +       /* Map a region. */
> +       ptr =3D mmap_(self, variant, NULL, 10 * page_size, PROT_READ | PR=
OT_WRITE, 0, 0);
> +       ASSERT_NE(ptr, MAP_FAILED);
> +
> +       /* We shouldn't yet see a guard flag. */
> +       ASSERT_FALSE(check_vmflag_guard(ptr));
> +
> +       /* Install a single guard region. */
> +       ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_INSTALL), 0);
> +
> +       /* Now we should see a guard flag. */
> +       ASSERT_TRUE(check_vmflag_guard(ptr));
> +
> +       /*
> +        * Removing the guard region should not change things because we =
simply
> +        * cannot accurately track whether a given VMA has had all of its=
 guard
> +        * regions removed.
> +        */
> +       ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_REMOVE), 0);
> +       ASSERT_TRUE(check_vmflag_guard(ptr));
> +
> +       /* Install guard regions throughout. */
> +       for (i =3D 0; i < 10; i++) {
> +               ASSERT_EQ(madvise(&ptr[i * page_size], page_size, MADV_GU=
ARD_INSTALL), 0);
> +               /* We should always see the guard region flag. */
> +               ASSERT_TRUE(check_vmflag_guard(ptr));
> +       }
> +
> +       /* Split into two VMAs. */
> +       ASSERT_EQ(munmap(&ptr[4 * page_size], page_size), 0);
> +
> +       /* Both VMAs should have the guard flag set. */
> +       ASSERT_TRUE(check_vmflag_guard(ptr));
> +       ASSERT_TRUE(check_vmflag_guard(&ptr[5 * page_size]));
> +
> +       /*
> +        * If the local file system is unable to merge VMAs due to having
> +        * unusual characteristics, there is no point in asserting merge
> +        * behaviour.
> +        */
> +       if (!local_fs_has_sane_mmap(self, variant)) {
> +               TH_LOG("local filesystem does not support sane merging sk=
ipping merge test");
> +               return;
> +       }
> +
> +       /* Map a fresh VMA between the two split VMAs. */
> +       ptr2 =3D mmap_(self, variant, &ptr[4 * page_size], page_size,
> +                    PROT_READ | PROT_WRITE, MAP_FIXED, 4 * page_size);
> +       ASSERT_NE(ptr2, MAP_FAILED);
> +
> +       /*
> +        * Check the procmap to ensure that this VMA merged with the adja=
cent
> +        * two. The guard region flag is 'sticky' so should not preclude
> +        * merging.
> +        */
> +       ASSERT_EQ(open_self_procmap(&procmap), 0);
> +       ASSERT_TRUE(find_vma_procmap(&procmap, ptr));
> +       ASSERT_EQ(procmap.query.vma_start, (unsigned long)ptr);
> +       ASSERT_EQ(procmap.query.vma_end, (unsigned long)ptr + 10 * page_s=
ize);
> +       ASSERT_EQ(close_procmap(&procmap), 0);
> +       /* And, of course, this VMA should have the guard flag set. */
> +       ASSERT_TRUE(check_vmflag_guard(ptr));
> +}
> +
>  TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftes=
ts/mm/vm_util.c
> index e33cda301dad..605cb58ea5c3 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -449,6 +449,11 @@ bool check_vmflag_pfnmap(void *addr)
>         return check_vmflag(addr, "pf");
>  }
>
> +bool check_vmflag_guard(void *addr)
> +{
> +       return check_vmflag(addr, "gu");
> +}
> +
>  bool softdirty_supported(void)
>  {
>         char *addr;
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftes=
ts/mm/vm_util.h
> index 26c30fdc0241..a8abdf414d46 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -98,6 +98,7 @@ int uffd_register_with_ioctls(int uffd, void *addr, uin=
t64_t len,
>  unsigned long get_free_hugepages(void);
>  bool check_vmflag_io(void *addr);
>  bool check_vmflag_pfnmap(void *addr);
> +bool check_vmflag_guard(void *addr);
>  int open_procmap(pid_t pid, struct procmap_fd *procmap_out);
>  int query_procmap(struct procmap_fd *procmap);
>  bool find_vma_procmap(struct procmap_fd *procmap, void *address);
> --
> 2.51.0
>

