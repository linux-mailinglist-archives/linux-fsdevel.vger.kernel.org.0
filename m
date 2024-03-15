Return-Path: <linux-fsdevel+bounces-14458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3312787CE65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD051F21212
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 13:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F56236AED;
	Fri, 15 Mar 2024 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kreJIIP8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA402E62F;
	Fri, 15 Mar 2024 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510872; cv=none; b=gZURBcACcmcXzxx0Vm3ibSLdXJ5y4+4Om3duo5d11s3U9EOtkxkb9f8GHZaaWE46htZWivSvz2qHUT9FsEbuP1WdqUmptLWZg/e5pxLVcti/5A432xpgNij1K8gZ63FORrDbeTP0/mtqBk3mTUiU1wEaaP4qeOOnvA1j/uppxak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510872; c=relaxed/simple;
	bh=s5tlyQ3TQ92cp3zmv6WhJU0WhcyMs03/Vt56LrZyZP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTQQDInt/S2R74fCGjShPmowqrzPopQVwQHhUllJZ8dMKuz6CCBqekVhoQBhENSKcTlqPvx6jkk7K5Qeo9MuSS1aX/XVuozuuUytZdEo3KBPSBjcB++Q03tKERNl4ngezCofZCwFHvOZMmcGJ1WevTzUebBv5e2A6G6P8BC0CXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kreJIIP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5130C433C7;
	Fri, 15 Mar 2024 13:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710510872;
	bh=s5tlyQ3TQ92cp3zmv6WhJU0WhcyMs03/Vt56LrZyZP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kreJIIP8JrjAHNDdkuowy06oj0Iwlu4NtzzGXp7ds7sLDxdg7VzHgI6Zycgasxnnc
	 mMbA1s695y3UMU45bEpqxwvcFqyT4NdCFt+oxNt0Jd21duw0H8jIyPuW6O7jMOADZJ
	 Z46JW1piH1hiNaDqU3n8QMuK1r1QwMQow+M7dZBYFpjKVrnZNAmS4sBi4lGOZZ06F9
	 kJAHcdIPuzD6ZmSZGJ+V1om6fwCm34RZ16gR7A3QIQNYAAKPL2JKXkw6wAkBd8xFA7
	 LCiUrYqU/Bcd3LJ3HcDoIN4JRkxCxh9SAy845bUZeXOBRB/rLCzeUu2VLptzAG0To/
	 edjvfwCE2X/kw==
Date: Fri, 15 Mar 2024 14:54:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: Yu Kuai <yukuai3@huawei.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de, 
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 00/19] fs & block: remove bdev->bd_inode
Message-ID: <20240315-assoziieren-hacken-b43f24f78970@brauner>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <1324ffb5-28b6-34fb-014e-3f57df714095@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1324ffb5-28b6-34fb-014e-3f57df714095@huawei.com>

On Fri, Mar 15, 2024 at 08:08:49PM +0800, Yu Kuai wrote:
> Hi, Christian
> Hi, Christoph
> Hi, Jan
> 
> Perhaps now is a good time to send a formal version of this set.
> However, I'm not sure yet what branch should I rebase and send this set.
> Should I send to the vfs tree?

Nearly all of it is in fs/ so I'd say yes.

