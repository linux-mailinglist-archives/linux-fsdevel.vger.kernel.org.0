Return-Path: <linux-fsdevel+bounces-73489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B17E5D1AD6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 19:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5623A3010520
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 18:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A17C34DCEE;
	Tue, 13 Jan 2026 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UK0t/RGR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC79342CB1;
	Tue, 13 Jan 2026 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768328885; cv=none; b=nOmPqVEcm+BURd/5fJK6WDhpRwJeUFjkYm0XriFkaQuW/FZjFu+S0ZW47KhVKm6WgBEHk9aRBvMfjG6do9fvR5b53GRIQmhiszts6aBHy6hCwoWWtgw7dk8Rbfbku12Fzi6wQ4h6rJFder8Rdzj2xiQ3F/yPys9LUTf3gViCutM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768328885; c=relaxed/simple;
	bh=Iv1rLkD62cgCbajLhZPKx5rPMv2NqyBVU6clCTQq5q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jngf8zolhcAmxj82s13rjyqa1zy2KCsXN6EE6uvaooiW4MwtXjoUXGkIREuEZCOTVVQIryqiroMA1gMEitLYAZONZj+2YgkIOOak23IsmZgXSaoPX9+R0OHmpG9SyAlbaWPfyrOkASfXDo/Y16sTTjXuTXkkRS8ClK1VCpDjnx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UK0t/RGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB89C116C6;
	Tue, 13 Jan 2026 18:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768328884;
	bh=Iv1rLkD62cgCbajLhZPKx5rPMv2NqyBVU6clCTQq5q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UK0t/RGRZRR//gpjWoXGseN1JNgTwgWTQUV8tCrfAHqNsSYBvFMyhWY4MAtZyNGeT
	 GgpNj8UJQp5TGcmZTdlosCaUbx3zEEQGpQVyBIMJk2QmHChR7jBb5RYSKe83Q5aB4V
	 FWNYXJPb4df4fI1lSjJh0wOva7xmfGsAhAGbMjGywGnWb+6Y7s3QLYAdZQC3Aglh2/
	 KQ9sox7D89A4fumBToqBsQvmNjX2AFg89w8mO9maq+QcOz7yy0atePZ6aQSvA0n+pB
	 gUaR3BPcFQc+36hO0+vHsb7dLqBeHqgX2G61FH56w4tNOJQ45kSmKAeOF6lHhVWtbm
	 bkX4tN6gvAAHA==
Date: Tue, 13 Jan 2026 10:28:04 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: cem@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 09/11] xfs: allow reconfiguration of the health
 monitoring device
Message-ID: <20260113182804.GC15532@frogsfrogsfrogs>
References: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs>
 <176826412900.3493441.14037373299121437005.stgit@frogsfrogsfrogs>
 <20260113161715.GC5025@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113161715.GC5025@lst.de>

On Tue, Jan 13, 2026 at 05:17:15PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 12, 2026 at 04:34:54PM -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Make it so that we can reconfigure the health monitoring device by
> > calling the XFS_IOC_HEALTH_MONITOR ioctl on it.  As of right now we can
> > only toggle the verbose flag, but this is less annoying than having to
> > closing the monitor fd and reopen it.
> 
> "reconfiguration" stills sounds rather pretentious for toggling the
> verbose flag, but the code looks good:

I'll change the title to:

"xfs: allow toggling verbose logging on the health monitoring file"

> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!

--D

