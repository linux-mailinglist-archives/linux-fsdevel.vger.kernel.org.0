Return-Path: <linux-fsdevel+bounces-59803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E93CFB3E158
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760A61A80C9E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C953128A8;
	Mon,  1 Sep 2025 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3m1NppH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD7242D72
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756725613; cv=none; b=e01mW5JUHM7o+IuqLUKDk3C43p4ImXVCL2BIOnb9rHiTQ8fCOXJHVUY2KcQ6Hy8znGmVcoEigHpcjVlS2Z0Q38r3e8lKtMqLKY7qvVARQv8UQ4TBoDl6W4kdBLwYZsf1LMHvdVcFNK12EtFwhgEAFEAElRR7AXb+1sZ3udva8b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756725613; c=relaxed/simple;
	bh=X1+dS7FOKGbwYXQ/LZUlQcAxlYuAaVNGKWngriBtLGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEUyNs8eXyTTXBkIhXnlFnB5tHAnijzk/ldSYxCeajbRT+esqEuxTEGu7vqIRzbIBhKxWLEesAwNyq27oyEiyCjIgBBrhlBnuwPSylInAZe+c7CWQNb52pj5SgVjyTr3Yp3+KzBj8Njb3WnjFPXOTaYK4suJPvwpyy2PozW4R68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3m1NppH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9482C4CEF0;
	Mon,  1 Sep 2025 11:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756725611;
	bh=X1+dS7FOKGbwYXQ/LZUlQcAxlYuAaVNGKWngriBtLGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e3m1NppHWOKpspVj5f2Rh5ZKXSwG7XJ6V9ZvMzq7qAUtUEB/jqFN/a7gdRfPRn2OJ
	 MKrJyWhW7OwBHGsQ/xjL3Wee74M8mutPIhQSbM2wcw1L+exIDIYaZ1nWx0r34bt74/
	 lo1IwfvuLsgr28eW1V88xLhghXtpRCQBTYuYkoYn669D4JerIyXr+WqFmWPlhw/wEj
	 zudaZEzdMKGvbbHxtPNFP8ojeqfFDh9o0cPanU2nBmH+ncm+irMtvWWvJ+v/uNwCxC
	 yBl9T7DE/HxNCAmo14F0wj/Jy/nbsDZr8t4Kw4bVLqYrlkLPhOPBRF+ZKcjqGKhoZK
	 nnxDsjb0OoLSg==
Date: Mon, 1 Sep 2025 13:20:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz
Subject: Re: [59/63] simplify the callers of mnt_unhold_writers()
Message-ID: <20250901-minigolf-anklicken-abeba1d98f05@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-61-viro@zeniv.linux.org.uk>
 <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
 <20250829001109.GB39973@ZenIV>
 <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com>
 <20250829060306.GC39973@ZenIV>
 <20250829060436.GA659926@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829060436.GA659926@ZenIV>

On Fri, Aug 29, 2025 at 07:04:36AM +0100, Al Viro wrote:
> The logics in cleanup on failure in mount_setattr_prepare() is simplified
> by having the mnt_hold_writers() failure followed by advancing m to the
> next node in the tree before leaving the loop.
> 
> And since all calls are preceded by the same check that flag has been set
> and the function is inlined, let's just shift the check into it.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

