Return-Path: <linux-fsdevel+bounces-15956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BDB89625D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 04:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30789286A7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 02:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6938F18EB8;
	Wed,  3 Apr 2024 02:16:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302F4168DA;
	Wed,  3 Apr 2024 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712110591; cv=none; b=TdTAzjSzTcollk/7Rgu6hvsYzLYwXMucy8BbaMwVQw3HnqNTj8bsccJb85BmRJysu58REZ+SfZsWOE0tubLI+b6hcVvFGayYmEDyLIQVaSFTXbuxOz4TUBn6gdj718ZUtMAeC6y45thTsirNczSTwXPjXT9rEE5qxUthb5Kcu68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712110591; c=relaxed/simple;
	bh=/harYmdcmE4WTbyR7q+2wKYBbOjJgq8gcNlGXufYIkM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aR9LLOTCSX0yxmS7/8BRmsQ7NhpxCqHmpFF1o6eNG8+4545m5xdVVLa4h8kK+xlptvPIpgD2e4bnmku792pMViy38Sl167x1dRKsunjI/RFsnjjZ4QV7ruTsefAO0GmQrEgVHzibo9HDpmP884i+RaS8LJ7AE5cloRDr4QbLvSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V8SzQ2PWXz4f3khh;
	Wed,  3 Apr 2024 10:16:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D04941A0176;
	Wed,  3 Apr 2024 10:16:24 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgAXMgv2uwxmq02RIw--.21036S2;
	Wed, 03 Apr 2024 10:16:24 +0800 (CST)
Subject: Re: [PATCH v2 1/6] writeback: protect race between bdi release and
 bdi_debug_stats_show
To: Brian Foster <bfoster@redhat.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz,
 tj@kernel.org, dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <20240327155751.3536-2-shikemeng@huaweicloud.com> <ZgWum7SWr44w0rie@bfoster>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <7232e82a-5073-003c-539f-f4627a9ee688@huaweicloud.com>
Date: Wed, 3 Apr 2024 10:16:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZgWum7SWr44w0rie@bfoster>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAXMgv2uwxmq02RIw--.21036S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4fWF47CF18JFW3Ww15urg_yoW5ArW8pa
	15Ga98Kr48X34agr13ZayDur9aqw40qrnrWF97ua1rAr1kCr1SkFyIkryj9r95ZrZ7Cw1Y
	va15Ar9rC3yDAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/29/2024 1:53 AM, Brian Foster wrote:
> On Wed, Mar 27, 2024 at 11:57:46PM +0800, Kemeng Shi wrote:
>> There is a race between bdi release and bdi_debug_stats_show:
>> /* get debug info */		/* bdi release */
>> bdi_debug_stats_show
>>   bdi = m->private;
>>   wb = &bdi->wb;
>> 				bdi_unregister
>> 				bdi_put
>> 				  release_bdi
>> 				    kfree(bdi)
>>   /* use after free */
>>   spin_lock(&wb->list_lock);
>>
> 
> Maybe I'm missing something, but it looks to me that
> bdi_unregister_debug() can't complete until active readers of associated
> debugfs files have completed. For example, see __debugfs_file_removed()
> and use of ->active_users[_drained]. Once the dentry is unlinked,
> further reads fail (I think) via debugfs_file_get(). Hm?
Sorry for missing this. The race seems not possible if debugfs could prevent
this. Thanks for the information. I will drop this in next version.

Kemeng

> 
> Brian
> 
>> Search bdi on bdi_list under rcu lock in bdi_debug_stats_show to ensure
>> the bdi is not freed to fix the issue.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  mm/backing-dev.c | 33 +++++++++++++++++++++++++++++++--
>>  1 file changed, 31 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
>> index 5f2be8c8df11..70f02959f3bd 100644
>> --- a/mm/backing-dev.c
>> +++ b/mm/backing-dev.c
>> @@ -46,16 +46,44 @@ static void bdi_debug_init(void)
>>  	bdi_debug_root = debugfs_create_dir("bdi", NULL);
>>  }
>>  
>> -static int bdi_debug_stats_show(struct seq_file *m, void *v)
>> +static struct backing_dev_info *lookup_bdi(struct seq_file *m)
>>  {
>> +	const struct file *file = m->file;
>>  	struct backing_dev_info *bdi = m->private;
>> -	struct bdi_writeback *wb = &bdi->wb;
>> +	struct backing_dev_info *exist;
>> +
>> +	list_for_each_entry_rcu(exist, &bdi_list, bdi_list) {
>> +		if (exist != bdi)
>> +			continue;
>> +
>> +		if (exist->debug_dir == file->f_path.dentry->d_parent)
>> +			return bdi;
>> +		else
>> +			return NULL;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +
>> +static int bdi_debug_stats_show(struct seq_file *m, void *v)
>> +{
>> +	struct backing_dev_info *bdi;
>> +	struct bdi_writeback *wb;
>>  	unsigned long background_thresh;
>>  	unsigned long dirty_thresh;
>>  	unsigned long wb_thresh;
>>  	unsigned long nr_dirty, nr_io, nr_more_io, nr_dirty_time;
>>  	struct inode *inode;
>>  
>> +	rcu_read_lock();
>> +	bdi = lookup_bdi(m);
>> +	if (!bdi) {
>> +		rcu_read_unlock();
>> +		return -EEXIST;
>> +	}
>> +
>> +	wb = &bdi->wb;
>>  	nr_dirty = nr_io = nr_more_io = nr_dirty_time = 0;
>>  	spin_lock(&wb->list_lock);
>>  	list_for_each_entry(inode, &wb->b_dirty, i_io_list)
>> @@ -101,6 +129,7 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
>>  		   nr_dirty_time,
>>  		   !list_empty(&bdi->bdi_list), bdi->wb.state);
>>  
>> +	rcu_read_unlock();
>>  	return 0;
>>  }
>>  DEFINE_SHOW_ATTRIBUTE(bdi_debug_stats);
>> -- 
>> 2.30.0
>>
> 
> 


