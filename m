Return-Path: <linux-fsdevel+bounces-47259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F524A9B132
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 16:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB6E16C834
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 14:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A955F190067;
	Thu, 24 Apr 2025 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJVGWmn4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F214E2DF68;
	Thu, 24 Apr 2025 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745505530; cv=none; b=Biqrj9yPGpAE5XL+wIhARnXj3GDWbaAVQmNcgLBs4nnVKZD4WdHQXmziI81TkWByTUaLCYbAeR+fyXJ7RLEzIfMqYqgvY0PlLwkseqnHZAYIIkxnH0jXwV5jY/zZxaofTbRFkPd2U59+MDvMUeLchFDQ8spvMSsAvE/wlyPduis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745505530; c=relaxed/simple;
	bh=WM7zfm0bT2ItDzzbHgZkWzBdQu/I59c8crE3d85m7Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hs2jKbQjazKSkqt0BDPOLrrrJe66VYXTPgRRonxxb00gLtX8ct51Bgn2O6zNSimYOBJt5/CeuGgIx2D+vPtk6+WIBw5A14Jb7shCAanAc6NPmKzA5tVJ6pDW3oApXlu4stWrryYYloLVju932m8Ixo6+Rhf+S3qPArc5gNn2YFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJVGWmn4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60655C4CEE3;
	Thu, 24 Apr 2025 14:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745505529;
	bh=WM7zfm0bT2ItDzzbHgZkWzBdQu/I59c8crE3d85m7Sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJVGWmn4v45l8WbiQwosdrijUHNMc637MOvicJxYlgxabqPeQTrlGaPCp6FRNvW4t
	 5VwyC/mU9NdVJtmH4Vuf7Qr6pY9v29qFYa12FPzKlM2an91t1wSg4+H2+klzjQzwT9
	 hS2beHMQTDgyeic7qRYktPe1ypBYTEDPD9xfrtzMP0npkfbxngnLfDFm9ECrIqu4Ar
	 8mxrgHrltGVe6EBrkAUzvgBR4795/tVd/is3RuDRvIRc1TrnZVIS+Z8txKTNTwoyDE
	 H6IoCmJavtTmgwwoqwG7fl56NAwc7SG0TwW9KSoyArW/nDLh8QQHxm++8njNhHX5/h
	 rJ23St7P5TFlA==
Date: Thu, 24 Apr 2025 07:38:48 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
	Bernd Schubert <bschubert@ddn.com>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Luis Henriques <luis@igalia.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Petr Vorel <pvorel@suse.cz>, Brian Foster <bfoster@redhat.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 13/19] famfs_fuse: Create files with famfs fmaps
Message-ID: <20250424143848.GN25700@frogsfrogsfrogs>
References: <20250421013346.32530-1-john@groves.net>
 <20250421013346.32530-14-john@groves.net>
 <nedxmpb7fnovsgbp2nu6y3cpvduop775jw6leywmmervdrenbn@kp6xy2sm4gxr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nedxmpb7fnovsgbp2nu6y3cpvduop775jw6leywmmervdrenbn@kp6xy2sm4gxr>

On Thu, Apr 24, 2025 at 08:43:33AM -0500, John Groves wrote:
> On 25/04/20 08:33PM, John Groves wrote:
> > On completion of GET_FMAP message/response, setup the full famfs
> > metadata such that it's possible to handle read/write/mmap directly to
> > dax. Note that the devdax_iomap plumbing is not in yet...
> > 
> > Update MAINTAINERS for the new files.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  MAINTAINERS               |   9 +
> >  fs/fuse/Makefile          |   2 +-
> >  fs/fuse/dir.c             |   3 +
> >  fs/fuse/famfs.c           | 344 ++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/famfs_kfmap.h     |  63 +++++++
> >  fs/fuse/fuse_i.h          |  16 +-
> >  fs/fuse/inode.c           |   2 +-
> >  include/uapi/linux/fuse.h |  42 +++++
> >  8 files changed, 477 insertions(+), 4 deletions(-)
> >  create mode 100644 fs/fuse/famfs.c
> >  create mode 100644 fs/fuse/famfs_kfmap.h
> > 

<snip>

> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index d85fb692cf3b..0f6ff1ffb23d 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -1286,4 +1286,46 @@ struct fuse_uring_cmd_req {
> >  	uint8_t padding[6];
> >  };
> >  
> > +/* Famfs fmap message components */
> > +
> > +#define FAMFS_FMAP_VERSION 1
> > +
> > +#define FUSE_FAMFS_MAX_EXTENTS 2
> > +#define FUSE_FAMFS_MAX_STRIPS 16
> 
> FYI, after thinking through the conversation with Darrick,  I'm planning 
> to drop FUSE_FAMFS_MAX_(EXTENTS|STRIPS) in the next version.  In the 
> response to GET_FMAP, it's the structures below serialized into a message 
> buffer. If it fits, it's good - and if not it's invalid. When the
> in-memory metadata (defined in famfs_kfmap.h) gets assembled, if there is
> a reason to apply limits it can be done - but I don't currently see a reason
> do to that (so if I'm currently enforcing limits there, I'll probably drop
> that.

You could also define GET_FMAP to have an offset in the request buffer,
and have the famfs daemon send back the next offset at the end of its
reply (or -1ULL to stop).  Then the kernel can call GET_FMAP again with
that new offset to get more mappings.

Though at this point maybe it should go the /other/ way, where the fuse
server can sends a "notification" to the kernel to populate its mapping
data?  fuse already defines a handful of notifications for invalidating
pagecache and directory links.

(Ugly wart: notifications aren't yet implemented for the iouring channel)

--D

> 
> > +
> > +enum fuse_famfs_file_type {
> > +	FUSE_FAMFS_FILE_REG,
> > +	FUSE_FAMFS_FILE_SUPERBLOCK,
> > +	FUSE_FAMFS_FILE_LOG,
> > +};
> > +
> > +enum famfs_ext_type {
> > +	FUSE_FAMFS_EXT_SIMPLE = 0,
> > +	FUSE_FAMFS_EXT_INTERLEAVE = 1,
> > +};
> > +
> > +struct fuse_famfs_simple_ext {
> > +	uint32_t se_devindex;
> > +	uint32_t reserved;
> > +	uint64_t se_offset;
> > +	uint64_t se_len;
> > +};
> > +
> > +struct fuse_famfs_iext { /* Interleaved extent */
> > +	uint32_t ie_nstrips;
> > +	uint32_t ie_chunk_size;
> > +	uint64_t ie_nbytes; /* Total bytes for this interleaved_ext; sum of strips may be more */
> > +	uint64_t reserved;
> > +};
> > +
> > +struct fuse_famfs_fmap_header {
> > +	uint8_t file_type; /* enum famfs_file_type */
> > +	uint8_t reserved;
> > +	uint16_t fmap_version;
> > +	uint32_t ext_type; /* enum famfs_log_ext_type */
> > +	uint32_t nextents;
> > +	uint32_t reserved0;
> > +	uint64_t file_size;
> > +	uint64_t reserved1;
> > +};
> >  #endif /* _LINUX_FUSE_H */
> > -- 
> > 2.49.0
> > 

