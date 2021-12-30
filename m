Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FD24820B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Dec 2021 23:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbhL3Wqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Dec 2021 17:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbhL3Wqv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Dec 2021 17:46:51 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2EEC06173E
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Dec 2021 14:46:51 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id s1so20951680pga.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Dec 2021 14:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vlkci45AQt8E1ie1DvNnXAC14qHOEoLKoX3LYBcwB44=;
        b=7LnkoXRQNpmy8nec0VpjUYeHuiqrATXHqMcbEQL6nVAs2ub1GoZAGlA2NZq4ml72Fx
         mDkfAi/IB4cILKb0Z0VW2J80t6EicqWlmrodrIp7fFGGoQScxsWlbtkyhB1fga6D/vN3
         3TWg2EYDYQ09ZeXsoZuQYSih700q4ypsPiJ+wKU/V+iCh+rtasjoA273HHfio1BotoGQ
         D3C22Wq1f+mJMRkjLj4F7AAu0HULmLQyrudra6rlz37r3xKM/+nTtusrogx2KRS+A9i+
         gYbIAbCzTnVvou9W+ywhAjwjPlcc21QpA3sDA8APmCEQ+xA4nZpslwSDZvCWF/iZdNvV
         sfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vlkci45AQt8E1ie1DvNnXAC14qHOEoLKoX3LYBcwB44=;
        b=VlglJygdXlfu1Fig3V3AxJAWblyBeDog+ksQRD8ZGCehCsv0GeBLnBj1pkQ8zXjJbW
         h6JIwsmTGBVACoPw9MSIDclyPfcF7pvSaNrf3MjOE4QSebnZbKDYX0dDbvZlzlVRMYvV
         Xo1R8p7gmfuoStapylLJN5juvoifxZq9E5okt3UAfL49q+fmrqwUhI3De0jwEIQoEW+1
         YFE1ZQQgiXNb0wd38Urzh1csGj/fXs77fqU9DJA/BAfVPvvxReu8NPnzmIRiySsOW2LD
         Pu4G0PPVuvMSpsw8lqhpQRNSDuEGwwxzLBt8aBPOLMTXHaDz0aPPqQzWOFL8jYT55+rF
         k2ZQ==
X-Gm-Message-State: AOAM531rp6aaqQL2n1ESMis0uffu53dh0DcSIUYpNHXrcWNsLHaXQoEz
        /J4bwi0afNsyzoBVPKd5WW7sHA==
X-Google-Smtp-Source: ABdhPJzKRK4NIWDqZRQqjkRZYIJ3yneeJXR0xNPDcIY3pjBDdF1Z44qUnFfMofud1fkcM86FGVDDqg==
X-Received: by 2002:a63:dd0f:: with SMTP id t15mr29211759pgg.134.1640904410757;
        Thu, 30 Dec 2021 14:46:50 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id y11sm26873813pfn.7.2021.12.30.14.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 14:46:50 -0800 (PST)
Subject: Re: [PATCH v10 4/5] io_uring: add fsetxattr and setxattr support
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Stefan Roesch <shr@fb.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@fb.com,
        torvalds@linux-foundation.org
References: <20211229203002.4110839-1-shr@fb.com>
 <20211229203002.4110839-5-shr@fb.com>
 <Yc0Ws8LevbWc+N1q@zeniv-ca.linux.org.uk>
 <Yc0hwttkEu4wSPGa@zeniv-ca.linux.org.uk>
 <20211230101242.j6jzxc4ahmx2plqx@wittgenstein>
 <Yc3bYj33YPwpAg8q@zeniv-ca.linux.org.uk>
 <20211230180114.vuum3zorhafd2zta@wittgenstein>
 <5030f5fa-79c3-b3b7-857d-3ac62bf2b982@kernel.dk>
 <Yc4xiLus+Os4GWZf@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <961974f9-5eb4-1289-2724-0e6c3faf0434@kernel.dk>
Date:   Thu, 30 Dec 2021 14:46:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Yc4xiLus+Os4GWZf@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/30/21 2:24 PM, Al Viro wrote:
> On Thu, Dec 30, 2021 at 11:09:12AM -0800, Jens Axboe wrote:
> 
>> For each command, there are two steps:
>>
>> - The prep of it, this happens inline from the system call where the
>>   request, or requests, are submitted. The prep phase should ensure that
>>   argument structs are stable. Hence a caller can prep a request and
>>   have memory on stack, as long as it submits before it becomes invalid.
>>   An example of that are iovecs for readv/writev. The caller does not
>>   need to have them stable for the duration of the request, just across
>>   submit. That's the io_${cmd}_prep() helpers.
>>
>> - The execution of it. May be separate from prep and from an async
>>   worker. Where the lower layers don't support a nonblocking attempt,
>>   they are always done async. The statx stuff is an example of that.
>>
>> Hence prep needs to copy from userland on the prep side always for the
>> statx family, as execution will happen out-of-line from the submission.
>>
>> Does that explain it?
> 
> The actual call chain leading to filename_lookup() is, AFAICS, this:
> 	io_statx()
> 		do_statx()
> 			vfs_statx()
> 				user_path_at()
> 					user_path_at_empty()
> 						filename_lookup()
> 
> If you are providing such warranties for the contents of pathname
> arguments, you have a bug in statx in the mainline.  If you are not,
> there's no point in doing getname() in getxattr prep.

Not for the filename lookup, as I said it's for data passed in. There
are no guarantees on filename lookup, that happens when it gets
executed. See mentioned example on iovec and readv/writev.

-- 
Jens Axboe

