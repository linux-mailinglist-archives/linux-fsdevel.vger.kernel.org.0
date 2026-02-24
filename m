Return-Path: <linux-fsdevel+bounces-78237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHWrFP95nWmAQAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 11:14:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E68351852E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 11:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43BC630B39DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 10:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D19F376BF2;
	Tue, 24 Feb 2026 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYW3umej"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C84B29AB05;
	Tue, 24 Feb 2026 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927814; cv=none; b=N2DVO+3vkp+fmOR5ekqwjVNwyP0eY2XknIFaJzLlrHkA5G3OO5eWEJTuAACAuQcIRc5r7tCXuNk3qg+KoClFHj4U5Iuf59vutddOzyyKrta/0oOaQYEug2lZ65oEM296yf+Ac3Z/Ho8G8mBMCM3domhb3ZLuFLpTWOJXLFOFtEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927814; c=relaxed/simple;
	bh=Z97oeCqMuGbvSy3Be3opMeaqqrYJfEPzbPgkH8q779M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8jjTM0gWfe/RK57YW4cKojOUNuf3v+9eTfA3YH334v9/yXIJyy1Po9hPmMaA7ktIp/N0s82mjKS63+HnGMJprMrBVogzTKHI9iPJxQhRgw4SPhIn8ZbyM1u8rZ7exx/zLqapSvgIKD4fVCi3y4lvE2JMO3xfZKUcK9UOpTHJYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYW3umej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BEBC116D0;
	Tue, 24 Feb 2026 10:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771927814;
	bh=Z97oeCqMuGbvSy3Be3opMeaqqrYJfEPzbPgkH8q779M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MYW3umej0heWTRwmXdbzk6ZnjNQ6RxMKF4GzL9W/96Wv7kKXRi8rU697Xs4yKQALB
	 lRfH8g+z+KW32PKgMxT0rreWx4Z1zw8e+l3sea9GjU5UWmdswWEyWrpoQWVOEdN9jo
	 QZ+E5n6J9aLtP69OKws2bKZ3zqoV7oKuzoBDdjYVQUW4RtpB9IBVtBqRq7v45lTc5n
	 iwLhxex7lcqaQ5WpOL9CaEuTfFXWLooGz9lLY2lOKLjdFvumgjHSzr4wj8j03YWwN7
	 x4t0hND+F7AM0uA9RT3De5jMQnhh4+QEiEeH+cuG5aOfFlL0CMZCfYsq/iXqp/1ZKi
	 jHb16fRqdMvvA==
Date: Tue, 24 Feb 2026 11:10:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, chuck.lever@oracle.com, 
	alex.aring@gmail.com, viro@zeniv.linux.org.uk, jack@suse.cz, arnd@arndb.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] Add support for empty path in openat and openat2 syscalls
Message-ID: <20260224-karotten-wegnimmt-79410ef99aeb@brauner>
References: <20260223151652.582048-1-jkoolstra@xs4all.nl>
 <44a2111e33631d78aded73e4b79908db6237227f.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44a2111e33631d78aded73e4b79908db6237227f.camel@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78237-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[xs4all.nl,oracle.com,gmail.com,zeniv.linux.org.uk,suse.cz,arndb.de,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.826];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E68351852E4
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 10:28:24AM -0500, Jeff Layton wrote:
> On Mon, 2026-02-23 at 16:16 +0100, Jori Koolstra wrote:
> > To get an operable version of an O_PATH file descriptors, it is possible
> > to use openat(fd, ".", O_DIRECTORY) for directories, but other files
> > currently require going through open("/proc/<pid>/fd/<nr>") which
> > depends on a functioning procfs.
> > 
> > This patch adds the O_EMPTY_PATH flag to openat and openat2. If passed
> > LOOKUP_EMPTY is set at path resolve time.
> > 
> 
> This sounds valuable, but there was recent discussion around the
> O_REGULAR flag that said that we shouldn't be adding new flags to older
> syscalls [1]. Should this only be an OPENAT2_* flag instead?
> 
> [1]: https://lore.kernel.org/linux-fsdevel/20260129-siebzehn-adler-efe74ff8f1a9@brauner/

I do like restricting it to openat2() as well.

