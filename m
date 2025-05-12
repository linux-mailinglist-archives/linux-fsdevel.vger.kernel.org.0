Return-Path: <linux-fsdevel+bounces-48727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A97D5AB33B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 11:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 966A97A6FA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 09:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF82266B66;
	Mon, 12 May 2025 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGAwkov+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8193266B50
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042323; cv=none; b=fb4VMHcWOrrsWgX1wMqQqw63LkOy4kCmuVIupy17PY9Uh5ftOn3DJ/XYeC4oOZZhbnms49pfXj89f2cfTH2axFQhuz8eRkdgOHVeALr66SrZJMQPMJWxVqypNzLcGC19OYfQV89WXXrFWf1rpO2Nof21X9qC3sOLqbsXddzeYj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042323; c=relaxed/simple;
	bh=L9+do7M6jxAoMcwtUyTG7Lac6mVBmbcmnbQaXWn1YJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXL5jBCNRhsa6z9MCvA18pgzHSdKDlXWhJjcPF/e8cva1848BdkmcsPWzGJ+/PDwZTvpjU6O6S9tIzu91Yfl4UNfqDoIX5N77+S4Yna3X30dHjI/QEvZ4zGTTYOWerJQ8i3auMv8063R9ki5kcFCAJ6rhbyFrPe/FBJ2lHqjLdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGAwkov+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C5BC4CEE9;
	Mon, 12 May 2025 09:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747042323;
	bh=L9+do7M6jxAoMcwtUyTG7Lac6mVBmbcmnbQaXWn1YJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LGAwkov+x3ge3R0X2FPRcZmdEhUHHUND86TButE1+kSoxwbo0U2BgoRbALNM3wTGO
	 6rCDzOLtOz7dkRqeQLT2D325epbB6BC01dLwLD8CybL0OEG17E/Ug3E7ShN3qVwZdn
	 RXj/rqhoupp/UPk928hRVfph0UPjBda/RKj8+MUjBAKJnJ3C26qsnyJQ27Bk4jT0aE
	 N1P1+jkb7qAvsvfYuxlJaWZOwFs/VGxpEWbLU7XdxAXN25hJmfOIXrX1HI8xziYiIl
	 ah7W4WBsTgTMUxuiNqrXn4vJj49UdR9I+u5PeCQQkTnuWE6aKihFBW9h2BDXuJr0i6
	 2J1dRw1sUysBg==
Date: Mon, 12 May 2025 11:31:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] selftests/filesystems: create get_unique_mnt_id()
 helper
Message-ID: <20250512-unfair-vagabunden-c9718abcbfce@brauner>
References: <20250509133240.529330-1-amir73il@gmail.com>
 <20250509133240.529330-7-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250509133240.529330-7-amir73il@gmail.com>

On Fri, May 09, 2025 at 03:32:38PM +0200, Amir Goldstein wrote:
> Add helper to utils.c and use it in mount-notify and statmount tests.
> 
> Linking with utils.c drags in a dependecy with libcap, so add it to the
> Makefile of the tests.
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Thanks!
Reviewed-by: Christian Brauner <brauner@kernel.org>

