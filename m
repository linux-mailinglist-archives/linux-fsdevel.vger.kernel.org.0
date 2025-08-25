Return-Path: <linux-fsdevel+bounces-59127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63B7B34AA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 20:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F0F2A2836
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 18:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BA327CCEE;
	Mon, 25 Aug 2025 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb2uYPi3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBE31F3FF8;
	Mon, 25 Aug 2025 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756147988; cv=none; b=R/qwH7i86GayOc8sGTOVsi0SaOfLENglcvtXMEtWWnSTpXnCRGRY4crlhE4JzzM6y+69p6hDrFtQO/lVHBLMXlxeqzNFWXZ43G2xsxpDjB3HFbpkV/bkk1K9hW4+oAtTaVqIaoD6tBsDp1+C56pc5rpO0tQStRGKQoz2hk9/dlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756147988; c=relaxed/simple;
	bh=LEW9gsFvgQr17Q8Hvz8WKHs69INOEWZ5Ig+Zk2KyLtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciSa1eUfAywdFdPV2Ri6TFiPP8C+vq4b+3QJcqXBWl+M/reLALenVcpxp4R116CoBOZYFHmDedZJOuabrnr6dmFD0pGmvDky27AQFa6so3OyUCDFhbfE4Kew3oCQ5mJokMsL6Nj6U3+YGCTPNjRZGHPIqsc6BItslSQnjhdG1Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb2uYPi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D076C4CEED;
	Mon, 25 Aug 2025 18:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756147988;
	bh=LEW9gsFvgQr17Q8Hvz8WKHs69INOEWZ5Ig+Zk2KyLtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lb2uYPi3eOLm4CsBv3EOgir97hD2gec70fzgc/UUC8EgEShwvOdx+TqoWoH5I+vSU
	 7J0r+U27tSe46fwR7OShP/BtBT5nwybHwJX2RupZSUSKL7xhLmcSuOA+A+mmzkeXtT
	 J+Crq080KBH41tinXIe+SgBIsDfgokYByiFlW2K14TxcyDtVulXENi9UoRR717CSN0
	 FlpLQ9TYYTcCPQLkLkzaRL2crTdOmVlP4mhzusombwS4zUE2sAWfin7EqyrsHqHV6w
	 Nn7Qv0yfJezlb8xsRFvxlsR5QH9MNTob2gXIN61wUZzNxBeWCfl0f5ahcWY9fdFF53
	 5VaWFk2ISjhvA==
Date: Mon, 25 Aug 2025 08:53:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, axboe@kernel.dk
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
Message-ID: <aKyxE6QOR_PtQ0mT@slm.duckdns.org>
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
 <20250820111940.4105766-4-sunjunchao@bytedance.com>
 <aKY2-sTc5qQmdea4@slm.duckdns.org>
 <CAHSKhtf--qn3TH3LFMrwqb-Nng2ABwV2gOX0PyAerd7h612X5Q@mail.gmail.com>
 <aKdQgIvZcVCJWMXl@slm.duckdns.org>
 <CAHSKhtdhj-AuApc8yw+wDNNHMRH-XNMVD=8G7Mk_=1o2FQASQg@mail.gmail.com>
 <aKds9ZMUTC8VztEt@slm.duckdns.org>
 <f1ff9656-6633-4a32-ab32-9ee60400b9b0@bytedance.com>
 <aKivUT2fSetErPMJ@slm.duckdns.org>
 <CAHSKhtc3Y-c5aoycj06V-8WwOeofXt5EHGkr4GLrU9VJt_ckmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHSKhtc3Y-c5aoycj06V-8WwOeofXt5EHGkr4GLrU9VJt_ckmw@mail.gmail.com>

Hello,

On Tue, Aug 26, 2025 at 01:45:44AM +0800, Julian Sun wrote:
...
> Sorry for having misunderstood what you meant before. I’m afraid that
> init_wait_func() cannot work the same way. Because calling
> init_wait_func() presupposes that we are preparing to wait for an
> event(like wb_wait_completion()), but waiting for such an event might
> lead to a hung task.
> 
> Please correct me if I'm wrong.

Using init_wait_func() does not require someone waiting for it. AFAICS, you
should be able to do the same thing that you did - allocating the done
entries individually and freeing them when the done count reaches zero
without anyone waiting for it. waitq doesn't really make many assumptions
about how it's used - when you call wake_up() on it, it just walks the
queued entries and invoke the callbacks there.

Thanks.

-- 
tejun

