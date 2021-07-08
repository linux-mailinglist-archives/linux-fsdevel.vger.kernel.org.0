Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC2E3C19C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 21:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhGHT2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 15:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhGHT2d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 15:28:33 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBE2C061574
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jul 2021 12:25:50 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id g22so9652339iom.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jul 2021 12:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6S7YAMaQ5hfgByK0Q7Ny9TcwwQexuIxF/Xc0CIcaWLA=;
        b=Ry4SqUX9x7mHYKMfgGodpI0I3kZbGYMpXAFQYKMRCRxS7maDwMC5Ge1QxXI+vaVQ8e
         aFGJBj4sdBl4t7fyHgOxy9617DiPMW6hF92k1YlsGdINHrfZy39iZplY3KUT/EJTLWIo
         B8292tosNeCRuJnDfdWRiqfCw7kNAVna5QTDbfMRVhyXuXseL0ZXQuRQhdN+/NuxYhQx
         yW24yHr3x3w3Y4+BeeutYB0XZOERGvoNaj9SBZaWT3W4Vb5gEeGa2B8UkAX9ZYkKt/Qz
         phQduBU6lSt2+8PAgG+BnoiNp+38wWnfmeq80hri1/6bqJcAMKGGR5F5BaTYGQQ+BPSE
         Ae/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6S7YAMaQ5hfgByK0Q7Ny9TcwwQexuIxF/Xc0CIcaWLA=;
        b=fz5cgwIERCGdRtn0Wy9y37sZ4b6WOUC7NS2CRwwqRTzwdwwJ87ag4Ulo8emR+/HqR5
         c6uv9Zr6KgH4yFYv5o1z8hLbnT50VpjVX+0eGJwFSZkVaLTYIE+SNbi9dOkSAc5PMFQY
         8itGBryqnz3/qU0cYb9pCDpSLzUiTVXgsPgz+bXIVC/xM6Z9TVQQoI8gkVm/BxODcWkD
         leHA4weRLWJkD+WKvERSlXTSOxnTOn+Zxpnh8YelgnUb1vfwiKZgQ6cctbNck4uTf0p7
         MDSviOUrh8ULVDoZbEey93Dd/GUmwgVMhY/ZQAVwlAJx9IodV99EXnzsZmXFv1HZ103B
         sl4w==
X-Gm-Message-State: AOAM532PhLy461tIaECVLHHtEn2a2WJS82EgFNkiydvWuIu1Y2+B+jfg
        YU7KYgohVW4AQBpPCTNMESNEeQ==
X-Google-Smtp-Source: ABdhPJzwWROlk8K1InwDLGCBXKS/2celn8lsHzD2mOOW7DMAqYUycHyX7FhjHXMYwvyTr+ThMW2w1Q==
X-Received: by 2002:a05:6638:d93:: with SMTP id l19mr14887413jaj.46.1625772349716;
        Thu, 08 Jul 2021 12:25:49 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id p8sm1541773iln.83.2021.07.08.12.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 12:25:49 -0700 (PDT)
Subject: Re: [PATCH v9 00/11] io_uring: add mkdir and [sym]linkat support
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
References: <20210708063447.3556403-1-dkadashev@gmail.com>
 <CAHk-=wjMFZ98ERV7V5u6R4FbYi3vRRf8_Uev493qeYCa1vqV3Q@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cbddca99-d9b1-d545-e2eb-a243ce38270b@kernel.dk>
Date:   Thu, 8 Jul 2021 13:25:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjMFZ98ERV7V5u6R4FbYi3vRRf8_Uev493qeYCa1vqV3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/8/21 12:34 PM, Linus Torvalds wrote:
> On Wed, Jul 7, 2021 at 11:35 PM Dmitry Kadashev <dkadashev@gmail.com> wrote:
>>
>> v9:
>> - reorder commits to keep io_uring ones nicely grouped at the end
>> - change 'fs:' to 'namei:' in related commit subjects, since this is
>>   what seems to be usually used in such cases
> 
> Ok, ack from me on this series, and as far as I'm concerned it can go
> through the io_uring branch.

I'll queue it up in a separate branch. I'm assuming we're talking 5.15
at this point.

> Al, please holler if you have any concerns.

Indeed.

-- 
Jens Axboe

