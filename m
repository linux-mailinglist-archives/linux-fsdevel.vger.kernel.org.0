Return-Path: <linux-fsdevel+bounces-39222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2E5A11709
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 03:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757A6188B566
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 02:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A6822DFB5;
	Wed, 15 Jan 2025 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2sEHWVS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E39222DF8A;
	Wed, 15 Jan 2025 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736907010; cv=none; b=rrdwqElvwE8VT/Q3aAUEAqTszr7cOgQAwmDf+JKvA3D6UIqoIckiEBt4CfvcWDUG+41g9molwDdOB+3o/xBQ75hNyPEcWOLzQe0llxemfQEsIM6gBiuSb4Tx6oNQ1MjLEnhBDBSuzbmWB9/B/zPzgvg5mSFi6l0XqL4kg1ha6GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736907010; c=relaxed/simple;
	bh=0of+rTg+LvFaFw8d6zhTmxYVB0urbY9S3+ltvXG8aYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRzu/U9MZUYlVBTG8xgHyBVvkwmC7MC3OEv9cxGda0nMD7Nwp5akrfHvSbwW+ZJE2CqfbA5GVW403rgOcsBVcg1BhfsWjAt6RTrkh28OcilNTl1+dm9Itcxq6p4cKyCql86wYAEoVfRoqiebmdwr1g5NzOojgR7hDLXfgUOzbyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2sEHWVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDF6C4CEDF;
	Wed, 15 Jan 2025 02:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736907010;
	bh=0of+rTg+LvFaFw8d6zhTmxYVB0urbY9S3+ltvXG8aYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L2sEHWVS0lB3BOii/uosf0tH0kf5X8kQOqQSrcbHkh9ChH2EtYihN7BmfBkc7hchn
	 NGPM+9vcaDAuHRgbVyMdzBlo1BSPPoFevU6p4Sztw7jLP0gZ01uQo7IfbY6unIFIKZ
	 iK7xn9nmM+KyDhhT3sbiED0LmQRydbdAX4Cu/zBsahWlH5n3b6lRDP4q/12vb8VR0D
	 YL3ZKq+SVozvc96mo9f+xboP6FbGIOnZXsktKKU55kV2+4n6ZM2KgpQM7xevgUUuwV
	 9VAXcOOgU2pn9utFEpmzI5bE8aLsIjM+w24LzoElAT6cElRC7AWKOop9kI/py/3J+o
	 /52I1bXYTR1eQ==
Date: Tue, 14 Jan 2025 18:10:09 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Implementing the NFS v4.2 WRITE_SAME
 operation: VFS or NFS ioctl() ?
Message-ID: <20250115021009.GE3561231@frogsfrogsfrogs>
References: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>

On Tue, Jan 14, 2025 at 04:38:03PM -0500, Anna Schumaker wrote:
> I've seen a few requests for implementing the NFS v4.2 WRITE_SAME [1]
> operation over the last few months [2][3] to accelerate writing
> patterns of data on the server, so it's been in the back of my mind
> for a future project. I'll need to write some code somewhere so NFS &
> NFSD can handle this request. I could keep any implementation internal
> to NFS / NFSD, but I'd like to find out if local filesystems would
> find this sort of feature useful and if I should put it in the VFS
> instead.

It would help to know more about what exactly write same does on NFS.
Is it like scsi's where you can pass a buffer and it'll write the same
buffer over and over across the device?

> I was thinking I could keep it simple, and model a function call based
> on write(3) / pwrite(3) to write some pattern N times starting at
> either the file's current offset or at a user-provide offset.
> Something like:
>     write_pattern(int filedes, const void *pattern, size_t nbytes, size_t count);
>     pwrite_pattern(int filedes, const void *pattern, size_t nbytes, size_t count, offset_t offset);

So yeah, it sounds similar.  Assuming nbytes is the size of *pattern,
and offset/count are the range to be pwritten?

> I could then construct a WRITE_SAME call in the NFS client using this
> information. This seems "good enough" to me for what people have asked
> for, at least as a client-side interface. It wouldn't really help the
> server, which would still need to do several writes in a loop to be
> spec-compliant with writing the pattern to an offset inside the
> "application data block" [4] structure.

I disagree, I think you just volunteered to plumb this pattern writing
all the way through to the block layer. ;)

> But maybe I'm simplifying this too much, and others would find the
> additional application data block fields useful? Or should I keep it
> all inside NFS, and call it with an ioctl instead of putting it into
> the VFS?

io_uring subcommand?

But I'd want to know more about what people want to use this for.
Assuming you don't just hook up FALLOC_FL_ZERO_RANGE to it and call it a
day. :)

--D

> Thoughts?
> Anna
> 
> [1]: https://datatracker.ietf.org/doc/html/rfc7862#section-15.12
> [2]: https://lore.kernel.org/linux-nfs/CAAvCNcByQhbxh9aq_z7GfHx+_=S8zVcr9-04zzdRVLpLbhxxSg@mail.gmail.com/
> [3]: https://lore.kernel.org/linux-nfs/CALWcw=Gg33HWRLCrj9QLXMPME=pnuZx_tE4+Pw8gwutQM4M=vw@mail.gmail.com/
> [4]: https://datatracker.ietf.org/doc/html/rfc7862#section-8.1
> 

