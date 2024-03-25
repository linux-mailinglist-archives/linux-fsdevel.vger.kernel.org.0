Return-Path: <linux-fsdevel+bounces-15189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A57889848
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 10:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD7D1C31892
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 09:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3741C4B00;
	Mon, 25 Mar 2024 04:53:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE203066EA;
	Mon, 25 Mar 2024 01:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711328790; cv=none; b=dQILg0MPEQr1JPgY01CNmYtJu6r254alvsaGCCR5h3s+gD0rd0KxQkZdy1/7cuCWFfcuNgf9t4vgrI7Zi0IIhNecmDASXV2HY2cgZLamBqvLndmlcaLpMixO4nYxALrye4mbAs/LkOGG45WhoW1ThCepGob7Ki4yYAaSK3mXiXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711328790; c=relaxed/simple;
	bh=BiJJDs5W0rU7mZ1eNHboXjOIJ9iG9RU4/q2m13Ua76k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLl8OEmhHnQqk5+qUHim+POu3Ft6rwcGszCpANSotAhFBka4kRq/7N5dKC3KK3Bt0XFn3PiLX2YHLHYvztTFZWGLu79scDlFsqWgcvOCSQOlqrJL067ntgDR0I0Q3fxnoR+rEhISO9ohtATRKf+lEMOwfxN4xQ1q5tgZ6C18yaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4E61468B05; Mon, 25 Mar 2024 02:06:23 +0100 (CET)
Date: Mon, 25 Mar 2024 02:06:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>,
	Christoph Hellwig <hch@lst.de>, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
Message-ID: <20240325010622.GA23670@lst.de>
References: <20240317213847.GD10665@lst.de> <022204e6-c387-b4b2-5982-970fd1ed5b5b@huaweicloud.com> <20240318013208.GA23711@lst.de> <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com> <ea4774db-188e-6744-6a5b-0096f6206112@huaweicloud.com> <20240318232245.GA17831@lst.de> <c62dac0e-666f-9cc9-cffe-f3d985029d6a@huaweicloud.com> <20240322063346.GB3404528@ZenIV> <20240322131030.pxbvtubien2t27zw@quack3> <20240322145728.GN538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322145728.GN538574@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Mar 22, 2024 at 02:57:28PM +0000, Al Viro wrote:
> What WRITE_ONE()?  We really shouldn't modify it without ->open_mutex; do
> we ever do that?  In current mainline:

READ_ONCE must be paired with WRITE_ONCE.  All updates are under a lock,
and if you want some other scheme than the atomic_t go ahead.  I original
did READ_ONCE/WRITE_ONCE and this was changed based on review feedback.


