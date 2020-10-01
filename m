Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F86280935
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 23:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733095AbgJAVI3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 17:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgJAVI2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:08:28 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07A6C0613D0
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2020 14:08:27 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id b13so107405qvl.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2020 14:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L5xnGp8SmU9BPT8epzS2zXOYvzWZom/+rkEDJDmq8FM=;
        b=HismU7trUEQ67V1iFgIi8ZKiEK7BujifavJHD8fC1UTS5NAhk5oWfKrq0O11yZ7Aef
         cAQzXCRy49dJEBg+fygFxaffp5clOqaLcBrk00oQiOxmW5LYBP/BnCHkFCfZeKw7WVCF
         fiORlxhlc39z8dYt0AS4AMbjENCEiWh4FEQ0wVAE4yZDPpL4vExHseIPRv8EAokOS8Fk
         yKNQHKrLk8tUtDZo2BENz9PnZNVkvARgNkTSgzuY5Q+viq/GJzs+wduvxqim3uSaCrvw
         y1Lj1nmYvWwRqiOyRHc7W6HU5gLtmsyUczY7kqz6Hdjzd5GdWrN/1Pj+p/775IjgWBYy
         vTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L5xnGp8SmU9BPT8epzS2zXOYvzWZom/+rkEDJDmq8FM=;
        b=FciGjfAlcop6Kw6J6DeQ7de9cSkKHjS0Wy1QtSgl81Nvrs3hrM5VYqfpHxQdeHrvSC
         L61Wh89GBv4PRI/YLFHVXZnG3uXUUj0d636bnCM/lyo7GCbs9W08jEGrkKfPKk960ZSk
         /Iz62xsu3w30uN5Is07z4BHap90Ngaq6pfn3Zqf0/upZvkZGauCja+nASrDm4E2AqAiK
         Jff2tVb7lqZqNUm0Qt3Fy2Y01gtvBnV6sbMEa7jEPT4Kg7OKEdgQB/TCYIGUCAqzVYY5
         VGYI7Qv3a33yjMLX8Mo2aSnLcg523P4111K2HisV6FrB8juorywUhCCLWLO2MHs3qh6k
         M8cg==
X-Gm-Message-State: AOAM533lLByAvQ8SWEZoY3Fx3//hT78GQrMYoMUBU88DSDkfbsscCmnt
        c8vlNtdip1RgxE0muBO8aDg0F7GgbgGQr8R8
X-Google-Smtp-Source: ABdhPJwfBvEERwx/rhhrMg+ntOUdO48iSshjD+VvE/k7sX/ATCyLYyGh8O3briFwd7wIqB8IyIvWew==
X-Received: by 2002:a0c:e892:: with SMTP id b18mr9648260qvo.5.1601586506774;
        Thu, 01 Oct 2020 14:08:26 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j197sm7475666qke.131.2020.10.01.14.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 14:08:26 -0700 (PDT)
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
Message-ID: <890b194d-8ed5-5434-3336-ffe8e287bde5@toxicpanda.com>
Date:   Thu, 1 Oct 2020 17:08:25 -0400
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

It's been running for an hour without hanging, you can add

Reviewed-and-tested-by: Josef Bacik <josef@toxicpanda.com>

Thanks!

Josef
