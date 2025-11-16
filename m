Return-Path: <linux-fsdevel+bounces-68608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 94045C61406
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 12:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4008735DACC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 11:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4042C21F7;
	Sun, 16 Nov 2025 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="W6/ozjk2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC2A2C21EA;
	Sun, 16 Nov 2025 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763294098; cv=none; b=tzRnGroe4oVnce34MTifXwgKimg9EnwZtyls9/oJWxj/6uHZwk9YESpX0V8B6bFghIeB09AxzMs6BPgAZCt2FbG1wjtNqB3HQorKjVFUDs0YG7K7F3ommHZnQ+fHwU2OgDtc59aJfHoGNMXSRPotqKE92r1AeJnRc1QY0lRB+Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763294098; c=relaxed/simple;
	bh=xtk8UQzrIzPbNaQvN2j0/EIZALpVBPnp+tlD9FHVG/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErzzTkEL2dc1+maZSCOEUCzBzRlN8YvYC2lDWUxyuTIdV1WohEpegR85CSVXB2iBaDbXg5h3x0MnLZZEJIHA5cEP/2e1jB47kzcZsU7nLwyKVtA8naWTtaTRgjZE4h4oLHxKJSfWg5pZ911yz1Jg0K+GJlgC5R/oAX9JfT/qpzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=W6/ozjk2; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763294087; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4v60toLnC7F9DIrdXiLX89QoxpYhFyqY7LCwty780Vs=;
	b=W6/ozjk2T9hvtvLrA8ogA8Zl0Qx0bZOVmgMjyDf3BouuKiDuwlRNtk6jaSj7neF/bA7rXxyiHZHKvB9x/I7bEAr4FctO3sIMStrVPMd4aYhxn43dCtpVBaz9coTeg0vK+quQStq2epd3pZZrYdoczhDhYJso6XjvRO234Q22tiU=
Received: from 30.170.196.81(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsSHQp._1763294083 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Nov 2025 19:54:44 +0800
Message-ID: <9e121004-fa70-4461-932b-9d30fd3733cc@linux.alibaba.com>
Date: Sun, 16 Nov 2025 19:54:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/9] iomap: stash iomap read ctx in the private field
 of iomap_iter
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, joannelkoong@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-2-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251114095516.207555-2-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/14 17:55, Hongbo Li wrote:
> It's useful to get filesystem-specific information using the
> existing private field in the @iomap_iter passed to iomap_{begin,end}
> for advanced usage for iomap buffered reads, which is much like the
> current iomap DIO.
> 
> For example, EROFS needs it to:
> 
>   - implement an efficient page cache sharing feature, since iomap
>     needs to apply to anon inode page cache but we'd like to get the
>     backing inode/fs instead, so filesystem-specific private data is
>     needed to keep such information;
> 
>   - pass in both struct page * and void * for inline data to avoid
>     kmap_to_page() usage (which is bogus).
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

LGTM, and I think the case 2) is useful even without
the main feature:

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

