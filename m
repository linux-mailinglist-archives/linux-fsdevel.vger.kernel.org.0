Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF39350A56
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 00:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhCaWnH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 18:43:07 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.1]:44768 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232406AbhCaWnE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 18:43:04 -0400
X-Greylist: delayed 1277 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Mar 2021 18:43:04 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id BB0EA6E960
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 17:21:41 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RjDZllVwPMGeERjDZlNMk2; Wed, 31 Mar 2021 17:21:41 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YojvDQ3EVOB0i+R+aoTOGVliEyEdWdfUxsBrA9b3YJY=; b=uqW4o/SQjZe6HtQmsZzdOzRPK0
        pSPdwToqdS8sMt91UZdSz1IrfQ7EZTux2Ii5f6pm07i4UBfzGY6+SWRkXrprxlNYYjRLfnl87JLpf
        /6XQyZ5LfhG3QRGeh8fSRddHgieVZPRWqIMaO8X6mxY0AdHJ0CHPISB2wIwsEkr3+m5qGvDlws2BJ
        V/QCGQsr2YgkuI0dO8hXm7zuGz+DNBW8evNYMOxD5nROxMSZsKWZYqvGVcqoe6prPH5/rfZli5u19
        J4wuAt0iyD+u2WnqOOPOpzcChZFS0uAP2zsi92q3/BUQCsITKT3iv1egE6s+0zRblMNm76hCiwPhB
        73/0Kmbw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:51022 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lRjDZ-000iqw-CV; Wed, 31 Mar 2021 17:21:41 -0500
Subject: Re: [PATCH][next] hfsplus: Fix out-of-bounds warnings in
 __hfsplus_setxattr
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210330145226.GA207011@embeddedor>
 <20210330214320.93600506530f1ab18338b467@linux-foundation.org>
 <20210331045357.GV351017@casper.infradead.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <2693ab27-64b6-9088-e172-83e7f8b4e95b@embeddedor.com>
Date:   Wed, 31 Mar 2021 16:21:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210331045357.GV351017@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lRjDZ-000iqw-CV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:51022
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/30/21 23:53, Matthew Wilcox wrote:
> On Tue, Mar 30, 2021 at 09:43:20PM -0700, Andrew Morton wrote:
>> On Tue, 30 Mar 2021 09:52:26 -0500 "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
>>
>>> Fix the following out-of-bounds warnings by enclosing
>>> structure members file and finder into new struct info:
>>>
>>> fs/hfsplus/xattr.c:300:5: warning: 'memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct DInfo' at offset 48 [-Warray-bounds]
>>> fs/hfsplus/xattr.c:313:5: warning: 'memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct FInfo' at offset 48 [-Warray-bounds]
>>>
>>> Refactor the code by making it more "structured."
>>>
>>> Also, this helps with the ongoing efforts to enable -Warray-bounds and
>>> makes the code clearer and avoid confusing the compiler.
>>
>> Confused.  What was wrong with the old code?  Was this warning
>> legitimate and if so, why?  Or is this patch a workaround for a
>> compiler shortcoming?
> 
> The offending line is this:
> 
> -                               memcpy(&entry.file.user_info, value,
> +                               memcpy(&entry.file.info, value,
>                                                 file_finderinfo_len);
> 
> what it's trying to do is copy two structs which are adjacent to each
> other in a single call to memcpy().  gcc legitimately complains that the
> memcpy to this struct overruns the bounds of the struct.  What Gustavo
> has done here is introduce a new struct that contains the two structs,
> and now gcc is happy that the memcpy doesn't overrun the length of this
> containing struct.

Thanks for this, Matthew. :)

--
Gustavo
