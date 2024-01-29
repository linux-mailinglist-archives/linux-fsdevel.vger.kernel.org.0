Return-Path: <linux-fsdevel+bounces-9277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC2383FB3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 01:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2219282E09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 00:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C708C10;
	Mon, 29 Jan 2024 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3fcEKHk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55155256
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706488801; cv=none; b=CtvZgDWguoolyVuetIv0FFDyhlbRdHsDZgdhXCmPQvxm8I9XPPxW+VMC37QKq0y4e6tVFhC1Ug22XrIYF8Q1NVgJyblIAWevenjJfQyhqF+IpjFbI20iDCcifd15JGLSDswXxhf1PnMMyjqc9kbN9d8oTgmuiOpjgt9/CXllimU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706488801; c=relaxed/simple;
	bh=GOR+vztBp9qsOfWG/p7VJatHV1ebL3mS/nkMHAUATnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwI6wuGfEFD2v2oSTDjOekO2AM6CDvu4K9IDI6rdYlOQnjTixNZl2apCd8jZYkVB22xhUTsqnZf5vm7rrkKxu7BRf8enZPBPMZLYnRqGxG8Arc3751scrlORjqWfxv7nOEOu57WGwG5yiNM12kiMVTn2MwsN+q28d26ZFiySaBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3fcEKHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BC6C43394
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 00:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706488801;
	bh=GOR+vztBp9qsOfWG/p7VJatHV1ebL3mS/nkMHAUATnU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S3fcEKHkqEqitRMIVj5hmqHJZU8fhO5OEUusrfOzN27629hkWvh/7fyDdeLi0PZr9
	 n3vr5PXcB47an+jKNzx35aEt0hmZOf9EWGsH5XYeb9ylZl1NWtz4bqsBvWTpD44/lm
	 nT1LsovvG7nanfo1PWWW25GgvPqdNHMVyPJDiLO0zJZETUyw/QsgWENqq+dOaSLyQI
	 zX9iTaHdT580sJjFb1dFA0vAfwPmUzC8iU4yrYfigwYmpILiBfCFgIb1+6MDMKfjxO
	 Z+7cssDVheDauDC40B3Stqn2Awq+CmHEyVgw2Vs0HQVYtQUtE8VYNA5yZ6/gCc8Q/y
	 Y0ksnseRU6AFw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a353f5407f1so137288666b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 16:40:01 -0800 (PST)
X-Gm-Message-State: AOJu0YwQPfZsCp3x/nn7FHZYHYKxR8k3lgVJMRMhwvCiNZ7FUqk6c4Wc
	wpsbtkGOQb/0o4xGm4wpIRb5yz5fiHlO3dNnUPAPwVyi4K4aocPGxzmfGVJg7ZWNrojvGzrBxZF
	mTzC9s0dIK92CzZV9w/qGt8zKWauIzQlncbUb
X-Google-Smtp-Source: AGHT+IEPQs8sUOkrWs+g/b4bMXhiO6ykzksvP2pqvceFjnm3ic5S2cUnErkR5WyrynR1Nl/rh9HjuD9/FYsibH5QMSY=
X-Received: by 2002:a17:906:6810:b0:a31:4cf0:cf81 with SMTP id
 k16-20020a170906681000b00a314cf0cf81mr2993727ejr.37.1706488799959; Sun, 28
 Jan 2024 16:39:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240128142522.1524741-1-ming.lei@redhat.com> <ZbbPCQZdazF7s0_b@casper.infradead.org>
 <ZbbfXVg9FpWRUVDn@redhat.com> <ZbbvfFxcVgkwbhFv@casper.infradead.org>
In-Reply-To: <ZbbvfFxcVgkwbhFv@casper.infradead.org>
From: Mike Snitzer <snitzer@kernel.org>
Date: Sun, 28 Jan 2024 19:39:49 -0500
X-Gmail-Original-Message-ID: <CAH6w=aw_46Ker0w8HmSA41vUUDKGDGC3gxBFWAhd326+kEtrNg@mail.gmail.com>
Message-ID: <CAH6w=aw_46Ker0w8HmSA41vUUDKGDGC3gxBFWAhd326+kEtrNg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/readahead: readahead aggressively if read drops in
 willneed range
To: Matthew Wilcox <willy@infradead.org>
Cc: Mike Snitzer <snitzer@kernel.org>, Ming Lei <ming.lei@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Don Dutile <ddutile@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 7:22=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sun, Jan 28, 2024 at 06:12:29PM -0500, Mike Snitzer wrote:
> > On Sun, Jan 28 2024 at  5:02P -0500,
> > Matthew Wilcox <willy@infradead.org> wrote:
> >
> > > On Sun, Jan 28, 2024 at 10:25:22PM +0800, Ming Lei wrote:
> > > > Since commit 6d2be915e589 ("mm/readahead.c: fix readahead failure f=
or
> > > > memoryless NUMA nodes and limit readahead max_pages"), ADV_WILLNEED
> > > > only tries to readahead 512 pages, and the remained part in the adv=
ised
> > > > range fallback on normal readahead.
> > >
> > > Does the MAINTAINERS file mean nothing any more?
> >
> > "Ming, please use scripts/get_maintainer.pl when submitting patches."
>
> That's an appropriate response to a new contributor, sure.  Ming has
> been submitting patches since, what, 2008?  Surely they know how to
> submit patches by now.
>
> > I agree this patch's header could've worked harder to establish the
> > problem that it fixes.  But I'll now take a crack at backfilling the
> > regression report that motivated this patch be developed:
>
> Thank you.
>
> > Linux 3.14 was the last kernel to allow madvise (MADV_WILLNEED)
> > allowed mmap'ing a file more optimally if read_ahead_kb < max_sectors_k=
b.
> >
> > Ths regressed with commit 6d2be915e589 (so Linux 3.15) such that
> > mounting XFS on a device with read_ahead_kb=3D64 and max_sectors_kb=3D1=
024
> > and running this reproducer against a 2G file will take ~5x longer
> > (depending on the system's capabilities), mmap_load_test.java follows:
> >
> > import java.nio.ByteBuffer;
> > import java.nio.ByteOrder;
> > import java.io.RandomAccessFile;
> > import java.nio.MappedByteBuffer;
> > import java.nio.channels.FileChannel;
> > import java.io.File;
> > import java.io.FileNotFoundException;
> > import java.io.IOException;
> >
> > public class mmap_load_test {
> >
> >         public static void main(String[] args) throws FileNotFoundExcep=
tion, IOException, InterruptedException {
> >               if (args.length =3D=3D 0) {
> >                       System.out.println("Please provide a file");
> >                       System.exit(0);
> >               }
> >               FileChannel fc =3D new RandomAccessFile(new File(args[0])=
, "rw").getChannel();
> >               MappedByteBuffer mem =3D fc.map(FileChannel.MapMode.READ_=
ONLY, 0, fc.size());
> >
> >               System.out.println("Loading the file");
> >
> >               long startTime =3D System.currentTimeMillis();
> >               mem.load();
> >               long endTime =3D System.currentTimeMillis();
> >               System.out.println("Done! Loading took " + (endTime-start=
Time) + " ms");
> >
> >       }
> > }
>
> It's good to have the original reproducer.  The unfortunate part is
> that being at such a high level, it doesn't really show what syscalls
> the library makes on behalf of the application.  I'll take your word
> for it that it calls madvise(MADV_WILLNEED).  An strace might not go
> amiss.
>
> > reproduce with:
> >
> > javac mmap_load_test.java
> > echo 64 > /sys/block/sda/queue/read_ahead_kb
> > echo 1024 > /sys/block/sda/queue/max_sectors_kb
> > mkfs.xfs /dev/sda
> > mount /dev/sda /mnt/test
> > dd if=3D/dev/zero of=3D/mnt/test/2G_file bs=3D1024k count=3D2000
> >
> > echo 3 > /proc/sys/vm/drop_caches
>
> (I prefer to unmount/mount /mnt/test; it drops the cache for
> /mnt/test/2G_file without affecting the rest of the system)
>
> > java mmap_load_test /mnt/test/2G_file
> >
> > Without a fix, like the patch Ming provided, iostat will show rareq-sz
> > is 64 rather than ~1024.
>
> Understood.  But ... the application is asking for as much readahead as
> possible, and the sysadmin has said "Don't readahead more than 64kB at
> a time".  So why will we not get a bug report in 1-15 years time saying
> "I put a limit on readahead and the kernel is ignoring it"?  I think
> typically we allow the sysadmin to override application requests,
> don't we?

The application isn't knowingly asking for readahead.  It is asking to
mmap the file (and reporter wants it done as quickly as possible..
like occurred before).

This fix is comparable to Jens' commit 9491ae4aade6 ("mm: don't cap
request size based on read-ahead setting") -- same logic, just applied
to callchain that ends up using madvise(MADV_WILLNEED).

> > > > @@ -972,6 +974,7 @@ struct file_ra_state {
> > > >   unsigned int ra_pages;
> > > >   unsigned int mmap_miss;
> > > >   loff_t prev_pos;
> > > > + struct maple_tree *need_mt;
> > >
> > > No.  Embed the struct maple tree.  Don't allocate it.
> >
> > Constructive feedback, thanks.
> >
> > > What made you think this was the right approach?
> >
> > But then you closed with an attack, rather than inform Ming and/or
> > others why you feel so strongly, e.g.: Best to keep memory used for
> > file_ra_state contiguous.
>
> That's not an attack, it's a genuine question.  Is there somewhere else
> doing it wrong that Ming copied from?  Does the documentation need to
> be clearer?  I can't fix what I don't know.

OK

