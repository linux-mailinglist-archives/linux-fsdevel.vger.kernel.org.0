Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8149C3E34C6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Aug 2021 12:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhHGKbh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Aug 2021 06:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhHGKbg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:31:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C9FC0613CF;
        Sat,  7 Aug 2021 03:31:18 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n12so4366957wrr.2;
        Sat, 07 Aug 2021 03:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xz2POERoj03wWLZEE/kDhO0wJ4yd+zaF3oDDbK7OnvA=;
        b=H2XHvma4LuuSVfBN8ILh6Jp9Pdbm1fXiqibs3HZAbEsSl2t9PmxV++zAVQc3H20S1J
         o7IRX3aQFf4Hu51bxL2+rQoDOmUElyxC+/cv9kq6OOirBn306UgSQNktK80MTV/7ewUD
         flytjI+yKhudqqDhG2ZblB/OFBenWkx8apuISOGUkeLkgSL9Dk+ZBZ57FLYTNxlkdHQ/
         wCoYiIZCpQj7SN/bW7GPLxUa5EaB5nnfsqBeo3DxPgM8nut6+YKOzpcH1Yy95NBXBwRa
         r9NXjx4m/j24gIPdtchs4FlDitXBdMrojfpcAUPa0E8SECt6Y5zx3h872RH2NCDAHhdk
         zDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xz2POERoj03wWLZEE/kDhO0wJ4yd+zaF3oDDbK7OnvA=;
        b=p5CE2Jzdhcw5ZaTEdsdxaVB4yeDgSj0+1D81NFNFe8cgvCbf48UIv0F+sVg+Mnuusi
         /BV5rVEh3ib5rlCMsj8iLum+ivOjuNQL7JxO2tAfmcqt7fbQQTjzBD2TsHItN1hW2oHd
         2tSofvG9gfOi8rm/r7vNaQzd+JvQosw4b6pN1ThpgBLHOBvDfC2FzDEs+7DPrNpHW459
         9muJue30eOwg4WalpCPAZnooTuON6GeQ9OGeE+/AhmNTcI2jBOB6Q7mBAF2g8s7tD3gQ
         nx9ZCAqKp93/D7VUMmtLwETkaUdc3wOloy1OhRYLuLZmTdrjFxxW4twrfsSAp+wMuFo+
         L8Cg==
X-Gm-Message-State: AOAM5322jGOM5+lU3T3aEE1LA2743uyUdudjTI+O0QDEE0RzBA16Egjv
        daB8ywfT40rcN9IPePCi/4kQzpVA45Y=
X-Google-Smtp-Source: ABdhPJzaxfdJrn/5/vNvO8eZMGRSq0NWEnWYnVHGVQv3O4xWrSyYXv+bhW2iZXMYwhQQZTbFwvfGRQ==
X-Received: by 2002:adf:f383:: with SMTP id m3mr14747988wro.81.1628332276733;
        Sat, 07 Aug 2021 03:31:16 -0700 (PDT)
Received: from [192.168.8.197] ([85.255.237.206])
        by smtp.gmail.com with ESMTPSA id x15sm15023813wmc.13.2021.08.07.03.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Aug 2021 03:31:16 -0700 (PDT)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
References: <07bd408d6cad95166b776911823b40044160b434.1628248975.git.asml.silence@gmail.com>
 <YQ09tqMda2ke2qHy@zeniv-ca.linux.org.uk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [RFC] mm: optimise generic_file_read_iter
Message-ID: <d6d36192-4afa-c8a5-5bc0-43bb667b7694@gmail.com>
Date:   Sat, 7 Aug 2021 11:30:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQ09tqMda2ke2qHy@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/6/21 2:48 PM, Al Viro wrote:
> On Fri, Aug 06, 2021 at 12:42:43PM +0100, Pavel Begunkov wrote:
>> Unless direct I/O path of generic_file_read_iter() ended up with an
>> error or a short read, it doesn't use inode. So, load inode and size
>> later, only when they're needed. This cuts two memory reads and also
>> imrpoves code generation, e.g. loads from stack.
> 
> ... and the same question here.
> 
>> NOTE: as a side effect, it reads inode->i_size after ->direct_IO(), and
>> I'm not sure whether that's valid, so would be great to get feedback
>> from someone who knows better.
> 
> Ought to be safe, I think, but again, how much effect have you observed
> from the patch?

Answering for both patches -- I haven't benchmarked it and don't expect
to find anything just from this one, considering variance between runs.
I took a loot at the assembly (gcc 11.1), it removes 2 reads to get
i_size, write+read that i_size from stack, because it stashed it on
the stack.

For example, we've squeezed several percents of throughput before on
the io_uring side just by cutting sheer number of not too expensive
individually instructions. IMHO, it's easier to do when you spotted
something by the way, than rediscovering the same during a performance
safari.

-- 
Pavel Begunkov
