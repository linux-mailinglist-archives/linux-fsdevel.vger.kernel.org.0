Return-Path: <linux-fsdevel+bounces-15064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 420CC8867A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 08:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E541C23DD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 07:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7A2168D2;
	Fri, 22 Mar 2024 07:51:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089B15E80;
	Fri, 22 Mar 2024 07:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711093896; cv=none; b=GOR71TIlLhpJFdhWKdXH+KQMALNEH45MYZgSEHhcPhaOUvuihPal9Wfgxf8raLxkhmoV5O0ywZkDq9IqI3qnNfqO+I8CyVUmcbUPKOIuXlFF4ZNW6M6F+kNblBCrTXo1mvjGtvZ/U+VjzInfJJD9FgsJrmMn0GaPoGyboxySjaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711093896; c=relaxed/simple;
	bh=LrGD4CdH70Ot8YjR3/hDQnujLQga75Lm7K2IQB1C1XY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GEyv03gWhJYQNEZf1lDsccV74DqGjdBb614Cfr0YHGbjKNKcst5N312el3tTl60b9AfodXw2JpH+eChwzCrH9QyiTJCd4D3OWugU2o7Kn7P4mMB5KDRf/u/oFR7FFCXyJrFQxb9wCemty8g4d1R9IoggwNj+YakyWfPzx1dQCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V1DzY4mTVz4f3jHr;
	Fri, 22 Mar 2024 15:51:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A059E1A0BC6;
	Fri, 22 Mar 2024 15:51:29 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgCn+mx_OP1l4WJkHw--.62143S2;
	Fri, 22 Mar 2024 15:51:29 +0800 (CST)
Subject: Re: [PATCH 1/6] writeback: collect stats of all wb of bdi in
 bdi_debug_stats_show
To: Jan Kara <jack@suse.cz>
Cc: akpm@linux-foundation.org, tj@kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 willy@infradead.org, bfoster@redhat.com, dsterba@suse.com,
 mjguzik@gmail.com, dhowells@redhat.com, peterz@infradead.org
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-2-shikemeng@huaweicloud.com>
 <20240321180620.mbint45pbyc74vpg@quack3>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <a684ccdb-372f-b9e6-7239-ddb42a3f5f28@huaweicloud.com>
Date: Fri, 22 Mar 2024 15:51:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240321180620.mbint45pbyc74vpg@quack3>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCn+mx_OP1l4WJkHw--.62143S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFy5JryrKrW5Zw43uw1rWFg_yoWrZw45pF
	s8Ga1rGr48Xry7W3ZxZFWDXrWftw4Fqw12qFyIyay5Cw1DZF1akFy3uFyjyFykArZ7GFyj
	yan0y3s3urWUtFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/22/2024 2:06 AM, Jan Kara wrote:
> On Wed 20-03-24 19:02:17, Kemeng Shi wrote:
>> /sys/kernel/debug/bdi/xxx/stats is supposed to show writeback information
>> of whole bdi, but only writeback information of bdi in root cgroup is
>> collected. So writeback information in non-root cgroup are missing now.
>> To be more specific, considering following case:
>>
>> /* create writeback cgroup */
>> cd /sys/fs/cgroup
>> echo "+memory +io" > cgroup.subtree_control
>> mkdir group1
>> cd group1
>> echo $$ > cgroup.procs
>> /* do writeback in cgroup */
>> fio -name test -filename=/dev/vdb ...
>> /* get writeback info of bdi */
>> cat /sys/kernel/debug/bdi/xxx/stats
>> The cat result unexpectedly implies that there is no writeback on target
>> bdi.
>>
>> Fix this by collecting stats of all wb in bdi instead of only wb in
>> root cgroup.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> Looks mostly good, one comment below:
> 
>> ---
>>  mm/backing-dev.c | 93 ++++++++++++++++++++++++++++++++++++------------
>>  1 file changed, 70 insertions(+), 23 deletions(-)
>>
>> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
>> index 5f2be8c8df11..788702b6c5dd 100644
>> --- a/mm/backing-dev.c
>> +++ b/mm/backing-dev.c
>> @@ -39,6 +39,19 @@ struct workqueue_struct *bdi_wq;
>>  #include <linux/debugfs.h>
>>  #include <linux/seq_file.h>
>>  
>> +struct wb_stats {
>> +	unsigned long nr_dirty;
>> +	unsigned long nr_io;
>> +	unsigned long nr_more_io;
>> +	unsigned long nr_dirty_time;
>> +	unsigned long nr_writeback;
>> +	unsigned long nr_reclaimable;
>> +	unsigned long nr_dirtied;
>> +	unsigned long nr_written;
>> +	unsigned long dirty_thresh;
>> +	unsigned long wb_thresh;
>> +};
>> +
>>  static struct dentry *bdi_debug_root;
>>  
>>  static void bdi_debug_init(void)
>> @@ -46,31 +59,65 @@ static void bdi_debug_init(void)
>>  	bdi_debug_root = debugfs_create_dir("bdi", NULL);
>>  }
>>  
>> -static int bdi_debug_stats_show(struct seq_file *m, void *v)
>> +static void collect_wb_stats(struct wb_stats *stats,
>> +			     struct bdi_writeback *wb)
>>  {
>> -	struct backing_dev_info *bdi = m->private;
>> -	struct bdi_writeback *wb = &bdi->wb;
>> -	unsigned long background_thresh;
>> -	unsigned long dirty_thresh;
>> -	unsigned long wb_thresh;
>> -	unsigned long nr_dirty, nr_io, nr_more_io, nr_dirty_time;
>>  	struct inode *inode;
>>  
>> -	nr_dirty = nr_io = nr_more_io = nr_dirty_time = 0;
>>  	spin_lock(&wb->list_lock);
>>  	list_for_each_entry(inode, &wb->b_dirty, i_io_list)
>> -		nr_dirty++;
>> +		stats->nr_dirty++;
>>  	list_for_each_entry(inode, &wb->b_io, i_io_list)
>> -		nr_io++;
>> +		stats->nr_io++;
>>  	list_for_each_entry(inode, &wb->b_more_io, i_io_list)
>> -		nr_more_io++;
>> +		stats->nr_more_io++;
>>  	list_for_each_entry(inode, &wb->b_dirty_time, i_io_list)
>>  		if (inode->i_state & I_DIRTY_TIME)
>> -			nr_dirty_time++;
>> +			stats->nr_dirty_time++;
>>  	spin_unlock(&wb->list_lock);
>>  
>> +	stats->nr_writeback += wb_stat(wb, WB_WRITEBACK);
>> +	stats->nr_reclaimable += wb_stat(wb, WB_RECLAIMABLE);
>> +	stats->nr_dirtied += wb_stat(wb, WB_DIRTIED);
>> +	stats->nr_written += wb_stat(wb, WB_WRITTEN);
>> +	stats->wb_thresh += wb_calc_thresh(wb, stats->dirty_thresh);
>> +}
>> +
>> +#ifdef CONFIG_CGROUP_WRITEBACK
>> +static void bdi_collect_stats(struct backing_dev_info *bdi,
>> +			      struct wb_stats *stats)
>> +{
>> +	struct bdi_writeback *wb;
>> +
>> +	/* protect wb from release */
>> +	mutex_lock(&bdi->cgwb_release_mutex);
>> +	list_for_each_entry(wb, &bdi->wb_list, bdi_node)
>> +		collect_wb_stats(stats, wb);
>> +	mutex_unlock(&bdi->cgwb_release_mutex);
>> +}
> 
> So AFAICT this function can race against
>   bdi_unregister() -> wb_shutdown(&bdi->wb)
> 
> because that doesn't take the cgwb_release_mutex. So we either need the RCU
> protection as Brian suggested or cgwb_lock or something. But given
> collect_wb_stats() can take a significant amount of time (traversing all
> the lists etc.) I think we'll need something more clever.
Sorry for missing this. I only pay attention to wb in cgroup as there is no
much change to how we use bdi->wb.
It seems that there was always a race between orginal bdi_debug_stats_show and
release of bdi as following
cat /.../stats
bdi_debug_stats_show
			bdi_unregister
			bdi_put
			  release_bdi
			    kfree(bdi)
  use after free

I will fix this in next version. Thanks!

> 
> 								Honza
> 


