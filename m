Return-Path: <linux-fsdevel+bounces-61336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BDCB579C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3075202D56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67624304BD0;
	Mon, 15 Sep 2025 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8h370fL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67883019C8
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937793; cv=none; b=W3tWbVFg3bKw9kZdNIUa8vVSLpoUE9ZLOOXCdgyq2seOgEuz4QgZXzf8Qp8MkunFwVN21DV18b6dB0U6zsLyFQWOIhFryqAfxwNRQOTiZ28To0RkM3QDD+8DGjG4v9+Sr92KY1yX4ZDnPIst3DAGSc8n+fB3HsD9uUhrGZNO9AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937793; c=relaxed/simple;
	bh=QbF5wwH3RrRzvaeirGJCLz3IlAjE40cC1RtoNOavAGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgQiKvFHInE6b4fgfMW89rXukeiKKlE9tP88bhmpY+L/XWiykQ/AxwpRqT9qWqEIxY9BHxqMpfr9n4F/aR1L2Pw9zLQmuTivDnx73+9BZtrtWtGx980yD1Qbr1ArOg8btjD7R8dcHeseKL3LCrThVqhB003TV4f//QHda5Wl1pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8h370fL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31AEC4CEF5;
	Mon, 15 Sep 2025 12:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937793;
	bh=QbF5wwH3RrRzvaeirGJCLz3IlAjE40cC1RtoNOavAGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F8h370fLpBRtRAfdffh+uJLh9L98fH1pd0nHLdvS5CsdK+SNGc1+IzciSrsng/sHW
	 NyY5y/InCT+OsQumvjG80Ngxh+s/OUiHYUUlgKSe2FCqobe5HtS0M4ldOwVtEBOXkU
	 kJjtxvXGkjvhOmDFtFlb1revcFygkzLV97ER7fWmswK0YqgilBXnhKJATUvVoUc9/t
	 nPQ5Ry/rojlyp/Kvh1e2g40gFV2xhClidNgv7z5MtnmTyj6F5OK73SF7N2AHjc7L2H
	 VILnYEtlw/NvNFdTv1LCHT1VaN4VgpGXS8+g0H9tC6GLZLLSM0X9tGIPno/tbMChD0
	 Q8aEQ7LKYwORA==
Date: Mon, 15 Sep 2025 14:03:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 08/21] export_operations->open(): constify path argument
Message-ID: <20250915-sardinen-nachmachen-e3c60cf9be24@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-8-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-8-viro@zeniv.linux.org.uk>

On Sat, Sep 06, 2025 at 10:11:24AM +0100, Al Viro wrote:
> for the method and its sole instance...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

