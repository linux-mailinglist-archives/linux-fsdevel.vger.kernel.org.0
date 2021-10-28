Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C28C43DAE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 07:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhJ1Fy6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 01:54:58 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:46433 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229586AbhJ1Fy5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 01:54:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Utxz1z-_1635400347;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Utxz1z-_1635400347)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 Oct 2021 13:52:28 +0800
Subject: Re: [Question] ext4/xfs: Default behavior changed after per-file DAX
To:     Vivek Goyal <vgoyal@redhat.com>, Ira Weiny <ira.weiny@intel.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-xfs@vger.kernel.org,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>
References: <26ddaf6d-fea7-ed20-cafb-decd63b2652a@linux.alibaba.com>
 <20211026154834.GB24307@magnolia> <YXhWP/FCkgHG/+ou@redhat.com>
 <20211026205730.GI3465596@iweiny-DESK2.sc.intel.com>
 <YXlj6GhxkFBQRJYk@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <665787d0-f227-a95b-37a3-20f2ea3e09aa@linux.alibaba.com>
Date:   Thu, 28 Oct 2021 13:52:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YXlj6GhxkFBQRJYk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/27/21 10:36 PM, Vivek Goyal wrote:
> [snip]
> 
>>
>> Is the biggest issue the lack of visibility to see if the device supports DAX?
> 
> Not necessarily. I think for me two biggest issues are.
> 
> - Should dax be enabled by default in server as well. If we do that,
>   server will have to make extra ioctl() call on every LOOKUP and GETATTR
>   fuse request. Local filesystems probably can easily query FS_XFLAGS_DAX
>   state but doing extra syscall all the time will probably be some cost
>   (No idea how much).

I tested the time cost from virtiofsd's perspective (time cost of
passthrough_ll.c:lo_do_lookup()):
- before per inode DAX feature: 2~4 us
- after per inode DAX feature: 7~8 us

It is within expectation, as the introduction of per inode DAX feature,
one extra ioctl() system call is introduced.

Also the time cost from client's perspective (time cost of
fs/fuse/dir.c:fuse_lookup_name())
- before per inode DAX feature: 25~30 us
- after per inode DAX feature: 30~35 us

That is, ~15%~20% performance loss.

Currently we do ioctl() to query the persitent inode flags every time
FUSE_LOOKUP request is received, maybe we could cache the result of
ioctl() on virtiofsd side, but I have no idea how to intercept the
runtime modification to these persistent indoe flags from other
processes on host, e.g. sysadmin on host, to maintain the cache consistency.

So if the default behavior of client side is 'dax=inode', and virtiofsd
disables per inode DAX by default (neither '-o dax=server|attr' is
specified for virtiofsd) for the sake of performance, then guest won't
see DAX enabled and thus won't be surprised. This can reduce the
behavior change to the minimum.


> 
> - So far if virtiofs is mounted without any of the dax options, just
>   by looking at mount option, I could tell, DAX is not enabled on any
>   of the files. But that will not be true anymore. Because dax=inode
>   be default, it is possible that server upgrade enabled dax on some
>   or all the files.
> 
>   I guess I will have to stick to same reason given by ext4/xfs. That is
>   to determine whether DAX is enabled on a file or not, you need to
>   query STATX_ATTR_DAX flag. That's the only way to conclude if DAX is
>   being used on a file or not. Don't look at filesystem mount options
>   and reach a conclusion (except the case of dax=never).


-- 
Thanks,
Jeffle
