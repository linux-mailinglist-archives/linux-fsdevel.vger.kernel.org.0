Return-Path: <linux-fsdevel+bounces-13570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA11871221
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 01:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7D4285DBB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 00:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD97EADC;
	Tue,  5 Mar 2024 00:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFNuVzZa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8F58BF8;
	Tue,  5 Mar 2024 00:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599964; cv=none; b=T6cfVnvkN//zQpCfstoWR9GRh/7ElmZ1yneBljKx/ienapdjiCL398qYQjfjqirkORy8sgzUNk3fM21fHmLBgu0+tqH5h2MlUstGQhiskdnvsC/Ui80TyCs9SaCxoCQxqUqfnYTRUC4Nu8JA8ksqFq/j7yAArg3HiLPruHHP004=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599964; c=relaxed/simple;
	bh=mA6Lxv1vjVUzoD1GPmyxmgQ0pQX9T2VEFTolbOGgrE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnxwV1mQqCxM5NTVZm518PsUN4Pese3M4vchuO875WGHt3Zj9GoIXXQUvrOzVFFuOIxjZmII6qlQRZ8OE4urmtSQUb8eqw+jZvL5gN67utwbzgt0OCJuLOQg3+vPKxfiiBuUQ6V+gT05eWHb68aIAsz95+G1XdeD9CoPhgZyUA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFNuVzZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE746C433F1;
	Tue,  5 Mar 2024 00:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709599964;
	bh=mA6Lxv1vjVUzoD1GPmyxmgQ0pQX9T2VEFTolbOGgrE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tFNuVzZahNLD7u9pBz3IyDJmllQttzNoeCd7UPWZyfB4c4iphSfvXStZ5Rdr44KJ9
	 9ZYTtBp4gclml2Dz8CgkanilNrXhHP3Xb4Wmqh62OaPMfH/5sQjrvbDrUfwAhQk8go
	 dTNp+c8WRQzToHOWMmVTzsVplBYaIJ10aGbI4Tx8ZP6xaedFJTwIo5iMYh068Fz3T1
	 qpIqr/gWUjCLMkYFzRFRf9NrvFgmU/+CE+P5ALFOVnx9rBGv+xauVCGZkbopef0MQ/
	 icWNhg0xP74v8I3CTB3jqevLrJL/sJLoWwyAT+WG5o5aMPmbi2AoZThIk4SZ2VFopg
	 G1AqWdYurm6YQ==
Date: Mon, 4 Mar 2024 16:52:42 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	djwong@kernel.org
Subject: Re: [PATCH v5 06/24] fsverity: pass tree_blocksize to
 end_enable_verity()
Message-ID: <20240305005242.GE17145@sol.localdomain>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-8-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304191046.157464-8-aalbersh@redhat.com>

On Mon, Mar 04, 2024 at 08:10:29PM +0100, Andrey Albershteyn wrote:
> XFS will need to know tree_blocksize to remove the tree in case of an
> error. The size is needed to calculate offsets of particular Merkle
> tree blocks.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/btrfs/verity.c        | 4 +++-
>  fs/ext4/verity.c         | 3 ++-
>  fs/f2fs/verity.c         | 3 ++-
>  fs/verity/enable.c       | 6 ++++--
>  include/linux/fsverity.h | 4 +++-
>  5 files changed, 14 insertions(+), 6 deletions(-)

How will XFS handle dropping a file's incomplete tree if the system crashes
while it's being built?

I think this is why none of the other filesystems have needed the tree_blocksize
in ->end_enable_verity() yet.  They need to be able to drop the tree from just
the information the filesystem has on-disk anyway.  ext4 and f2fs just truncate
past EOF, while btrfs has some code that finds all the verity metadata items and
deletes them (see btrfs_drop_verity_items() in fs/btrfs/verity.c).

Technically you don't *have* to drop incomplete trees, since it shouldn't cause
a behavior difference.  But it seems like something that should be cleaned up.

- Eric

