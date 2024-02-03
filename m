Return-Path: <linux-fsdevel+bounces-10190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2752684880F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 18:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD2C5B238B8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 17:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD6F5FDC2;
	Sat,  3 Feb 2024 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="KCVs/tCY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057785FBB4
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Feb 2024 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706983049; cv=none; b=D6VEVWjMZWqcOmMKfLW88Uti1aLHHBCLS4ztLu8jeSUicfXpT14+7FMt7EutmW74ToQNjC5ZIGJwm0NW6zlIDtNR0Q//+0fX7qnQ11h+xBn9Ip8AG6qSVN40/PovmoKwz8yqdBGemnh65rHs1PpnfeIWTHZ6WpN3LvBQUwGmpiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706983049; c=relaxed/simple;
	bh=Yj5aDDXTM+qpJNjCB3RU5HxCJC5EPb3NxOhYz32dNII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX6nXq1XLPQmqmhIo/MI6LFZNGh7SIc61ZkFpHVetKAJloaxXk9gzXW8bJUXLuLmPrD2JrLVviGc+k0RkvgBuMiLzYdE97NAhfwd8cejlalrUw5xdZdAfouWcr6yH61ZYz9V43nePZddffifziWQVrGo2GTQb6njuAf63Ss4GNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=KCVs/tCY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-236.bstnma.fios.verizon.net [173.48.82.236])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 413HueK6016816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Feb 2024 12:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706983003; bh=l4Qu1q6RKuEeOxA7OnxAR5gXRKkLwV3d96mBPvSYLxs=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=KCVs/tCYcG6FASwSKeCTJN/GaIweqiatqM26tedyHRNWr5Nm9ZsMPGptGJVxCHr6y
	 7nDV5tQBtR44r1e3VUwyHuQB6DYTXp5Qn49NpINbg2AJLeNdzz6G7+woFfRsZs+Gjq
	 GDWmNAko6C4hatS0ECCdVPOXhrl8ajdZ+RChykF3ccqMZiO2/wCkYGwM5Mu39KkSaT
	 CIuZmq2cWaoZ+wBMBv/xW3dOMH5YppG14JbOeOqJLRAFVYPmvCLLxBm9z3y4eWn7Rm
	 DBepFE7ZnAUR6Vn4c3mIOYTlsudCwhT5Bz/EaF0WRUUT5gPjzbiKoHi4GqPRlCUleO
	 XBiUTtmml9rvw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 0349C15C02FC; Sat,  3 Feb 2024 12:56:40 -0500 (EST)
Date: Sat, 3 Feb 2024 12:56:39 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        hch@infradead.org, djwong@kernel.org, willy@infradead.org,
        zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v3 03/26] ext4: correct the hole length returned by
 ext4_map_blocks()
Message-ID: <20240203175639.GF36616@mit.edu>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127015825.1608160-4-yi.zhang@huaweicloud.com>

On Sat, Jan 27, 2024 at 09:58:02AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> In ext4_map_blocks(), if we can't find a range of mapping in the
> extents cache, we are calling ext4_ext_map_blocks() to search the real
> path and ext4_ext_determine_hole() to determine the hole range. But if
> the querying range was partially or completely overlaped by a delalloc
> extent, we can't find it in the real extent path, so the returned hole
> length could be incorrect.
> 
> Fortunately, ext4_ext_put_gap_in_cache() have already handle delalloc
> extent, but it searches start from the expanded hole_start, doesn't
> start from the querying range, so the delalloc extent found could not be
> the one that overlaped the querying range, plus, it also didn't adjust
> the hole length. Let's just remove ext4_ext_put_gap_in_cache(), handle
> delalloc and insert adjusted hole extent in ext4_ext_determine_hole().
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Suggested-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted

