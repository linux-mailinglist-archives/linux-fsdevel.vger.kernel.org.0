Return-Path: <linux-fsdevel+bounces-3311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D9B7F31B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 15:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0011C21C5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 14:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960F554FB2;
	Tue, 21 Nov 2023 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSzVy5Ct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE63833DA
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 14:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9884CC433C7;
	Tue, 21 Nov 2023 14:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700578599;
	bh=8FmCxkEnHhgmNBOAqNM2xFCmYVixnF/HJ/DKWRM2L7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSzVy5Ct8aj/mOsYdqpkdTxV8ixB0LlWtjsVTW+OS044zVrLuAbZ5N+yJmA4NQ0KP
	 0n4evX4N5q8P0fYQMM6JlWxif/W3Jzc+cFx5q5GdPWWpcMO5vzx2ASuNGMYsfb5BPy
	 HCcYHELok6AMcG+6ou9G2N7b2eHIDnck1lmtN5/JVa/zmuaAkKztoeqa1afshFGckx
	 FMD2A3LEQfoXcxqx+FcQBOLxOdajC6PLOlufSSBe3CSHgH0WjOyuo/lbISswOtT6eN
	 ytC9yk03TFVoxJzA/gEEFMwzl26P7LsUsBUGv7UgSqL8+tbNSye7gCfkuED4eqYm5r
	 LKYUKm63BP83Q==
Date: Tue, 21 Nov 2023 15:56:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/15] splice: remove permission hook from
 iter_file_splice_write()
Message-ID: <20231121-einband-erwidern-a606cece3bc0@brauner>
References: <20231114153321.1716028-1-amir73il@gmail.com>
 <20231114153321.1716028-6-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231114153321.1716028-6-amir73il@gmail.com>

On Tue, Nov 14, 2023 at 05:33:11PM +0200, Amir Goldstein wrote:
> All the callers of ->splice_write(), (e.g. do_splice_direct() and
> do_splice()) already check rw_verify_area() for the entire range
> and perform all the other checks that are in vfs_write_iter().
> 
> Create a helper do_iter_writev(), that performs the write without the
> checks and use it in iter_file_splice_write() to avoid the redundant
> rw_verify_area() checks.
> 
> This is needed for fanotify "pre content" events.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

If you resend anyway, for the low-level splice helpers specifically it
would be nice to add a comment that mentions that the caller is expected
to perform basic rw checks.

