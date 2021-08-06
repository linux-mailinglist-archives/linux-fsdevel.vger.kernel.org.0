Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B563E2ED3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 19:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhHFRSs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 13:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhHFRSs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 13:18:48 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A76DC061798
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Aug 2021 10:18:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b1-20020a17090a8001b029017700de3903so12848698pjn.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Aug 2021 10:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oVXTKnqxAtSSQ4IhMfAUss53lifoLdXxsRc2hm5fWQk=;
        b=CKiEOTFMQ/3Qhx3l95vADApRAr8YPPIFXI/RiO+DD/FyUWwQfMxAnGTngzfs52GjZ6
         5r1dJW2Us6NBnCA83uqa155Jw5+amCYHYpJ9G8Bdo02LqmseJ57BuKTPTmMsTyE5VfVq
         eHzdXhw1BtFQx7jHy9kLKOYgkuP0ssSOLDQUmqL9ucWxONXNM0uJAESLQpurrF9X7MXz
         WVKRPTXdI1l8vWAkjFzwjtJpG9rxxPgFt0Zv9AGQlExsDrXCyb39QJBrM7savbMvHNQY
         2k64LWPeFgCpd/KyNaDMU2bB6Mt0hHJADcNttsxIp9A4GrK7Otefc/RYyRdAY+sZu29e
         MTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oVXTKnqxAtSSQ4IhMfAUss53lifoLdXxsRc2hm5fWQk=;
        b=MGwYZzBxywlYzdNnMD1m04dmslZCHqaa8JwyF9o7qU3a7V0gveX5Nt9FSmjgmdVlgA
         ciyOmKOdGSBh4AKOILxAvFBX408t5iitlM4e+zKiILUnSkDul24HdS2c0sNKZAXvMK95
         jkOC/A6ivYDWvwsRqBYbce+WM2ze1pXafi4hSmoCqwJGIHdNffNXe2qEYsMijCaPs8mb
         fxsk77q5UMvx3A+NYlA8kWp+6UOJDvhv5d+kBhZW82/w07BmN/THjEziLsYdvNOHfHMa
         vj3I4/n9euqtP0Kry1+oW4Fp06VHCaIhqk9/wYN4PmB5DkGgYJWsatrrLSa0GzHFG0op
         HYLA==
X-Gm-Message-State: AOAM5319Hse/6onhLkDwJtfzeBDtZyySWaAf3nzxVoL7wCpgsUkKaO5K
        pC4nhZg1VOckH9+n7cDxawYrXA==
X-Google-Smtp-Source: ABdhPJyyGRHkebbNz2ZNHI6Ms1cY/vawO4y2E+ItlvpXXieImUC6qMAsM6Mwe/KnqfDpFpOCbJ2T+w==
X-Received: by 2002:a17:90a:5889:: with SMTP id j9mr21720768pji.117.1628270311027;
        Fri, 06 Aug 2021 10:18:31 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id c24sm13239677pgj.11.2021.08.06.10.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 10:18:30 -0700 (PDT)
Subject: Re: [RFC] mm: optimise generic_file_read_iter
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <07bd408d6cad95166b776911823b40044160b434.1628248975.git.asml.silence@gmail.com>
 <YQ09tqMda2ke2qHy@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cd31510a-2065-6078-468d-bbff816f818d@kernel.dk>
Date:   Fri, 6 Aug 2021 11:18:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YQ09tqMda2ke2qHy@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/6/21 7:48 AM, Al Viro wrote:
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

Ran a quick test here, doing polled IO (~3.3M IOPS) and we reduce the
overhead of generic_file_read_iter() from 1.5% of the runtime to 1.2%.
Noticeable. Will improve once we stop digging into the inode on the
io_uring side.

Anyway, just one data point, perhaps Pavel has some too.


-- 
Jens Axboe

