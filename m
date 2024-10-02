Return-Path: <linux-fsdevel+bounces-30655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BDE98CCCF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 07:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244C91F2303A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 05:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF25823AF;
	Wed,  2 Oct 2024 05:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwhU8e8x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A85778C75;
	Wed,  2 Oct 2024 05:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727848785; cv=none; b=HCBCdKVQS9/+Gtsb70M2CY6OpxgIKtkpoJd2xVDo+7FP/BjBRWTGgi1MksaKBZTIdAsUumzAAt02sV2sBNUt1h6YzOUNa0LUvn3I5ig9rI9TveBeiZNsNdSHAdxTxI5Up+rMjDUsKRHbf63XNiH4Q43hkOIJeXu0T/XN/LpC5G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727848785; c=relaxed/simple;
	bh=p1GZ19giyjDwYzrq8S2W0JWuU8WzdM0xcPlL3Vo2zug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUltNaSQs2aRhgW81fjz2C+Cwb85nv1gcXIX2/AM5fuGl3gcNjMeZeeMVGm3w/FuNJpICe6vUMwFUxGeyrS6yVGbXVeOUqBZH/rVt3iBlop1w8jUt9uH8OZ7/P2p2twJpWMjMLRU0SwMXR1CX6VVQXhn4IQb0yx+YZt70LBErmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwhU8e8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2DAC4CEC5;
	Wed,  2 Oct 2024 05:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727848784;
	bh=p1GZ19giyjDwYzrq8S2W0JWuU8WzdM0xcPlL3Vo2zug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HwhU8e8xMbSUWYVKfSnOxJ92J0SBXGIky7DITgTr/WLWRQTQDU0ECIX94Latp2wpH
	 vytH81D80E9mPtDY+hoKSIrzJgJC+HszlZS1ZMFvZsXGdMM8kKYPZXuVjhyl2+6zai
	 ls1jLdfwGrxYceIbGYbHDGs0SCLjJqRFPbI51Mflutcfot6KP/dmCo25BZeNhWUzK4
	 Te32n0fSQn1gfsYYkeOv0R81b5Nz0uWL+3PqRrCyOGOJAOB+cL5mBf5Pitqxdg/tKT
	 qlgF5DKsGv8vT28yl+YeAIRhhSFVMkbthf4UQa9i0pTf3DL8exbkQePGIYtVigx65X
	 wsTCVNUyF7bhg==
Date: Wed, 2 Oct 2024 07:59:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	cgzones@googlemail.com
Subject: Re: [PATCH 6/9] replace do_getxattr() with saner helpers.
Message-ID: <20241002-pathetisch-gesammelt-10392757f05d@brauner>
References: <20241002011011.GB4017910@ZenIV>
 <20241002012230.4174585-1-viro@zeniv.linux.org.uk>
 <20241002012230.4174585-6-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002012230.4174585-6-viro@zeniv.linux.org.uk>

On Wed, Oct 02, 2024 at 02:22:27AM GMT, Al Viro wrote:
> similar to do_setxattr() in the previous commit...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

