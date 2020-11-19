Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A0B2B9AE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 19:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgKSSsG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 13:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbgKSSsF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:48:05 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBC8C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 10:48:05 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id q1so6295029ilt.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 10:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r/O6cJk6Y5rYulCeygqRJMwxovSqolk86IiSOaMMQdU=;
        b=1YJeT1z/SUhodTYSUtJYX3knppanyp2ovZJ8kr+vWqZG8RKMuarW42s1eKPgUSKd78
         7ux4dLne43Q9nr0m6EN0afLd5mFEH+81rJ+Pww80pTCfb+7LvQBNqE4ljYypClRGwR0d
         weMQaRfS49Wq2Rocfa2kWzzbNPG5F4yJCF8kfsfrcfGUSuQuPXI/FNBP2XV3IHQNVZYs
         KX1TjK0Ko4KQ1AvBRNMOTEnb/jbI4fgDH9DnKY9Q+lze4fk8rT0RpF5ZPUGFccxYr39A
         cm2yf05ttjFlE5uiYD5hW3++NkTVCP/VwLVJkxGMT/0nUzgG4JGVGybcZ7OG7QxKVsve
         f6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r/O6cJk6Y5rYulCeygqRJMwxovSqolk86IiSOaMMQdU=;
        b=LrZEPhk8mbqPusGXPLrdVtWvuGavh7EIRNxXiNA6gSpJrS5SVD/z9ZziHfvVjgLezY
         xEvI+CfsnsXtUk0D8WDiBguyIyxnHueXOdqoPGKeIDAopO9aXw+82+1UxhHa/rqLIIbT
         ukULRJnEhzADgNWK50pTPgLf1S7l2KKN5UHEH0RbaEqaLcTvnW6Ks+wpp1h9y96L2r8E
         rFGMrD889G2XARwwh4yblwhrlMq3EHiJ0JE/Yl8AUXaBmwHYq1txGSUhPMRi4AEdFymv
         RGJcc5PMaSF2w1yToI2eFv2/V27ajPc9L3PS0Vf62HEJOfLcPbA8K9iN7+opCDrwRXwK
         yThQ==
X-Gm-Message-State: AOAM530y4qEbzRcIrtLwQrtkBhx3ZDVHJT96qDi4DOkF/0Q3DNW7aT7L
        arknpyCNbi2U8MzfpRCGs/slww==
X-Google-Smtp-Source: ABdhPJzjCz5SKbN/GYVAApdJ1/yVhlcDEQjfwpKhovZ9XyzLURjnPg6AcC45mpq02AN6A7nP75ycGw==
X-Received: by 2002:a92:2811:: with SMTP id l17mr24161609ilf.238.1605811685034;
        Thu, 19 Nov 2020 10:48:05 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z9sm181499iog.3.2020.11.19.10.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 10:48:04 -0800 (PST)
Subject: Re: [PATCH v2] eventfd: convert to ->write_iter()
To:     Christoph Hellwig <hch@infradead.org>,
        Michal Kubecek <mkubecek@suse.cz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ed4484a3dc8297296bfcd16810f7dc1976d6f7d0.1605808477.git.mkubecek@suse.cz>
 <20201119180315.GB24054@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ffb060aa-e3ed-3dbe-9418-8ccf8d798974@kernel.dk>
Date:   Thu, 19 Nov 2020 11:48:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201119180315.GB24054@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/19/20 11:03 AM, Christoph Hellwig wrote:
> On Thu, Nov 19, 2020 at 07:00:19PM +0100, Michal Kubecek wrote:
>> While eventfd ->read() callback was replaced by ->read_iter() recently by
>> commit 12aceb89b0bc ("eventfd: convert to f_op->read_iter()"), ->write()
>> was not replaced.
>>
>> Convert also ->write() to ->write_iter() to make the interface more
>> consistent and allow non-blocking writes from e.g. io_uring. Also
>> reorganize the code and return value handling in a similar way as it was
>> done in eventfd_read().
> 
> But this patch does not allow non-blocking writes.

What am I missing here? He checks the file and IOCB non-block flags,
and returns -EAGAIN if there's no space. If not, it waits and schedules.

-- 
Jens Axboe

