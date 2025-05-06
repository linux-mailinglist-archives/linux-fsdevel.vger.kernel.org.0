Return-Path: <linux-fsdevel+bounces-48168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 262A0AABA70
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372E23AF41E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 07:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C1021FF27;
	Tue,  6 May 2025 04:41:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEE521FF25;
	Tue,  6 May 2025 04:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746506356; cv=none; b=kdOUlxJLiKfkbTbQJ1HKs5h/9yhXefeltj5r3nk7VZitoQYDOnMOJQvXzHmek3aLM1qW/XC/UXPAniqd2DE/LxFV696hliyfaa4W2Qa5a8syBC+KqKFLvz98osrXQxhTTkE5h8AnX9y9V+zHv92nv3ImtFGnh17Gs8FTubmDslI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746506356; c=relaxed/simple;
	bh=S2fduj5qv77iXlgOkNIVFju8b0oD/77jdBh6aDiLXyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1X+PI3USOKNmzwng7NLEA3kYvAqj6KyubqsHHEuaruaUsrdrH/JgDwCb1RsbQVEdwEXryyTlz4vOKNlPoa3ZGmircfjL5XMdBxLMJttuNaSk5pEiXS18kSfdQZ9ywfGMK0spju7SYB4wfsM5vH56y09+cfB2PRhaEhlfTrX6lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A9A3367373; Tue,  6 May 2025 06:39:07 +0200 (CEST)
Date: Tue, 6 May 2025 06:39:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, john.g.garry@oracle.com, bmarzins@redhat.com,
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
	brauner@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250506043907.GA27061@lst.de>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com> <20250421021509.2366003-8-yi.zhang@huaweicloud.com> <20250505132208.GA22182@lst.de> <20250505142945.GJ1035866@frogsfrogsfrogs> <c7d8d0c3-7efa-4ee6-b518-f8b09ec87b73@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7d8d0c3-7efa-4ee6-b518-f8b09ec87b73@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 06, 2025 at 12:28:54PM +0800, Zhang Yi wrote:
> OK, since this statx reporting flag is not strongly tied to
> FALLOC_FL_WRITE_ZEROES in vfs_fallocate(), I'll split this patch into
> three separate patches.

I don't think that is the right thing to do do.  Keep the flag addition
here, and then report it in the ext4 and bdev patches adding
FALLOC_FL_WRITE_ZEROES as the reporting should be consistent with
the added support.


