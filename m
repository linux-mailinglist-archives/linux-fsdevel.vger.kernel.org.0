Return-Path: <linux-fsdevel+bounces-57328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AF1B2081B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531763B5BBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3052D3729;
	Mon, 11 Aug 2025 11:45:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666862BEC2F;
	Mon, 11 Aug 2025 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754912726; cv=none; b=WGQMxugiI47PzvSt8LzzwIQyg1C9+/siF9C9CwJjkuFxntk9o9ojKPcG27RFB/16AOctt76/LVXoKgtj6GZSSmOtiWX0vyyu7ml78IT1yY+RnCu4D8VQh4aDUA6cACxEDBygr2Za03PilZKbTLYCQ8LuGvoxIPfMQofH6Rn6GmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754912726; c=relaxed/simple;
	bh=1FpN0t8TOFT0mPy+HBk3oYO0/vYuhEeuchJL9MfoR4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWqJxeLfng2GGGjkJtrm89DIPsVLEtXis4LOsdAtf0IJZN6+UGbX8DF1+T9WBdsrUs6f39P6wwOSsD+PgA5UKHLTcB5pTY9Q9AOgujAuyXbRxKvJUfw67vhaV8aNSfahyNK1Ipv6snbsni1S4tiZbGx8+yb55hoY/NeKaGMw3vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F2C26227A87; Mon, 11 Aug 2025 13:45:19 +0200 (CEST)
Date: Mon, 11 Aug 2025 13:45:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org,
	ebiggers@kernel.org, hch@lst.de, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 04/29] fsverity: add per-sb workqueue for post read
 processing
Message-ID: <20250811114519.GA8969@lst.de>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org> <20250728-fsverity-v1-4-9e5443af0e34@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-fsverity-v1-4-9e5443af0e34@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 28, 2025 at 10:30:08PM +0200, Andrey Albershteyn wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
> 
> For XFS, fsverity's global workqueue is not really suitable due to:
> 
> 1. High priority workqueues are used within XFS to ensure that data
>    IO completion cannot stall processing of journal IO completions.
>    Hence using a WQ_HIGHPRI workqueue directly in the user data IO
>    path is a potential filesystem livelock/deadlock vector.

Do they?  I though the whole point of WQ_HIGHPRI was that they'd
have separate rescue workers to avoid any global pool effects.

> 2. The fsverity workqueue is global - it creates a cross-filesystem
>    contention point.

How does this not affect the other file systems?

If the global workqueue is such an issue, maybe it should be addressed
in an initial series before the xfs support?


