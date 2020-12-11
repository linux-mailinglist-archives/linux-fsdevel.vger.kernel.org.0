Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CB92D7EEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 19:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbgLKS4n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 13:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbgLKS43 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 13:56:29 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03989C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 10:55:49 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id u4so5021413plr.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 10:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZXu11A1RjreqDJVVPQHqpitqG78PoTQ7nopVuSH3wTU=;
        b=Sd9VQs4mQ8bKtRyfyVU2wSTjOsjVg/oKg93colg3NSpMUKKDBDz2zM91C5/ekmW0JE
         aQgU/G0QiS7YAuv2EEc9UO5/6GgGlkSj6LiFDwSh4emHMiJTdcciNTFEIGH+KejRG9+R
         UM4nf1TDOtWpqKaXPZnyQKjxMulWWqFG8NvumMTzT2QIirkS5miCtitRPkRimmzkq4uk
         FOAGjQamVtVTFMp98C0JIUgnZvrStLs9JiNLFI2pjvXZMEvRd6+3GhDZF6PZzJGPJHy4
         B+PbhGhxsOECjjJYaHAXrFmZiJ1MuTJPCw0qQLR4UovzrYWfks8YUFgEU6G48kBJ0ty0
         bswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZXu11A1RjreqDJVVPQHqpitqG78PoTQ7nopVuSH3wTU=;
        b=g56/x1FskLznpGdqYnrZ9G2mnTaH6OxE7wx68NKsvkxhE8aI6uHa4c2B4HmnMcatgM
         UawIpAB23T0cKYJH+7fHA4ls+vvGy2MVhAB94jpjaE3LrPteF+z/HLiJ03OWFX/nU7Qe
         zaau5bCT72n7Vme9GmO5dCE4LEn+tYVkHmkiliRR9r/9MEgQB92r6imZHClLyQbG9YNa
         0FK4eoBnswagvB+TUgMc1tlr5VE9mTDpCycjNcyCmLncTIayp5qNsb5Pkaol4/EFUBqe
         bXThdnwF6hhwpOGer9H0vg9qldZHItAvSnJh2XUzMm8X75hvt69iH82P83xTu3sz3MaD
         DurA==
X-Gm-Message-State: AOAM530dqoGmDesAERMjO469xU+nZIDw522zIGweWam60r/JVFUywODm
        foQqur0XoSyqoi5KxZeMY3zA9gEZ3346jA==
X-Google-Smtp-Source: ABdhPJzvayoiUqdOQI1hoazyCm6uZXQveDM2H25QACPxBdB67jocnbuzEgcv2VUVrF0KPn3m775r6A==
X-Received: by 2002:a17:902:26:b029:d8:b213:3765 with SMTP id 35-20020a1709020026b02900d8b2133765mr12301984pla.82.1607712948308;
        Fri, 11 Dec 2020 10:55:48 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id l8sm10602615pjq.22.2020.12.11.10.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 10:55:47 -0800 (PST)
Subject: Re: [PATCH 1/2] fs: add support for LOOKUP_NONBLOCK
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20201210200114.525026-1-axboe@kernel.dk>
 <20201210200114.525026-2-axboe@kernel.dk>
 <CAHk-=wif32e=MvP-rNn9wL9wXinrL1FK6OQ6xPMtuQ2VQTxvqw@mail.gmail.com>
 <139ecda1-bb08-b1f2-655f-eeb9976e8cff@kernel.dk>
 <20201211024553.GW3579531@ZenIV.linux.org.uk>
 <89f96b42-9d58-cd46-e157-758e91269d89@kernel.dk>
 <20201211173305.GB2443@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b496fc38-908b-d3e7-4506-f0b0d6f7b60c@kernel.dk>
Date:   Fri, 11 Dec 2020 11:55:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211173305.GB2443@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/11/20 10:33 AM, Matthew Wilcox wrote:
> On Fri, Dec 11, 2020 at 09:05:26AM -0700, Jens Axboe wrote:
>> On 12/10/20 7:45 PM, Al Viro wrote:
>>> So how hard are your "we don't want to block here" requirements?  Because
>>> the stuff you do after complete_walk() can easily be much longer than
>>> everything else.
>>
>> Ideally it'd extend a bit beyond the RCU lookup, as things like proc
>> resolution will still fail with the proposed patch. But that's not a
>> huge deal to me, I consider the dentry lookup to be Good Enough.
> 
> FWIW, /proc/$pid always falls back to REF walks.  Here's a patch from
> one of my colleagues that aims to fix that.
> 
> https://lore.kernel.org/linux-fsdevel/20201204000212.773032-1-stephen.s.brennan@oracle.com/
> 
> Maybe you had one of the other parts of /proc in mind?

Yes, it is/was /proc/self/ specifically, which the patch won't really
help. But it's not like it's a huge issue, and I'm quite happy (for
now) to just have that -EOPNOTSUPP on open as it does.

-- 
Jens Axboe

