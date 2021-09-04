Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC17D4008E0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Sep 2021 03:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350788AbhIDA6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 20:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350650AbhIDA6f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 20:58:35 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8E9C061757
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Sep 2021 17:57:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id s29so799343pfw.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Sep 2021 17:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xz8nnMXJDbBJ194DuFd2giPN2/XCiMv/EpcFRaBE6MY=;
        b=E1TWI6Ez3mIdBOoL2FupyZ48lierRN65SgA5BnsjL+J1/Fk0hqr7Cooy/423gpEEx4
         wJ9hhxRfBm5TTDdegOPMDKBlcmU2UA7U85KarR38qj8SXMGSZGfAk/RrOwwwd6nW/mkd
         M/k2tDotI/DtUQS+byWW1drSD5ELfWG1CuXoQONM0hEtVsZ0MbWXgCT/0Q3ehGBK/NDy
         XHSzqjUz4PyjSnwpiP7JCC5H3PtYRZjouVN16PB2uRHF0LwIxp0O++1jvZA97uouBYFF
         iv/LCi8oOo/4OyAAyGCCy3gWsSB5ydaRJq63kd1KDp6A+WkxoF2GSTnsJ5wmU+iqJiv0
         i3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xz8nnMXJDbBJ194DuFd2giPN2/XCiMv/EpcFRaBE6MY=;
        b=NoHi3Tj1zrKMBhJ++sGpbWRbzp8rWyyfd+9a/T11SMTmnFah4EBW+FWELMFC86uGGN
         HXun9f/O4heR2ZWs9gRHFOvMyJzmLzThsr7Yg1yxqlP2GdWjmcc9h0OyVNi0NDzj+DeR
         8Jf+cGqsLtAatVbvZNkuIc4Pno8vGrwAMia77MZFri6QMlKHXLgW1MYPl9yrHeSctv8i
         490m5m45Y1/pBJtWYkwvtZGVSJ3E9w1WTFlznuwvLLP16TjAsKbsZfkKwqZ5R7PMJCRL
         rq/Z889tIhpppqht8ycjHc86DZ54jGhgZav9v9EsXsNUd6XgSXlUSkY7elErJ2WKwjcr
         B8fg==
X-Gm-Message-State: AOAM531JcPhdqq7VJNgekggZgSI6QI0YCgW734BgS2XVzgrOyt/nFVZn
        Hgm4pie1vaVSNUALfxaVXJkVcBD5T2JmXw==
X-Google-Smtp-Source: ABdhPJxIsJlvuvYIM8B6AsXvLN1fN3cBDhbb0TBx4LLOltAWG1KofE7Ic2zbjANygN590SztlOa0pQ==
X-Received: by 2002:a05:6a00:1c65:b0:412:f893:fc6d with SMTP id s37-20020a056a001c6500b00412f893fc6dmr1288038pfw.8.1630717054524;
        Fri, 03 Sep 2021 17:57:34 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id p10sm527113pge.38.2021.09.03.17.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 17:57:33 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] iter revert problems
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Palash Oswal <oswalpalash@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org,
        syzbot+9671693590ef5aad8953@syzkaller.appspotmail.com
References: <cover.1629713020.git.asml.silence@gmail.com>
 <65d27d2d-30f1-ccca-1755-fcf2add63c44@kernel.dk>
 <YTKZwuUtJJDQb8F+@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <72e3c837-8e44-8bc3-36c2-4a8682892a62@kernel.dk>
Date:   Fri, 3 Sep 2021 18:57:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YTKZwuUtJJDQb8F+@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/3/21 3:55 PM, Al Viro wrote:
> On Fri, Sep 03, 2021 at 02:55:26PM -0600, Jens Axboe wrote:
>> On 8/23/21 4:18 AM, Pavel Begunkov wrote:
>>> iov_iter_revert() doesn't go well with iov_iter_truncate() in all
>>> cases, see 2/2 for the bug description. As mentioned there the current
>>> problems is because of generic_write_checks(), but there was also a
>>> similar case fixed in 5.12, which should have been triggerable by normal
>>> write(2)/read(2) and others.
>>>
>>> It may be better to enforce reexpands as a long term solution, but for
>>> now this patchset is quickier and easier to backport.
>>>
>>> v2: don't fail if it was justly fully reverted
>>> v3: use truncated size + reexapand based approach
>>
>> Al, let's get this upstream. How do you want to handle it? I can take
>> it through the io_uring tree, or it can go through your tree. I really
>> don't care which route it takes, but we should get this upstream as
>> it solves a real problem.
> 
> Grabbed, will test and send a pull request...

Thanks Al! We should mark these for stable as well.

-- 
Jens Axboe

