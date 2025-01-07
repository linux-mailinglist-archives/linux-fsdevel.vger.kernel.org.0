Return-Path: <linux-fsdevel+bounces-38564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48072A041DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 15:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7D3166A79
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 14:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8AB1F63E4;
	Tue,  7 Jan 2025 14:05:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE29E1F3D48;
	Tue,  7 Jan 2025 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258757; cv=none; b=Cn8zq6lr0VPPfa0Wp61kfvsB9GHP4t4/uqYtOAl3Xy8uqVyKHcr6fq/gDAaa6+1IfTipI5tP+oLHjRcFFO/yl2YhODK+6/OjJpCvYhlZeEkKLKrgW3dyQUsVYg3S06sbkqzikecLjgb4Kk73j1KlW4ehRf9sNlAIh1GnZi2cg8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258757; c=relaxed/simple;
	bh=ymO0pR/jZ9c/Yw0Sffygjl0lMBjbUTgAaRWofBYyiU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFOC1fpwSCgMeO/h98yWzv0MwEka+ugTmc3+cr0AS9pAm2Nv36Yxfltj55vkNXC/IdHd2Dzy5TvMyBhaaIw7E0dr2n7baktb/CxpRUKsfutBuXlTiV3Otmz6HIwTk//QYIFaMf7w2DWY0273Q5k/HMuUU9zFiOOPH090zbb+vsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YSCVx3WBCz4f3jrt;
	Tue,  7 Jan 2025 22:05:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 964891A164F;
	Tue,  7 Jan 2025 22:05:49 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAni1+7NH1nNiczAQ--.46088S3;
	Tue, 07 Jan 2025 22:05:49 +0800 (CST)
Message-ID: <b964a57a-0237-4cbd-9aae-457527a44440@huaweicloud.com>
Date: Tue, 7 Jan 2025 22:05:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] fs: introduce FALLOC_FL_FORCE_ZERO to fallocate
To: "Darrick J. Wong" <djwong@kernel.org>,
 Christoph Hellwig <hch@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 adilger.kernel@dilger.ca, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com,
 Sai Chaitanya Mitta <mittachaitu@gmail.com>, linux-xfs@vger.kernel.org
References: <20241228014522.2395187-1-yi.zhang@huaweicloud.com>
 <20241228014522.2395187-2-yi.zhang@huaweicloud.com>
 <Z3u-OCX86j-q7JXo@infradead.org> <20250106161732.GG1284777@mit.edu>
 <Z3wEhXakqrW4i3UC@infradead.org> <20250106173133.GB6174@frogsfrogsfrogs>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250106173133.GB6174@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAni1+7NH1nNiczAQ--.46088S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJryrtw47Cr1kCF4rJrW7XFb_yoW8uw1Upa
	yrJr1DKr1ktr43u3s7Z3WxKrW8Cw4rAr47uFn0qr4DZr15Zr1SqF47KryY9a47uryxA3Wj
	qrWIvay5uwsrCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFk
	u4UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/1/7 1:31, Darrick J. Wong wrote:
> On Mon, Jan 06, 2025 at 08:27:49AM -0800, Christoph Hellwig wrote:
>> On Mon, Jan 06, 2025 at 11:17:32AM -0500, Theodore Ts'o wrote:
>>> Yes.  And we might decide that it should be done using some kind of
>>> ioctl, such as BLKDISCARD, as opposed to a new fallocate operation,
>>> since it really isn't a filesystem metadata operation, just as
>>> BLKDISARD isn't.  The other side of the argument is that ioctls are
>>> ugly, and maybe all new such operations should be plumbed through via
>>> fallocate as opposed to adding a new ioctl.  I don't have strong
>>> feelings on this, although I *do* belive that whatever interface we
>>> use, whether it be fallocate or ioctl, it should be supported by block
>>> devices and files in a file system, to make life easier for those
>>> databases that want to support running on a raw block device (for
>>> full-page advertisements on the back cover of the Businessweek
>>> magazine) or on files (which is how 99.9% of all real-world users
>>> actually run enterprise databases.  :-)
>>
>> If you want the operation to work for files it needs to be routed
>> through the file system as otherwise you can't make it actually
>> work coherently.  While you could add a new ioctl that works on a
>> file fallocate seems like a much better interface.  Supporting it
>> on a block device is trivial, as it can mostly (or even entirely
>> depending on the exact definition of the interface) reuse the existing
>> zero range / punch hole code.
> 
> I think we should wire it up as a new FALLOC_FL_WRITE_ZEROES mode,
> document very vigorously that it exists to facilitate pure overwrites
> (specifically that it returns EOPNOTSUPP for always-cow files), and not
> add more ioctls.
> 

Sorry. the "pure overwrites" and "always-cow files" makes me confused,
this is mainly used to create a new written file range, but also could
be used to zero out an existing range, why you mentioned it exists to
facilitate pure overwrites?

For the "always-cow files", do you mean reflinked files? Could you
please give more details?

Thanks,
Yi.

> (That said, doesn't BLKZEROOUT already do this for bdevs?)
> 
> --D


