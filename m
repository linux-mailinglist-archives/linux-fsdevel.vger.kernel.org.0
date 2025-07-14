Return-Path: <linux-fsdevel+bounces-54813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6EBB038C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 10:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD2D97A4488
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 08:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9BE2397A4;
	Mon, 14 Jul 2025 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ4rue5T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0A91F2C34;
	Mon, 14 Jul 2025 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480648; cv=none; b=jhVnTAQ8fFttCa4l7Eyd8Xdm9JcvIvjpsRZ/00kfUzWCGcqD2rBO4TLtsc1fU2YrpcdDr0k1FrZg+0PcYGGEPC5MfdYYGE4CV+T5jEWtgyi1+e4I7DUU1WjdgGXLa+C4eUpsKhsVbBPAWTb0rpq/L2v6YDcHUd28CpnOPmPTE9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480648; c=relaxed/simple;
	bh=tDNm/mgtrOBDDalZH4huEeiwlJWKLGTAqrd2deM/Af4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkHysR22yvc8IfzXI1xVrTcJTTian6NNUDyoPQEAyIFiDpMgQJf3bm22wD0nMG89vGhxLmwrUApnIO2hACyiZ9aSrwpJ7XXHDjbabSGGngVgTmg6qyIRsgE9XTOui7PqonIq+zSwVKiW/jV4nugJA4ZaCAmSS4rwWZUkx0MIu1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ4rue5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A3DC4CEED;
	Mon, 14 Jul 2025 08:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752480648;
	bh=tDNm/mgtrOBDDalZH4huEeiwlJWKLGTAqrd2deM/Af4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQ4rue5TeYhMvPmicjdY8z2eu2mRRyx8+HyhSacGwaoAs+ueCkS23g4vJY5wKE2rZ
	 jIPxqaj1JqrEPGVhkVXbhbbTQPiKl8AEdqx0CHqxmmWivDRT92SGDASWplPNiO7Qd9
	 bjFcW2SZU2Ez45i2IGCAoO1qJXpMdSB8KlfcXTTNzAZmO50nJQhOMm0TkBnO569fnT
	 Dcpm81MQgZvSoEmujKDZw+tgRYXuEAjt2hnUIvGM/Q0WLGE+3X6ZmQhLOt/1zwxmXZ
	 LuD29iV4S5/8oD2DJozUrBUSb8ZkJhVxuBYTpNkPICGJyOHeDwqV8TVOyoOPtNVSOY
	 Gzjt3gTn8ryeg==
Date: Mon, 14 Jul 2025 10:10:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Subject: Re: [PATCH] fs: warn on mount propagation in unprivileged user
 namespaces
Message-ID: <20250714-zerkratzen-untrennbar-780218a73780@brauner>
References: <20250714070556.343824-1-prabhakar.pujeri@dell.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250714070556.343824-1-prabhakar.pujeri@dell.com>

On Mon, Jul 14, 2025 at 03:05:56AM -0400, Prabhakar Pujeri wrote:
> Mount propagation operations in unprivileged user namespaces can
> bypass isolation. Add a pr_warn_once warning in mount(2) and
> mount_setattr(2) when MS_SHARED, MS_SLAVE, or MS_UNBINDABLE
> propagation flags are used without CAP_SYS_ADMIN. Document the warning
> in sharedsubtree.rst with an explanation why it is emitted and how to
> avoid it.
> ---

This doesn't make sense at all. So no, we're not going to take this.
Rejected-by: Christian Brauner <brauner@kernel.org>

