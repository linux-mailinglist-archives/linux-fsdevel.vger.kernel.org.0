Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6115F280811
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 21:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgJATwG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 15:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgJATwF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:52:05 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E022C0613D0
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2020 12:52:05 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id db4so3753042qvb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2020 12:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=amhuZRTrcgQIVXmT057DFVjm/VxiWGRQUCfIJWZIZwU=;
        b=wQ0l5ZktQ/oeg9Dqf+dc3G9tfsThxahO1Fwb/QwVIgO/U58MSkOoat+xb66COK2fxV
         6JCPmnmoSTeNkLXfY6l8PbrvGpplhZQF4n6taeWXgJbM8/mPxjFhcuW6Y2BTEJ62dAUU
         pGWs+pgwucD/H4mDQ+3TvsDG/ci2FWvwbSs3xx8xx0IiOO5XfCwOs6Y4vVHJdPYu/9nu
         0PTA3U8JXfGWH62P+oPFl+6I5Y9Q7/ODpnUbn/8uGPIU4avnPGZvnWct5tFHV7dLj5rr
         rRit0uVG4YHsKUPPi8MZG6QHAHLmz3/Nm1NWl/xhuFSiHt89Ha/aX2cfjv01IhJv8qGp
         x9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=amhuZRTrcgQIVXmT057DFVjm/VxiWGRQUCfIJWZIZwU=;
        b=tGayDsdbg20RqTpTzwu3Rcfj9C495vUuFhcc0dM64VdlL3YowBWniLzhb9fqd2d02F
         OIZx/bzEjtvD8DwgE2I+TkmoZPNeWeXTLhOzOjk61DievoyvGRP0MTCZkbT2x9bfwVDN
         MEx28ZdgW3UWcInY6gToLeDxSlKjD/CJSh3OBiTgwSpdmpIpldavuDvHDB4OZS4tNglX
         xjDReEf6TcDWe89Qk2J7OTu1qGTn0wyRxTG1mLajlUv3htM8xtVDUf+HAy8CutzPcfYj
         cMFScd87aXwEcgOJFZEZoGPbEflDX4+TiM03FZaUX8iSKY9S25052l2p0hZdRMbaawmK
         OdKA==
X-Gm-Message-State: AOAM532oyuQlYY5MEyOT/mAi5T8C0UBwAvN13mhCgxZ5yMiJgZxRvpAF
        T8C5lw0rhZfMigvhfVUDuRkE0kenrMwsjJJJ
X-Google-Smtp-Source: ABdhPJyGn3L1+8Mij1Sn7ctAhde8k9+g62792hMAPYYFXoOKl8uPrQS/ekkyjM12RfWgJZsLS5pXgw==
X-Received: by 2002:ad4:544a:: with SMTP id h10mr9428886qvt.35.1601581924444;
        Thu, 01 Oct 2020 12:52:04 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d123sm6788365qkg.71.2020.10.01.12.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 12:52:03 -0700 (PDT)
Subject: Re: [PATCH] pipe: fix hang when racing with a wakeup
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <bfa88b5ad6f069b2b679316b9e495a970130416c.1601567868.git.josef@toxicpanda.com>
 <CAHk-=wj9-Cc-qZUrTZ=V=LrHj-wK++kuOrxbiFQCkbu9THycEQ@mail.gmail.com>
 <eb829164-8035-92ee-e7ba-8e6b062ab1d8@toxicpanda.com>
 <CAHk-=whwZxj0WdGk2ryax574ut1xPq-=12DcFxZgq9rmCBdDbg@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b2d0752c-40a2-e675-9982-3c8e99f592d4@toxicpanda.com>
Date:   Thu, 1 Oct 2020 15:52:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=whwZxj0WdGk2ryax574ut1xPq-=12DcFxZgq9rmCBdDbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/1/20 2:38 PM, Linus Torvalds wrote:
> On Thu, Oct 1, 2020 at 10:41 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> Obviously not ideal, but I figured the simpler fix was better for stable, and
>> then we could work out something better.
> 
> I think the attached is the proper fix, and it's not really any more
> complicated.
> 
> The patch is bigger, but it's pretty obvious: get rid of the
> non-specific "pipe_wait()", and replace them with specific versions
> that wait for a particular thing.
> 
> NOTE! Entirely untested. It seems to build fine for me, and it _looks_
> obvious, but I haven't actually rebooted to see if it works at all. I
> don't think I have any real splice-heavy test cases.
> 
> Mind trying this out on the load that showed problems?
> 

I wrote a simple reproducer, reproduced the problem on an unpatched kernel in 
like 20 minutes.  I'm loading this up, I'll call it fixed in say a couple of 
hours?  Thanks,

Josef
