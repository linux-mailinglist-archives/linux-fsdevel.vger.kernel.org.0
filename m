Return-Path: <linux-fsdevel+bounces-72261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0845CEB03E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 02:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 299D93024139
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 01:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E23A2D781B;
	Wed, 31 Dec 2025 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IFaMHshy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF10C189906;
	Wed, 31 Dec 2025 01:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767145940; cv=none; b=gScGUv+S/sZCYE81C6l9oAcwpB9nILJOIL312IDI1Eq9q6KUWpMlhXLq+bGQZJpTgyCbrqxgF3ceMJNl1F2wpWJ9A8JQIyaLFHUl3HVpb9Gr2694goq8f/YTesBtTu8Wu5cW3Ye5oEIOZx6n1VBAyHGoD2L25mEU1+R5SVITWrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767145940; c=relaxed/simple;
	bh=ZTdcIkLpEKUp8FvjFC+vuUF2dVEGtYVIrEh5uiZ9Tx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0VvcsM54z7v4SGlxq94isP/Go2uZBPwaVbG39t6GXPVX5buYBrjBrj14Kmr6elm9RjaJBsuTtU7YXnrrqUGIToqbJSt3gjoaXeahG4e6PTszhkD6Akm7xumlU/XEsyiZc/EkCANQdVhdHheJl72JOK8lxLnonBhnT+IJmX5I+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IFaMHshy; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=/Jviu6s8Co1WoqLYoqogYOVd8I7W+HZTVgu26MAReo4=;
	b=IFaMHshyfUJWN/B8qR4tkxyGUs/4kygZcby4jg+fxNqqRDgiG6B4WKKLeocg41
	XLhxVYA/LhQed/8eP/e13lGM5JvH3OrYBZcJbj6bG5K4YFlOM6WWcO0mb+raGNN0
	5iPAJ9rs8dQ3oo/D2AyjJUAORaUFNCqVMmEmCOqEtbl9w=
Received: from [10.42.20.201] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDXRPqigVRpgmRIDg--.26058S2;
	Wed, 31 Dec 2025 09:51:30 +0800 (CST)
Message-ID: <49331fb0-9cfe-4ec9-a819-60ab62de15e7@163.com>
Date: Wed, 31 Dec 2025 09:51:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 8/9] exfat: support multi-cluster for exfat_map_cluster
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "brauner@kernel.org" <brauner@kernel.org>,
 "chizhiling@kylinos.cn" <chizhiling@kylinos.cn>, "jack@suse.cz"
 <jack@suse.cz>, "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "willy@infradead.org" <willy@infradead.org>
References: <PUZPR04MB6316AEB35F215CCA9BB0895181BCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <PUZPR04MB6316AEB35F215CCA9BB0895181BCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDXRPqigVRpgmRIDg--.26058S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4Rv-erUUUUU
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC2wL3lWlUgaJumwAA3Q

On 12/30/25 17:06, Yuezhang.Mo@sony.com wrote:
>> @@ -293,12 +298,14 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
>>
>>   	if (cluster == EXFAT_EOF_CLUSTER)
>>   		goto done;
>> +	if (WARN_ON_ONCE(!count))
>> +		count = 1;
> 
> The count is 0 only if cluster is EXFAT_EOF_CLUSTER.
> So this warning never occur, right? If yes, please remove it.

Yes, it's never 0 unless something goes wrong :)

I will remove it in v2.


