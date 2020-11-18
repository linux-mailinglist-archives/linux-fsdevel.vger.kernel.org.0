Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20072B885B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 00:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgKRXZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 18:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgKRXZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 18:25:40 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12766C0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 15:25:40 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id q34so2427673pgb.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 15:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iVPm75HCejAbfrsPX/m4lDspW5RIkaFULkWaEI+VKIw=;
        b=sCl5Zm2CR6tiUD87M2YHG8Fe+rfguExcgnvmDaoLUyknnQcaTKbNTRwyTkqMfkrzwv
         pSDEwDwKtNKsdSuXNu8mPzscp50kLawU+n0Ud/rb76ctnxugAFSudElUer/qKEWSgq87
         hydsMrdqBN+AUvIyFmgy3QsmgMTddhIv2jmuQ7Oq0sdh1+2VSn2iZBvtGkU3EnLGXjkh
         v5o0ecQ1coCrB+exxBEbGj0XknMe6MHuKt/gytC32OB+xoxrC/V9oxH+6XdUKvCwn8hc
         UNY6T6W8tsg+UH+1yEEJympbB03icjyYuvx0GXr3jrNPXsI//lYAm/Y7iBf2wi6BeZtO
         6PXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iVPm75HCejAbfrsPX/m4lDspW5RIkaFULkWaEI+VKIw=;
        b=PRnQpiqc7UBRT6TEtERuiU+rQImSoZotF6SndSYTDiM1xnatBRlSYGIFL/iggv/YRk
         cRqXgbYd0dIkcLKiSMTPLFlORNPa7DSYCY9NG9DB2cThIJlMbBWSGoFgtAxEgd2hMj/V
         MnTOooolUPNK/Zt0q7SJRFDT+9I06gkLUilfJmQebseHAAimMgQMOHif1kfS6NEsKPEY
         yC7XI5KV8XebLIcyz3LurSVQzj0j95pw3kGxtvhlqWQqxiX4NoNxZ5DoBQiGwKsE7Gz9
         1hDdev6qIPcIHnS8rjxosbINgSlhBDcV1kCFAXlrywch/wFH8yPPwUm408QXKGDlgEel
         rxFg==
X-Gm-Message-State: AOAM532EHori7RAQrXdl3Ql6dZY+tl9k28fiQC3frnIIjeyKIcQiZi0u
        0XNoNaxUD57jKmyqGiDuNBshS0IvtMHoIg==
X-Google-Smtp-Source: ABdhPJxs+GhEvkod5U8YnL990GhfAx47xjK/0XSERjCGGuq1PM+o0vfwR2ZceI+WLIxX2Bs7vRyyeQ==
X-Received: by 2002:a17:90b:f10:: with SMTP id br16mr1336797pjb.60.1605741938998;
        Wed, 18 Nov 2020 15:25:38 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id k9sm25833590pfi.188.2020.11.18.15.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 15:25:38 -0800 (PST)
Subject: Re: [PATCH] eventfd: convert to ->write_iter()
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <8a4f07e6ec47b681a32c6df5d463857e67bfc965.1605690824.git.mkubecek@suse.cz>
 <20201118151806.GA25804@infradead.org>
 <20201118195936.p33qlcjc7gp2zezz@lion.mk-sys.cz>
 <4e4d222c-ed8b-a40d-0cdc-cf152573645c@kernel.dk>
 <20201118231835.u6hqivoayq5ej4vg@lion.mk-sys.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7323253d-003a-456c-166c-d85a614c8bf6@kernel.dk>
Date:   Wed, 18 Nov 2020 16:25:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201118231835.u6hqivoayq5ej4vg@lion.mk-sys.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/18/20 4:18 PM, Michal Kubecek wrote:
> On Wed, Nov 18, 2020 at 02:27:08PM -0700, Jens Axboe wrote:
>> On 11/18/20 12:59 PM, Michal Kubecek wrote:
>>> On Wed, Nov 18, 2020 at 03:18:06PM +0000, Christoph Hellwig wrote:
>>>> On Wed, Nov 18, 2020 at 10:19:17AM +0100, Michal Kubecek wrote:
>>>>> While eventfd ->read() callback was replaced by ->read_iter() recently,
>>>>> it still provides ->write() for writes. Since commit 4d03e3cc5982 ("fs:
>>>>> don't allow kernel reads and writes without iter ops"), this prevents
>>>>> kernel_write() to be used for eventfd and with set_fs() removal,
>>>>> ->write() cannot be easily called directly with a kernel buffer.
>>>>>
>>>>> According to eventfd(2), eventfd descriptors are supposed to be (also)
>>>>> used by kernel to notify userspace applications of events which now
>>>>> requires ->write_iter() op to be available (and ->write() not to be).
>>>>> Therefore convert eventfd_write() to ->write_iter() semantics. This
>>>>> patch also cleans up the code in a similar way as commit 12aceb89b0bc
>>>>> ("eventfd: convert to f_op->read_iter()") did in read_iter().
>>>>
>>>> A far as I can tell we don't have an in-tree user that writes to an
>>>> eventfd.  We can merge something like this once there is a user.
>>>
>>> As far as I can say, we don't have an in-tree user that reads from
>>> sysctl. But you not only did not object to commit 4bd6a7353ee1 ("sysctl:
>>> Convert to iter interfaces") which adds ->read_iter() for sysctl, that
>>> commit even bears your Signed-off-by. There may be other examples like
>>> that.
>>
>> A better justification for this patch is that users like io_uring can
>> potentially write non-blocking to the file if ->write_iter() is
>> supported.
> 
> So you think the patch could be accepted with a modified commit message?
> (As long as there are no technical issues, of course.) I did not really
> expect there would be so much focus on a justification for a patch which
> (1) converts f_ops to a more advanced (and apparently preferred)
> interface and (2) makes eventfd f_ops more consistent.
> 
> For the record, my original motivation for this patch was indeed an out
> of tree module (not mine) using kernel write to eventfd. But that module
> can be patched to use eventfd_signal() instead and it will have to be
> patched anyway unless eventfd allows kernel_write() in 5.10 (which
> doesn't seem likely). So if improving the code is not considered
> sufficient to justify the patch, I can live with that easily. 

My point is that improving eventfd writes from io_uring is a win with
this patch, whereas enabling kernel_write() makes people more nervous,
and justifiably so as your stated use case is some out of tree module.

So yeah, I'd focus on the former and not the latter, as it is actually
something I'd personally like to see...

-- 
Jens Axboe

