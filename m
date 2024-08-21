Return-Path: <linux-fsdevel+bounces-26475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3BF959E67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 15:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F880B22345
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 13:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00411A2840;
	Wed, 21 Aug 2024 13:14:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B70119ABC1;
	Wed, 21 Aug 2024 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246075; cv=none; b=lwPcGmVCUKH4+GqT8ZsgsSD+2G7fuq6mpYAR5KLBqKOE7bR9JqDiCyahfMnvUJ/Boie0dOFqPc2pMG+CmivDjT3kP9ZcpKYw9IG8VSbk6a+ChABqBlCw6MKPLT53pvm7pGCjL7zqhUg1DiwXkw/FBFnw9BJ9NSZStLBWyqMzXY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246075; c=relaxed/simple;
	bh=A3YWBJIxhsU8dEoVy09RzSQzt4RlEDYezkcVF7X7JQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRpnRLWhVmWGbTmrrZRu1sE+Q0K7rUd2OZuvsMIUWtlFKhKiWHJRu74gRy/FbObEDFlxAEickq7G0ys4lywLOFzmWhCRBWOUm35HnWuDQv0x8O4Ysbw5oK/JnJEOLUyRyGLkcplxHuw0WxtJyQbGb0mj9q/nhtvujN/KGmzJCGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3CA38227A87; Wed, 21 Aug 2024 15:14:28 +0200 (CEST)
Date: Wed, 21 Aug 2024 15:14:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: sort out the fallocate mode vs flag mess
Message-ID: <20240821131428.GA22423@lst.de>
References: <20240821063108.650126-1-hch@lst.de> <20240821063108.650126-4-hch@lst.de> <ZsXg4mUWsTya0dNu@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsXg4mUWsTya0dNu@bfoster>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 21, 2024 at 08:43:14AM -0400, Brian Foster wrote:
> > -	if ((mode & ~FALLOC_FL_KEEP_SIZE) && IS_APPEND(inode))
> > +	if (mode != FALLOC_FL_ALLOCATE_RANGE && IS_APPEND(inode))
> >  		return -EPERM;
> 
> Unless I'm misreading, this changes semantics by enforcing that we
> cannot use KEEP_SIZE on append only files. That means one can no longer
> do a post-eof prealloc without actually changing the file size, which on
> a quick test seems to work today.

No, I think it was me misreading the old code.  And I'm a little worried
that no test cought it.


