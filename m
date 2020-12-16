Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49792DB9AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 04:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgLPDbk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 22:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPDbk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 22:31:40 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810EFC0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 19:31:00 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id m6so6005718pfm.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 19:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DqQdax5wUEqz+3JvGluM1Hb6N1LgdnHbZfF6kAuGG4I=;
        b=fDMkFfbrF6yDUTtOgg3KrAwXAZluWTXiWFB4YQYHMoAboecXdjqu13epemq0wCKi8o
         4kwtu45POKwMrcfeLieopaDrahuatILLQjWJCU25KwlFjWn9fj8zwNimch54suLFiKSS
         xxgDZ7eap5qh01aiQGZPv6hDn4tBJe4xUXsv4rY+Ku87K4R+fEPZ5tKahWJX5Yfh7sVD
         veVpXLE3fkb5IUxRI9Gq3ZLN4ydcTzQTuYpdv0mJsNRgQcPeDYVa876kDHQ3G8k40ss6
         yjN33YGIocFj6Ih9epz0C3b7mBMXgwYqcXSnxC/oSslVSnHe4KiNN2tilNUDv+p84YS4
         WGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DqQdax5wUEqz+3JvGluM1Hb6N1LgdnHbZfF6kAuGG4I=;
        b=bCWi/EFwfDC527V6+xoHJHzrl4cqrtt40s5aXrzKGfwpz9nbwm5c0m+tzDIj8DwoXp
         vevx3jpJYvrjWbI72QeqAnFOrb1NlCfMitk45ytVpKmTS38VBm7EJ51mQ2A2hzvp0+Wo
         GWJfWd0giq+39gNaGmEpE7ZbKItnA3q2VxmPK7hT45enqqhB2OTvzTwTgCYZBSnNaAsS
         cTtoF6dhjh8uYItnot7gn2t7uLWzBPeyKgcYd7NQrhRo4G4qa7slOAnzkUQABzn2F4gp
         QDTrUrGhLlA+rOMgcuRlHwFlmCEZJYnlK3UJ6zCDWL7k1uWGShH2uLycopqn5GP+j/5Y
         GUTQ==
X-Gm-Message-State: AOAM531QZZDBmJYKmlLiT819xn2sECu0fSmvl2+o4n6N6nGnDBK1C382
        yiLfaCisXemV3wM7w5ZFI+KxC15y0y5pmw==
X-Google-Smtp-Source: ABdhPJzHtbz7eVq4JAsywxuFmztJCYN0o4Q/IEriXaatddDQZVkj4ydeXKbZNUwWWWBs/DlLzBOezQ==
X-Received: by 2002:a63:7d47:: with SMTP id m7mr31007667pgn.405.1608089459824;
        Tue, 15 Dec 2020 19:30:59 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id z27sm446060pfq.70.2020.12.15.19.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 19:30:59 -0800 (PST)
Subject: Re: [PATCH 2/4] fs: add support for LOOKUP_NONBLOCK
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
References: <20201214191323.173773-1-axboe@kernel.dk>
 <20201214191323.173773-3-axboe@kernel.dk>
 <20201216023620.GH3579531@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a4ec6e24-2d01-0104-2604-18c88bd608a0@kernel.dk>
Date:   Tue, 15 Dec 2020 20:30:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201216023620.GH3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/15/20 7:36 PM, Al Viro wrote:
> On Mon, Dec 14, 2020 at 12:13:22PM -0700, Jens Axboe wrote:
>> io_uring always punts opens to async context, since there's no control
>> over whether the lookup blocks or not. Add LOOKUP_NONBLOCK to support
>> just doing the fast RCU based lookups, which we know will not block. If
>> we can do a cached path resolution of the filename, then we don't have
>> to always punt lookups for a worker.
>>
>> We explicitly disallow O_CREAT | O_TRUNC opens, as those will require
>> blocking, and O_TMPFILE as that requires filesystem interactions and
>> there's currently no way to pass down an attempt to do nonblocking
>> operations there. This basically boils down to whether or not we can
>> do the fast path of open or not. If we can't, then return -EAGAIN and
>> let the caller retry from an appropriate context that can handle
>> blocking.
>>
>> During path resolution, we always do LOOKUP_RCU first. If that fails and
>> we terminate LOOKUP_RCU, then fail a LOOKUP_NONBLOCK attempt as well.
> 
> Ho-hum...  FWIW, I'm tempted to do the same change of calling
> conventions for unlazy_child() (try_to_unlazy_child(), true on
> success).  OTOH, the call site is right next to removal of
> unlikely(status == -ECHILD) suggested a few days ago...
> 
> Mind if I take your first commit + that removal of unlikely + change
> of calling conventions for unlazy_child() into #work.namei (based at
> 5.10), so that the rest of your series got rebased on top of that?

Of course, go ahead.

>> @@ -3299,7 +3315,16 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
>>  {
>>  	struct dentry *child;
>>  	struct path path;
>> -	int error = path_lookupat(nd, flags | LOOKUP_DIRECTORY, &path);
>> +	int error;
>> +
>> +	/*
>> +	 * We can't guarantee that the fs doesn't block further down, so
>> +	 * just disallow nonblock attempts at O_TMPFILE for now.
>> +	 */
>> +	if (flags & LOOKUP_NONBLOCK)
>> +		return -EAGAIN;
> 
> Not sure I like it here, TBH...

This ties in with the later email, so you'd prefer to gate this upfront
instead of putting it in here? I'm fine with that.

-- 
Jens Axboe

