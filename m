Return-Path: <linux-fsdevel+bounces-10938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748D884F4C3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE4F286A2A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B88420325;
	Fri,  9 Feb 2024 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umc6NbkW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AF026AC2;
	Fri,  9 Feb 2024 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478791; cv=none; b=U1n4UVG+6ucavvp93a7QkyK6EVoG4UHIBrtjFlO73atI9SlnzJ6tjqAAdDC8QR9RE06J3vieYjJTsCtxby3qidMXRc0r+3HdKhHmlgYnIbL2mzNS0UiqPQACGTnZvWzUJ9/6efH+ZRzmcG/KUUybwKcXp0BXoCZlMpFH36CCAs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478791; c=relaxed/simple;
	bh=qsVDpGlKNl7ofaW0rykZqXDOCMPdKAFPik4Rvabi0zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7ZHJWxx+SMmLZrYfnKX7GOBgUFAvmNfSXHHWQCykbXcefz1tp4jnJjmzDCsDrBwMyycFpQ9a60ajeyldqAVjLUunbr14xCuB0ActLEKC0JuI5LXsM5sqKqq1WZtL2EOxti1hdN8ouZtDC9xP9bj5L4UdJpx1hyoMZPnUbYjkNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umc6NbkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4561DC433C7;
	Fri,  9 Feb 2024 11:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707478791;
	bh=qsVDpGlKNl7ofaW0rykZqXDOCMPdKAFPik4Rvabi0zI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=umc6NbkWI/3l9wXMfJxEJJ9IQI4sqnre5durlk/V0O0oz1zWstyNoBXhum+docG8v
	 XIWVxrqz9960/nWpXSpo3K3wcMOu1tojGMLTPrjMyBdo64JQ3bKnPM71VRSni70kfj
	 89EQTRcC3iCR8qb2AliPKjUsXdI++bDvBjR8A1Asz9rwIO8Eyg7j/EhqcIzprb3V6T
	 5ZIThjWUJLJ8fAdMLL4lVFUzvorzC+komHdZB4Gye/dDfo/GoYB9OKFf8Gk09ID7zV
	 ZVkJrjiCfeHBdTcI1K0Drb23FiO2YuWjtEGPSUaqulcIJFs19Nc/S1N++Ozp6cNPcU
	 19tDky4183FFw==
Date: Fri, 9 Feb 2024 12:39:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 01/34] bdev: open block device as files
Message-ID: <20240209-hinreichend-gut-f5d588b72096@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-1-adbd023e19cc@kernel.org>
 <20240129160241.GA2793@lst.de>
 <20240201-rational-wurfgeschosse-73ca66259263@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240201-rational-wurfgeschosse-73ca66259263@brauner>

> > How about the following:
> > 
> >  - alloc_file loses the actual file allocation and gets a new name
> >    (unfortunatel init_file is already taken), callers call
> >    alloc_empty_file_noaccount or alloc_empty_file plus the
> >    new helper.
> >  - similarly __alloc_file_pseudo is split into a helper creating
> >    a path for mnt and inode, and callers call that plus the
> >    file allocation
> > 
> > ?
> 
> Ok, let me see how far I get.

Ok, it's in vfs.super.

