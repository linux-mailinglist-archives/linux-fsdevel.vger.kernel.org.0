Return-Path: <linux-fsdevel+bounces-27506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8CD961D46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 06:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25B41F2433B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 04:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2796C145A0F;
	Wed, 28 Aug 2024 04:04:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C8D3FEC;
	Wed, 28 Aug 2024 04:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724817888; cv=none; b=lARwXmTnAlVVlEkv85hvCAMey/75kcWsHKEr7LlCDfJxR5MMSei/F1vOpTL2FMkghsYkxOhVCHMQU15YVjnSAA7UbHLmBe4Xi71ciFsXP7dKieXyNvDQbj1wO5lk69TNrnBXyheov4t2VOzaKQoO8perVHDGKvzcNlnbKvWxyx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724817888; c=relaxed/simple;
	bh=XgqJ1W2bzYdI5oXGVpzV1GTdSHe1K9DQ5SYe0OZrCZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onDwzWNMeaR6eiCsIg1Q2c8gSUiDpA/mBsTYzj8XJFMmRyZn7YeLvu5vF1sf1FmXrcuTf927DEehEQaqVQX61+sXi/XoBxYcM608uFr6xlPlhyKH7AshPGVXsw3+bxZ3d/HLuW1QDUA1+QXq3pvAoYyd/kY+w92cQZYyv3GoKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8DE0268B05; Wed, 28 Aug 2024 06:04:40 +0200 (CEST)
Date: Wed, 28 Aug 2024 06:04:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Brian Foster <bfoster@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/6] ext4: remove tracing for FALLOC_FL_NO_HIDE_STALE
Message-ID: <20240828040440.GA30409@lst.de>
References: <20240827065123.1762168-1-hch@lst.de> <20240827065123.1762168-3-hch@lst.de> <20240827145634.GR865349@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827145634.GR865349@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 27, 2024 at 07:56:34AM -0700, Darrick J. Wong wrote:
> If we're going to drop this flag that has never been accepted by any of
> the fallocate implementations, then can we remove it from the uapi?

We usually don't really remove code point allocations once added,
but converting the define to a comment might be a good idea.

