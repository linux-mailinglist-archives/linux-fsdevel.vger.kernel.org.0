Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956432DB752
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 01:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgLPAB2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 19:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgLOX0k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 18:26:40 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34373C0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 15:26:00 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id n10so8256646pgl.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 15:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0BtDjjQwgo5cssyB9phhEWsIn6Y0kXGy+MyO+eUcleY=;
        b=meT7eA9f+evHXhFdUTPKlNkFReh5bmpybzWBS/ORVZ4+UdvEo5qejXD5Rcu9aXES89
         lUZiZASZEZftfZLDtK7P7a2OAHXN6B7fw11eYRrj9O8FicoWdjZYcRz4lKO+Ah+jTEoH
         wgOLU9yxjL2rPtHz12Kikaa0n7/V8Z8VMeSs1eP425jqC5vwPcHrC4mzP5zgjJBwNs+K
         xTchos+YdrMKZqJFJUiJIjt0oCRd2dXS5kBpGKnspI6z6sY1i8fd43jVdqaSyyAXjLup
         XrYYC9ftgGq2RSWdKVoL+90fbSI2RYsJWht3RU5TAOzGse/XFPq8aV8XYHbI0Tc7TP6S
         D/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0BtDjjQwgo5cssyB9phhEWsIn6Y0kXGy+MyO+eUcleY=;
        b=L8Jn6cMnEqksZLVJm4Rq7CXyWGFZ8LUxHHx+37lKsYH+iYLlnIb5Jdz0EyiUZwbj5j
         uledi6Mzp8XUiaSpNaSufoTmd4VqNdb0XUWYg+fag9xrLJUa0EzQqM1yW1EDz+9LUfxO
         mHsL9I6Hcl68ZklV9X8eU88GjeNjz6drjpgg1cZNUxRt+2WKAMl/WfkI6pbtxK+ZZ92u
         UxSZm7H3/pbx4YCD5SNMLOX3+glWzvI8qwAAl3kzCvbYK+Hu3NjD2S3u/G28+SyTRZQ4
         A0dBve1YV82xJ1D676D0c9w3Gkm+4YDjqa4lzTRU1Nb309X7+mvSATWgN8lIgNKiCmFT
         l+4w==
X-Gm-Message-State: AOAM533SpA0akpgIxu/3lUeKHayKzw7KjYhSQ6T/K3zrwV+iqFfll+CF
        XnFcX4ASIkHoz6CwqSlUsKg1EQ==
X-Google-Smtp-Source: ABdhPJwS82e7t7h82A1CyyEkc/pGdyh/0u5/gxrHz21RbBG+KNHeMdMhpBfpJBmKKH1Ke5H0h8yTrQ==
X-Received: by 2002:a63:5748:: with SMTP id h8mr4215757pgm.24.1608074759624;
        Tue, 15 Dec 2020 15:25:59 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a31sm13226pgb.93.2020.12.15.15.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 15:25:59 -0800 (PST)
Subject: Re: [PATCH 3/4] fs: expose LOOKUP_NONBLOCK through openat2()
 RESOLVE_NONBLOCK
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20201214191323.173773-1-axboe@kernel.dk>
 <20201214191323.173773-4-axboe@kernel.dk>
 <20201215222522.GS3913616@dread.disaster.area>
 <CAHk-=whAhRQaFUn7dhDAgoofVRA2EJvbmiKAYFA0ciwPQjnGwg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <656157a9-0d1c-25a9-7fe4-88e1216fa364@kernel.dk>
Date:   Tue, 15 Dec 2020 16:25:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whAhRQaFUn7dhDAgoofVRA2EJvbmiKAYFA0ciwPQjnGwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/15/20 3:31 PM, Linus Torvalds wrote:
> On Tue, Dec 15, 2020 at 2:25 PM Dave Chinner <david@fromorbit.com> wrote:
>>
>> What text are you going to add to the man page to describe how this
>> flag behaves to developers?
> 
> I think it was you or Jens who suggested renaming it to RESOLVE_CACHED
> (and LOOKUP_CACHED), and I think that would be a good idea.

Yeah that was me, and I think it helps both internally in terms of the
code being easier/better to read, and when exposed as a user API as
well. It makes it readily apparent what it does, which is much better
than requring lengthy descriptions of it...

I'll go ahead and make the edit.

-- 
Jens Axboe

