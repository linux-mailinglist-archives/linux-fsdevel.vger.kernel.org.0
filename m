Return-Path: <linux-fsdevel+bounces-4619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FC7801678
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361A21F21005
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CD73F8C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Inm+JbqU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D991D10D0
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:07:38 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cde11fb647so2663078b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701468458; x=1702073258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YQfhMuRIsbbhA4byoTnf3ILysjsRNS3/HHA853GOzAw=;
        b=Inm+JbqUEbLotO33+3ph5QBp9+pGeMBsAjteoY+2Kw1/u8nKSa1iimV7dkbevZ7SW1
         Hs6XygpS8kfGMNbCi/uYixbefpCsE1iaJfVbP3niSPCfxOrEpRJjLaVRVP8+eg3umRuD
         SLeimMybkiUCL3b7q25MQMOxLNU9KtXQdeOWW51axpxG+Bgz19NxRJIMWjhO4VQNDk/t
         TuYmq/JIdNV53/Qc2X4yn7cFhu66f9cVut4kG1pp38KOTWaKw/ahH1TZFUNa54u5LS9g
         GgREGEO42kXKas4TctciR27zGBQT1jia0lnCtgaVFi6rMCWeZXFop/jL/HsO3XPdlddo
         J4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468458; x=1702073258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQfhMuRIsbbhA4byoTnf3ILysjsRNS3/HHA853GOzAw=;
        b=EVZZvspnRwqUJXLNJHqXFd6CIeOuDuYafQEW1EprimKxLVniVKY5H03Ld/n/Py4qck
         IUBDGyQuwoPQs+VZ2XRJDoTk5fXkSQNQbcJQ1WFKU84/Z5tHGvhspZA4+Ylsx0T56BIo
         BGML0j1qK5s1qK4djZy8mYSQq5BLKC9Tr9ONWljRmpR9Us8w0x60IrV5WJ571GSXzbvR
         PqXDorXvUYtz8b8fmkLsWZwNlAqaTNXGmzud5JjoPeZZT736qk0TvEF2v5QlfknNICkE
         KCVROtuu9T7DByTUgscQW2l/tuJ3oAdbxrE8YLnhjbP6HCobxeC/LT1QklhMCXheJf3E
         naGA==
X-Gm-Message-State: AOJu0Yz/xqILVvr+H62u+lsp+qXmc63hjjd4c+p9+QIXwc/lCAhRJNYg
	9ugUMBbC3ehqvRcqyqtrKKZp29PMlw+3GOrb4RQ=
X-Google-Smtp-Source: AGHT+IHn0EpeSi5B2rQLxrrOISHjlpMWaKQpxCq9eItPt05oGFOnoWDLHFaXbAeEnMdp+k89dFb5Tg==
X-Received: by 2002:a05:6a20:1594:b0:18f:97c:9773 with SMTP id h20-20020a056a20159400b0018f097c9773mr248569pzj.91.1701468458314;
        Fri, 01 Dec 2023 14:07:38 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id du22-20020a056a002b5600b006cdc6a2bd89sm3571728pfb.141.2023.12.01.14.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:07:37 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1r9Bfa-002ZyI-2n;
	Sat, 02 Dec 2023 09:07:34 +1100
Date: Sat, 2 Dec 2023 09:07:34 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	dchinner@redhat.com
Subject: Re: [RFC 1/7] iomap: Don't fall back to buffered write if the write
 is atomic
Message-ID: <ZWpZJicSjW2XqMmp@dread.disaster.area>
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <09ec4c88b565c85dee91eccf6e894a0c047d9e69.1701339358.git.ojaswin@linux.ibm.com>
 <ZWj6Tt1zKUL4WPGr@dread.disaster.area>
 <85d1b27c-f4ef-43dd-8eed-f497817ab86d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85d1b27c-f4ef-43dd-8eed-f497817ab86d@oracle.com>

On Fri, Dec 01, 2023 at 10:42:57AM +0000, John Garry wrote:
> On 30/11/2023 21:10, Dave Chinner wrote:
> > On Thu, Nov 30, 2023 at 07:23:09PM +0530, Ojaswin Mujoo wrote:
> > > Currently, iomap only supports atomic writes for direct IOs and there is
> > > no guarantees that a buffered IO will be atomic. Hence, if the user has
> > > explicitly requested the direct write to be atomic and there's a
> > > failure, return -EIO instead of falling back to buffered IO.
> > > 
> > > Signed-off-by: Ojaswin Mujoo<ojaswin@linux.ibm.com>
> > > ---
> > >   fs/iomap/direct-io.c | 8 +++++++-
> > >   1 file changed, 7 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > index 6ef25e26f1a1..3e7cd9bc8f4d 100644
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -662,7 +662,13 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> > >   			if (ret != -EAGAIN) {
> > >   				trace_iomap_dio_invalidate_fail(inode, iomi.pos,
> > >   								iomi.len);
> > > -				ret = -ENOTBLK;
> > > +				/*
> > > +				 * if this write was supposed to be atomic,
> > > +				 * return the err rather than trying to fall
> > > +				 * back to buffered IO.
> > > +				 */
> > > +				if (!atomic_write)
> > > +					ret = -ENOTBLK;
> > This belongs in the caller when it receives an -ENOTBLK from
> > iomap_dio_rw(). The iomap code is saying "this IO cannot be done
> > with direct IO" by returning this value, and then the caller can
> > make the determination of whether to run a buffered IO or not.
> > 
> > For example, a filesystem might still be able to perform an atomic
> > IO via a COW-based buffered IO slow path. Sure, ext4 can't do this,
> > but the above patch would prevent filesystems that could from being
> > able to implement such a fallback....
> 
> Sure, and I think that we need a better story for supporting buffered IO for
> atomic writes.
> 
> Currently we have:
> - man pages tell us RWF_ATOMIC is only supported for direct IO
> - statx gives atomic write unit min/max, not explicitly telling us it's for
> direct IO
> - RWF_ATOMIC is ignored for !O_DIRECT
> 
> So I am thinking of expanding statx support to enable querying of atomic
> write capabilities for buffered IO and direct IO separately.

You're over complicating this way too much by trying to restrict the
functionality down to just what you want to implement right now.

RWF_ATOMIC is no different to RWF_NOWAIT. The API doesn't decide
what can be supported - the filesystems themselves decide what part
of the API they can support and implement those pieces.

TO go back to RWF_NOWAIT, for a long time we (XFS) only supported
RWF_NOWAIT on DIO, and buffered reads and writes were given
-EOPNOTSUPP by the filesystem. Then other filesystems started
supporting DIO with RWF_NOWAIT. Then buffered read support was added
to the page cache and XFS, and as other filesystems were converted
they removed the RWF_NOWAIT exclusion check from their read IO
paths.

We are now in the same place with buffered write support for
RWF_NOWAIT. XFS, the page cache and iomap allow buffered writes w/
RWF_NOWAIT, but ext4, btrfs and f2fs still all return -EOPNOTSUPP
because they don't support non-blocking buffered writes yet.

This is the same model we should be applying with RWF_ATOMIC - we
know that over time we'll be able to expand support for atomic
writes across both direct and buffered IO, so we should not be
restricting the API or infrastructure to only allow RWF_ATOMIC w/
DIO. Just have the filesystems reject RWF_ATOMIC w/ -EOPNOTSUPP if
they don't support it, and for those that do it is conditional on
whther the filesystem supports it for the given type of IO being
done.

Seriously - an application can easily probe for RWF_ATOMIC support
without needing information to be directly exposed in statx() - just
open a O_TMPFILE, issue the type of RWF_ATOMIC IO you require to be
supported, and if it returns -EOPNOTSUPP then it you can't use
RWF_ATOMIC optimisations in the application....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

