Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D5723538E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Aug 2020 19:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgHARBl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Aug 2020 13:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgHARBk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Aug 2020 13:01:40 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3014C06174A
        for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2020 10:01:40 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s15so6074955pgc.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2020 10:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+PxwhlYwCuE9vpR6eFkH2yWrmfz/AznBDZGYrMjxyzI=;
        b=qJvC55oDMsvRufkXV/nYX2jzTVwfRz0BB8sRjqmBBtDWN7gYn0xBngG1/IBFUZewdc
         PUQpInS0ReZRlxhBfTDuBiG0MPW6CdU5Kly4Q1xxnXx2iWxu7D+UmOeEIu4e3kX95HU7
         aj+v1UIehBO8EsvvmW/J6a0NTd2qEk5iJR93eTzNqJLIrtKwkp+m/9+EVzDKKhUsMPku
         oihU/QrBcjwqdF0X4EbuNwCjUgIoEi3NnTkWyDDP/7c5ZV6IeoeQ/MhidDhCLSbFFclw
         buGaqFpFw+BQr2CusP4T5H8hygVCalRZoOGAQPdCAOBkW8imxkMRSGvb/Z3pbcqGiXrH
         6GrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+PxwhlYwCuE9vpR6eFkH2yWrmfz/AznBDZGYrMjxyzI=;
        b=AswssYxK5qPdyeHC00qqtMxYxk+jRMDu/5J25KF4oV7viyxQLxrU+RE14bjKSFqcUH
         PcSzpcrHGbG3hvTn5UHmOwfjHSAwdhp5o7Cew+rvFDKoXlLXtj5IitoibgeQo5BatoYl
         qe9Log4syaCh4OcrxANTs03KTod+SXgfgTh3vru2RULtLAbpUYYfC6rD2mIJsFQEI2ma
         H7vlJvwgP38AMmmdN/DDmdYcr8uKhKVkS7Cgk0dxqz3reAAYtmjFhTJNQ+UDHKrWbLK1
         fnYSfzIL1vNMRF6JM8j3UkFuJNIMwqH0HnTOtrv2RX0hKQSgC5oczVvWODMtTsz38GSH
         AKgw==
X-Gm-Message-State: AOAM532Qsq0V3YgQTEj6voqwqVvmDV+obBsPn0QcG0asm5hOZxJ8o8FJ
        FOuPuzsC+BQTJLmuCS6Dzsedlw==
X-Google-Smtp-Source: ABdhPJyBZUtBVHRQU5HCEhS1TkxxnGkUnCedmMiMah7+33vLzFRKPv/bOOVkrcNpamN7sepVDhoxig==
X-Received: by 2002:a62:1505:: with SMTP id 5mr847706pfv.41.1596301300314;
        Sat, 01 Aug 2020 10:01:40 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id jb1sm11175740pjb.9.2020.08.01.10.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2020 10:01:39 -0700 (PDT)
Subject: Re: [PATCH] fs: optimise kiocb_set_rw_flags()
To:     Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e523f51f59ad6ecdad4ad22c560cb9c913e96e1a.1596277420.git.asml.silence@gmail.com>
 <20200801153711.GV23808@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <debd12e1-8ba5-723d-75ad-47af99db05a0@kernel.dk>
Date:   Sat, 1 Aug 2020 11:01:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200801153711.GV23808@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/1/20 9:37 AM, Matthew Wilcox wrote:
> On Sat, Aug 01, 2020 at 01:36:33PM +0300, Pavel Begunkov wrote:
>> Use a local var to collect flags in kiocb_set_rw_flags(). That spares
>> some memory writes and allows to replace most of the jumps with MOVEcc.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> If you want to improve the codegen here further, I would suggest that
> renumbering the IOCB flags to match the RWF flags would lead to better
> codegen (can't do it the other way around; RWF flags are userspace ABI,
> IOCB flags are not).  iocb_flags() probably doesn't get any worse because
> the IOCB_ flags don't have the same numbers as the O_ bits (which differ
> by arch anyway).

Yeah that's not a bad idea, would kill a lot of branches.

-- 
Jens Axboe

