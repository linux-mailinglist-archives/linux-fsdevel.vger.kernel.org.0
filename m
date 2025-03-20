Return-Path: <linux-fsdevel+bounces-44653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFE4A6B022
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 22:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CBAE19C0528
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 21:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA52A22A819;
	Thu, 20 Mar 2025 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Is/D9gNb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1122A7F8;
	Thu, 20 Mar 2025 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742507183; cv=none; b=XvIPFu5NSUNJStGSstypmeldstTAzWiMZp4vwxJv1Pp/3hFEHF2ATPtuK+uF3sXzoaJW4MG0U6Zzpq36vP1vXVrmZVQ0Mo2N5N8oJ2A/yFrwjZpMMEfwR80AdAeFJaDLXV/MfIioM+Zyasuypnp6FAemxZEp3VrjdDqPsvQg8kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742507183; c=relaxed/simple;
	bh=tIioghicpQr3pmw5Sb/QIdJmci3qZXGbXH7x0CysHYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=belaisHj76T634PDbEfFmjoBdc3+I9htLZvWITV9lSGw4Q3mu1kMLfVIhEKky6mjsA9aYkVoECwlQzEcI0Yiveg4YSsoBg+tXPTg3a5aWXnXYtJuL3Pow/OgYXcf2EArS5GLz03KQPm7Hhbdr82WC2pOgI9+upVEX3nBo1pDfoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Is/D9gNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C43C4CEDD;
	Thu, 20 Mar 2025 21:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742507182;
	bh=tIioghicpQr3pmw5Sb/QIdJmci3qZXGbXH7x0CysHYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Is/D9gNbxFZ9rjohQBIz3DUAHsyZTatAqRba6SOq67JBFVhtI44bCIJM+54Mk5Uzk
	 E2/uBjG5cW9uLJeK/QNESgQRnN//O9W7mdzP1TYXuQxkeLUUAy8Kz8w1Ur/4Dd6V7t
	 8EfexWOd4Y+IRPtaz4jxxHFm1ICPw3CIBKpJwRPx3i1FkNR1h7up5F/JBfSa2WEG9P
	 BAm5YzncD8+msKa1XebPoEkziuL4sKIbS5qqtuNIp6UVWWRdgb3rtLfsyTARJVjWN1
	 L/+jjJB4QZPt2HBtCxwaTsT7ASt63fFZC0PJaHwvKgXHC4ItOTD9i909QpEWvLdlCn
	 IE5NanQCaqAbA==
Date: Thu, 20 Mar 2025 14:46:20 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	david@fromorbit.com, leon@kernel.org, sagi@grimberg.me,
	axboe@kernel.dk, joro@8bytes.org, brauner@kernel.org, hare@suse.de,
	willy@infradead.org, djwong@kernel.org, john.g.garry@oracle.com,
	ritesh.list@gmail.com, p.raghav@samsung.com, gost.dev@samsung.com,
	da.gomez@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
Message-ID: <Z9yMrCtwtX7xIMMx@bombadil.infradead.org>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
 <20250320141846.GA11512@lst.de>
 <a40a704f-22c8-4ae9-9800-301c9865cee4@acm.org>
 <Z9w7Nz-CxWSqj__H@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9w7Nz-CxWSqj__H@kbusch-mbp.dhcp.thefacebook.com>

On Thu, Mar 20, 2025 at 09:58:47AM -0600, Keith Busch wrote:
> I allocate out of hugetlbfs to reliably send direct IO at this size
> because the nvme driver's segment count is limited to 128. The driver
> doesn't impose a segment size limit, though. If each segment is only 4k
> (a common occurance), I guess that's where Luis is getting the 512K
> limit?

Right, for direct IO we are not getting the large folios we can take
fruit from with buffered IO, so in effect we can end up with large IOs
possible with buffered but not direct IO.

Yes, direct IO with huge pages can help you overcome this as you noted.
But also mTHP can be enabled and used for direct IO, or io-uring cmd but
mTHP is not deterministic for your allocations even if you have a min
order filesystem. The min order requirement is only useful to use in the
buffered IO case.

  Luis

