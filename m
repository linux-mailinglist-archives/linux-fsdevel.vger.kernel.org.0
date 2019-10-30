Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86492EA4DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 21:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfJ3UfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 16:35:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43917 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfJ3UfO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 16:35:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1so3818577wra.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2019 13:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GKB6Sx/IUizZ9IZiRwVYRZ7sZESLZmd5Upv0GbKgvpI=;
        b=h6STLAlgZAIHahRpiOqt75+7YPhEervlfOHpzdNopczUpjoi/cznwsqOZegaIuJ4TM
         zdwrYQypkfpFaKGT8vusv604I2nbF1GOJZlwrB9ZKBgTEBjDOpLU6TSZRH/roP8sxwT+
         LZ6HXtPlhEH+GSsavlv45TTL5baI9xO8kN71I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GKB6Sx/IUizZ9IZiRwVYRZ7sZESLZmd5Upv0GbKgvpI=;
        b=bcS+LqpG/ZbZMCzKBJne/l/xhxxI4r3JFIqppcOXSMT3BAFMfSgmRknSS70oWoqxJj
         fUDGqTiCvdZeEndXLsk6y2ExgvIu9G1vUDYkGxhhvl5Zv4gl7IZnBsHu1jz2OTvuCo05
         QxXGBGA6GfdX337qPTE6X8B7wHWjX7V+akI7wS21uQvecFfcF6cWxFjmjz7aJlQOv6J/
         e1YfjnL0itouKw8FsQDAUkUzc3oT+LlO2GohPUIuNqJ5hCyiYWX1F8VAV6UKs3bwOzjL
         PvBKMu/hdsDb+z+fnbsaOUw3UblSKQALeXU8IQkbb5bHhlvZRqje8fE/09kBebmh8dhK
         Vs9Q==
X-Gm-Message-State: APjAAAWW7dhVma9T8Bx7fg48KY3P0WEvSJih3FkXvP/fTgBbUyVgA5ic
        FyhA368ZbrrD5cUBs8MTAYy+bvE8i82jW5FbNgI=
X-Google-Smtp-Source: APXvYqwZ8L7WBUXKpllPra1iDKCIj9jTGodgQKb31qnM478jp8ypjhyOfCzrMdjpE9K/VYB36AzGxg==
X-Received: by 2002:adf:d18b:: with SMTP id v11mr1782349wrc.308.1572467711910;
        Wed, 30 Oct 2019 13:35:11 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id a7sm1633681wrr.89.2019.10.30.13.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 13:35:10 -0700 (PDT)
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
To:     Ilya Dryomov <idryomov@gmail.com>,
        David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
 <CAOi1vP97DMX8zweOLfBDOFstrjC78=6RgxK3PPj_mehCOSeoaw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4892d186-8eb0-a282-e7e6-e79958431a54@rasmusvillemoes.dk>
Date:   Wed, 30 Oct 2019 21:35:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAOi1vP97DMX8zweOLfBDOFstrjC78=6RgxK3PPj_mehCOSeoaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30/10/2019 17.19, Ilya Dryomov wrote:
> On Thu, Oct 24, 2019 at 11:49 AM David Howells <dhowells@redhat.com> wrote:
>>  /*
>> - * We use a start+len construction, which provides full use of the
>> - * allocated memory.
>> - * -- Florian Coosmann (FGC)
>> - *
>> + * We use head and tail indices that aren't masked off, except at the point of
>> + * dereference, but rather they're allowed to wrap naturally.  This means there
>> + * isn't a dead spot in the buffer, provided the ring size < INT_MAX.
>> + * -- David Howells 2019-09-23.
> 
> Hi David,
> 
> Is "ring size < INT_MAX" constraint correct?

No. As long as one always uses a[idx % size] to access the array, the
only requirement is that size is representable in an unsigned int. Then
because one also wants to do the % using simple bitmasking, that further
restricts one to sizes that are a power of 2, so the end result is that
the max size is 2^31 (aka INT_MAX+1).

> I've never had to implement this free running indices scheme, but
> the way I've always visualized it is that the top bit of the index is
> used as a lap (as in a race) indicator, leaving 31 bits to work with
> (in case of unsigned ints).  Should that be
> 
>   ring size <= 2^31
> 
> or more precisely
> 
>   ring size is a power of two <= 2^31

Exactly. But it's kind of moot since the ring size would never be
allowed to grow anywhere near that.

Rasmus
