Return-Path: <linux-fsdevel+bounces-35878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FAA9D938D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 09:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D945165F52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 08:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DCD1ABEBB;
	Tue, 26 Nov 2024 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="UVEQYXXF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CWerTH+a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F246613C3F6;
	Tue, 26 Nov 2024 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732610970; cv=none; b=a7ZyMvjKif3UjxX2uSSIWIajtmNt0Wg9PAMJTPhY1/QqvPt6xg5paxNUnmbIAfEKRwT9jftUKAW1ANRn+rHIA0UhuTxxdyN2urz25JZ9lh9Xg1QZ7xI/HM0WIyU5+ZNzVYcTdWHWWarLeEhYaYMZT5gEOysVdpzo0tq7DV7t1Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732610970; c=relaxed/simple;
	bh=QgA2V39K+nI8Yw0kGgHn1G1xYlFo87d/nEmMPnhMCyA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UGnCnikDhoGzB09+HEuj02h4n7ILDKkY2tT2Y8WO3WITAaVHBjezdg7acgO7GvYQiN9Pkun2+MdjPCHpgCmRPYlYpoiCbKIApo6GyJempPl1F0aK8JV65NUAdV6E/nICuOYWNOOiVoVfBRGVij+wpOXotCnKpYjtNfX+YoSLETI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=UVEQYXXF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CWerTH+a; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id A8B1E1140158;
	Tue, 26 Nov 2024 03:49:26 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 26 Nov 2024 03:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732610966;
	 x=1732697366; bh=Qd19FLub09m9YC9jkC4e0DUGqBo/39uXk/01+azJUEw=; b=
	UVEQYXXFLYQlQl6Yh66OTYGqna8PXeYwTCRT8WL9kNMgsIwTvyefqnfMrrDMd4rJ
	r3NUGxuaIO4qJS2T93hszme5BWugzpVMtKA4eJqwPFFAWjWkwmcA/uAhW6BomRXF
	jU0NrCMknn3SiJ9TF5sqco36KmxyxBNd7DgLNOr16tsbcL46EWpEXecHBiHinh1p
	y7k9uYbB6tyJ6Jd5jVm6WwhbC2foNOtkYGD5RUwENYCdbRTFJyTfbZReHIZvu+zg
	R+HHQdtFHUVO+sK4klY6vgKYXj7Um5VhPEcVHYFTHdd9qZdl/9merOl3ScBn2/O9
	+8TEH0o9Zual2f3d68J+mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732610966; x=
	1732697366; bh=Qd19FLub09m9YC9jkC4e0DUGqBo/39uXk/01+azJUEw=; b=C
	WerTH+aenqwR0jH4udCVgVcMLi8Xfsilp2tqUwNqllEHT+pLGpA/dg9Bk/31UfZW
	7bEKaisgV5yVXkZteN80MefY1gkS16HZGjLbExE8CD9PBHEk3IwxctEg8WIFgdPm
	88KefC+bZl5xPMxIwOnGNCkz13+6JIpyI6aYdyJvMT1HgVQmSdtmqhmlhI+XbKNz
	nj8O18iDCFb2y4Vp+Ij08zYHZjbx+YaQQI1QaLAMwe8280j4HpnKG3L9lx1JPYXn
	0QYDYsIHHYBkSGND+qjfUO9llxiI+CbX6meYT+i1mzbQkLNfW4eruMzXBLPzMyBu
	460VfEJltg9jRKVV+Aq0w==
X-ME-Sender: <xms:lotFZ8Kiql7C8tgUlsvXeFeyyNy7J0Uv5rm-vj1bPA3PHCzzEqCrJQ>
    <xme:lotFZ8K0rytf1gGFiE7ekf7PuDOGhNUAEvxQ694-k7SW8xeoW4plSpAKUJfeWfXyS
    a8xIx4s1REEAXSlt9o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepledp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprghnuggvrhhsrdhrohigvghllheslhhinhgrrhhordhorhhg
    pdhrtghpthhtohepuggrnhdrtggrrhhpvghnthgvrheslhhinhgrrhhordhorhhgpdhrtg
    hpthhtohepnhgrrhgvshhhrdhkrghmsghojhhusehlihhnrghrohdrohhrghdprhgtphht
    thhopehlkhhfthdqthhrihgrghgvsehlihhsthhsrdhlihhnrghrohdrohhrghdprhgtph
    htthhopehnvghtfhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepughh
    ohifvghllhhssehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvg
    hvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lotFZ8uabkzTD6kHjDKiBwYtmUbgYIp6AtoBDgAV73Bx_9y0y5YHCg>
    <xmx:lotFZ5a2MexPC4-BtuXuMHqZVH2-jmJDzIxqE04h14VFDKAEmT8rMw>
    <xmx:lotFZzZGwd3CkOcjVBMDMrKZuq1QlsEf4k2FYnENYik5uxlhs4Vhmw>
    <xmx:lotFZ1AFDh-wbJ9_Byyv1yFrHm5Q1h5X7VAB9S3sUMUcDIX6xsrBGA>
    <xmx:lotFZxPM9cAUgqeyOZJTWHiVMxoZE7qbhH5anYVDdfs7KEZp693-H58x>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1B8832220071; Tue, 26 Nov 2024 03:49:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 26 Nov 2024 09:49:05 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, "open list" <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org
Cc: "Jeff Layton" <jlayton@kernel.org>, "David Howells" <dhowells@redhat.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>
Message-Id: <b55d1f04-aadc-490e-a8b5-fe1588f3c9c0@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYuLXDh8GDmgdhmA1NAhsma3=FoH1n93gmkHAGGFKbNGeQ@mail.gmail.com>
References: 
 <CA+G9fYuLXDh8GDmgdhmA1NAhsma3=FoH1n93gmkHAGGFKbNGeQ@mail.gmail.com>
Subject: Re: fs/netfs/read_retry.c:235:20: error: variable 'subreq' is uninitialized
 when used here [-Werror,-Wuninitialized]
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Nov 26, 2024, at 09:25, Naresh Kamboju wrote:
> The x86_64 builds failed with clang-19 and clang-nightly on the Linux
> next-20241125 tag.
> Same build pass with gcc-13.

> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Build error:
> ---------
> fs/netfs/read_retry.c:235:20: error: variable 'subreq' is
> uninitialized when used here [-Werror,-Wuninitialized]
>   235 |         if (list_is_last(&subreq->rreq_link, &stream->subrequests))
>       |                           ^~~~~~
> fs/netfs/read_retry.c:28:36: note: initialize the variable 'subreq' to
> silence this warning
>    28 |         struct netfs_io_subrequest *subreq;
>       |                                           ^
>       |                                            = NULL
> 1 error generated.
> make[5]: *** [scripts/Makefile.build:194: fs/netfs/read_retry.o] Error 1


This broke in 1bd9011ee163 ("netfs: Change the read result
collector to only use one work item"), which introduced an
extra "subreq" variable in the "do {} while()" loop that
shadows the one in the function body.

The one pointed out by the compiler is not initialized
anywhere. My best guess is that the extra declaration should
just be removed here:

--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -72,7 +72,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
        next = stream->subrequests.next;
 
        do {
-               struct netfs_io_subrequest *subreq = NULL, *from, *to, *tmp;
+               struct netfs_io_subrequest *from, *to, *tmp;
                struct iov_iter source;
                unsigned long long start, len;
                size_t part;

This also removes an initialization to NULL, but I think
that was not needed regardless.

       Arnd

