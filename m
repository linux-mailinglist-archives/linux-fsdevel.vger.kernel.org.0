Return-Path: <linux-fsdevel+bounces-58827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E010B31C11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82141D64C8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBF93126BE;
	Fri, 22 Aug 2025 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNAKblhD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D483126A2;
	Fri, 22 Aug 2025 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873017; cv=none; b=tYNcR6SFtJVyuF5Qu98D2Bd65AOJ9BGBVmJV3HjvQqhsmz0wBHyJ5/MC/816X1oEYyC4SF2gTRWDSveLMJYXSWFI+rS1QS7s6+9Zf9HYlLnA1mWfZwerupUWcatQDaAWSEIhUa/hVF/sdG11VWnOIrTS6SUqU2X3iRsoQrQmggw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873017; c=relaxed/simple;
	bh=Fb4Tl08JSw5g4q+81h38d4NVzRH5WJTAHSr9V3+/Yw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixRRJjdM0C211GyDKMgd3cKW+LYnI7PKYg1tEACb/wCP/3jcUGoJoPsQgfDB/+ybkGq6oCbPdjBD8kfS8DcdDaOWef7mVMRykK3ZO2+VBGdCRZ0zME3F22AnUEFconH0vwee456Rv1zwdXR+G+Q1aUYApRXfcDqixtwnVr3pckE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNAKblhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40953C113CF;
	Fri, 22 Aug 2025 14:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755873017;
	bh=Fb4Tl08JSw5g4q+81h38d4NVzRH5WJTAHSr9V3+/Yw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vNAKblhDR8m6nfud4a/26IwU9QfI8+bkN+RmS9yQ3m9qkj7Gwl9RCz4xRJ+MfWHNw
	 WoDAQxKRV6CvRtdZIHFVXB607VLpEnoP/ZNPReoXPUZ2K40OZYiKalWD63kmtVhNtb
	 xRihznT8R1caRb6ZNN5fhuikz6TLFJRyGuTGryFA2zIR+7Qx72hls2HaVFyLTdRIi1
	 fRUQyow3diyyBXgjCjTQIcOBhI/TBWv8vjALaHjQ/i/Ia+xQZlPX7rWl8QY021WLPK
	 D5ugYIdBVpwH1BJkmz2hYc3ulmJouUmYGWZwWeB6RWFLsJcDzr2oI6Tuvysz97Sjig
	 A34b+v9w6UQsw==
Date: Fri, 22 Aug 2025 08:30:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, snitzer@kernel.org, axboe@kernel.dk,
	dw@davidwei.uk, brauner@kernel.org, hch@lst.de,
	martin.petersen@oracle.com, djwong@kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
	Jan Kara <jack@suse.com>
Subject: Re: [PATCHv3 0/8] direct-io: even more flexible io vectors
Message-ID: <aKh-9nOqiSbMAtwo@kbusch-mbp>
References: <20250819164922.640964-1-kbusch@meta.com>
 <87a53ra3mb.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a53ra3mb.fsf@gmail.com>

On Fri, Aug 22, 2025 at 06:57:08PM +0530, Ritesh Harjani wrote:
> Keith Busch <kbusch@meta.com> writes:
> 
> BTW - I did some basic testing of the series against block device, XFS &
> EXT4 and it worked as expected (for both DIO & AIO-DIO) i.e.
> 1. Individial iov_len need not be aligned to the logical block size anymore.
> 2. Total length of iovecs should be logical block size aligned though.
> 
> i.e. this combination works with this patch series now:
> 
>     posix_memalign((void**)&aligned_buf, mem_align, 2 * BLOCK_SIZE);
>     struct iovec iov[4] = {
>         {.iov_base = aligned_buf, .iov_len = 500},
>         {.iov_base = aligned_buf + 500, .iov_len = 1500},
>         {.iov_base = aligned_buf + 2000, .iov_len = 2000},
>         {.iov_base = aligned_buf + 4000, .iov_len = 4192}
>     }; // 500 + 1500 + 2000 + 4192 = 8192

Yep, the kernel would have rejected that before, but should work now. An
added bonus, the code doesn't spend CPU cycles walking the iovec early
anymore.

Your test, though, is not getting to the real good stuff! :) Your
vectors are virtually contiguous, so the block layer will merge them to
maybe only one block sized segment. Add some offsets to create gaps, but
still adhere to your device's dma and virtual boundary limits. Your
offset options may be constrained if you're using NVMe, but I have a
follow up series fixing that for capable hardware.

