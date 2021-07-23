Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458033D3D61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 18:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhGWPg4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 11:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhGWPg4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:36:56 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69850C061757
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jul 2021 09:17:29 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id o7so855718ilh.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jul 2021 09:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ihWneKebM4lpsOeEFb80CNpygB9RTktVEb8Cc/YXHUc=;
        b=lUn6K2TYkavFX2oglx3hEhjVlhSxKHyQQ3xMrUsOyQ48uDXj+cDolNgviLuNitadjX
         pey4VdiGPxv/G3WbY2GAjMbZWKbdIPw0nj0aU7Wx9tGEeMR+MuQukP77zySNuwD0yUro
         abLQdDe8nxxeZY73r9WZx8LhOYIInZVExEpLI0YEutxBlojv8KaxKOhUsdIIyi5DV1Lv
         t6rhXW6kEmLSa2htH0LcPOhIoRPwnFviLW37UDMy8t8wWaQuEPksg16jPoG7VxBO1DBw
         UtZ5Am+KeD/GMH8ozZDXlBjhkvzrPeXEZJuPXlwWf5vpUo2IyOsDcNRsVgOFSNuNowze
         5GDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ihWneKebM4lpsOeEFb80CNpygB9RTktVEb8Cc/YXHUc=;
        b=PP8xHOugCnhIFyeHd8o94giIrH1ynnF4YWt+JW95F3OUZp+4WPsKJvP4pOieXEpIE3
         rkYrdDtoqFm2feKCGl9WIMhzm51foGRp0Vum+peb8Oi5YXCnfRXw2fCbchkPoknq2Hg4
         qnuZGdHju0g7M5vbRa830eF5zVfhOuF7DvFwG7gf/+1hES3n7oVQ85HNgrU/PzniMWu0
         meUM3oOueySyNkRKXAaq1XkQ9X1f8dNDhdVNHDhiFSHFLn2RP/MAD/OJTamuqhyPbgHE
         rPTBl1Sdw6lbpQtYkPvI6E/I1R3Eii8LXRqaW1btuCh3y0TBe/uSDTc+1FiGMsHXQ7tz
         NaKw==
X-Gm-Message-State: AOAM530GzWEm7xykwBM7lzYgsE5wsXT+JIblwFRRM6CvVMLydi3SxyPO
        AIgHo/2bD78EBhl4q8/TlU5/HQ==
X-Google-Smtp-Source: ABdhPJyPOnhWH64cVqUzTNSWHK2FqyJ+GkOfJQ1D0PSUIohw+xTLS0G3vSwAAXD3sTw66ytGr+GM1A==
X-Received: by 2002:a05:6e02:5cf:: with SMTP id l15mr3943619ils.90.1627057048691;
        Fri, 23 Jul 2021 09:17:28 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a17sm12803ios.36.2021.07.23.09.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 09:17:28 -0700 (PDT)
Subject: Re: [PATCH 3/3] io_uring: refactor io_sq_offload_create()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <cover.1618916549.git.asml.silence@gmail.com>
 <939776f90de8d2cdd0414e1baa29c8ec0926b561.1618916549.git.asml.silence@gmail.com>
 <YPnqM0fY3nM5RdRI@zeniv-ca.linux.org.uk>
 <57758edf-d064-d37e-e544-e0c72299823d@kernel.dk>
 <YPn/m56w86xAlbIm@zeniv-ca.linux.org.uk>
 <a85df247-137f-721c-6056-a5c340eed90e@kernel.dk>
 <YPoI+GYrgZgWN/dW@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8fb39022-ba21-2c1f-3df5-29be002014d8@kernel.dk>
Date:   Fri, 23 Jul 2021 10:17:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YPoI+GYrgZgWN/dW@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/22/21 6:10 PM, Al Viro wrote:
> On Thu, Jul 22, 2021 at 05:42:55PM -0600, Jens Axboe wrote:
> 
>>> So how can we possibly get there with tsk->files == NULL and what does it
>>> have to do with files, anyway?
>>
>> It's not the clearest, but the files check is just to distinguish between
>> exec vs normal cancel. For exec, we pass in files == NULL. It's not
>> related to task->files being NULL or not, we explicitly pass NULL for
>> exec.
> 
> Er...  So turn that argument into bool cancel_all, and pass false on exit and
> true on exec? 

Yes

> While we are at it, what happens if you pass io_uring descriptor
> to another process, close yours and then have the recepient close the one it
> has gotten?  AFAICS, io_ring_ctx_wait_and_kill(ctx) will be called in context
> of a process that has never done anything io_uring-related.  Can it end up
> trying to resubmit some requests?> 
> I rather hope it can't happen, but I don't see what would prevent it...

No, the pending request would either have gone to a created thread of
the original task on submission, or it would be sitting in a
ready-to-retry state. The retry would attempt to queue to original task,
and either succeed (if still alive) or get failed with -ECANCELED. Any
given request is tied to the original task.

-- 
Jens Axboe

