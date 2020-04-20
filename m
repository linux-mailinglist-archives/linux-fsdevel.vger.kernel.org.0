Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06151B1818
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 23:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgDTVLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 17:11:18 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40292 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgDTVLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:11:17 -0400
Received: by mail-pj1-f67.google.com with SMTP id a22so401176pjk.5;
        Mon, 20 Apr 2020 14:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wrPH749mUN8hliBUrahYDBfQbFobH/RtFO+RluKgR0c=;
        b=LivDrY5Ouu2czO0qIGWzXiVMlitkGzsLsQF2wFYUanuha55j6R1l/v3f6fbr5Yn97V
         a1Nf1cKwKMlxNBx8gvh0B9TxG4lOjU8tn5EVF9NpQb6fvWIIlkndzF045ASxLmEFjgwo
         Izmjb7PYRGKCrAHCZmYWquUI0m4pbaIP0OkP3ADy4jb/fJyqiVvA6xUqB0le0qSfKkaf
         HGKGzxXrnYLD64A2zGsu3vVflmLlAp5HV+BJ02o4cXHRuwcObLIUWZL33s4I/kDOkUlR
         ZMtAiHQiP9UPIibIM1t8GIN9FU7FyrXU7ilHN0xgyoMFSjZgH+hkSyJUnybkp4myk0+J
         FtwA==
X-Gm-Message-State: AGi0PuavJARo54tgWtDazrPA9nPgNBAIy9bluHK6W300PLR36cs+t77P
        HZ9tmlDaRI8GylWusyvkoSCkLtEtyZs=
X-Google-Smtp-Source: APiQypLpcT/SUkIQmuuXSrPoqK0E8Cp2xLvNfCZASPQMFboRu2ZZ34NFyvthqIVZYVdzDqs93Z4ZTg==
X-Received: by 2002:a17:90b:3751:: with SMTP id ne17mr1574517pjb.114.1587417077115;
        Mon, 20 Apr 2020 14:11:17 -0700 (PDT)
Received: from [100.124.9.192] ([104.129.199.10])
        by smtp.gmail.com with ESMTPSA id 71sm394670pfw.111.2020.04.20.14.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 14:11:16 -0700 (PDT)
Subject: Re: [PATCH v2 04/10] block: revert back to synchronous request_queue
 removal
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-5-mcgrof@kernel.org>
 <749d56bd-1d66-e47b-a356-8d538e9c99b4@acm.org>
 <20200420185943.GM11244@42.do-not-panic.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <eba2a91b-62a6-839d-df54-2a1cf8262652@acm.org>
Date:   Mon, 20 Apr 2020 14:11:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420185943.GM11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/20/20 11:59 AM, Luis Chamberlain wrote:
> On Sun, Apr 19, 2020 at 03:23:31PM -0700, Bart Van Assche wrote:
>> On 4/19/20 12:45 PM, Luis Chamberlain wrote:
>>> + * Decrements the refcount to the request_queue kobject, when this reaches
>>> + * 0 we'll have blk_release_queue() called. You should avoid calling
>>> + * this function in atomic context but if you really have to ensure you
>>> + * first refcount the block device with bdgrab() / bdput() so that the
>>> + * last decrement happens in blk_cleanup_queue().
>>> + */
>>
>> Is calling bdgrab() and bdput() an option from a context in which it is not
>> guaranteed that the block device is open?
> 
> If the block device is not open, nope. For that blk_get_queue() can
> be used, and is used by the block layer. This begs the question:
> 
> Do we have *drivers* which requires access to the request_queue from
> atomic context when the block device is not open?

Instead of trying to answer that question, how about changing the 
references to bdgrab() and bdput() into references to blk_get_queue() 
and blk_put_queue()? I think if that change is made that we won't have 
to research what the answer to the bdgrab()/bdput() question is.

Thanks,

Bart.
