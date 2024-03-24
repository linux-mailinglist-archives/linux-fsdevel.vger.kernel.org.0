Return-Path: <linux-fsdevel+bounces-15173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9F0887C58
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 11:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA671C209D6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7E5175B1;
	Sun, 24 Mar 2024 10:51:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E6A1758B;
	Sun, 24 Mar 2024 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711277474; cv=none; b=TXxCEqXWhptVi/nz1nKUYY8jmROzTv/3PEYveEXk9HtdJ2HkY4zclleTj5wDRD/oAP2YkZjQ8B9rt7a5Tl5jvs8XLE9BfR2RussIlchtiXbuDGON1fT9WJ2SOdrezVRNiCCI0kPBO/a0HT4a6LLNPf3zBnzrM5goHWej3vMoXOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711277474; c=relaxed/simple;
	bh=PN2swhOYOVTj/oUNRb9B9xf/l+LKz0C702cw77G8xXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pKZlvSAQQZre8pC/rbJsBEV2pIjYWDfJsbEVf+xL/fTkKGOqX+p90dohLOEc6NfmYNCYpsQLSf7ofccG+S91xHbP81h59v8M6b99UfB1pQ+twK2lSACEve6wdNUAlrppyko4ikw5x5s1wZaDjLyy99a9o900cNRJlOLubV0aZjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.30] (p4fee269d.dip0.t-ipconnect.de [79.238.38.157])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: buczek)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 95B4A61E5FE0A;
	Sun, 24 Mar 2024 11:50:48 +0100 (CET)
Message-ID: <b1d67dd6-4326-4247-96a3-283ab1975a50@molgen.mpg.de>
Date: Sun, 24 Mar 2024 11:50:47 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: possible 6.6 regression: Deadlock involving super_lock()
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, it+linux@molgen.mpg.de
References: <6e010dbb-f125-4f44-9b1a-9e6ac9bb66ff@molgen.mpg.de>
 <20240321-brecheisen-lasst-7ac15aff03b1@brauner>
From: Donald Buczek <buczek@molgen.mpg.de>
In-Reply-To: <20240321-brecheisen-lasst-7ac15aff03b1@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/24 14:35, Christian Brauner wrote:
>> Also, one writeback thread was blocked. I mention that, because I
>> don't get how these these two threads could depend on each other:
> 
> Writeback holds s_umount. So writeback seems to not make progress and
> blocks the mount. So right now it seems unlikely that this is related.

Oh, yes, super_trylock_shared() in __writeback_inodes_wb(). Sorry, I've missed that and blamed the victim.

> Any chance you can try and reproduce this with v6.7 and newer?

We can't really reproduce anything yet, we can only wait and see if it happens again on the production system. We are willing to risk that, so we've just switched the system to 6.6.22 and made sure, that drgn is available to further analyze a possible frozen state. This was not the case on the reported freeze due to a configuration error. Although, currently, I would have no idea how to find out, why the folio is locked forever, even with drgn available.

We can switch to 6.7. Why do you propose it? Is there reason to believe that the problem might go away or would that help in analysis if we hit it again on that series?

I'm a bit hesitating, because this is a production system and we have the experience that switching from one mainline release to the next (or from one stable series to another) produces some new problems most of the times.

Thanks

   Donald

>> # # /proc/39359/task/39359: kworker/u268:5+flush-0:58 :
>> # cat /proc/39359/task/39359/stack
>>
>> [<0>] folio_wait_bit_common+0x135/0x350
>> [<0>] write_cache_pages+0x1a0/0x3a0
>> [<0>] nfs_writepages+0x12a/0x1e0 [nfs]
>> [<0>] do_writepages+0xcf/0x1e0
>> [<0>] __writeback_single_inode+0x46/0x3a0
>> [<0>] writeback_sb_inodes+0x1f5/0x4d0
>> [<0>] __writeback_inodes_wb+0x4c/0xf0
>> [<0>] wb_writeback+0x1f5/0x320
>> [<0>] wb_workfn+0x350/0x4f0
>> [<0>] process_one_work+0x142/0x300
>> [<0>] worker_thread+0x2f5/0x410
>> [<0>] kthread+0xe8/0x120
>> [<0>] ret_from_fork+0x34/0x50
>> [<0>] ret_from_fork_asm+0x1b/0x30

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433

