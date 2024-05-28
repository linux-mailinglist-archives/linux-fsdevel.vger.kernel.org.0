Return-Path: <linux-fsdevel+bounces-20318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BD18D1665
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 10:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752CC284827
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 08:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E8A13C82D;
	Tue, 28 May 2024 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9UlsoCF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499B6EB64;
	Tue, 28 May 2024 08:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885516; cv=none; b=fK1678+SB27ckdZY6lLcaZQLALnn/iU5budP8Qpe02HPcUQBuhGIA7biAXClTjJq/8KQ7/VZ8B74WvqUAIzoG2KFddg5HQzyq9jQZk0KUTcrIDNB/nYd7nQaSJprs528QOOE/urBbhdqbwHguOGXuH9F5ziz9v7duq+NpeL7Yz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885516; c=relaxed/simple;
	bh=Pp1h9rKnlXC+BzTr3QzZgGdZk7UnGky0ZpYWvwodtdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFgFncxxHy5gdSBPzLu5ZhXc5vdk5jYITCfYt0MXbGK/i9cPa8CNWax4UhqejMwNDSAiyhxK9SXzaqAKEAXZZ2xNnN9TvT24e/svGP4yD8AU6uJ2xcF+7HHmzm/xq+nGNSgJQwimGmNyUb9B4lObU4B4ZwyiYbE0hizqXkYYMvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9UlsoCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E79C32781;
	Tue, 28 May 2024 08:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716885515;
	bh=Pp1h9rKnlXC+BzTr3QzZgGdZk7UnGky0ZpYWvwodtdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9UlsoCFveDXOijNN7ysl3SGOeVuvAmdhwmZ590h1U4JzkLrD1hXQK9F7g0i/9K/h
	 zWldbRoimxOPTKDupJ8fI71QoLUJKTmpk+hI3ooGNs1eknT2xgmwh9LRatComsjVe3
	 48K5vKpBGZKn84GvBjKs4QHZ/JXy0JesDITJecj51ZGlgeCrxbpvD4fqBA0UZrXR9Q
	 wYCvNYhm6UOD7a99xeGfWTD+3qiBfepeCmZkagNlHYSUJ/D3dJbN1tKn3GJH8oU5U1
	 543HYmApBJGRZK+XvOyjQoEY2UulgaCOE/p7OBpoNcw7ANc8XECxoMNANXE7N9osYz
	 RhyM5wlJVXBpA==
Date: Tue, 28 May 2024 10:38:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, winters.zc@antgroup.com
Subject: Re: [RFC 0/2] fuse: introduce fuse server recovery mechanism
Message-ID: <20240528-jucken-inkonsequent-60b0a15d7ede@brauner>
References: <20240524064030.4944-1-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240524064030.4944-1-jefflexu@linux.alibaba.com>

On Fri, May 24, 2024 at 02:40:28PM +0800, Jingbo Xu wrote:
> Background
> ==========
> The fd of '/dev/fuse' serves as a message transmission channel between
> FUSE filesystem (kernel space) and fuse server (user space). Once the
> fd gets closed (intentionally or unintentionally), the FUSE filesystem
> gets aborted, and any attempt of filesystem access gets -ECONNABORTED
> error until the FUSE filesystem finally umounted.
> 
> It is one of the requisites in production environment to provide
> uninterruptible filesystem service.  The most straightforward way, and
> maybe the most widely used way, is that make another dedicated user
> daemon (similar to systemd fdstore) keep the device fd open.  When the
> fuse daemon recovers from a crash, it can retrieve the device fd from the
> fdstore daemon through socket takeover (Unix domain socket) method [1]
> or pidfd_getfd() syscall [2].  In this way, as long as the fdstore
> daemon doesn't exit, the FUSE filesystem won't get aborted once the fuse
> daemon crashes, though the filesystem service may hang there for a while
> when the fuse daemon gets restarted and has not been completely
> recovered yet.
> 
> This picture indeed works and has been deployed in our internal
> production environment until the following issues are encountered:
> 
> 1. The fdstore daemon may be killed by mistake, in which case the FUSE
> filesystem gets aborted and irrecoverable.

That's only a problem if you use the fdstore of the per-user instance.
The main fdstore is part of PID 1 and you can't kill that. So really,
systemd needs to hand the fds from the per-user instance to the main
fdstore.

> 2. In scenarios of containerized deployment, the fuse daemon is deployed
> in a container POD, and a dedicated fdstore daemon needs to be deployed
> for each fuse daemon.  The fdstore daemon could consume a amount of
> resources (e.g. memory footprint), which is not conducive to the dense
> container deployment.
> 
> 3. Each fuse daemon implementation needs to implement its own fdstore
> daemon.  If we implement the fuse recovery mechanism on the kernel side,
> all fuse daemon implementations could reuse this mechanism.

You can just the global fdstore. That is a design limitation not an
inherent limitation.

