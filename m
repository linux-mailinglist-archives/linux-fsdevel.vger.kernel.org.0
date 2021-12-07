Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9093546B376
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 08:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhLGHPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 02:15:30 -0500
Received: from foss.arm.com ([217.140.110.172]:51948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhLGHPa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:15:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CC2411FB;
        Mon,  6 Dec 2021 23:12:00 -0800 (PST)
Received: from [10.163.34.206] (unknown [10.163.34.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2B423F5A1;
        Mon,  6 Dec 2021 23:11:55 -0800 (PST)
Subject: Re: [RFC PATCH 01/14] fs/proc/vmcore: Update read_from_oldmem() for
 user pointer
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kexec <kexec@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, x86 <x86@kernel.org>
References: <20211203104231.17597-1-amit.kachhap@arm.com>
 <20211203104231.17597-2-amit.kachhap@arm.com> <20211206140451.GA4936@lst.de>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <08e4e9d8-2c42-115a-f440-d7f44fb19280@arm.com>
Date:   Tue, 7 Dec 2021 12:41:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20211206140451.GA4936@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 12/6/21 7:34 PM, Christoph Hellwig wrote:
> On Fri, Dec 03, 2021 at 04:12:18PM +0530, Amit Daniel Kachhap wrote:
>> +	return read_from_oldmem_to_kernel(buf, count, ppos,
>> +					  cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT));
> 
> Overly long line.
> 
>> +ssize_t read_from_oldmem(char __user *ubuf, char *kbuf, size_t count,
>> +			 u64 *ppos, bool encrypted)
>>   {
>>   	unsigned long pfn, offset;
>>   	size_t nr_bytes;
>> @@ -156,19 +163,27 @@ ssize_t read_from_oldmem(char *buf, size_t count,
>>   		/* If pfn is not ram, return zeros for sparse dump files */
>>   		if (!pfn_is_ram(pfn)) {
>>   			tmp = 0;
>> -			if (!userbuf)
>> -				memset(buf, 0, nr_bytes);
>> -			else if (clear_user(buf, nr_bytes))
>> +			if (kbuf)
>> +				memset(kbuf, 0, nr_bytes);
>> +			else if (clear_user(ubuf, nr_bytes))
>>   				tmp = -EFAULT;
> 
> This looks like a huge mess.  What speak against using an iov_iter
> here?

iov_iter seems to be a reasonable way. As a start I thought of adding
minimal changes.

> 
