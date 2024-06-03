Return-Path: <linux-fsdevel+bounces-20840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49498D852D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 16:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119E31C20E4A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 14:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EEE12F5B8;
	Mon,  3 Jun 2024 14:35:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C1A12EBE6;
	Mon,  3 Jun 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425342; cv=none; b=NbzTF9GRVegzYBzvCWL9Q/IdVZe8uVYLfIGjxv7Jj0txtVAG6Mym0XDWpXSSsT0hKNkbZubyiW65B/wTZvbtLl/uETx0zYW2VLsHhrDWiLxmpb2u5CrjnML7w4oFJEZH3X4mVSUiBvwHftKKqgv2+Ny/xFu/uHsJnTcGe2Szud8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425342; c=relaxed/simple;
	bh=aS7WNKyb79nHjkRKjId2BNPG35Iq9xA2er2JeQ/uKJA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rrwMWhg7LKqQcxGxJGo0dLnpMv/m7sXE8eSbNNuijnyJH0BfoNhTKZEKzhPGuUb0xAohwUEUqN5tPkdsQJuu2Wg//wIqCGRRZVK7a77PIYjxVP21PfObFWQlCOUfgnlScHotdyegcWcR+gUHmo/82vAWlCl/PPin9Ro/D+bmqEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VtGV96W3Vz4f3jkk;
	Mon,  3 Jun 2024 22:35:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2D4441A0170;
	Mon,  3 Jun 2024 22:35:36 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgDnCg621F1mAppQOw--.29601S3;
	Mon, 03 Jun 2024 22:35:36 +0800 (CST)
Subject: Re: [RFC PATCH v4 6/8] xfs: correct the truncate blocksize of
 realtime inode
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, brauner@kernel.org,
 david@fromorbit.com, chandanbabu@kernel.org, jack@suse.cz,
 willy@infradead.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-7-yi.zhang@huaweicloud.com>
 <ZlnSTAg15vWjc1Qm@infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <67a811e0-6723-3bb6-5f74-a66610b884a0@huaweicloud.com>
Date: Mon, 3 Jun 2024 22:35:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZlnSTAg15vWjc1Qm@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDnCg621F1mAppQOw--.29601S3
X-Coremail-Antispam: 1UD129KBjvdXoWrury3tryDtr4xWw18Jr4xJFb_yoWxZrc_ua
	y5Ar92g3WkWFn5Aa17Cr15GFsxKFW2krsrXw15XFsFq3sxtas5ta1qyrWFkF1DKFsrtrn8
	ZryI9r4avrnFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/31 21:36, Christoph Hellwig wrote:
> On Wed, May 29, 2024 at 05:52:04PM +0800, Zhang Yi wrote:
>> +	if (xfs_inode_has_bigrtalloc(ip))
>> +		first_unmap_block = xfs_rtb_roundup_rtx(mp, first_unmap_block);
> 
> Given that first_unmap_block is a xfs_fileoff_t and not a xfs_rtblock_t,
> this looks a bit confusing.  I'd suggest to just open code the
> arithmetics in xfs_rtb_roundup_rtx.  For future proofing my also
> use xfs_inode_alloc_unitsize() as in the hunk below instead of hard
> coding the rtextsize.  I.e.:
> 
> 	first_unmap_block = XFS_B_TO_FSB(mp,
> 		roundup_64(new_size, xfs_inode_alloc_unitsize(ip)));
> 
Sure, makes sense to me.

Thanks,
Yi.


