Return-Path: <linux-fsdevel+bounces-26555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2250B95A647
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 23:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93ACA1F228B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 21:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF360170A19;
	Wed, 21 Aug 2024 21:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="DppD+lqN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B593B7405A
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724274130; cv=none; b=IJ2ZDJPabHuSO2oGYQgIJMsNCvfB95thKFPZUFBbtY5KrVvHY2v7/l9Q4U/xLgMeQ/3zaRstAVRC6ArB8Xd9j7eb4BYIonr7CpiAJKqXt+P77fTj0f9rsDHbUWU81CxCN6qZd2t5n/cMMoKnsEYyWY34Aqj7TYMzXbVS6aI05iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724274130; c=relaxed/simple;
	bh=qo3HfyxgYz+ARn5brrQ1qCZSvZDjomJ/B63GAA/ekcc=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=BlMYv+CLfnIeQ5VL1bqNidCTziNXOVBCA8bWcE1+MDQETkhnlbPv6XMPTByZZ81i+R8vZ+WCDZIpMLFdkMb1bMVp36SFbffylBeV72GmUlCJNv4TrlheHQQGOXBuSZ8V2y0yMbf0szZt6yrzYlbtNyqC8fAKRbpWTF0jlQ1eqZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=DppD+lqN; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7a1c7857a49so106617a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 14:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1724274127; x=1724878927; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5gkZVhDgiENeIhudma772OretQnBA4LLyV2LWCGjhwA=;
        b=DppD+lqNqLOhUhwFiD3AwwcvOVJt8sPpiEswS1FSELDKxz3kv0pGCZm//BjKp9i6vI
         n1B1IotROnbhv2M+pMn4SDxpqp5x2u5bBWl+2K6fuwxtPvR3i0Z9MZ7rdy0+XrqPYMCx
         oirHmBJY93+3HFu9c2JNXL1/kgX+tBxx9Yie+oGAkdAbWV87oujv4W2fMzWPS3AGUQqQ
         1vFj706V/4SdDNG7olFEYpeXHOeH2yZeVkTU+G7q56mLakppmEJkurnbR5ikQXolIIdt
         NkK1boi/fAjK2MwIfrwPnGs5JszqlOfODkEcIie4ZP1m0l765Clcl0ikTKMjgxsDWxQm
         LOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724274127; x=1724878927;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gkZVhDgiENeIhudma772OretQnBA4LLyV2LWCGjhwA=;
        b=fZdP+LXuInToxj/VpKR4cQu/Ska6qMcoC9sV5iGisns8K2T5ziGRuS/J3ZJGQVmkDa
         5wMd7nPiA/8JG5/l/SBU9ZPpMbcrG9o/W1CykrR8fnG5C3BevyC1aoSsUWo/gI99zVXm
         y294W0nmo3cApuFJtd90OfR8aZHkvmaQLDks/1BOWrw8xmY779TI3yTWEDMXweYioJnZ
         8odgNe9UntyYygEew/1Mi8cvgWJYJCDXZagdvVXZBQbCUs2NwuPr8HzDElSmP317Ye9d
         cZ3aLFt0OtWd5KmXdfv7uqzUZ9Z9m1Goi1cUf0zxMqWb7KmQQ/YhUV3UeBq2I1AjFWjN
         6+YA==
X-Forwarded-Encrypted: i=1; AJvYcCX2CoxNGmWHscSOE5yHiVPHZBFVU0Vo7FUpZlYdOIcigV0Fm15+82OFXM1vrkrMSqS/aU9Bdwn416kNT873@vger.kernel.org
X-Gm-Message-State: AOJu0YwGHkrhwMOtu7y8LHjPf6LRFznrdzlfPpI0XfwhA4iPXBKJliqv
	Yju/SpZd0vfwthFHtN/2sKFcaFXGPlKwq7u/r48m/ykGvESYdG/PUzs/W9GBk5g=
X-Google-Smtp-Source: AGHT+IFaMDauIiJXABxwEORKbXngDgS4LbM9Z4c0yPOy/Sqzv12pUasP8fV1sAizSF0ARDZOQZlhNA==
X-Received: by 2002:a17:90b:17c8:b0:2d3:da6d:8328 with SMTP id 98e67ed59e1d1-2d5e9a1f2fcmr3849075a91.21.1724274126514;
        Wed, 21 Aug 2024 14:02:06 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbb0b27sm2374106a91.45.2024.08.21.14.02.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2024 14:02:05 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <9BA2DBC4-0DB3-406C-A88D-B816C421EF1D@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4DB06D7F-E9DD-49B0-9742-25CD056E7ED8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH RFC v2 6/6] inode: make i_state a u32
Date: Wed, 21 Aug 2024 15:03:01 -0600
In-Reply-To: <20240821-work-i_state-v2-6-67244769f102@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 NeilBrown <neilb@suse.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Jeff Layton <jlayton@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
To: Christian Brauner <brauner@kernel.org>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
 <20240821-work-i_state-v2-6-67244769f102@kernel.org>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_4DB06D7F-E9DD-49B0-9742-25CD056E7ED8
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Aug 21, 2024, at 9:47 AM, Christian Brauner <brauner@kernel.org> wrote:
> 
> Now that we use the wait var event mechanism make i_state a u32 and free
> up 4 bytes. This means we currently have two 4 byte holes in struct
> inode which we can pack.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> include/linux/fs.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 8525f8bfd7b9..a673173b6896 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -681,7 +681,7 @@ struct inode {
> #endif
> 
> 	/* Misc */
> -	unsigned long		i_state;
> +	u32			i_state;

Is it worthwhile to add a comment that there is a hole here, instead
of leaving it for future re-discovery?

        /* 32-bit hole */

> 	struct rw_semaphore	i_rwsem;
> 
> 	unsigned long		dirtied_when; /* jiffies of first dirtying */

Normally this would be excess noise, but since struct inode is
micro-optimized (like struct page) it probably makes sense to
document this case.

Cheers, Andreas






--Apple-Mail=_4DB06D7F-E9DD-49B0-9742-25CD056E7ED8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmbGVgUACgkQcqXauRfM
H+Afhw//U72bgO23Or3tE6jiWaErkgepZfqBu4gQJ+fckFyWdaY9SKs7TCJqphhf
TYmu3jm2hkva5qpSvuYDgMTk+pGNRfZV0y1MkoWrecKSkSY+XmhS493FPlM4lCrB
crJQDbhUdJOPFbzNp4ThUh4akZJcwkkU1k6gYcf6PofeSbYojNu17pSKhibpMknD
YCniN4aIpycjVBdDVzn5gmEzAfOOtx6YqdOtdOknGNS9IeOtcb3SorICG6pLPRah
WDCL1oQSNa1uUwynenCvprvsBnKajzouQ3Zd4Uy8Z7hOCfrg4HJYhIHib3yhwuNa
ceOpd42QQxieQtqdC3LAZWIpJbYx/X8YV8VRgkfKj4BMGLwrryISXZdF3M7GMAH7
TGu8x98jVJuaPSrY87ZEXN68gEZ/y+Ff2s7slc9uOY1jNFLOSWyR/5JlqAReNuWY
4o+C1LwBj0JxLBkIkW0Xq+ODO1J9362SOYfQHI+AVVNjOyh6+YJbxLTEfqRFUKuw
/NK5YUTK43ubRN/lALOO9lvIHFtWs4NenRoTCRuHx2N0+BonKg40fbfZs3lyLRdP
UAogKCj78x989wOBCDujEm7nDX1zkwzDOH9/m0hzNhTUOYnG001qlEMakGMOUOYQ
kRfZ2nEkYdBoEl9TokxkHNSewAQuGNwQ995Xh4s1j26Kz+AJGus=
=Lph7
-----END PGP SIGNATURE-----

--Apple-Mail=_4DB06D7F-E9DD-49B0-9742-25CD056E7ED8--

