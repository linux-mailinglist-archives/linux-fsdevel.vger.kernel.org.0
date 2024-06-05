Return-Path: <linux-fsdevel+bounces-21042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD738FD0F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 16:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5BFCB232AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 14:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EA9199A2;
	Wed,  5 Jun 2024 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUV/YdLe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04C823D7
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2024 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717597567; cv=none; b=mDpQp+aaamLlsQuqPwaQ+ZlijffoPQVNSJ4yPQ/DI9fn1TFK6hg+4HCgkL2IuyiCdVzrNG04sJrKqLi3hnXxvNX+/GV6q+3himm1n5+HsuV3nnOTukeuSaijBy1PEdhPNsoWepE1WcLNjdOVbEzKXqT5K/mIVPrtzCGY4z0f+Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717597567; c=relaxed/simple;
	bh=Rnd+J3xJqSW6X4/piLjGNx5ZpjoeEIrTFgxDNqHCRDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4TjF0RiTX6INCQVoa49zX7HMmkve5QAZAsrIx3fWM4wvWeTVjRDcLWfKc+fhkf80H8CZkSj4gi6mkWH+Ex+us0uJz5b3LpkhwB6/trBkTHrFGhzyEoFi85U36qrg4+dEVncZU6Gu2pDxFH6C88FA10U+XMoKv6RKpAzqYxphyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUV/YdLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFF7C2BD11;
	Wed,  5 Jun 2024 14:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717597567;
	bh=Rnd+J3xJqSW6X4/piLjGNx5ZpjoeEIrTFgxDNqHCRDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUV/YdLeG0nVA7A0s42gFHcuBV8YpFwcjJLjAFohL8T5EksYLi2x38UAMWnV5QgU3
	 qHOXafhcWYzqXDdmGvXlIbW4555Bw1Ge0wQIID86W0Ez3DRPl3NlGX8QNnNp3csxBa
	 30A7hFReO09+ET35b2/UvM3l8slJSKWyJt/TviBOgxX9Nl+CjKF8swySBkSv/SMyr6
	 sRsMw9DbXQKlTtegs7OxjkUZo3SE5GeO+vulWGgECzr7cU2M0W8U6WuKph42qew4Az
	 ybxmoyDRgxycZM5GX7nGZSi8xounIdTtntl6LHWfBr486kG9T2qCCKbKftTLNwBm1P
	 nPIMYt7exvm+g==
Date: Wed, 5 Jun 2024 16:26:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ivan Babrou <ivan@cloudflare.com>, linux-fsdevel@vger.kernel.org, 
	kernel-team <kernel-team@cloudflare.com>
Subject: Re: why does proc_fd_getattr() bother with S_ISDIR(inode->i_mode)?
Message-ID: <20240605-blutzellen-vierbeinig-3e438a13e001@brauner>
References: <20240604034051.GP1629371@ZenIV>
 <CABWYdi0KTJVsuEokmUF+fQ6w9orGNeaJLyjni0E8T+A0-FHe7g@mail.gmail.com>
 <20240604174059.GQ1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240604174059.GQ1629371@ZenIV>

On Tue, Jun 04, 2024 at 06:40:59PM +0100, Al Viro wrote:
> On Tue, Jun 04, 2024 at 10:35:43AM -0700, Ivan Babrou wrote:
> > On Mon, Jun 3, 2024 at 8:40 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > >         ... when the only way to get to it is via ->getattr() in
> > > proc_fd_inode_operations?  Note that proc_fd_inode_operations
> > > has ->lookup() in it; it _can't_ be ->i_op of a non-directory.
> > >
> > >         Am I missing something here?
> > 
> > It's been two years, but I think I was just extra cautious.
> 
> Does anyone have objections against the following?
> 
> [PATCH] proc_fd_getattr(): don't bother with S_ISDIR() check
>     
> that thing is callable only as ->i_op->getattr() instance and only
> for directory inodes (/proc/*/fd and /proc/*/task/*/fd)
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Kill it,
Reviewed-by: Christian Brauner <brauner@kernel.org>

