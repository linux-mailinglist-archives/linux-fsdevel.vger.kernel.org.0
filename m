Return-Path: <linux-fsdevel+bounces-55959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D27B10FA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 18:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1F11CC4DED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 16:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28251F151C;
	Thu, 24 Jul 2025 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akxe8H/c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1326D8F7D;
	Thu, 24 Jul 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374727; cv=none; b=ng+d29K5KUXKGQvxO2oJmrMpu/GmJFZXBoqKg/SemXOSKJIaZq/OhbP2tCfohiJZFPUMF+IKwyFWqPhrGREiRS7mJFdEOawpDqjSd8EuG7Q+NpYZ+jkyUpXgsqTa5FnE3oF0KGpRk/TVPIUElIhvU2NLfMVDggSuRqKOkhBw2Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374727; c=relaxed/simple;
	bh=LhuhjAjmd1hufnv97WR89cPyw5PBvrFjoK0j4KlZ13M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KL5/O08Z388derp4m5NaJtvKo46zf6DszIv1iNZ+jvL9EjdEBe1h5NAhYIGyrnI1aAX15gNPngsdqjg65vm5EFKNSXXe6+3I1JZKJlQLGW8PUGBNG/fhLwaP+ONMJGC0lgyh0FiaLOCOIk8GFDsWUeB1BUvm1oFtBqlVUa/jXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akxe8H/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A72C4CEED;
	Thu, 24 Jul 2025 16:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753374726;
	bh=LhuhjAjmd1hufnv97WR89cPyw5PBvrFjoK0j4KlZ13M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=akxe8H/cb9Ldvqi7eOPFHuxO5Qc0RqwNhdhjC5G1ECK+LwFYHQJi0eYyWMC8HODaw
	 miptezOwRUknq6dNH+b7S+fTvBfI4dSfVmHCqi6hJSiLEKKym75/cxwKmhl4Q92+cL
	 hzZpH+sI2DjkbnI2IrMkQH5wvFUWMAIXr0KkzBMfTK6GuHFaFGNTPbfdTrkvsKtdPp
	 06y/5BNam++9xdSTEt/CHvPUQMWtADL8ifJm0dDoA7aY2rYUGPkbxfzOadeb6YHvNE
	 dVG4mgR7cTr9wCjSycq1Edxdye+WfZP4/RooLE47+VS3mh7WbsWJ6/9NIq0dVfb3zr
	 VX2JE8t2Kh7RA==
Date: Thu, 24 Jul 2025 09:32:06 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, cem@kernel.org, dan.j.williams@intel.com,
	willy@infradead.org, jack@suse.cz, brauner@kernel.org,
	viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] xfs: reject max_atomic_write mount option for no
 reflink
Message-ID: <20250724163206.GN2672029@frogsfrogsfrogs>
References: <20250724081215.3943871-1-john.g.garry@oracle.com>
 <20250724081215.3943871-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724081215.3943871-4-john.g.garry@oracle.com>

On Thu, Jul 24, 2025 at 08:12:15AM +0000, John Garry wrote:
> If the FS has no reflink, then atomic writes greater than 1x block are not
> supported. As such, for no reflink it is pointless to accept setting
> max_atomic_write when it cannot be supported, so reject max_atomic_write
> mount option in this case.
> 
> It could be still possible to accept max_atomic_write option of size 1x
> block if HW atomics are supported, so check for this specifically.
> 
> Fixes: 4528b9052731 ("xfs: allow sysadmins to specify a maximum atomic write limit at mount time")
> Signed-off-by: John Garry <john.g.garry@oracle.com>

/me wonders if "mkfs: allow users to configure the desired maximum
atomic write size" needs a similar filter?

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_mount.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index 0b690bc119d7..1ec70f4e57b4 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -784,6 +784,25 @@ xfs_set_max_atomic_write_opt(
>  		return -EINVAL;
>  	}
>  
> +	if (xfs_has_reflink(mp))
> +		goto set_limit;
> +
> +	if (new_max_fsbs == 1) {
> +		if (mp->m_ddev_targp->bt_awu_max ||
> +		    (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_awu_max)) {
> +		} else {
> +			xfs_warn(mp,
> + "cannot support atomic writes of size %lluk with no reflink or HW support",
> +				new_max_bytes >> 10);
> +			return -EINVAL;
> +		}
> +	} else {
> +		xfs_warn(mp,
> + "cannot support atomic writes of size %lluk with no reflink support",
> +				new_max_bytes >> 10);
> +		return -EINVAL;
> +	}
> +
>  set_limit:
>  	error = xfs_calc_atomic_write_reservation(mp, new_max_fsbs);
>  	if (error) {
> -- 
> 2.43.5
> 
> 

