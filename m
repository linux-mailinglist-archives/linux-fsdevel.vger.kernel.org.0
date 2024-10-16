Return-Path: <linux-fsdevel+bounces-32083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3959A0636
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 11:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4579A1F24398
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 09:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643E2206061;
	Wed, 16 Oct 2024 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KDnH3E7W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80795206063
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072610; cv=none; b=uUKtsB2WnHTUTfirBSG0Q+jany9kXMTbp9HpSAKpf4g5KfG2ReFNqNxKdCffIZb+pFmVY6UNCj9iC3ZLsoRMK/6WiqpFUfIFIPRh7+XFFaOk7Y8Id7snWjKPoF9TFYoBEDtqHc27z4ikpUjGiNN4OlCNnykKD3UaX3TJZ2WGB2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072610; c=relaxed/simple;
	bh=Gr4WWWyXuj4BAE1iqQUO41p+vQmB4OZAYvWlbJBKeVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pFkEXtS1dVKWO0I5ru5ibLnR4VsqV3DQkjEN42Q+/E442DGTpLjX1GvernKfQZnoHjJnFlbVV8Sj3zMWEjwKnZ8MfIt045pAl1lfscZcO/26QXW6LnmgGQBkw9iKd9PVlmLzSZoCljAjjNvhePc/ZsP2EF2z0cgJhLQh1H+IPxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KDnH3E7W; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729072605; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Rnszya6EHQM6AQ4/YRC+ZygvroVabaRKD1faRhw01hs=;
	b=KDnH3E7WdRoqRzQZSL95Nx0q46dpVfK9mIdDGod3LOqhh0nYuRDDONSUf0VdedXXQ6Zr7y6SKCcC8Hi17dJwpop2n+CTwhR9DzYqIKlQ80f6HjAzrOasgHJAfzQUsDxe88wyxS20Dc0iONelk4kVqfeZg6ORgNRfS18StY4FBH8=
Received: from 30.221.144.185(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WHGyZ3z_1729072603 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Oct 2024 17:56:44 +0800
Message-ID: <02544610-05e4-49b3-a477-3ee35c0701ed@linux.alibaba.com>
Date: Wed, 16 Oct 2024 17:56:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 bernd.schubert@fastmail.fm, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 linux-mm@kvack.org, kernel-team@meta.com
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com>
 <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/15/24 6:01 PM, Miklos Szeredi wrote:
> On Mon, 14 Oct 2024 at 20:23, Joanne Koong <joannelkoong@gmail.com> wrote:
> 
>> This change sets AS_NO_WRITEBACK_RECLAIM on the inode mapping so that
>> FUSE folios are not reclaimed and waited on while in writeback, and
>> removes the temporary folio + extra copying and the internal rb tree.
> 
> What about sync(2)? 

FYI The posix sync(2) says, "The writing, although scheduled, is not
necessarily complete upon return from sync()." [1]

Thus hopefully it won't break the posix semantics of sync(2) down if we
skip the waiting on the writeback of fuse pages.

[1] https://pubs.opengroup.org/onlinepubs/9699919799/functions/sync.html

-- 
Thanks,
Jingbo

