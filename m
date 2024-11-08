Return-Path: <linux-fsdevel+bounces-34108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDB59C279D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 23:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 603F6B2224C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 22:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5126B1EABC5;
	Fri,  8 Nov 2024 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/67EJ11"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B1E233D89
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731105243; cv=none; b=kxCXQKDoOzYV9E+sRCbxwA9SgCkltvMNzaOSjt4oIIaTDBJEd8yLom4KbBHgvry/zSWJ1Wcf0vTTp4RxRCgUgGAggsNWKOyVsrKmaOZipzxxZU8H4UCC1pDodFirId7Hf040TjogHClc+8leqfOFTXiQ7p+16Ck+5UOeiE6jUd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731105243; c=relaxed/simple;
	bh=w7Ze0OgMOMYVj96gN3cZoOIxja+ZZxW+SCa+tYjbIlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=clCCEkqMTTbr0eL/QE+psG59Mhkuv+347+cpifix9d4DTNFfyNE2R7EhzkCc4N/dIV1OZalFIoV3oIK+LZH88V0hRR2q/ZEnoH+vJc4EYyA5OcrYFmDrr1Obz0V9+nCymaZ3rOll585gyOycVwp51NgMv7ETTWa5/tjVi8VwiAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/67EJ11; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4609c96b2e5so17523441cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 14:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731105241; x=1731710041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rtbWxBpUgKg49scbC1SEF5Nn+qd22JpYqesU+kKdH0=;
        b=b/67EJ11KrqTcYo4CDhXqh0wV+vGniMrq/zuuSnbFxfGCfB6SIuwmkYsOQQogEuIMl
         yFkK44YYiGtYp5wrYCYGmXB2+iBrk6OSRVxCJOHa8lHWsOmRDYWikgy3kHT7HbXeAfMA
         9/HCWlKFDXSGp9do0xb1VEWSjYsyn2qqDKgNyvJHkEjmHwLT3PDJdWGapBELagapZpCR
         eXGaCkDEzpyRHb11i4WqbXhg8pup+i9zDgzLvfe1KtGqg/FQOK+/Wb5pbPzuDokZGHk2
         HdrqDhWd3eYEcEo5C/w4LRBMTb270IOghz8LECFKnfpsuV+1N8Lkqm4wLSAnjsIH5VEj
         KqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731105241; x=1731710041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rtbWxBpUgKg49scbC1SEF5Nn+qd22JpYqesU+kKdH0=;
        b=XzzybREs8zhIlfXhmIgiBWe2VAbG7jlHthiikGpJXdfk+d2P1vG2tMjxBVBQ5q/GnT
         ot5kL6UhRyKE2ZmqG6pNUFGfW9C0y7FOMwcwQaWZ02sgX3RUnSNsvvdS//SGadGMT8yq
         kPkBVzweYiMuye8M52mO8hQSsFcOmcRVk93YZon/c2QbF2xGhtisam5LGQjVnzhy71+d
         VDmYBD6+gykV5wpnxLC8QOi8Xw+mCCVInCn9aY0ABVOs5oW5XpsmHo7x0cNm9UVAv7wX
         SHD4Y1UDiTjkHvVLpZasbJnc1Q/SjuRNdOddBlG0uJlWhImGWM7RU/EDjAuwWoj47sVt
         90RA==
X-Forwarded-Encrypted: i=1; AJvYcCXzLL+BVUkh8zrBbytfFLI6d/iujtAAM7Ifa91U2Wamb+64prEfzpAGi2ICTzsLMXx0yJGR4EKSlShSb9d+@vger.kernel.org
X-Gm-Message-State: AOJu0YxLXpv0yHhtdQ9rS7SBcUh7hifETgSzE8n7NA/PZUYbl2nBvsn5
	P4l0YSe72jBEk7F/i6SkJBeZ6k9fHO2ZQ7YHtzQKBDNfpXUaj/SAU9oiWwv4VBCDdTq+8FtS6I8
	lU7WACzcCG+VA+pKVHbCU3v3vnjMF821MM8k=
X-Google-Smtp-Source: AGHT+IGOxEcJXCsO967q4+s9Bc/NC1jzpXnfAnlqf9+eCxrdRKNu1BGRHvOCuzAt16xPvjW0P+s3YUfFHTplTB+md+0=
X-Received: by 2002:ac8:6690:0:b0:463:1561:a0e3 with SMTP id
 d75a77b69052e-4631561a1d2mr14273981cf.19.1731105241006; Fri, 08 Nov 2024
 14:34:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107235614.3637221-1-joannelkoong@gmail.com>
 <20241107235614.3637221-7-joannelkoong@gmail.com> <1b3a36fe-1f62-410c-97fa-d59e7385f683@linux.alibaba.com>
In-Reply-To: <1b3a36fe-1f62-410c-97fa-d59e7385f683@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 8 Nov 2024 14:33:50 -0800
Message-ID: <CAJnrk1YDUEkKRDetmX_5Dw4HkJ+qCkG5WCUHGvp-SWzCo4WLpA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev, 
	josef@toxicpanda.com, linux-mm@kvack.org, bernd.schubert@fastmail.fm, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:49=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
> Hi, Joanne,
>
> Thanks for the continuing work!
>
> On 11/8/24 7:56 AM, Joanne Koong wrote:
> > Currently, we allocate and copy data to a temporary folio when
> > handling writeback in order to mitigate the following deadlock scenario
> > that may arise if reclaim waits on writeback to complete:
> > * single-threaded FUSE server is in the middle of handling a request
> >   that needs a memory allocation
> > * memory allocation triggers direct reclaim
> > * direct reclaim waits on a folio under writeback
> > * the FUSE server can't write back the folio since it's stuck in
> >   direct reclaim
> >
> > To work around this, we allocate a temporary folio and copy over the
> > original folio to the temporary folio so that writeback can be
> > immediately cleared on the original folio. This additionally requires u=
s
> > to maintain an internal rb tree to keep track of writeback state on the
> > temporary folios.
> >
> > A recent change prevents reclaim logic from waiting on writeback for
> > folios whose mappings have the AS_WRITEBACK_MAY_BLOCK flag set in it.
> > This commit sets AS_WRITEBACK_MAY_BLOCK on FUSE inode mappings (which
> > will prevent FUSE folios from running into the reclaim deadlock describ=
ed
> > above) and removes the temporary folio + extra copying and the internal
> > rb tree.
> >
> > fio benchmarks --
> > (using averages observed from 10 runs, throwing away outliers)
> >
> > Setup:
> > sudo mount -t tmpfs -o size=3D30G tmpfs ~/tmp_mount
> >  ./libfuse/build/example/passthrough_ll -o writeback -o max_threads=3D4=
 -o source=3D~/tmp_mount ~/fuse_mount
> >
> > fio --name=3Dwriteback --ioengine=3Dsync --rw=3Dwrite --bs=3D{1k,4k,1M}=
 --size=3D2G
> > --numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1 --directory=3D/roo=
t/fuse_mount
> >
> >         bs =3D  1k          4k            1M
> > Before  351 MiB/s     1818 MiB/s     1851 MiB/s
> > After   341 MiB/s     2246 MiB/s     2685 MiB/s
> > % diff        -3%          23%         45%
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>
>
> > @@ -1622,7 +1543,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, s=
truct iov_iter *iter,
> >                       return res;
> >               }
> >       }
> > -     if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
> > +     if (!cuse && filemap_range_has_writeback(mapping, pos, (pos + cou=
nt - 1))) {
>
> filemap_range_has_writeback() is not equivalent to
> fuse_range_is_writeback(), as it will return true as long as there's any
> locked or dirty page?  I can't find an equivalent helper function at
> hand though.
>

Hi Jingbo,

I couldn't find an equivalent helper function either. My guess is that
filemap_range_has_writeback() returns true if the page is locked
because it doesn't have a way of determining if the page is dirty or
not (it seems like if a page is locked, then we can't read the
writeback bit on it) so it errs on the side of assuming yes.
For this case, it seems okay to me to use
filemap_range_has_writeback() because if we get back a false positive
(eg filemap_range_has_writeback() returns true when it's actually
false), the only cost is the overhead of an additional
fuse_sync_writes() call but fuse_sync_writes() will return immediately
from the wait().

>
>
> > @@ -3423,7 +3143,6 @@ void fuse_init_file_inode(struct inode *inode, un=
signed int flags)
> >       fi->iocachectr =3D 0;
> >       init_waitqueue_head(&fi->page_waitq);
> >       init_waitqueue_head(&fi->direct_io_waitq);
> > -     fi->writepages =3D RB_ROOT;
>
> It seems that 'struct rb_root writepages' is not removed from fuse_inode
> structure.
>

Nice catch! I'll remove this from the fuse_inode struct in v5.

>
> Besides, I also looked through the former 5 patches and can't find any
> obvious errors at the very first glance.  Hopefully the MM guys could
> offer more professional reviews.
>

Thanks for looking through this code in this version and the past
versions of this patchset too. It's much appreciated!

> --
> Thanks,
> Jingbo

