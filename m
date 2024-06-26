Return-Path: <linux-fsdevel+bounces-22513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5436091825B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 15:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E26F3B27017
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 13:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC994181CE5;
	Wed, 26 Jun 2024 13:28:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2428181326;
	Wed, 26 Jun 2024 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408526; cv=none; b=g7ZPGGecp4LvzfBxMHg0TecYduW3cSqkANt985GUCO0kwTAnd89Ocx6go9BDETQFIaN+ikwM45QFtdvZMzSJ7fy5R9K3mMcUqFCvHUTdlVsnvSjTBPbT6FX0klsDR6CP+Iqt9rs/VogwiHfHk/ilNaFm2I1Mr3FqtlY+tJiifXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408526; c=relaxed/simple;
	bh=dC6GP9/oaLl6FQTpY3wSzhic8KMRpCzvW8QGmRCpcpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MM1XKPVAfYvat05taxokXXUuzvoT8fsUhzCRNxacx5Qk+5BpyWs5AdgOu6cNYRkbffWbNFWMxzs2TRRjTKZ3YxQbkKMqWoKbbO+mm0jttgIgkLklQWiEHGxeQn2oHEmpCFE7pjNrlww8gflUAOPyAcjpOdREt1wRELI471K+KzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W8MwD6WKnz4f3l1m;
	Wed, 26 Jun 2024 21:28:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 15A2A1A0170;
	Wed, 26 Jun 2024 21:28:41 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgD3IH2CF3xm2VGPAQ--.5318S3;
	Wed, 26 Jun 2024 21:28:38 +0800 (CST)
Message-ID: <f3a1084a-5b0d-4e4c-b78b-1a67082fc172@huaweicloud.com>
Date: Wed, 26 Jun 2024 21:28:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/5] cachefiles: some bugfixes for withdraw and
 xattr
To: Christian Brauner <brauner@kernel.org>
Cc: netfs@lists.linux.dev, dhowells@redhat.com, jlayton@kernel.org,
 hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
 zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
 wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>,
 Baokun Li <libaokun@huaweicloud.com>
References: <20240522115911.2403021-1-libaokun@huaweicloud.com>
 <4f357745-67a6-4f2e-8d69-2f72dc8a42d0@huaweicloud.com>
 <20240626-ballungszentrum-zugfahrt-b45c1790ed7b@brauner>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <20240626-ballungszentrum-zugfahrt-b45c1790ed7b@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgD3IH2CF3xm2VGPAQ--.5318S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XFyDCFy5JryUuryxJryUGFg_yoWxuwb_uF
	95uF97C3ykCrWj9a17WFW5ArsxKFyxX3sYywn7XFy3K34furWkAF4rGFZxAry3GFWrJF95
	Cas8Wanavw1aqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOmhFUU
	UUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAGBV1jkHpckwAAsa

On 2024/6/26 21:16, Christian Brauner wrote:
> On Wed, Jun 26, 2024 at 11:03:10AM GMT, Baokun Li wrote:
>> A gentle ping.
> Hm? That's upstream in
>
> commit a82c13d29985 ('Merge patch series "cachefiles: some bugfixes and cleanups for ondemand requests"')
Due to the large number of patches, these patches have been
divided into three patch sets according to their dependencies.

The 12 patches that have been merged in are the largest set,
and there are two other sets that have not yet been merged in.

The current patch set is one of the unmerged sets, and the other
set is:
https://patchwork.kernel.org/project/linux-fsdevel/list/?series=853409

Thanks,

-- 
With Best Regards,
Baokun Li


