Return-Path: <linux-fsdevel+bounces-61107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00317B5541B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 17:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756E31D65C4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 15:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A89630DD35;
	Fri, 12 Sep 2025 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJORIBnl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C1A2AC17;
	Fri, 12 Sep 2025 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692136; cv=none; b=R7bXM1Xz6YM6+DI9j7nBSGDKXvCyidWEfGTb5ewTXBgL73rRPdU+2ZlHKQ+I4S/8QCscz8CYjlaAGB5EfuhA7FkxzHlWWnmWrYzZWAIgx9h/t4brEgAYAATmhKhcEkkCDeAjCkxlhNZS+SwtfwXUa/QF3KZ7BGqVYkzcGB92888=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692136; c=relaxed/simple;
	bh=w0cUq/nK2Vjcwbw3NPD5TFvhnYYDR2DsptMeDTdessw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYnBJp70vnkmp7aREtY6lVMjULT1/ELUE4n/Ux69ao0eweBVLrFr0txf5FbWd9Jdv2QrX+co6OfRGahwYz9Q7OxKqIcXq27RRVnLIt8jz3h3fR3csEgChSkqSQVzgBGMpQjNkeIhXQ+eS1fI519IDRpTURnUY/IYRCO0HSOvEk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJORIBnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C62C4CEF1;
	Fri, 12 Sep 2025 15:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757692136;
	bh=w0cUq/nK2Vjcwbw3NPD5TFvhnYYDR2DsptMeDTdessw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJORIBnlB9TgukpI9RKy50Qe4oTuv5gWn0rbT9lVf7WDqzGLlpNWaEy5Qvdml+niy
	 5RVx9x/WdLEJ/9wMaUyX4n/SD5JEZuX9tqI3jGxB6JWKjehPfKlnRjqU7qJVz9uxOQ
	 hQjngZEoCXCVayir4eXLLr4YjVNl/Rt+i9Z5zhHDQ+e0JHkCh9rrJvsL+0XEXHglfb
	 iyNDsiCR9ShsD6Xt5lIdObQbnWxjNxa17t2csmDOY277Tn6BwWCxpWIHU+EK6S0LMd
	 SL6ehHGfjXGXtBZIEASpG7Tj0wceTrZ+e0Z/SbrH1Laf7Yb3nEFzZ7qrQH/6qqIYZx
	 jWEjOG55ZFBfA==
Date: Fri, 12 Sep 2025 05:48:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 08/33] cgroup: use ns_common_init()
Message-ID: <aMRA5khPpmC03pJt@slm.duckdns.org>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-8-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-work-namespace-v2-8-1a247645cef5@kernel.org>

On Fri, Sep 12, 2025 at 01:52:31PM +0200, Christian Brauner wrote:
> Don't cargo-cult the same thing over and over.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Please feel free to route how you see fit and let me know if I should take
it.

Thanks.

-- 
tejun

