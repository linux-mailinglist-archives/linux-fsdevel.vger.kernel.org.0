Return-Path: <linux-fsdevel+bounces-49601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7099AC0073
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 01:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A999E4C4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 23:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E241723BF91;
	Wed, 21 May 2025 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoxN0R+R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3917E21E0A2;
	Wed, 21 May 2025 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747869061; cv=none; b=PYvsEq/efWzt4Mcj0YlR+F30rDCqx1EcEvHaHTyHQphifGzNWOZyGlduH6BBDRvBIHSrwDBX5B0Y+2prkYaF77puWrhdyVscEdnqJRVg2IVVwRAKkaSrNwvSDWyYkgmZA2Ay7MaBKz7Mci3U6kOeqXNqJg73xtKzHfjukgNTsRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747869061; c=relaxed/simple;
	bh=uB61s4rZaPOkIL5YPmArkTV9W9vtOhnDgtZFo0cjj28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D93/fm8yoXMxZG9xaZ4cyN7Cibbogtu4uiN7mtrp9JLzEU5giqU2ubBSCg5q3eDvg5k/r5fXn8bAYfgI/kyAMyXnpUhcUNkuJrHGoCwwBk9aO9Xk3AiYk86pson8HvKnx9EutWbg0cYzAccTnYr5Zl/23LuZjrnb/PnsAzZWSwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoxN0R+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AA8C4CEE4;
	Wed, 21 May 2025 23:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747869061;
	bh=uB61s4rZaPOkIL5YPmArkTV9W9vtOhnDgtZFo0cjj28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MoxN0R+RKY/RIXjOVTHnHlCrf0QrrSIdhoARdmUczwhflQBCjM3WbiPEK1R7eBYU9
	 +M5VLXcemnpdU8q9b9VuFSzqL2iGoVdhbGrCqSdH+T98MB8yj7DoTfjypgCRbBChuP
	 Wu6do25sAqYs3AxFBc1Kk1bt/dPwx2p3OGLpI4QOw8wvPR1AGck6c02odf6hIQVzIm
	 w0B+qlE3ljcfDU5oBeOj3OG3hnmLJHIX83S+Sl9TU1NUSMIAqTqTHKU4/qjcXgrvqS
	 sd+eePa7r8hjVZQwhlBrZz7yM5xTFBVXzrW9dmc48Irw5ZKxemxp1NlawWrJTx0TF3
	 QbJC5EqV2IUzg==
Date: Wed, 21 May 2025 16:11:00 -0700
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
	Ajay Joshi <ajayjoshi@micron.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [RFC PATCH 00/19] famfs: port into fuse
Message-ID: <20250521231100.GA9688@frogsfrogsfrogs>
References: <20250421013346.32530-1-john@groves.net>
 <hobxhwsn5ruaw42z4xuhc2prqnwmfnbouui44lru7lnwimmytj@fwga2crw2ych>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hobxhwsn5ruaw42z4xuhc2prqnwmfnbouui44lru7lnwimmytj@fwga2crw2ych>

On Wed, May 21, 2025 at 05:30:12PM -0500, John Groves wrote:
> On 25/04/20 08:33PM, John Groves wrote:
> > Subject: famfs: port into fuse
> >
> > <snip>
> 
> I'm planning to apply the review comments and send v2 of
> this patch series soon - hopefully next week.

Heh, I'm just about to push go on an RFC patchbomb for the entirety of
fuse + iomap + ext4-fuse2fs.

> I asked a couple of specific questions for Miklos and
> Amir at [1] that I hope they will answer in the next few
> days. Do you object to zeroing fuse_inodes when they're
> allocated, and do I really need an xchg() to set the
> fi->famfs_meta pointer during fuse_alloc_inode()? cmpxchg
> would be good for avoiding stepping on an "already set"
> pointer, but not useful if fi->famfs_meta has random
> contents (which it does when allocated).

I guess you could always null it out in fuse_inode_init_once and again
when you free the inode...

> I plan to move the GET_FMAP message to OPEN time rather than
> LOOKUP - unless that leads to problems that I don't
> currently foresee. The GET_FMAP response will also get a
> variable-sized payload.
> 
> Darrick and I have met and discussed commonality between our
> use cases, and the only thing from famfs that he will be able
> to directly use is the GET_FMAP message/response - but likely
> with a different response payload. The file operations in
> famfs.c are not applicable for Darrick, as they only handle
> mapping file offsets to devdax offsets (i.e. fs-dax over
> devdax).
> 
> Darrick is primarily exploring adapting block-backed file
> systems to use fuse. These are conventional page-cache-backed
> files that will primarily be read and written between
> blockdev and page cache.

Yeah, I really do need to get moving on sending out the RFC.

Everyone: patchbomb incoming!

> (Darrick, correct me if I got anything important wrong there.)
> 
> In prep for Darrick, I'll add an offset and length to the
> GET_FMAP message, to specify what range of the file map is
> being requested. I'll also add a new "first header" struct
> in the GET_FMAP response that can accommodate additional fmap
> types, and will specify the file size as well as the offset
> and length of the fmap portion described in the response
> (allowing for GET_FMAP responses that contain an incomplete
> file map).

Hrrmrmrmm.  I don't think there's much use in trying to share a fuse
command but then have to parse through the size of the response to
figure out what the server actually sent back.  It's less confusing to
have just one response type per fuse command.

I also don't think that FUSE_IOMAP_BEGIN is all that good of an
interface for what John is trying to do.  A regular filesystem creates
whatever mappings it likes in response to the far too many file IO APIs
in Linux, and needs to throw them at the kernel.  OTOH, famfs'
management daemon creates a static mapping with repeating elements and
that gets uploaded in one go via FUSE_GET_FMAP.  Yes, we could mash them
into a single uncohesive mess of an interface, but why would we torture
ourselves so?

(For me it's the "repeating sequences" aspect of GET_FMAP that makes me
think it should be a separate interface.  OTOH I haven't thought much
about how to support filesystems that implement RAID.)

> If there is desire to give GET_FMAP a different name, like
> GET_IOMAP, I don't much care - although the term "iomap" may
> be a bit overloaded already (e.g. the dax_iomap_rw()/
> dax_iomap_fault() functions debatably didn't need "iomap"
> in their names since they're about converting a file offset
> range to daxdev ranges, and they don't handle anything
> specifically iomap-related). At least "FMAP" is more narrowly
> descriptive of what it is.
> 
> I don't think Darrick needs GET_DAXDEV (or anything
> analogous), because passing in the backing dev at mount time
> seems entirely sufficient - so I assume that at least for now
> GET_DAXDEV won't be shared. But famfs definitely needs
> GET_DAXDEV, because files must be able to interleave across
> memory devices.

I actually /did/ add a notification so that the fuse server can tell the
kernel that they'd like to use a particular fd with iomap.  It doesn't
support dax devices by virtue of gatekeeping on S_ISBLK, but it wouldn't
be hard to do that.

> The one issue that I will kick down the road until v3 is
> fixing the "poisoned page|folio" problem. Because of that,
> v2 of this series will still be against a 6.14 kernel. Not
> solving that problem means this series won't be merge-able
> until v3.
> 
> I hope this is all clear and obvious. Let me know if not (or
> if so).

Hee hee.

--D

> 
> Thanks,
> John
> 
> 
> [1] https://lore.kernel.org/linux-fsdevel/20250421013346.32530-1-john@groves.net/T/#me47467b781d6c637899a38b898c27afb619206e0
> 
> 

