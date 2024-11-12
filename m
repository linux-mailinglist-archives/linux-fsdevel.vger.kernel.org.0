Return-Path: <linux-fsdevel+bounces-34396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C6F9C4F1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 08:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767791F2359A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 07:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA91120ADFA;
	Tue, 12 Nov 2024 07:05:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91CC20A5F1;
	Tue, 12 Nov 2024 07:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731395159; cv=none; b=KE+rs+ZH+r591gs7pu64N8xyafbMN6ZAa0I91oF2Ej/CL75T95WMNOkWivv4PcOFOBiOjntoD1MW6D+RuUoEiVeN1xx6cgkoE1+6CVluCzpplcQueMmoaMEnOVWAgIIcrwHozkFPvU00M0pChg0TO8dc4Jtxt7aXtktWeTc404Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731395159; c=relaxed/simple;
	bh=EcsYETK8R+xF72C+3z/nYsPavgNhoJDLZWQv3GLY/WA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CJT915Hpd+uNYuH/Zbg8FQ+HVEm8IAv8BqdlFJMwzMUSMNwImC1E5GgQ11RshAM9ZDFiesEQU2tOERTZHB+wSuL9oWxOQrBaP/kxF2C54nnIBOVS+kWmoElf6a4HaE1mG1s2BBip1rygwD1XRwiJ0MibxWwLlKt/apsAC0EsGSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XncrG4WTjz4f3jRG;
	Tue, 12 Nov 2024 15:05:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CBBA91A0197;
	Tue, 12 Nov 2024 15:05:52 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgDHb7FP_jJnKDoTBg--.23277S2;
	Tue, 12 Nov 2024 15:05:52 +0800 (CST)
Subject: Re: [PATCH RESEND V2 0/5] Fixes and cleanups to xarray
To: Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20241111215359.246937-1-shikemeng@huaweicloud.com>
 <20241111132816.3dcbb113241353e9a544adab@linux-foundation.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <8667a8e9-8052-4a32-817a-2c4ef97ddfbe@huaweicloud.com>
Date: Tue, 12 Nov 2024 15:05:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241111132816.3dcbb113241353e9a544adab@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDHb7FP_jJnKDoTBg--.23277S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurW3Cw43tF17Ww1fXw47urg_yoW5Wr1kpa
	yrCa47ArykJF1rGrn7Za1Ig3WF9w4rXr45JrWrWry2y343Gr1Yvr12g3yavFyDCrs3Cr1Y
	qFW0v3s5XFs8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVb
	kUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 11/12/2024 5:28 AM, Andrew Morton wrote:
> On Tue, 12 Nov 2024 05:53:54 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:
> 
>> This series contains some random fixes and cleanups to xarray. Patch 1-3
>> are fixes and patch 4-5 are cleanups. More details can be found in
>> respective patches. 
> 
> As we're at -rc7 I'm looking to stash low-priority things away for
> consideration after 6.13-r1.
> 
> But I don't know if all of these are low-priority things.  Because you
> didn't tell me!
> 
> Please please always always describe the possible userspace-visible effects of
> all fixes.  And all non-fixes, come to that.>
> So.  Please go through all of the patches in this series and redo the
> changelogs, describing the impact each patch might have for our users.
Sorry for missing these information, I will add detail of impact to userspace
in next version.
As there are a lot of users of xarray in kernel and I'm not familar to
most of them, I maybe not able to send new series with description of
userspace-visible effects in time. I'd like to describe effect to users
of xarray in kernel here to give some early inputs.

Patch 1 fixes the issue that xas_find_marked() will return a sibling entry
to users when there is a race to replace old entry with small range with
a new entry with bigger range. The kernel will crash if users use returned
sibling entry as a valid entry.
For example, find_get_entry() will crash if it gets a sibling entry from
xas_find_marked() when trying to search a writeback folios.

Patch 2 fixes the issue that xas_split_alloc() doesn't distinguish large
entries whose order is == xas->xa_shift + 2 * XA_CHUNK_SHIFT in whice case
the splited entries have bigger order than expected. Then afterward
xas_store will assign stored entry with bigger range than expected and we
will get wrong entry from slot after actual range of stored entry. Not
sure if we will split large entry with order == xas->xa_shift + 2 *
XA_CHUNK_SHIFT.

Patch 3 fixes the issue that xas_pause() may skip some entry unepxectedly
after xas_load()(may be called in xas_for_each for first entry) loads a
large entry with index point at mid of the entry. So we may miss to writeback
some dirty page and lost user data.

> 
> If any of these patches should, in your opinion, be included in 6.12
> and/or backported into -stable trees then it would be better to
> separate them into a different patch series.  But a single patch series
> is acceptable - I can figure this stuff out, if I'm given the necessary
> information!  
As impact descripted above, patch 1-3 should be include in 6.12 and backported
into -stable trees. But we need to confirm if the trigger condition exists
in users(filemap, shmem and so on) of xarray in real world. Will include more
information in next version.

Thanks.
> 
> Thanks.
> 


