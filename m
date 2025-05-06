Return-Path: <linux-fsdevel+bounces-48224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA57BAAC244
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 13:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17AAE1B68660
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C178227A45F;
	Tue,  6 May 2025 11:17:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AB38F66;
	Tue,  6 May 2025 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530225; cv=none; b=RpJOvHfQk/T1Bk5FU2eqkSUUSRac4pSfovZ2PSZPlWAbLD2xLXwLgtPw3lLQYkrwvqX9hF887q9dg8nmPY0+lck79tXDvG0dlqo+lkJchYKMgOR2srh/Deacy0iERtwF4dhedRIgcOvO4q5rKl+fiA2XgSc5VNCWgz58SGAvZgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530225; c=relaxed/simple;
	bh=Z7jOwuEBTaEvhsLGSpRE/ZPVJ70iFQdIT9GmLOYv7TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+SVea76V2dRL+7pwEbbxyuHY2+oUIIYHoB3drCikJrIjWCSe+2rfNOeyTqqpSQQW5BmHi4J3TIc2roXptO9lKtITaHFCH+ZP0HeogRj/Ew1e2ZiI1QG4R87fohGt7Q3yTWHygd5ZgZvz7wSjr09F7Tk5Tx+AAN4LNKCXEtM//A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZsG7449SCz4f3lCf;
	Tue,  6 May 2025 19:16:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 83A261A1BAF;
	Tue,  6 May 2025 19:16:58 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl+o7xlohYhoLg--.37289S3;
	Tue, 06 May 2025 19:16:58 +0800 (CST)
Message-ID: <64c8b62a-83ba-45be-a83e-62b6ad8d6f22@huaweicloud.com>
Date: Tue, 6 May 2025 19:16:56 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
To: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
 shinichiro.kawasaki@wdc.com, brauner@kernel.org, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
 <20250421021509.2366003-8-yi.zhang@huaweicloud.com>
 <20250505132208.GA22182@lst.de> <20250505142945.GJ1035866@frogsfrogsfrogs>
 <c7d8d0c3-7efa-4ee6-b518-f8b09ec87b73@huaweicloud.com>
 <20250506043907.GA27061@lst.de>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250506043907.GA27061@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXOl+o7xlohYhoLg--.37289S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Xr1rZFyDCrWUGw4rKFy3Jwb_yoW8JrWDpa
	yUKFyqyw4DKr15Xwn7uw4vgrn5Zrs5JFn8Gw4rKr18Zws8X3WxKF9Yg3WDGF9xWr1fAa4U
	ArsxK34DXayfC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
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
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jIksgUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/5/6 12:39, Christoph Hellwig wrote:
> On Tue, May 06, 2025 at 12:28:54PM +0800, Zhang Yi wrote:
>> OK, since this statx reporting flag is not strongly tied to
>> FALLOC_FL_WRITE_ZEROES in vfs_fallocate(), I'll split this patch into
>> three separate patches.
> 
> I don't think that is the right thing to do do.  Keep the flag addition
> here, and then report it in the ext4 and bdev patches adding
> FALLOC_FL_WRITE_ZEROES as the reporting should be consistent with
> the added support.
> 

Sorry, but I don't understand your suggestion. The
STATX_ATTR_WRITE_ZEROES_UNMAP attribute only indicate whether the bdev
and the block device that under the specified file support unmap write
zeroes commoand. It does not reflect whether the bdev and the
filesystems support FALLOC_FL_WRITE_ZEROES. The implementation of
FALLOC_FL_WRITE_ZEROES doesn't fully rely on the unmap write zeroes
commoand now, users simply refer to this attribute flag to determine
whether to use FALLOC_FL_WRITE_ZEROES when preallocating a file.
So, STATX_ATTR_WRITE_ZEROES_UNMAP and FALLOC_FL_WRITE_ZEROES doesn't
have strong relations, why do you suggested to put this into the ext4
and bdev patches that adding FALLOC_FL_WRITE_ZEROES?

Thanks,
Yi.


