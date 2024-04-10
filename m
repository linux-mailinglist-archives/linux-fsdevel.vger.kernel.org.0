Return-Path: <linux-fsdevel+bounces-16520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C752E89E8A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 06:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2431C21323
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 04:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDDEC13C;
	Wed, 10 Apr 2024 04:01:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D2C129;
	Wed, 10 Apr 2024 04:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712721667; cv=none; b=nohzfOOxRvbbuTfFc1dsfQuRCxz0qEeQ5MQbQR9jwlojoAD92hX5xoZndjEogNnfGR/g4GDi2Injulala2E/wXfkDzteOw0bflaH7BtzW6lz1kkmESFL/xQiEJ/He07DisJcRnHIOyqVcCN9VW4B0ePXgV64K6xKRG8xdfB03b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712721667; c=relaxed/simple;
	bh=z9S602DxMZn4oXUQBg3hReabFanxHpZnF1qc7HBKj4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKfynSvyELHh7bISjz2/g3D3GarVwOydy51fel8Ob2arPrFkxPG4ZnFuCECosBJdhOBstwByKeEE7GKMGKJ+d33c3LMq0e7Zjw9O1A4/daTyhxwOkUtDJiJU0sworn11xk/YIP584ZkP1UH2MG9CLNbLBCdUb0qUNiYRUBH10tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6753D68BEB; Wed, 10 Apr 2024 06:00:59 +0200 (CEST)
Date: Wed, 10 Apr 2024 06:00:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 15/14] xfs: capture inode generation numbers in the
 ondisk exchmaps log item
Message-ID: <20240410040058.GA1883@lst.de>
References: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs> <20240410000528.GR6390@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410000528.GR6390@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 09, 2024 at 05:05:28PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Per some very late review comments, capture the generation numbers of
> both inodes involved in a file content exchange operation so that we
> don't accidentally target files with have been reallocated.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
> I'm throwing this one on the pile since I guess it's not so hard to add
> the generation number to a brand new log item.

It does looks fine to me, but it leaves the question open:  why here
and not elsewhere.  And the answer based on the previous discussions
is that this is the first new log item after the problem was known
and we'll need to eventually rev the other ino based items as well.
Maybe capture this in a comment?


