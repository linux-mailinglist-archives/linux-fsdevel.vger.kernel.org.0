Return-Path: <linux-fsdevel+bounces-41105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FE2A2AEE2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 18:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDEC4169B43
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 17:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2DD18A6A8;
	Thu,  6 Feb 2025 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2VgB/Zh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFDB4C8E;
	Thu,  6 Feb 2025 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863040; cv=none; b=Gydf51VjfGaBHxUBmzhjht6o7ZTMsZmvDXBcp+4lp6YYSg6BiNCb3PVOhW044E//o7EiAAfcq6sNCaT0eBK2j/yQLOEZ8719JpqByMbebsRlwZ7010eGmZN5UB3o8iF+S8sMJ7PuSOfNIAQr1gtQ9WD8hols3ZYg2M6suOAwPWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863040; c=relaxed/simple;
	bh=fMnGPXellcATsoTgTEpcZXWkCawqhY4ZsZLOxIxgcjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLSDczLtPYkGYWhpJSO9s9cAM6SatLL1C5pZ4uL+/w5sEbUONDRoQH3qrimYk3wXzjZs+rPhKHBf9oBFX2si6GuTydOAdyyEqNNuuQodnS8u39hFAZfTqKnAXS7fwwGjQ+mVaijP6RzlschTU3D4y3US73fNU3/x100/c7gGGT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2VgB/Zh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19022C4CEDD;
	Thu,  6 Feb 2025 17:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738863039;
	bh=fMnGPXellcATsoTgTEpcZXWkCawqhY4ZsZLOxIxgcjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2VgB/ZhyftJcPwSE47rRZLndJn/gjdZBfdSAa/NV79MAmkUE+QB3pwlCQrh90ibR
	 DWiSGHzMdTZyIe7U46vwDWayl2XxUYiUEBQKd5smb6M+wLnRrYxzDvBKrAP9pkta63
	 umbqy5w2cHEooBsTl6qnWJTNe0F22m32N5DOPySu/bqwnPNFosq58UG4ThkKShAoQe
	 +3i4hdZOo53rOhiKCfRtEsyNmZsR36qJugxZx6LuJihnY7XmtfwKnJPsAZJbvrZndH
	 FK1zl3gx0c+rIzXCVF4X8a9/DoQoE2gWU3b89n5R0R91uWOKo+lrMjgrrLniFLQZ9p
	 SU8prm5jrnNSg==
Date: Thu, 6 Feb 2025 09:30:37 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>, dave@stgolabs.net,
	david@fromorbit.com, djwong@kernel.org, kbusch@kernel.org,
	john.g.garry@oracle.com, hch@lst.de, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	kernel@pankajraghav.com
Subject: Re: [PATCH v2 1/8] fs/buffer: simplify block_read_full_folio() with
 bh_offset()
Message-ID: <Z6Txvdewl2m8NRRo@bombadil.infradead.org>
References: <20250204231209.429356-1-mcgrof@kernel.org>
 <20250204231209.429356-2-mcgrof@kernel.org>
 <1b211dd3-a45d-4a2e-aa2a-e0d3e302d4ca@suse.de>
 <Z6PgGccx6Uz-Jum6@casper.infradead.org>
 <13223185-5c5e-4c52-b7ab-00155b5ebd86@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13223185-5c5e-4c52-b7ab-00155b5ebd86@suse.de>

On Thu, Feb 06, 2025 at 08:17:32AM +0100, Hannes Reinecke wrote:
> On 2/5/25 23:03, Matthew Wilcox wrote:
> > On Wed, Feb 05, 2025 at 05:18:20PM +0100, Hannes Reinecke wrote:
> > > One wonders: shouldn't we use plugging here to make I/O more efficient?
> > 
> > Should we plug at a higher level?
> > 
> > Opposite question: What if getblk() needs to do a read (ie ext2 indirect
> > block)?
> 
> Ah, that. Yes, plugging on higher level would be a good idea.
> (And can we check for nested plugs? _Should_ we check for nested plugs?)

I think given the discussion less is more for now, and if we really want
this we can add it later. Thoughts?

  Luis

