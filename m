Return-Path: <linux-fsdevel+bounces-47693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D6BAA414D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 05:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8883B9073
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 03:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCD41C84A5;
	Wed, 30 Apr 2025 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tlACnRn/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF01B2DC77B;
	Wed, 30 Apr 2025 03:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745983207; cv=none; b=vF9Oxn/1mLpv9VVzSHbjzr4tfmY3/yzT3UDPkxzikBJmBFg5BJlwAW5/ksPz5842LujFcIWotqdEiX5LvoEqJW11pjZ7NZY9cYQeVFFxGu8qRGwQoCuZ36jToB8AJxq9j5AdQh+KsKWB4mVC23peAd92oPFIxtRFlVU7UZJOoWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745983207; c=relaxed/simple;
	bh=zW/xqRBt1sphDb5KG3p7zM2W7dG4twLwPPJaTJ5yAus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOgoE8nIK3rMwUcNCcV0FH4egRfc76PB1lAZ7EQTDX/vKY7iPzh7dzYgha9MQDWlY3Za4JiYGLS4U2jDABy4EYcQM8Z1w5aKVcDU3HWBmAAXHSeNYm8N7GEYv9KWpEKj1Q1I4c6kezFvKPA7Grw6E90zjrVYC/tqiuopAF8G0FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tlACnRn/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dTu0gBWGway8wTXN5Rf61wdFSCADtBR5CZO0pXYvIUc=; b=tlACnRn/yybqure6VbWO9QVeuI
	dnnWcNpqrfk9q2t+04wuqWuMJutDSY2L0AYLZauLwsT5YHc4ciNzzX2ZHiItilKCT3g5IMNpf5prZ
	9kaSSmacAbkA6CiYqXXB/vXsesgXPsLjiF/GJ36DIUq+5BvBxPx7Db9xFEbJSMb82GLJaUIaITa7J
	8ZOsD5foY9sQuDB9Coa1Mg4SxfOsDCDuD7TUYePe4h1nL1Tt4K0I4PrIGCJW8pLgWMp9RUjhM/qRs
	Qli161Aw7DC15AMhUZurKbJhkoWv+5PU2WmAwCXLvVJMUCgrHpd5nXbxjZTcwd3z955CuBB6wYYVe
	2HIu/gPg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9xzN-00000009ATw-28rz;
	Wed, 30 Apr 2025 03:20:01 +0000
Date: Wed, 30 Apr 2025 04:20:01 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, wanghaichi0403@gmail.com,
	yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH 4/4] ext4: ensure i_size is smaller than maxbytes
Message-ID: <aBGW4TsUM5yOCf_8@casper.infradead.org>
References: <20250430011301.1106457-1-yi.zhang@huaweicloud.com>
 <20250430011301.1106457-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430011301.1106457-4-yi.zhang@huaweicloud.com>

On Wed, Apr 30, 2025 at 09:13:01AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The inode i_size cannot be larger than maxbytes, check it while loading
> inode from the disk.

With this patch, why do we need patch 1?

