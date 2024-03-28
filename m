Return-Path: <linux-fsdevel+bounces-15498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1C988F505
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 03:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B776B23655
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 01:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9435F24219;
	Thu, 28 Mar 2024 01:59:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8708E22618;
	Thu, 28 Mar 2024 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711591190; cv=none; b=iv6OcEtcyeU2MCUWEZPF7sl7XqAquBFp81ALRCGVfjz71mp0CpHJbvDV/6TumViSOdDUPWR4jZiguV/rHiN8Edfhsv9o83iwoPYAVPWvavbCvw8ITd7JBq0TqAMnYkcghaTkFyt8tgpfiNVw38nSEqZpUE81RpS6KlyDjuOr9Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711591190; c=relaxed/simple;
	bh=CaFAYNasP3QvvTHntEwDpAEI0ipNZngQgZKNvavFEa0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZN00edYMeBwBKJ6lDTLMOdlAyfDV/VOvVL9k9Ddpba5tQYhk52ENNUSJgaDTZlfAy8O2SUZxtnhC2dLQ1mO9dFtFYz3U7W4O9ko8QbMrCg1ezwSOtfALyNilmxUOpWeuvGZWXNRSQ3bsM6c/rtQ0WMaGgCCsq5NQNb1E1tIdD5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V4mtt6YWLz4f3kkc;
	Thu, 28 Mar 2024 09:59:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F381F1A0E41;
	Thu, 28 Mar 2024 09:59:38 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgD3EQsIzwRmGgktIQ--.20517S2;
	Thu, 28 Mar 2024 09:59:37 +0800 (CST)
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
To: Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, jack@suse.cz, bfoster@redhat.com, tj@kernel.org,
 dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <20240327104010.73d1180fbabe586f9e3f7bd2@linux-foundation.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <05bae65c-99fa-34f2-43e6-9a16f7d1ddc7@huaweicloud.com>
Date: Thu, 28 Mar 2024 09:59:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240327104010.73d1180fbabe586f9e3f7bd2@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgD3EQsIzwRmGgktIQ--.20517S2
X-Coremail-Antispam: 1UD129KBjvJXoWrur4rZrWUtF43Xr4kZw4kXrb_yoW8Jryfpa
	95Ga1Ykr17AF4rJan7CF12kw15X3ZxKFy7X39rJw1fJFWY9a4Y9rs293yFg3WfZ397Kryj
	qan3WFyvv3WjkrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUOyCJDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/


on 3/28/2024 1:40 AM, Andrew Morton wrote:
> On Wed, 27 Mar 2024 23:57:45 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:
> 
>> This series tries to improve visilibity of writeback.
> 
> Well...  why?  Is anyone usefully using the existing instrumentation? 
> What is to be gained by expanding it further?  What is the case for
> adding this code?
> 
> I don't recall hearing of anyone using the existing debug
> instrumentation so perhaps we should remove it!
Hi Andrew, this was discussed in [1]. In short, I use the
debug files to test change in submit patchset [1]. The
wb_monitor.py is suggested by Tejun in [2] to improve
visibility of writeback.
I use the debug files to test change in [1]. The wb_monitor.py is suggested by Tejun
in [2] to improve visibility of writeback.
> 
> Also, I hit a build error and a pile of warnings with an arm
> allnoconfig build.
> 
Sorry for this, I only tested on x86. I will look into this and
fix the build problem in next version.

[1] https://lore.kernel.org/lkml/44e3b910-8b52-5583-f8a9-37105bf5e5b6@huaweicloud.com/
[2] https://lore.kernel.org/lkml/a747dc7d-f24a-08bd-d969-d3fb35e151b7@huaweicloud.com/
[3] https://lore.kernel.org/lkml/ZcUsOb_fyvYr-zZ-@slm.duckdns.org/


