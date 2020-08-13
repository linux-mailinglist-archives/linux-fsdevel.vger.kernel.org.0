Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA55244070
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 23:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgHMVb5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 17:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMVb5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 17:31:57 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FEDC061757
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 14:31:57 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id o2so3367819qvk.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 14:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A0O34qikXns/ytpRF66igHLNzjuKUB2GXbD8H3lK9Cw=;
        b=wdDEWxTKceXP4HFWkn5yqXxqTabNCYq3NagIUeqh7V54xWCyhnM12KnaT8TFARdxoZ
         64m7DXucAflzdtOUJMjgrOngoGqb44Vq/t6L8rwrgAzV0F3kfbC6ZKihH+qVMARSfX2E
         AboiW0bCtznAPQH4PIdH7U/uL3W0n8tW8KH2nfK/F4C9UCJlBwAj1oiOMZo7Hq1zybIP
         hxXS+pkkTtCPFrE+CqidsGVnbfv4uh0M02k9pFy2dr/cpLPoI7xEE88H5MmveghRVnqu
         0KhBGumVj4x/AOCHRfOypzB4y15VLmUDhbRS0tMB6s9rBGKG8NPr6I4v052d2dh6ZhlU
         i/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A0O34qikXns/ytpRF66igHLNzjuKUB2GXbD8H3lK9Cw=;
        b=ebVY4YA4YZgdvsYmFFFGX3jGCI546mmH5E41THbiN6dKGB1qUHwOEnzDwNxL6oDc3s
         ldutDAhUsv4XN4Dcb8HZZbOjcBBTftI6G9lcPXnk4nV+XqMtaP004FN4BttcZmX+eGho
         NwJBoOwhQnPMYEt7jFgJD1ffSa2QxGa4/R885rghvI5Hy653StqnA/5jFPwq96rGrzF2
         zjvA82rgLy1O5OxpQGONRSbYR+gSp2Ogd3hjLbilar1nn2Lf+BtgLYiBCEEJqDiUsDNQ
         TzaDfCMGvvJKpFQjBvH0628HHIPsV9dgk5VQFN8YarOjEWE174Sx1dzqLoAIu/6HdigU
         fRsw==
X-Gm-Message-State: AOAM533k1IZulL6nhC9Okdxm65KQv0ZH4sz6HEVEmER//WU+abjx+6/u
        vS3GXwXzED0jzQbCdJSJqEb9gQ==
X-Google-Smtp-Source: ABdhPJw1739/fps5sGg94EWIzpqBNse+OfMx9SH2Fwv3YnMBXDckZmA8TU/hJN9RPgxR4hPxf11hKg==
X-Received: by 2002:ad4:54b2:: with SMTP id r18mr6617359qvy.92.1597354315991;
        Thu, 13 Aug 2020 14:31:55 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::10a7? ([2620:10d:c091:480::1:fe9c])
        by smtp.gmail.com with ESMTPSA id i75sm6829279qke.70.2020.08.13.14.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 14:31:55 -0700 (PDT)
Subject: Re: [PATCH][v2] proc: use vmalloc for our kernel buffer
To:     David Laight <David.Laight@ACULAB.COM>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "willy@infradead.org" <willy@infradead.org>
References: <20200813145305.805730-1-josef@toxicpanda.com>
 <20200813153356.857625-1-josef@toxicpanda.com>
 <20200813153722.GA13844@lst.de>
 <974e469e-e73d-6c3e-9167-fad003f1dfb9@toxicpanda.com>
 <20200813154117.GA14149@lst.de> <20200813162002.GX1236603@ZenIV.linux.org.uk>
 <9e4d3860-5829-df6f-aad4-44d07c62535b@toxicpanda.com>
 <3612878ce143427b89a70de3abfb657d@AcuMS.aculab.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <cd5ecedc-cef1-4325-36aa-e7b06485f3a1@toxicpanda.com>
Date:   Thu, 13 Aug 2020 17:31:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3612878ce143427b89a70de3abfb657d@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/13/20 5:10 PM, David Laight wrote:
> From: Josef Bacik
>> Sent: 13 August 2020 18:19
> ...
>> We wouldn't even need the extra +1 part, since we're only copying in how much
>> the user wants anyway, we could just go ahead and convert this to
>>
>> left -= snprintf(buffer, left, "0x%04x\n", *(unsigned int *) table->data);
>>
>> and be fine, right?  Or am I misunderstanding what you're looking for?  Thanks,
> 
> Doesn't that need to be scnprintf()?
> IIRC snprintf() returns the number of bytes that would have been
> written were the buffer infinite size?
> (I suspect this is an 'accidental' return value from the original
> SYSV? userspace implementation that just dumped characters that
> wouldn't fit in the buffer somewhere.)
> 

Yeah, if you look at the patches I just sent you'll notice I used scnprintf() 
everywhere.  Thanks,

Josef
