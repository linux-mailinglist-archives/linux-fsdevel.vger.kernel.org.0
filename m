Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D32243C33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 17:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgHMPIq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 11:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgHMPIp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:08:45 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7984C061757
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 08:08:44 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l64so5433192qkb.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 08:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TpPqrvEx4xHNdepObOT++ZGuQdpdQDmnw4mMGhCoSdw=;
        b=j5tFYd0Cke7wCpz/RBUl63TsW/KeW2sBcGKKKs1j8bP+N/s9pC1fv8BV43lOW57uMG
         CvJhu6WdBQN2/XSUUsH7Wm9VNKmUDojnwtmCrMzhc0dgkJ+JAVtPvXJ/v1FA+B7K/SGp
         8Y10Esl8wz78DqSl2csvd2i0dSJWBKP9TWZzJ0CgquXx7CNptlpoRXcnPEUQs40VL8az
         zWH26MV4K1cOXN0/l0RYDBDQpeAxglL1uYdXd7TZ945NlNIVz2wy4caEZ99C+lNj+ybK
         stnMeJXGeEDZlHHlxgIDqt2TvDUTRUvVyE18UNJ4erGruWeho93gWKaB8U8dMNVOByg9
         b2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TpPqrvEx4xHNdepObOT++ZGuQdpdQDmnw4mMGhCoSdw=;
        b=Y9npDl1hF1biYb38OewRLhWoOm9hQwlsck3QzfPPw/0EUGk6SJTzfajURZlQ1lwLWU
         I+V5XH7vaolEbIQD+ZxhdGGRvhLL9JlAAfHkQnu42WiYIou9Z/iHLToJlxoo5QUhIgy3
         /k9/3CQso0ysAkuQMA9Ikc+Nj4awCwIdpHyCZdcuhLQINXEjm74uGwNZZtfMNv0cqyGR
         nPomCIziIGCLBg0OTNTlw2ahtgbMxUvVm29c1kzurNr0upQGm+X9ruFWBbZspNeInzzH
         yYvLTX9cM89BzL7Lh8uqfc4ECyZU5i0lI6JJJ1pYHObVmvNc4MXr4JkmIzNuIVNlJ+yR
         +uZw==
X-Gm-Message-State: AOAM531SdFtMWNOK/FWoJVNwjbil0PJKm9gWYrRdr+S9bI+BagKxbyMV
        k7YNPQ0/1UHCRTPchSFvRPAUZA==
X-Google-Smtp-Source: ABdhPJxU5xv81Z8slBsIXbEz9xC3rOMSBeqzbXHaZyURciBgvMTJxYo2+91SFZkPPcaeGCbCJMJ9dw==
X-Received: by 2002:a37:a45:: with SMTP id 66mr5214506qkk.435.1597331323806;
        Thu, 13 Aug 2020 08:08:43 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::10a7? ([2620:10d:c091:480::1:8f88])
        by smtp.gmail.com with ESMTPSA id l1sm6540036qtp.96.2020.08.13.08.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 08:08:43 -0700 (PDT)
Subject: Re: [PATCH] proc: use vmalloc for our kernel buffer
To:     Matthew Wilcox <willy@infradead.org>
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20200813145305.805730-1-josef@toxicpanda.com>
 <20200813145941.GJ17456@casper.infradead.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3fad71b2-eda1-aca4-f421-41d2097e4769@toxicpanda.com>
Date:   Thu, 13 Aug 2020 11:08:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813145941.GJ17456@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/13/20 10:59 AM, Matthew Wilcox wrote:
> On Thu, Aug 13, 2020 at 10:53:05AM -0400, Josef Bacik wrote:
>> +/**
>> + * vmemdup_user - duplicate memory region from user space and NUL-terminate
> 
> vmemdup_user_nul()
> 
>> +void *vmemdup_user_nul(const void __user *src, size_t len)
>> +{
>> +	void *p;
>> +
>> +	p = kvmalloc(len, GFP_USER);
> 
> len+1, shirley?
> 
>> +	if (!p)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	if (copy_from_user(p, src, len)) {
>> +		kvfree(p);
>> +		return ERR_PTR(-EFAULT);
>> +	}
> 
> I think you forgot
> 
>          p[len] = '\0';
> 

Sweet lord I need more sleep, my bad.  Thanks,

Josef
