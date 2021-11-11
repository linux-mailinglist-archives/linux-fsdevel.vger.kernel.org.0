Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5A544CE51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 01:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhKKA3a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 19:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbhKKA33 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 19:29:29 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D05AC061205
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 16:26:37 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id 14so4912094ioe.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 16:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NyY8bek2WvSGjibqw1QUPQDNaQc/2Apt9v2sF1q2Sv4=;
        b=jl8dCUt7BkCW8ACewdF5osqNI3RRnyRBlDQP+bydLnpGYyQGl6gpUQLfxoxQoh5i6V
         MZBsAXng179VNrfxCM39UGTAJvAJ4/yuK9LxptVUGrVjXh3EuNxWp9CPHDp5/qxXAbUK
         AudU9T1bq4PRSE2Xwcu3+vNRsTRrmfqH8pR7ojn4yKH28l7o9Ysq8/kenSprv+E4r+tD
         hQUx6HWhvEGAk2z+k4uH1bSjsGBesfOspT7wG/rmpTeAvbpPyEVeGUSveLIw56fx3Ifo
         saZYwZiQsc5w+jWXEoA7zR3Kg8fblBc4BMesHGNlJs+5LBQVWbMdqOH4gO1jHXW8FIoB
         t+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NyY8bek2WvSGjibqw1QUPQDNaQc/2Apt9v2sF1q2Sv4=;
        b=ggSFOCH7xWs2RH/gn4i/O5U/piwh5UD59jyJb/kRBpOavSY0oXAm5LVJgErt36XwRi
         FAVPfeUiD+7Jx1Nc0TkrRh8TEQfHo/uHI3oLyTt1ShJXLTr3jGAnkAw/H0nEteF2delt
         6AhkR3RA97fYwUrN2bzR7hOmFkIPf42GdtCTQgl5K4O6SGExDsuPMFMbGBOgDsxvjaF1
         b2TTCwGgUsoTfxiYlKXhNZBIAsURGk9q1pBZDvuojbNgbnkPOUq7k/k4ciXE1eGbESWl
         y9/FBL214fNzmS7TOsm7GFDs0JnqSLf+YoImbeHM2GcV3KwDkirkcGN6GTQ7V6r4/eDs
         Xtsw==
X-Gm-Message-State: AOAM530PZDiWIcnYI4yNwGyNik7WMXGb72z6N2ieWp7jBgfpjCHAWVyU
        4/Pi4Ks92nCMHo5GCthiUSw+o+lA13mDkr8d
X-Google-Smtp-Source: ABdhPJxopWi9rf1i9qBVVWTcqIkAhArpHV5fNVB3eoBbngZouc4tphuIfKJZ6Q5OY/IaBbXy3Iy8rw==
X-Received: by 2002:a5d:8903:: with SMTP id b3mr2207722ion.44.1636590396221;
        Wed, 10 Nov 2021 16:26:36 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id s15sm1139630ilu.16.2021.11.10.16.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 16:26:35 -0800 (PST)
Subject: Re: [PATCH] f2fs: provide a way to attach HIPRI for Direct IO
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20211109021336.3796538-1-jaegeuk@kernel.org>
 <YYqkWWZZsMW49/xu@infradead.org>
 <042997ce-8382-40fe-4840-25f40a84c4bf@kernel.dk>
 <YYwYxv4s1ZzBZRtC@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a309f240-e99c-5049-fc67-007a50eb56b3@kernel.dk>
Date:   Wed, 10 Nov 2021 17:26:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YYwYxv4s1ZzBZRtC@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/10/21 12:08 PM, Jaegeuk Kim wrote:
> On 11/09, Jens Axboe wrote:
>> On 11/9/21 9:39 AM, Christoph Hellwig wrote:
>>> On Mon, Nov 08, 2021 at 06:13:36PM -0800, Jaegeuk Kim wrote:
>>>> This patch adds a way to attach HIPRI by expanding the existing sysfs's
>>>> data_io_flag. User can measure IO performance by enabling it.
>>>
>>> NAK.  This flag should only be used when explicitly specified by
>>> the submitter of the I/O.
>>
>> Yes, this cannot be set in the middle for a multitude of reasons. I wonder
>> if we should add a comment to that effect near the definition of it.
> 
> Not surprising. I was wondering we can add this for testing purpose only.
> Btw, is there a reasonable way that filesystem can use IO polling?

Whether an IO is polled or not belongs to the issuer of the IO, as it
comes with certain obligations like "I will actively poll for the
completion of this request", and it incurs certain restrictions in the
block layer in terms of whether or not you can ever sleep for requests.

You could certainly use in in an fs, but only IFF you are the original
issuer of the request, which then also means that you are the one that
needs to poll for completion of it.

It's not a drive-by "let's set this flag to speed things up" kind of
flag, there are a lot more moving parts than that.

I don't think it will be useful for you.

-- 
Jens Axboe

