Return-Path: <linux-fsdevel+bounces-44434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA763A68BD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 12:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEDD3B9C9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 11:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DD3253346;
	Wed, 19 Mar 2025 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OsHngClh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00320DD74;
	Wed, 19 Mar 2025 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383960; cv=none; b=i89MpDzw+7SYGAOZh/4XBAoBi7MMnWO/TKw+27K5/PzeYV91sCH+H22jHuRHRMeXcHy5bgd1uwqLge20S2yW1AQdhDomipzYUmyS+r9mRSZe/9yBVmkQizOQjOaX5chhI7eHgA3YHp6b+Z+SkjkgLZuxIkEv7fu71gQvkLM8+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383960; c=relaxed/simple;
	bh=rsdcZl7tPxTsBCcUQbKbC6lqs5sbOxWeK28KxqapY7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tAypTHsCB8gMdwf2/utEEz2DEq653VxYimzYfPuqATYG/PS3ppmt3vdcKsLora6s0lmpmSgVRlEShVqmwB8AWPUKH8R/AV5p8RFstCtJ015W3fBXEK0T2giQGAs4eVByZOO7xMHHVLWSb0ldVoyvy9jZh1e+1vb7BufMJjzQ4jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OsHngClh; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rVKvDalAIXQl6kRsl213fXAUomW+pHKUvMUcmYjOCHc=; b=OsHngClhbRN2QB3JsiB1llNiyc
	9tjxcWkFEMgK7xVr/YLLRuo/NQbbCG99W//4wQkt/bkukoqQY0L2fc8xkocPCkBVVMV5yCstmRB/l
	g/fqPHiJ7huHjSn7e9R6QrfQ3Jw8a3OYa/jx5hVFZjdx8xr7F25h1DEllgRY1Kkf4969gPndZmtB5
	VtvPVSTWBFZoYkIlniFRzZEj0LUK9m5voZlo5Z5ykyVlZgsHbuO+TJVWFhA4kDh2MqvsVNlyu9Zaw
	ednS/3sQ6Fjd8rllNXEOVMwMNDQT77T8BCgdG7LqoDonqg2v626YQn6XmksBRfwj5NSj+4ReC+SOj
	CI4x6XSQ==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1turez-003I3t-IK; Wed, 19 Mar 2025 12:32:33 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel-dev@igalia.com
Subject: Re: [PATCH] fuse: fix possible deadlock if rings are never initialized
In-Reply-To: <20250306111218.13734-1-luis@igalia.com> (Luis Henriques's
	message of "Thu, 6 Mar 2025 11:12:18 +0000")
References: <20250306111218.13734-1-luis@igalia.com>
Date: Wed, 19 Mar 2025 11:32:33 +0000
Message-ID: <874izpb6i6.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06 2025, Luis Henriques wrote:

> When mounting a user-space filesystem using io_uring, the initialization
> of the rings is done separately in the server side.  If for some reason
> (e.g. a server bug) this step is not performed it will be impossible to
> unmount the filesystem if there are already requests waiting.
>
> This issue is easily reproduced with the libfuse passthrough_ll example,
> if the queue depth is set to '0' and a request is queued before trying to
> unmount the filesystem.  When trying to force the unmount, fuse_abort_con=
n()
> will try to wake up all tasks waiting in fc->blocked_waitq, but because t=
he
> rings were never initialized, fuse_uring_ready() will never return 'true'.
>
> Fixes: 3393ff964e0f ("fuse: block request allocation until io-uring init =
is complete")
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
>  fs/fuse/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 7edceecedfa5..2fe565e9b403 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -77,7 +77,7 @@ void fuse_set_initialized(struct fuse_conn *fc)
>  static bool fuse_block_alloc(struct fuse_conn *fc, bool for_background)
>  {
>  	return !fc->initialized || (for_background && fc->blocked) ||
> -	       (fc->io_uring && !fuse_uring_ready(fc));
> +	       (fc->io_uring && fc->connected && !fuse_uring_ready(fc));
>  }
>=20=20
>  static void fuse_drop_waiting(struct fuse_conn *fc)
>

Gentle ping.  I was wondering if this would be worth picking before 6.14
is out.

Cheers,
--=20
Lu=C3=ADs

