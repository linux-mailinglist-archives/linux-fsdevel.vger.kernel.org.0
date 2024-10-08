Return-Path: <linux-fsdevel+bounces-31321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0FC9948B9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 14:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029BF1C21448
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 12:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1286A1DE2CF;
	Tue,  8 Oct 2024 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YZDeNV8s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B351E485;
	Tue,  8 Oct 2024 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389769; cv=none; b=O7SxNjprwpYrbEpEm6UhYYLTAjOLjoaadlUp5Kvzi9HRlQ3l0V8A8Ci+M8W+44TfYAsOz2xc1MhtME9nylp/IR8UQGbdlmWIp76xI84jGxnkVRVQSXHfKB6zSYuRpDnsPyIG250FfurXPxRUe/n9f3JeRlGchle7suRL3xykdEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389769; c=relaxed/simple;
	bh=zjYzfQogUxPJPeT4iXZHwPM4OQ8y0mVwV0hA0pkSX+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKi+Fkdd5jsYcYBXKKXBKEn2MlHaAnzccX6zDXhmkmBScxhTa3hX4626sol7ulbfeTtLQs5kP60LQuEBjMJJCgEVy4eykF+b5MQZ3levZl2s0hpjnv7IyZJJuIBC8nSmCD4UzxWUM7t01lCBhNXbm+n9j2MYY+r+xdguNYFpbP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YZDeNV8s; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728389764; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YSHOWwL5PQ8Vjc/lzXai26oFbtfjaLjk7eVPoweFJR4=;
	b=YZDeNV8sT1IQATK4abKKbXAtzw9Vxj9T2HzSGdgEpA2rxTWNzaiNMT1eJxbBDMdB93kgqqcdBNnuSiObqKmwrMTkSvjL/jOivg6E/IkgWXNCa7Z2YBqyXvEm1vX6NuFCCVhS2FDWPM5opcLAKkNV9A2vadloW0/tWm7WG5MBQX0=
Received: from 172.20.10.8(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGek4fk_1728389443)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 20:10:45 +0800
Message-ID: <34cbdb0b-28f4-4408-83b1-198f55427b5c@linux.alibaba.com>
Date: Tue, 8 Oct 2024 20:10:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs/super.c: introduce get_tree_bdev_by_dev()
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Allison Karlitskaya <allison.karlitskaya@redhat.com>,
 Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
References: <20241008095606.990466-1-hsiangkao@linux.alibaba.com>
 <ZwUcT0qUp2DKOCS3@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZwUcT0qUp2DKOCS3@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christoph,

On 2024/10/8 19:49, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 05:56:05PM +0800, Gao Xiang wrote:
>> As Allison reported [1], currently get_tree_bdev() will store
>> "Can't lookup blockdev" error message.  Although it makes sense for
>> pure bdev-based fses, this message may mislead users who try to use
>> EROFS file-backed mounts since get_tree_nodev() is used as a fallback
>> then.
>>
>> Add get_tree_bdev_by_dev() to specify a device number explicitly
>> instead of the hardcoded fc->source as mentioned in [2], there are
>> other benefits like:
>>    - Filesystems can have other ways to get a bdev-based sb
>>      in addition to the current hard-coded source path;
>>
>>    - Pseudo-filesystems can utilize this method to generate a
>>      filesystem from given device numbers too.
>>
>>    - Like get_tree_nodev(), it doesn't strictly tie to fc->source
>>      either.
> 
> Do you have concrete plans for any of those?  If so send pointers.

Thanks for your comment.

I don't have any pointer for now, just listing the potential use
cases for reference.

But the error message out of get_tree_bdev() is inflexible and
IMHO it's too coupled to `fc->source`.

> Otherwise just passing a quiet flag of some form feels like a much
> saner interface.

I'm fine with this way, but that will be a treewide change, I
will send out a version with a flag later.

Thanks,
Gao Xiang

