Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E6F23167E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 01:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbgG1Xzc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 19:55:32 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36258 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbgG1Xzb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 19:55:31 -0400
Received: from [10.137.106.139] (unknown [131.107.174.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id 206D720B4908;
        Tue, 28 Jul 2020 16:55:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 206D720B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595980531;
        bh=w20ZeApysxkNgENHQge66diVoP/SQfne/ezQvvgUqcM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nnq1/Ln3/IaJyZh6MpEpyRjnynpp3gggyXPT/zMkvX1w1syPnu2hKbPS6qxyDZnxS
         iKMgtnrSyFqUCEF9u5XDmKjPxBkR+ecBgizOPG2aHqejlOosEDxXCEWUMINrbBhQeK
         UE1cUIuE1lbhP1MNi/Lq5CeWTt4iiPMyWIVFTjTo=
Subject: Re: [RFC PATCH v5 05/11] fs: add security blob and hooks for
 block_device
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        paul@paul-moore.com, eparis@redhat.com, jannh@google.com,
        dm-devel@redhat.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-audit@redhat.com, tyhicks@linux.microsoft.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net, sashal@kernel.org,
        jaskarankhurana@linux.microsoft.com, mdsakib@microsoft.com,
        nramas@linux.microsoft.com, pasha.tatashin@soleen.com
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
 <20200728213614.586312-6-deven.desai@linux.microsoft.com>
 <ef0fff6f-410a-6444-f1e3-03499a2f52b7@schaufler-ca.com>
 <20200728224003.GC951209@ZenIV.linux.org.uk>
From:   Deven Bowers <deven.desai@linux.microsoft.com>
Message-ID: <f6bda37a-e6f8-3de9-2bae-25d2296f3424@linux.microsoft.com>
Date:   Tue, 28 Jul 2020 16:55:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728224003.GC951209@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/28/2020 3:40 PM, Al Viro wrote:
> On Tue, Jul 28, 2020 at 03:22:59PM -0700, Casey Schaufler wrote:
> 
>>> +	hlist_for_each_entry(p, &security_hook_heads.bdev_setsecurity, list) {
>>> +		rc = p->hook.bdev_setsecurity(bdev, name, value, size);
>>> +
>>> +		if (rc == -ENOSYS)
>>> +			rc = 0;
>>> +
>>> +		if (rc != 0)
>>
>> Perhaps:
>> 		else if (rc != 0)
>>
>>> +			break;
>>> +	}
>>> +
>>> +	return rc;
> 
> 	hlist_for_each_entry(p, &security_hook_heads.bdev_setsecurity, list) {
> 		rc = p->hook.bdev_setsecurity(bdev, name, value, size);
> 		if (rc && rc != -ENOSYS)
> 			return rc;
> 	}
> 	return 0;
> 
> Easier to reason about that way...
> 

Yeah, this is cleaner. I'll make the change for v6.
