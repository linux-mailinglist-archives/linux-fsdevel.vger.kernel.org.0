Return-Path: <linux-fsdevel+bounces-34622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ECD9C6CB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 11:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2635128BE08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370C91FB8B7;
	Wed, 13 Nov 2024 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnZwlSrX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BE4290F
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493207; cv=none; b=Njz9nwqX+j4jf9FJp4lT0hmnWH/8Cj6AH8lNcrETI1oYdcKI87VIZKVMLGQmWTEsPC2kOl9QfJ4cCd8yMspIsp7gIpHqKo4omAr9S/lp8bR5vc8+SKgMi7sGZVpNRZlcZFbb7SWG2rWadfDmfEHIFyeGHTvRfHrYtmVUN3Eyzwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493207; c=relaxed/simple;
	bh=ycjUzIjQpOqOFm2PJh+uigZ8iUlK1f+7EOV2eUBncJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdB9WV8r4U0T+BU/Y3QPipNs3dzU0NA1mUK6MIOV+xi2ZVeNUpcCYSi6jJUO7/NscQB4rVqC9Ytt9VyEiHNvMvXVs2FBwEfsTJHzYX8+oMx4JimhHt1aEPBRDCGMIOdjrvzfspcF6rZUDBRIsyTQp+u2My/rTL99guCbpv+pEbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnZwlSrX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A092BC4CED5;
	Wed, 13 Nov 2024 10:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731493207;
	bh=ycjUzIjQpOqOFm2PJh+uigZ8iUlK1f+7EOV2eUBncJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DnZwlSrXumvkI6BDLf/tQZpZ3AOhVoFSZc62qvzYsPSWm2kjt7zQBxEJ8/bJek+fj
	 D0CgOZk0RM9wb4a9OkUWqKlOdmOAl8N9YbrCKyUMvqFyaetCwY319zYeEwozglNObo
	 iQ6YLPfgMREctY6EL8gljOmfkBcB3lgA8473eNh3DfGMxlQsWPUrDKElZOXWjAMPQW
	 /8ipkhu53iEaedC9tpVt8/cvrej6jDcbgkYIwfPQf8SOyofRxY2uHwMVF4LgWMCR9h
	 Y0zvrvvcZpg9dNrzfDA3ps3WKTsmCrO8H5lhxiAQwl5gk5vQRm0RCdY1j9IPrA9Pfw
	 94cLQJqHb0mTQ==
Date: Wed, 13 Nov 2024 11:20:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/5] io_statx_prep(): use getname_uflags()
Message-ID: <20241113-geflattert-zyklen-bc52b7bc1b3b@brauner>
References: <20241112202118.GA3387508@ZenIV>
 <20241112202552.3393751-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112202552.3393751-1-viro@zeniv.linux.org.uk>

On Tue, Nov 12, 2024 at 08:25:48PM +0000, Al Viro wrote:
> the only thing in flags getname_flags() ever cares about is
> LOOKUP_EMPTY; anything else is none of its damn business.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

