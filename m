Return-Path: <linux-fsdevel+bounces-57925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D441BB26D29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 18:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3049AA1529
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 16:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CAA2FCC14;
	Thu, 14 Aug 2025 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAijTxAu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935A3166F1A;
	Thu, 14 Aug 2025 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190471; cv=none; b=Mng35y6LGam56qCAyXJJKDA/RiZjJFYarUHdAejIFJYP/JlpF5lwRgRMoBfHcok9TZ1huOeCPk3hjvTuMIR6im5lMCeI8jyoGwvnmM7vKSb40QxdIr+zF+O+OzeMSFZ4YxmRNer+mr8gj90dXq0HF11pzMAKxuJhaTWKsE5OfNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190471; c=relaxed/simple;
	bh=l+BdPGU5s1lSz+Wn4Skj6yNZHRqBxCYdP1QbhjGj46w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dc07DHx9nFSHmzBYwR7BbcJmg7lOKpRasaYF+uZqdyptW55paegCO4RlJvEhoYTQudzshijREYsIjGbp1LXX8zMgPOB/oXPKu1+7mlVg5wLwDPGuSSj9OF7TGl2lmefY/Nxq+ZJeUybdkPscwKYRXU6alJZsBvdkUxT1Glh2pw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAijTxAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2593AC4CEED;
	Thu, 14 Aug 2025 16:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755190471;
	bh=l+BdPGU5s1lSz+Wn4Skj6yNZHRqBxCYdP1QbhjGj46w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uAijTxAuY3vGwM78+PrRc/fCQLGARlU2IACUe8szD/QvaX7trsuwHqBZM0fU/BkJ0
	 PrKRsyPReVqn1jx+XoArIoQSdVBZ6pgLV5XJ3gwVZsxMoPqw64Rd5/ba5m5Giswfef
	 +pWR5d1bRDswR628xphF8ZJg5OzExBiI+bx4OjoJXq70IScPa3+UDFRffBnH7BGs6t
	 Z0b1epTyG+7p8SS4oKLtdLRaB4oVYY2J/7eVwEiWHaGt2ultzwauOolHjFJbFepz6P
	 8AtC40MBVot4IzdXlUjfNKsre/FmlM+TNETCjpS5bIV9PHVY5//XDsMmFYJmeboDSM
	 trEYUGuKC9C6A==
Date: Thu, 14 Aug 2025 09:54:30 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, hch@lst.de,
	tytso@mit.edu, bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, brauner@kernel.org,
	martin.petersen@oracle.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH xfsprogs v2] xfs_io: add FALLOC_FL_WRITE_ZEROES support
Message-ID: <20250814165430.GR7942@frogsfrogsfrogs>
References: <20250813024250.2504126-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813024250.2504126-1-yi.zhang@huaweicloud.com>

On Wed, Aug 13, 2025 at 10:42:50AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The Linux kernel (since version 6.17) supports FALLOC_FL_WRITE_ZEROES in
> fallocate(2). Add support for FALLOC_FL_WRITE_ZEROES support to the
> fallocate utility by introducing a new 'fwzero' command in the xfs_io
> tool.
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=278c7d9b5e0c
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
> v1->v2:
>  - Minor description modification to align with the kernel.
> 
>  io/prealloc.c     | 36 ++++++++++++++++++++++++++++++++++++
>  man/man8/xfs_io.8 |  6 ++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/io/prealloc.c b/io/prealloc.c
> index 8e968c9f..9a64bf53 100644
> --- a/io/prealloc.c
> +++ b/io/prealloc.c
> @@ -30,6 +30,10 @@
>  #define FALLOC_FL_UNSHARE_RANGE 0x40
>  #endif
>  
> +#ifndef FALLOC_FL_WRITE_ZEROES
> +#define FALLOC_FL_WRITE_ZEROES 0x80
> +#endif
> +
>  static cmdinfo_t allocsp_cmd;
>  static cmdinfo_t freesp_cmd;
>  static cmdinfo_t resvsp_cmd;
> @@ -41,6 +45,7 @@ static cmdinfo_t fcollapse_cmd;
>  static cmdinfo_t finsert_cmd;
>  static cmdinfo_t fzero_cmd;
>  static cmdinfo_t funshare_cmd;
> +static cmdinfo_t fwzero_cmd;
>  
>  static int
>  offset_length(
> @@ -377,6 +382,27 @@ funshare_f(
>  	return 0;
>  }
>  
> +static int
> +fwzero_f(
> +	int		argc,
> +	char		**argv)
> +{
> +	xfs_flock64_t	segment;
> +	int		mode = FALLOC_FL_WRITE_ZEROES;

Shouldn't this take a -k to add FALLOC_FL_KEEP_SIZE like fzero?

(The code otherwise looks fine to me)

--D

> +
> +	if (!offset_length(argv[1], argv[2], &segment)) {
> +		exitcode = 1;
> +		return 0;
> +	}
> +
> +	if (fallocate(file->fd, mode, segment.l_start, segment.l_len)) {
> +		perror("fallocate");
> +		exitcode = 1;
> +		return 0;
> +	}
> +	return 0;
> +}
> +
>  void
>  prealloc_init(void)
>  {
> @@ -489,4 +515,14 @@ prealloc_init(void)
>  	funshare_cmd.oneline =
>  	_("unshares shared blocks within the range");
>  	add_command(&funshare_cmd);
> +
> +	fwzero_cmd.name = "fwzero";
> +	fwzero_cmd.cfunc = fwzero_f;
> +	fwzero_cmd.argmin = 2;
> +	fwzero_cmd.argmax = 2;
> +	fwzero_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
> +	fwzero_cmd.args = _("off len");
> +	fwzero_cmd.oneline =
> +	_("zeroes space and eliminates holes by allocating and submitting write zeroes");
> +	add_command(&fwzero_cmd);
>  }
> diff --git a/man/man8/xfs_io.8 b/man/man8/xfs_io.8
> index b0dcfdb7..0a673322 100644
> --- a/man/man8/xfs_io.8
> +++ b/man/man8/xfs_io.8
> @@ -550,6 +550,12 @@ With the
>  .B -k
>  option, use the FALLOC_FL_KEEP_SIZE flag as well.
>  .TP
> +.BI fwzero " offset length"
> +Call fallocate with FALLOC_FL_WRITE_ZEROES flag as described in the
> +.BR fallocate (2)
> +manual page to allocate and zero blocks within the range by submitting write
> +zeroes.
> +.TP
>  .BI zero " offset length"
>  Call xfsctl with
>  .B XFS_IOC_ZERO_RANGE
> -- 
> 2.39.2
> 
> 

