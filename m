Return-Path: <linux-fsdevel+bounces-59135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B510B34B38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 21:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD01240EDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 19:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AB8287257;
	Mon, 25 Aug 2025 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTeAa+2u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC596283FD0;
	Mon, 25 Aug 2025 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151784; cv=none; b=bVDTBN6HtM7mae+PSAhNia2T5EM+VmPRldl5dRIduJVMw5zlrzKSquJygjVzN4VUMberllnn4xWm/l5eX8q8j5C34RigBYBCNdvKFqgeX8a7cfcZpOuetfwjNY0j3LeEJig0mn2v1Q1ATod7g9sroq2cg4WYzrVf74Ne1cWOQAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151784; c=relaxed/simple;
	bh=hVscp1LYJaE3qcWw1GcbvK5mxrfCB+Tpux7lBFjeAVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxIkQV2fRbuaKCajgNgZuJ+D2sDXJX0m2a0gD2AzijB7JTMu86UU6Y7tdPpFd5ZzaVsoIbfxeoUqr/IcCQWwO4k7zF35S/d86I9D+L8TAlJGWWjvLXMy0nlLwq1au+d1OyMWbjkIgDkVErnkSC/Mc5KqbErc8mD/Mtc08HraobM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTeAa+2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2926AC113D0;
	Mon, 25 Aug 2025 19:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756151783;
	bh=hVscp1LYJaE3qcWw1GcbvK5mxrfCB+Tpux7lBFjeAVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pTeAa+2uOaISM98RRzC4Nn9WsSf6YSnwYgEVzqlFEkSipaSB9bsubD0esBLaK0qRe
	 Xoz6/+sA3FMfCp1GLgVG/1xN2OZE1Z47LrAjd7WZnqr5PSco+5OqLJFRn7C6H3Uzg/
	 lA8E6HVDHwHmLaQZmbxGbgPx8i6UneXWZbrkjXJ9omsb3Jw0NuuvTMDikSNDpE1O7O
	 GAqabyk803NyWP8+6151e+wjA1onWrEyyYy5uk/a/0Mt8VKXd+Hr7jof2Bq/TsnK/+
	 xDi0QSyWJ9lhL0yKWGVlIjq8TKkTfDNz4jv9lAieSBPXG5K4vmntqP1rPXmyLovOeC
	 TdJB5NU4zK0FA==
Date: Mon, 25 Aug 2025 15:56:21 -0400
From: Sasha Levin <sashal@kernel.org>
To: Nathan Gao <zcgao@amazon.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [REGRESSION] fs: ERR_PTR dereference in expand_files() on
 v6.12.43
Message-ID: <aKy_5bOIZwolisn2@laps>
References: <20250825152725.43133-1-zcgao@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250825152725.43133-1-zcgao@amazon.com>

On Mon, Aug 25, 2025 at 08:27:25AM -0700, Nathan Gao wrote:
>Hi,
>
>I noticed an ERR_PTR dereference issue in expand_files() on kernel 6.12.43
>when allocating large file descriptor tables. The issue occurs when
>alloc_fdtable() returns ERR_PTR(-EMFILE) for large nr input, but
>expand_fdtable() is not properly checking these error returns. dup_fd()
>seems also have the issue, missing proper ERR_PTR handling.
>
>The ERR_PTR return was introduced by d4f9351243c1 ("fs: Prevent file
>descriptor table allocations exceeding INT_MAX") which adds INT_MAX limit
>check in alloc_fdtable().

Ugh, sorry :(

>I was able to trigger this with the unshare_test selftest:
>
>[   40.283906] BUG: unable to handle page fault for address: ffffffffffffffe8
>...
>[   40.287436] RIP: 0010:expand_files+0x7e/0x1c0
>...
>[   40.366211] Kernel panic - not syncing: Fatal exception
>
>Looking at the upstream kernel, this can be addressed by Al Viro's
>fdtable series [1], which added the ERR_PTR handling in this code path.
>Perhaps backporting this series, especially 1d3b4be ("alloc_fdtable():
>change calling conventions.") would help resolve the issue.

I agree. I'll pick up. Thanks for the report!

-- 
Thanks,
Sasha

