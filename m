Return-Path: <linux-fsdevel+bounces-10657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C200D84D1F9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 20:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F303B1C26689
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 19:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4758663B;
	Wed,  7 Feb 2024 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENQrnzkO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CB88564B;
	Wed,  7 Feb 2024 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707332679; cv=none; b=mvzQ1RzPJmdvxr5YmpEn2LYaJODwtX5/OFDGbM+qJc97g3bw0Ri0AxkZX+ldxakc1nV+ReEvHtK1yaFxWlCO0p9Cr010pvGNDn4g2hnIjkzMEAmbMJjng6LtvucLLcVaYUF11oNZ54c9Zs9NnGBBnfAt0zncM9EG2o4f+YPdeQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707332679; c=relaxed/simple;
	bh=5GVhqpjuJPE3FvDUZWAwDUtgj5KWUa1cTo/8uxteTSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgiq3wyX8djdFoMGGhHa9trBFU7deowuaZrzs86mRqqvxeYeMjzj7c01GDNKdv67iOOiEGIf4kWWSLgKr3xn1Ygk0zznlmO+Vm4BWqujF552JFQ6Qo0uiq09xkvuHltpu3z4jYkT3c/iXloDmTMKDk6zmNsbWWS5+IHyMOdkvvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENQrnzkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F337C433C7;
	Wed,  7 Feb 2024 19:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707332679;
	bh=5GVhqpjuJPE3FvDUZWAwDUtgj5KWUa1cTo/8uxteTSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ENQrnzkOPesZKqiDU0cwLn6XoCVLAjhIas4QUugytVYKxIG6Ba3AAqFcM4GdT4lKE
	 ZIfO4DJkgQ2SumZp9LXEi1kNi30mL3Uc/OnlYY+cq7ElPW8rEFM2oaARX/iHE5iQXF
	 l0LSvClRKd072SrfoHcrqBEvIm6rmJa3ALLMeloOH9BE6HIC7M/PFr1u9X6RkoLyJE
	 d6rasc/zNnMTcS7TOx95EfuDYryAmxUEXZfrKk5TAXjOE3w7wI7r8TASZjU0md0wxM
	 QgGwhSp1i4pwA3EiydfHLf969TbHVr9X9bKjDRjFz9cRJfYaBxu9JvbXmn5NkCL72q
	 rPBnlttOAE8vw==
Date: Wed, 7 Feb 2024 11:04:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 chuck.lever@oracle.com, jlayton@kernel.org, linux-api@vger.kernel.org,
 brauner@kernel.org, edumazet@google.com, davem@davemloft.net,
 alexander.duyck@gmail.com, sridhar.samudrala@intel.com,
 willemdebruijn.kernel@gmail.com, weiwan@google.com,
 David.Laight@ACULAB.COM, arnd@arndb.de, sdf@google.com,
 amritha.nambiar@intel.com, Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS
 (VFS and infrastructure))
Subject: Re: [PATCH net-next v6 3/4] eventpoll: Add per-epoll prefer busy
 poll option
Message-ID: <20240207110437.292f7eaf@kernel.org>
In-Reply-To: <20240205210453.11301-4-jdamato@fastly.com>
References: <20240205210453.11301-1-jdamato@fastly.com>
	<20240205210453.11301-4-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Feb 2024 21:04:48 +0000 Joe Damato wrote:
> When using epoll-based busy poll, the prefer_busy_poll option is hardcoded
> to false. Users may want to enable prefer_busy_poll to be used in
> conjunction with gro_flush_timeout and defer_hard_irqs_count to keep device
> IRQs masked.
> 
> Other busy poll methods allow enabling or disabling prefer busy poll via
> SO_PREFER_BUSY_POLL, but epoll-based busy polling uses a hardcoded value.
> 
> Fix this edge case by adding support for a per-epoll context
> prefer_busy_poll option. The default is false, as it was hardcoded before
> this change.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

