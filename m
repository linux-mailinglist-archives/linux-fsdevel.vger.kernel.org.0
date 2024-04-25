Return-Path: <linux-fsdevel+bounces-17838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 343748B2CAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 00:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD35B1F285F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 22:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F4D15AAD0;
	Thu, 25 Apr 2024 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M8vrWQ71"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1582135A;
	Thu, 25 Apr 2024 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082226; cv=none; b=FiJF+LU/tT2NaY/gLMx1swkG+UcyeaX0VM+Hf8YgN7E+JG9/hG6rcjqi9aCBXKkMqdEnPltRFwkSNgZnOls/0pBD1He1ps+cda21OJ91TgeHSNSS+hcUcxWT+Gket/jz9aubqEYm8AdnBgzHewl7FCG5TXckw4WDfyN83sJizz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082226; c=relaxed/simple;
	bh=3ZV5smop/lPyYIXEXoCUHn82p3Cb7VEDXtcEeatmiBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5CXvuFottjnyaj8H9dCP4fDfAspjJHCyVQAo4wbZniyMmFE876Lw1OvOTM7TwVmI/L9eiCrT8wMZcamNvyTpfs38CyllYZpOKrJu5aoRVyOGCeSu/1fqTattJm/OuwF9ucNf30CJDdUPl9KA8+1Dnta2Jzc/bXuArXni5Q82U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M8vrWQ71; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714082215; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=V92ffFYenJ+D/klo7VNY7AiRuYJPKbryKeaFLPKmcfI=;
	b=M8vrWQ71Sw8WVSjL6UeWXbzM9qOVcD2vFlgi61QtBCiVxR/eSoSZd+CdKd0T8F18/kuF4XG+SrYE3vfdGD74mTdER8kBAN9w1JXZQboTBNoGUDwLmGBArnvIWdeMPXgcVMDYMZbXoy4tx+AuvBCwrZiTUUTs9el+RYfBzsGpVB4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W5GUHhL_1714082213;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5GUHhL_1714082213)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 05:56:54 +0800
Message-ID: <22fccbef-1cf2-4579-a015-936f5ef40782@linux.alibaba.com>
Date: Fri, 26 Apr 2024 05:56:52 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vfs.all 08/26] erofs: prevent direct access of bd_inode
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
 brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 yukuai3@huawei.com
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-9-yukuai1@huaweicloud.com>
 <20240407040531.GA1791215@ZenIV>
 <a660a238-2b7e-423f-b5aa-6f5777259f4d@linux.alibaba.com>
 <20240425195641.GJ2118490@ZenIV> <20240425200846.GK2118490@ZenIV>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240425200846.GK2118490@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Al,

On 2024/4/26 04:08, Al Viro wrote:
> On Thu, Apr 25, 2024 at 08:56:41PM +0100, Al Viro wrote:
> 
>> FWIW, see #misc.erofs and #more.erofs in my tree; the former is the
>> minimal conversion of erofs_read_buf() and switch from buf->inode
>> to buf->mapping, the latter follows that up with massage for
>> erofs_read_metabuf().
> 
> First two and last four patches resp.  BTW, what are the intended rules
> for inline symlinks?  "Should fit within the same block as the last

symlink on-disk layout follows the same rule of regular files.  The last
logical block can be inlined right after the on-disk inode (called tail
packing inline) or use a separate fs block to keep the symlink if tail
packing inline doesn't fit.

> byte of on-disk erofs_inode_{compact,extended}"?  Feels like
> erofs_read_inode() might be better off if it did copying the symlink
> body instead of leaving it to erofs_fill_symlink(), complete with
> the sanity checks...  I'd left that logics alone, though - I'm nowhere
> near familiar enough with erofs layout.
If I understand correctly, do you mean just fold erofs_fill_symlink()
into the caller?  That is fine with me, I can change this in the
future.

Thanks,
Gao Xiang

