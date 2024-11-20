Return-Path: <linux-fsdevel+bounces-35260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFED9D3323
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 06:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EA66B24356
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 05:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C74158D92;
	Wed, 20 Nov 2024 05:28:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7340157485;
	Wed, 20 Nov 2024 05:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732080514; cv=none; b=e8cC0e/mxGlZHdS2ljaDQVj1PVi+NWnsZ2Jf2UVRfZqq6uB0dCsOLNgjmRzJu1J0FeYY0ZDmlDsXYUAEM7QcRlurEnS/70BY1tV3HUG9cSZudyUOKVa3SuRXywA75eJRLLCsNIAbGLU2W8Co7SzqBjcBc3DP9HGx6W7QvTr01dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732080514; c=relaxed/simple;
	bh=dqcH9fVhC40QNP80jhRT6Nrq8JHcePHb1NbMOON6evo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NVIGUXEZtJUwWjT3XONPzuTxTE/rUU+KcDKvd4ujZuovrHScX6LhAMsNCw+WGVmnJxa7wN1LXRP+7Z3RBageCGC8JGjaWiznP0mS1f2Kdag/MlDKo8V2D2kRwJuM8ZdEzTDGTeq2jAkwXWdXRrWoATwzQFbHh+/tgPpqES4q3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XtTss5FnFz2GZl8;
	Wed, 20 Nov 2024 13:08:49 +0800 (CST)
Received: from kwepemf200016.china.huawei.com (unknown [7.202.181.9])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B383140336;
	Wed, 20 Nov 2024 13:10:48 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 kwepemf200016.china.huawei.com (7.202.181.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 Nov 2024 13:10:47 +0800
Message-ID: <c6c703a1-00f8-4348-b8c0-17166aebf636@huawei.com>
Date: Wed, 20 Nov 2024 13:10:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] vfs: support caching symlink lengths in inodes
To: Matthew Wilcox <willy@infradead.org>
CC: Mateusz Guzik <mjguzik@gmail.com>, <brauner@kernel.org>,
	<viro@zeniv.linux.org.uk>, <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <hughd@google.com>,
	<linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <linux-mm@kvack.org>
References: <20241119094555.660666-1-mjguzik@gmail.com>
 <20241119094555.660666-2-mjguzik@gmail.com>
 <f7cc4ce1-9c20-4a5b-8a66-69b1f00a7776@huawei.com>
 <Zz1tK-rMV5uYyco6@casper.infradead.org>
Content-Language: en-US
From: "wangjianjian (C)" <wangjianjian3@huawei.com>
In-Reply-To: <Zz1tK-rMV5uYyco6@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf200016.china.huawei.com (7.202.181.9)

On 2024/11/20 13:01, Matthew Wilcox wrote:
> On Wed, Nov 20, 2024 at 12:15:18PM +0800, wangjianjian (C) wrote:
>>> +{
>>> +	inode->i_link = link;
>>> +	inode->i_linklen = linklen;
>> Just curious, is this linklen equal to inode size? if it is, why don't use
>> it?
> 
> Maybe you should read v1 of the patch series where Jan explained where
> that's not true.
okay, I see, thanks for this.
> 
-- 
Regards


