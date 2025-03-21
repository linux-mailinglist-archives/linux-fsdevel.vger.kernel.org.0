Return-Path: <linux-fsdevel+bounces-44675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65467A6B40C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 06:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D73189CA16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 05:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17A61E9B0D;
	Fri, 21 Mar 2025 05:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UkwqT/xf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323BD46B5;
	Fri, 21 Mar 2025 05:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742534885; cv=none; b=rJc+yzOcbBmZyBML35V3w88wPlnyR67T+3yhOOShBtdgnBxmvN1l/TArxLXZq3SG9SsUO3xKK/UmKf5eHWt7JPvq6YEW8NdF5Kmtcs1iIfi/Ci2P+Dz7gX5a8qUntSNKPR9tMDmTHoAH687gR8zqrxI86NRjzLvBvS6xeq+q1Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742534885; c=relaxed/simple;
	bh=gFRZr495JWgz8tsTRUKs87yDTDwYoQ25vCxHnnHJi4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFbv7XpLS+4YJVk9coFockYP/Jp5vbUGF1b6eJ4nUvyOVd1O9iVTDzvZN2vncwOMVmASPnDHxbG8Vs5r3XqPgSDj1YcgNQliXNzNTp0+g6rIMayoNEHXkJuDIOLDg0aoOqxpfCrQMlGnZBCeVd26X5aoMqECDqQLtBFjJ5qDePw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UkwqT/xf; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742534874; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3OjmVg3hNieyiJXK/kdh6TLgZvVamdZ07Qi4mofSePI=;
	b=UkwqT/xfOpQwBAypx5eiAlILfAEPOMadCoeHoJlWViU4RvHyzwZqLblzPQBirHyBKBiYMQ0inoEbU+DJLKa0PoWWXkTzZ5RY+JLEq+51z4x+JGoMB0hHdUAuXXj1K/mCh/871LG1c6/+l/dYgogygQ2ABqcundcS+lOYtQsMs1Y=
Received: from 30.74.129.101(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WSGDxm1_1742534873 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Mar 2025 13:27:54 +0800
Message-ID: <582bc002-f0c8-4dbb-8fa5-4c10a479b518@linux.alibaba.com>
Date: Fri, 21 Mar 2025 13:27:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] initrd: support erofs as initrd
To: Christoph Hellwig <hch@lst.de>, julian.stecklina@cyberus-technology.de
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250320-initrd-erofs-v1-1-35bbb293468a@cyberus-technology.de>
 <20250321050114.GC1831@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250321050114.GC1831@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christoph,

On 2025/3/21 13:01, Christoph Hellwig wrote:
> We've been trying to kill off initrd in favor of initramfs for about
> two decades.  I don't think adding new file system support to it is
> helpful.
> 

Disclaimer: I don't know the background of this effort so
more background might be helpful.

Two years ago, I once thought if using EROFS + FSDAX to directly
use the initrd image from bootloaders to avoid the original initrd
double caching issue (which is what initramfs was proposed to
resolve) and initramfs unnecessary tmpfs unpack overhead:
https://lore.kernel.org/r/ZXgNQ85PdUKrQU1j@infradead.org

Also EROFS supports xattrs so the following potential work (which
the cpio format doesn't support) is no longer needed although I
don't have any interest to follow either):
https://lore.kernel.org/r/20190523121803.21638-1-roberto.sassu@huawei.com

Anyway, personally I have no time slot or even input on those.

Thanks,
Gao Xiang

