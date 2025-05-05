Return-Path: <linux-fsdevel+bounces-48091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94373AA958F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 16:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872C2189BE17
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 14:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5CC259C9C;
	Mon,  5 May 2025 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0wSIYBb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663A677111;
	Mon,  5 May 2025 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454873; cv=none; b=SVkj+pDbzOP9VGyWyKP/53Lk3qNWVW8ZAa7kWqwhCvCfj5DemCN8aX5cAICfryYJ29r3AhVL4uT1DF6v330QHAYdKpQYhX0fdesURJaTPT7FgaCEW5CIEeKBzEBIfWXz8h5coIjyiLCW8d2qNyuTzycBKoSEgfwCoZnWlRkb5IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454873; c=relaxed/simple;
	bh=94MZILw8BjtHmyqJf30aTndYbQiQoKqn4L/9ITuUj1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsvK9edv8e4crG3rxUKFxzP/cLkAiueUuKSdrptfsvHwZ+06e66lyeOb46C6LpW47uBfiiGV+NN9Qq5TLCpm76kz+wsD4flCL+jGbwfI1R0RHmtNSL8DR36QnpPi7EMq/o1hkBYjXJHJ6yZ8clD0Tcbj/3Jurx9QyBYk2OHna/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0wSIYBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019ADC4CEE4;
	Mon,  5 May 2025 14:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746454872;
	bh=94MZILw8BjtHmyqJf30aTndYbQiQoKqn4L/9ITuUj1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r0wSIYBbPqtAFUY+a2rfAwqjhxZmnLQJseVAPHQka/nM+qn01NBrgqHj9EdPPdyR2
	 P0k9ddaJnDWhprrAO2Rc4EjFFnU9KvmgWz7BvjcQW1DumlWDq5S245r2NZT3BnJae+
	 wIvQ88odJaC6oNiKOd2YZKJ2uTx8QPLeg9kOZgzQ0XEGbOdyMaQUo8sbfuFD5JKo76
	 9D6uXQALEzeb3vdXnG/KlLeXDB/zEVtoRyMJOLuC+QgiNEXEY8WCaP/B9XwVIjHkDl
	 gF0GALyFfmuivK8eRC/YqKpsmtkxedOPfk5IT1sR0IId0SMUSRkO2PTErY0VBkqz5l
	 VkOI5RTHG2HHg==
Date: Mon, 5 May 2025 16:21:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com, 
	da.gomez@samsung.com
Subject: Re: [PATCH] swapfile: disable swapon for bs > ps devices
Message-ID: <20250505-schildern-wolfsrudel-6d867c48f9db@brauner>
References: <20250502231309.766016-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250502231309.766016-1-mcgrof@kernel.org>

On Fri, May 02, 2025 at 04:13:09PM -0700, Luis Chamberlain wrote:
> Devices which have a requirement for bs > ps cannot be supported for
> swap as swap still needs work. Now that the block device cache sets the
> min order for block devices we need this stop gap otherwise all
> swap operations are rejected.
> 
> Without this you'll end up with errors on these devices as the swap
> code still needs much love to support min order.
> 
> # cat /sys/block/nvme3n1/queue/logical_block_size  16384
> # mkswap /dev/nvme3n1
> mkswap: /dev/nvme3n1: warning: wiping old swap signature.
> Setting up swapspace version 1, size = 100 GiB (107374178304 bytes)
> no label, UUID=6af76b5c-7e7b-4902-b7f7-4c24dde6fa36
> # swapon /dev/nvme3n1
> swapon: /dev/nvme3n1: swapon failed: Invalid argument
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> I had posted an RFC about a heads up about us needing this less than a year
> ago [0] and well, we now need it for v6.15 since swap code is just not ready.
> 
> Christian, this should probably go through your tree.
> 
> I tested it on a LBS device where the logical block size is 16 KiB on
> x86_64 and confirm that while mkswap would swapon would be rejected.
> 
> [0] https://lore.kernel.org/all/20240627000924.2074949-1-mcgrof@kernel.org/T/#u

Thanks Luis! Did you plan on adding the comment that Christoph requested?

