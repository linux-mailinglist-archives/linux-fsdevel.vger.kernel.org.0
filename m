Return-Path: <linux-fsdevel+bounces-30295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B61988CF8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 01:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECDD281ABB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 23:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C701B86EF;
	Fri, 27 Sep 2024 23:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4seaDAc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C15C18A93C;
	Fri, 27 Sep 2024 23:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727479328; cv=none; b=ZcYjlCaYmjttUkZbwRAHMmnBs8bc+cOcxa/lU5TNVcXeuSXOMhJJmxbVIgZlitrnF8aPWz1dRenxDCFRlH9AexdF0Rc273QKdOU1Rn6Fjw+LdOM373HEp0SudfT2+2cENdapnR/gFUIQCU1u470sCgwk6XPjdSikH5iDftwQSRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727479328; c=relaxed/simple;
	bh=Ni1PSWIgWkGtc+GXe+ot0cv4W+TUNKSABP3D+pYXhYY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aljw4uJHbpowFPGlo/yKGUFcKY2flch0V+zTq1LYKG8Ldds/ppo7Lzz9Fbang/eVpz83DRfWHPPNXqSUdSP8UiwAYGfaUMQPdXb7jNOAq0DaQSHhuGv+fXxSyylg4/ryNSdrP7Y7Ef3EK0apqzCSoTWqPajSKjtNlx4NttEthSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4seaDAc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2057835395aso27746795ad.3;
        Fri, 27 Sep 2024 16:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727479327; x=1728084127; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7LAvOZp6Vqb9AO/+VS+wUvq7SL5EIr/lbn9RL5sF1d0=;
        b=X4seaDAcW8hCvrmZ9f5CUE/Zi37ZWomZWDCIw6yZyfARvhHxzARH9E75WjX23kL4ks
         KNcQ1vxN5/ysi2HY/cGBOVo/Gndnx5O0EuLOHB4OAxIavTMqr1AxJToHSRQ0PXhUtFHh
         PlEbj+uZP7IRWseMXITL2I5WKPiWkjR1JCMXWvhq7dEXL86U5V/rHNHmXtqcvIOJlwMO
         uuNQsBH59fEWr3EbYPRGIsaM+yfwwsNmna7RUpAjXLXFO0i4/1+vlAQm/GM05hGA+nQ5
         nx5SJgv//TTGiYGrH2ZI8XZpoKYeGZdio3JUbOFPyjFht1nHnATjXxjqJZfKvRD4VNL5
         k8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727479327; x=1728084127;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7LAvOZp6Vqb9AO/+VS+wUvq7SL5EIr/lbn9RL5sF1d0=;
        b=cxCqjFnW6fHcA58yQ9PvzV613qd8IHdXvc+PjW9PwSYlkVxsMudvlYPRCFn6kBB8vW
         z7R64yGU8JZpV13N7XnYBarha9f7YnaMuS/wCJE/tbKoTonqRUNPYRi6U9cJi0S4+7IF
         DVUjb1leN8p4z1dM0LzkntJ2RhjjFARkDLhJ0G8Taj6EobMx5RMdGsrBngP1EX0eEnNg
         +E6Oj+7CpIDAO+p3FPakSQCzw/bCSGMaXaIOrk4NgiTXm8O0DbLkjB7+yrMTc2q1S4sk
         Jg9QvwoHuVkM6vtDVV2KWup3dL1TfoH8mXSnqXOFsZN6PjrkIe7RJo7mRQodbvRI4o7G
         /VhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOY8wjuKC918UWHfM3Kn06RGIyECCcbQGrNihQKgWmegZXKQ5ZTilApBf/7OpAVBK2CiCESR8BknxZTg==@vger.kernel.org, AJvYcCV06H6+NiGZcI82Y/O91GrMp4oaQdEEw2azexo7cdqhqGxpdQ5PxlHV1a8wEUl1JxIMOgVv2kLN17S6@vger.kernel.org, AJvYcCVmvq2cDKjl8FFqCSlDWheqRFMTPxYdq2LCTEf7JfB+AZZWA3aYupmXnkIyJI8nw8+H/zuhD8VDC8kz@vger.kernel.org, AJvYcCW/UHUNNDBa/Rq8pp45dx8+B5L6TJorCv0xziX1OJdnde+7ohqxYrkKgwXKJwZp6jJvIre1+Y3XX8viBxKSVw==@vger.kernel.org, AJvYcCW9y9pdHqf9Wi1WmEhGR9xb5IVjrWAq81j+2t4xBeks5oZN4afdz5/zZnIhFA3eOQePCjAvrqBtVAbd1jhH@vger.kernel.org, AJvYcCWqpJrmq13P2shzHCmpFB+nTpbCXCyGbxfyaOaZB9mpah1hej0IEZdT3hh38hwZOxUATY9wCyn7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx66ifhfdNrF/S8JGnHsL+C+ikL2sSSjm6bPrnN5ymnJzFsuBaL
	uqF++FGh4LFrfxNz3H8lSl4Ya8D6WP+ckP1R2LoI0kgEBz+dgp7a
X-Google-Smtp-Source: AGHT+IFXTEMtPJJpJatKRUAfPM6/3maacD+r+Yf+RlOH8FPWHZYjxB+hsah3pGiJOGYuet3l4rSHvQ==
X-Received: by 2002:a17:902:e74e:b0:206:bbaa:84e9 with SMTP id d9443c01a7336-20b37b9b53cmr81601675ad.47.1727479326584;
        Fri, 27 Sep 2024 16:22:06 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e5169csm18253515ad.238.2024.09.27.16.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 16:22:06 -0700 (PDT)
Message-ID: <d87e3b4dfd4624d182d3d23992eacb7b9ffeff90.camel@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
From: Eduard Zingerman <eddyz87@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Manu Bretelle <chantr4@gmail.com>, asmadeus@codewreck.org, 
 ceph-devel@vger.kernel.org, christian@brauner.io, ericvh@kernel.org, 
 hsiangkao@linux.alibaba.com, idryomov@gmail.com, jlayton@kernel.org, 
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-nfs@vger.kernel.org,  marc.dionne@auristor.com,
 netdev@vger.kernel.org, netfs@lists.linux.dev,  pc@manguebit.com,
 smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
 v9fs@lists.linux.dev, willy@infradead.org
Date: Fri, 27 Sep 2024 16:22:01 -0700
In-Reply-To: <2668612.1727471502@warthog.procyon.org.uk>
References: <55cef4bef5a14a70b97e104c4ddd8ef64430f168.camel@gmail.com>
	 <20240923183432.1876750-1-chantr4@gmail.com>
	 <20240814203850.2240469-20-dhowells@redhat.com>
	 <2663729.1727470216@warthog.procyon.org.uk>
	 <2668612.1727471502@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-27 at 22:11 +0100, David Howells wrote:

[...]

> If you look here:
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/lo=
g/?h=3Dnetfs-fixes
>=20
> you can see some patches I've added.  If you can try this branch or cherr=
y
> pick:
>=20
> 	netfs: Fix write oops in generic/346 (9p) and generic/074 (cifs)
> 	netfs: Advance iterator correctly rather than jumping it
> 	netfs: Use a folio_queue allocation and free functions
> 	netfs: Add a tracepoint to log the lifespan of folio_queue structs

I used your branch netfs-fixes, namely at the following commit:
8e18fe180b0a ("netfs: Abstract out a rolling folio buffer implementation")

> And then turn on the following "netfs" tracepoints:
>=20
> 	read,sreq,rreq,failure,write,write_iter,folio,folioq,progress,donate
>

System can't boot, so I used the following kernel command line:
... trace_event=3D:netfs_read,:netfs_sreq,:netfs_rreq,:netfs_failure,:netfs=
_write,:netfs_write_iter,:netfs_folio,:netfs_folioq,:netfs_progress,:netfs_=
donate

No warnings like "Failed to enable trace event ...", so I assume it worked
as expected.

A fresh dmesg is here:
https://gist.github.com/eddyz87/e8f4780d833675a7e58854596394a70f

Don't see any tracepoint output there, so something is probably missing.

> > Alternatively I can pack this thing in a dockerfile, so that you would
> > be able to reproduce locally (but that would have to wait till my eveni=
ng).
>=20
> I don't have Docker set up, so I'm not sure how easy that would be for me=
 to
> use.

What's your preferred setup for the repro?


