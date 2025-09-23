Return-Path: <linux-fsdevel+bounces-62520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E49B973BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 20:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 117DE7B643D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 18:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13DA2E03F3;
	Tue, 23 Sep 2025 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPah/j6e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3FFA48;
	Tue, 23 Sep 2025 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758653217; cv=none; b=GS1FTBC2fSmQmUTG1B+TousYlXBbP/VSxoUpuTd8/j8fIXhDeSM0djtlKI/GK+/dAlDqNWCat7Bi0SSJuWSfBlv/18L/jfCn+MNvM782D/vYrQ7HcD8U115K18VpZr6WaCgvI7A4tmXpEde/17VkMb8dCe4ykwZUfSJU60HpxrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758653217; c=relaxed/simple;
	bh=wdN3ztjj0RzlADMA5/cAzNLLiQSH2hkl2jvgBChB5ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QG4Qgb5jBjFW/MXZvp1Qd8o8/6uubSpwc6MdoEq1IbHPH/Y9b5tLQXJWM17UA9G9JwURyFLfLykdrIwE/AB9CZTKvmNjBMKWj0SW9t18hzYsfLHofrl6qiO9nU4/v7UFyXpi8bx3Smpho/hjlGl1kZFosX9l98vq+6kPVosIusI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPah/j6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891AFC4CEF5;
	Tue, 23 Sep 2025 18:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758653216;
	bh=wdN3ztjj0RzlADMA5/cAzNLLiQSH2hkl2jvgBChB5ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WPah/j6eCARV/bKKUgMMcditnRIhsNigxTcA7CSVM04zDS4XEqmQK+/kl440Wc+ff
	 VTuS5pcvew+ldusJyOHGoHVpBJlXkiIyvysHO4pAwEjyYKjyIooYMG4SqdNZPWlJJX
	 2CSkc5Rm8E+PUSfD7EVo6P2+8IgaQ/zOSOC3O/ZRn5em+MsJVdLsF8/5Z6ihkQjrvm
	 cKGdU1GJIKvOI28qFm/2SFporbrXOEWe/hqbBpS5I8P4/VocV2dS7IKMBXYcpoUBTR
	 YsAIjavfqeZQZLCjzLZDQOfiTXJqhJqZB9ufQ5iOmTwrJ9L2Otko8/Ecy6z2RSI42l
	 4vJcjznb7ROtA==
Date: Tue, 23 Sep 2025 11:46:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: wangyufei <wangyufei@vivo.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, cem@kernel.org,
	kundan.kumar@samsung.com, anuj20.g@samsung.com, bernd@bsbernd.com,
	david@fromorbit.com, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [RFC 2/2] xfs: implement get_inode_wb_ctx_idx() for per-AG
 parallel writeback
Message-ID: <20250923184655.GF1587915@frogsfrogsfrogs>
References: <20250914121109.36403-1-wangyufei@vivo.com>
 <20250914121109.36403-3-wangyufei@vivo.com>
 <20250922165642.GA11520@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922165642.GA11520@lst.de>

On Mon, Sep 22, 2025 at 06:56:42PM +0200, Christoph Hellwig wrote:
> On Sun, Sep 14, 2025 at 08:11:09PM +0800, wangyufei wrote:
> > The number of writeback contexts is set to the number of CPUs by
> > default. This allows XFS to decide how to assign inodes to writeback
> > contexts based on its allocation groups.
> > 
> > Implement get_inode_wb_ctx_idx() in xfs_super_operations as follows:
> > - Limit the number of active writeback contexts to the number of AGs.
> > - Assign inodes from the same AG to a unique writeback context.
> 
> I'm not sure this actually works.  Data is spread over AGs, just with
> a default to the parent inode AG if there is space, and even that isn't
> true for the inode32 option or when using the RT subvolume.

I don't know of a better way to shard cheaply -- if you could group
inodes dynamically by a rough estimate of the AGs that map to the dirty
data (especially delalloc/unwritten/cow mappings) then that would be an
improvement, but that's still far from what I would consider the ideal.

Ideally (maybe?) one could shard dirty ranges first by the amount of
effort (pure overwrite; secondly backed-by-unwritten; thirdly
delalloc/cow).  The first two groups could then be sharded by AG and
issued in parallel.  The third group involve so much metadata changes
that you could probably just shard evenly across CPUs.  Writebacks get
initiated in that order, and then we see where the bottlenecks lie in
ioend completion.

(But that's just my hazy untested brai^Widea :P)

--D

> > +
> > +	if (mp->m_sb.sb_agcount <= nr_wb_ctx)
> > +		return XFS_INO_TO_AGNO(mp, xfs_inode->i_ino);
> > +	return xfs_inode->i_ino % nr_wb_ctx;
> > +}
> > +
> >  static const struct super_operations xfs_super_operations = {
> >  	.alloc_inode		= xfs_fs_alloc_inode,
> >  	.destroy_inode		= xfs_fs_destroy_inode,
> > @@ -1295,6 +1308,7 @@ static const struct super_operations xfs_super_operations = {
> >  	.free_cached_objects	= xfs_fs_free_cached_objects,
> >  	.shutdown		= xfs_fs_shutdown,
> >  	.show_stats		= xfs_fs_show_stats,
> > +	.get_inode_wb_ctx_idx   = xfs_fs_get_inode_wb_ctx_idx,
> >  };
> >  
> >  static int
> > -- 
> > 2.34.1
> ---end quoted text---
> 

