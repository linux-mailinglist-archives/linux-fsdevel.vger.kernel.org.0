Return-Path: <linux-fsdevel+bounces-25261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5696E94A553
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EAB1C20E3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B881DD3BA;
	Wed,  7 Aug 2024 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqnffUML"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967C51C823D;
	Wed,  7 Aug 2024 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026261; cv=none; b=FU7YvzgQYse56VcQuGF2uKHKC9/i0hPvbclmEi5/dIG9NNvqlZWGw+kZkW3wjrXI5yzeqbfihi4AiSd8aYy0P3BIzRdH+qWUr9CzdTjcEEAIn3MDFeNVDLake0JqrO9W7KB69ZdMZ1i1gf0vxzMIDakePSHcCC1JK/7vhkjBWdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026261; c=relaxed/simple;
	bh=E/laLQ9dMfJml/QyDxgw5H5/ZrSTkya9K7UN1EuXwE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEPMgBw3lpd6X/PoVgnitqW+2lKo+Bdv/U3qOh+dPpIVquBPUgcxian5fiDW8Lm2v1fyhKwnUih8jmjVJMS8ugfb3JfpGVzV8Kz1JO1rkUhBWOopQ1vk/eWa3LGualn6M/YHRzCudNggXiXyAkSy8KgCVE+emkpGeKoho2iE0G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqnffUML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EF7C32782;
	Wed,  7 Aug 2024 10:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723026261;
	bh=E/laLQ9dMfJml/QyDxgw5H5/ZrSTkya9K7UN1EuXwE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XqnffUMLo7vPPuATJobw7Fl1U0SbRDh1zDSPQnoUV/BDnrYoEfMGJuD8CbNQ1W7Sp
	 XHwYM4Y0+36U8jpe/4X3YswNzegRLVjZEFwPF2NrwYhUNDtvGA/r8tXYCPpPNCvlH1
	 kH2srKIK8+g5FXbNSYqEXgqudDvhyTrkL068P0l6YEgjhycl/xFOPMNzrCEKW5+2V9
	 dL/qPzG32YlxopVHFy2U/a8FBnWAiLKxZo1gu+WoL09uio4Q6gFl4WXGoEqqJUog89
	 2ur3S9r3YkE92QGLRMA7VW90w3ppjCNeQ1Grw6Z/F/ciiY9uFhiQKwqUiH51o2NIjJ
	 JSSczsuwddsAA==
Date: Wed, 7 Aug 2024 12:24:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 09/39] timerfd: switch to CLASS(fd, ...)
Message-ID: <20240807-metapher-behagen-8e3cff9321b6@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-9-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-9-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:15:55AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Fold timerfd_fget() into both callers to have fdget() and fdput() in
> the same scope.  Could be done in different ways, but this is probably
> the smallest solution.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

