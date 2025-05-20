Return-Path: <linux-fsdevel+bounces-49504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB19ABD8C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 15:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E810188CDF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 13:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BF222D4EF;
	Tue, 20 May 2025 13:05:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335E12F5A5;
	Tue, 20 May 2025 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747746304; cv=none; b=a+KscoiK2Vaj9bzAks8ZObnYICAejWSegZibTQssG+p2K3IiqbvczSLmiXI1v2VGQVdM6FTmfufLnNrTgTVzw7lNlGFzkOFJKxOMbvOMBn0EIB+fhcxwLVWaYaB9pnsvCbyjJqXCex8eDgbckXORzqHaoML8TeNX3Jwx4IDDlWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747746304; c=relaxed/simple;
	bh=0muRCv3c3eJ7g6gmyBRD0irSfDgk2oTjiNhBPV+L93Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1yXcsRjtEj7j8q/IWI3gsoMdjIf85pVzB+GXyFiqfNKkA8q/7KzcPR7drSNZtIzUUxVjWBQerMU7PBH6ppSxHfyRsSsRi0mMJ2Iz25qET+j41SXBd4nTwYLUVGf5/sLVpeix8bcDQXS5B5sdBlQhXi48TQXPEGsy3IvMnpdYlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4b1vsC43rdz4f3l26;
	Tue, 20 May 2025 21:04:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0B61A1A06DC;
	Tue, 20 May 2025 21:04:58 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl_4fSxoiCXqMw--.54580S3;
	Tue, 20 May 2025 21:04:57 +0800 (CST)
Message-ID: <a5145aba-1412-488d-9d8d-05a108029327@huaweicloud.com>
Date: Tue, 20 May 2025 21:04:55 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] ext4: correct the journal credits calculations of
 allocating blocks
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, willy@infradead.org, adilger.kernel@dilger.ca,
 jack@suse.cz, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
 <20250512063319.3539411-6-yi.zhang@huaweicloud.com>
 <2e127ed8-20a2-4610-8fd8-e2095bde0577@huaweicloud.com>
 <20250519154800.GD38098@mit.edu>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250519154800.GD38098@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXOl_4fSxoiCXqMw--.54580S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JryUJrWrurWxZF4rurW8tFb_yoWDtFb_ZF
	48ArZ2vFyUGF1xGanFkrs7CFs2vayfG345Gry8W34UKw1rAF4kGanYkr9xZrnxGFyrJr98
	uFn0qr1aq3W2vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOB
	MKDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/5/19 23:48, Theodore Ts'o wrote:
> On Mon, May 19, 2025 at 10:48:28AM +0800, Zhang Yi wrote:
>>
>> This patch conflicts with Jan's patch e18d4f11d240 ("ext4: fix
>> calculation of credits for extent tree modification") in
>> ext4_ext_index_trans_blocks(), the conflict should be resolved when
>> merging this patch. However, I checked the merged commit of this patch
>> in your dev branch[1], and the changes in ext4_ext_index_trans_blocks()
>> seem to be incorrect, which could result in insufficient credit
>> reservations on 1K block size filesystems.
> 
> Thanks so much for noticing the mis-merge!  I've fixed it in my tree,
> and will be pushing it out shortly.  If you could take a look and make
> sure that it's correct, that would be great.
> 

The merge in ext4_ext_index_trans_blocks() appears to be correct now.
However, the issue that Jan pointed out regarding the modification in
ext4_meta_trans_blocks() is correct, it will also lead to insufficient
credit reservations on some corner images. I will send out a fix ASAP.

Best Regards.
Yi.


