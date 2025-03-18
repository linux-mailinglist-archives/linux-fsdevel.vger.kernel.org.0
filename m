Return-Path: <linux-fsdevel+bounces-44237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31077A666AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 04:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B163BB840
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 03:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4DD198E9B;
	Tue, 18 Mar 2025 03:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tAdtXjf4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CCF22094;
	Tue, 18 Mar 2025 03:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742267020; cv=none; b=JJBVshrjJSwcfqRgcIctsQ9fEUFzQDUFRXQwRzx0S9SSYULf4OsNEJNGCRsS7y9IdC5+wgje8L58P3rs8jejbuA90//o/vYm00LIWJ+Tuu0D+LE1pJUFRlayD/JM4uLreSdr73bB2Ve0dBPNZWdZ94aLtAkLlVDrjZVgMvNNf2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742267020; c=relaxed/simple;
	bh=o+tf22H0kP+fWEj0xzJyUcyCNlkJ7CClEUKtHNlbIYU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZplQUn2hM9kbaIIVInIQOcE9vrcVVqVrl6iuvqM35HbZBRVzhX9N7CeyUMYC7I7AC0Q4YpB5PJ2H5RDudrhItlNIKXRWzBRka+YGQofNQ/FTUZqn6189Y0LvkJRKL0aw9H/GIEjwkJX0EarAFW5qi6nubMKtEEjU56zdjFCn6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tAdtXjf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FC8C4CEE3;
	Tue, 18 Mar 2025 03:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1742267019;
	bh=o+tf22H0kP+fWEj0xzJyUcyCNlkJ7CClEUKtHNlbIYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tAdtXjf4DNGQx83LugQAfbDYv+baT02AD1KiN6eoL0uA0oGikJxKCevs1GYUYww5Z
	 MLeDZpQ9cdxLLuViqhxsmOsNb//OJ706jc00aEZTA04LkEGTl/DXLNhdthAT4wZS+9
	 8JL3LvO7M2lWPqmA9dPSjCEzpp+wVxTeLzbbE17g=
Date: Mon, 17 Mar 2025 20:03:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Liu Ye <liuyerd@163.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, willy@infradead.org,
 david@redhat.com, svetly.todorov@memverge.com, vbabka@suse.cz,
 ran.xiaokai@zte.com.cn, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 Liu Ye <liuye@kylinos.cn>
Subject: Re: [PATCH v3] fs/proc/page: Refactoring to reduce code
 duplication.
Message-Id: <20250317200338.c38679f5b7e4b67f86c58dc4@linux-foundation.org>
In-Reply-To: <20250318025138.170876-1-liuyerd@163.com>
References: <20250318025138.170876-1-liuyerd@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 10:51:38 +0800 Liu Ye <liuyerd@163.com> wrote:

> From: Liu Ye <liuye@kylinos.cn>
> 
> The function kpageflags_read and kpagecgroup_read is quite similar
> to kpagecount_read. Consider refactoring common code into a helper
> function to reduce code duplication.
> 

The code in mm.git's mm-unstable branch (and in linux-next) has changed
significantly.  Please take a look?


