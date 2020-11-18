Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0682B8630
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 22:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgKRVAK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 16:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgKRVAK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:00:10 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD660C0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 13:00:08 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id d17so3586378ion.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 13:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6EcyjAEeydl3nddZL8iYQE7pw949Ma6ixF/yRhksIqc=;
        b=Dch7U7OYntC3KtUQrY0zSn9cc9dCOaQ+bRl0OG0L5nC9/H0WfR+ru8erroQRpO9w9x
         ADhv3GNw5HKIbkPHL0swANO/6lGhPd0FZSAoxfAkk0UQNpbKFAf+KPSWx5Ndibq1ynHo
         X3WVZqa+3cOsxppr64b6JTFJR2CEMstFsKljLSDNuo1H2SeVRAqUzNRipcyNanihQvHr
         wwcf8a9pr/lKz/HoPvMlhRxkUM2KjcGiCvaKDz5Aiy15QCfODGcatLlZx7tFQkHmksAu
         gVL0cY37IV8+eZwDW7HTdt0/lKF2anoH7oYc1U2RmfiVYx07eprjXGK2Ai83ahDZHQt0
         vlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6EcyjAEeydl3nddZL8iYQE7pw949Ma6ixF/yRhksIqc=;
        b=KeEpNWXThsd7B5RxCbyng0leDtK5D5vJKjRh8+5OYsALm7B6g94b8Qdtz1iWnqIrBe
         0RCyvA39m9sJz+IwEsOZrjji+V1hJXxlRmTHVuHL37KK3Y3nGZnfyoCCLqHZANzc7eoz
         TidD22fTVvh5FkFbndVIH+Tc6qNQ8P1lbIpxqhtFJd0Zzduw2ZRZKZpLrjxQs5/ixHxX
         V9lNRcYqZNQEI9XrfWxVIlsVl/DbFhnNSj+u/gggTpqqYtOEo7waUPNkOOjIzfqS5x6U
         irxokxvRFdVN9dCnLh2TEMiDg0uYoPzSKYwp0jHejZS1mQ/QltJ6djqq0D5DLKYS3sNz
         +yoA==
X-Gm-Message-State: AOAM531K2a54au4mHnFvx/GtBNA0cpHFV0HYl/7O+VEDTHTWB8eCM7K2
        5kErqQu/bA7vJre8aPxIXlYqhTGYu0ePag==
X-Google-Smtp-Source: ABdhPJwsy5oJ9Z1hdZkKviObdRRDgjoG2XcStR9A3Q2RH9Q3biDZJsuOktgwa1VhBp9U2pbTAA9PEA==
X-Received: by 2002:a6b:5919:: with SMTP id n25mr2191151iob.204.1605733207775;
        Wed, 18 Nov 2020 13:00:07 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d23sm17028208ill.56.2020.11.18.13.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 13:00:07 -0800 (PST)
Subject: Re: [PATCH RFC] iomap: only return IO error if no data has been
 transferred
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <2a56ae95-b64e-f20f-8875-62a2f2e8e00f@kernel.dk>
 <20201118071941.GN7391@dread.disaster.area>
 <9ef0f890-f115-41f3-15fc-28f21810379f@kernel.dk>
 <20201118203723.GP7391@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <95d51836-9dc0-24c3-9aad-678d68613907@kernel.dk>
Date:   Wed, 18 Nov 2020 14:00:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201118203723.GP7391@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/18/20 1:37 PM, Dave Chinner wrote:
> On Wed, Nov 18, 2020 at 08:26:50AM -0700, Jens Axboe wrote:
>> On 11/18/20 12:19 AM, Dave Chinner wrote:
>>> On Tue, Nov 17, 2020 at 03:17:18PM -0700, Jens Axboe wrote:
>>>> If we've successfully transferred some data in __iomap_dio_rw(),
>>>> don't mark an error for a latter segment in the dio.
>>>>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>
>>>> ---
>>>>
>>>> Debugging an issue with io_uring, which uses IOCB_NOWAIT for the
>>>> IO. If we do parts of an IO, then once that completes, we still
>>>> return -EAGAIN if we ran into a problem later on. That seems wrong,
>>>> normal convention would be to return the short IO instead. For the
>>>> -EAGAIN case, io_uring will retry later parts without IOCB_NOWAIT
>>>> and complete it successfully.
>>>
>>> So you are getting a write IO that is split across an allocated
>>> extent and a hole, and the second mapping is returning EAGAIN
>>> because allocation would be required? This sort of split extent IO
>>> is fairly common, so I'm not sure that splitting them into two
>>> separate IOs may not be the best approach.
>>
>> The case I seem to be hitting is this one:
>>
>> if (iocb->ki_flags & IOCB_NOWAIT) {
>> 	if (filemap_range_has_page(mapping, pos, end)) {
>>                   ret = -EAGAIN;
>>                   goto out_free_dio;
>> 	}
>> 	flags |= IOMAP_NOWAIT;
>> }
>>
>> in __iomap_dio_rw(), which isn't something we can detect upfront like IO
>> over a multiple extents...
> 
> This specific situation cannot result in the partial IO behaviour
> you described.  It is an -upfront check- that is done before any IO
> is mapped or issued so results in the entire IO being skipped and we
> don't get anywhere near the code you changed.
> 
> IOWs, this doesn't explain why you saw a partial IO, or why changing
> partial IO return values avoids -EAGAIN from a range we apparently
> just did a partial IO over and -didn't have page cache pages-
> sitting over it.

You are right, I double checked and recreated my debugging. What's
triggering is that we're hitting this in xfs_direct_write_iomap_begin()
after we've already done some IO:

allocate_blocks:
	error = -EAGAIN;
	if (flags & IOMAP_NOWAIT)
		goto out_unlock;

> Can you provide an actual event trace of the IOs in question that
> are failing in your tests (e.g. from something like `trace-cmd
> record -e xfs_file\* -e xfs_i\* -e xfs_\*write -e iomap\*` over the
> sequential that reproduces the issue) so that there's no ambiguity
> over how this problem is occurring in your systems?

Let me know if you still want this!

-- 
Jens Axboe

