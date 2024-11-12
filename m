Return-Path: <linux-fsdevel+bounces-34518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4D19C609D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 19:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF632815A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 18:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A55B217914;
	Tue, 12 Nov 2024 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMxeHhyj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F9F215024
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436985; cv=none; b=N2TmLu4chXyXOaLsLlCtqGnDm+dkKeBN+z0ozc3Y45k0zLazdt+zqQ42YWUK8GI+9dY6pW5kR4y4nKqUQBfz9nakF9+/GLvOBKaBZdvALmG2gvsuWdGHAK8mYjG4y5wrKI6XUrCx+PVuJiO6zvuBQgisu6nCUnHguww/Ug4QQ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436985; c=relaxed/simple;
	bh=S7FUwtVV0BAKBNPojmarbvihA/jhfYctbNTjlWrVP8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iph/M+viRJnbPkm+VuSWAsxZwHKU295HYLGpMFUGpVHIQR8+RNYaPz+1mbwZSNquPI+P09Xv9rNOp3mgARVrba+HF0v9zGo7W/uz0HnfW31Y8o+zmZby+K2nOp1XwFrX+el9S6wkzNh1cKMjaRFn6/uR24ORlC8Wffv1etGHEGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eMxeHhyj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731436982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tPoALtQLssYylid2Eh8irr2ayHO3s2n1Pnm5KZqNhDA=;
	b=eMxeHhyjtJkStwUjEterl/PyJRO31xKYMJZyeH9VB5dp+9OHGEBY1w5e8mqT/qPdI7FQMf
	XqpaenBJ6kWDWbKpn/UclDo7Frpld1twdxA252W+X6VWGFB2jAT2QR/cPCSbWFOFv85FSE
	7lmWNUKw8LIEvbZbIukfaFOyd6N1fZs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-KBKMB-AKMtCdhLFGSI1cJg-1; Tue,
 12 Nov 2024 13:42:58 -0500
X-MC-Unique: KBKMB-AKMtCdhLFGSI1cJg-1
X-Mimecast-MFC-AGG-ID: KBKMB-AKMtCdhLFGSI1cJg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68AFC1955EE8;
	Tue, 12 Nov 2024 18:42:56 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.120])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4402A1956086;
	Tue, 12 Nov 2024 18:42:54 +0000 (UTC)
Date: Tue, 12 Nov 2024 13:44:27 -0500
From: Brian Foster <bfoster@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
	linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
Message-ID: <ZzOiC5-tCNiJylSx@bfoster>
References: <221590fa-b230-426a-a8ec-7f18b74044b8@kernel.dk>
 <ZzIfwmGkbHwaSMIn@infradead.org>
 <04fd04b3-c19e-4192-b386-0487ab090417@kernel.dk>
 <31db6462-83d1-48b6-99b9-da38c399c767@kernel.dk>
 <3da73668-a954-47b9-b66d-bb2e719f5590@kernel.dk>
 <ZzLkF-oW2epzSEbP@infradead.org>
 <e9b191ad-7dfa-42bd-a419-96609f0308bf@kernel.dk>
 <ZzOEzX0RddGeMUPc@bfoster>
 <7a4ef71f-905e-4f2a-b3d2-8fd939c5a865@kernel.dk>
 <3f378e51-87e7-499e-a9fb-4810ca760d2b@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f378e51-87e7-499e-a9fb-4810ca760d2b@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Nov 12, 2024 at 10:19:02AM -0700, Jens Axboe wrote:
> On 11/12/24 10:06 AM, Jens Axboe wrote:
> > On 11/12/24 9:39 AM, Brian Foster wrote:
> >> On Tue, Nov 12, 2024 at 08:14:28AM -0700, Jens Axboe wrote:
> >>> On 11/11/24 10:13 PM, Christoph Hellwig wrote:
> >>>> On Mon, Nov 11, 2024 at 04:42:25PM -0700, Jens Axboe wrote:
> >>>>> Here's the slightly cleaned up version, this is the one I ran testing
> >>>>> with.
> >>>>
> >>>> Looks reasonable to me, but you probably get better reviews on the
> >>>> fstests lists.
> >>>
> >>> I'll send it out once this patchset is a bit closer to integration,
> >>> there's the usual chicken and egg situation with it. For now, it's quite
> >>> handy for my testing, found a few issues with this version. So thanks
> >>> for the suggestion, sure beats writing more of your own test cases :-)
> >>>
> >>
> >> fsx support is probably a good idea as well. It's similar in idea to
> >> fsstress, but bashes the same file with mixed operations and includes
> >> data integrity validation checks as well. It's pretty useful for
> >> uncovering subtle corner case issues or bad interactions..
> > 
> > Indeed, I did that too. Re-running xfstests right now with that too.
> 
> Here's what I'm running right now, fwiw. It adds RWF_UNCACHED support
> for both the sync read/write and io_uring paths.
> 

Nice, thanks. Looks reasonable to me at first glance. A few randomish
comments inlined below.

BTW, I should have also mentioned that fsx is also useful for longer
soak testing. I.e., fstests will provide a decent amount of coverage as
is via the various preexisting tests, but I'll occasionally run fsx
directly and let it run overnight or something to get the op count at
least up in the 100 millions or so to have a little more confidence
there isn't some rare/subtle bug lurking. That might be helpful with
something like this. JFYI.

> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 41933354..104910ff 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -43,6 +43,10 @@
>  # define MAP_FILE 0
>  #endif
>  
> +#ifndef RWF_UNCACHED
> +#define RWF_UNCACHED	0x80
> +#endif
> +
>  #define NUMPRINTCOLUMNS 32	/* # columns of data to print on each line */
>  
>  /* Operation flags (bitmask) */
> @@ -101,7 +105,9 @@ int			logcount = 0;	/* total ops */
>  enum {
>  	/* common operations */
>  	OP_READ = 0,
> +	OP_READ_UNCACHED,
>  	OP_WRITE,
> +	OP_WRITE_UNCACHED,
>  	OP_MAPREAD,
>  	OP_MAPWRITE,
>  	OP_MAX_LITE,
> @@ -190,15 +196,16 @@ int	o_direct;			/* -Z */
>  int	aio = 0;
>  int	uring = 0;
>  int	mark_nr = 0;
> +int	rwf_uncached = 1;
>  
>  int page_size;
>  int page_mask;
>  int mmap_mask;
> -int fsx_rw(int rw, int fd, char *buf, unsigned len, unsigned offset);
> +int fsx_rw(int rw, int fd, char *buf, unsigned len, unsigned offset, int flags);
>  #define READ 0
>  #define WRITE 1
> -#define fsxread(a,b,c,d)	fsx_rw(READ, a,b,c,d)
> -#define fsxwrite(a,b,c,d)	fsx_rw(WRITE, a,b,c,d)
> +#define fsxread(a,b,c,d,f)	fsx_rw(READ, a,b,c,d,f)
> +#define fsxwrite(a,b,c,d,f)	fsx_rw(WRITE, a,b,c,d,f)
>  

My pattern recognition brain wants to see an 'e' here. ;)

>  struct timespec deadline;
>  
> @@ -266,7 +273,9 @@ prterr(const char *prefix)
>  
>  static const char *op_names[] = {
>  	[OP_READ] = "read",
> +	[OP_READ_UNCACHED] = "read_uncached",
>  	[OP_WRITE] = "write",
> +	[OP_WRITE_UNCACHED] = "write_uncached",
>  	[OP_MAPREAD] = "mapread",
>  	[OP_MAPWRITE] = "mapwrite",
>  	[OP_TRUNCATE] = "truncate",
> @@ -393,12 +402,14 @@ logdump(void)
>  				prt("\t******WWWW");
>  			break;
>  		case OP_READ:
> +		case OP_READ_UNCACHED:
>  			prt("READ     0x%x thru 0x%x\t(0x%x bytes)",
>  			    lp->args[0], lp->args[0] + lp->args[1] - 1,
>  			    lp->args[1]);
>  			if (overlap)
>  				prt("\t***RRRR***");
>  			break;
> +		case OP_WRITE_UNCACHED:
>  		case OP_WRITE:
>  			prt("WRITE    0x%x thru 0x%x\t(0x%x bytes)",
>  			    lp->args[0], lp->args[0] + lp->args[1] - 1,
> @@ -784,9 +795,8 @@ doflush(unsigned offset, unsigned size)
>  }
>  
>  void
> -doread(unsigned offset, unsigned size)
> +__doread(unsigned offset, unsigned size, int flags)
>  {
> -	off_t ret;
>  	unsigned iret;
>  
>  	offset -= offset % readbdy;
> @@ -818,23 +828,39 @@ doread(unsigned offset, unsigned size)
>  			(monitorend == -1 || offset <= monitorend))))))
>  		prt("%lld read\t0x%x thru\t0x%x\t(0x%x bytes)\n", testcalls,
>  		    offset, offset + size - 1, size);
> -	ret = lseek(fd, (off_t)offset, SEEK_SET);
> -	if (ret == (off_t)-1) {
> -		prterr("doread: lseek");
> -		report_failure(140);
> -	}
> -	iret = fsxread(fd, temp_buf, size, offset);
> +	iret = fsxread(fd, temp_buf, size, offset, flags);
>  	if (iret != size) {
> -		if (iret == -1)
> -			prterr("doread: read");
> -		else
> +		if (iret == -1) {
> +			if (errno == EOPNOTSUPP && flags & RWF_UNCACHED) {
> +				rwf_uncached = 1;

I assume you meant rwf_uncached = 0 here?

If so, check out test_fallocate() and friends to see how various
operations are tested for support before the test starts. Following that
might clean things up a bit.

Also it's useful to have a CLI option to enable/disable individual
features. That tends to be helpful to narrow things down when it does
happen to explode and you want to narrow down the cause.

Brian

> +				return;
> +			}
> +			prterr("dowrite: read");
> +		} else {
>  			prt("short read: 0x%x bytes instead of 0x%x\n",
>  			    iret, size);
> +		}
>  		report_failure(141);
>  	}
>  	check_buffers(temp_buf, offset, size);
>  }
> +void
> +doread(unsigned offset, unsigned size)
> +{
> +	__doread(offset, size, 0);
> +}
>  
> +void
> +doread_uncached(unsigned offset, unsigned size)
> +{
> +	if (rwf_uncached) {
> +		__doread(offset, size, RWF_UNCACHED);
> +		if (rwf_uncached)
> +			return;
> +	}
> +	__doread(offset, size, 0);
> +}
> +	
>  void
>  check_eofpage(char *s, unsigned offset, char *p, int size)
>  {
> @@ -870,7 +896,6 @@ check_contents(void)
>  	unsigned map_offset;
>  	unsigned map_size;
>  	char *p;
> -	off_t ret;
>  	unsigned iret;
>  
>  	if (!check_buf) {
> @@ -885,13 +910,7 @@ check_contents(void)
>  	if (size == 0)
>  		return;
>  
> -	ret = lseek(fd, (off_t)offset, SEEK_SET);
> -	if (ret == (off_t)-1) {
> -		prterr("doread: lseek");
> -		report_failure(140);
> -	}
> -
> -	iret = fsxread(fd, check_buf, size, offset);
> +	iret = fsxread(fd, check_buf, size, offset, 0);
>  	if (iret != size) {
>  		if (iret == -1)
>  			prterr("check_contents: read");
> @@ -1064,9 +1083,8 @@ update_file_size(unsigned offset, unsigned size)
>  }
>  
>  void
> -dowrite(unsigned offset, unsigned size)
> +__dowrite(unsigned offset, unsigned size, int flags)
>  {
> -	off_t ret;
>  	unsigned iret;
>  
>  	offset -= offset % writebdy;
> @@ -1101,18 +1119,18 @@ dowrite(unsigned offset, unsigned size)
>  			(monitorend == -1 || offset <= monitorend))))))
>  		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\n", testcalls,
>  		    offset, offset + size - 1, size);
> -	ret = lseek(fd, (off_t)offset, SEEK_SET);
> -	if (ret == (off_t)-1) {
> -		prterr("dowrite: lseek");
> -		report_failure(150);
> -	}
> -	iret = fsxwrite(fd, good_buf + offset, size, offset);
> +	iret = fsxwrite(fd, good_buf + offset, size, offset, flags);
>  	if (iret != size) {
> -		if (iret == -1)
> +		if (iret == -1) {
> +			if (errno == EOPNOTSUPP && flags & RWF_UNCACHED) {
> +				rwf_uncached = 0;
> +				return;
> +			}
>  			prterr("dowrite: write");
> -		else
> +		} else {
>  			prt("short write: 0x%x bytes instead of 0x%x\n",
>  			    iret, size);
> +		}
>  		report_failure(151);
>  	}
>  	if (do_fsync) {
> @@ -1126,6 +1144,22 @@ dowrite(unsigned offset, unsigned size)
>  	}
>  }
>  
> +void
> +dowrite(unsigned offset, unsigned size)
> +{
> +	__dowrite(offset, size, 0);
> +}
> +
> +void
> +dowrite_uncached(unsigned offset, unsigned size)
> +{
> +	if (rwf_uncached) {
> +		__dowrite(offset, size, RWF_UNCACHED);
> +		if (rwf_uncached)
> +			return;
> +	}
> +	__dowrite(offset, size, 0);
> +}
>  
>  void
>  domapwrite(unsigned offset, unsigned size)
> @@ -2340,11 +2374,21 @@ have_op:
>  		doread(offset, size);
>  		break;
>  
> +	case OP_READ_UNCACHED:
> +		TRIM_OFF_LEN(offset, size, file_size);
> +		doread_uncached(offset, size);
> +		break;
> +
>  	case OP_WRITE:
>  		TRIM_OFF_LEN(offset, size, maxfilelen);
>  		dowrite(offset, size);
>  		break;
>  
> +	case OP_WRITE_UNCACHED:
> +		TRIM_OFF_LEN(offset, size, maxfilelen);
> +		dowrite_uncached(offset, size);
> +		break;
> +
>  	case OP_MAPREAD:
>  		TRIM_OFF_LEN(offset, size, file_size);
>  		domapread(offset, size);
> @@ -2702,7 +2746,7 @@ uring_setup()
>  }
>  
>  int
> -uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
> +uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset, int flags)
>  {
>  	struct io_uring_sqe     *sqe;
>  	struct io_uring_cqe     *cqe;
> @@ -2733,6 +2777,7 @@ uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
>  		} else {
>  			io_uring_prep_writev(sqe, fd, &iovec, 1, o);
>  		}
> +		sqe->rw_flags = flags;
>  
>  		ret = io_uring_submit_and_wait(&ring, 1);
>  		if (ret != 1) {
> @@ -2781,7 +2826,7 @@ uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
>  }
>  #else
>  int
> -uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
> +uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset, int flags)
>  {
>  	fprintf(stderr, "io_rw: need IO_URING support!\n");
>  	exit(111);
> @@ -2789,19 +2834,21 @@ uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
>  #endif
>  
>  int
> -fsx_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
> +fsx_rw(int rw, int fd, char *buf, unsigned len, unsigned offset, int flags)
>  {
>  	int ret;
>  
>  	if (aio) {
>  		ret = aio_rw(rw, fd, buf, len, offset);
>  	} else if (uring) {
> -		ret = uring_rw(rw, fd, buf, len, offset);
> +		ret = uring_rw(rw, fd, buf, len, offset, flags);
>  	} else {
> +		struct iovec iov = { .iov_base = buf, .iov_len = len };
> +
>  		if (rw == READ)
> -			ret = read(fd, buf, len);
> +			ret = preadv2(fd, &iov, 1, offset, flags);
>  		else
> -			ret = write(fd, buf, len);
> +			ret = pwritev2(fd, &iov, 1, offset, flags);
>  	}
>  	return ret;
>  }
> 
> 
> -- 
> Jens Axboe
> 


