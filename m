Return-Path: <linux-fsdevel+bounces-38620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B53A1A04ECA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 02:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61AF5188811A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 01:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6CA15696E;
	Wed,  8 Jan 2025 01:20:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DA778F24;
	Wed,  8 Jan 2025 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736299239; cv=none; b=FXYVrIARrd/1rNGyn44airrAKC1vqrVhLB9QkN4T15ZTmTcATQlLK0SrezVFBG2SPZDT5ML/a0YkNCvjcCXpuKew4q3lFUSd1b/8ogiyGyUpNO95XsdfHTacggOYXG/WhAc0kXNRSulxov3klK1LEhqB8HpZumSK84eZDIkWSmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736299239; c=relaxed/simple;
	bh=IzOOzUG7AoU1E7QXJeIgLSgU3omWwrBeAwxDhmLwfRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IdTGQSGMc6OrgRqg7MuGV47Dw6wxwxVZ/Aff9gU+gH9ryUhrrJtfCBTO7Qe0bPvLYTOvWoii2h3jyK/gNylNnfpaqQFFC7noi9DQGphae1Q06y1x0lS4qN1pWEYWGXHLlyPfNdKDJQakZWC7UHhmjBqDiyWQQTfxbzrkMyh6jzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YSVTR5J55z4f3lfJ;
	Wed,  8 Jan 2025 09:20:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 174F61A092F;
	Wed,  8 Jan 2025 09:20:33 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGDe0n1nC4RfAQ--.53048S3;
	Wed, 08 Jan 2025 09:20:32 +0800 (CST)
Message-ID: <f26a21c9-2520-4deb-98f5-385adc92a934@huaweicloud.com>
Date: Wed, 8 Jan 2025 09:20:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] fs: introduce FALLOC_FL_FORCE_ZERO to fallocate
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, adilger.kernel@dilger.ca, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com,
 Sai Chaitanya Mitta <mittachaitu@gmail.com>, linux-xfs@vger.kernel.org
References: <20241228014522.2395187-1-yi.zhang@huaweicloud.com>
 <20241228014522.2395187-2-yi.zhang@huaweicloud.com>
 <Z3u-OCX86j-q7JXo@infradead.org> <20250106161732.GG1284777@mit.edu>
 <Z3wEhXakqrW4i3UC@infradead.org> <20250106173133.GB6174@frogsfrogsfrogs>
 <b964a57a-0237-4cbd-9aae-457527a44440@huaweicloud.com>
 <Z31Za6Ma97QPHp1W@infradead.org>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <Z31Za6Ma97QPHp1W@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHrGDe0n1nC4RfAQ--.53048S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JrykAF47uF1UCr47tr43Jrb_yoWDWrgE93
	9Iqr4kAw1qqF97Aa1ayFZ8XrWxW3srGayUJry5Jw1fZF9xJa9xuF95Wr4S9F4xZF4jkr9I
	9FsxXr4DG3WakjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFk
	u4UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/1/8 0:42, Christoph Hellwig wrote:
> On Tue, Jan 07, 2025 at 10:05:47PM +0800, Zhang Yi wrote:
>> Sorry. the "pure overwrites" and "always-cow files" makes me confused,
>> this is mainly used to create a new written file range, but also could
>> be used to zero out an existing range, why you mentioned it exists to
>> facilitate pure overwrites?
> 
> If you're fine with writes to your file causing block allocations you
> can already use the hole punch or preallocate fallocate modes.  No
> need to actually send a command to the device.
> 

Okay, I misunderstood your point earlier. This is indeed prepared for
subsequent overwrites. Thanks a lot for explaining.

Thanks,
Yi.

>>
>> For the "always-cow files", do you mean reflinked files? Could you
>> please give more details?
> 
> reflinked files will require out of place writes for shared blocks.
> As will anything on device mapper snapshots.  Or any file on
> file systems that write out of place (btrfs, f2fs, nilfs2, the
> upcoming zoned xfs mode).
> 


