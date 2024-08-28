Return-Path: <linux-fsdevel+bounces-27586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F247E962902
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 15:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A404A1F221BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 13:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCA7188CC6;
	Wed, 28 Aug 2024 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jz/nPOOu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F2017BB25;
	Wed, 28 Aug 2024 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852625; cv=none; b=PBs7aOvZRnNb6HupEloPwQPdWo0S10wDl71s9hTTBwrvn06N1K6to2cM/wsn2ZTjCzuhLIp1B+a03cKL7Nqbq7aHA8mSsMoUe7sOlQZ/WX82mo/v4j9ry34yj/VNx/h3pwVJHx9IHkIPHmTS3r1H3S13Qs+J3mXK9Nhkzyuv1h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852625; c=relaxed/simple;
	bh=vUCy+esMmmIriBrBlRQ/31MuOgDJ+ygm7nRLEW5Xqrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESNw3JeOfCfKnXxsQpt6qOves3AB8XkqLAPyVLFdeizaqebO21oUKMT6McgntDHXuIoKYXSmSjXKA5hVHJpo/cjBYjzPL/0lZXk+/AhjTQ8ztuU1QGpnEdNdI+7xoMjqTfwDZY0sRVyzyCvYzMrPR4k4eDjwz1npD3/AdrfJw2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jz/nPOOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE4EC98EE3;
	Wed, 28 Aug 2024 13:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724852624;
	bh=vUCy+esMmmIriBrBlRQ/31MuOgDJ+ygm7nRLEW5Xqrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jz/nPOOujBTjhMz0brFF+TVmPv00EZ6RkW9IETGOlegJnv1iP0A7Gmg/kew4aXaby
	 /oFvT3XVKC1MpRjhejrWxl7KpZr8pwBs3Kq96c1FN/8b3nDDfYTUypGcSCYuFM26vK
	 K9j52Du8W+wLg1awymI3Dvaa5bqXymzKw/VyJAM2YcrFKvK7eoRH11gLE3Dg5FnfF2
	 4EUIV5Fex5iPKPdW9xV+nH03bToEBjIizw0+dbUchpeMfND8G08mQHib/wcdg8G3ck
	 tBORZgwX2W2M5ohjNa2myNIeyTGIhOnyLewIWlWTxQs7yHXtQUWLAzF3NyA/2CNskn
	 +v9qkEL10c4zQ==
Date: Wed, 28 Aug 2024 15:43:39 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Hongbo Li <lihongbo22@huawei.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: RFC: add STATX_DIO_READ_ALIGN
Message-ID: <20240828-gaswerk-wohlfahrt-744e04b7becd@brauner>
References: <20240828051149.1897291-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828051149.1897291-1-hch@lst.de>

On Wed, Aug 28, 2024 at 08:11:00AM GMT, Christoph Hellwig wrote:
> Hi all,
> 
> file systems that write out of place usually require different alignment
> for direct I/O writes than what they can do for reads.  This series tries
> to address this by yet another statx field.

I think that's fine. If we run out of statx spare fields we can start
versioning by size using via STATX__RESERVED.

