Return-Path: <linux-fsdevel+bounces-70195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8E0C9360F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 02:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2CF3A9B3C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 01:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59A81D5CD1;
	Sat, 29 Nov 2025 01:32:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3B6182B7;
	Sat, 29 Nov 2025 01:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764379956; cv=none; b=qW5qrwkoN86R16DmeFdgCn75VE+fbwuMm6JObRuIflOhbtyONuuLZyWFQZKEbc8hXJmEJwtnU2+rEbeLCEkD8yTXN1LTxHga/vZ58XuwGWb6bjz5zT/L3H8BkwV35zLIHqDhWt4c+Vy4rq+fKQ3jyhw0tfEM/w8YkSToq6zsTs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764379956; c=relaxed/simple;
	bh=Gr/qED2MiqIBmBbu5xmiUz+E93dJowUD0NQlY5cfWvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctuYS4t5fSwQe0pXMhkIHr35CYIph6yWAyORRnayN4a8yyYfOvCnHnVTVyLgv3jIUemt2mMfqrSmRg85NUzCN8qPRLUqMguY8g4g0KLt1yILzqsOjYcSab/eHWGs2XsI2kqMoStOXhD24hCAxpi3Qs85T+i/vtca+lIocKPWma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dJCLq2ZvPzKHMJr;
	Sat, 29 Nov 2025 09:31:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id EF7EE1A13B2;
	Sat, 29 Nov 2025 09:32:29 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgAHZXsqTSppiaV+CQ--.54014S3;
	Sat, 29 Nov 2025 09:32:27 +0800 (CST)
Message-ID: <58148859-dad6-4a1a-82ef-2a6099e2464d@huaweicloud.com>
Date: Sat, 29 Nov 2025 09:32:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] ext4: replace ext4_es_insert_extent() when
 caching on-disk extents
To: Theodore Tso <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
 yi.zhang@huawei.com, yizhang089@gmail.com, libaokun1@huawei.com,
 yangerkun@huawei.com
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251128164959.GC4102@macsyma-3.local>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251128164959.GC4102@macsyma-3.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAHZXsqTSppiaV+CQ--.54014S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1rGw45Zr4xGry7AF18Zrb_yoW8GF18pr
	Wag345Kr4kXrWUAayfZrWUZFn0vwn5Cr9xG3Z3Grnxuws0ga4IgryF93yj9F1Ut395Ga12
	gF129rnY9w4UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hi, Ted!

On 11/29/2025 12:49 AM, Theodore Tso wrote:
> Thanks to Jan and Ojaswin for their comments and reviews on this patch set.
> 
> As you may have noticed this version of the patchset is currently in
> the ext4.git tree, and has shown up in linux-next.

The ext4.git tree[1] shows that only the first three patches from this
v2 version have been merged, possibly because the fourth patch conflicted
with ErKun's patch[2]. I've written a new version locally, adding two fix
patches for the three merged patches, and then rebase the subsequent
patches and modify them directly. I can send them out after texting.
Is this okay?

Thanks,
Yi.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/log/?h=dev
[2] https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=dev&id=dac092195b6a35bc7c9f11e2884cfecb1b25e20c

> 
> Given that we have some suggested changes, there are a couple of ways
> we can handle this:
> 
> 1) Zhang Yi could produce a new version of the patch set, and I'll
> replace the v2 version of the patch set currently in the ext4.git tree
> with a newer version.
> 
> 2) We could append fix-up patches to the ext4.git tree to reflect
> those changes.
> 
> 3) I could drop the patch set entirely and we apply a later version
> of the patch series after the merge window.
> 
> What are folks' preferences?
> 
> Thanks,
> 
> 						- Ted


