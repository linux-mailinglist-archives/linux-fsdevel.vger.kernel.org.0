Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4CC3A77C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 09:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhFOHQr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 03:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhFOHQp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:16:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3516CC0617AF
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 00:14:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k25so20807223eja.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 00:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=euuI3sy0vUASeXoR3VF/cB0ofsJ2xtWE3m2SATxLwmE=;
        b=AomJNf88QS9O+s+qQw3D2dxQMVlYRACJ3W6XV/Qfc9QG0D0RMI5MlxK9IjvvJIfClI
         5zXWKP6nSPEoagEG9oFTv/mhIC7PoaOzqpANzJ5ugqNtCLdKU6Jlc9TgwIf0qa3UIqnp
         YEc2nN5Za8ELHgcu0qqnD0SgUiv8OTTTmTsiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=euuI3sy0vUASeXoR3VF/cB0ofsJ2xtWE3m2SATxLwmE=;
        b=P3/tefJDvCMuJDMo4VqUpPIS253eFxNBjqJq+pZFPfrgjzXniP2CKWvMglaD1P3ta4
         HXAdWV7F59O9XCnRCNAIAoQet8xZumoY6z0fFxHvD3iCHJ7LrqJL4jvYj3pZfGI9G9Ti
         2NsPCQCjtfrAkww1spgI1cJgiSuYmQU4vyh7011cqHgkn1n93YupCLn0CgPQNPfa/cYj
         n6G6kGx0UvPaNmUkRl68XzM9rSPU1rtG7QZObdq0BD6m9A5OzFarfUVyqFF2IE3IdwIw
         lOEgEDP08Jzc1MT3/5bWDicF+arZqwBRuD8FLgymydomOZ5Nxde+PJ6cBci25k5sHTSB
         agHQ==
X-Gm-Message-State: AOAM533v3aY8VnNkAIF6FU7wHBUDrrUZRBIunFSIvtVNvJSTamn4PHKa
        usKKflXoy5Rr09yZB7l8pCBYwMUm+KV0XOTD
X-Google-Smtp-Source: ABdhPJzjxFXKFZC7HNcQTYqrBtjgNTWh3xNtZtvIBwbS9EkxpwWTAToHGPC1F1FjdetgeI8BTV58aQ==
X-Received: by 2002:a17:906:25db:: with SMTP id n27mr18868513ejb.170.1623741278609;
        Tue, 15 Jun 2021 00:14:38 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id br21sm9160791ejb.124.2021.06.15.00.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 00:14:38 -0700 (PDT)
Subject: Re: [PATCH RFCv3 2/3] lib/vsprintf.c: make %pD print full path for
 file
To:     Justin He <Justin.He@arm.com>, Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20210611155953.3010-1-justin.he@arm.com>
 <20210611155953.3010-3-justin.he@arm.com> <YMd4ixry8ztzlG/e@alley>
 <AM6PR08MB4376D26EFD5886B7CF21EFCFF7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <113d9380-8493-1bde-9c76-992f4ce675d9@rasmusvillemoes.dk>
Date:   Tue, 15 Jun 2021 09:14:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <AM6PR08MB4376D26EFD5886B7CF21EFCFF7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15/06/2021 08.48, Justin He wrote:
> Hi Petr
> 

>>> +   /* no filling space at all */
>>> +   if (buf >= end || !buf)
>>> +           return buf + reserved_size;
>>> +
>>> +   /* small space for long name */
>>> +   if (buf < end && prepend_len < 0)
>>> +           return string_truncate(buf, end, p, dpath_len, spec);
>>
>> We need this only because we allowed to write the path behind
>> spec.field_width. Do I get it right?
> 
> Both of field_width and precision:
> "%.14pD" or "%8.14pD"

Precision is never gonna be used with %p (or any of its kernel
extensions) because gcc would tell you

foo.c:5:13: warning: precision used with ‘%p’ gnu_printf format [-Wformat=]
    5 |  printf("%.5p\n", foo);

and there's no way -Wformat is going to be turned off to allow that usage.

IOW, there's no need to add complexity to make "%.3pD" of something that
would normally print "/foo/bar" merely print "/fo", similar to what a
precision with %s would mean.

As for field width, I don't know if it's worth honouring, but IIRC the
original %pd and %pD did that (that's where we have widen_string etc. from).

Other %p extensions put the field with to some other use (e.g. the
bitmap and hex string printing), so they obviously cannot simultaneously
use it in the traditional sense.

Rasmus
