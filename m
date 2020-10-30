Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2CD2A0BAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 17:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgJ3Qti (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 12:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgJ3Qti (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:49:38 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D232FC0613D2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2020 09:49:36 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id p15so8221142ioh.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2020 09:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tG+n/t1qBUCj/v91rLdw/q5jo3ynBwp9llr1Pk6zEPE=;
        b=l8D1Ji+XaROHEacSN2Rjdc7PFJjkcXtiPo8gC7oxf46mBeSxyFW+VH3f+CDlnsjmQ3
         tRqLM8UACXn+ZDZYvN1CuE7DksVY91gtlEk+TkxLBX5n9K8RmBojLDJ6ZD+M/zAvuTG/
         bjrKnXsoZ9PZMwoau41Pm43aj3uRXeZ17zMBKXDHpIWcCZ3sHJE+nARyFvDzMQ+TLnKU
         8JKS3Hh036P+gJH7adFif2JEgvMCOlunyoc+nJUEaLan+t5q22dMEu3dnBiezLwTaGzr
         yqKCo5rI5Dr36LssyX9YEnEP+PcK81z2BbS9YwKYDgeL0KqERQ1uOHjur9fQ84NhMyt7
         1Fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tG+n/t1qBUCj/v91rLdw/q5jo3ynBwp9llr1Pk6zEPE=;
        b=QBpWze0o8qBfPvU+IE4I/DmfGXvo53MD1HCMz8aFArXchCa7F80wFcPEyWhoMEFTVc
         PM1T68CW2Pz07h38YqZ2bleNYK+I4BpupwDSUVvNb9gU6iTomj+JONJROfiB6W2xtuFW
         LuH1XHkw1aPOWsZMr221u0ZPnt8Qy9974vWC8OsDPdmTc6LacSBZv19sbkOYpXoxPwd4
         KqA1XDrWW8revy0capeVaa3gP0QlF3eUeKMfy3vR2Lg3TOLZ4Jd0iivyLrS62mbat243
         4ShZdmEPPOgG5OAC0PRU+W9PFO7gfEyI+8LVDt3WuGpcD+JgozP3jEj/YjMks/yUWAIf
         05mw==
X-Gm-Message-State: AOAM533OwBKiS12wCqUhXNf6adZxE0pvbY6lGYBt3tEodu4vbyglLp+L
        UNG+L45Zd9PTkCsI+cxSsovi3g==
X-Google-Smtp-Source: ABdhPJxT5w7sUnGbO12W5ab3BhmMX1OspT+ztMfJzg/947sne96PI/SWqmcXtcBF9UeP3bkrH5NcYA==
X-Received: by 2002:a02:5d04:: with SMTP id w4mr2686525jaa.67.1604076576106;
        Fri, 30 Oct 2020 09:49:36 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w68sm5844136ila.1.2020.10.30.09.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 09:49:35 -0700 (PDT)
Subject: Re: [PATCH -next] fs: Fix memory leaks in do_renameat2() error paths
To:     Qian Cai <cai@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20201030152407.43598-1-cai@redhat.com>
 <251c80d6-a2d0-4053-404f-bffd5a53313e@kernel.dk>
 <09fa614adb555358d39ab606a8c6a2d89ba4a11d.camel@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fa085de9-766c-156a-e6ef-bd834b0cc626@kernel.dk>
Date:   Fri, 30 Oct 2020 10:49:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <09fa614adb555358d39ab606a8c6a2d89ba4a11d.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:52 AM, Qian Cai wrote:
> On Fri, 2020-10-30 at 09:27 -0600, Jens Axboe wrote:
>> On 10/30/20 9:24 AM, Qian Cai wrote:
>>> We will need to call putname() before do_renameat2() returning -EINVAL
>>> to avoid memory leaks.
>>
>> Thanks, should mention that this isn't final by any stretch (which is
>> why it hasn't been posted yet), just pushed out for some exposure.
> 
> I don't know what other people think about this, but I do find a bit
> discouraging in testing those half-baked patches in linux-next where it does not
> even ready to post for a review.

I don't disagree with that and this doesn't normally happen. I don't
want to get into the reasonings, but things had to be shuffled which is
why they ended up in -next before being posted this week. They will go
out shortly.

-- 
Jens Axboe

