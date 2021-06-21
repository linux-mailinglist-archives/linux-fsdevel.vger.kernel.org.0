Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56213AEC31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 17:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhFUPY6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 11:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFUPY5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:24:57 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937DFC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 08:22:43 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id a6so7640429ioe.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 08:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f4+KG24B2HfsHu90r5w/CTSIPdObAH2jmSrDr7fU9SM=;
        b=yu0tjSyV+aWm1/LSnEeUyroHKv4sQQ0WksMgLMq8S0cEHRsTrpPdWDCnOuS28qZN9o
         un2vzgckJfJjg5+6O2I+4zDLnmO4QA+iV0oC3URiRjWm95DbcIobadE+FsrT6dUNLLs1
         uFMY+jfDD9TM8bQfQ+a1/JrBRo4SfVvcxS33+0o7eb5O9Xo1QQv2Vt6DrpTCQdIudQcB
         uuoy5h1f1sZntYJ9q0XRv5pbqB4RxCs+uRz6KZkKMDIcRBvoKjA/lzVQ8Tm+G13nDCy5
         J+5h1ymI3mtHz3I3PAEPUfAgcn/OdojubAry9E85aAduiwFQEdQtfiEfYjz8MxH50V+x
         uiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f4+KG24B2HfsHu90r5w/CTSIPdObAH2jmSrDr7fU9SM=;
        b=FHZTVpAc8o5Qm9ONu2/QZyjlmLZSJ39CAAMrbr3/0pB+kDoLVvHPMCj0kG9fRbSS65
         JJinFWrc1qnB/+Wg/C61SnogYkzjERW4AVWRdkcRZzXrDCbNjxIN2I2ml20g1kEufEHc
         zL0Cii4vqhK2JCI/XRakjP9BbZBqs/L2xoKs55J1Zmi/OXSw9k8kbeP1RzcYGIyVsCum
         ZU0fVKNsszyemyvcHSy+ZMI8pRY/1C4dYOo69kBvhanpuh95LuuhynWNW9HOk5qMHBh2
         8440QfagW6qEu8Zivg6oSKMUtyosh8iEjkWfpnEZzCkQElN8fZ/aEJSaPFB7UfNU40sZ
         hb1w==
X-Gm-Message-State: AOAM533b6Yi8yN+2jxHWRdCu+Zn98KSlz1FccUFXMLXTZVmOXVvEn1um
        nNXN+nU+ciiNW0DgUhTez12Q0ZlASli4WQ==
X-Google-Smtp-Source: ABdhPJzba4aETNHXz2GtAV4P2QwTd0dsPIIb9pmpViw7tI433U6ibGhDScn5KJr+e8TCNA07ITZIrQ==
X-Received: by 2002:a5d:89d0:: with SMTP id a16mr6758173iot.76.1624288962654;
        Mon, 21 Jun 2021 08:22:42 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v10sm47399ilg.84.2021.06.21.08.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 08:22:41 -0700 (PDT)
Subject: Re: [RFC] what to do with IOCB_DSYNC?
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
References: <YM/hZgxPM+2cP+I7@zeniv-ca.linux.org.uk>
 <20210621135958.GA1013@lst.de> <YNCcG97WwRlSZpoL@casper.infradead.org>
 <20210621140956.GA1887@lst.de> <YNCfUoaTNyi4xiF+@casper.infradead.org>
 <20210621142235.GA2391@lst.de> <YNCjDmqeomXagKIe@zeniv-ca.linux.org.uk>
 <20210621143501.GA3789@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <096ea3c0-d96f-d8f5-5527-bf66d490734b@kernel.dk>
Date:   Mon, 21 Jun 2021 09:22:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210621143501.GA3789@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/21/21 8:35 AM, Christoph Hellwig wrote:
> On Mon, Jun 21, 2021 at 02:32:46PM +0000, Al Viro wrote:
>> 	I'd rather have a single helper for those checks, rather than
>> open-coding IS_SYNC() + IOCB_DSYNC in each, for obvious reasons...
> 
> Yes, I think something like:
> 
> static inline bool iocb_is_sync(struct kiocb *iocb)
> {
> 	return (iocb->ki_flags & IOCB_DSYNC) ||
> 		S_SYNC(iocb->ki_filp->f_mapping->host);
> }
> 
> should do the job.

I think that's the right approach.

FWIW, my more recent testing does show the init of the iocb being the
big cycler eater causing slowdowns for sync IO in conversions to the
iter handlers instead of ->read/write. Would really welcome the
improvements suggested here, various conversions are stalled because of
it.

-- 
Jens Axboe

