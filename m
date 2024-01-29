Return-Path: <linux-fsdevel+bounces-9416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466F1840C50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 17:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECF71C21DDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7A7158D99;
	Mon, 29 Jan 2024 16:49:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2B61586DC;
	Mon, 29 Jan 2024 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546982; cv=none; b=OBXOZrze/mdBKz0cEQe/lMiwtqtFHwwVkx354/Y1SToGJ+rXQDr9CY4jsOeky8UwrP5ygFinmSlSHr22mQinWIQmwtYCEKJURgZnsoZsDj4SMX4ONY7QsEk++TZAoSUPV1n8KfTAxPw/2o85Hhl/X78DAfbaGMNl7QdZpaxlfhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546982; c=relaxed/simple;
	bh=IV5DA19radB9e79+4WF0YspUKv2sUx3yM9ovAFgEU9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cc0+OPjAVmOktYZcNYTqNcYhxLG3+mRdUQ0ph8CRfdaJRtkLDvBp9qmA+C//kTAbIe6qnNveGCg/dPGtIYth2xxES+lqzSrahJlGPu2R1Q0WfUp+uMcoeTlj62bJiqHwIv0QW8SlzxYws6ATdlzIP0GcJFkdIfFAltWza2xy3+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 088FA68C4E; Mon, 29 Jan 2024 17:49:35 +0100 (CET)
Date: Mon, 29 Jan 2024 17:49:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 31/34] block: use file->f_op to indicate restricted
 writes
Message-ID: <20240129164934.GA4587@lst.de>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org> <20240123-vfs-bdev-file-v2-31-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-31-adbd023e19cc@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 23, 2024 at 02:26:48PM +0100, Christian Brauner wrote:
> Make it possible to detected a block device that was opened with
> restricted write access solely based on its file operations that it was
> opened with. This avoids wasting an FMODE_* flag.
> 
> def_blk_fops isn't needed to check whether something is a block device
> checking the inode type is enough for that. And def_blk_fops_restricted
> can be kept private to the block layer.

I agree with not wasting a FMODE_* flag, but I also really hate
duplicating the file operations.

I went to search for a good place to stash this information and ended up
at the f_version field in struct file.  That one is never touched by the 
VFS proper but just the file system and a few lseek helpers.  The
latter currently happen to be used by block devices unfortunately,
but it seem like moving the f_version clearing into the few filesystem
actualy using it would be good code hygiene anyway.


