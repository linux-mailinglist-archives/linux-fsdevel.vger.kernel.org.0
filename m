Return-Path: <linux-fsdevel+bounces-59338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47413B3787A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 05:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E3C47A3430
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 03:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D163074B6;
	Wed, 27 Aug 2025 03:13:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DCF1AB52D;
	Wed, 27 Aug 2025 03:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756264410; cv=none; b=BD57sepTMOzXBiDOp+m23AQPpXXhskDn1v/XLzNG1KFiYtBuC7JoByVf+uLYLbb3Id7Uigp3BEhAMpUINwaLrw+k0JjyQfvw7iIzhcPMEMcBYJzyrhfHovUywsPgNKl7kKZAd4LSBi/EhMpJmmGT3OhMqjfiiZVj45C3Ok3PF7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756264410; c=relaxed/simple;
	bh=dVQ2iRM0B9mG/QkcgL/3eV7ZWiGhjSm9OFZfHWGE5f8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NjC/xb3NeHINBJENXHMiz2PuwtLFHSMN5/Pgz21Dcbcx3tsvd1TSqf8kf8ibZzCSCJ1KICRa82/YbWZ4ZrlTf1X22ePJRbPW4oBoQNfkp8d7p9R/TtUQMsZRv4HxIg5haRr+YbapzP5iqw1bw2wL8XN4as8yrRmbSUwO2HNW6l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cBV3L0mjxzKHMc1;
	Wed, 27 Aug 2025 11:13:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B9F0B1A1040;
	Wed, 27 Aug 2025 11:13:17 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCn8IzJd65o6fO3AQ--.46037S3;
	Wed, 27 Aug 2025 11:13:15 +0800 (CST)
Subject: Re: [REGRESSION] loop: use vfs_getattr_nosec for accurate file size
To: Theodore Ts'o <tytso@mit.edu>, Rajeev Mishra <rajeevm@hpe.com>
Cc: linux-block@vger.kernel.org,
 Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>, "yukuai (C)" <yukuai3@huawei.com>
References: <20250827025939.GA2209224@mit.edu>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <274c312c-d0e5-10af-0ef0-bab92e71eb64@huaweicloud.com>
Date: Wed, 27 Aug 2025 11:13:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250827025939.GA2209224@mit.edu>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8IzJd65o6fO3AQ--.46037S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF18Cr4rGr48ZryxJF45GFg_yoW8Ww4xpa
	9a9F1Ykr1DKr1UCFWjgr1UZ3W0grZ5X3sxWr18twn3ZFyUt34jkr929r43WF4Ykryrua1a
	kwna93s09r4IvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwx
	hLUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/27 10:59, Theodore Ts'o Ð´µÀ:
> Hi, I was testing 6.17-rc3, and I noticed a test failure in fstest
> generic/563[1], when testing both ext4 and xfs.  If you are using my
> test appliance[2], this can be trivially reproduced using:
> 
>     kvm-xfstests -c ext4/4k generic/563
> or
>     kvm-xfstests -c xfs/4k generic/563
> 
> [1] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/generic/563
> [2] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
> 
> A git bisect pointed the problem at:
> 
> commit 47b71abd58461a67cae71d2f2a9d44379e4e2fcf
> Author: Rajeev Mishra <rajeevm@hpe.com>
> Date:   Mon Aug 18 18:48:21 2025 +0000
> 
>      loop: use vfs_getattr_nosec for accurate file size
>      
>      Use vfs_getattr_nosec() in lo_calculate_size() for getting the file
>      size, rather than just read the cached inode size via i_size_read().
>      This provides better results than cached inode data, particularly for
>      network filesystems where metadata may be stale.
>      
>      Signed-off-by: Rajeev Mishra <rajeevm@hpe.com>
>      Reviewed-by: Yu Kuai <yukuai3@huawei.com>
>      Link: https://lore.kernel.org/r/20250818184821.115033-3-rajeevm@hpe.com
>      [axboe: massage commit message]
>      Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ... and indeed if I go to 6.17-rc3, and revert this commit,
> generic/563 starts passing again.
> 
> Could you please take a look, and/or revert this change?  Many thanks!

This is fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-6.17&id=d14469ed7c00314fe8957b2841bda329e4eaf4ab

Thanks,
Kuai

> 
>        	  	      	      	 	- Ted
> 
> .
> 


