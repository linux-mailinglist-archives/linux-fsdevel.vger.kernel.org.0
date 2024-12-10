Return-Path: <linux-fsdevel+bounces-36972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25189EB84E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 18:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E772857C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 17:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79E723ED79;
	Tue, 10 Dec 2024 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="K2NJRVAp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A796E23ED55
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851924; cv=none; b=DxCoQdC00JRIyRMx62Kf8vc46BYDtkWOKPo5U3uzjCzpK5NsDFA/BvPURqbHaPNQPBMVRyIwDP8ipiJnpaYOo7T//43saS80QOfx4bkElMyXy64/70n2FS6tPiPWP8+jAIFwkyRK7i/olmnKQuiGAtnW4LeMD9yljuHX3yVFjqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851924; c=relaxed/simple;
	bh=Lk3A2XLb2uwBKq0odBvp1eQZlIF6Qzisjrfiu50ZLMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffIV4UKvCtyE9SDBFXOHeNG25EJLkPS9hoTgyC6yxPIYDWgSN+ZMdk/joecikIZALHJL1/5G9HfXXu+Q/N1kPpmb04DL0BpcAQniRbszuk9iw/QfhjPS4yGZFjEIOxWg2YE15ZVkswF2gmzZGgib2mPZKLEnMTo2Z+hy7bmdgIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=K2NJRVAp; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ef81222aaaso46797427b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 09:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1733851920; x=1734456720; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wi8HJGwMQPJ/54eqOjcxbBjZPjjPx8EpP/ayDod4FA8=;
        b=K2NJRVApnlA89VuKzFVROZncJIwNP0hw4PEgXgKLlA7aliPeEt2pqI/LD8uca7v9iv
         svAO2/VxbpVHXJIvMNyuaVMRf+xdhQhP6lDIm2Y5/qOl4qhFP0TUWlhaQdxfZ+QDyouh
         Y6scYxLunFM/wsNCyHLpZVoKjDC+TzcIKnmgV6WFi50h+HFyD32FtHz5kch5kJ+Am6Y5
         i3b7Gx+CiPCNJL/b8+TiVf2uLMhWP9t01FXAEGYSXBWmtYcdnqkKFvFKwEXOsj0cTNcP
         5RBcrrf1CgvMzPndWkLnAVwQbmXwyDwpkemjVoR5GtWZ5w1Z2N5z2A0NG7FJlgpvawFy
         7o7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733851920; x=1734456720;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wi8HJGwMQPJ/54eqOjcxbBjZPjjPx8EpP/ayDod4FA8=;
        b=ucjlVZhq0GVmFn9TIEc3M7VioQfv0ZUwYamJeDa27jQPbzT6MpusJkcD9bLbwwpjpp
         3RvvHyCVMPXdc1KWVWSREpxgLXsfFdK8DFIQaYgfl3qyLRSHd8d0xpyxPPEOHKiFz62w
         sdyUnyiJKpgBGIW+MbtHEL+r9aw8C/+hwSHe61kHcvFpri4zIvPQCvMKsLwd5byViNy4
         w+P3Rtjo8LBWXFtS0Dew/9ehmCcfsMxfMo7WZF2F7oFDf/DmHFuXSERwND4GvK06gfi/
         rJLkDbCpS2BmYwrR6P4zhGpud4k8X8JrU2NIoxzH0QVcJpE6GdNC8dm2JmLrncUlMsEv
         sTmg==
X-Forwarded-Encrypted: i=1; AJvYcCU5J/qm7ORDjTcKM22r8I9O4UjRvCJgKyGG1deT6Nu7TFxtKy81hwZcRrURvPhRK+vGz1du567R7LJ7dw8F@vger.kernel.org
X-Gm-Message-State: AOJu0YyXJA4e5Rj8Gf7mIdG2kZ54nfgpv5BLOuhYcheuoH0S/9OB1aiH
	kd+tuhKXr1IUIBGzHWLPwarh6qTHfpafNeLMfNtyp+tm8LRx3WY7/YyXN/6EUUs=
X-Gm-Gg: ASbGncuvF+Lq6MoepOYeoHSGecHf2W4lu2zplz0k/P9TzU6ezWcE9PupHXRhBJavRQ1
	GU1+T4/2SY+9hMxHgAwQfaULg0IMq6Q6xeWiOB4+HftyCCxoBuubCv0eg0vwOjS3xloB8u4Tfnc
	QbxgBhLSXDMdly0PFS4yaOepFRKkUNFlbqPL6EzhrDQnwHvT3dM5i/MgIXRZCu89XPBhqiGndSm
	bqvD6+RtsoHTB4bnoWxY7pxiGgZ0Od4vZJu69/JuqP+nLt53fUeiDhSBoTsTQAeK/Q1xu5Dn5qn
	fNSe+eMeC2AhhY4=
X-Google-Smtp-Source: AGHT+IGD03LOks7lsB+LMRb9sAqMSiArwfeoGFX0j8NF1YXmftYlAwdFh8WLdE5AFsFXzUD1vAeLTA==
X-Received: by 2002:a05:690c:7402:b0:6ef:7ac0:1ac1 with SMTP id 00721157ae682-6f022f6b313mr60805867b3.29.1733851919204;
        Tue, 10 Dec 2024 09:31:59 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6efd384e713sm28758417b3.14.2024.12.10.09.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:31:57 -0800 (PST)
Date: Tue, 10 Dec 2024 12:31:51 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Malte =?iso-8859-1?Q?Schr=F6der?= <malte.schroeder@tnxip.de>,
	Matthew Wilcox <willy@infradead.org>,
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: silent data corruption in fuse in rc1
Message-ID: <20241210173151.GA2932546@perftesting>
References: <68a165ea-e58a-40ef-923b-43dfd85ccd68@tnxip.de>
 <2143b747-f4af-4f61-9c3e-a950ab9020cf@tnxip.de>
 <20241209144948.GE2840216@perftesting>
 <Z1cMjlWfehN6ssRb@casper.infradead.org>
 <20241209154850.GA2843669@perftesting>
 <4707aea6-addb-4dc3-96f7-691d2e94ab25@tnxip.de>
 <CAJnrk1apXjQw7LEgSTmjt1xywzjp=+QMfYva4k1x=H0q2S6mag@mail.gmail.com>
 <CAJnrk1YfeNNpt2puwaMRcpDefMVg1AhjYNY4ZsKNqr85=WLXDg@mail.gmail.com>
 <CAJnrk1aF-_N6aBHbuWz0e+z=B4cH3GjZZ60yHRPbctMMG6Ukxw@mail.gmail.com>
 <wfxmi5sqxwoiflnxokte5su2jycoefhgjm4pcp5e7lb5xe4nbd@4lqnzu2r2vmj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wfxmi5sqxwoiflnxokte5su2jycoefhgjm4pcp5e7lb5xe4nbd@4lqnzu2r2vmj>

On Tue, Dec 10, 2024 at 11:54:18AM -0500, Kent Overstreet wrote:
> On Mon, Dec 09, 2024 at 09:14:33PM -0800, Joanne Koong wrote:
> > On Mon, Dec 9, 2024 at 11:52 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> > >
> > > On Mon, Dec 9, 2024 at 10:47 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> > > >
> > > > On Mon, Dec 9, 2024 at 9:07 AM Malte Schröder <malte.schroeder@tnxip.de> wrote:
> > > > >
> > > > > On 09/12/2024 16:48, Josef Bacik wrote:
> > > > > > On Mon, Dec 09, 2024 at 03:28:14PM +0000, Matthew Wilcox wrote:
> > > > > >> On Mon, Dec 09, 2024 at 09:49:48AM -0500, Josef Bacik wrote:
> > > > > >>>> Ha! This time I bisected from f03b296e8b51 to d1dfb5f52ffc. I ended up
> > > > > >>>> with 3b97c3652d91 as the culprit.
> > > > > >>> Willy, I've looked at this code and it does indeed look like a 1:1 conversion,
> > > > > >>> EXCEPT I'm fuzzy about how how this works with large folios.  Previously, if we
> > > > > >>> got a hugepage in, we'd get each individual struct page back for the whole range
> > > > > >>> of the hugepage, so if for example we had a 2M hugepage, we'd fill in the
> > > > > >>> ->offset for each "middle" struct page as 0, since obviously we're consuming
> > > > > >>> PAGE_SIZE chunks at a time.
> > > > > >>>
> > > > > >>> But now we're doing this
> > > > > >>>
> > > > > >>>     for (i = 0; i < nfolios; i++)
> > > > > >>>             ap->folios[i + ap->num_folios] = page_folio(pages[i]);
> > > > > >>>
> > > > > >>> So if userspace handed us a 2M hugepage, page_folio() on each of the
> > > > > >>> intermediary struct page's would return the same folio, correct?  So we'd end up
> > > > > >>> with the wrong offsets for our fuse request, because they should be based from
> > > > > >>> the start of the folio, correct?
> > > > > >> I think you're 100% right.  We could put in some nice asserts to check
> > > > > >> this is what's happening, but it does seem like a rather incautious
> > > > > >> conversion.  Yes, all folios _in the page cache_ for fuse are small, but
> > > > > >> that's not guaranteed to be the case for folios found in userspace for
> > > > > >> directio.  At least the comment is wrong, and I'd suggest the code is too.
> > > > > > Ok cool, Malte can you try the attached only compile tested patch and see if the
> > > > > > problem goes away?  Thanks,
> > > > > >
> > > > > > Josef
> > > > > >
> > > > > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > > > > index 88d0946b5bc9..c4b93ead99a5 100644
> > > > > > --- a/fs/fuse/file.c
> > > > > > +++ b/fs/fuse/file.c
> > > > > > @@ -1562,9 +1562,19 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
> > > > > >               nfolios = DIV_ROUND_UP(ret, PAGE_SIZE);
> > > > > >
> > > > > >               ap->descs[ap->num_folios].offset = start;
> > > > > > -             fuse_folio_descs_length_init(ap->descs, ap->num_folios, nfolios);
> > > > > > -             for (i = 0; i < nfolios; i++)
> > > > > > -                     ap->folios[i + ap->num_folios] = page_folio(pages[i]);
> > > > > > +             for (i = 0; i < nfolios; i++) {
> > > > > > +                     struct folio *folio = page_folio(pages[i]);
> > > > > > +                     unsigned int offset = start +
> > > > > > +                             (folio_page_idx(folio, pages[i]) << PAGE_SHIFT);
> > > > > > +                     unsigned int len = min_t(unsigned int, ret, folio_size(folio) - offset);
> > > > > > +
> > > > > > +                     len = min_t(unsigned int, len, PAGE_SIZE);
> > > > > > +
> > > > > > +                     ap->descs[ap->num_folios + i].offset = offset;
> > > > > > +                     ap->descs[ap->num_folios + i].length = len;
> > > > > > +                     ap->folios[i + ap->num_folios] = folio;
> > > > > > +                     start = 0;
> > > > > > +             }
> > > > > >
> > > > > >               ap->num_folios += nfolios;
> > > > > >               ap->descs[ap->num_folios - 1].length -=
> > > > >
> > > > > The problem persists with this patch.
> > > > >
> > >
> > > Malte, could you try Josef's patch except with that last line
> > > "ap->descs[ap->num_pages - 1].length  -= (PAGE_SIZE - ret) &
> > > (PAGE_SIZE - 1);" also removed? I think we need that line removed as
> > > well since that does a "-=" instead of a "=" and
> > > ap->descs[ap->num_folios - 1].length gets set inside the for loop.
> > >
> > > In the meantime, I'll try to get a local repro running on fsx so that
> > > you don't have to keep testing out repos for us.
> > 
> > I was able to repro this locally by doing:
> > 
> > -- start libfuse server --
> > sudo ./libfuse/build/example/passthrough_hp --direct-io ~/src ~/fuse_mount
> > 
> > -- patch + compile this (rough / ugly-for-now) code snippet --
> > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > index 777ba0de..9f040bc4 100644
> > --- a/ltp/fsx.c
> > +++ b/ltp/fsx.c
> > @@ -1049,7 +1049,8 @@ dowrite(unsigned offset, unsigned size)
> >         }
> >  }
> > 
> > -
> > +#define TWO_MIB (1 << 21)  // 2 MiB in bytes
> > 
> >  void
> >  domapwrite(unsigned offset, unsigned size)
> >  {
> > @@ -1057,6 +1058,8 @@ domapwrite(unsigned offset, unsigned size)
> >         unsigned map_size;
> >         off_t    cur_filesize;
> >         char    *p;
> > +       int ret;
> > +       unsigned size_2mib_aligned;
> > 
> >         offset -= offset % writebdy;
> >         if (size == 0) {
> > @@ -1101,6 +1104,41 @@ domapwrite(unsigned offset, unsigned size)
> >         pg_offset = offset & PAGE_MASK;
> >         map_size  = pg_offset + size;
> > 
> > +       size_2mib_aligned = (size + TWO_MIB - 1) & ~(TWO_MIB - 1);
> > +       void *placeholder_map = mmap(NULL, size_2mib_aligned * 2, PROT_NONE,
> > +                            MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > +       if (!placeholder_map) {
> > +               prterr("domapwrite: placeholder map");
> > +               exit(202);
> > +       }
> > +
> > +       /* align address to nearest 2 MiB */
> > +       void *aligned_address =
> > +               (void *)(((uintptr_t)placeholder_map + TWO_MIB - 1) &
> > ~(TWO_MIB - 1));
> > +
> > +       void *map = mmap(aligned_address, size_2mib_aligned, PROT_READ
> > | PROT_WRITE,
> > +                         MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED |
> > MAP_POPULATE, -1, 0);
> > +
> > +       ret = madvise(map, size_2mib_aligned, MADV_COLLAPSE);
> > +       if (ret) {
> > +               prterr("domapwrite: madvise collapse");
> > +               exit(203);
> > +       }
> > +
> > +       memcpy(map, good_buf + offset, size);
> > +
> > +       if (lseek(fd, offset, SEEK_SET) == -1) {
> > +               prterr("domapwrite: lseek");
> > +               exit(204);
> > +       }
> > +
> > +       ret = write(fd, map, size);
> > +       if (ret == -1) {
> > +               prterr("domapwrite: write");
> > +               exit(205);
> > +       }
> > +
> > +       /*
> >         if ((p = (char *)mmap(0, map_size, PROT_READ | PROT_WRITE,
> >                               MAP_FILE | MAP_SHARED, fd,
> >                               (off_t)(offset - pg_offset))) == (char *)-1) {
> > @@ -1119,6 +1157,15 @@ domapwrite(unsigned offset, unsigned size)
> >                 prterr("domapwrite: munmap");
> >                 report_failure(204);
> >         }
> > +       */
> > +       if (munmap(map, size_2mib_aligned) != 0) {
> > +               prterr("domapwrite: munmap map");
> > +               report_failure(206);
> > +       }
> > +       if (munmap(placeholder_map, size_2mib_aligned * 2) != 0) {
> > +               prterr("domapwrite: munmap placeholder_map");
> > +               report_failure(207);
> > +       }
> >  }
> > 
> > -- run fsx test --
> > sudo ./fsx -b 3 ~/fuse_mount/example.txt -N 5000
> > 
> > On the offending commit 3b97c3652, I'm seeing:
> > [user]$ sudo ./fsx -b 3 ~/fuse_mount/example.txt -N 5000
> > Will begin at operation 3
> > Seed set to 1
> > ...
> > READ BAD DATA: offset = 0x1925f, size = 0xf7a3, fname =
> > /home/user/fuse_mount/example.txt
> > OFFSET      GOOD    BAD     RANGE
> > 0x1e43f     0x4b4a  0x114a  0x0
> > operation# (mod 256) for the bad data may be 74
> > 0x1e441     0xa64a  0xeb4a  0x1
> > operation# (mod 256) for the bad data may be 74
> > 0x1e443     0x264a  0xe44a  0x2
> > operation# (mod 256) for the bad data may be 74
> > 0x1e445     0x254a  0x9e4a  0x3
> > ...
> > Correct content saved for comparison
> > (maybe hexdump "/home/user/fuse_mount/example.txt" vs
> > "/home/user/fuse_mount/example.txt.fsxgood")
> > 
> > 
> > I tested Josef's patch with the "ap->descs[ap->num_pages - 1].length
> > -= (PAGE_SIZE - ret) & (PAGE_SIZE - 1);" line removed and it fixed the
> > issue:
> > 
> > [user]$ sudo ./fsx -b 3 ~/fuse_mount/example.txt -N 5000
> > Will begin at operation 3
> > Seed set to 1
> > ...
> > copying to largest ever: 0x3e19b
> > copying to largest ever: 0x3e343
> > fallocating to largest ever: 0x40000
> > All 5000 operations completed A-OK!
> > 
> > 
> > Malte, would you mind double-checking whether this fixes the issue
> > you're seeing on your end?
> 
> I get the impression you might be flailing a bit, it seems you're not
> exactly sure what's going on, and either Willy or Josef previously
> alluded to a lack of assertions - so I'm going to echo that.
> 
> I've noticed a lot of (more junior?) kernel engineers are hesitant to
> use assertions (because of e.g. checkpatch and "don't crash the
> kernel!"), but assertions are one of the best tools we've got until we
> get to languages where we can do embedded correctness proofs.
> 
> _Especially_ when you're doing tricky data structure work, like all the
> folios stuff. As a lot of us have learned from painful experience, bugs
> in low level data structures can easily translate into silent data
> corruption bugs, so this is a situation where I'd even likely ignore the
> "don't crash the kernel" guidance and prefer BUG_ON() to WARN_ON() -
> crashing is better than silent data corruption, and it makes any bugs
> noisier so they shake out quicker.
> 
> Haven't looked at the relevant patches yet, but if you'd like me to look
> and offer suggestions I'd be happy to.

This is a failure in testing.  And I don't mean "Joanne obviously didn't test
this", I mean that we as a file system community forget that fstests isn't as
exhaustive as we think.  I was honestly surprised to see that we don't actually
have anything that purposely allocates large folios and then does O_DIRECT with
them.  Now we know, Joanne already has followups for extending fsx to purposely
allocate large folios so we can have testing coverage for this case.  Yay
software development, we find gaps, we plug them, we move on.

As an echo to Willy's point, it is a good thing to offer to help and provide
guidance, I applaud the sentiment.  Making comments about the experience level
of the people involved is not helpful and can be seen as condescending.  Thanks,

Josef

