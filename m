Return-Path: <linux-fsdevel+bounces-51768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E14E3ADB397
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072B81891CC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAA520CCED;
	Mon, 16 Jun 2025 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0zQ8gYO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6649C1D6DB5;
	Mon, 16 Jun 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083415; cv=none; b=J3oTIi5dsllTPX1zu83QuSUI8gdM7OOZk7PhcEJWVhddpSKRKtQopzUybnbH37XTR4KzcYUwwy5YA//bNe8gs5VgZJyu3HjLI9rb0sQFdkqWxk2aV1rLTg8K+xH+G+rXl9jtYYPdiCcPhOtJt7aZdJK2zZpX8+Rjoe0U97dPigY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083415; c=relaxed/simple;
	bh=t00n8yVXDRme/+N8FmaQFvJ8h2RSMULhGuezgfvEgrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GU8C7anmjYaF/vq7SxMjoKT2VkldNqJbSe1wtmG5AMbBp9bpv1qGeTUiotUJ5yuJ4CvcIe6MjJMj7xWt+lxSWPHgSnTzuXJ+DNU1KDJhP9JioBnVuqvDepcHGJGkDaz9Fp1BaCWOcWG9NBkepuqc0p7llgvl1NXQqTaeiDxtl8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0zQ8gYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFCDC4CEEA;
	Mon, 16 Jun 2025 14:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750083415;
	bh=t00n8yVXDRme/+N8FmaQFvJ8h2RSMULhGuezgfvEgrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g0zQ8gYOkZONjpXn5uKOYx/db7VMKrCUWxVXk+WEB/Jfp26WanCW4CrZx1nOEIpaK
	 80Fg3R1v8Frj5H5iquxK98htwo6dwIGvtBLRUsfGNtJyKGV8fUGlt0+xwongZn1QTp
	 cDYBivXemQzq0uyXeF6JHAjLuJCUhRifUF+2d3taR8Lm1YC4SHZ4HK87oyUwDBWy5J
	 1MbzBzN8SjpmYwsjsoLEPzP3oIj9/ej0mIsSLppWJ1cqw1dhR6yXqvD/KFPkvdpOV3
	 anmBpWxxRTc3pJCZn+HmdZjZOIM4zPqOlek9bQ2wlIkwhBb24y5OyaaH51FY4GXHoX
	 v+ifiTa+sLqKw==
Date: Mon, 16 Jun 2025 16:16:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] apparmor: file never has NULL f_path.mnt
Message-ID: <20250616-holzlatten-biografie-94d47ed640ea@brauner>
References: <20250615003011.GD1880847@ZenIV>
 <20250615003110.GA3011112@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250615003110.GA3011112@ZenIV>

On Sun, Jun 15, 2025 at 01:31:10AM +0100, Al Viro wrote:
> [don't really care which tree that goes through; right now it's
> in viro/vfs.git #work.misc, but if somebody prefers to grab it
> through a different tree, just say so]
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

