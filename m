Return-Path: <linux-fsdevel+bounces-24723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A409440DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 04:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211C8283BC4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 02:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514A71EB4AB;
	Thu,  1 Aug 2024 01:52:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12218F5C;
	Thu,  1 Aug 2024 01:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722477177; cv=none; b=N5ayFrzyOQO0ShGu87ieMykjciZxtteFSNy4gyvQDgJxymYJPq2bWYYrTtexsPDEtczIumUELmYK4Jluo0aVKvoSnF4IWQ4+whvMjWzt7nC257M49KcQqxS4UqruU2oPvh6wP023IJoH0HvIrlB89JIEAB+kfsbjs8YNluO/zIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722477177; c=relaxed/simple;
	bh=fnu8t9s2QwTd/TCltEsl3p++l1c+Pl/BUsTsX1JMsbE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UHFNY8Jx/NGoeDQYUctrZZrNeYmQ6OdiX+I6vGaeZQ9FfglufwThSRCW4jucnG5jso7X6T6OtiRbsk03Bsnx9/v6uSpI+kMALAN/O04/3Z9zwXEfNC2DqwcOTt42l7ArZHLnhSdGyWd2bRz4pcN+izewbyYhQPRrjaZYzGCY4Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WZBmj3K6kz4f3kvm;
	Thu,  1 Aug 2024 09:52:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7271F1A018D;
	Thu,  1 Aug 2024 09:52:51 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4Vx6qpmQ921AQ--.14765S3;
	Thu, 01 Aug 2024 09:52:51 +0800 (CST)
Subject: Re: [PATCH 5/6] iomap: drop unnecessary state_lock when setting ifs
 uptodate bits
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
 brauner@kernel.org, david@fromorbit.com, jack@suse.cz, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240731091305.2896873-1-yi.zhang@huaweicloud.com>
 <20240731091305.2896873-6-yi.zhang@huaweicloud.com>
 <ZqprvNM5itMbanuH@casper.infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <995196b3-3571-b23f-eb5f-d3fee5d97593@huaweicloud.com>
Date: Thu, 1 Aug 2024 09:52:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZqprvNM5itMbanuH@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHL4Vx6qpmQ921AQ--.14765S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WryUAw1DWF4xtFyDWw1ftFb_yoW8Jr43pF
	9Y9F9akr4DJFWSkrnFv3W8XF1093sxCa45GF95Jr15Za98WFyagFZ7tF45ZrW8J3s3WFZF
	va1UWr98GayDZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/8/1 0:52, Matthew Wilcox wrote:
> On Wed, Jul 31, 2024 at 05:13:04PM +0800, Zhang Yi wrote:
>> Commit '1cea335d1db1 ("iomap: fix sub-page uptodate handling")' fix a
>> race issue when submitting multiple read bios for a page spans more than
>> one file system block by adding a spinlock(which names state_lock now)
>> to make the page uptodate synchronous. However, the race condition only
>> happened between the read I/O submitting and completeing threads, it's
>> sufficient to use page lock to protect other paths, e.g. buffered write
>> path. After large folio is supported, the spinlock could affect more
>> about the buffered write performance, so drop it could reduce some
>> unnecessary locking overhead.
> 
> This patch doesn't work.  If we get two read completions at the same
> time for blocks belonging to the same folio, they will both write to
> the uptodate array at the same time.
> 
This patch just drop the state_lock in the buffered write path, doesn't
affect the read path, the uptodate setting in the read completion path
is still protected the state_lock, please see iomap_finish_folio_read().
So I think this patch doesn't affect the case you mentioned, or am I
missing something?

Thanks,
Yi.


