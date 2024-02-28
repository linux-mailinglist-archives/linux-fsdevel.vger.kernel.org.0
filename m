Return-Path: <linux-fsdevel+bounces-13081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCB386B0A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 14:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D20AB28A5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 13:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B8F15697B;
	Wed, 28 Feb 2024 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XMyodxNZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2A414F98B;
	Wed, 28 Feb 2024 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127719; cv=none; b=TD+awYPm0OLaTGw3U1rkpX5NHaBm1L41sI6zXU0qfZ0cJgfT0GhrveFNOfdOm6u5KLftKYuMZSRKsoOgS1/DqaW8Nn/KKshSj/Fni5JIqKb1Eagp7sqoyzWLDKPTCu8QZzxkRL2+CM1JaSS4ESVZAcxhTqa1NpDOqbSLNCygOoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127719; c=relaxed/simple;
	bh=7OSCgle4oTVta2mmyBgw11MCfhratg/MFfXgPG9wRLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiZRU/oIuPoXsLiVdvP9xWVgawupRyQKwIJWS9/dIMrm5oH5YNNDdFfaUkTiZ4KQrWQ8vwCFJphcx0E8z2E0jAXg7qoDWpIafOo5vkcJdEK4EutPClzBHhD7ddTj+FATKqJmtoKoSkKJZJ5zEguXSEacyAbCG/XnIsTp3680w7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XMyodxNZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2K3Le2TO+LTRd7C82GIMe7rGY4dRpMh0mcw2QBrEo0s=; b=XMyodxNZ3GbXUO/dvlcwHAE7JQ
	6iIY6GTGSOa+injzT9VwyQAXsb+TaFSSPZzu4jlne1jHUTVrvqkleQOBFqvlker5yANxTdfI8x2MX
	9f5auAGZMUJfEZJnblSGNXoZsTIXdQbmVBwmL/19IVohfLIJn034SDktBSQ+1sKQbg2dc9pa5sSDT
	ofodJcdYXbManhvGiuCnUvAHZ1Ti5VnXGjDmp3wbWckUO6bFr75VtGfo7tI+dTvb42n3wv4IoM4iP
	00XiC66/Jo1PNGs/aB3U0a7KwVRmyKTDW9pdfQfou02yabgfn9E2XRZ0fJFiBaCUk+EQ+x5CaYny3
	SyrcjAxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfKC2-00000009WNU-3cFb;
	Wed, 28 Feb 2024 13:41:54 +0000
Date: Wed, 28 Feb 2024 05:41:54 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 17/19] dm-vdo: prevent direct access of
 bd_inode
Message-ID: <Zd84IulYNpcKuxC-@infradead.org>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-18-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-18-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Feb 22, 2024 at 08:45:53PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that dm upper layer already statsh the file of opened device in
> 'dm_dev->bdev_file', it's ok to get inode from the file.

Where did this code get in?


