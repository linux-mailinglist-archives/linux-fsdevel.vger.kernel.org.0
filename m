Return-Path: <linux-fsdevel+bounces-58033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80587B28242
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 16:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24CB85E36C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 14:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE07724C076;
	Fri, 15 Aug 2025 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozEwDeal"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8552367CD;
	Fri, 15 Aug 2025 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268965; cv=none; b=ID/Xgn3sqz/h0UomyDUnDruF9iTxN5vodOyauyQuGdbM1wf+8PLD7L3zxcouLXfh3PsTuqbnctm8nJ3WL7uJXdql+qovffwrzt2UZGvvqgG5oE96q/lvpbF2ie2M881urin8N5K7rdU+HfNGfrI+Jw5C+9z4MZxeVNi0d0MYUO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268965; c=relaxed/simple;
	bh=DmOtZ+shegw3Xq2qbIvm9MhD1J8beNXNffYo5DT55zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkVcYTI5UBJENyWb45g4brJG3FXzeH/9lm5njo6Y6hyUAqLpPXCcRQMFLsSRPwPnNX59Ko6dcAfrBcYHeagi8PNrehu4h1UqjSFfkjKOlA73eGr3b76WTkDOiaH5QZv6geAbWlcab9COeRvveRUGym1Z1snOOleZPuUE875+nUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozEwDeal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4B5C4CEEB;
	Fri, 15 Aug 2025 14:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755268964;
	bh=DmOtZ+shegw3Xq2qbIvm9MhD1J8beNXNffYo5DT55zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozEwDealkGjrGu3EotSAhGBDHyTGe4g5x5IxOg3UEZ8mb0DQqoaqSO0Ki/NfMsbUJ
	 bc15UYRtOJd1XvEdMxz2z5bPx0u7YKl/LupzoCtJGWsG0ZfJimJRMQu/7YmE7P7atv
	 4P6DzOPMydN16VsrJLYZRRh22gsjTDrrPlhrEMALPezXRmTzibl1cRW9EMwOOGw7Pl
	 JJI0p5mepNTHPaq+Hu6ThslkuJBckHvlWIndnLddlc9zRfj0vGHHeIcIzOasceWL8i
	 oKl8FrSmHPqTq8yBCT1dYiqC47ScOv7F3eiq1LFCN43P8XXcbLtjrZMl4s13uBjyv0
	 cqUAIaoZ2taog==
Date: Fri, 15 Aug 2025 07:42:43 -0700
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
Message-ID: <20250815144243.GU7965@frogsfrogsfrogs>
References: <20250813024250.2504126-1-yi.zhang@huaweicloud.com>
 <20250814165430.GR7942@frogsfrogsfrogs>
 <1428e3fe-ae7a-410d-97b5-7dd0249c41c0@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1428e3fe-ae7a-410d-97b5-7dd0249c41c0@huaweicloud.com>

On Fri, Aug 15, 2025 at 05:59:01PM +0800, Zhang Yi wrote:
> On 2025/8/15 0:54, Darrick J. Wong wrote:
> > On Wed, Aug 13, 2025 at 10:42:50AM +0800, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> The Linux kernel (since version 6.17) supports FALLOC_FL_WRITE_ZEROES in
> >> fallocate(2). Add support for FALLOC_FL_WRITE_ZEROES support to the
> >> fallocate utility by introducing a new 'fwzero' command in the xfs_io
> >> tool.
> >>
> >> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=278c7d9b5e0c
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >> ---
> >> v1->v2:
> >>  - Minor description modification to align with the kernel.
> >>
> >>  io/prealloc.c     | 36 ++++++++++++++++++++++++++++++++++++
> >>  man/man8/xfs_io.8 |  6 ++++++
> >>  2 files changed, 42 insertions(+)
> >>
> >> diff --git a/io/prealloc.c b/io/prealloc.c
> >> index 8e968c9f..9a64bf53 100644
> >> --- a/io/prealloc.c
> >> +++ b/io/prealloc.c
> >> @@ -30,6 +30,10 @@
> >>  #define FALLOC_FL_UNSHARE_RANGE 0x40
> >>  #endif
> >>  
> >> +#ifndef FALLOC_FL_WRITE_ZEROES
> >> +#define FALLOC_FL_WRITE_ZEROES 0x80
> >> +#endif
> >> +
> >>  static cmdinfo_t allocsp_cmd;
> >>  static cmdinfo_t freesp_cmd;
> >>  static cmdinfo_t resvsp_cmd;
> >> @@ -41,6 +45,7 @@ static cmdinfo_t fcollapse_cmd;
> >>  static cmdinfo_t finsert_cmd;
> >>  static cmdinfo_t fzero_cmd;
> >>  static cmdinfo_t funshare_cmd;
> >> +static cmdinfo_t fwzero_cmd;
> >>  
> >>  static int
> >>  offset_length(
> >> @@ -377,6 +382,27 @@ funshare_f(
> >>  	return 0;
> >>  }
> >>  
> >> +static int
> >> +fwzero_f(
> >> +	int		argc,
> >> +	char		**argv)
> >> +{
> >> +	xfs_flock64_t	segment;
> >> +	int		mode = FALLOC_FL_WRITE_ZEROES;
> > 
> > Shouldn't this take a -k to add FALLOC_FL_KEEP_SIZE like fzero?
> > 
> 
> Since allocating blocks with written extents beyond the inode size
> is not permitted, the FALLOC_FL_WRITE_ZEROES flag cannot be used
> together with the FALLOC_FL_KEEP_SIZE.

Heh, apparently I didn't read the manpage well enough.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


> Thanks,
> Yi.
> 
> > (The code otherwise looks fine to me)
> > 
> > --D
> > 
> >> +
> >> +	if (!offset_length(argv[1], argv[2], &segment)) {
> >> +		exitcode = 1;
> >> +		return 0;
> >> +	}
> >> +
> >> +	if (fallocate(file->fd, mode, segment.l_start, segment.l_len)) {
> >> +		perror("fallocate");
> >> +		exitcode = 1;
> >> +		return 0;
> >> +	}
> >> +	return 0;
> >> +}
> >> +
> >>  void
> >>  prealloc_init(void)
> >>  {
> >> @@ -489,4 +515,14 @@ prealloc_init(void)
> >>  	funshare_cmd.oneline =
> >>  	_("unshares shared blocks within the range");
> >>  	add_command(&funshare_cmd);
> >> +
> >> +	fwzero_cmd.name = "fwzero";
> >> +	fwzero_cmd.cfunc = fwzero_f;
> >> +	fwzero_cmd.argmin = 2;
> >> +	fwzero_cmd.argmax = 2;
> >> +	fwzero_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
> >> +	fwzero_cmd.args = _("off len");
> >> +	fwzero_cmd.oneline =
> >> +	_("zeroes space and eliminates holes by allocating and submitting write zeroes");
> >> +	add_command(&fwzero_cmd);
> >>  }
> >> diff --git a/man/man8/xfs_io.8 b/man/man8/xfs_io.8
> >> index b0dcfdb7..0a673322 100644
> >> --- a/man/man8/xfs_io.8
> >> +++ b/man/man8/xfs_io.8
> >> @@ -550,6 +550,12 @@ With the
> >>  .B -k
> >>  option, use the FALLOC_FL_KEEP_SIZE flag as well.
> >>  .TP
> >> +.BI fwzero " offset length"
> >> +Call fallocate with FALLOC_FL_WRITE_ZEROES flag as described in the
> >> +.BR fallocate (2)
> >> +manual page to allocate and zero blocks within the range by submitting write
> >> +zeroes.
> >> +.TP
> >>  .BI zero " offset length"
> >>  Call xfsctl with
> >>  .B XFS_IOC_ZERO_RANGE
> >> -- 
> >> 2.39.2
> >>
> >>
> 
> 

