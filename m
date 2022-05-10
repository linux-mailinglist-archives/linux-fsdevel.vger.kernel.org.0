Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45547522532
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 22:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiEJUKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 16:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiEJUKv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 16:10:51 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C237B286E8;
        Tue, 10 May 2022 13:10:49 -0700 (PDT)
Received: from [192.168.88.87] (unknown [180.242.99.67])
        by gnuweeb.org (Postfix) with ESMTPSA id 85BFE7F610;
        Tue, 10 May 2022 20:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1652213448;
        bh=xGbGpRh0CXRIes2avgyarli9Rp73tR9kYCMcxSyKOGY=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=Y71uOwEP1OuzgfBJxJAcbh3DjOMp7w2q8B0ZlPEpb0WGBpLN/0UGzZU6oKjaT4vT+
         NaE/pD4g8oxs1aCCjbG8mKILd0KY01Oo0rTCzXVzL50WWYyZlhYs+CQFqYcgMt6/UE
         nkFhdPf6WH8g4x5XFZUkdmYEyAI1Hfp6JiEWVQ+OMA5UddcvK3TWlBI6OA0s57hEuJ
         AyXljU0N5gCxu3KHObvJz+NhWrb/slPVsmRthyrfkzprlKG4IRuEukoArktZtYZHZ/
         hGyVVp9ZPzqFgUD0pj45XCMJf8LJFk3WQ69vYnlJdiMuCOwha46/0ytHQs1qvQSTS9
         DJJ4LQIjvuApA==
Message-ID: <435b5f7a-fcbd-f7ae-b66f-670e5997aa1b@gnuweeb.org>
Date:   Wed, 11 May 2022 03:10:31 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
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
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH v5] mm/ksm: introduce ksm_force for each process
In-Reply-To: <20220508092710.930126-1-xu.xin16@zte.com.cn>
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

On 5/8/22 4:27 PM, cgel.zte@gmail.com wrote:
> +static ssize_t ksm_force_write(struct file *file, const char __user *buf,
> +				size_t count, loff_t *ppos)
> +{
> +	struct task_struct *task;
> +	struct mm_struct *mm;
> +	char buffer[PROC_NUMBUF];
> +	int force;
> +	int err = 0;
> +
> +	memset(buffer, 0, sizeof(buffer));
> +	if (count > sizeof(buffer) - 1)
> +		count = sizeof(buffer) - 1;
> +	if (copy_from_user(buffer, buf, count)) {
> +		err = -EFAULT;
> +		goto out_return;
> +	}

This one looks like over-zeroing to me. You don't need to zero
all elements in the array. You're going to overwrite it with
`copy_from_user()` anyway.

Just zero the last potentially useful element by using @count
as the index. It can be like this:

```
	char buffer[PROC_NUMBUF];

	if (count > sizeof(buffer) - 1)
		count = sizeof(buffer) - 1;
	if (copy_from_user(buffer, buf, count))
		return -EFAULT;
	buffer[count] = '\0';
```

-- 
Ammar Faizi
