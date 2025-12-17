Return-Path: <linux-fsdevel+bounces-71569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 214A9CC80E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 15:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA6FE305871C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 14:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4691534A77E;
	Wed, 17 Dec 2025 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Nh39j5O7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F5834252F;
	Wed, 17 Dec 2025 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765978908; cv=none; b=YadvI0tGH+DDh1T1UJCOUt9LzdrB8kNgOBZFV39HUg0nS+1w2BkkzULLxMbIzlOazRJJO4Xl6Z6KEWZkAcC7Sw80fml3rrpoirbdrpe22l6EKwbk+ArA1Vh05Tz5RL4Jhygf6lOTwIN7cFViq6rB3jtDHuUgvfP5TMKUO/P9ZUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765978908; c=relaxed/simple;
	bh=w6Vg1aDGUc/4a0Xa+7zZBFvhlcmqlDjtygk5QBTRxNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDhBsI2bNZ5K27A3K1XGq7oKQxEl3XVLjQfM2uGstLUmSs9Pmk2rflkuQcCr33w/K6Iv6UmqCORPCyihxoPn3feo7lRbo3jJpzIoixYLWmjDmeR58Jv2MSlft4DI1HtOFNxxmyBMs4wAB9lY+30KRjn+sZP/kPck4w2UiITbCm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=Nh39j5O7; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=ETsLTV4d8l/8DLT+5nRiNYPm60z6FUh/BDtjYtFJRYQ=; b=Nh39j5O7oHanWQiT+uJHr+TFF9
	nPexn3pQjkrXrn1kA01MGbAfW5ikI3FptyM8LOunaypivgCNlGc2JONaHAPfnvfi061AesmNZj3iz
	Mozu2yqZCCMWbGJDLW2cek8OsH8l5YUSujMNfUs+D/trlOi4luLMsdfbbGsKktt/tyc1W7V2ix1p9
	2ZRnUh1iJmS9bo9ms/2nIfIB+xCN8BcdjgiqL2CSVKrMV8rQRuahESuiwjwHg9IaIn3w3CLb1ejbU
	5qo8JqiMYByffPPEejIyDkb7ndpZNSmbu+rRc5wtoje5rrzpmjfIDVTrqMxgGnb/42LIzXeKLB44V
	nOCftc+0Qp8nyi2H6erQYoZy4DDR0XGszPYK1A/X2GjPS0WNm3DyHC2FPWFbTf5ZAgR2Vxtlb/1+U
	Jw4CpQEo2a3Eu0BbLV0QBZUJclgqxeaVMvncptKPefVRBNzlDNxyS2+kq8MJI2PQrCoVpJgaYODvw
	HZ9X7O/BeSTAY8xDo1TUaN+aqfENwQtwSKl5mMTy0hTrCGfr5iQx7fpskSu2ayp44jTpBhNSy54K8
	xl+HUo407L/0zI7oHnf4yoYamXrpxUaZBZ8qv1JLleeI+WiJ2vc1IdwZ+hoM5VGFUb6+qXWr2rZja
	mjta8J8e3VaWJ71ABLzH4whJeVpDkVJor+roGsFTs=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, asmadeus@codewreck.org,
 Chris Arges <carges@cloudflare.com>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 David Howells <dhowells@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH] 9p/virtio: restrict page pinning to user_backed_iter() iovec
Date: Wed, 17 Dec 2025 14:41:31 +0100
Message-ID: <2332946.iZASKD2KPV@weasel>
In-Reply-To: <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
References: <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, 9 December 2025 22:04:23 CET Dominique Martinet via B4 Relay 
wrote:
> From: Dominique Martinet <asmadeus@codewreck.org>
> 
> When doing a loop mount of a filesystem over 9p, read requests can come
> from unexpected places and blow up as reported by Chris Arges with this
> reproducer:
> ```
> dd if=/dev/zero of=./xfs.img bs=1M count=300
> yes | mkfs.xfs -b size=8192 ./xfs.img
> rm -rf ./mount && mkdir -p ./mount
> mount -o loop ./xfs.img ./mount
> ```
> 
> The problem is that iov_iter_get_pages_alloc2() apparently cannot be
> called on folios (as illustrated by the backtrace below), so limit what
> iov we can pin from !iov_iter_is_kvec() to user_backed_iter()
[...] 
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index
> 10c2dd48643818907f4370243eb971fceba4d40b..f7ee1f864b03a59568510eb0dd3496bd0
> 5b3b8d6 100644 --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -318,7 +318,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
> if (!iov_iter_count(data))
>  		return 0;
> 
> -	if (!iov_iter_is_kvec(data)) {
> +	if (user_backed_iter(data)) {
>  		int n;
>  		/*
>  		 * We allow only p9_max_pages pinned. We wait for the
> 
> ---
> base-commit: 3e281113f871d7f9c69ca55a4d806a72180b7e8a
> change-id: 20251210-virtio_trans_iter-5973892db2e3

Something's seriously messed up with 9p cache right now. With today's git 
master I do get data corruption in any 9p cache mode, including cache=mmap, 
only cache=none behaves clean.

With this patch applied though it gets even worse as I can't even boot due to 
immediate 9p data corruption. Could be coincidence, as I get corruption 
without this patch in any cache mode as well, but at least I have to try much 
harder to trigger it.

Currently busy with other stuff, so could be a while before being able to 
identify the cause.

/Christian



