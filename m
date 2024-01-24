Return-Path: <linux-fsdevel+bounces-8750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A77683AA4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ECB8B235A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B562F7764F;
	Wed, 24 Jan 2024 12:50:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6884A77652;
	Wed, 24 Jan 2024 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100630; cv=none; b=aa3z79hW6Z5g+WOIoHCbS1mbEgDTpnCGmBoQcUgRJf1LJtyL1ndVSxKCh1ACM5GmEQpp7xP9JOjzELruRMoq/lRB6aOc0iCgoqkXFsZaIFhmTqCG+3HkE3tZlTb40nd5iP2D7H1lBVHfWZk5Up8gLNOqTwfUR6xbc1KlgIA/oNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100630; c=relaxed/simple;
	bh=lRs6RL/zQlcIaeBWW71/aAJ66BXOtnlf6gJLAxRKZck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTGUnOoKVoSRJut6l731PC6+15FRAIcJ9dlWxdE7YqJFFZubG9E9cg+myRZkq3YwHaDKWAUzwSnX3C12BpnSS89ySp4c9v6oGnk6HJMVQo45FY3uz1G9IOY1Bn4xNgQvTICWtcUccT5QMc1afSsO4ktk/UGG7UbBGauG+OLQyIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W.Gp3dN_1706100621;
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W.Gp3dN_1706100621)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 20:50:22 +0800
Message-ID: <96abca7f-8bd1-44e8-98be-c60d6d676ec6@linux.alibaba.com>
Date: Wed, 24 Jan 2024 20:50:21 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: add support for explicit export disabling
Content-Language: en-US
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 amir73il@gmail.com
References: <20240124113042.44300-1-jefflexu@linux.alibaba.com>
 <CAJfpegtkSgRO-24bdnA4xUMFW5vFwSDQ7WkcowNR69zmbRwKqQ@mail.gmail.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJfpegtkSgRO-24bdnA4xUMFW5vFwSDQ7WkcowNR69zmbRwKqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/24/24 8:16 PM, Miklos Szeredi wrote:
> On Wed, 24 Jan 2024 at 12:30, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> open_by_handle_at(2) can fail with -ESTALE with a valid handle returned
>> by a previous name_to_handle_at(2) for evicted fuse inodes, which is
>> especially common when entry_valid_timeout is 0, e.g. when the fuse
>> daemon is in "cache=none" mode.
>>
>> The time sequence is like:
>>
>>         name_to_handle_at(2)    # succeed
>>         evict fuse inode
>>         open_by_handle_at(2)    # fail
>>
>> The root cause is that, with 0 entry_valid_timeout, the dput() called in
>> name_to_handle_at(2) will trigger iput -> evict(), which will send
>> FUSE_FORGET to the daemon.  The following open_by_handle_at(2) will send
>> a new FUSE_LOOKUP request upon inode cache miss since the previous inode
>> eviction.  Then the fuse daemon may fail the FUSE_LOOKUP request with
>> -ENOENT as the cached metadata of the requested inode has already been
>> cleaned up during the previous FUSE_FORGET.  The returned -ENOENT is
>> treated as -ESTALE when open_by_handle_at(2) returns.
>>
>> This confuses the application somehow, as open_by_handle_at(2) fails
>> when the previous name_to_handle_at(2) succeeds.  The returned errno is
>> also confusing as the requested file is not deleted and already there.
>> It is reasonable to fail name_to_handle_at(2) early in this case, after
>> which the application can fallback to open(2) to access files.
>>
>> Since this issue typically appears when entry_valid_timeout is 0 which
>> is configured by the fuse daemon, the fuse daemon is the right person to
>> explicitly disable the export when required.
>>
>> Also considering FUSE_EXPORT_SUPPORT actually indicates the support for
>> lookups of "." and "..", and there are existing fuse daemons supporting
>> export without FUSE_EXPORT_SUPPORT set, for compatibility, we add a new
>> INIT flag for such purpose.
> 
> This looks good overall.
> 
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> ---
>> RFC: https://lore.kernel.org/all/20240123093701.94166-1-jefflexu@linux.alibaba.com/
>> ---
>>  fs/fuse/inode.c           | 11 ++++++++++-
>>  include/uapi/linux/fuse.h |  2 ++
>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index 2a6d44f91729..851940c0e930 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -1110,6 +1110,11 @@ static struct dentry *fuse_get_parent(struct dentry *child)
>>         return parent;
>>  }
>>
>> +/* only for fid encoding; no support for file handle */
>> +static const struct export_operations fuse_fid_operations = {
> 
> Nit: I'd call this fuse_no_export_operations (or something else that
> emphasizes the fact that this is only for encoding and not for full
> export support).

OK I will rename it to fuse_no_export_operations.

By the way do I need to bump and update the minor version of FUSE protocol?


-- 
Thanks,
Jingbo

