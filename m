Return-Path: <linux-fsdevel+bounces-62418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1473B92523
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 18:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DAFD7AFC0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 16:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F3A3101DF;
	Mon, 22 Sep 2025 16:56:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF3231195A;
	Mon, 22 Sep 2025 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560217; cv=none; b=KOQcIwx7FxJbkBU9W5PALhHPg0QCurURKud/C0hZyixlCfN8n/oG8gnaV2mKt9yn7mA1pHL4dvJhLzGmBgZzGfv9OJrZ3jzXCLp2X0QVma3myCTkshJ5jwxZn0gNQ1FiciSfKSlqXxqk4pxuulA0oO8EuictC6e52Mx0cqtCy5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560217; c=relaxed/simple;
	bh=fbsUy9vq6xHe3GDhL5H6lbbPocSgiT97owdRBERAMMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgFGp5yTiWxtqcWxuPJjxN7MwcwKspQmba/qhegxHBfz0lIh3yHmBy/ra7eqaxZKRCQ0Y/roAKbL/myzqtzpKV+JMfy1vHFd0sB6dM+FFRMsSh0y6zogbUPaGWPr/qbAVdqPaqiaBMJ6/ckuJc5VyNgI/EIBvha0dmUL5El6R1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BC47A67373; Mon, 22 Sep 2025 18:56:42 +0200 (CEST)
Date: Mon, 22 Sep 2025 18:56:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: wangyufei <wangyufei@vivo.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	cem@kernel.org, kundan.kumar@samsung.com, anuj20.g@samsung.com,
	hch@lst.de, bernd@bsbernd.com, djwong@kernel.org,
	david@fromorbit.com, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [RFC 2/2] xfs: implement get_inode_wb_ctx_idx() for per-AG
 parallel writeback
Message-ID: <20250922165642.GA11520@lst.de>
References: <20250914121109.36403-1-wangyufei@vivo.com> <20250914121109.36403-3-wangyufei@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914121109.36403-3-wangyufei@vivo.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Sep 14, 2025 at 08:11:09PM +0800, wangyufei wrote:
> The number of writeback contexts is set to the number of CPUs by
> default. This allows XFS to decide how to assign inodes to writeback
> contexts based on its allocation groups.
> 
> Implement get_inode_wb_ctx_idx() in xfs_super_operations as follows:
> - Limit the number of active writeback contexts to the number of AGs.
> - Assign inodes from the same AG to a unique writeback context.

I'm not sure this actually works.  Data is spread over AGs, just with
a default to the parent inode AG if there is space, and even that isn't
true for the inode32 option or when using the RT subvolume.

> +
> +	if (mp->m_sb.sb_agcount <= nr_wb_ctx)
> +		return XFS_INO_TO_AGNO(mp, xfs_inode->i_ino);
> +	return xfs_inode->i_ino % nr_wb_ctx;
> +}
> +
>  static const struct super_operations xfs_super_operations = {
>  	.alloc_inode		= xfs_fs_alloc_inode,
>  	.destroy_inode		= xfs_fs_destroy_inode,
> @@ -1295,6 +1308,7 @@ static const struct super_operations xfs_super_operations = {
>  	.free_cached_objects	= xfs_fs_free_cached_objects,
>  	.shutdown		= xfs_fs_shutdown,
>  	.show_stats		= xfs_fs_show_stats,
> +	.get_inode_wb_ctx_idx   = xfs_fs_get_inode_wb_ctx_idx,
>  };
>  
>  static int
> -- 
> 2.34.1
---end quoted text---

