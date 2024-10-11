Return-Path: <linux-fsdevel+bounces-31687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C979799A22B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 13:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA2E2870CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 11:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7367F213EDE;
	Fri, 11 Oct 2024 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEUTMg/e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7E21E3DC7;
	Fri, 11 Oct 2024 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644394; cv=none; b=CqmOXHc1hpT1Hvr2WGwj0e7EG3HWNjKNXgqRQyj4hRcAXFrpTzJicxyQlWqUmxNngmGxuzRmFCDriUJV4+XggHtaYgJOKLVUVORnoSOUm9njP8BKm0bqnGxeuPzzR3Xf7b8VUNb2SK4qvaRry/Xg8BY6H+TtuIpYB5QxvZlZn0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644394; c=relaxed/simple;
	bh=ycxJ6ScFzSsNKvzWi3lumTfu4nd8mOU96CEiXUCV0M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CATqYzlKfFKUJCKfo/4qYj/H5/TIDa0FW3oEx2SzHQyILsVyz0AUsN6/v9hNb/xvr1gtWZKSJhptLS4icbD8IyRG80QniQNj4ZTc5ieDIT0msTna7nG5Jq6yFfJy+CF4d72Q+V4G8pfw35UmXqkGCdDmoBs+wO7GLKEpu4b1qjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEUTMg/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF1DC4CECD;
	Fri, 11 Oct 2024 10:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728644394;
	bh=ycxJ6ScFzSsNKvzWi3lumTfu4nd8mOU96CEiXUCV0M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dEUTMg/eJbTJlFpwAz9flrVgSEgv9Bnf0wNt84kvTR6FIAM4al4tI+4KqtYXL53nL
	 SUCv1zekFCRQPUJNrm7nU0Qh+HHAzUW3N15/nD6ySa6bDTdcrqRSjPDNLgaHYvbF1U
	 i87T5JkD7Ivk/Dl9xJHesvBawWVe+phylaSfpk21ZQiIUJ/CbMuiYeuP4f00uBDrVd
	 JyGrNlkBnapz7S5+NSfgvJm67KIOTvuJ+WnU1WFN+rMdDrWApd/zjTJbHxsQWbeJJC
	 Fuw/ceF+Oa62wKg5h51g1wsjlIlULL1XBQo7ZSLzVUednnMQYLqVVzJUn127rOj7nL
	 LBPP5ifLk9hog==
Date: Fri, 11 Oct 2024 12:59:50 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: fix stale delalloc punching for COW I/O v5
Message-ID: <wlyiudd5izvirhd3uotvq5ybh2xpkzw36pbk2y5xdj3ko6aedn@5o7ylpqyk3qx>
References: <20241008085939.266014-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008085939.266014-1-hch@lst.de>

On Tue, Oct 08, 2024 at 10:59:11AM GMT, Christoph Hellwig wrote:
> Hi all,
> 

Just as a heads up to Christian, that I'm adding this to my queue now as most of
these are xfs-related.

Carlos

> this is another fallout from the zoned XFS work, which stresses the XFS
> COW I/O path very heavily.  It affects normal I/O to reflinked files as
> well, but is very hard to hit there.
> 
> The main problem here is that we only punch out delalloc reservations
> from the data fork, but COW I/O places delalloc extents into the COW
> fork, which means that it won't get punched out forshort writes.
> 
> 
> Changes since v4:
>  - unshare also already holds the invalidate_lock as found out by recent
>    fsstress enhancements
> 
> Changes since v3:
>  - improve two comments
> 
> Changes since v2:
>  - drop the patches already merged and rebased to latest Linus' tree
>  - moved taking invalidate_lock from iomap to the caller to avoid a
>    too complicated locking protocol
>  - better document the xfs_file_write_zero_eof return value
>  - fix a commit log typo
> 
> Changes since v1:
>  - move the already reviewed iomap prep changes to the beginning in case
>    Christian wants to take them ASAP
>  - take the invalidate_lock for post-EOF zeroing so that we have a
>    consistent locking pattern for zeroing.
> 
> Diffstat:
>  Documentation/filesystems/iomap/operations.rst |    2 
>  fs/iomap/buffered-io.c                         |  111 ++++++-------------
>  fs/xfs/xfs_aops.c                              |    4 
>  fs/xfs/xfs_bmap_util.c                         |   10 +
>  fs/xfs/xfs_bmap_util.h                         |    2 
>  fs/xfs/xfs_file.c                              |  146 +++++++++++++++----------
>  fs/xfs/xfs_iomap.c                             |   67 +++++++----
>  include/linux/iomap.h                          |   20 ++-
>  8 files changed, 198 insertions(+), 164 deletions(-)
> 

