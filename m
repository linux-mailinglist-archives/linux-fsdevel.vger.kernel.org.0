Return-Path: <linux-fsdevel+bounces-11046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0293B8503DE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 11:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2011F2376D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 10:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253DA364C2;
	Sat, 10 Feb 2024 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RWSz3RN3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAB136132;
	Sat, 10 Feb 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707560462; cv=none; b=BEMGoyKezM2OX/NQjDWwmIG17+PvUn/IyUlvRO5p8H5HXCbNP5qHmZvGBpATuW+9dU5vYv3AIz8CjY6k6xzphfJ9axccED11lr5+exLwzt0fCaMQ0vgtt9vm9d1EB1hcN/XjS8hmUUqxSlg5Kw+Mzq4QiaCFYvFscDrMRF+8B7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707560462; c=relaxed/simple;
	bh=jwDkwqD9xadpWe0tlX2hjpeWUF5VC1o0HlE1/3FcU+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRtCCB+AEC9l7iFF5HLW/ojss3U5OiRlHzagEIIBBI/yQHwjllVj7wflyP94G7keGXsW8gnNLs982fxcEr4dOg3nTQb7v0T1S/xVrh8M64IjEqMittrLpN8OZfw10gpomrJWl09zBauRVD8bp+cIoOBDGBrC3lXbDwz8MAqSJac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RWSz3RN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5D5C433C7;
	Sat, 10 Feb 2024 10:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707560462;
	bh=jwDkwqD9xadpWe0tlX2hjpeWUF5VC1o0HlE1/3FcU+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWSz3RN3B8YKdVgFsnvSw3yEXQPoCrxGWKISaYCFtXYtkv98fvfE5hsS/cGO3435U
	 IjgeEhgi92tyiI9m5h7AoFg+3KTDRGioy0htjTEqRBDt49N+d1lOKMI1a11VLg3afA
	 +5TQtNRMk2ROlvGz+RhDMWTBvPAeucJmZb06oF7M=
Date: Sat, 10 Feb 2024 10:20:58 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Avi Kivity <avi@scylladb.com>, Sandeep Dhavale <dhavale@google.com>,
	Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
Subject: Re: [PATCH v3] fs, USB gadget: Remove libaio I/O cancellation support
Message-ID: <2024021022-ahoy-vintage-b210@gregkh>
References: <20240209193026.2289430-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209193026.2289430-1-bvanassche@acm.org>

On Fri, Feb 09, 2024 at 11:30:26AM -0800, Bart Van Assche wrote:
> Originally io_cancel() only supported cancelling USB reads and writes.
> If I/O was cancelled successfully, information about the cancelled I/O
> operation was copied to the data structure the io_cancel() 'result'
> argument points at. Commit 63b05203af57 ("[PATCH] AIO: retry
> infrastructure fixes and enhancements") changed the io_cancel() behavior
> from reporting status information via the 'result' argument into
> reporting status information on the completion ring. Commit 41003a7bcfed
> ("aio: remove retry-based AIO") accidentally changed the behavior into
> not reporting a completion event on the completion ring for cancelled
> requests. This is a bug because successful cancellation leads to an iocb
> leak in user space. Since this bug was introduced more than ten years
> ago and since nobody has complained since then, remove support for I/O
> cancellation. Keep support for cancellation of IOCB_CMD_POLL requests.
> 
> Calling kiocb_set_cancel_fn() without knowing whether the caller
> submitted a struct kiocb or a struct aio_kiocb is unsafe. The
> following call trace illustrates that without this patch an
> out-of-bounds write happens if I/O is submitted by io_uring (from a
> phone with an ARM CPU and kernel 6.1):
> 
> WARNING: CPU: 3 PID: 368 at fs/aio.c:598 kiocb_set_cancel_fn+0x9c/0xa8
> Call trace:
>  kiocb_set_cancel_fn+0x9c/0xa8
>  ffs_epfile_read_iter+0x144/0x1d0
>  io_read+0x19c/0x498
>  io_issue_sqe+0x118/0x27c
>  io_submit_sqes+0x25c/0x5fc
>  __arm64_sys_io_uring_enter+0x104/0xab0
>  invoke_syscall+0x58/0x11c
>  el0_svc_common+0xb4/0xf4
>  do_el0_svc+0x2c/0xb0
>  el0_svc+0x2c/0xa4
>  el0t_64_sync_handler+0x68/0xb4
>  el0t_64_sync+0x1a4/0x1a8
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Avi Kivity <avi@scylladb.com>
> Cc: Sandeep Dhavale <dhavale@google.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Fixes: 63b05203af57 ("[PATCH] AIO: retry infrastructure fixes and enhancements")

I can't see this git id in Linus's tree, are you sure it is correct?

thanks,

greg k-h

