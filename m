Return-Path: <linux-fsdevel+bounces-32542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2189A9464
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 01:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674D2283F15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 23:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9CF1E8829;
	Mon, 21 Oct 2024 23:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="GXpKyRlG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A441E6325;
	Mon, 21 Oct 2024 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729554819; cv=none; b=eCRRIvzsEVbwL4Vm11XW8hBSMzKpIAPxyMgNyE/fc7Fx5wMyVnQLWQr7SAKn7E9yg3wIRABifdLC6QL1BL6pqWJSMWrjCm6j1+rERCeiojJb5xzlpm2K3k6+tQ32WXf/OI0D9VhYxBLumbRcCS/AXECqv1JTqPn/fNJQWbIFYiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729554819; c=relaxed/simple;
	bh=tFRu6EMylPp3LvWlxOVcpIx8tqErVAbtF+BDXGrKeFs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAtZhj1yV2gw8HsC9wMtrCeKgX2g5z9gbhBr/nOWjfT75KxQVmCuKVgmhxpp7J/D26iMZUXMnAKYa5JnRBI59xPoBLTWymlo1aJjJtTW3zPt1IBf5QtdFEB5l20L2nlAzRgETlFw6qHCkR7dzzM4FdobU+rc8GINTgSTdzMLW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=GXpKyRlG; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id EEE1F20820;
	Tue, 22 Oct 2024 01:53:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H3eHxTkhD1Aq; Tue, 22 Oct 2024 01:53:34 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 4B269206B0;
	Tue, 22 Oct 2024 01:53:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4B269206B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1729554814;
	bh=4oO/CO1S7FHDO6oDhvZ6wAucF3SqIDF1wHi005tQZjg=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=GXpKyRlGqvFxZDeYVNHJVNH7HsQ9/2IvOMe3Fv7yFvWz5glP/+7n53h9L07zwt7H0
	 Cl0NDxEcUI1rQj6FZa2upn5ARPUqQ2Tb68tVcnNIvkjP73kQjBOMBCNe3aOy0R3RKk
	 aaXIpi1iDw9fMTtbEv0fDTNTwfbAKpLG3StHPKQz3ftbPW8s6THy3FfVHdGwRQecXc
	 0l/ONEwHW7su2fZCftYGMaCcZHWcLg39TVsJMT6VYNyxsfQu7+DjmPurmWExOyX1sn
	 hOacj5DWZaUp12WzQf9Ty1TPjVc9PBsUeLSZceqwbkT0vxQaq9eZ8mC+6CGOSEq7ua
	 KOFwewkYkb2ig==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 01:53:34 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 01:53:33 +0200
Date: Tue, 22 Oct 2024 01:53:26 +0200
From: Antony Antony <antony.antony@secunet.com>
To: David Howells <dhowells@redhat.com>
CC: Antony Antony <antony@phenome.org>, Sedat Dilek <sedat.dilek@gmail.com>,
	Maximilian Bosch <maximilian@mbosch.me>, Linux regressions mailing list
	<regressions@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] 9p: Don't revert the I/O iterator after reading
Message-ID: <ZxbpdnA4jR7IYhRH@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <ZxFQw4OI9rrc7UYc@Antony2201.local>
 <D4LHHUNLG79Y.12PI0X6BEHRHW@mbosch.me>
 <c3eff232-7db4-4e89-af2c-f992f00cd043@leemhuis.info>
 <D4LNG4ZHZM5X.1STBTSTM9LN6E@mbosch.me>
 <CA+icZUVkVcKw+wN1p10zLHpO5gqkpzDU6nH46Nna4qaws_Q5iA@mail.gmail.com>
 <2299159.1729543103@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2299159.1729543103@warthog.procyon.org.uk>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hi David,

On Mon, Oct 21, 2024 at 21:38:23 +0100, David Howells wrote:
> Hi Antony,
> 
> I think I may have a fix already lurking on my netfs-writeback branch for the
> next merge window.  Can you try the attached?

yes. The fix works. I rebooted a few times and no crash.

Tested-by: Antony Antony <antony.antony@secunet.com>

I am running test script in a loop over night. 

thanks,
-antony

> 
> David
> ---
> Don't revert the I/O iterator before returning from p9_client_read_once().
> netfslib doesn't require the reversion and nor doed 9P directory reading.
> 
> Make p9_client_read() use a temporary iterator to call down into
> p9_client_read_once(), and advance that by the amount read.
> 
> Reported-by: Antony Antony <antony@phenome.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Eric Van Hensbergen <ericvh@kernel.org>
> cc: Latchesar Ionkov <lucho@ionkov.net>
> cc: Dominique Martinet <asmadeus@codewreck.org>
> cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> cc: v9fs@lists.linux.dev
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org


> ---
>  net/9p/client.c |   10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 5cd94721d974..be59b0a94eaf 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -1519,13 +1519,15 @@ p9_client_read(struct p9_fid *fid, u64 offset, struct iov_iter *to, int *err)
>  	*err = 0;
>  
>  	while (iov_iter_count(to)) {
> +		struct iov_iter tmp = *to;
>  		int count;
>  
> -		count = p9_client_read_once(fid, offset, to, err);
> +		count = p9_client_read_once(fid, offset, &tmp, err);
>  		if (!count || *err)
>  			break;
>  		offset += count;
>  		total += count;
> +		iov_iter_advance(to, count);
>  	}
>  	return total;
>  }
> @@ -1567,16 +1569,12 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
>  	}
>  	if (IS_ERR(req)) {
>  		*err = PTR_ERR(req);
> -		if (!non_zc)
> -			iov_iter_revert(to, count - iov_iter_count(to));
>  		return 0;
>  	}
>  
>  	*err = p9pdu_readf(&req->rc, clnt->proto_version,
>  			   "D", &received, &dataptr);
>  	if (*err) {
> -		if (!non_zc)
> -			iov_iter_revert(to, count - iov_iter_count(to));
>  		trace_9p_protocol_dump(clnt, &req->rc);
>  		p9_req_put(clnt, req);
>  		return 0;
> @@ -1596,8 +1594,6 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
>  			p9_req_put(clnt, req);
>  			return n;
>  		}
> -	} else {
> -		iov_iter_revert(to, count - received - iov_iter_count(to));
>  	}
>  	p9_req_put(clnt, req);
>  	return received;
> 

