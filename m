Return-Path: <linux-fsdevel+bounces-52658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5489AE59B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 04:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBEA81BC0BB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 02:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102F32222A9;
	Tue, 24 Jun 2025 02:15:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 40E08201276;
	Tue, 24 Jun 2025 02:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731311; cv=none; b=dvIsEWvIsrLT1oqeetHSn0PVmTb2l/jWY74xhFFwTkzyy5rOtlG25UDSJo0d7cEIZbekTtkk5+nRjMUUd1gj+BALQCyfC7/dTuVImEpODP0eqtijkZW0JMMxxwn4kBwHWSmdWTQjKAm4Xll76IH3zjezX16+9nigyGfJncYuQiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731311; c=relaxed/simple;
	bh=TqIHhbyr12Co2TLu3Apca6Gz8ChPUH0zAN4ha3G3h8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=KbJ8sY/RaFBjmeWXagpvtC2VMHAHrjT5qPpsTmon2HiOFaygKmJvh5TneDwz8QxVqFaBYib3MoLZCXUx65v0rrJaUUlS5ubbX7juRMXsijLdHu3H/sKa8vJNrMStZ3+yZTzIhQLmmjLn+hCq9ZRnqOJgbnDUn+EC6ckyrYlA99E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 88D7860107F46;
	Tue, 24 Jun 2025 10:14:56 +0800 (CST)
Message-ID: <a90315db-e2d9-4a86-9be5-6ea88f5c94a2@nfschina.com>
Date: Tue, 24 Jun 2025 10:14:55 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/proc/vmcore: a few cleanups for vmcore_add_device_dump
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, vgoyal@redhat.com, dyoung@redhat.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Su Hui <suhui@nfschina.com>
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <d60db71a-0b4f-4e7d-8c06-7493934aa507@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025/6/23 23:22, Dan Carpenter wrote:
> On Mon, Jun 23, 2025 at 10:36:45PM +0800, Baoquan He wrote:
>> On 06/23/25 at 06:47pm, Su Hui wrote:
>>> There are three cleanups for vmcore_add_device_dump(). Adjust data_size's
>>> type from 'size_t' to 'unsigned int' for the consistency of data->size.
>> It's unclear to me why size_t is not suggested here. Isn't it assigned
>> a 'sizeof() + data->size' in which size_t should be used?

Oh, sorry for this, I missed some things.

1497         data_size = roundup(sizeof(struct vmcoredd_header) + 
data->size,
1498                             PAGE_SIZE);
1499
1500         /* Allocate buffer for driver's to write their dumps */
1501         buf = vmcore_alloc_buf(data_size);
             [...]
1515
1516         dump->buf = buf;
1517         dump->size = data_size;
                  ^^^^^^^^^^^^^^^^^^^^^
If data_size is 64 bit and assume data_size is bigger than 32bit, 
dump->size will overflow.
Should we adjust dump->size's type to size_t? Or maybe it's impossible 
for data_size bigger
than 32bit?
> Yeah...  That's a good point.  People should generally default to size_t
> for sizes.  It really does prevent a lot of integer overflow bugs.  In
> this case data->size is not controlled by the user, but if it were
> then that would be an integer overflow on 32bit systems and not on
> 64bit systems, until we start declaring sizes as unsigned int and
> then all the 32bit bugs start affecting everyone.
Agreed, sorry for my fault again.
I will remove the 'unsigned int' in v2 patch.
Thanks for your suggestions!

regards,
Su Hui


