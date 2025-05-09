Return-Path: <linux-fsdevel+bounces-48588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD36FAB138A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 14:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BB4CB22FAF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4E229187C;
	Fri,  9 May 2025 12:36:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7F2291163;
	Fri,  9 May 2025 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746794165; cv=none; b=pNBT21kM+YQixygq9+dO8sfHPDCDw7P3Pp6/YSWTrzB0bU/U5KbwgkR4Ocz44qSNXewmGghxAy3DOOYkKlSBneGLLjhwyford/U4dMbansOXaK4Hh9ytTYrcuMThO0zmK0nWh026zSjMh2ybg/biGxqH/iCm7xQsWda8ra9VPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746794165; c=relaxed/simple;
	bh=iFG6U4TNU0CiwWw5zXUbd1SGuqdNDV0zCwWyjsJlnBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYiBDDSqbeBoSWeV4j3PaLG/Xydp1ByS54+G13Hl3tzz9ImufdUpj8ZCR9oJFiyYwZ9NZ6jPBQ6e58s9cmc/mXWvZbzfYEZ53ZIgZ2fqXxCXpz2EKCI4IhurbFyXKjxL2RKjN9O2osLoSYjCgHD7x0gmIfrJw+3wV9ixkX1G4dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zv7kl6J0kz4f3kvq;
	Fri,  9 May 2025 20:35:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E6B2A1A0359;
	Fri,  9 May 2025 20:35:53 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAHa1+l9h1osHmaLw--.17418S3;
	Fri, 09 May 2025 20:35:51 +0800 (CST)
Message-ID: <7118c684-db9d-4bf1-a8dc-48c4cf698eba@huaweicloud.com>
Date: Fri, 9 May 2025 20:35:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
To: Theodore Ts'o <tytso@mit.edu>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
 shinichiro.kawasaki@wdc.com, brauner@kernel.org, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250421021509.2366003-8-yi.zhang@huaweicloud.com>
 <20250505132208.GA22182@lst.de> <20250505142945.GJ1035866@frogsfrogsfrogs>
 <c7d8d0c3-7efa-4ee6-b518-f8b09ec87b73@huaweicloud.com>
 <20250506043907.GA27061@lst.de>
 <64c8b62a-83ba-45be-a83e-62b6ad8d6f22@huaweicloud.com>
 <20250506121102.GA21905@lst.de>
 <a39a6612-89ac-4255-b737-37c7d16b3185@huaweicloud.com>
 <20250508050147.GA26916@lst.de>
 <68172a9e-cf68-4962-8229-68e283e894e1@huaweicloud.com>
 <20250508202424.GA30222@mit.edu>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250508202424.GA30222@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHa1+l9h1osHmaLw--.17418S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKr4rJryDuw4UKryUtr47Jwb_yoWxur13pF
	WFgF4Fyr4DKFyrAwn2vw4xuF1YyrZ3JFy5Grs5Gw10kws8ZF1SgFn7K3yFvasrJr97Wa1j
	qFWYqFyDGanYyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/5/9 4:24, Theodore Ts'o wrote:
> On Thu, May 08, 2025 at 08:17:14PM +0800, Zhang Yi wrote:
>> On 2025/5/8 13:01, Christoph Hellwig wrote:
>>>>
>>>> My idea is not to strictly limiting the use of FALLOC_FL_WRITE_ZEROES to
>>>> only bdev or files where bdev_unmap_write_zeroes() returns true. In
>>>> other words, STATX_ATTR_WRITE_ZEROES_UNMAP and FALLOC_FL_WRITE_ZEROES
>>>> are not consistent, they are two independent features. Even if some
>>>> devices STATX_ATTR_WRITE_ZEROES_UNMAP are not set, users should still be
>>>> allowed to call fallcoate(FALLOC_FL_WRITE_ZEROES). This is because some
>>>> devices and drivers currently cannot reliably ascertain whether they
>>>> support the unmap write zero command; however, certain devices, such as
>>>> specific cloud storage devices, do support it. Users of these devices
>>>> may also wish to use FALLOC_FL_WRITE_ZEROES to expedite the zeroing
>>>> process.
>>>
>>> What are those "cloud storage devices" where you set it reliably,
>>> i.e.g what drivers?
>>
>> I don't have these 'cloud storage devices' now, but Ted had mentioned
>> those cloud-emulated block devices such as Google's Persistent Desk or
>> Amazon's Elastic Block Device in. I'm not sure if they can accurately
>> report the BLK_FEAT_WRITE_ZEROES_UNMAP feature, maybe Ted can give more
>> details.
>>
>> https://lore.kernel.org/linux-fsdevel/20250106161732.GG1284777@mit.edu/
> 
> There's nothing really exotic about what I was referring to in terms
> of "cloud storage devices".  Perhaps a better way of describing them
> is to consider devices such as dm-thin, or a Ceph Block Device, which
> is being exposed as a SCSI or NVME device.

OK, then correctly reporting the BLK_FEAT_WRITE_ZEROES_UNMAP feature
should no longer be a major problem. It seems that we do not need to
pay much attention to enabling this feature manually.

> 
> The distinction I was trying to make is performance-related.  Suppose
> you call WRITE_ZEROS on a 14TB region.  After the WRITES_ZEROS
> complete, a read anywhere on that 14TB region will return zeros.
> That's easy.  But the question is when you call WRITE_ZEROS, will the
> storage device (a) go away for a day or more before it completes (which
> would be the case if it is a traditional spinning rust platter), or
> (b) will it be basically instaneous, because all dm-thin or a Ceph Block
> Device needs to do is to delete one or more entries in its mapping
> table.

Yes.

> 
> The problem is two-fold.  First, there's no way for the kernel to know
> whether a storage device will behave as (a) or (b), because SCSI and
> other storage specifications say that performance is out of scope.
> They only talk about the functional results (afterwards, if yout try
> to read from the region, you will get zeros), and are utterly silent
> about how long it migt take.  The second problem is that if you are an
> application program, there is no way you will be willing to call
> fallocate(WRITE_ZEROS, 14TB) if you don't know whether the disk will
> go away for a day or whether it will be instaneous.
> 
> But because there is no way for the kernel to know whether WRITE_ZEROS
> will be fast or not, how would you expect the kernel to expose
> STATX_ATTR_WRITE_ZEROES_UNMAP?  Cristoph's formulation "breaking the
> abstraction" perfectly encapsulate the SCSI specification's position
> on the matter, and I agree it's a valid position.  It's just not
> terribly useful for the application programmer.

Yes.

> 
> Things which some programs/users might want to know or rely upon, but which is normally quite impossible are: 
> 
> * Will the write zero / discard operation take a "reasonable" amount
>   of time?  (Yes, not necessarilly well defined, but we know it when
>   we see it, and hours or days is generally not reasonable.)
> 
> * Is the operation reliable --- i.e., is the device allowed to
>   randomly decide that it won't actually zero the requested blocks (as
>   is the case of discard) whenever it feels like it.
> 
> * Is the operation guaranteed to make the data irretreviable even in
>   face of an attacker with low-level access to the device.  (And this
>   is also not necessarily well defined; does the attacker have access
>   to a scanning electronic microscope, or can do a liquid nitrogen
>   destructive access of the flash device?)

Yes.

> 
> The UFS (Universal Flash Storage) spec comes the closest to providing
> commands that distinguish between these various cases, but for most
> storage specifications, like SCSI, it is absolutely requires peaking
> behind the abstraction barrier defined by the specification, and so
> ultimately, the kernel can't know.
> 
> About the best you can do is to require manual configuration; perhaps a
> config file at the database or userspace cluster file system level
> because the system adminsitrator knows --- maybe because the hyperscale
> cloud provider has leaned on the storage vendor to tell them under
> NDA, storage specs be damned or they won't spend $$$ millions with
> that storage vendor ---  or because the database administrator discovers
> that using fallocate(WRITE_ZEROS) causes performance to tank, so they
> manually disable the use of WRITE_ZEROS.

Yes, this is indeed what we should consider.

> 
> Could this be done in the kernel?  Sure.  We could have a file, say,
> /sys/block/sdXX/queue/write_zeros where the write_zeros file is
> writeable, and so the administrator can force-disable WRITES_ZERO by
> writing 0 into the file.  And could this be queried via a STATX
> attribute?  I suppose, although to be honest, I'm used to doing this
> by looking at the sysfs files.  For example, just recently I coded up
> the following:
> 
> static int is_rotational (const char *device_name EXT2FS_ATTR((unused)))
> {
> 	int		rotational = -1;
> #ifdef __linux__
> 	char		path[1024];
> 	struct stat	st;
> 	FILE		*f;
> 
> 	if ((stat(device_name, &st) < 0) || !S_ISBLK(st.st_mode))
> 		return -1;
> 
> 	snprintf(path, sizeof(path), "/sys/dev/block/%d:%d/queue/rotational",
> 		major(st.st_rdev), minor(st.st_rdev));
> 	f = fopen(path, "r");
> 	if (!f) {
> 		snprintf(path, sizeof(path),
> 			"/sys/dev/block/%d:%d/../queue/rotational",
> 			major(st.st_rdev), minor(st.st_rdev));
> 		f = fopen(path, "r");
> 	}
> 	if (f) {
> 		if (fscanf(f, "%d", &rotational) != 1)
> 			rotational = -1;
> 		fclose(f);
> 	}
> #endif
> 	return rotational;
> }
> 
> Easy-peasy!   Who needs statx?   :-)
> 

Yes. as I replied earlier, I'm going to implement this with a new flag,
BLK_FALG_WRITE_ZEROES_UNMAP_DISABLED, similar to the existing
BLK_FLAG_WRITE_CACHE_DISABLED. Make
/sys/block/<disk>/queue/write_zeroes_unmap to read-write. Regarding
whether to rename it to 'write_zeroes', I need to reconsider, as the
naming aligns perfectly with FALLOC_FL_WRITE_ZEROES, but the **UNMAP**
semantics cannot be adequately expressed.

Thank you for your detailed explanation and suggestions!

Best regards.
Yi.


