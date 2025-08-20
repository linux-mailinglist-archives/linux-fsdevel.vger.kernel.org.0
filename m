Return-Path: <linux-fsdevel+bounces-58407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AC6B2E70F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 22:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30E2A25A33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 20:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C192D6E60;
	Wed, 20 Aug 2025 20:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nnk9QIhB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06C5287266;
	Wed, 20 Aug 2025 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723518; cv=none; b=Y+tTJm1a61KioddDveeUEGcLjpi9EN4qZ062QoYylhDC1bXKDjNY+edse/2Zyhd1815MZAUuSV/goA//hvwt3Iak+HAqosfD5vgbl4Q7QbPyXOdP6tmm18O5NJEyaNLqVxmMrYVYK0SvvbiEs0mGNbOag/8scdm3FtWCsDdCkhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723518; c=relaxed/simple;
	bh=2LIlV6jZV84iq2Ygc/m4ROJTKmC2fI48srPWv9QJ338=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gm+qutY24T3vi7ZsD5Yc7VC3XxQWUAn2n2X2hWej6f6q5V7dL0Hqg833WG5TUYB+Z1SMnGs4WAkigpsVO7LMYkLVboxWVT/MV/jPYdonj1VtoR5d8ESVrAiAAYfzzibE35PzHPLjV4yW+ZiU8a2gjKGFo5Az+UUX9UORKiJ7BhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nnk9QIhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8E8C4CEE7;
	Wed, 20 Aug 2025 20:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755723515;
	bh=2LIlV6jZV84iq2Ygc/m4ROJTKmC2fI48srPWv9QJ338=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nnk9QIhBnunV2dusAtIYAOEhwvRBZyAphZf+rtRSzXmJSWWPbKeBm3PLl4iA8Qn/S
	 jLHsDOtIWncKkY+QQpPBCNotmtZNXKOrBoxYcLtmCmhGpcueAWX/kdiXitgzL+SRai
	 lQ9EdWw4kelLR8kUHZFf0RZKwLdghw2g3H3TeGNo9AuMQ8Nai4cJXllnoSM1A7yZr9
	 KSTvl+vujY46+GQ8TokMD+2+cFexCY675+8WYcW5lfEEYLnNPbAaJHnHKeFOezwquD
	 b2ENPWE54KW6Go5aJl/h8F7X+VRlrRRXstz0GZEuOSJxVQrxyiVxrZJmchoBPGmDUn
	 rT9qIQbg9SavQ==
Date: Wed, 20 Aug 2025 10:58:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, axboe@kernel.dk
Subject: Re: [PATCH] memcg: Don't wait writeback completion when release
 memcg.
Message-ID: <aKY2-sTc5qQmdea4@slm.duckdns.org>
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
 <20250820111940.4105766-4-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820111940.4105766-4-sunjunchao@bytedance.com>

On Wed, Aug 20, 2025 at 07:19:40PM +0800, Julian Sun wrote:
> @@ -3912,8 +3921,12 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
>  	int __maybe_unused i;
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
> -	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
> -		wb_wait_for_completion(&memcg->cgwb_frn[i].done);
> +	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
> +		struct wb_completion *done = memcg->cgwb_frn[i].done;
> +
> +		if (atomic_dec_and_test(&done->cnt))
> +			kfree(done);
> +	}
>  #endif

Can't you just remove done? I don't think it's doing anything after your
changes anyway.

Thanks.

-- 
tejun

