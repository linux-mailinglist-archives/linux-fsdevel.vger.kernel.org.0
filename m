Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87B5226B88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbgGTQmI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 12:42:08 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58374 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbgGTQmG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:42:06 -0400
Received: from [10.137.106.139] (unknown [131.107.174.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id D40D020B4909;
        Mon, 20 Jul 2020 09:42:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D40D020B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595263326;
        bh=3WXhX2ALsHf2q0CNQWhMDb6+Us/DWEgno/p0XetGReU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UX8lUvTr2G8xrIi4guewPBf2sMpGgCSWG+ypVjSkYree00iVyz+K6+TNPYj5kqBpt
         OJ1PUugFka19lCF1U2bCAf3ni5ddtj5CGjxeZgGafnEwJSMh8WQa7ExyR5hCc+fazj
         HdAQOXuV9j5EmSiKfIRiaJdWdiInyuMxRVW+6Yqg=
Subject: Re: [RFC PATCH v4 05/12] fs: add security blob and hooks for
 block_device
To:     Casey Schaufler <casey@schaufler-ca.com>, agk@redhat.com,
        axboe@kernel.dk, snitzer@redhat.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, viro@zeniv.linux.org.uk,
        paul@paul-moore.com, eparis@redhat.com, jannh@google.com,
        dm-devel@redhat.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-audit@redhat.com
Cc:     tyhicks@linux.microsoft.com, linux-kernel@vger.kernel.org,
        corbet@lwn.net, sashal@kernel.org,
        jaskarankhurana@linux.microsoft.com, mdsakib@microsoft.com,
        nramas@linux.microsoft.com
References: <20200717230941.1190744-1-deven.desai@linux.microsoft.com>
 <20200717230941.1190744-6-deven.desai@linux.microsoft.com>
 <1843d707-c62e-fa13-c663-c123ea1205a0@schaufler-ca.com>
From:   Deven Bowers <deven.desai@linux.microsoft.com>
Message-ID: <e82dbf6b-e90d-205b-62d1-b7cd8b5df844@linux.microsoft.com>
Date:   Mon, 20 Jul 2020 09:42:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1843d707-c62e-fa13-c663-c123ea1205a0@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/17/2020 5:14 PM, Casey Schaufler wrote:

[...snip]

>> +EXPORT_SYMBOL(security_bdev_free);
>> +
>> +int security_bdev_setsecurity(struct block_device *bdev,
>> +			      const char *name, const void *value,
>> +			      size_t size)
>> +{
>> +	return call_int_hook(bdev_setsecurity, 0, bdev, name, value, size);
>> +}
> 
> What is your expectation regarding multiple security modules using the
> same @name? What do you expect a security module to do if it does not
> support a particular @name? You may have a case where SELinux supports
> a @name that AppArmor (or KSRI) doesn't. -ENOSYS may be you friend here.
> 

I expect that some security modules may want to use the same @name / use
the data contained with @name. I cannot speak to the future cases of
other LSMs, but I expect if they want the raw @value, they'll copy it
into their security blob, or interpret @value to a field defined by
their security blob.

Originally, I expected a security module that does not implement a
particular @name no-op with return 0, not -ENOSYS, but I recognize that
error codes are valuable, and it's a trivial change - I'll switch the 
security hook to call the hooks while allowing -ENOSYS or 0 in the next 
iteration.

>> +EXPORT_SYMBOL(security_bdev_setsecurity);
>> +
>>   #ifdef CONFIG_PERF_EVENTS
>>   int security_perf_event_open(struct perf_event_attr *attr, int type)
>>   {
