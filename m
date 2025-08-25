Return-Path: <linux-fsdevel+bounces-59077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C79EB340FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F49E1890FA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207E3275AE6;
	Mon, 25 Aug 2025 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIkb2MUJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE042750FA
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129304; cv=none; b=gBnmtnF78c6kZ8FX5ckcZAdoIFQ6Qagz64UYsGoTzRkDIwiqIjUvSFBUTkBlzLTd++ltXzaA4MqQou715Udnxamo/P6EkVgRolpE8auZw52p0RrV9l47LTAYjgHe0AhbNI/RXMyCqzJVQ7czIyeW1a7C5EzMfoRPTPllKW+qoFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129304; c=relaxed/simple;
	bh=ZFzCcF63loXfzNV6vRxBH9SQyNz/SUjwJBjAyrRlTpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L41CghzNaHB/XIkTzej0NCXzFJdiXILmAobfo0nAxMq4OR6Pkn89CQ/gnxKTLw21hJt9L1E47jaC9irgAzfEGVbEa1SqrZfOLGaerVaMrgH1r5X55WlQBYL7W6BiMDdrNSUBYQfJfnntCl4HLvWJEHWjBoXa9zpDeLwCPzcfDRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIkb2MUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6351C4CEED;
	Mon, 25 Aug 2025 13:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756129304;
	bh=ZFzCcF63loXfzNV6vRxBH9SQyNz/SUjwJBjAyrRlTpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WIkb2MUJVapGN+07+wHr277QtXMs0N50iDLbMraF9tXdfmr2PVim0YNnpN7xc1jK9
	 2YbAT51fG2F1kpHcHfCJ5jxXh6HP6e+rFS5kPOGThB/Uzgxlk2q6VAoA3tfPgpLfIY
	 s22tA4sPHsdQFcRRvVSmzzbv48JbxffKXI9Nb2vZScLNCuq3Mb39Ma+0jdTq2aZ3vp
	 7YTn62syCJVDsRjrBxDVmIDmJuTW2Qvda05MIdR0x7jMANg/KDqz1YxN9adCoMSwK9
	 HGthPFa6OUwEe0tvunbJNYHvE7KeMG7ySWKRXU2f77uiGgbPt8vsiSjr8xBPxLLo8/
	 kTsuR7XGhfB9Q==
Date: Mon, 25 Aug 2025 15:41:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 51/52] ecryptfs: get rid of pointless mount references in
 ecryptfs dentries
Message-ID: <20250825-individual-gepaukt-396092eb04fc@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-51-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-51-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:54AM +0100, Al Viro wrote:
> ->lower_path.mnt has the same value for all dentries on given ecryptfs
> instance and if somebody goes for mountpoint-crossing variant where that
> would not be true, we can deal with that when it happens (and _not_
> with duplicating these reference into each dentry).
> 
> As it is, we are better off just sticking a reference into ecryptfs-private
> part of superblock and keeping it pinned until ->kill_sb().

The overlayfs model.

> 
> That way we can stick a reference to underlying dentry right into ->d_fsdata
> of ecryptfs one, getting rid of indirection through struct ecryptfs_dentry_info,
> along with the entire struct ecryptfs_dentry_info machinery.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

