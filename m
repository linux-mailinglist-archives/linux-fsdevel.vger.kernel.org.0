Return-Path: <linux-fsdevel+bounces-42613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2091DA45061
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 23:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344533AA070
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 22:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE10220691;
	Tue, 25 Feb 2025 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkpT2fYU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C8021E08B;
	Tue, 25 Feb 2025 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523119; cv=none; b=B4jusS1BpQe+/2OcXjiquNDu0TC45geLn18QcXx/SRR01d+FZfuLPWp53o8QD2V7aP365wzWW13pJqcLhuVVgNUMRrOE3dGk6fV2ppLV/Wou0M2RgsDR9OR0pjetpeH0X0UoQ3Nii/x324GzXoXxfrAGm7RuKzMoOre6IkIm4jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523119; c=relaxed/simple;
	bh=KEfsxG3pYOBMY2Bdq5N8V7S+3R1Sn3rZ/1w6BmEbgLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApjLa+vbDdFSs2ejXSoZPE3r2Mj61PfY8uLxUlnoHXFBiqgrEsrx+Y6dJGeb2njask932bC+mWG0tQjzAiVhVy+y4MEi/Q/e42WtERRQLGrbHgzC+qgsK0YF8hH7o0uU0KjmBum95LztZKqC3+dttsJkvF4ATGz7sL/5lK5DzX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkpT2fYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A7FC4CEDD;
	Tue, 25 Feb 2025 22:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740523119;
	bh=KEfsxG3pYOBMY2Bdq5N8V7S+3R1Sn3rZ/1w6BmEbgLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RkpT2fYUGSKd/VcVrVx3ySPG01JzZWclTgpro0KxfF74loIbiGZcXGyCgRCbURbSa
	 rvLGw+TCK+aJIC1P/xnhSkL45pXYJa444NkoQyA5vSfs2bNDOzDT4+XlrwDERjUpqI
	 37gRIKATWveugY0T6uhWcIyFHelagudPlvCDt9kcX7Joplr+im+i+HWx6Tb0YDkLfl
	 2Fg7s/03sPmUMyg+Z3BAQYqe7rB24ocJh/g6aXeleocZ6LT/SExhbGJZmu6O0Ail72
	 +bWmwQnSDTIpGT3h0iYlRcCLM+/yys/dBBiA0BY3FU5Qhf3dh3XpplX9UkBpFvSVWP
	 yvmHQ7YlzuYCg==
Received: by pali.im (Postfix)
	id 270DA89B; Tue, 25 Feb 2025 23:38:26 +0100 (CET)
Date: Tue, 25 Feb 2025 23:38:26 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Steve French <stfrench@microsoft.com>,
	Jean-Christophe Guillain <jean-christophe@guillain.net>,
	Paulo Alcantara <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>, linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix the smb1 readv callback to correctly call netfs
Message-ID: <20250225223826.sm4445vrc56mfuwh@pali>
References: <2433838.1740522300@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2433838.1740522300@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716

On Tuesday 25 February 2025 22:25:00 David Howells wrote:
>     
> Fix cifs_readv_callback() to call netfs_read_subreq_terminated() rather
> than queuing the subrequest work item (which is unset).  Also call the
> I/O progress tracepoint.
> 
> Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use one work item")
> Reported-by: Jean-Christophe Guillain <jean-christophe@guillain.net>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219793
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <stfrench@microsoft.com>
> cc: Pali Rohár <pali@kernel.org>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org

Thanks! With this change, I cannot reproduce crash anymore.

Tested-by: Pali Rohár <pali@kernel.org>

Steve, could you please include this fix into some queue? This should be
merged into next -rc.

> ---
>  fs/smb/client/cifssmb.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
> index 6a3e287eabfa..bf9acea53ccb 100644
> --- a/fs/smb/client/cifssmb.c
> +++ b/fs/smb/client/cifssmb.c
> @@ -1338,7 +1338,8 @@ cifs_readv_callback(struct mid_q_entry *mid)
>  	rdata->credits.value = 0;
>  	rdata->subreq.error = rdata->result;
>  	rdata->subreq.transferred += rdata->got_bytes;
> -	queue_work(cifsiod_wq, &rdata->subreq.work);
> +	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
> +	netfs_read_subreq_terminated(&rdata->subreq);
>  	release_mid(mid);
>  	add_credits(server, &credits, 0);
>  }
> 

