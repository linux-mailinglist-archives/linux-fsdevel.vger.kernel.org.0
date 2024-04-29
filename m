Return-Path: <linux-fsdevel+bounces-18079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CDB8B5358
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 10:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4580F281983
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 08:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461D917BBB;
	Mon, 29 Apr 2024 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hU7MiF7q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FA01118D;
	Mon, 29 Apr 2024 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714380126; cv=none; b=SIfawS7pSSczfI8ceAziAL8AsMq+nmSRhxM5M+IUHQUo9BYY8Yj1euSj4IGteBERzms2vy6P53AGGSbTjg5PPmfMVBER4yx0D+tpGDSI4h7JITQG7erICyvm6h+o/6Kwg08q1x95a2IAVATR2+z8lCjncibs15Mq7csOA+0bb5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714380126; c=relaxed/simple;
	bh=LG62qWMIwbIy4hcTqwq+US2SDrBdu3Qw1QIOQR8u+zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOI6ZrdZ8+yMLMhkNKS6JwDdxNwITqnXOksuK0sJyD5HTIMycO5jLrMzaN4qypGy+9js24D9axE6bNKn2/loC3cbrRhtRsl5cXzzpNDbWcOvYU3w1nSOiPzA85TLuEJuJSkftdQX295tL0qgCyRNQEsYZ74sMOP4Z3zhHJjtMGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hU7MiF7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6071C113CD;
	Mon, 29 Apr 2024 08:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714380126;
	bh=LG62qWMIwbIy4hcTqwq+US2SDrBdu3Qw1QIOQR8u+zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hU7MiF7q/FWfGWWxaTvM655FH3q1W42M0SjW9CBvmUlaPodAB8gFhoGSMSiIgZlBg
	 c1PGBQD2qWkQdTS+zL7zGznELL8ulnmJ58pBQbNgKruKnV7hfr8IcbtydJ5MBrm+Ee
	 1CLdp+i506bzYWw0MarGJ5o5MYRkc9pDLoxSVZcUIwfcPB0zyTcQSxSEJAduCwFB4Z
	 zmxWaCgWn9AWtGR1KCeE2L67Cha0KFSEQ+tyowYk6bp0kmwgzNMAzDRV2zqmQNWk4n
	 HpNMJbaotlhBMJRAWXw7vohGaJy9oSTApEYr2XTNxfFkXM3yQpaaXTFtr9HM54Ij7Y
	 Gv51BzGvsD5Cw==
Date: Mon, 29 Apr 2024 10:42:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 7/7] set_blocksize(): switch to passing struct file *,
 fail if it's not opened exclusive
Message-ID: <20240429-nilpferd-beimessen-920d25a648f5@brauner>
References: <20240427210920.GR2118490@ZenIV>
 <20240427211305.GG1495312@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240427211305.GG1495312@ZenIV>

On Sat, Apr 27, 2024 at 10:13:05PM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

