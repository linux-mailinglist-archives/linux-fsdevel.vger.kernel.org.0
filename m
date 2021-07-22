Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270F53D22B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 13:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhGVKrg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 06:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhGVKrg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 06:47:36 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3294EC061575;
        Thu, 22 Jul 2021 04:28:10 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id f190so3113701wmf.4;
        Thu, 22 Jul 2021 04:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0IUu5cxIaYOqC1XS0AMKZ7KuvInfL/EoTMBPiEMolG0=;
        b=QCYAMSL8dCv+avqi2vEPn3dZ2pBZ3RjQ92wroER3XLXz/tLodZFXvsxNXJj6w/PnHT
         To/ChckV6ckCgrTAHDOJHsbe0tmtO5fBladJWMENDRgBndkl1q+EPsziWlBl7S4U3rnJ
         +J8pul7NkJEoMguS7huKS0zSBy8DnP39sm1vI+uwE8nRtrBdy/m56A4CVdS5I3fc855b
         z+bvgeU8agsIhbfZpNsjHzrYXMVWg14FLDGjmNe0jR7KRgNF9Z34A/bmTRUXZ4wedXsy
         BWTNG6L10GoHhC9vEH4BtV7slhIBPiD54r6E4X/c5T2FLw6YvFqTLN6derFOmx4wvB/E
         o9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0IUu5cxIaYOqC1XS0AMKZ7KuvInfL/EoTMBPiEMolG0=;
        b=Rk8bFICy0gL1JVteCzxiVNg7LFBu7Nna617Tzcm3nQb9CS6KK7OhqJMy2CumD+umzw
         Zu4fn/X5YBvpeiQm9Hl1SEI4GBvT4AOjDIxs5H04CHod04W+LZUmGDsTaigydOc3vrr/
         kueVDu1/9rAnG1WAZlh5LKF1AAWksAb/vChAVUOpsM+XJDOnmSQ7ETB8ivp1JCoMKfiX
         KIqEQmatdWw0sI8+57mb/R1eDR9fYHbxfIIg4qw1QxnL164uQI9aPTQAacvyFa3M7vVF
         ZMBnMEI5gO96S3D+ljjGfgLVyCox+4SDdWWwkGCi9RqP67D56AGDIMYRVpoSmOcwYmHg
         LfnQ==
X-Gm-Message-State: AOAM53166/kYdqBGQV/INxaVf4mw3adiiRr7J6cWZ+NFljIMHVB8nCY8
        XFxEWhiViguckamZVZxF08I=
X-Google-Smtp-Source: ABdhPJxpod6CbKT2f7JC7GYdX64cEWqqrnSdp+YI3EWRxk5NJG8zfEZ0IfkIa/arf5RKCqbgh04DDw==
X-Received: by 2002:a05:600c:19d3:: with SMTP id u19mr8962355wmq.115.1626953288815;
        Thu, 22 Jul 2021 04:28:08 -0700 (PDT)
Received: from [10.20.1.172] ([185.138.176.94])
        by smtp.gmail.com with ESMTPSA id r2sm3319495wmh.34.2021.07.22.04.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 04:28:08 -0700 (PDT)
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nborisov@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
References: <20210721135926.602840-1-nborisov@suse.com>
 <CAHk-=whqJKKc9wUacLEkvTzXYfYOUDt=kHKX6Fa8Kb4kQftbbQ@mail.gmail.com>
 <b24b5a9d-69a0-43b9-2ceb-8e4ee3bf2f17@suse.com>
 <CAHk-=wgMyXh3gGuSzj_Dgw=Gn_XPxGSTPq6Pz7dEyx6JNuAh9g@mail.gmail.com>
 <CAHk-=wgr3JSoasv3Kyzc0u-L36oAr=hzY9oUrCxaszWaxgLW0A@mail.gmail.com>
From:   Nikolay Borisov <n.borisov.lkml@gmail.com>
Message-ID: <eef30b51-c69f-0e70-11a8-c35f90aeca67@gmail.com>
Date:   Thu, 22 Jul 2021 14:28:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgr3JSoasv3Kyzc0u-L36oAr=hzY9oUrCxaszWaxgLW0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 21.07.21 г. 22:26, Linus Torvalds wrote:
> On Wed, Jul 21, 2021 at 11:45 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I can do the mutual alignment too, but I'd actually prefer to do it as
>> a separate patch, for when there are numbers for that.
>>
>> And I wouldn't do it as a byte-by-byte case, because that's just stupid.
> 
> Here's that "try to align one of the pointers in order to avoid the
> lots-of-unaligned case" patch.
> 
> It's not quite as simple, and the generated assembly isn't quite as
> obvious. But it still generates code that looks good, it's just that
> the code to align the first pointer ends up being a bit harder to
> read.
> 

This one also works, tested only on x86-64. Looking at the perf diff:

    30.44%    -28.66%  [kernel.vmlinux]         [k] memcmp


Comparing your 2 version that you submitted the difference is:

     1.05%     +0.72%  [kernel.vmlinux]     [k] memcmp


So the pointer alignment one is slightly more expensive. However those
measurements were done only on x86-64.

Now on a more practical note, IIUC your 2nd version makes sense if the
cost of doing a one unaligned access in the loop body is offset by the
fact we are doing a native word-sized comparison, right?


<snip>
