Return-Path: <linux-fsdevel+bounces-53572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9D8AF035E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 21:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B441C075AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 19:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613E9281368;
	Tue,  1 Jul 2025 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+BDc6Iu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FAF1CBEAA;
	Tue,  1 Jul 2025 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751396938; cv=none; b=jO6jy05j2LWh3m5HA1PQtpKZs6yLN6n42laPACd3cdDGXuBMz4lLWFPy55Xc9I44ahyV9QlRrHm9c96F9rjIRJ5EeSx6zbIy53sUpw9dd3+dp6x7tU5+gmpCD+uFy8r40t0LVRc8GVA7Abx0oOkcifsl5Wpennd3/ylyzEzY5RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751396938; c=relaxed/simple;
	bh=vICwRvZ2gmJ2aXjP8dbL0q41nxaXT5Fje7WWGoXFC7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EC/izr6U+J9kj5dF5FgRxpxtaPQVArhtR7BEOtpcSGpFGVylCDwbAo/s3c86LUn8pbN2a4SSxMIr6hBqqrDqNAK55jb4lvXsStMylydEOaxY2KgnZIPUF8BXWBu7vPLFw10CLJi2hK4nSVKh2qYvqzRBjOxupcrPXKNAGmUJEiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+BDc6Iu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D540C4CEEB;
	Tue,  1 Jul 2025 19:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751396938;
	bh=vICwRvZ2gmJ2aXjP8dbL0q41nxaXT5Fje7WWGoXFC7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+BDc6Iu0isrbTPhplbPWe3yUY92oVOp3i46SjM2thkVV7BwzS+UWxGFgd3pnvvag
	 VH9+HtQ9jEO6QgA/q/UhThHlpWygLhALN27Olj8pWwlYKPDRWQ3h47XP+AUvXiFFWK
	 VYSyYquIPV0sHznHEV/KJJZqFI8kkVmWL3hPIRxWPG/7QtdpWuysyBi/1HHU9+DoDj
	 cnFQGan15vg+4RlUbZ4eR9uNVCmvsCAj80HU9rTLxJYdwN0ZKelfXlsHnExzv4PgRJ
	 YDB9TMso/iKg76I2eA1pGFH7J3Fz5UhZgW5x4QE7ittnOVSC9w+6V7BgqS9v9XFSbM
	 Gyp0jwHKqYIoA==
Date: Tue, 1 Jul 2025 12:08:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, selinux@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 6/6] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <20250701190857.GR10009@frogsfrogsfrogs>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-6-c4e3bc35227b@kernel.org>
 <20250701184317.GQ10009@frogsfrogsfrogs>
 <20250701185457.jvbwhiiihdauymrg@pali>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250701185457.jvbwhiiihdauymrg@pali>

On Tue, Jul 01, 2025 at 08:54:57PM +0200, Pali Rohár wrote:
> On Tuesday 01 July 2025 11:43:17 Darrick J. Wong wrote:
> > On Mon, Jun 30, 2025 at 06:20:16PM +0200, Andrey Albershteyn wrote:
> > > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > > index 0098b0ce8ccb..0784f2033ba4 100644
> > > --- a/include/uapi/linux/fs.h
> > > +++ b/include/uapi/linux/fs.h
> > > @@ -148,6 +148,24 @@ struct fsxattr {
> > >  	unsigned char	fsx_pad[8];
> > >  };
> > >  
> > > +/*
> > > + * Variable size structure for file_[sg]et_attr().
> > > + *
> > > + * Note. This is alternative to the structure 'struct fileattr'/'struct fsxattr'.
> > > + * As this structure is passed to/from userspace with its size, this can
> > > + * be versioned based on the size.
> > > + */
> > > +struct fsx_fileattr {
> > > +	__u32	fsx_xflags;	/* xflags field value (get/set) */
> > 
> > Should this to be __u64 from the start?  Seeing as (a) this struct is
> > not already a multiple of 8 bytes and (b) it's likely that we'll have to
> > add a u64 field at some point.  That would also address brauner's
> > comment about padding.
> 
> Hello!
> 
> As I have already mentioned, after this syscall API/ABI is finished, I'm
> planning to prepare patches for changing just selected fields / flags by
> introducing a new mask field, and support for additional flags used by
> existing filesystems (like windows flags).
> 
> My idea is extending this structure for a new "u32 fsx_xflags_mask"
> and new "u32 fsx_xflags2" + "u32 fsx_xflags2_mask". (field names are
> just examples).
> 
> So in case you are extending the structure now, please consider if it
> makes sense to add all members, so we do not have to define 2 or 3
> structure versions in near feature.
> 
> Your idea of __u64 for fsx_xflags means that it will already cover the
> "u32 fsx_xflags2" field.

Ah, ok, so that work *is* still coming. :)

Are you still planning to add masks for xflags bits that are clearable
and settable?  i.e.

	__u64	fa_xflags;		/* state */
	...
	<end of V0 structure>

	__u64	fa_xflags_mask;		/* bits for setattr to examine */
	__u64	fa_xflags_clearable;	/* clearable bits */
	__u64	fa_xflags_settable;	/* settable bits */

I think it's easier just to define u64 in the V0 structure and then add
the three new fields in V1.  What do you think?

--D

> > --D
> > 
> > > +	__u32	fsx_extsize;	/* extsize field value (get/set)*/
> > > +	__u32	fsx_nextents;	/* nextents field value (get)   */
> > > +	__u32	fsx_projid;	/* project identifier (get/set) */
> > > +	__u32	fsx_cowextsize;	/* CoW extsize field value (get/set) */
> > > +};
> > > +
> > > +#define FSX_FILEATTR_SIZE_VER0 20
> > > +#define FSX_FILEATTR_SIZE_LATEST FSX_FILEATTR_SIZE_VER0
> > > +
> > >  /*
> > >   * Flags for the fsx_xflags field
> > >   */
> > > diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
> > > index 580b4e246aec..d1ae5e92c615 100644
> > > --- a/scripts/syscall.tbl
> > > +++ b/scripts/syscall.tbl
> > > @@ -408,3 +408,5 @@
> > >  465	common	listxattrat			sys_listxattrat
> > >  466	common	removexattrat			sys_removexattrat
> > >  467	common	open_tree_attr			sys_open_tree_attr
> > > +468	common	file_getattr			sys_file_getattr
> > > +469	common	file_setattr			sys_file_setattr
> > > 
> > > -- 
> > > 2.47.2
> > > 
> > > 
> 

