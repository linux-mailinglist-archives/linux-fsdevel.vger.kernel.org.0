Return-Path: <linux-fsdevel+bounces-28791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CCD96E3F0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 22:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D23B234EC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 20:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A51D1A01AD;
	Thu,  5 Sep 2024 20:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="BPJP4AOp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4EE175BF;
	Thu,  5 Sep 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567549; cv=none; b=mPVkOQtAsmkhCzmxMvfNAoqTy7IDnWGRYBnB5G5wQFGPFy499e9bKdjDSzEia0XTult00TseaJYkeFi8cvSdsQc8F3DfKMpp6sX6Zq4BBILlA2gu2WigWSvldNOQjmmXX/eJkvEAyMn1tVa8UWlX5EKXmZcjuQ8TQneQkPrWORY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567549; c=relaxed/simple;
	bh=dSxDom7EipPIlOqbePYFsJJ9UrMmg2qtFlqtq0cX7vk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N0BeqxuyEu9RL0CyGYPc5AR9GIdRKy4lU7w6UOZJKaqPjIBfShShAIYAYfwl6kHsiWl7r+EGbbUu6ncjjjuD2Obb+tUoESttw/+uQGPQbdgtOhkep/fROfqq1c5zlCWUz4kLWIuZeNST7DpdVHDvWFLZGdF775+iOahU2mlS2dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=BPJP4AOp; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BF1A742B25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1725567546; bh=dSxDom7EipPIlOqbePYFsJJ9UrMmg2qtFlqtq0cX7vk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BPJP4AOploLiilgYBNEBBlMlzee7P8adCjbZxYhNyytj8CV60RYbsOPkNZZZuzywD
	 2ae38vkyZ4dc4hLiLNL4qT18rk7fiirq9k6p7fe5etg9pnpMpNErRXBSCfqICD0T1X
	 b6C55Ca/EUTYnNv1HZZ7CQfzMlF4dj02YBoyOeRQo0BFL3Fyu6yfxlcJ6iov3PcunY
	 xPFJrf8aHnBh4o8ONGwZARndutcO2bPkCfLR1CTVVXIXv1C3hQBqe3sjV8lL3lcG+m
	 xgqwC+FFMUgF087TzEtivWIxeWHGLvbutROZW5yX5Y8GqRsVCi89HqGgTD8FpOB4Os
	 hzsqiztR6E9tg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BF1A742B25;
	Thu,  5 Sep 2024 20:19:06 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-doc@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 kernel-dev@igalia.com, kernel@gpiccoli.net, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Bart Van Assche <bvanassche@acm.org>, "Darrick J.
 Wong" <djwong@kernel.org>, Jens Axboe <axboe@kernel.dk>, Jan Kara
 <jack@suse.cz>
Subject: Re: [PATCH V5] Documentation: Document the kernel flag
 bdev_allow_write_mounted
In-Reply-To: <20240828145045.309835-1-gpiccoli@igalia.com>
References: <20240828145045.309835-1-gpiccoli@igalia.com>
Date: Thu, 05 Sep 2024 14:19:05 -0600
Message-ID: <87cylhhn0m.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Guilherme G. Piccoli" <gpiccoli@igalia.com> writes:

> Commit ed5cc702d311 ("block: Add config option to not allow writing to mounted
> devices") added a Kconfig option along with a kernel command-line tuning to
> control writes to mounted block devices, as a means to deal with fuzzers like
> Syzkaller, that provokes kernel crashes by directly writing on block devices
> bypassing the filesystem (so the FS has no awareness and cannot cope with that).
>
> The patch just missed adding such kernel command-line option to the kernel
> documentation, so let's fix that.
>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---

Applied, thanks.

jon

