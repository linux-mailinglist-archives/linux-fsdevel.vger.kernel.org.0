Return-Path: <linux-fsdevel+bounces-17844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A398F8B2D79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 01:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4FD1C20F6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 23:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DD9156655;
	Thu, 25 Apr 2024 23:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nOiu6mSJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86D14E2EF;
	Thu, 25 Apr 2024 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714086672; cv=none; b=qVuRB0m8GNSO3iUuvZwinU1qApuaxbQq2s4M623IxKAsB4vsah/FAExA8ykZftFqmZZwTWSkbLh5y1FOwH+IueffD+FJ7nunk+Qqhon9mx85BZwlJxj586wM3PAg4co/AFogYERtSlFCw2UfURLdDXe7Wq3hVUbCbGeCrdgCyTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714086672; c=relaxed/simple;
	bh=echJfnx1+SZTZAMb6NRojmgE98ewi1+ITMk5g0mz3EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jX/kXCzLMHLCzY0O1UQiqEYcW5G4O+Jrr4ozehXDjanYj7egx3jk+GdqdBR7xHBgO/v5pPCx6AlsKZ+aB/O03tV0JoWrbQ1ZmaRmDWoCqzUu2VIe23m3ycGHcix2YOSQG/BMuZVtMVl/HOC1oILef0lcfrqpwyfEEZmZa6aW3yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nOiu6mSJ; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714086666; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lolKLRwh904ESZ6jUpCbXGmIKnu+dbZ3BXzYH0SxRH8=;
	b=nOiu6mSJ1UCsHbQZBwr4KdzXIkdhJOE2fNw59UBfAMtiePfQGBRkCss928u7Y0MUCYW0Me7Cq/GL55YFyswOhulFEWDFxH0FINnfecgUa03CEQMHc7CX27IJEnPHUad9ZiM94Dp8e74smlgCEYPxEDbDi9buMM7Cf7jwtG8PKJ8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W5Gb-9w_1714086663;
Received: from 30.25.226.163(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5Gb-9w_1714086663)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 07:11:05 +0800
Message-ID: <f5035861-2598-467f-80d4-b6977699f602@linux.alibaba.com>
Date: Fri, 26 Apr 2024 07:11:02 +0800
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
 <22fccbef-1cf2-4579-a015-936f5ef40782@linux.alibaba.com>
 <20240425222847.GN2118490@ZenIV>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240425222847.GN2118490@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/26 06:28, Al Viro wrote:
> On Fri, Apr 26, 2024 at 05:56:52AM +0800, Gao Xiang wrote:
>> Hi Al,
>>
>> On 2024/4/26 04:08, Al Viro wrote:
>>> On Thu, Apr 25, 2024 at 08:56:41PM +0100, Al Viro wrote:
>>>
>>>> FWIW, see #misc.erofs and #more.erofs in my tree; the former is the
>>>> minimal conversion of erofs_read_buf() and switch from buf->inode
>>>> to buf->mapping, the latter follows that up with massage for
>>>> erofs_read_metabuf().
>>>
>>> First two and last four patches resp.  BTW, what are the intended rules
>>> for inline symlinks?  "Should fit within the same block as the last
>>
>> symlink on-disk layout follows the same rule of regular files.  The last
>> logical block can be inlined right after the on-disk inode (called tail
>> packing inline) or use a separate fs block to keep the symlink if tail
>> packing inline doesn't fit.
>>
>>> byte of on-disk erofs_inode_{compact,extended}"?  Feels like
>>> erofs_read_inode() might be better off if it did copying the symlink
>>> body instead of leaving it to erofs_fill_symlink(), complete with
>>> the sanity checks...  I'd left that logics alone, though - I'm nowhere
>>> near familiar enough with erofs layout.
>> If I understand correctly, do you mean just fold erofs_fill_symlink()
>> into the caller?  That is fine with me, I can change this in the
>> future.
> 
> It's just that the calling conventions of erofs_read_inode() feel wrong ;-/
> We return a pointer and offset, with (ERR_PTR(...), anything) used to
> indicate an error and (pointer into page, offset) used (in case of
> fast symlinks and only in case of fast symlinks) to encode the address
> of symlink body, with data starting at pointer + offset + vi->xattr_isize
> and length being ->i_size, no greater than block size - offset - vi->xattr_size.
> 
> If anything, it would be easier to follow (and document) if you had
> allocated and filled the symlink body right there in erofs_read_inode().
> That way you could lift erofs_put_metabuf() call into erofs_read_inode(),
> along with the variable itself.
> 
> Perhaps something like void *erofs_read_inode(inode) with
> 	ERR_PTR(-E...) => error
> 	NULL => success, not a fast symlink
> 	pointer to string => success, a fast symlink, body allocated and returned
> to caller.

Got it.  my original plan was that erofs_read_inode() didn't need
to handle inode->i_mode stuffs (IOWs, different type of inodes).

But I think symlink i_link cases can be handled specifically in
erofs_read_inode().

> 
> Or, for that matter, have it return an int and stuff the body into ->i_link -
> it's just that you'd need to set ->i_op there with such approach.
> 
> Not sure, really.  BTW, one comment about erofs_fill_symlink() - it's probably
> a good idea to use kmemdup_nul() rather than open-coding it (and do that after
> the block overflow check, obviously).

Yes, let me handle all of this later.

Thanks,
Gao Xiang

