Return-Path: <linux-fsdevel+bounces-44921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C56A6E58A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED69B3BB19D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7564C1EF099;
	Mon, 24 Mar 2025 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuQYcWJV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F2B1EE7BB;
	Mon, 24 Mar 2025 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850936; cv=none; b=rOaJxTSEqkpSuttarrqAKUF0AmMd6yYulX+UEpN/YcHGpPPJ/ItGYs+HRgEJQTuJJAXHw/0hOK2OnTp3UVvPoT8NMGf8+XNS7wRDo4zVsPFSzENtOV8nXCB5Fu0Ou10k61Y7Y//N40bs62K40b4i5d/S3PfSKQP8DoCspXmFt6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850936; c=relaxed/simple;
	bh=OnAeBGbysppJJXr0NLzsMbwqvY6T+m0Q0cW3IZZpb8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9I9jG7covVi5MWT4iXIHz6VhXvshNwYm+y3BfxmcNkS7YQcu15HpkbdYKpyiycKTnYoioVF5zMjVfihnH/S9BMS5ZKvtdPxcHR+diHSEitn0OhCY1LAkjq3QgqzM09/dSRFmY/ukClgaJdXurqt60KKN73XXS9QmHWfh8F964k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuQYcWJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819A9C4CEDD;
	Mon, 24 Mar 2025 21:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850935;
	bh=OnAeBGbysppJJXr0NLzsMbwqvY6T+m0Q0cW3IZZpb8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KuQYcWJVXUSbBDTFzOz2/2wlN2QyBUFkFnqGiFDAkCeC/YfKvMqAixJAMAD0xdjd5
	 i4C8YfXWzauygIKJWI6EyN2FWdvHFm4RtAQZ1yfX84ptIfDOIU7HzufnjKByGOjY6r
	 v8ibl2EZ6eGGfU+mhiqd5zIy4K2GOsB5CLHvqMVjIaOrw2g6e+ejPHjSuqfUhFVm/w
	 i/ieLUZQitPwvuWCHX/msBE3ls6+mzsXL9V2NDCDHrG3jufFkjh+Fz/9JDo2o5HnVP
	 DT3t+TnNXaljqvADCEo+mrJ9qHvvy7O7y+jJaE5ruf3rH3LMwL//YvhPvGy6RSL0rl
	 UzT213qrmAKgQ==
Date: Mon, 24 Mar 2025 14:15:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
 brauner@kernel.org, asml.silence@gmail.com, hch@infradead.org,
 axboe@kernel.dk, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, "David
 S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH vfs/for-next 2/3] splice: Move splice_to_socket to
 net/socket.c
Message-ID: <20250324141526.5b5b0773@kernel.org>
In-Reply-To: <20250322203558.206411-3-jdamato@fastly.com>
References: <20250322203558.206411-1-jdamato@fastly.com>
	<20250322203558.206411-3-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Mar 2025 20:35:45 +0000 Joe Damato wrote:
> Eliminate the #ifdef CONFIG_NET from fs/splice.c and move the
> splice_to_socket helper to net/socket.c, where the other splice socket
> helpers live (like sock_splice_read and sock_splice_eof).
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Matter of preference, to some extent, but FWIW:

Acked-by: Jakub Kicinski <kuba@kernel.org>

