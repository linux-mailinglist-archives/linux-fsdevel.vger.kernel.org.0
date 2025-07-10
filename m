Return-Path: <linux-fsdevel+bounces-54407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BD3AFF65E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 03:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA0F7B4DE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 01:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6433926E6E5;
	Thu, 10 Jul 2025 01:10:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999E825C810;
	Thu, 10 Jul 2025 01:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752109855; cv=none; b=RzwMJuqx/PS/VtLwaOfBNAqOag2sT1GSjTXxX0au3v1JgFojcjT50TpJTcZcrOjEwsjl0dWv5cV0LFaidDbgq5DpaVeuXH5LDCnsh08XJJ4bsrXEu61ixGdkBgu3dWnLkA2dG5Hyk3+P9tjmZ8dbc79lv76jkqa9mXFvVq6X14c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752109855; c=relaxed/simple;
	bh=polTNEeOS/4T+OqPkd+JBjFkgMdpjkKbeSJ8JtsidBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9xnDmMsUCiBiqDaVykVlQy6xMB2fvsc84LJBVkz9h7BImLn75sDF6pNwY1paM1BNXHCm3LsvqvnpIvc7nWipIMUYE70/w5tEOYjm/LWu9C+WkjQYhwEEUrCbToiVPx+HzTmaO0G4IfFVgWVG6JXqNWRvlBqzhgMjsxWevgvB7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bcxcC2fzqzYQvLP;
	Thu, 10 Jul 2025 09:10:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 3074E1A1546;
	Thu, 10 Jul 2025 09:10:50 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP3 (Coremail) with SMTP id _Ch0CgBXBCIYE29ovh7bBA--.17693S3;
	Thu, 10 Jul 2025 09:10:49 +0800 (CST)
Message-ID: <886b55b4-162f-4acd-a5ec-6114e6239a89@huaweicloud.com>
Date: Thu, 10 Jul 2025 09:10:48 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cachefiles: Fix the incorrect return value in
 __cachefiles_write()
To: David Howells <dhowells@redhat.com>, Zizhi Wo <wozizhi@huaweicloud.com>
Cc: netfs@lists.linux.dev, jlayton@kernel.org, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 libaokun1@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com
References: <20250703024418.2809353-1-wozizhi@huaweicloud.com>
 <2731907.1752077037@warthog.procyon.org.uk>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <2731907.1752077037@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBXBCIYE29ovh7bBA--.17693S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYv7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r
	1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2025/7/10 0:03, David Howells 写道:
> I think this should only affect erofs, right?
> 
> David
> 
> 

Yes, currently other callers don't rely on the return value of
__cachefiles_write(); instead, they determine success or failure through
cachefiles_write_complete().

Therefore, resetting "ret" to 0 in __cachefiles_write() might be
unnecessary? When this step is removed, the outer
cachefiles_ondemand_fd_write_iter() can also correctly update the offset
based on ret.

Thanks,
Zizhi Wo


