Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402DD28DCE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 11:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgJNJVE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 05:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387781AbgJNJUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:44 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D34C0613AE
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2020 14:49:38 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id c22so1957455ejx.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2020 14:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EzSWvplMqO4cdN++0Ux5XsKlBbV7BOhF67AtXcUOeMs=;
        b=GO89q5/UKsCuaRfA42EpuS4jIEk4259OJUr1KkM2uwbGGwvTjVKxPHUcolF8kks7Mo
         +mkXL7oq058MeNpC93YGjZUHhm/CIWona3mza47SaubqG9vncZ7ku8lG6JauvRTbIX6P
         OI+ObqhVYJlbnv5zPa9PqfvmwErfKwr0+UzoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EzSWvplMqO4cdN++0Ux5XsKlBbV7BOhF67AtXcUOeMs=;
        b=En4cHftljCTq80CTGBz5mJMu9JqsLZo3X7BS/sNj+eJoLluh3X3WX438kWIE3SsCo+
         /szArmAKoDb+M0vwP9BXcCnHtaCZ147q2eI/YfO7BxUspDnW03csdWqce/AZIGi8F1rZ
         FobySTvFWF43O27khsm/10LHZ9n7EbBjnuw0CJ5ecO3mRSCnQI5kVS5pYUd7ubfIjgpH
         w4peJKlUQwhtk1WTeBk0PSyI1C/q7mZCxJZaPb8xPIGByH5NCNRmaVSCepw+F0fk9H3G
         FgKgYtfM3qBw8wZ4ACor+mNSV39oSnnami9GVzBdyd++16hO/Uk31DkBRBw7uLK4pYwq
         qcJQ==
X-Gm-Message-State: AOAM533NS0WSblbOOgT3BDiOwNnL1/f9xmu2+yQnZ/NVbDdsLFs5FrO1
        b70XEjuSGlqC4EDGyexfCWqflQ==
X-Google-Smtp-Source: ABdhPJwABvCvhJd+JSDbSPUX836u6gpnht+hLXQCQn+gFf/NH+wdWUzERRS4w7diiDWA4EN5G3lHTA==
X-Received: by 2002:a17:906:3852:: with SMTP id w18mr1824808ejc.551.1602625777024;
        Tue, 13 Oct 2020 14:49:37 -0700 (PDT)
Received: from [192.168.1.149] (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id a12sm454869edy.87.2020.10.13.14.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 14:49:36 -0700 (PDT)
Subject: Re: [PATCH 1/2] fs, close_range: add flag CLOSE_RANGE_CLOEXEC
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        christian.brauner@ubuntu.com, containers@lists.linux-foundation.org
References: <20201013140609.2269319-1-gscrivan@redhat.com>
 <20201013140609.2269319-2-gscrivan@redhat.com>
 <20201013210925.GJ3576660@ZenIV.linux.org.uk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <70fa4f70-38cc-7e18-8156-65a3e50c641e@rasmusvillemoes.dk>
Date:   Tue, 13 Oct 2020 23:49:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201013210925.GJ3576660@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/10/2020 23.09, Al Viro wrote:
> On Tue, Oct 13, 2020 at 04:06:08PM +0200, Giuseppe Scrivano wrote:
>> +		spin_lock(&cur_fds->file_lock);
>> +		fdt = files_fdtable(cur_fds);
>> +		cur_max = fdt->max_fds - 1;
>> +		max_fd = min(max_fd, cur_max);
>> +		while (fd <= max_fd)
>> +			__set_close_on_exec(fd++, fdt);
>> +		spin_unlock(&cur_fds->file_lock);
> 
> 	First of all, this is an atrocious way to set all bits
> in a range.  What's more, you don't want to set it for *all*
> bits - only for the ones present in open bitmap.  It's probably
> harmless at the moment, but let's not create interesting surprises
> for the future.

Eh, why not? They can already be set for unallocated slots:

commit 5297908270549b734c7c2556745e2385b6d4941d
Author: Mateusz Guzik <mguzik@redhat.com>
Date:   Tue Oct 3 12:58:14 2017 +0200

    vfs: stop clearing close on exec when closing a fd

    Codepaths allocating a fd always make sure the bit is set/unset
    depending on flags, thus clearing on close is redundant.

And while we're on that subject, yours truly suggested exactly that two
years prior [1], with a follow-up [2] in 2018 to do what wasn't done in
5297908, but (still) seems like obvious micro-optimizations, given that
the close_on_exec bitmap is not maintained as a subset of the open
bitmap. Mind taking a look at [2]?

[1]
https://lore.kernel.org/lkml/1446543679-28849-1-git-send-email-linux@rasmusvillemoes.dk/t/#u
[2]
https://lore.kernel.org/lkml/20181024160159.25884-1-linux@rasmusvillemoes.dk/

Rasmus
