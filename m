Return-Path: <linux-fsdevel+bounces-45428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B47BA778FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 12:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02925188DED0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 10:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5371C1F2F;
	Tue,  1 Apr 2025 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQuU9h3/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E775C1F03C1;
	Tue,  1 Apr 2025 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743503941; cv=none; b=hTcDpMxtegQP+CaFc5tNlYV4TXikYhb3YEbs0/W/6VAIn89dubwvPaeeqfPF7cs1lmQxlbiYkMXD8NQ/+MPNYmX6tUwIf4QL/Qh5AlOAvth5GCXTa1+oIsWHieqexiMwNDXMaKC8PA/Yov3TopzJmYIC6X1gfehMI7H6bz6ZRL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743503941; c=relaxed/simple;
	bh=xzSk4RrNw0hne6KOrxEzMiFTHDtlwU9EpndEZ5Fd1bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsJ0Ngwg5GuXxbe384IgKHong4NX4c0AUJeo43XLHLQsoOPFJoTKgr/ZyLx4oTWnm3ZSiKO7pDy9IebS47SSIv2e30VYcBRMdpR8cw3eTyRhxbKklledCD3r9JIzS1hLeY4TNyL9Vnr4YKmmasD4bCBODYj358JJzUkS+RKumr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQuU9h3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960DFC4CEE8;
	Tue,  1 Apr 2025 10:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743503940;
	bh=xzSk4RrNw0hne6KOrxEzMiFTHDtlwU9EpndEZ5Fd1bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fQuU9h3/Ge4k1UqejHmnhVX0eSVne4q3qXHcLbz9LtaT98OUdqjx8R+JRpwi8+BHn
	 gFUVE3Olz2+u52QmE8pmxCXzZ/F5jy3538UuqFXBc1fQuMC2Ixe3Ikrws5nzBTrBCh
	 wpqqbLEI4dszJcfwLc2/Yy7YDZObyoJ1F8cBiuhhExEdW0eDYXGE0HRpdhRW8NXGqH
	 FJF9WkRx4P3iQ7EsmJDEYG3dsykuQZXsHCTSQWoqqJ2JAI66qAw9VjjDa5tZrkJdyz
	 HSRin7ytnW/DL1K6HyajETdIMvnoCCSr+of4eGd6S3ssKEQZDE7rs2/7rV5y5YOHuA
	 oeb7JCEttcfbA==
Date: Tue, 1 Apr 2025 12:38:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "willy@infradead.org" <willy@infradead.org>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>, 
	"lkp@intel.com" <lkp@intel.com>, David Howells <dhowells@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	Patrick Donnelly <pdonnell@redhat.com>, Alex Markuze <amarkuze@redhat.com>, 
	"idryomov@gmail.com" <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: fix variable dereferenced before check in
 ceph_umount_begin()
Message-ID: <20250401-wohnraum-willen-de536533dd94@brauner>
References: <20250328183359.1101617-1-slava@dubeyko.com>
 <Z-bt2HBqyVPqA5b-@casper.infradead.org>
 <202939a01321310a9491eb566af104f17df73c22.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202939a01321310a9491eb566af104f17df73c22.camel@ibm.com>

On Fri, Mar 28, 2025 at 07:30:11PM +0000, Viacheslav Dubeyko wrote:
> On Fri, 2025-03-28 at 18:43 +0000, Matthew Wilcox wrote:
> > On Fri, Mar 28, 2025 at 11:33:59AM -0700, Viacheslav Dubeyko wrote:
> > > This patch moves pointer check before the first
> > > dereference of the pointer.
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > Closes: https://lore.kernel.org/r/202503280852.YDB3pxUY-lkp@intel.com/ 
> > 
> > Ooh, that's not good.  Need to figure out a way to defeat the proofpoint
> > garbage.
> > 
> 
> Yeah, this is not good.
> 
> > > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> > > index f3951253e393..6cbc33c56e0e 100644
> > > --- a/fs/ceph/super.c
> > > +++ b/fs/ceph/super.c
> > > @@ -1032,9 +1032,11 @@ void ceph_umount_begin(struct super_block *sb)
> > >  {
> > >  	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
> > >  
> > > -	doutc(fsc->client, "starting forced umount\n");
> > >  	if (!fsc)
> > >  		return;
> > > +
> > > +	doutc(fsc->client, "starting forced umount\n");
> > 
> > I don't think we should be checking fsc against NULL.  I don't see a way
> > that sb->s_fs_info can be set to NULL, do you?
> 
> I assume because forced umount could happen anytime, potentially, we could have
> sb->s_fs_info not set. But, frankly speaking, I started to worry about fsc-

No, it must be set. The VFS guarantees that the superblock is still
alive when it calls into ceph via ->umount_begin().

