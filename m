Return-Path: <linux-fsdevel+bounces-19800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D1B8C9D85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 14:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202921C22D26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 12:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D7955E75;
	Mon, 20 May 2024 12:39:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A050275;
	Mon, 20 May 2024 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208799; cv=none; b=CKKqOkurqC/mHOsbxgzY7QOZJ9WOR0fy98b+dmOCESxQJ+rP1IIdurw/7VfUCbv/SG/87qyvsTVn06HR72mbK2CeaRJCS/4ouoYlBZsY+WVVM0+J3vZ5tSfTOg3DsP1/4hM34eJkJm0K+2HKLfpRvFWxzL8uf2KY5qK/IBq9Bow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208799; c=relaxed/simple;
	bh=RMALe9odXTlOhasHrwx7JoyA/Hw3+Z+zypbJzTqfiiM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=P30tjZUr8uqFNitAxl3na9B2J2VaKWCLEiGzbQ+GgiocHCoC36mi/2oEKm1C0RGEUjMwO5h0hO+Cc9lQYv1lTtYS/Tgnq7tryInRdp9nxTyAX6Axu99PYC5VoaVEJKwQt+N/zpSxy7FQgWdDJsrE5g7vuOk44iRXf0VhYWNkqXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vjcb24YNPz4f3l1K;
	Mon, 20 May 2024 20:39:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0A02B1A016E;
	Mon, 20 May 2024 20:39:53 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgDnCw+XREtma4YLNg--.33126S3;
	Mon, 20 May 2024 20:39:52 +0800 (CST)
Subject: Re: [PATCH] ext4/jbd2: drop jbd2_transaction_committed()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240513072119.2335346-1-yi.zhang@huaweicloud.com>
 <20240515002513.yaglghza4i4ldmr5@quack3>
 <f0eb115d-dd10-e156-9aed-65b7f479f008@huaweicloud.com>
 <20240520084906.ejykv3xwn7l36jbg@quack3>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <8d85f75e-cf9e-b3da-766f-59d80d608203@huaweicloud.com>
Date: Mon, 20 May 2024 20:39:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240520084906.ejykv3xwn7l36jbg@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDnCw+XREtma4YLNg--.33126S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF43Kr43Ar1UGr4rKw17Jrb_yoW8Wry5pF
	W8Ka47Ka17tr1Svrn7trnrZFy2yw1Ikry8Gr9F9ryqk3yUG3sagrWftryak34Duw1kGayI
	9rWFgFZrG3W5ua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/20 16:49, Jan Kara wrote:
> On Thu 16-05-24 16:27:25, Zhang Yi wrote:
>> On 2024/5/15 8:25, Jan Kara wrote:
>>> On Mon 13-05-24 15:21:19, Zhang Yi wrote:
>>> Also accessing j_commit_sequence without any
>>> lock is theoretically problematic wrt compiler optimization. You should have
>>> READ_ONCE() there and the places modifying j_commit_sequence need to use
>>> WRITE_ONCE().
>>>
>>
>> Thanks for pointing this out, but I'm not sure if we have to need READ_ONCE()
>> here. IIUC, if we add READ_ONCE(), we could make sure to get the latest
>> j_commit_sequence, if not, there is a window (it might becomes larger) that
>> we could get the old value and jbd2_transaction_committed() could return false
>> even if the given transaction was just committed, but I think the window is
>> always there, so it looks like it is not a big problem, is that right?
> 
> Well, all accesses to any memory should use READ_ONCE(), be protected by a
> lock, or use types that handle atomicity on assembly level (like atomic_t,
> or atomic bit operations and similar). Otherwise the compiler is free to
> assume the underlying memory cannot change and generate potentionally
> invalid code. In this case, I don't think realistically any compiler will
> do it but still it is a good practice and also it saves us from KCSAN
> warnings. If you want to know more details about possible problems, see
> 
>   tools/memory-model/Documentation/explanation.txt
> 
> chapter "PLAIN ACCESSES AND DATA RACES".
> 

Sure, this document is really helpful, I'll add READ_ONCE() and
WRITE_ONCE() here, thanks a lot.

Yi.


