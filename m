Return-Path: <linux-fsdevel+bounces-38563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE868A03F79
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 13:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8555918871AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 12:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275A81E9B3A;
	Tue,  7 Jan 2025 12:38:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923848F6B;
	Tue,  7 Jan 2025 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253538; cv=none; b=drfCjSccDOWEjQyIHebg04pb4YOw72w1yWdrj3IJZpEFI/284Al8BTbfVJEU1QnLf/FZ/ZeoGJQgXFqG9TujEGXWPvMWVYar5B+fBhmgtjbMwC+imBRlzcwWeBcchVz5E99wOzACjh4Yt0NV65lKE7rVO8GKF0XKycHKdVBvTXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253538; c=relaxed/simple;
	bh=L0nfuSD2CSSJ7OAPd80iCht8aeMgdGjN/dt4w7/FAVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCHHj85UHtXKiZcgnN0NKMoiAjFY7XdXo6o0SHLUcLBkbFq5kky4W2SrT8RDxEKTBkiySqo5G/AfIFHyJniWbagsONd423BP/BqEzipXueRYIgwLPJWN+OZtdCmDdiqaat9l66uNa3eAtZ952zzGIkNZpOi7sAJNOVd4H29wMVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YS9ZZ2H1lz4f3lWJ;
	Tue,  7 Jan 2025 20:38:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9F5681A0E98;
	Tue,  7 Jan 2025 20:38:51 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDHKl9ZIH1nZKstAQ--.45269S3;
	Tue, 07 Jan 2025 20:38:51 +0800 (CST)
Message-ID: <3e443003-ff12-45c8-b41b-65a0af43de61@huaweicloud.com>
Date: Tue, 7 Jan 2025 20:38:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] fs: introduce FALLOC_FL_FORCE_ZERO to fallocate
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, tytso@mit.edu, djwong@kernel.org, adilger.kernel@dilger.ca,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com, Sai Chaitanya Mitta <mittachaitu@gmail.com>,
 linux-xfs@vger.kernel.org
References: <20241228014522.2395187-1-yi.zhang@huaweicloud.com>
 <20241228014522.2395187-2-yi.zhang@huaweicloud.com>
 <Z3u-OCX86j-q7JXo@infradead.org>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <Z3u-OCX86j-q7JXo@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDHKl9ZIH1nZKstAQ--.45269S3
X-Coremail-Antispam: 1UD129KBjvJXoW7JFyDuFW5ZFW7Ww4DKr4fGrg_yoW8JF17pF
	WYkF4vy3Z093W09w18Za1kXFyFv3y8Gay5JrySqrWkAr15Gr12yF18WFyY9Fy8Cr97Ww4Y
	q3yavF9xuF1UuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	aFAJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/1/6 19:27, Christoph Hellwig wrote:
> There's a feature request for something similar on the xfs list, so
> I guess people are asking for it.
> 
> That being said this really should not be a modifier but a separate
> operation, as the logic is very different from FALLOC_FL_ZERO_RANGE,
> similar to how plain prealloc, hole punch and zero range are different
> operations despite all of them resulting in reads of zeroes from the
> range.

OK, it seems reasonable to me, and adding a new operation would be
better. There is actually no need to mix it with the current
FALLOC_FL_ZERO_RANGE.

> 
> That will also make it more clear that for files or file systems that
> require out place writes this operation should fail instead of doing
> pointless multiple writes.
> 
> Also please write a man page update clearly specifying the semantics,
> especially if this should work or not if there is no write zeroes
> offload in the hardware, or if that offload actually writes physical
> zeroes to the media or not.
> 

Sure. thanks for your advice.

Thanks,
Yi.

> Btw, someone really should clean up the ext4 fallocate code to use
> helper adnd do the
> 
> 	switch (mode & FALLOC_FL_MODE_MASK) {
> 	}
> 
> and then use helpers for each mode whih will make these things a lot
> more obvious.


