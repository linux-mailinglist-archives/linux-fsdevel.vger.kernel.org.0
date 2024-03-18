Return-Path: <linux-fsdevel+bounces-14725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F1887E607
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 10:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB37282721
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 09:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDBB2E646;
	Mon, 18 Mar 2024 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzXmP4mo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC6A2E62B;
	Mon, 18 Mar 2024 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754770; cv=none; b=g/4tVEOZ3TQ209Ro9ryYm7fCKXtgI+7kWLLjLHtwS8VRMwvsOnsUXSnYJ5kpsplF9SDvsvVXo1PFlkvS0yVz4JA8QRWpSd0p9taebDi8/0YM8QmV+aHJ6O/9bUDgOi88SzBBiOGsa0vKY+Kfytw3ZpVV0ZjX7iIh2UVN+uMN+Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754770; c=relaxed/simple;
	bh=/Ol/hP6jJDJFX7LubaYjB73J2s1tvVRfioXG5UzYmMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhoKK0XqGwrhjiCs0HQKwsrmeA3Wr5MZejJg+CQqSJe1GYFwknW831IH011AZvEIvruibBuUo63E1D9WCEeNdW50sHzE54KRTlFh8JN3K7kWxirmrC3D2Lj/g+kl197A2xIU6iv6iqny9XgQBBBr83fI+MrGeU6zBq8aiCG7YP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzXmP4mo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B24DC433F1;
	Mon, 18 Mar 2024 09:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710754769;
	bh=/Ol/hP6jJDJFX7LubaYjB73J2s1tvVRfioXG5UzYmMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bzXmP4mo3vQn8vi8RVOwEO20FSQVWnjsenbFDIuho4PfYOzVVRrZSrZiNtqvxaKx0
	 m6TO0NL79y+AMaBLN5uqyyGdQhlkqlQn5VG5NyDzOZszu0HFZgmaHrVer697WR19Ol
	 YN94GRbpoL/kx6EGbC/Lwkpe/VJ3/vE5L+T9J6lCSnkx2mlc5LaRVA19ifU6kEce8p
	 YLA3nWGUiSAgQOIivTGNw+KOFd8PR+5GL2e/N0rO5N4B7NLutD8jB5L1mNqCb03B1/
	 An8W55RuCF5wCZqzehwvupcq4wnC/ElCZtVH9JG5mhZ7y4Ox4d+pGw0ZQjnuh1R1oK
	 mys2nbaFFk28w==
Date: Mon, 18 Mar 2024 10:39:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, axboe@kernel.dk, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [RFC v4 linux-next 00/19] fs & block: remove bdev->bd_inode
Message-ID: <20240318-mythisch-pittoresk-1c57af743061@brauner>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <1324ffb5-28b6-34fb-014e-3f57df714095@huawei.com>
 <20240315-assoziieren-hacken-b43f24f78970@brauner>
 <ac0eb132-c604-9761-bce5-69158e73f256@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac0eb132-c604-9761-bce5-69158e73f256@huaweicloud.com>

On Sat, Mar 16, 2024 at 10:49:33AM +0800, Yu Kuai wrote:
> Hi, Christian
> 
> 在 2024/03/15 21:54, Christian Brauner 写道:
> > On Fri, Mar 15, 2024 at 08:08:49PM +0800, Yu Kuai wrote:
> > > Hi, Christian
> > > Hi, Christoph
> > > Hi, Jan
> > > 
> > > Perhaps now is a good time to send a formal version of this set.
> > > However, I'm not sure yet what branch should I rebase and send this set.
> > > Should I send to the vfs tree?
> > 
> > Nearly all of it is in fs/ so I'd say yes.
> > .
> 
> I see that you just create a new branch vfs.fixes, perhaps can I rebase
> this set against this branch?

Please base it on vfs.super. I'll rebase it to v6.9-rc1 on Sunday.

