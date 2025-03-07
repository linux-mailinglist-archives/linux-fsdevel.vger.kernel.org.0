Return-Path: <linux-fsdevel+bounces-43493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F42A57574
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 23:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637641794AF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35C5258CED;
	Fri,  7 Mar 2025 22:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/Pgk9Bx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A929F258CCE
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 22:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741388092; cv=none; b=eZblZzXdtnhVnCmJCRt2L9v5mJRIIcppWrrB5c6BOYPJCMOp08+q8n8JAF/c340T1a8+8J/tWWmFpVWu48Ntt/ILB943RgT5o04oR9Nl5B+U2IupiaWMSEFFGgSp+XIDR+M4zDjoawSpTfWga2Qb24XJDZ6mbu180YRTRdmNku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741388092; c=relaxed/simple;
	bh=BSi+jLpfi6FKVIOnGVr3DA17x8MXb/n0b1fUUm36580=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx2OCwTtvfov2XIrMEeduKuCw+D2FO+juOlOoz7rCqQ5L30U/fEB+Vmfd2AtTw8W6os0LWiHUZpQlZGv9zOelzEIGUz5QbTdogZTQhqixJRj8lb+bDG7AG9e6M7xDAOLN3RVdYXnXWxWI0dtt017dl5pi4TqqXW2s2OsKVjc0rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/Pgk9Bx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741388089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kHIQmI/H5roYn1gRZhaXUiNd6lXGJi2nFrmnslq5uRk=;
	b=O/Pgk9BxLPiY2T5eCpU6xrOdpHZ+JXa+vWrmVqWOSzw3uDbm/mbh4/mufz+jS8f957WpPf
	2cdvm5VJ7tHOOhO/zmhmTFoYq+RdZ+u3OM0TZnqbU/FUX9qTHB23eBfaB7UkSb7tzqCq+u
	ySS/qsgrHTycPqYIrJJdqRE9LZlmNx4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-8M6qQ5JoOoyZcIglVOWZ8A-1; Fri,
 07 Mar 2025 17:54:45 -0500
X-MC-Unique: 8M6qQ5JoOoyZcIglVOWZ8A-1
X-Mimecast-MFC-AGG-ID: 8M6qQ5JoOoyZcIglVOWZ8A_1741388084
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D807B1956083;
	Fri,  7 Mar 2025 22:54:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6A85618009BC;
	Fri,  7 Mar 2025 22:54:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  7 Mar 2025 23:54:12 +0100 (CET)
Date: Fri, 7 Mar 2025 23:54:08 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/pipe.c: merge if statements with identical conditions
Message-ID: <20250307225408.GC28762@redhat.com>
References: <20250307222500.1117662-1-linux@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307222500.1117662-1-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/07, Rasmus Villemoes wrote:
>
> As 'head' is not updated after head+1 is assigned to pipe->head, the
> condition being tested here is exactly the same as in the big if
> statement just above. Merge the two bodies.

Yes.

But Mateusz has already sent the same patch, please see

	[PATCH 1/3] pipe: drop an always true check in anon_pipe_write()
	https://lore.kernel.org/all/20250303230409.452687-2-mjguzik@gmail.com/

Oleg.

> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  fs/pipe.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 097400cce241..27385e3e5417 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -547,10 +547,8 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
>
>  			if (!iov_iter_count(from))
>  				break;
> -		}
> -
> -		if (!pipe_full(head, pipe->tail, pipe->max_usage))
>  			continue;
> +		}
>
>  		/* Wait for buffer space to become available. */
>  		if ((filp->f_flags & O_NONBLOCK) ||
> --
> 2.48.1
>


