Return-Path: <linux-fsdevel+bounces-16083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60665897BB3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 00:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E81A1C23D14
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 22:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E035B156227;
	Wed,  3 Apr 2024 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mrR/KpgK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50E9692FC;
	Wed,  3 Apr 2024 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712184041; cv=none; b=FAF8QBjUYw3mEcCoxRFmjA8iiwYK3jrSnBddSYcYWHrv5wIikMlZAY/jFCnUMPqI60rMinnHMjC614np9mq1xoXwPUoKRVViJhKVsmvyYmnK1o83I7k7N4SoGYoh3GeXCgjixUOT8b3acROPdO0Fn7OFV8XIUPY6MLPwxOFhjPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712184041; c=relaxed/simple;
	bh=2cgH9YR8FnnrQGdsLTiqmanJEs/UuvAQD87+LbLt1Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7EF/Qe2z3nePHpNbxGsPKIEyeMxSAw50eC8twOFQkqIQNaCA/T5rZelTuQwp7xyydsFOKwjYmaTPa8JQp+Nkf75LfhYTXmGnxeEUpw1KS2HVoibFRBr1XjpuZ1AKlRv1olDR6d6esWsHWYgwG9f7hKjYsGHQLMasSMwuhPBeDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mrR/KpgK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1npgfG17mHVKv3jerNoPzNQLvjBifSU4oBnZgQvzF3Q=; b=mrR/KpgKNoNTqz4sqN0Nn+9ZsY
	Ap/TJSW8PKvmgjMcnPB8dZ/UDddI7IXQZ6ytCqgm9pUIu+KT4ZgB2Mxqfe5EOdJTIOYtOGp4AIIsa
	MedGQAyeUII7WddxItOpkYzTFbPYipbxil6t6CDAc47N0AjPHJwWb3XPK0BTzwveZQ/Z3VpVh2udv
	J/vWCyQ6x+E6d7TdX9ImvXenVI/Mjpk4oTLZVKLB1+xauzoHCazMDKUVRZfUeHiE0+PHXTAyyXn1c
	943/ipdEMeQibPe1Kt92cTWaphC3/WSveZjHrVkGYpVxbX+I3RELlSb7XZAxk/Vc+cqz8umygicaJ
	dLHmgugQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rs9HZ-005BUP-1z;
	Wed, 03 Apr 2024 22:40:37 +0000
Date: Wed, 3 Apr 2024 23:40:37 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] timerfd: convert to ->read_iter()
Message-ID: <20240403224037.GM538574@ZenIV>
References: <20240403140446.1623931-1-axboe@kernel.dk>
 <20240403140446.1623931-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403140446.1623931-2-axboe@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Apr 03, 2024 at 08:02:52AM -0600, Jens Axboe wrote:

> -		res = put_user(ticks, (u64 __user *) buf) ? -EFAULT: sizeof(ticks);
> +		res = copy_to_iter(&ticks, sizeof(ticks), to);

Umm...  That's not an equivalent transformation - different behaviour on
short copy; try to call it via read(fd, unmapped_buffer, 8) and see what
happens.

copy_to_iter() returns the amount copied; no data copied => return 0, not -EFAULT.

> +	ufd = get_unused_fd_flags(O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS));

You do realize that get_unused_fd_flags() ignores O_RDWR (or O_NDELAY), right?
Mixing those with O_CLOEXEC makes sense for anon_inode_getfd(), but here you
have separate calls of get_unused_fd_flags() and anon_inode_getfile(), so...

