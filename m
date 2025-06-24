Return-Path: <linux-fsdevel+bounces-52722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B01AE6049
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B3316B4EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C0027B4E1;
	Tue, 24 Jun 2025 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ju3m5l6Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D154719F480
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750756077; cv=none; b=ptSnFhLUM8iHpDuCiRZMwNms5CXsoN2ARFWJP89q0wQiS9R1y8j4VdT7fqOHucfNpIXBqq8RuIFcPSM7LcNHFVXWi8TvliYuI9t8C/ghg8g5ZPrVXXBK1jnVygNT5w8R05w9LUjmibzfMLHA+KX4eOHjH0J9xw0wj1k+VECnlVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750756077; c=relaxed/simple;
	bh=4oabjpNYgZb8M2/Nsrcq82+BVuQxgCKciQ1MlmFYIE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9uhWzBHQ2nV88qXI3lSM2GLjxamFusCEFotNShnYpeWEI+/pDmH6SL5bcJasDaqEGrAdEvLgnZ+7bH1D9hizFN4h01TjpDZ2hl1E+7JFPs9h9Ar9MMwpJvdziqLf+vxcRqznxXyRWN4Rgb0dmchD3/j1Z8fGhHqReZDJIoMgrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ju3m5l6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E85C4CEE3;
	Tue, 24 Jun 2025 09:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750756077;
	bh=4oabjpNYgZb8M2/Nsrcq82+BVuQxgCKciQ1MlmFYIE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ju3m5l6ZQyt9+dCbzHYlkPQCyayHplZ1nWNR9MxxNviigaR1ZW61LhkNsqMz+aq9K
	 ELwBnCphnek2YxX7aemWN65L+Xn/Jkq/hdLDfViiMCS07p0Jl8gb8zz0F9dHtJnMNR
	 RVINEAL6ZodERyMlJRgznqaiuiXGLiO3oYtlILdYa85u33Qn9Ho2fS59TroyleepbH
	 pNt+EQzEY3vUXuHTgA0Dok1HSlQGBLDvHCuGDrk47ImzN4/jz+8JLdk+tq/To7e6j8
	 /f9c+y7zPcVSWV/agLiX84Z6+QO3upc4wU09lVLK15r1cx2oGUOxHTcbEAu0sD/79K
	 X3e8rJflctz4g==
Date: Tue, 24 Jun 2025 11:07:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Brian Foster <bfoster@redhat.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: fix fuse_fill_write_pages() upper bound calculation
Message-ID: <20250624-damen-abtauchen-c73cdf291eef@brauner>
References: <20250614000114.910380-1-joannelkoong@gmail.com>
 <aE1VvnDfZj0oJMMv@bfoster>
 <CAJnrk1aUqLeas5n4qo7VpVn-+tgRZfBTSyhFR95TxXOzMDjKVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJnrk1aUqLeas5n4qo7VpVn-+tgRZfBTSyhFR95TxXOzMDjKVA@mail.gmail.com>

> Miklos or Christian, could this fix be added to the next release candidate?

Snatched.

