Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF82E3EC470
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 20:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbhHNS0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Aug 2021 14:26:08 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:33399 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbhHNS0H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Aug 2021 14:26:07 -0400
Received: by mail-pl1-f169.google.com with SMTP id a20so16108166plm.0;
        Sat, 14 Aug 2021 11:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V/UunbGPn7b9qeiuqDc7nUnLkftRm49BxQKgOeX29LI=;
        b=akaPopfFBXG5HUqZx5qGZGVNDoy0XKHbE/pvqZsrypYInpAp0MWYWeewxPwRRtu6d7
         6zTTtjjnSCtR8Nd0c2aJ6C2SHADLVVdNwaQQS+FUlYwXgi4b3jt69Eed++tRnsUbekVf
         3n6Ge8YU3bg2NeAevjnPzdhQpzQ7EwhAyaQhmyHonXC8YF9ycHY+/ZRq3tBfdBhE2FBc
         BbbLTu20jXHJwIqY6IZbjNyZgmB20tPRl3Dn6sbSItit5no3J+PcRqcqcPVj2elFjz5F
         92gLNbrrj+79l5DjU2lDTXadbhCqINXBrAtprXsa82e9ErSVKlSXYRW+O85vWrvpQP3E
         6ghA==
X-Gm-Message-State: AOAM5324/ocYh/T1vNfn1Hdfey4+hczur5gavfZ6Xl3OA1NKAG9kwTzy
        +oJpl7Zagd8AxCnG80AJYAd9q4MpiSA=
X-Google-Smtp-Source: ABdhPJwqQsnbZrocVZuoL85A8ndRmQw0cVFw2+cnn8XXH0bJv9BAiXryV4q8SchXa9agAStxa7MrKQ==
X-Received: by 2002:a17:902:c386:b029:12d:4eda:9e42 with SMTP id g6-20020a170902c386b029012d4eda9e42mr6572776plg.57.1628965538283;
        Sat, 14 Aug 2021 11:25:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:ec45:c824:1851:d6df? ([2601:647:4000:d7:ec45:c824:1851:d6df])
        by smtp.gmail.com with ESMTPSA id u17sm6330929pfh.184.2021.08.14.11.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 11:25:37 -0700 (PDT)
Subject: Re: [GIT PULL] configfs fix for Linux 5.14
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bodo Stroesser <bostroesser@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Becker <jlbec@evilplan.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <YRdp2yz+4Oo2/zHy@infradead.org>
 <CAHk-=whh8F-9Q=h=V=bKczqfRPbUN_A3h21aVfkk2HNhCWF+Pw@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <eca7f963-7ee1-d062-8020-a2a32a69a9e6@acm.org>
Date:   Sat, 14 Aug 2021 11:25:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whh8F-9Q=h=V=bKczqfRPbUN_A3h21aVfkk2HNhCWF+Pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/14/21 9:27 AM, Linus Torvalds wrote:
> On Fri, Aug 13, 2021 at 9:00 PM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> configfs fix for Linux 5.14
>>
>>  - fix to revert to the historic write behavior (Bart Van Assche)
> 
> It would have been lovely to see what the problem was, but the commit
> doesn't actually explain that.
> 
> I suspect it's this
> 
>     https://lkml.org/lkml/2021/7/26/581
> 
> but there might have been more.

Hi Linus,

Bodo explained to me via a private email that the historic behavior is
the behavior he needs for a patch that he is still working on. I'm not
aware of any existing user space software that relies on the historic
(non-POSIX) behavior of configfs writes.

Bart.
