Return-Path: <linux-fsdevel+bounces-9019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 008A683D08F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 00:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935C91F27233
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 23:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8A3134B5;
	Thu, 25 Jan 2024 23:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mmh748ud"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CE1125C8;
	Thu, 25 Jan 2024 23:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706224907; cv=none; b=XpGBGNI1vaLr5f//ijC4uZIbuODSqzgjKLX3IRfHJkhNcKKz9PlUGhNX/TXLZdueWbP52tl1yYlBQlHd8SLnRf+mCTk6F4rjN0eKMBVCByh8g4KyyydPGIqWAQYcbUU99yVksmqyAJieEO0+/kEYYePn9Abo6dwNCLDctSyNfHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706224907; c=relaxed/simple;
	bh=guOzA7K6RUgZ5DDnCdKRtRAA0JyuY3NLLW25sX22Xag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSG0rjoY2ekWMQ4ZfoeHgEUYKTzxiDWwEEpxNO7ozomI/XP8KQOmad/71+G8x9psRYpZfO69VyF0+c5O7aR4FLkApGQX2ynLBaaEeO5GFaRwyjhWhbuoC8pW6+n6X8pqo8rNEf/6TCJozEaS+0uTMJOuNsoqTt0jZqn6aCI9vSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mmh748ud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0D5C433F1;
	Thu, 25 Jan 2024 23:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706224907;
	bh=guOzA7K6RUgZ5DDnCdKRtRAA0JyuY3NLLW25sX22Xag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mmh748ud3Gbon2Ah/b3OsL3op+RJWgcz/46gD1rs+N4tL7aFMhUVtB35T6Q7ZkZLk
	 MyK6EXm41JZzMkPYFIg8S4J/tJrO6Y8wOMWcqJ3AJKkKDEXINxS8IJocZvjfXwOGkc
	 ZeIjPEfvazV/u8gDk26Xz1/ly4mTgfFP5peIqDUU=
Date: Thu, 25 Jan 2024 15:21:46 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, edumazet@google.com,
	davem@davemloft.net, alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com, kuba@kernel.org,
	willemdebruijn.kernel@gmail.com, weiwan@google.com,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Steve French <stfrench@microsoft.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jiri Slaby <jirislaby@kernel.org>,
	Julien Panis <jpanis@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Thomas Huth <thuth@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/3] eventpoll: Add epoll ioctl for
 epoll_params
Message-ID: <2024012551-anyone-demeaning-867b@gregkh>
References: <20240125225704.12781-1-jdamato@fastly.com>
 <20240125225704.12781-4-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125225704.12781-4-jdamato@fastly.com>

On Thu, Jan 25, 2024 at 10:56:59PM +0000, Joe Damato wrote:
> +struct epoll_params {
> +	u64 busy_poll_usecs;
> +	u16 busy_poll_budget;
> +
> +	/* for future fields */
> +	u8 data[118];
> +} EPOLL_PACKED;

variables that cross the user/kernel boundry need to be __u64, __u16,
and __u8 here.

And why 118?

thanks,

greg k-h

