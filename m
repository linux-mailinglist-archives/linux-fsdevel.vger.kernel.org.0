Return-Path: <linux-fsdevel+bounces-47335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF0FA9C416
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 11:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25493467D73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 09:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1847A233721;
	Fri, 25 Apr 2025 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="LKC5Cybo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE021CC62
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745574363; cv=none; b=oSAwhnqproUNO/85trgE3ODAfjUeFrU1gcHlGODkFw5BUtqIdkLF1sjJk7tc/mptNVJi10nGW0nAI4y11+Jouz2jMKkSzw/28bkOgB1zunS3DrXdZC7rPvrEstEr5VdI4m044PCLKAULj9aizbq8JURfCMrAhZ+Kjwuqq9T2+eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745574363; c=relaxed/simple;
	bh=CT6ygFwoZ8+QHtrlgVLsq1TM7iV9Rf9wWxrBNEpjQr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpQI/6bXJrTX8hCkTHvl8MbUh8+97ub1dpBXxvRyLoX93FiPGfOA4+NYjaSPBpQACDIq5HbpOQnsibd9+iU3lhH6kS3MV101npfNBdWvn5zXTplTFnku2BfFa/dPKdMEc3EKDAb4/+vsW6YDMhQzJp/noQ4tIg0vh8uIRQhzkp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=LKC5Cybo; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZkSTD2xRXz11m8;
	Fri, 25 Apr 2025 11:38:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1745573920;
	bh=k9O880SpAHDg9OTbUAzSq+ppQby6H7XkNGu6/HLa7bM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LKC5Cybo5po8VijIQ+QvCHLCTRdJSYNFkqAHhm1twb9jTuU1tLA++vqilXbaNzIMP
	 J8OrBcrcAjcimsaQMLGEm8Lm3OJLEcZTzu/g447jUHrhG2NxfE0wirwYxnBjJBNiTr
	 x4C4h6MvhFXAFSyj7G0HHR8k+BdYrKvLidPFU2tM=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZkSTC5gTDzTMn;
	Fri, 25 Apr 2025 11:38:38 +0200 (CEST)
Date: Fri, 25 Apr 2025 11:38:37 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [WTF][landlock] d_is_negative(fd_file(f)->f_path.dentry) ???
Message-ID: <20250425.aegoh9fieNoh@digikod.net>
References: <20250424220011.GJ2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424220011.GJ2023217@ZenIV>
X-Infomaniak-Routing: alpha

On Thu, Apr 24, 2025 at 11:00:11PM +0100, Al Viro wrote:
> 
> static int get_path_from_fd(const s32 fd, struct path *const path)
> {
> ...
>         if ((fd_file(f)->f_op == &ruleset_fops) ||
>             (fd_file(f)->f_path.mnt->mnt_flags & MNT_INTERNAL) ||
>             (fd_file(f)->f_path.dentry->d_sb->s_flags & SB_NOUSER) ||
>             d_is_negative(fd_file(f)->f_path.dentry) ||
>             IS_PRIVATE(d_backing_inode(fd_file(f)->f_path.dentry)))
>                 return -EBADFD;
> 
> 	Folks, could somebody explain how exactly can an opened file
> come to have a _negative_ dentry?  And if you have found a way for that
> to happen, why didn't you report the arseloads of NULL pointer dereference
> bugs that would expose, along with assorted memory corruptors, etc.?

I wasn't sure if it was possible or not (for any possible FD), and as a
preventive approach I preferred to check that before dereferencing the
inode.

> 
> 	Normally I would just quietly rip the bogus check out, but on
> the off-chance that somebody _has_ found a bug that would cause that,
> I would prefer to check with those who had added the check in the first
> place.

Thanks for the heads up.  I don't have a specific scenario in mind, feel
free to remove this check if it looks overcautious to you.

