Return-Path: <linux-fsdevel+bounces-51270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C09AD508E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0031BC003F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDD32571A0;
	Wed, 11 Jun 2025 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdMc4izm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396872AD2C
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749635448; cv=none; b=FUXmA/n/2rj3TZ/zmMGO5+cpuPwnE6PM+RMjgV0H4fHKAJUGJM2PNMsWDp4Qq4JngHblyoJTybDyxRE1dqgCPZiYxLDn5lA0pkR9LpY1vPEi0Bh0HZIn0IC4icx5jUM30aGKYWLqlrjJfK8ZgVxTnkwQHYnuepljhvg/FBOmtzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749635448; c=relaxed/simple;
	bh=S/iUmTyv6e3nV07+PfgSJeyOsteQ2MaXxUYUerw6f+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PA3ks6A7Pl+YuDY81zrzdQmqMoo/2Y0M+N8VEIVnIWKJFZujXlGkuS0b7+ky2Aug06qNcu8Z5PDWvEVSKJqTG+6a9FYWCMihM/6hv139iXWhfCpNnlkTHQqY96HBzs3Fg2T1ebOF8QdPL5OTmjRzLeWQNH+lro2iA8ksaIRIqbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdMc4izm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258EAC4CEEE;
	Wed, 11 Jun 2025 09:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749635447;
	bh=S/iUmTyv6e3nV07+PfgSJeyOsteQ2MaXxUYUerw6f+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DdMc4izmkbTKI6KcKGIMNQqu3MhjWwQ4kKpeFkAzEVd1Bdb6eWgCqaRq/7AY2b+Zk
	 yainM5KNCWS+Lm2UUTiYyfmof7S6czcqmrImR+Fu0pB+y1kDfhdwdKR4gU27nq8br6
	 LN5q/ebMP8Ljma4/j4B6GIwhAYpgBc1/sV7Ld5/ZCf7KQBoK48NhLUMWKhnmDndKv6
	 357ktC4hfMQgxX9G+Nb+AbHkUCPHGKlyMkWC9nzWHYj96kIGKGAWgaBce65W9qIOFk
	 4yH0ZFM9IDguc3qY4GbPcc5YqcrMzHdtB5aq7d7noFrzl1i+SMuadysJlS4lLvo6y8
	 D9cwkIolhj71Q==
Date: Wed, 11 Jun 2025 11:50:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, miklos@szeredi.hu, 
	neilb@suse.de, torvalds@linux-foundation.org
Subject: Re: [PATCH v2 14/21] devpts, sunrpc, hostfs: don't bother with ->d_op
Message-ID: <20250611-dissens-modem-4a2336e2f9ae@brauner>
References: <20250611075023.GJ299672@ZenIV>
 <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
 <20250611075437.4166635-14-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250611075437.4166635-14-viro@zeniv.linux.org.uk>

On Wed, Jun 11, 2025 at 08:54:30AM +0100, Al Viro wrote:
> Default ->d_op being simple_dentry_operations is equivalent to leaving
> it NULL and putting DCACHE_DONTCACHE into ->s_d_flags.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

