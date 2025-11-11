Return-Path: <linux-fsdevel+bounces-67872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72876C4CA99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2493BAF78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B282F49F5;
	Tue, 11 Nov 2025 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYV7wo/8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EC6228CA9;
	Tue, 11 Nov 2025 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853240; cv=none; b=aCC0HBJsBRSa5jbHD4lIWw/zmitI9b/e77J1ExNuL2t7pcYRkgSJabq1Dfi4JPp85aEuKSMrmTxWOsfglZEOhi4KuklGzRe9ZmQGzmFut5/62RbCFIL1aaOP8wg3Yeys9/+56ErvMKcxsedoxoQT3FI9cTw63uaGOGD1+C8BavY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853240; c=relaxed/simple;
	bh=L65M4dF3os+W2WKpgS1o4tMupE+uWY2D8hkMGwN/YGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txsnKzrv//UyH3bOQY9fOFgahkioOVzrx9281lO4zUSj4r39qNpf7nf3LEEQ6+kpncVOQibuLGmgjXA4/Y135yWUrcJOGl/TB2h9L1UMMVb+wxV1E7PMnVoDB6p/e0xT5esLD+07Xdgq3TMVsatwXu9t9oEX6W0K7sN501DiRKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYV7wo/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA64AC4AF0E;
	Tue, 11 Nov 2025 09:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762853240;
	bh=L65M4dF3os+W2WKpgS1o4tMupE+uWY2D8hkMGwN/YGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mYV7wo/8/LzMaZ848IcdKOnkMJZIUM+xVBVatsNxOc7iEmJKvwrcTRbO9kXCIvyly
	 5JisvrnyzgThRa6MSFu209SqjhwygBNKYzDqx0ujEzQuQgAh0evDyOwi5HwrV+H0n/
	 ABNqHqZPyc4lM+XeETColisFG0JXJcuabvMbVemW78IlL6Dx20TeS+2s8LycI1ukUV
	 6gea7x2+v5gcWkD7wbWMOWon5Sb8W7/nkwUoucDXEXXS7cujl83nEHpRLMsVtqzKmx
	 HqnWwL04KPOwitj6dX3Ix8IeeTxg5O2MtNcWGicSSZBufsxbRl1cLIvovBjVKG8pgU
	 5San4pL7jr2tw==
Date: Tue, 11 Nov 2025 10:27:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] fs/nsfs: skip active ref counting for initial
 namespaces
Message-ID: <20251111-inhaftiert-observieren-b595499354e4@brauner>
References: <20251109092333.844185-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251109092333.844185-1-kartikey406@gmail.com>

On Sun, Nov 09, 2025 at 02:53:33PM +0530, Deepanshu Kartikey wrote:
> Initial namespaces are statically allocated and exist for the entire
> lifetime of the system. They should not participate in active
> reference counting.
> 
> The recent introduction of active reference counting in commit
> 3a18f809184b ("ns: add active reference count") added functions that
> unconditionally take/drop active references on all namespaces,
> including initial ones.
> 
> This causes a WARN_ON_ONCE() to trigger when a namespace file for an
> initial namespace is evicted:
> 
>   WARNING: ./include/linux/ns_common.h:314 at nsfs_evict+0x18e/0x200
> 
> The same pattern exists in nsproxy_ns_active_get() and
> nsproxy_ns_active_put() which could trigger similar warnings when
> operating on initial namespaces.
> 
> Fix by checking is_initial_namespace() before taking or dropping
> active references in:
> - nsfs_evict()
> - nsproxy_ns_active_get()
> - nsproxy_ns_active_put()
> 
> Reported-by: syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=0b2e79f91ff6579bfa5b
> Fixes: 3a18f809184b ("ns: add active reference count")
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---

This is not the way to fix it and it's not the cause of the bug.
I've sent a series that addresses this issue properly and it's already
been in next.

