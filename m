Return-Path: <linux-fsdevel+bounces-38546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E0BA03856
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 08:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428D83A42E8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 07:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163A41DFE23;
	Tue,  7 Jan 2025 07:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tip5vQQy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E5F197A68;
	Tue,  7 Jan 2025 07:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736233436; cv=none; b=tjQQuBHBX/9hFUWUktgwrF9RlEePO5A0vPtvZ+oGXHuhSiFGBeUNxGDoA8NTZ02q4narDE1hCeCEsRaSBvCVwwQQXL5At4R8ztElIE4hsWvecrx/LeYXob3JUux1xj1wAN7zeQUC2t834JxEFcwUJBPEvZ19UR/PnUzWSWQLVhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736233436; c=relaxed/simple;
	bh=xHQte6L/AwKA5hpjNm6UhPZjwQKdvizBRh0A+UFDyIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieAmiKO42GcrlleaLpJK82tQ5HXKz0j7OtWpBq/aHrZ0X/sna3MLfBzgSSDEiR0clM7+2fPv3L/8kmxRNhxs+DOU1ywaLkPvfTbCYPgDev54r5YgQD89XV/5eSmytVYn5tDda+6c4JnW7loLsMEI71Rn/h4qcSM4674X76s1o8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tip5vQQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB31DC4CEE0;
	Tue,  7 Jan 2025 07:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736233435;
	bh=xHQte6L/AwKA5hpjNm6UhPZjwQKdvizBRh0A+UFDyIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tip5vQQy11mk6ukdUDJo7V0eKJYJ3iw5o3L+aIQY1CO6gzVD4NXlbJNjtaxxUpYz2
	 qyDHqjiBmCZ5wPBGVM/Q0hO8OeEbWzQ+f7SF+/ZCP+IlsmcixiKQjilrYhhRETG14h
	 bnJQEjU5gM5EdeKuCvdQ1O6SKWc1t6OG1ZuKZSbOL40BNRva28tbGgc+IvStBdCZZe
	 H1LXJuOR/zetU/3KHcY5IVVeB1PKtmLJAA3rXCf7Sfq9kIuxAh0BlQJvDRsR007UFv
	 mxz20baxB0PQveqsVTbOwi2IhWsGRc82Idv2kf70Rv4SJJvA6GqnxfLZv5YSxUeQWX
	 AOwOEpPQQrjrA==
Date: Mon, 6 Jan 2025 23:03:55 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/4] xfs: report the correct read/write dio alignment for
 reflinked inodes
Message-ID: <20250107070355.GH6174@frogsfrogsfrogs>
References: <20250106151607.954940-1-hch@lst.de>
 <20250106151607.954940-5-hch@lst.de>
 <dd525ca1-68ff-4f6d-87a9-b0c67e592f83@oracle.com>
 <20250107061012.GA13898@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107061012.GA13898@lst.de>

On Tue, Jan 07, 2025 at 07:10:12AM +0100, Christoph Hellwig wrote:
> On Mon, Jan 06, 2025 at 06:37:06PM +0000, John Garry wrote:
> >> +	/*
> >> +	 * On COW inodes we are forced to always rewrite an entire file system
> >> +	 * block or RT extent.
> >> +	 *
> >> +	 * Because applications assume they can do sector sized direct writes
> >> +	 * on XFS we fall back to buffered I/O for sub-block direct I/O in that
> >> +	 * case.  Because that needs to copy the entire block into the buffer
> >> +	 * cache it is highly inefficient and can easily lead to page cache
> >> +	 * invalidation races.
> >> +	 *
> >> +	 * Tell applications to avoid this case by reporting the natively
> >> +	 * supported direct I/O read alignment.
> >
> > Maybe I mis-read the complete comment, but did you really mean "natively 
> > supported direct I/O write alignment"? You have been talking about writes 
> > only, but then finally mention read alignment.
> 
> No, this is indeed intended to talk about the different (smaller) read
> alignment we are now reporting.  But I guess the wording is confusing
> enough that I should improve it?

How about:

/*
 * For COW inodes, we can only perform out of place writes of entire
 * file allocation units (clusters).  For a sub-cluster directio write,
 * we must fall back to buffered I/O to perform the RMW.  At best this
 * is highly inefficient; at worst it leads to page cache invalidation
 * races.  Tell applications to avoid this by reporting separately the
 * read and (larger) write alignments.
 */

--D

