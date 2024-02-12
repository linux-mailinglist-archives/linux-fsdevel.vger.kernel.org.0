Return-Path: <linux-fsdevel+bounces-11103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A48D851196
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 11:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE281F20FFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 10:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C941920DE8;
	Mon, 12 Feb 2024 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSGgCuYB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB9C2555B;
	Mon, 12 Feb 2024 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707735262; cv=none; b=jrWeH+vIXvYcmbgrz4rwXrS/rQ9YbIsGqNm9UyzJ+q+iY4dIydn613HZR0LEVMu14qQS7c0jlQVgvTXbTMYMZzeRhTBRi4QRy1lQztL1l6mllKTyqZF6xKVxyEHQAQi0AJxrG3W5szTo3POO+/VNRbY84bwxRYp+mos6cUYr5k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707735262; c=relaxed/simple;
	bh=I6euxNxNU8o6q+fS/THeaLsXmcMYc805VACZ871eUbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cu67zVQybwY2f+TO3kxgY19CcTUHmnPBMhvXjyjrXN9/t0xYK8uiXS0OC2RK4Iao47hyMWf3/gNe3yEye7pCcF4NLuqosvnRkN0qSJLmnUgREykDo8nc3T2O73OspHv2NcVFXs6ub2VvdoUSPyCjzDMuK5ZAF0jS+3zZQw0cMfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSGgCuYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A00C433C7;
	Mon, 12 Feb 2024 10:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707735261;
	bh=I6euxNxNU8o6q+fS/THeaLsXmcMYc805VACZ871eUbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nSGgCuYBLI7mmVkw3MKSEpB9h3hkmm25fpfDfy3Lq69Lj9SJgTNjYP55TRcCnqEWW
	 edVkVia5352NYMnTNFc+ZE83R0Ej0W7ksASgHlzoLkBsLRp1KFrtYGZnPKEtcVS9t2
	 Ak7660ebGDG8ni+/pqmysmvvIaCvoT6GTp/hVe6t/K31jk1An+EezweGKYFIloytA3
	 0KW+RiRql8DCimPhClQcZD+ZxU4Afl+KXx1MvsvJjIFxlzMlgjNJ0aiTatTzBMGggt
	 aJTAaE1h24Rfv4tuDQ8gwoyeFuI0hIBg/NCPO5KTSRr8MCHKGGDGg0UM4KF+e3O8h7
	 uALf7TkVJMLjA==
Date: Mon, 12 Feb 2024 11:54:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>, 
	Sandeep Dhavale <dhavale@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3] fs, USB gadget: Remove libaio I/O cancellation support
Message-ID: <20240212-heilt-leerlauf-a6befe24ee67@brauner>
References: <20240209193026.2289430-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---

Great,
Reviewed-by: Christian Brauner <brauner@kernel.org>

