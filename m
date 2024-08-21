Return-Path: <linux-fsdevel+bounces-26494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DF795A283
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 18:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DCB1C222EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 16:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA3814EC5C;
	Wed, 21 Aug 2024 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKSMg4wi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AFF13AA2F;
	Wed, 21 Aug 2024 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256717; cv=none; b=L2NWoPjTPZp4lryqNJOGpSiIuPi2x9aGyTcyJlyog3G6iJpkVKU8eFInlT6WLO9HGYLtFakKkav3qxNLpM6kFwsQp8Nu8CSQLO6UFAUV+Q+7Cp9ehKSdprFvpwvOvOjdjS8k7RMGKst2WgZH313IQKLfnCNWYRxA78P/XApSPjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256717; c=relaxed/simple;
	bh=MEJJd+MKHs1hMwsiYvw3/hmUabJ0aXvZ/amvjwnl0Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/ZBehU5cvbMVwiU9jO24q8Lwt1PfQmjxuz4jrzAEEOe53OHKFmWGrlSOjPmPuhol2H96GD1pWGJ4lx0j1K/2Y8omcn2bUs4YZFUoqj7GQXollbLhx0lkQz2YZJVS9rqnl3iMibE80M5GZAHRwuP3stRyXbaerh6cWvHN5NHNAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKSMg4wi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC53C32786;
	Wed, 21 Aug 2024 16:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724256716;
	bh=MEJJd+MKHs1hMwsiYvw3/hmUabJ0aXvZ/amvjwnl0Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKSMg4wifuJYoPjK6qaRKZugM+xEv2szUoNZoUXGKK+OxqWJeZWUT3YVBtU6trS2u
	 lcAqeb9/5CmVrTfYcQvPdFWAuOGpEQHN/0ouVXXlxfTrX+Ac9tnvINk1Q0SBAktXmy
	 EA/CwkPBqF/3bfCm/sVaboL18jPlh8jwGk0RPeTMsN9295RqXUIp6vnCjLw7KHJ68X
	 kiVIhAHnrmps4osYirOFwkAMvvF49/IPqxAZp9m2nHSyXdcDRtXSQBJXDqSrwYfy1l
	 iSLhndiuZxHDq9Um2ov8kuLFta17kNye8jNc4Z1hAiFqKsI/Cesi/j+GCeqkGnIyrP
	 kE11iork6D+Gw==
Date: Wed, 21 Aug 2024 09:11:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: sort out the fallocate mode mess
Message-ID: <20240821161156.GB865349@frogsfrogsfrogs>
References: <20240821063108.650126-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821063108.650126-1-hch@lst.de>

On Wed, Aug 21, 2024 at 08:30:26AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> I've recently been looking at the XFS fallocate implementation and got
> upset about the messing parsing of the mode argument, which mixes modes
> and an optional flag in a really confusing way.
> 
> This series tries to clean this up by better defining what is the
> operation mode and what is an optional flag, so that both the core
> code and file systems can use switch statements to switch on the mode.

For patches 4-6,
Acked-by: Darrick J. Wong <djwong@kernel.org>

(I'm not going to touch the NO_HIDE_STALE pony, I'll let you and tytso
mix it up over^W^W^W^Wdiscuss that...)

--D

