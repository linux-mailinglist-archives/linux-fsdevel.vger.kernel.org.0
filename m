Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65D63AECEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 17:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFUQB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 12:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhFUQBz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 12:01:55 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65333C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 08:59:41 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id b5so3773881ilc.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tXUoDruRqw6fm0tJ4U5TxS0H24Nor4c/WCllgD/ekng=;
        b=ZAA163GYntSyFwpWN8NcRUpdGFTpzOMYug2nYdMcr6M3qeW9TgC1PWIXPbSH8RyQVv
         2NbApjKRvenz3k8TkWM4OW67hU/0r3ZQOA/FZBmqpDCXwn4ga5GoUd5DE00NUN//VqxF
         o5nVi7E+RTxL2YupQOhnEfTv3SZvZt4vPIfybxepMsBLmlPbGTBQTAbjdfu1AOY5PcQd
         7f9NBlHIt1X1bzAEq9mIsLGfPX3sdn4HoyxePTpm1Rtyo4GDBOrZOluQGpeyME36mVMH
         9dsXRqlTY0LYYnEpeA5b1k+Jy+Jrn/RlSwuriYRRwMtSrc7FOiHFn/CowYJxMmFVTxmt
         1d9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tXUoDruRqw6fm0tJ4U5TxS0H24Nor4c/WCllgD/ekng=;
        b=IraRpkedcRSHCEFZbDrws0MQxNGILJN3GgD+f+L2r7hSzjnCN7Pu7iSbrKndO2z7v4
         GSeWtvYt0NWJ/LOeriDLrWeILcxjtD2EbOSykHOFwLntl75NE4gOQONul18G7Z170hBh
         yOm06Vaq3eeqvl/3lXdNJr+Qsd0d71mY0uGX9/qMtc2rAw95KnXr6JQcsEFU6cRApGAC
         ml1Difmv79DPfmawwTQfgDEDjFNsh75naEDRvWcuGyw3dNOwtYWWDTSCuXBXTjBOQy/e
         TEkqXeOAsDeC0NLNkDruedj5QThdBS4KXtUcCabGaj2iQC5sq0TwNwj4gSE3a5oj/3kf
         YOrQ==
X-Gm-Message-State: AOAM533wB4S6H4MObcJBk/8lvmi6MTbLA70gGGFGUqemxTMFChJ3OcKt
        xeXzwtLvKX+G94Ey1AsgdCFRHiMj/l4wSQ==
X-Google-Smtp-Source: ABdhPJzIpeqnBFYPefppR8k/Z63jSp8UKaplttn9BkxKxDeigjgqyqj0Zrivb+pEFt7ZYoJUDDC0VA==
X-Received: by 2002:a05:6e02:14c4:: with SMTP id o4mr9804037ilk.6.1624291180784;
        Mon, 21 Jun 2021 08:59:40 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g4sm369749ilk.37.2021.06.21.08.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 08:59:40 -0700 (PDT)
Subject: Re: [PATCH v5 00/10] io_uring: add mkdir, [sym]linkat and mknodat
 support
From:   Jens Axboe <axboe@kernel.dk>
To:     Dmitry Kadashev <dkadashev@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
References: <20210603051836.2614535-1-dkadashev@gmail.com>
 <b6ab44fc-385f-6f96-379d-ce6cbabd7238@kernel.dk>
Message-ID: <6ea228f7-6be2-712f-01aa-0299e63b3f68@kernel.dk>
Date:   Mon, 21 Jun 2021 09:59:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b6ab44fc-385f-6f96-379d-ce6cbabd7238@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/21/21 9:57 AM, Jens Axboe wrote:
> On 6/2/21 11:18 PM, Dmitry Kadashev wrote:
>> This started out as an attempt to add mkdirat support to io_uring which
>> is heavily based on renameat() / unlinkat() support.
>>
>> During the review process more operations were added (linkat, symlinkat,
>> mknodat) mainly to keep things uniform internally (in namei.c), and
>> with things changed in namei.c adding support for these operations to
>> io_uring is trivial, so that was done too. See
>> https://lore.kernel.org/io-uring/20210514145259.wtl4xcsp52woi6ab@wittgenstein/
>>
>> The first patch is preparation with no functional changes, makes
>> do_mkdirat accept struct filename pointer rather than the user string.
>>
>> The second one leverages that to implement mkdirat in io_uring.
>>
>> 3-6 just convert other similar do_* functions in namei.c to accept
>> struct filename, for uniformity with do_mkdirat, do_renameat and
>> do_unlinkat. No functional changes there.
>>
>> 7 changes do_* helpers in namei.c to return ints rather than some of
>> them returning ints and some longs.
>>
>> 8-10 add symlinkat, linkat and mknodat support to io_uring
>> (correspondingly).
>>
>> Based on for-5.14/io_uring.
> 
> Can you send in the liburing tests as well?

Ah nevermind, you already did...

-- 
Jens Axboe

