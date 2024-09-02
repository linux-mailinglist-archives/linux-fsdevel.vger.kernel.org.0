Return-Path: <linux-fsdevel+bounces-28235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D2A968604
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 13:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD714283185
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 11:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3438184548;
	Mon,  2 Sep 2024 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhXEWN2E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E48183CA6;
	Mon,  2 Sep 2024 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275975; cv=none; b=O6Ivxl/fqbSi7IDZE8M63vBZmY0gMRd0d83OaL4qGVjnMbNHeibPWqJgSuhR0IJ0+LHYIz2Lzdh8QXIyA/tqMqYRg6hBCr5l2t2lo4Ar6+koYM3Pq5BNmCVbdmIGyVbqtB4q1lkm8eoWwohjOwRdKWTbmhHKz4dVjamDvslBtWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275975; c=relaxed/simple;
	bh=jZSPsbRDeYfAIjFSccAJD5W2bOgGFFO+iX0qP5NmWsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ngm8Hy9HICsUr0pjXpfj6LsvXZmUjOkXvAahAJobHfAWjVCNtuGugesYXauANd/2mNLBxSuYpKzg+WhlMWVdA/nM8XWmLk3HZbW7Q8aL5cI5rTru6jQy9usL/lFoZrH9GusSRn92GuSvlAshZjHK4KvVRKj8TRZdSP1RPTd1gHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhXEWN2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B508C4CEC2;
	Mon,  2 Sep 2024 11:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725275974;
	bh=jZSPsbRDeYfAIjFSccAJD5W2bOgGFFO+iX0qP5NmWsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VhXEWN2E9SZrEYGDgIOUaT6c13AO0YRmKmHoqVijmCSyZ8uqynj5AEHoRptLZb12b
	 pbR8f9WKDnb/cL4nuK7thjEmvBWtX2QHgL1zJgPivib3zS6qzKEU5S3CoLPB8t/qK0
	 T/B6XRjOKcpHehkTYh6xEA9pZDOI6sVufsQUKfJ6+SiEN1Wnj7E9fW/ccF3jyzczyz
	 uI7PPmsaEhEIeGSQfc+XzDNRU34GYY281uCtHBY/dbL+yXo+bgUue2+nUqPkaHFsLH
	 riu7ESgI1nbpMVMDUV2/2yQW3N1iAfrvJUhTSLlfVPj8SCkbjmKQL5RYsDZ/SJ/LPh
	 NPe8lBliBijxA==
Date: Mon, 2 Sep 2024 13:19:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	amir73il@gmail.com, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-bcachefs@vger.kernel.org, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 16/16] xfs: add pre-content fsnotify hook for write
 faults
Message-ID: <20240902-kollidieren-geldbeschaffung-ba4bb1b038d0@brauner>
References: <cover.1723670362.git.josef@toxicpanda.com>
 <631039816bbac737db351e3067520e85a8774ba1.1723670362.git.josef@toxicpanda.com>
 <20240829111753.3znmdajndwwfwh6n@quack3>
 <20240830232833.GR6216@frogsfrogsfrogs>
 <20240902102344.evvpipetu6zghrwz@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240902102344.evvpipetu6zghrwz@quack3>

On Mon, Sep 02, 2024 at 12:23:44PM GMT, Jan Kara wrote:
> On Fri 30-08-24 16:28:33, Darrick J. Wong wrote:
> > On Thu, Aug 29, 2024 at 01:17:53PM +0200, Jan Kara wrote:
> > > On Wed 14-08-24 17:25:34, Josef Bacik wrote:
> > > > xfs has it's own handling for write faults, so we need to add the
> > > > pre-content fsnotify hook for this case.  Reads go through filemap_fault
> > > > so they're handled properly there.
> > > > 
> > > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > 
> > > Looks good to me but it would be great to get explicit ack from some XFS
> > > guy...  Some selection CCed :)
> > 
> > Looks decent to me, but I wonder why xfs_write_fault has to invoke
> > filemap_maybe_emit_fsnotify_event itself?  Can that be done from
> > whatever calls ->page_mkwrite and friends?
> 
> So we were discussing this already here [1]. The options we have:
> 
> 1) Call filemap_maybe_emit_fsnotify_event() from filesystem hooks

Sidenote: Can that be renamed to filemap_fsnotify() or something
similar. Especially that "maybe" in there really doesn't add value imho.

