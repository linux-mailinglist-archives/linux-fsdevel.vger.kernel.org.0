Return-Path: <linux-fsdevel+bounces-36049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156FB9DB2D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 07:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDC42813CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 06:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A22E145B0F;
	Thu, 28 Nov 2024 06:41:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A08041C94;
	Thu, 28 Nov 2024 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732776066; cv=none; b=ot0giO4x1AjFAANlTyZ770sYhm/yVUmJ6JHkpYmHCPoz89uo7wcyQU+UZYqkT5vd0cH1AxmCkp+qN83D/1Uf+fSvVAKBjmfY/UodGE9O7MgyidTWkEgb63WHj0VDeDktvzFztsZdgVJznRkXhvrGSY+3T2NVMMJq6rJcO1rFJ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732776066; c=relaxed/simple;
	bh=yjLyfcn2g5HdR7a1Axwb8+PqkeslJtyagwiXrAJwYFU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uc9UDoYw32jrep3bKMjxJag5wbrOB1fslxvk66u+k1a87B2eNYrtEVue4uWqbwJaYlo7WDUTDZyAzxmYxz+waTncAIHmIb6GBck6qM8ZlBNwO+eg4mP4cmXWmv7C3sLZUnsAGoPnKbIraUdL2SpNsDDpFK0e0mEi+tIT2VRkaYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XzRTw20zYz1T5yZ;
	Thu, 28 Nov 2024 14:38:44 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id D5D7D1400CB;
	Thu, 28 Nov 2024 14:40:53 +0800 (CST)
Received: from localhost (10.175.112.188) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 28 Nov
 2024 14:40:53 +0800
Date: Thu, 28 Nov 2024 14:38:50 +0800
From: Long Li <leo.lilong@huawei.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <brauner@kernel.org>, <cem@kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <yi.zhang@huawei.com>, <houtao1@huawei.com>,
	<yangerkun@huawei.com>
Subject: Re: [PATCH v5 1/2] iomap: fix zero padding data issue in concurrent
 append writes
Message-ID: <Z0gP-peky2Se-YIy@localhost.localdomain>
References: <20241127063503.2200005-1-leo.lilong@huawei.com>
 <20241127162829.GY1926309@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20241127162829.GY1926309@frogsfrogsfrogs>
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500017.china.huawei.com (7.185.36.126)

On Wed, Nov 27, 2024 at 08:28:29AM -0800, Darrick J. Wong wrote:
> > @@ -1789,7 +1790,16 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
> >  
> >  	if (ifs)
> >  		atomic_add(len, &ifs->write_bytes_pending);
> > +
> > +	/*
> > +	 * If the ioend spans i_size, trim io_size to the former to provide
> > +	 * the fs with more accurate size information. This is useful for
> > +	 * completion time on-disk size updates.
> 
> I think it's useful to preserve the diagram showing exactly what problem
> you're solving:
> 
> 	/*
> 	 * Clamp io_offset and io_size to the incore EOF so that ondisk
> 	 * file size updates in the ioend completion are byte-accurate.
> 	 * This avoids recovering files with zeroed tail regions when
> 	 * writeback races with appending writes:
> 	 *
> 	 *    Thread 1:                  Thread 2:
> 	 *    ------------               -----------
> 	 *    write [A, A+B]
> 	 *    update inode size to A+B
> 	 *    submit I/O [A, A+BS]
> 	 *                               write [A+B, A+B+C]
> 	 *                               update inode size to A+B+C
> 	 *    <I/O completes, updates disk size to min(A+B+C, A+BS)>
> 	 *    <power failure>
> 	 *
> 	 *  After reboot:
> 	 *    1) with A+B+C < A+BS, the file has zero padding in range
> 	 *       [A+B, A+B+C]
> 	 *
> 	 *    |<     Block Size (BS)    >|
> 	 *    |DDDDDDDDDDDD00000000000000|
> 	 *    ^           ^        ^
> 	 *    A          A+B     A+B+C
> 	 *                       (EOF)
> 	 *
> 	 *    2) with A+B+C > A+BS, the file has zero padding in range
> 	 *       [A+B, A+BS]
> 	 *
> 	 *    |<     Block Size (BS)    >|<      Block Size (BS)    >|
> 	 *    |DDDDDDDDDDDD00000000000000|000000000000000000000000000|
> 	 *    ^           ^              ^           ^
> 	 *    A          A+B            A+BS       A+B+C
> 	 *                              (EOF)
> 	 *
> 	 *    D = Valid Data
> 	 *    0 = Zero Padding
> 	 *
> 	 * Note that this defeats the ability to chain the ioends of
> 	 * appending writes.
> 	 */
> 
> (I reduced the blocksize a bit for wrapping purposes)

Ok, I will update it.

> 
> The logic looks ok, but I'm curious about how you landed at 2.6.12-rc
> for the fixes tag.
> 
> --D

I see that io_size was introduced in version 2.6. It's quite difficult
to determine the exact version where the issue was introduced, but I can
confirm it was before version 4.19, as I can reproduce the issue in 4.19.
It should before introduce iomap infrastructure, how about using the
following fix tag?

Fixes: ae259a9c8593 ("fs: introduce iomap infrastructure") # goes further back than this

Thanks, 
Long Li

