Return-Path: <linux-fsdevel+bounces-13866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB36874D1E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 12:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7725B22015
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 11:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE10128812;
	Thu,  7 Mar 2024 11:11:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A2F12AACA;
	Thu,  7 Mar 2024 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809862; cv=none; b=XN9RNUVpc9HZ1/ZrPBuJWfSaG8hg1N86bZLxQLPyNymo2yo1bq1Pju18W5/xDJ3Qf3QVxkiwGe5HJmUPOHZxhCkj+n52F+M+8hxtClGXOgddSueOUazR6CoDtR0USfOiCcvdfOUaX87Z05VElCLYztvpTwc8Gj7BfCxBQ5FKK34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809862; c=relaxed/simple;
	bh=d9qXCwBy0OCnjmukXXQYfDDhyk8g3sbgN8e6gFFm7+o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rDG9HdqDrnRrgXWucIZD8DXUU4F1x7hTYdTHgyGFTb8ue1fpnMrmUDlcvrEkgUFsQTHOCdX9EHPHh/pHgh0D4uwy9lcWOM5dBbRMxUri8vya0zM9Vky2iXCyCGw/zDmPZdIeAQwBZhAV/KADuF21KZ9k1TJNyzlZ9ZTn+EPKawo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 56BBB644CE85;
	Thu,  7 Mar 2024 12:10:58 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id UdxeGAjGXPBj; Thu,  7 Mar 2024 12:10:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 84261644CE7E;
	Thu,  7 Mar 2024 12:10:57 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JXqFNTpdyqQP; Thu,  7 Mar 2024 12:10:57 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4C4FE644CE85;
	Thu,  7 Mar 2024 12:10:57 +0100 (CET)
Date: Thu, 7 Mar 2024 12:10:57 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
	upstream+pagemap@sigma-star.at, adobriyan@gmail.com, 
	wangkefeng wang <wangkefeng.wang@huawei.com>, 
	ryan roberts <ryan.roberts@arm.com>, hughd@google.com, 
	peterx@redhat.com, avagin@google.com, lstoakes@gmail.com, 
	vbabka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	usama anjum <usama.anjum@collabora.com>, 
	Jonathan Corbet <corbet@lwn.net>
Message-ID: <861682210.23281.1709809857201.JavaMail.zimbra@nod.at>
In-Reply-To: <db29666a-32b8-4bf6-ab13-7de3b09b0da1@redhat.com>
References: <20240306232339.29659-1-richard@nod.at> <20240306232339.29659-2-richard@nod.at> <db29666a-32b8-4bf6-ab13-7de3b09b0da1@redhat.com>
Subject: Re: [PATCH 2/2] [RFC] pagemap.rst: Document write bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: pagemap.rst: Document write bit
Thread-Index: m4Aa6cZ4OAmz6WBRgPq7/2CUVSqXkA==

----- Urspr=C3=BCngliche Mail -----
> Von: "David Hildenbrand" <david@redhat.com>
> An: "richard" <richard@nod.at>, "linux-mm" <linux-mm@kvack.org>
>> +   Bit 58 is useful to detect CoW mappings; however, it does not indica=
te
>> +   whether the page mapping is writable or not. If an anonymous mapping=
 is
>> +   writable but the write bit is not set, it means that the next write =
access
>> +   will cause a page fault, and copy-on-write will happen.
>=20
> That is not true.

Can you please help me correct my obvious misunderstanding?



