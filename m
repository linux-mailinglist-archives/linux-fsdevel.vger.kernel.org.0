Return-Path: <linux-fsdevel+bounces-54153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEBEAFB9F1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 19:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4FB11AA4ADB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 17:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC112E7F35;
	Mon,  7 Jul 2025 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOGbFC3j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD9221FF46;
	Mon,  7 Jul 2025 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751909545; cv=none; b=lI6BLgJPxxDNha8+LwgKfCk7zfTkY44s/JGbbEWsdRDDcW2W1UhCV2PC6J+ebi1YqQMFb/OcgvvHsBvbpSdT7c85W+/CtGzddIcZz3R4WzZuepk0FHLKYGTtAhZeBYeM+R1Jg4kG1/F/caZ2UlEYC1L0SrWC8NnGGqBghQUwvWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751909545; c=relaxed/simple;
	bh=WVJM3SZSm3oQSvOHm5Mfdm6shiB97KhB2K1EJcyPlbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVBYNje2MSN6nZ27ISEHaEG+Zl/CTQpYddOQL3FDFiJ6n+gzaE9hL5IDLCCyIzMuBMqF1dow5bAl4WyMRqbCoGom52r/Bl73pXnTvqxcU/AMPc16A+y7TPj8CtovKl9oGibItVwA+iF4pl49zVlYL7v4DTDWOGFMzyVZRxrsjWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOGbFC3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08608C4CEE3;
	Mon,  7 Jul 2025 17:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751909545;
	bh=WVJM3SZSm3oQSvOHm5Mfdm6shiB97KhB2K1EJcyPlbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOGbFC3ja6kH0v9HVh6u72McOgfluLSdOzEl0TSfObx4qj05LTIsPZp1YlFp2d/KG
	 jcTh6/TPj2VgfH9UGVMW6K6F49OGVGdMj5DwDN3M35DFbdPHkdwuTBEr+71QgI3QU+
	 C5vqjR/EQXTveC357KTHMSU71XAs1IhWyXz8GmlfXVqeLtICIFll0Tq7M0SDuVYKFP
	 M6DERATRLZxQAFTwmNEta7o/v3ZVuPFxv+4odjv9O9cGxAkvPPRhphawIC4Y3mvNWT
	 nIS+i970xaZT9HLpaJR/52GJ7VN7wxQ3nsDnG8QJqGrnaFxTMtkk49iKldeDEqzm/h
	 49110wloNqfGQ==
Date: Mon, 7 Jul 2025 10:32:24 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bschubert@ddn.com>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 10/18] famfs_fuse: Basic fuse kernel ABI enablement for
 famfs
Message-ID: <20250707173224.GB2672029@frogsfrogsfrogs>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-11-john@groves.net>
 <aimijj4mxtklldc3w6xpuwaaneoa7ekv5cnjj7rva3xmzoslgx@x4cwlmwb7dpm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aimijj4mxtklldc3w6xpuwaaneoa7ekv5cnjj7rva3xmzoslgx@x4cwlmwb7dpm>

On Thu, Jul 03, 2025 at 05:45:48PM -0500, John Groves wrote:
> On 25/07/03 01:50PM, John Groves wrote:
> > * FUSE_DAX_FMAP flag in INIT request/reply
> > 
> > * fuse_conn->famfs_iomap (enable famfs-mapped files) to denote a
> >   famfs-enabled connection
> > 
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/fuse/fuse_i.h          |  3 +++
> >  fs/fuse/inode.c           | 14 ++++++++++++++
> >  include/uapi/linux/fuse.h |  4 ++++
> >  3 files changed, 21 insertions(+)
> > 
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 9d87ac48d724..a592c1002861 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -873,6 +873,9 @@ struct fuse_conn {
> >  	/* Use io_uring for communication */
> >  	unsigned int io_uring;
> >  
> > +	/* dev_dax_iomap support for famfs */
> > +	unsigned int famfs_iomap:1;
> > +
> >  	/** Maximum stack depth for passthrough backing files */
> >  	int max_stack_depth;
> >  
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 29147657a99f..e48e11c3f9f3 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1392,6 +1392,18 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
> >  			}
> >  			if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
> >  				fc->io_uring = 1;
> > +			if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) &&
> > +			    flags & FUSE_DAX_FMAP) {
> > +				/* XXX: Should also check that fuse server
> > +				 * has CAP_SYS_RAWIO and/or CAP_SYS_ADMIN,
> > +				 * since it is directing the kernel to access
> > +				 * dax memory directly - but this function
> > +				 * appears not to be called in fuse server
> > +				 * process context (b/c even if it drops
> > +				 * those capabilities, they are held here).
> > +				 */
> > +				fc->famfs_iomap = 1;
> 
> I think there should be a check here that the fuse server is 
> capable(CAP_SYS_RAWIO) (or maybe CAP_SYS_ADMIN), but this function doesn't 
> run in fuse server context. A famfs fuse server is providing fmaps, which 
> map files to devdax memory, which should not be an unprivileged operation.

I thought process_init_reply /does/ run in the fuse server's context.
It calls process_init_limits, which checks for capable(CAP_SYS_ADMIN)...

--D

> 1) Does fs/fuse already store the capabilities of the fuse server?
> 2) If not, where do you suggest I do that, and where do you suggest I store
> that info? The only dead-obvious place (to me) that fs/fuse runs in server
> context is in fuse_dev_open(), but it doesn't store anything...
> 
> @Miklos, I'd appreciate your advice here.
> 
> Thanks!
> John
> 
> 

