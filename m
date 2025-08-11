Return-Path: <linux-fsdevel+bounces-57405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0C6B213B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 19:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C14C34E37B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 17:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCCB2D6E54;
	Mon, 11 Aug 2025 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwDDFWEn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B712D6E40;
	Mon, 11 Aug 2025 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934689; cv=none; b=V8QjgMQCi+WaRpQg4lZWSh/Nipl82NQgZs1gApBy5cI6b7vZsoJolW4VhXrvBuO84OxRb6VIYXrsYPakG+8iSZIWiS+upsDSzc2EUgpeIA9oGAb9DLtEtpCWINlByac2/pdpuEFpVjzDRavG2as1KSCqJjui6QfqR/g6tPmTWz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934689; c=relaxed/simple;
	bh=jUDKUC55/ByDGIJqIA62x2PDfSmedYhIlXa/WxG9+xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cg9rleOXpEyLOXRF+snb27mdVLNPLlHL6h+wc6FTHFbN2jW1Jwwtr5Q1Swjca7j7BGQPxkOGwjAHfY/uCpW+KX4hTtHX9KT5/w/sU/ewUTqhY/iurIHDYNhDsHd+VtYswdKmjYFHWA2kV15zxRnxX2qwSqIP5rTLfXYfmfVR5mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwDDFWEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DD5C4CEED;
	Mon, 11 Aug 2025 17:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754934688;
	bh=jUDKUC55/ByDGIJqIA62x2PDfSmedYhIlXa/WxG9+xY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RwDDFWEnS36tkphynxs54ndKSNk+KE+GFn6j1hqfG6LyxFneYRU8YKmlxC1aCOexj
	 +J+4DodytZelYW+7LpRQt2Ze9RHQardqYU3+MrD+lP1V+R1lZdVVgtBgNVoKWwVO+k
	 FhLvmOQ8lyZtW2Qpf3fwaNa64pzAXgeO9mCBf5OGpjCmpNr+vilZPwkaF0DcnqQ3Rf
	 gRH1CffV0vn69F/RrvV0auCZTWX1BT2PfXWqDFXVkqNSIpb4iqeDw1QlxI89uR1/ol
	 ixBn86Wy1b8PUcN2NGuSN+qcwDp4mAIqkBbI4ZcCA1cksE8+9hScjxXhPMjX8ZdZMQ
	 o0VDL6XwunyUw==
Date: Mon, 11 Aug 2025 07:51:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	david@fromorbit.com, djwong@kernel.org, ebiggers@kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 04/29] fsverity: add per-sb workqueue for post read
 processing
Message-ID: <aJotnxPj_OXkrc42@slm.duckdns.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-4-9e5443af0e34@kernel.org>
 <20250811114519.GA8969@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811114519.GA8969@lst.de>

Hello,

On Mon, Aug 11, 2025 at 01:45:19PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 28, 2025 at 10:30:08PM +0200, Andrey Albershteyn wrote:
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> > 
> > For XFS, fsverity's global workqueue is not really suitable due to:
> > 
> > 1. High priority workqueues are used within XFS to ensure that data
> >    IO completion cannot stall processing of journal IO completions.
> >    Hence using a WQ_HIGHPRI workqueue directly in the user data IO
> >    path is a potential filesystem livelock/deadlock vector.
> 
> Do they?  I though the whole point of WQ_HIGHPRI was that they'd
> have separate rescue workers to avoid any global pool effects.

HIGHPRI and MEM_RECLAIM are orthogonal. HIGHPRI makes the workqueue use
worker pools with high priority, so all work items would execute at MIN_NICE
(-20). Hmm... actually, rescuer doesn't set priority according to the
workqueue's, which seems buggy.

Thanks.

-- 
tejun

