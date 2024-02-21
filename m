Return-Path: <linux-fsdevel+bounces-12223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D427B85D436
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2D9282229
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F133D3BA;
	Wed, 21 Feb 2024 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCfXF3Ih"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BFF3D0BC
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508770; cv=none; b=WfSAA5oJ0sJlWY6vcA7FNxUAqK5qVJUmomLC5b5d3McBuGJiRmU7Q9E75LvVFB7x1HVurrcWdekQdwnOJ01IEbUh0r+ffEFfoKTGpPeHpA/HN8EMyFsUyf6hErr7Kaz9rRp7sItZJ3OMeSiNM6L8lPjwEGDZHsz14CjDX7mNKj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508770; c=relaxed/simple;
	bh=0i0lV4ypySeTd3b65DMKIMJT+UVy20kSiYvzkpEdsD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+SBT6yISTXIo3axnmxXsZ0UaxxFgXwspN6AkJw33+Ak0eR9ZvjCWn6tzhusvM+uLlBg0TMmcS8obD6mw77OJxsN75VVlEairFvTcaBSDtMYi1EK9steUcgahOMOv20rN4p3fyUt/6RZcxUL7WbXYVj7WBHBTebirDdMLu2KSp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCfXF3Ih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB742C433C7;
	Wed, 21 Feb 2024 09:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708508769;
	bh=0i0lV4ypySeTd3b65DMKIMJT+UVy20kSiYvzkpEdsD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OCfXF3Ih+r9+WsLEPwCubFA5jmfTZEjhY4NlJCf76LvW6bxhLu7a2GJRxGc5ym5A9
	 0UCXvzlqv/R+Fm/bjEKRNX3B/fWPO9lR/vGiYmEgvWF9Mf3miW5mxeefdm3tfSVnzZ
	 gMOQy5sps7LwdvRMlUnwkckNbks63cZqA5+D8mCCZhBLPHnnGYyNnucH0ynVzH1w+y
	 rl49SLWVmfNNv1klmr3XSNcSIWIrrEN3ea5/mmcP/RmemAQbeBimEm8xomK4Kjxej8
	 pSeHDfo0rFvhvEOtvkSFqpKeNQygp/QN+bNeHvCHIl4TvFdVJZDWh/QKvaDZ/sH7GR
	 Ovtg4ufRBz+2A==
From: Christian Brauner <brauner@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 0/2] Fix libaio cancellation support
Date: Wed, 21 Feb 2024 10:26:18 +0100
Message-ID: <20240221-hautnah-besonderen-e66d60bae4e6@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215204739.2677806-1-bvanassche@acm.org>
References: <20240215204739.2677806-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1374; i=brauner@kernel.org; h=from:subject:message-id; bh=0i0lV4ypySeTd3b65DMKIMJT+UVy20kSiYvzkpEdsD0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRePRZx4QjH29Dfu9Y5TDAKthRYMq17rc/fLZcuND/eZ PKjPc9GpaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAipTEMf+XeL95n9z3xRosB 06Tq2CninZYlren7Flpo6ldsvhLUwMfwk1HhzU7PpxIztR+yf9UJ3vDTbSmD3lffj0k3ni99/sk mjR8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 15 Feb 2024 12:47:37 -0800, Bart Van Assche wrote:
> This patch series fixes cancellation support in libaio as follows:
>  - Restore the code for completing cancelled I/O.
>  - Ignore requests to support cancellation for I/O not submitted by libaio.

And the libaio cancellation code itself is safe?

> 
> Please consider this patch series for the next merge window.
> 
> Thanks,
> 
> [...]

Cancellation function appropriately named ffs_aio_cancel(). ;/

--

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/2] fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio
      https://git.kernel.org/vfs/vfs/c/34c6ea2e3aea
[2/2] fs/aio: Make io_cancel() generate completions again
      https://git.kernel.org/vfs/vfs/c/ee347c5af5be

