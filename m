Return-Path: <linux-fsdevel+bounces-4687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D16EB801DBD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 17:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BBD9281469
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 16:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4490A21112
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMkNgR8j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351E412E
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Dec 2023 07:06:45 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-67a338dfca7so22106976d6.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Dec 2023 07:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701529604; x=1702134404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcudOB9JkUUlY1ny//imrBUzLwpMxJ+A6w38gq7e7K0=;
        b=HMkNgR8jHSomXsDOfAjTC9Ot8X2WKOCxoPKANnqJUZDMXx6Sc/UCbb34c0janGxTcN
         uFVK9641YormbZNucgQD1EJ/avWaMdmSN1NwzjtVzo0MrPgAraDNuFbfI0mB8slVCvFJ
         2tOnHvzqCLp/mnut3hSRSuOBagTG/Rht09wKJxZZ3QuKzQxj0zvLXDLPKkWYQiNEFMyK
         8fBOsV7ZsLxrwfbWivcn52mYbwI5U3W9Zy9LkjNfBsp+M2R7jb2ppZi3NY/4JDj/8wE1
         ZpFQl0sjKS5fdbpRz+T1eu+CGeYCfv6PFPdjBRQVkAyYg1GFe89LK1O59hyIGVmT0oe0
         LdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701529604; x=1702134404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcudOB9JkUUlY1ny//imrBUzLwpMxJ+A6w38gq7e7K0=;
        b=PIEUDVYKkMHQE/o0j9QJkTgkDjjBykzpfhyZW/6e2eEPFMnKMVh40V7Vxys8a74tvp
         +q7aqjyTPIwv6jIfkF53b4P67VpdyCw6BQyWhnIGlVRxjG3SFV33DzqrFFBLwy/34dYk
         qeib+dCht7NgGPIqjMD0osppT2zWh6R5XAj2QxisKZ6bc9m6xfvpDeovh2sXTZwMyHOM
         1Q2v6HQ3e1wUXjOKQWdwbAV7NNpN5zv96rLG8piXq4JPk1Nz0L3SR0dwPddjLO/555JY
         oKjnMtYkZCkrzAUbIuLYs1rwM3S0cfblrs0EbNWRjgLA4YMDxMLFR38oRwvH13c9gpjs
         MrRw==
X-Gm-Message-State: AOJu0Yz8M6pydQiq/Ms4GFM+a1pPYLXjLx/7Hbdu76AfWwPlM0qPpDl7
	skhUV0D9FNy0tji9IeHhdP6qljfTzVONqVRvoLCXgZDOcSo=
X-Google-Smtp-Source: AGHT+IFJmQcyOubV+Jc9CbYVsQhGymRiZVb7tucii8lsLsikgLo7v0GUbGPjlC2uHxohYl/XUhSNFlJKLr3qV3UJNoE=
X-Received: by 2002:a0c:f810:0:b0:67a:956d:98d5 with SMTP id
 r16-20020a0cf810000000b0067a956d98d5mr1637054qvn.29.1701529604289; Sat, 02
 Dec 2023 07:06:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920024001.493477-1-tfanelli@redhat.com> <CAJfpegtVbmFnjN_eg9U=C1GBB0U5TAAqag3wY_mi7v8rDSGzgg@mail.gmail.com>
 <32469b14-8c7a-4763-95d6-85fd93d0e1b5@fastmail.fm>
In-Reply-To: <32469b14-8c7a-4763-95d6-85fd93d0e1b5@fastmail.fm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 2 Dec 2023 17:06:32 +0200
Message-ID: <CAOQ4uxgW58Umf_ENqpsGrndUB=+8tuUsjT+uCUp16YRSuvG2wQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
To: Bernd Schubert <bernd.schubert@fastmail.fm>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Tyler Fanelli <tfanelli@redhat.com>, linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, 
	gmaglione@redhat.com, hreitz@redhat.com, Hao Xu <howeyxu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 4:08=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> Hi Miklos,
>
> On 9/20/23 10:15, Miklos Szeredi wrote:
> > On Wed, 20 Sept 2023 at 04:41, Tyler Fanelli <tfanelli@redhat.com> wrot=
e:
> >>
> >> At the moment, FUSE_INIT's DIRECT_IO_RELAX flag only serves the purpos=
e
> >> of allowing shared mmap of files opened/created with DIRECT_IO enabled=
.
> >> However, it leaves open the possibility of further relaxing the
> >> DIRECT_IO restrictions (and in-effect, the cache coherency guarantees =
of
> >> DIRECT_IO) in the future.
> >>
> >> The DIRECT_IO_ALLOW_MMAP flag leaves no ambiguity of its purpose. It
> >> only serves to allow shared mmap of DIRECT_IO files, while still
> >> bypassing the cache on regular reads and writes. The shared mmap is th=
e
> >> only loosening of the cache policy that can take place with the flag.
> >> This removes some ambiguity and introduces a more stable flag to be us=
ed
> >> in FUSE_INIT. Furthermore, we can document that to allow shared mmap'i=
ng
> >> of DIRECT_IO files, a user must enable DIRECT_IO_ALLOW_MMAP.
> >>
> >> Tyler Fanelli (2):
> >>    fs/fuse: Rename DIRECT_IO_RELAX to DIRECT_IO_ALLOW_MMAP
> >>    docs/fuse-io: Document the usage of DIRECT_IO_ALLOW_MMAP
> >
> > Looks good.
> >
> > Applied, thanks.  Will send the PR during this merge window, since the
> > rename could break stuff if already released.
>
> I'm just porting back this feature to our internal fuse module and it
> looks these rename patches have been forgotten?
>
>

Hi Miklos, Bernd,

I was looking at the DIRECT_IO_ALLOW_MMAP code and specifically at
commit b5a2a3a0b776 ("fuse: write back dirty pages before direct write in
direct_io_relax mode") and I was wondering - isn't dirty pages writeback
needed *before* invalidate_inode_pages2() in fuse_file_mmap() for
direct_io_allow_mmap case?

For FUSE_PASSTHROUGH, I am going to need to call fuse_vma_close()
for munmap of files also in direct-io mode [1], so I was considering instal=
ling
fuse_file_vm_ops for the FOPEN_DIRECT_IO case, same as caching case,
and regardless of direct_io_allow_mmap.

I was asking myself if there was a good reason why fuse_page_mkwrite()/
fuse_wait_on_page_writeback()/fuse_vma_close()/write_inode_now()
should NOT be called for the FOPEN_DIRECT_IO case regardless of
direct_io_allow_mmap?

I mean, maybe an unmap of a read-only private map does not need to
flush dirty pages (IDK), but caching mode seems to do it anyway?

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAJfpegtOt6MDFM3vsK+syJhpLMSm7wBa=
zkXuxjRTXtAsn9gCuA@mail.gmail.com/

