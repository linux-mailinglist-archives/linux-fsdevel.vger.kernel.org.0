Return-Path: <linux-fsdevel+bounces-57928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A8DB26D3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 19:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4BB5C475B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894691C84A6;
	Thu, 14 Aug 2025 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tc/ZysOC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D3A1E4BE
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191101; cv=none; b=UgecARMBEkF5T08l19F8ZdTCxYzrgzrdKTD99EwWzFLpsTjTlTehNGOEYXyg73cqGba6vXo6lCN8xyfossK1UjtDR0pTkpAQMiOU12n/V0qFPuPY7SU+PeEAU/AkRsrWcfEtmr7Xf1ArUSWBhQbnaIEEWRmae6wBkzryvMwndeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191101; c=relaxed/simple;
	bh=T6AAOUO7crEdfNQW24yv/E36Gmcw2znGD1T/bzsQOFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyXUUzZE32luNcn1Mw31kSAdcVREkH///IwO45/YqX/dQQx28eo5C0M8mDE6pNTLkw4VPUm3tQwe0h9QUlvMrJjgC+yTCv+O8cmIXQImwN+Wvb3P6C8ZkhWrqe59Rq03Vt73JXqJboKKPnCO/UZhKvVCX3LOWoM36q+ylm4lK9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tc/ZysOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6931AC4CEED;
	Thu, 14 Aug 2025 17:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755191100;
	bh=T6AAOUO7crEdfNQW24yv/E36Gmcw2znGD1T/bzsQOFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tc/ZysOCZ7Zz4IXBk8yVRPOuNBbUqixORTJjV1xZJ8GF5gAME1Hl630wUHv+08+Vb
	 0c70jhoiyhMfWvWcZXnMxFlipA1GhhYcLR0voE28YGFE1qfhy5FksU0XoylC09cBvE
	 /egFHrj9ccQ8smvfJUadKPFsWQYFl/xCokOGaWdpE/C924vQa81LTi3Og1lA4lnNUN
	 trvqBHdVzkE7I2viGsoaBuffXyyFNcogWjzHKbZDtSGvyx8SyZU1s6EPxlyYif671N
	 hno9F5ZYN1mKaZF69h0Xy0v6jkewpjQ9vVCUSGhAIrI2bTEOD+/9vk7vJAMI04tIGb
	 2Y4Isr8dBlSnA==
Date: Thu, 14 Aug 2025 10:04:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bschubert@ddn.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>,
	Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v2 3/3] fuse: add COPY_FILE_RANGE_64 that allows large
 copies
Message-ID: <20250814170459.GS7942@frogsfrogsfrogs>
References: <20250813152014.100048-1-mszeredi@redhat.com>
 <20250813152014.100048-4-mszeredi@redhat.com>
 <CAJnrk1bfoumJHwc5p-WASXYxWG8tzz91LfzpiEkPTSOoTDK1ig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bfoumJHwc5p-WASXYxWG8tzz91LfzpiEkPTSOoTDK1ig@mail.gmail.com>

On Wed, Aug 13, 2025 at 10:03:17AM -0700, Joanne Koong wrote:
> On Wed, Aug 13, 2025 at 8:24 AM Miklos Szeredi <mszeredi@redhat.com> wrote:
> >
> > The FUSE protocol uses struct fuse_write_out to convey the return value of
> > copy_file_range, which is restricted to uint32_t.  But the COPY_FILE_RANGE
> > interface supports a 64-bit size copies and there's no reason why copies
> > should be limited to 32-bit.
> >
> > Introduce a new op COPY_FILE_RANGE_64, which is identical, except the
> > number of bytes copied is returned in a 64-bit value.
> >
> > If the fuse server does not support COPY_FILE_RANGE_64, fall back to
> > COPY_FILE_RANGE.
> 
> Is it unacceptable to add a union in struct fuse_write_out that
> accepts a uint64_t bytes_copied?
> struct fuse_write_out {
>     union {
>         struct {
>             uint32_t size;
>             uint32_t padding;
>         };
>         uint64_t bytes_copied;
>     };
> };
> 
> Maybe a little ugly but that seems backwards-compatible to me and
> would prevent needing a new FUSE_COPY_FILE_RANGE64.

I wonder, does fuse_args::out_argvar==1 imply that you could create a
new 64-bit fuse_write64_out:

struct fuse_write64_out {
	uint64_t size;
	uint64_t padding;
};

and then fuse_copy_file_range declares a union:

union fuse_cfr_out {
	struct fuse_write_out out;
	struct fuse_write64_out out64;
};

passes that into fuse_args:

	union fuse_cfr_out outarg;

	args.out_argvar = 1;
	args.out_numargs = 1;
	args.out_args[0].size = sizeof(outarg);
	args.out_args[0].value = &outarg;

and then we can switch on the results:

	if (args.out_args[0].size == sizeof(fuse_write64_out))
		/* 64-bit return */
	else if (args.out_args[0].size == sizeof(fuse_write_out))
		/* 32-bit return */
	else
		/* error */

I guess the problem is that userspace has to know that the kernel will
accept a fuse_write64_out, because on an old kernel it'll get -EINVAL
and ... then what?  I think an error return ends the request and the
fuse server can't just try again with fuse_write_out.

<shrug> Maybe I'm speculating stupi^Wwildly. ;)

--D

> >
> > Reported-by: Florian Weimer <fweimer@redhat.com>
> > Closes: https://lore.kernel.org/all/lhuh5ynl8z5.fsf@oldenburg.str.redhat.com/
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/fuse/file.c            | 44 ++++++++++++++++++++++++++++-----------
> >  fs/fuse/fuse_i.h          |  3 +++
> >  include/uapi/linux/fuse.h | 12 ++++++++++-
> >  3 files changed, 46 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 4adcf09d4b01..867b5fde1237 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -3013,33 +3015,51 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
> >         if (is_unstable)
> >                 set_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
> >
> > -       args.opcode = FUSE_COPY_FILE_RANGE;
> > +       args.opcode = FUSE_COPY_FILE_RANGE_64;
> >         args.nodeid = ff_in->nodeid;
> >         args.in_numargs = 1;
> >         args.in_args[0].size = sizeof(inarg);
> >         args.in_args[0].value = &inarg;
> >         args.out_numargs = 1;
> > -       args.out_args[0].size = sizeof(outarg);
> > -       args.out_args[0].value = &outarg;
> > +       args.out_args[0].size = sizeof(outarg_64);
> > +       args.out_args[0].value = &outarg_64;
> > +       if (fc->no_copy_file_range_64) {
> > +fallback:
> > +               /* Fall back to old op that can't handle large copy length */
> > +               args.opcode = FUSE_COPY_FILE_RANGE;
> > +               args.out_args[0].size = sizeof(outarg);
> > +               args.out_args[0].value = &outarg;
> > +               inarg.len = len = min_t(size_t, len, UINT_MAX & PAGE_MASK);
> > +       }
> >         err = fuse_simple_request(fm, &args);
> >         if (err == -ENOSYS) {
> > -               fc->no_copy_file_range = 1;
> > -               err = -EOPNOTSUPP;
> > +               if (fc->no_copy_file_range_64) {
> 
> Maybe clearer here to do the if check on the args.opcode? Then this
> could just be
> if (args.opcode == FUSE_COPY_FILE_RANGE) {
> 
> which imo is a lot easier to follow.
> 
> > +                       fc->no_copy_file_range = 1;
> > +                       err = -EOPNOTSUPP;
> > +               } else {
> > +                       fc->no_copy_file_range_64 = 1;
> > +                       goto fallback;
> > +               }
> >         }
> > -       if (!err && outarg.size > len)
> > -               err = -EIO;
> > -
> >         if (err)
> >                 goto out;
> >
> > +       bytes_copied = fc->no_copy_file_range_64 ?
> > +               outarg.size : outarg_64.bytes_copied;
> > +
> > +       if (bytes_copied > len) {
> > +               err = -EIO;
> > +               goto out;
> > +       }
> > +
> >         truncate_inode_pages_range(inode_out->i_mapping,
> >                                    ALIGN_DOWN(pos_out, PAGE_SIZE),
> > -                                  ALIGN(pos_out + outarg.size, PAGE_SIZE) - 1);
> > +                                  ALIGN(pos_out + bytes_copied, PAGE_SIZE) - 1);
> >
> >         file_update_time(file_out);
> > -       fuse_write_update_attr(inode_out, pos_out + outarg.size, outarg.size);
> > +       fuse_write_update_attr(inode_out, pos_out + bytes_copied, bytes_copied);
> >
> > -       err = outarg.size;
> > +       err = bytes_copied;
> >  out:
> >         if (is_unstable)
> >                 clear_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 122d6586e8d4..94621f68a5cc 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -1148,6 +1153,11 @@ struct fuse_copy_file_range_in {
> >         uint64_t        flags;
> >  };
> >
> > +/* For FUSE_COPY_FILE_RANGE_64 */
> > +struct fuse_copy_file_range_out {
> 
> imo having the 64 in the struct name more explicitly makes it clearer
> to the server which one they're supposed to use, eg struct
> fuse_copy_file_range64_out
> 
> Thanks,
> Joanne
> > +       uint64_t        bytes_copied;
> > +};
> > +
> 

