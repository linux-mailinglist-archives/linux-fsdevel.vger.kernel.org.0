Return-Path: <linux-fsdevel+bounces-14660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC4C87E03E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 22:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BACCFB219C2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 21:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C6D20B20;
	Sun, 17 Mar 2024 21:23:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD3A208A7;
	Sun, 17 Mar 2024 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710710591; cv=none; b=Sju1mmtExVgy43EQJ7nPKgLSGgKD424FJetHBvarIS9XZlYWDLOGVqcyesPmgB7kifxGxZDnJqwDNrr+rFfq3RtMlfjgHkE3DXw1pC28jhMmIPT0YAoXx7zOMP394e9C9Sj4vyVslstE7xFWK2KDLD3zD7BlZ29erKisQauHixs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710710591; c=relaxed/simple;
	bh=Kn1xf3LglyRK81IqmgUuXq/Vvvos9KK1xx4iYxASE8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8XU4ScaN8V7oMrimj2EfmoqBRJCAktfUBkNLEVyGljcp4waJwnfF5As2lMJo7Gx+UBmTcsIDS77jFjNvT5WljtIPPoQ9fPveRIscpp8arz3TzgcKph1K9a/RqTs6K5TeK79EDEAbpZps72gQh5RRLX7YDa1cTVT7X8C/GIhp/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F182F68BEB; Sun, 17 Mar 2024 22:23:04 +0100 (CET)
Date: Sun, 17 Mar 2024 22:23:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 04/19] block: prevent direct access of
 bd_inode
Message-ID: <20240317212304.GD8963@lst.de>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com> <20240222124555.2049140-5-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-5-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 22, 2024 at 08:45:40PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Add helpers to access bd_inode, prepare to remove the field 'bd_inode'
> after removing all the access from filesystems and drivers.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

I suspect a few things like the partition parsing should pass down
the bdev file further, but no need to do that now.


