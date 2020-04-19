Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4441AFE9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 00:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDSWXg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 18:23:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38484 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgDSWXg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 18:23:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id y25so4002446pfn.5;
        Sun, 19 Apr 2020 15:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PxxckLMR2d23G7JoN6ozKi6ERyzYCtE5BsAkT8xkLNU=;
        b=QqQQiz3OpOQReE1Q2jwf/c85i8xCPktW9WOr5FoOxCQyC1qtu+jtotqAtlte4MKmdu
         pi/kqpGTGsLK2YyLi1agBZMVLa4bJd2NHG/9HeE0yGOwkhE+x4uk0LiVlrKjwsB1Ok66
         AsxdpEJjL9xdA0naosS9WcekQLTc8sDu2XvGapGMvvarFEbEznvvtzAOrIe0A5U0qKbw
         hk2d9L5nW02Ggw+jeXhA3VSShIlUI4+ZJIRI+c9OvpVssJp/rSP8TJFa8/f7iOJBKCm2
         OduyQuSZ3w6BnH8bobw9roQkeD4+M60TsFnIq1LRFagg/jdO9Ilg8z+T5UIebMPIWdez
         CbCg==
X-Gm-Message-State: AGi0PuYIdCD6agVH8ZcXeHJDXybdblXpBAOTnaC1aSJcdGd9YshlPbkd
        nNlMMmOHWyxODnwJ3aYtXIw=
X-Google-Smtp-Source: APiQypJKXdia+liMhX0/hlemOsS2zbQv5lseIECGPkTjiAMuvfNJzjg5PKXUFzaG+2drmrCSZSz94w==
X-Received: by 2002:aa7:9484:: with SMTP id z4mr14283395pfk.144.1587335015542;
        Sun, 19 Apr 2020 15:23:35 -0700 (PDT)
Received: from [100.124.11.78] ([104.129.199.4])
        by smtp.gmail.com with ESMTPSA id 135sm26218134pfu.207.2020.04.19.15.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 15:23:34 -0700 (PDT)
Subject: Re: [PATCH v2 04/10] block: revert back to synchronous request_queue
 removal
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-5-mcgrof@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <749d56bd-1d66-e47b-a356-8d538e9c99b4@acm.org>
Date:   Sun, 19 Apr 2020 15:23:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200419194529.4872-5-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/19/20 12:45 PM, Luis Chamberlain wrote:
> +/**
> + * blk_put_queue - decrement the request_queue refcount
> + *
> + * @q: the request_queue structure to decrement the refcount for
> + *

How about following the example from 
Documentation/doc-guide/kernel-doc.rst and not leaving a blank line 
above the function argument documentation?

> + * Decrements the refcount to the request_queue kobject, when this reaches
                               ^^
                               of?
> + * 0 we'll have blk_release_queue() called. You should avoid calling
> + * this function in atomic context but if you really have to ensure you
> + * first refcount the block device with bdgrab() / bdput() so that the
> + * last decrement happens in blk_cleanup_queue().
> + */

Is calling bdgrab() and bdput() an option from a context in which it is 
not guaranteed that the block device is open?

Does every context that calls blk_put_queue() also call blk_cleanup_queue()?

How about avoiding confusion by changing the last sentence of that 
comment into something like the following: "The last reference must not 
be dropped from atomic context. If it is necessary to call 
blk_put_queue() from atomic context, make sure that that call does not 
decrease the request queue refcount to zero."

>   /**
>    * blk_cleanup_queue - shutdown a request queue
> + *
>    * @q: request queue to shutdown
>    *

How about following the example from 
Documentation/doc-guide/kernel-doc.rst and not leaving a blank line 
above the function argument documentation?

>    * Mark @q DYING, drain all pending requests, mark @q DEAD, destroy and
>    * put it.  All future requests will be failed immediately with -ENODEV.
> + *
> + * You should not call this function in atomic context. If you need to
> + * refcount a request_queue in atomic context, instead refcount the
> + * block device with bdgrab() / bdput().

Surrounding blk_cleanup_queue() with bdgrab() / bdput() does not help. 
This blk_cleanup_queue() must not be called from atomic context.

>   /**
> - * __blk_release_queue - release a request queue
> - * @work: pointer to the release_work member of the request queue to be released
> + * blk_release_queue - release a request queue
> + *
> + * This function is called as part of the process when a block device is being
> + * unregistered. Releasing a request queue starts with blk_cleanup_queue(),
> + * which set the appropriate flags and then calls blk_put_queue() as the last
> + * step. blk_put_queue() decrements the reference counter of the request queue
> + * and once the reference counter reaches zero, this function is called to
> + * release all allocated resources of the request queue.
>    *
> - * Description:
> - *     This function is called when a block device is being unregistered. The
> - *     process of releasing a request queue starts with blk_cleanup_queue, which
> - *     set the appropriate flags and then calls blk_put_queue, that decrements
> - *     the reference counter of the request queue. Once the reference counter
> - *     of the request queue reaches zero, blk_release_queue is called to release
> - *     all allocated resources of the request queue.
> + * This function can sleep, and so we must ensure that the very last
> + * blk_put_queue() is never called from atomic context.
> + *
> + * @kobj: pointer to a kobject, who's container is a request_queue
>    */

Please follow the style used elsewhere in the kernel and move function 
argument documentation just below the line with the function name.

Thanks,

Bart.
