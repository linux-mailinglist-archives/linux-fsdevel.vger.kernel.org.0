Return-Path: <linux-fsdevel+bounces-36959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5658A9EB737
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 17:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1001C284A1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5081A231CA0;
	Tue, 10 Dec 2024 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fs9q4pkX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BD822FE07
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849669; cv=none; b=AkIxNYeiKQslvdPstb8tmydpGHmUfW6cPejhI1hrmYzWfdbGz6hCXR0VHLpcdLCcQSCQ4fAk66GEQGGDO6ou38wr/d3lM4Mp9Gp9UVfcxAeaJulTdDAZY1CH9hpgh+v74nj3DKngEzjxOVXn1f2UKRsFzxmWPvm5o/P1PJZDlps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849669; c=relaxed/simple;
	bh=VQZ8ySLZ2n1OWD83ytoTqfWeVcDkPvOcFvM8Ghl5bzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZ3PtzJj3a5QGbnwiioW4oca9In5fzHMPs2tEqn9gyrZ/jn8L7Fm+xruBtuYvhz/j1oNTcKQChvcAuBishH1pI2VkioZciEkfKOOumiZV6TRxl8+Cp4+DSLUtDiOM6IZymFu0EDctYm4vHsLRPvvAl/fG5ZplJQj0VekDHPhfT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fs9q4pkX; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Dec 2024 11:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733849664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XM2VxUxgl5deJhKdTR5V+OfXBBksPP4VmyCfZFzv1DY=;
	b=Fs9q4pkXBS7OTIer+cH1FvT614Iga+YjLEgG9FrHnT92V8wDDxdcn8cP+/nZqggpTyKUQO
	57QGBW1w2TvduGnf7S4I4dYhHLS4rwCKBZupfMcdrfTR2c0nni6tZv+z+X6xyqee+DS6oC
	XEurCMB6S1kZYkMIqir44/g8A1K8LWY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Malte =?utf-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>, 
	Josef Bacik <josef@toxicpanda.com>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: silent data corruption in fuse in rc1
Message-ID: <wfxmi5sqxwoiflnxokte5su2jycoefhgjm4pcp5e7lb5xe4nbd@4lqnzu2r2vmj>
References: <Z1T09X8l3H5Wnxbv@casper.infradead.org>
 <68a165ea-e58a-40ef-923b-43dfd85ccd68@tnxip.de>
 <2143b747-f4af-4f61-9c3e-a950ab9020cf@tnxip.de>
 <20241209144948.GE2840216@perftesting>
 <Z1cMjlWfehN6ssRb@casper.infradead.org>
 <20241209154850.GA2843669@perftesting>
 <4707aea6-addb-4dc3-96f7-691d2e94ab25@tnxip.de>
 <CAJnrk1apXjQw7LEgSTmjt1xywzjp=+QMfYva4k1x=H0q2S6mag@mail.gmail.com>
 <CAJnrk1YfeNNpt2puwaMRcpDefMVg1AhjYNY4ZsKNqr85=WLXDg@mail.gmail.com>
 <CAJnrk1aF-_N6aBHbuWz0e+z=B4cH3GjZZ60yHRPbctMMG6Ukxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aF-_N6aBHbuWz0e+z=B4cH3GjZZ60yHRPbctMMG6Ukxw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 09, 2024 at 09:14:33PM -0800, Joanne Koong wrote:
> On Mon, Dec 9, 2024 at 11:52 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > On Mon, Dec 9, 2024 at 10:47 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> > >
> > > On Mon, Dec 9, 2024 at 9:07 AM Malte Schröder <malte.schroeder@tnxip.de> wrote:
> > > >
> > > > On 09/12/2024 16:48, Josef Bacik wrote:
> > > > > On Mon, Dec 09, 2024 at 03:28:14PM +0000, Matthew Wilcox wrote:
> > > > >> On Mon, Dec 09, 2024 at 09:49:48AM -0500, Josef Bacik wrote:
> > > > >>>> Ha! This time I bisected from f03b296e8b51 to d1dfb5f52ffc. I ended up
> > > > >>>> with 3b97c3652d91 as the culprit.
> > > > >>> Willy, I've looked at this code and it does indeed look like a 1:1 conversion,
> > > > >>> EXCEPT I'm fuzzy about how how this works with large folios.  Previously, if we
> > > > >>> got a hugepage in, we'd get each individual struct page back for the whole range
> > > > >>> of the hugepage, so if for example we had a 2M hugepage, we'd fill in the
> > > > >>> ->offset for each "middle" struct page as 0, since obviously we're consuming
> > > > >>> PAGE_SIZE chunks at a time.
> > > > >>>
> > > > >>> But now we're doing this
> > > > >>>
> > > > >>>     for (i = 0; i < nfolios; i++)
> > > > >>>             ap->folios[i + ap->num_folios] = page_folio(pages[i]);
> > > > >>>
> > > > >>> So if userspace handed us a 2M hugepage, page_folio() on each of the
> > > > >>> intermediary struct page's would return the same folio, correct?  So we'd end up
> > > > >>> with the wrong offsets for our fuse request, because they should be based from
> > > > >>> the start of the folio, correct?
> > > > >> I think you're 100% right.  We could put in some nice asserts to check
> > > > >> this is what's happening, but it does seem like a rather incautious
> > > > >> conversion.  Yes, all folios _in the page cache_ for fuse are small, but
> > > > >> that's not guaranteed to be the case for folios found in userspace for
> > > > >> directio.  At least the comment is wrong, and I'd suggest the code is too.
> > > > > Ok cool, Malte can you try the attached only compile tested patch and see if the
> > > > > problem goes away?  Thanks,
> > > > >
> > > > > Josef
> > > > >
> > > > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > > > index 88d0946b5bc9..c4b93ead99a5 100644
> > > > > --- a/fs/fuse/file.c
> > > > > +++ b/fs/fuse/file.c
> > > > > @@ -1562,9 +1562,19 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
> > > > >               nfolios = DIV_ROUND_UP(ret, PAGE_SIZE);
> > > > >
> > > > >               ap->descs[ap->num_folios].offset = start;
> > > > > -             fuse_folio_descs_length_init(ap->descs, ap->num_folios, nfolios);
> > > > > -             for (i = 0; i < nfolios; i++)
> > > > > -                     ap->folios[i + ap->num_folios] = page_folio(pages[i]);
> > > > > +             for (i = 0; i < nfolios; i++) {
> > > > > +                     struct folio *folio = page_folio(pages[i]);
> > > > > +                     unsigned int offset = start +
> > > > > +                             (folio_page_idx(folio, pages[i]) << PAGE_SHIFT);
> > > > > +                     unsigned int len = min_t(unsigned int, ret, folio_size(folio) - offset);
> > > > > +
> > > > > +                     len = min_t(unsigned int, len, PAGE_SIZE);
> > > > > +
> > > > > +                     ap->descs[ap->num_folios + i].offset = offset;
> > > > > +                     ap->descs[ap->num_folios + i].length = len;
> > > > > +                     ap->folios[i + ap->num_folios] = folio;
> > > > > +                     start = 0;
> > > > > +             }
> > > > >
> > > > >               ap->num_folios += nfolios;
> > > > >               ap->descs[ap->num_folios - 1].length -=
> > > >
> > > > The problem persists with this patch.
> > > >
> >
> > Malte, could you try Josef's patch except with that last line
> > "ap->descs[ap->num_pages - 1].length  -= (PAGE_SIZE - ret) &
> > (PAGE_SIZE - 1);" also removed? I think we need that line removed as
> > well since that does a "-=" instead of a "=" and
> > ap->descs[ap->num_folios - 1].length gets set inside the for loop.
> >
> > In the meantime, I'll try to get a local repro running on fsx so that
> > you don't have to keep testing out repos for us.
> 
> I was able to repro this locally by doing:
> 
> -- start libfuse server --
> sudo ./libfuse/build/example/passthrough_hp --direct-io ~/src ~/fuse_mount
> 
> -- patch + compile this (rough / ugly-for-now) code snippet --
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 777ba0de..9f040bc4 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -1049,7 +1049,8 @@ dowrite(unsigned offset, unsigned size)
>         }
>  }
> 
> -
> +#define TWO_MIB (1 << 21)  // 2 MiB in bytes
> 
>  void
>  domapwrite(unsigned offset, unsigned size)
>  {
> @@ -1057,6 +1058,8 @@ domapwrite(unsigned offset, unsigned size)
>         unsigned map_size;
>         off_t    cur_filesize;
>         char    *p;
> +       int ret;
> +       unsigned size_2mib_aligned;
> 
>         offset -= offset % writebdy;
>         if (size == 0) {
> @@ -1101,6 +1104,41 @@ domapwrite(unsigned offset, unsigned size)
>         pg_offset = offset & PAGE_MASK;
>         map_size  = pg_offset + size;
> 
> +       size_2mib_aligned = (size + TWO_MIB - 1) & ~(TWO_MIB - 1);
> +       void *placeholder_map = mmap(NULL, size_2mib_aligned * 2, PROT_NONE,
> +                            MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +       if (!placeholder_map) {
> +               prterr("domapwrite: placeholder map");
> +               exit(202);
> +       }
> +
> +       /* align address to nearest 2 MiB */
> +       void *aligned_address =
> +               (void *)(((uintptr_t)placeholder_map + TWO_MIB - 1) &
> ~(TWO_MIB - 1));
> +
> +       void *map = mmap(aligned_address, size_2mib_aligned, PROT_READ
> | PROT_WRITE,
> +                         MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED |
> MAP_POPULATE, -1, 0);
> +
> +       ret = madvise(map, size_2mib_aligned, MADV_COLLAPSE);
> +       if (ret) {
> +               prterr("domapwrite: madvise collapse");
> +               exit(203);
> +       }
> +
> +       memcpy(map, good_buf + offset, size);
> +
> +       if (lseek(fd, offset, SEEK_SET) == -1) {
> +               prterr("domapwrite: lseek");
> +               exit(204);
> +       }
> +
> +       ret = write(fd, map, size);
> +       if (ret == -1) {
> +               prterr("domapwrite: write");
> +               exit(205);
> +       }
> +
> +       /*
>         if ((p = (char *)mmap(0, map_size, PROT_READ | PROT_WRITE,
>                               MAP_FILE | MAP_SHARED, fd,
>                               (off_t)(offset - pg_offset))) == (char *)-1) {
> @@ -1119,6 +1157,15 @@ domapwrite(unsigned offset, unsigned size)
>                 prterr("domapwrite: munmap");
>                 report_failure(204);
>         }
> +       */
> +       if (munmap(map, size_2mib_aligned) != 0) {
> +               prterr("domapwrite: munmap map");
> +               report_failure(206);
> +       }
> +       if (munmap(placeholder_map, size_2mib_aligned * 2) != 0) {
> +               prterr("domapwrite: munmap placeholder_map");
> +               report_failure(207);
> +       }
>  }
> 
> -- run fsx test --
> sudo ./fsx -b 3 ~/fuse_mount/example.txt -N 5000
> 
> On the offending commit 3b97c3652, I'm seeing:
> [user]$ sudo ./fsx -b 3 ~/fuse_mount/example.txt -N 5000
> Will begin at operation 3
> Seed set to 1
> ...
> READ BAD DATA: offset = 0x1925f, size = 0xf7a3, fname =
> /home/user/fuse_mount/example.txt
> OFFSET      GOOD    BAD     RANGE
> 0x1e43f     0x4b4a  0x114a  0x0
> operation# (mod 256) for the bad data may be 74
> 0x1e441     0xa64a  0xeb4a  0x1
> operation# (mod 256) for the bad data may be 74
> 0x1e443     0x264a  0xe44a  0x2
> operation# (mod 256) for the bad data may be 74
> 0x1e445     0x254a  0x9e4a  0x3
> ...
> Correct content saved for comparison
> (maybe hexdump "/home/user/fuse_mount/example.txt" vs
> "/home/user/fuse_mount/example.txt.fsxgood")
> 
> 
> I tested Josef's patch with the "ap->descs[ap->num_pages - 1].length
> -= (PAGE_SIZE - ret) & (PAGE_SIZE - 1);" line removed and it fixed the
> issue:
> 
> [user]$ sudo ./fsx -b 3 ~/fuse_mount/example.txt -N 5000
> Will begin at operation 3
> Seed set to 1
> ...
> copying to largest ever: 0x3e19b
> copying to largest ever: 0x3e343
> fallocating to largest ever: 0x40000
> All 5000 operations completed A-OK!
> 
> 
> Malte, would you mind double-checking whether this fixes the issue
> you're seeing on your end?

I get the impression you might be flailing a bit, it seems you're not
exactly sure what's going on, and either Willy or Josef previously
alluded to a lack of assertions - so I'm going to echo that.

I've noticed a lot of (more junior?) kernel engineers are hesitant to
use assertions (because of e.g. checkpatch and "don't crash the
kernel!"), but assertions are one of the best tools we've got until we
get to languages where we can do embedded correctness proofs.

_Especially_ when you're doing tricky data structure work, like all the
folios stuff. As a lot of us have learned from painful experience, bugs
in low level data structures can easily translate into silent data
corruption bugs, so this is a situation where I'd even likely ignore the
"don't crash the kernel" guidance and prefer BUG_ON() to WARN_ON() -
crashing is better than silent data corruption, and it makes any bugs
noisier so they shake out quicker.

Haven't looked at the relevant patches yet, but if you'd like me to look
and offer suggestions I'd be happy to.

