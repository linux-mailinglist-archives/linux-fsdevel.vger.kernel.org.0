Return-Path: <linux-fsdevel+bounces-58853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4A5B321D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 19:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A325621394
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 17:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E17299929;
	Fri, 22 Aug 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gb2Gkqf8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B652989B0;
	Fri, 22 Aug 2025 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885394; cv=none; b=KKx+beaFV4PU+AvCjuD7z/0+0kgSb8H9poGOtIJljSgYBZOlqPpe9gb+vTsU+n7iosOY4GTb75/fZcjv8FcRCUX8+Wem7aCW0BiMAYXJ/dh9uUivNvzbse0GhiPxR+MomcJpBSHUcyLN+yxiZol5CCIjQvIOA7BctEHnNpkB1OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885394; c=relaxed/simple;
	bh=k7VWYIjPAzuV20kP58e4+MtV8ncD9UUDxLstpSgppv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HD+HADA5NMatpKvYXSZ52f1hA227DSwmc2CpoLdB6TVbltlI1cfzLyb1Sy0cHFsEr5xny9BdPftHtfzwAPEjZm1NB5B5jvv3uaex0n9Kht5XPEjw1CMHTSPfpvrXJYLloQcXuJzKiwDMmSn3R97+mBF6aUuq2vLn1dKOeZBrZM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gb2Gkqf8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217D0C4CEED;
	Fri, 22 Aug 2025 17:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755885394;
	bh=k7VWYIjPAzuV20kP58e4+MtV8ncD9UUDxLstpSgppv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gb2Gkqf8MJh6iq3LqbZbGGKfdPS1/dsElaHM+WfLst/9cryyCUKwi51sMVKVPNZN3
	 Ld71rg/p+2fOt6jubauyd4geJrKs3Div7S2hsc/EZmhOTvDCsm3mEZyroTIh+j0SIr
	 YV0+hC5Vrd+oqtByeHSMSA7Un49FwS802vxCQe/4WhxjxYMCpUOMtHrYiZR5PGia53
	 XCL4md4T0KZAYHfU5IBIg8ov85Og28DHAN4fK31gPfpIvGZUhMf1FEVRhbbTo+1VFs
	 ZmQ9r6pK0TY5M+H4522JgdhxmgPD07GAmz+7MuHU9D0WBCEClO5oErqv0XvzGA9uxV
	 XLQWpp1m4s08A==
Date: Fri, 22 Aug 2025 07:56:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, axboe@kernel.dk
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
Message-ID: <aKivUT2fSetErPMJ@slm.duckdns.org>
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
 <20250820111940.4105766-4-sunjunchao@bytedance.com>
 <aKY2-sTc5qQmdea4@slm.duckdns.org>
 <CAHSKhtf--qn3TH3LFMrwqb-Nng2ABwV2gOX0PyAerd7h612X5Q@mail.gmail.com>
 <aKdQgIvZcVCJWMXl@slm.duckdns.org>
 <CAHSKhtdhj-AuApc8yw+wDNNHMRH-XNMVD=8G7Mk_=1o2FQASQg@mail.gmail.com>
 <aKds9ZMUTC8VztEt@slm.duckdns.org>
 <f1ff9656-6633-4a32-ab32-9ee60400b9b0@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1ff9656-6633-4a32-ab32-9ee60400b9b0@bytedance.com>

Hello,

On Fri, Aug 22, 2025 at 04:22:09PM +0800, Julian Sun wrote:
> +struct wb_wait_queue_head {
> +	wait_queue_head_t waitq;
> +	wb_wait_wakeup_func_t wb_wakeup_func;
> +};

wait_queue_head_t itself already allows overriding the wakeup function.
Please look for init_wait_func() usages in the tree. Hopefully, that should
contain the changes within memcg.

Thanks.

-- 
tejun

