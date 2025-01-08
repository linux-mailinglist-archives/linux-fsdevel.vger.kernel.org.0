Return-Path: <linux-fsdevel+bounces-38611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB60A04E39
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 01:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AAEC3A6197
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 00:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A93838DE9;
	Wed,  8 Jan 2025 00:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K//HoggS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8392AF04;
	Wed,  8 Jan 2025 00:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736296864; cv=none; b=UF1FXFl7qlemp+/nYpMaOmWwq6nGWLUJVpqggGzp6Vhto0Lq6XlhZwJwNAH289uJSQyP610jniITk69XFeETmChqtt8b3YkzSTe1IIQRYzvoPMLwv3tI4cK8s2fcIbA7xwsmBvUIQJbeDghNdZXzbubZv6mgY6yLzlSIKYPzmoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736296864; c=relaxed/simple;
	bh=ZDTEhjnhwtf7LbPGKOS/VVoCibEBG2tcWNEhlQyax24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSg+B2DWssRFHgV1WAF29vC9h5RaMo4pTeRhv8gQ/9W/a02m4wP4EozrRPVEdSkFVga92GAZIzdWC8Pre/4pPXKj/ywPQCetO6k59D5MSdTNo60slrGc0nm4UCq8YNObWYDBY0mzeKAdUXmjtLaj4tEyeYkT0YzPcAuA0rY4QSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K//HoggS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D76C4CED6;
	Wed,  8 Jan 2025 00:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736296864;
	bh=ZDTEhjnhwtf7LbPGKOS/VVoCibEBG2tcWNEhlQyax24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K//HoggSEU8nBLj6V9dO5d0upivTeEf+wPaJPMLXk4CYOZjH+uD9C53vlTun/HWkD
	 vWQSnol4VkkIGaA5r8/5wMV9kbAgi5V3K+aHtT1s2ddSQfgg1ZBUC7cGcCeuMb1t7R
	 X07bUwPQ+Ap116Xmu5oQzABsn6tnh/+D27oUySYRlXdXhaWg7CtFSatpSs1/3RjoDO
	 G6SPrptx22v+GhYSMH8E5RVu6J1YqKCYL3p/dNVhDvNHR0iPJlNkfvfEbkyCipr+rl
	 Fx+1bTghF7BpeOYp0WTusknHZcwtNKxv/Pg55qnVx63Snb6Pgzd6lpdbgcFa9s4Bw3
	 1SHeTTRmKA/wQ==
Date: Tue, 7 Jan 2025 16:41:03 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 3/7] iomap: Lift blocksize restriction on atomic writes
Message-ID: <20250108004103.GA1306365@frogsfrogsfrogs>
References: <20250102140411.14617-1-john.g.garry@oracle.com>
 <20250102140411.14617-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102140411.14617-4-john.g.garry@oracle.com>

On Thu, Jan 02, 2025 at 02:04:07PM +0000, John Garry wrote:
> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> 
> Filesystems like ext4 can submit writes in multiples of blocksizes.
> But we still can't allow the writes to be split. Hence let's check if
> the iomap_length() is same as iter->len or not.
> 
> It is the role of the FS to ensure that a single mapping may be created
> for an atomic write. The FS will also continue to check size and alignment
> legality.
> 
> Signed-off-by: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> jpg: Tweak commit message
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Fine with me.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 18c888f0c11f..6510bb5d5a6f 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -314,7 +314,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	size_t copied = 0;
>  	size_t orig_count;
>  
> -	if (atomic && length != fs_block_size)
> +	if (atomic && length != iter->len)
>  		return -EINVAL;
>  
>  	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
> -- 
> 2.31.1
> 
> 

