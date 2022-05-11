Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DC4522DC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 09:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243238AbiEKH7O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 03:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243233AbiEKH7N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 03:59:13 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F50606D2;
        Wed, 11 May 2022 00:59:12 -0700 (PDT)
Received: from [192.168.88.87] (unknown [180.242.99.67])
        by gnuweeb.org (Postfix) with ESMTPSA id 08DE87F61A;
        Wed, 11 May 2022 07:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1652255952;
        bh=Fw2qZDFCMmqG0M/lJabaILxfE+Gi6Tl3+WvT87pP3r8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JoBjT/ovjOaGCKw98GwB+oUVIZJd1BNr1hAVPEmvAZTZXbHlMdQXp+nEJlWv0SkMK
         uMLW+g35pjyiVP4LcynhQXjIC4Udhbqxyc4/lQGYkEt06XqrXiWXtfkXqZlC1WZLY8
         eP0Zh2vP2PQhbmLFW00GGNK6SQPRfhX4MOr+yd6aDHf3AfOfp3l5jyRweisIzJJMuy
         jg6iIB/UT3qRcl5PHXDHRxFwe3ldog6TL7RPs3TSWcOPEy8lxcXIAdU/XFOFEX4KhE
         Hfm4j4803+DW01AO+a7yk5F2oxbMSfMVAX6WddrCKBLL0Du9c6+2tNcL8QyeWTZ/nK
         C8m59fGl2mVCw==
Message-ID: <fb4f0d4c-aaf7-b225-f5bb-7c41c48fb8f1@gnuweeb.org>
Date:   Wed, 11 May 2022 14:58:56 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5] mm/ksm: introduce ksm_force for each process
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cgel.zte@gmail.com, Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>,
        xu xin <xu.xin16@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Linux fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220507105926.d4423601230f698b0f5228d1@linux-foundation.org>
 <20220508092710.930126-1-xu.xin16@zte.com.cn>
 <435b5f7a-fcbd-f7ae-b66f-670e5997aa1b@gnuweeb.org>
 <20220510133016.9feff1aeec1a7a9ae137a8c3@linux-foundation.org>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220510133016.9feff1aeec1a7a9ae137a8c3@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/22 3:30 AM, Andrew Morton wrote:
> On Wed, 11 May 2022 03:10:31 +0700 Ammar Faizi <ammarfaizi2@gnuweeb.org> wrote:
> 
>> On 5/8/22 4:27 PM, cgel.zte@gmail.com wrote:
>>> +static ssize_t ksm_force_write(struct file *file, const char __user *buf,
>>> +				size_t count, loff_t *ppos)
>>> +{
>>> +	struct task_struct *task;
>>> +	struct mm_struct *mm;
>>> +	char buffer[PROC_NUMBUF];
>>> +	int force;
>>> +	int err = 0;
>>> +
>>> +	memset(buffer, 0, sizeof(buffer));
>>> +	if (count > sizeof(buffer) - 1)
>>> +		count = sizeof(buffer) - 1;
>>> +	if (copy_from_user(buffer, buf, count)) {
>>> +		err = -EFAULT;
>>> +		goto out_return;
>>> +	}
>>
>> This one looks like over-zeroing to me. You don't need to zero
>> all elements in the array. You're going to overwrite it with
>> `copy_from_user()` anyway.
>>
>> Just zero the last potentially useful element by using @count
>> as the index. It can be like this:
>>
>> ```
>> 	char buffer[PROC_NUMBUF];
>>
>> 	if (count > sizeof(buffer) - 1)
>> 		count = sizeof(buffer) - 1;
>> 	if (copy_from_user(buffer, buf, count))
>> 		return -EFAULT;
>> 	buffer[count] = '\0';
>> ```
> 
> Use strncpy_from_user()?

Sounds better.

> Can this code use proc_dointvec_minmax() or similar?

Not familiar with that API at all. Leaving it to other participants...

-- 
Ammar Faizi
