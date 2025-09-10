Return-Path: <linux-fsdevel+bounces-60854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF409B52349
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 23:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F7B1BC1C7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 21:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CF73090E8;
	Wed, 10 Sep 2025 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEM+++Vb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A119B307AD1;
	Wed, 10 Sep 2025 21:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757538447; cv=none; b=bsUvDzW20sd3CWQi6m+fms+4FYUVa5thLaCWfE+rrYsJH8Z9caUR2d8lVIaJNRi8rmUaEGuRXZJ+b60eZZlSdyF+e0TI2gu5KIYGq7l9xMFBDicY7aY+eGra1iT/53MqObScVbSQfAWSwcrlPFzSbXwTTHwKBPSLfub97ayG9hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757538447; c=relaxed/simple;
	bh=2YPPXjuAHf0vHmGEGykxAK2OhwuGpfXNUwM3XuYu9G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDk9O0YkJkmFKlQ2DOuZpxhdjO9+i5dXsASU5l2uLp34fyaqdv1AT0O3YpDTZFH54H2Gl+Iy8KW2DDeFkt1dOBfPJMRw4/GgfM3Hy92+MfV+giSooY0ehT9451zP7AXINV6oo6sU2BfCR6+r7o1dV3Yre/zgIgbi6oWX5+SAvdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEM+++Vb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DC9C4CEEB;
	Wed, 10 Sep 2025 21:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757538447;
	bh=2YPPXjuAHf0vHmGEGykxAK2OhwuGpfXNUwM3XuYu9G4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEM+++VbIe7sTzERp//BoGoRM5iEcmtMN49JoP0Cgmc7zSUV4tcF8xuMPDwlYKMmj
	 PZ79vJAcj8RO5Nl+OUHuZtmiZQpLLC91WNfI16tWdBKIoLpwx+NM4YMmm/syrR4HKx
	 nJXCs9mAzNYYF7j3qUOqqUlI/527ifodyPnbCmQ/SepFZG8fw6qCHrFugpOsjNysTX
	 O71YlIZyqgY7tvXn8BhGhBoQvObiSaablU1y/czIrkVvtLSIIO9sy3uDTmgHntqMsy
	 rXWNsfAqQ2oQRzIZLJp47BGs3pt985N8nTBsxpgGPbtPPIuoMWTjKFtD3fqbh7+9CR
	 efXvTYSsIIGBg==
Date: Wed, 10 Sep 2025 17:07:25 -0400
From: Sasha Levin <sashal@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 14/32] net: use ns_common_init()
Message-ID: <aMHoje4qJsao2wkU@laps>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-14-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250910-work-namespace-v1-14-4dd56e7359d8@kernel.org>

On Wed, Sep 10, 2025 at 04:36:59PM +0200, Christian Brauner wrote:
>@@ -573,6 +588,7 @@ struct net *copy_net_ns(unsigned long flags,
>
> 	if (rv < 0) {
> put_userns:
>+		ns_free_inum(&net->ns);

I've ended up looking at this patch because of Jan's earlier comment about a
different issue in this patch.

Aren't we double-freeing net->ns here if setup_net() failed?

setup_net() can call ops_undo_list() on failure, which will
ns_free_inum(&net->ns) once, and then we do it again in the put_userns error
handling label.

-- 
Thanks,
Sasha

