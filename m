Return-Path: <linux-fsdevel+bounces-58612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBF2B2FBAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 16:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04D3F7A3CD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 14:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527032DF708;
	Thu, 21 Aug 2025 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBZbiO+u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A372923D7E5;
	Thu, 21 Aug 2025 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784896; cv=none; b=PPpXtEqU35PZvghwjSVbUK2oVhkAe4eCmtnsjOzdZfbNNum8mWrhhbXgei1fG3lv/43RjywaeHxyHIAX9Sqpl5+neE+32dsf4Xts/FEw762y6c159u5Hzurvbac2BWJXtpSvM2wH4g6hysFmvw9dSVj/aca3F1Y5H/Hb6AR0eEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784896; c=relaxed/simple;
	bh=fPFpDcD5IoxktsMx43cYimZsbxu1wQFHGY0B5ONqI+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBRv5NRGR4i4jwq1GGIgf67G5Qs/83ZFkd4d7KAUg8QC0RUuej2+8wyD3H+UxM0mxF7RoqV9STHlanL4j+hXQTvLGJnxs/Ns3INL4rhIn8hAZ8/UCH4ctBINroSqflBB/FHkkiA2w+fZSnGzEapzsoPHQTtJT9xLAkLJNDhggiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBZbiO+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EE0C4CEED;
	Thu, 21 Aug 2025 14:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755784896;
	bh=fPFpDcD5IoxktsMx43cYimZsbxu1wQFHGY0B5ONqI+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CBZbiO+u0jnyT/QGYfPK58tb7SkDHf7TnD6mTq5jfAmGCYn5ThhwQBfRcPNhHFcTM
	 eQjyVgQ69lPhefuQvvkjB7K5TAsb5ZQdv1w7eFx6j64qrpBWhzIYrqxL6AoJCebPEm
	 E3ds54S/IKBi7nfgAt1pkwRuEJbiTa1ZJXCtbUCHmYXrqcN2SFZ3Egk8tgVcylrGje
	 re2tLHiZpiaoH2XbU7utb+SJZdcbYpxhCEQ/ZeDsceUCweYwTq0DWlO4PtQJv5tflI
	 AwCCEyK6rYOhejR/MLYuvMQt2yiuCqXn0QQ977AvzvqlweOjjqkj0h+mYH4VM7TooN
	 r1fVhUxmBnb8A==
Date: Thu, 21 Aug 2025 08:01:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <aKcmvfECWdv6CedK@kbusch-mbp>
References: <20250714131713.GA8742@lst.de>
 <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com>
 <aHULEGt3d0niAz2e@infradead.org>
 <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com>
 <20250715060247.GC18349@lst.de>
 <072b174d-8efe-49d6-a7e3-c23481fdb3fc@oracle.com>
 <20250715090357.GA21818@lst.de>
 <bd7b1eea-18bc-431e-bc29-42b780ff3c31@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd7b1eea-18bc-431e-bc29-42b780ff3c31@oracle.com>

On Tue, Aug 19, 2025 at 12:42:01PM +0100, John Garry wrote:
> 
> If we always ignore AWUPF, I fear that lots of sound NVMe implementations
> will be excluded from HW atomics.

It's not that they're excluded from HW atomics. They're just excluded
from the block layer's attributes and guard rails. People were using
NVMe atomics long before those block layer features, at least.

