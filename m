Return-Path: <linux-fsdevel+bounces-42878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B14A4AA2E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 11:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88EF2189822B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 10:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE2F1D61BB;
	Sat,  1 Mar 2025 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D36LrVgn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D474C1D5CC1
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Mar 2025 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740823639; cv=none; b=OaXKu+gONKiF4+bqmm0xEnVAwPRt97ZOi3fZVR8qQjs4cuaQ+MovCUVUPvkM8lPMszw0uDLNriOg1I7AfDWqi1RzbRx/NxzHWG0HsrxPvcsEOiIMZV4aIlPHmY9ei35UUjr13ZHcHNU0aEGoEgq/ubjS7Yuf5+tMoEk9qgiAcV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740823639; c=relaxed/simple;
	bh=2SX+ULxgxauhI9VP3grOu+SWN7IzY/3ifoaH4+FD4h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYtDCFQFd6+2KuUxg6r15cIf/hj4LtsAGeKmJwTeokw0Oc4Ey2k1FdPalngoGPunKw2HA8M3UlF9Av10FNpoxoLyYlUJGKk2jVGfsYVDSUgSQBnhxbSRunScKu+oUaPSBe25ItoGWCt5a6Sepnz50KFOPdjc5vgH7GbmX1mutYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D36LrVgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A04AC4CEDD;
	Sat,  1 Mar 2025 10:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740823638;
	bh=2SX+ULxgxauhI9VP3grOu+SWN7IzY/3ifoaH4+FD4h4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D36LrVgnP15PgGq7UOfauCuDspxwG0VzvvfRK0mJStCvShVRcwbgZyUSP8wd/cueB
	 4/PpSNiJyW5B92jxv9BpSeQ0X3vVhWDqkIfyN8iNDSouX4oWK0YhBmGDU3AZRRKMlv
	 5hb3Ypb3b3JhqbR70rxXvv/hEeu7t1qfzoo+AHLnCNtnZipiLWQs5BEEo7r/vRlViM
	 gYBsopHECCNBVabIwwcHpjS71JC7bwsaLxJ54s88u3dk3SNN7wkt5c5U2CX4ORgnuS
	 9xG6hb7r4usRbunbgkbPd6CvaxOABY8thQmYLOvtNKOwJU67tcho1MSArd8Zqfgewz
	 dsJAnXNPkqpJA==
Date: Sat, 1 Mar 2025 11:07:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Pan Deng <pan.deng@intel.com>, viro@zeniv.linux.org.uk, 
	linux-fsdevel@vger.kernel.org, tianyou.li@intel.com, tim.c.chen@linux.intel.com, 
	lipeng.zhu@intel.com
Subject: Re: [PATCH] fs: place f_ref to 3rd cache line in struct file to
 resolve false sharing
Message-ID: <20250301-ermahnen-kramen-b6e90ea5b50d@brauner>
References: <20250228020059.3023375-1-pan.deng@intel.com>
 <uyqqemnrf46xdht3mr4okv6zw7asfhjabz3fu5fl5yan52ntoh@nflmsbxz6meb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <uyqqemnrf46xdht3mr4okv6zw7asfhjabz3fu5fl5yan52ntoh@nflmsbxz6meb>

On Fri, Feb 28, 2025 at 08:51:27PM +0100, Jan Kara wrote:
> On Fri 28-02-25 10:00:59, Pan Deng wrote:
> > When running syscall pread in a high core count system, f_ref contends
> > with the reading of f_mode, f_op, f_mapping, f_inode, f_flags in the
> > same cache line.
> 
> Well, but you have to have mulithreaded process using the same struct file
> for the IO, don't you? Otherwise f_ref is not touched...

Yes, it's specifically designed to scale better under high contention.

> 
> > This change places f_ref to the 3rd cache line where fields are not
> > updated as frequently as the 1st cache line, and the contention is
> > grealy reduced according to tests. In addition, the size of file
> > object is kept in 3 cache lines.
> > 
> > This change has been tested with rocksdb benchmark readwhilewriting case
> > in 1 socket 64 physical core 128 logical core baremetal machine, with
> > build config CONFIG_RANDSTRUCT_NONE=y
> > Command:
> > ./db_bench --benchmarks="readwhilewriting" --threads $cnt --duration 60
> > The throughput(ops/s) is improved up to ~21%.
> > =====
> > thread		baseline	compare
> > 16		 100%		 +1.3%
> > 32		 100%		 +2.2%
> > 64		 100%		 +7.2%
> > 128		 100%		 +20.9%
> > 
> > It was also tested with UnixBench: syscall, fsbuffer, fstime,
> > fsdisk cases that has been used for file struct layout tuning, no
> > regression was observed.
> 
> So overall keeping the first cacheline read mostly with important stuff
> makes sense to limit cache traffic. But:
> 
> >  struct file {
> > -	file_ref_t			f_ref;
> >  	spinlock_t			f_lock;
> >  	fmode_t				f_mode;
> >  	const struct file_operations	*f_op;
> > @@ -1102,6 +1101,7 @@ struct file {
> >  	unsigned int			f_flags;
> >  	unsigned int			f_iocb_flags;
> >  	const struct cred		*f_cred;
> > +	u8				padding[8];
> >  	/* --- cacheline 1 boundary (64 bytes) --- */
> >  	struct path			f_path;
> >  	union {
> > @@ -1127,6 +1127,7 @@ struct file {
> >  		struct file_ra_state	f_ra;
> >  		freeptr_t		f_freeptr;
> >  	};
> > +	file_ref_t			f_ref;
> >  	/* --- cacheline 3 boundary (192 bytes) --- */
> >  } __randomize_layout
> 
> This keeps struct file within 3 cachelines but it actually grows it from
> 184 to 192 bytes (and yes, that changes how many file structs we can fit in
> a slab). So instead of adding 8 bytes of padding, just pick some
> read-mostly element and move it into the hole - f_owner looks like one
> possible candidate.

This is what I did. See vfs-6.15.misc! Thanks!

> 
> Also did you test how moving f_ref to the second cache line instead of the
> third one behaves?
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

