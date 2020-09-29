Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDCD27D0A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 16:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbgI2OIt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 10:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbgI2OIt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:08:49 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33253C0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2020 07:08:49 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id g7so4887870iov.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2020 07:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=euWnP0EJlqYVaKu5lNq63ImPlulmGIi8tNfvVNhQacA=;
        b=yJ/vStC080VOPuKUMvBTmMUJ1H/SPQ3U7f29zv7UcANL8Z2hrauxe2MtRa6DCJFy/S
         mBWCHeAM2WNCaaA3IlgJVlC45InLmWcqjAsNzgUNikSIiak+4BPAr1Hv50RtsOUyhpW3
         vUZr4FIuyNX8Zw+Olb0YH6UtlxjbRWlg3zcJ9hXWNI8oJzIpyKxYAxBgUWettmTXQDUb
         PgzgiM9klFb1V1fyEOURhsjeES/gaCBo2HManZbKZO6KUkN8z3s+y2w9DtBG4QZD4KaR
         sJNb+ot8MeSxJ5MzQFpgXJTeW6BKHUniIcELOsIHRtuVDRXLsoDrX59RTLFD3G6VSU3J
         7ahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=euWnP0EJlqYVaKu5lNq63ImPlulmGIi8tNfvVNhQacA=;
        b=Wpyc6pi0W2h1n9d6qurbdNQCXj6Jev0IX3TqkRYpTH885++BfO2ZKNqcyJiHH8z8kJ
         gskfjv/6NBbkRuaYEWMUwkS9/cV8Mb8fvopEy2wDtoEjnJGdqIq794K+WDc+pZhZw5lS
         AYWZZPkqWl3ErLuqmQSZr1BT2JYrzGO2tl+5BdXP+NTOh4vUzmaIDxL96v7aL1Z9lV4G
         9uXF4SOq7dgm8wCayOITsEzkgX/aqv/7xgDdQpgdYyMKQCziluhKPJgLmCcsVJkLwNFq
         C/nrISB1PZR7UYdwR7NXsXCVyB1wp+7F8X1M36xlZvdVcW9IBkQGXEq4YR1ZdUup2ScW
         OuRg==
X-Gm-Message-State: AOAM53003ygqh5lnWM5MNooZGNU2FhrILfP7dG53+G4J7M3Hew2yi8cY
        uAzI7Aeb+K2A9JOB+rFAuUzWlQ==
X-Google-Smtp-Source: ABdhPJwznZKAEjDwbXPZsPlNS+SrujjBj22UJqCGUldQibpOSN7EhG/+YYv8NUbpjF+Q14qRF0RZKA==
X-Received: by 2002:a6b:8b52:: with SMTP id n79mr2561452iod.122.1601388528281;
        Tue, 29 Sep 2020 07:08:48 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d17sm2470609ilo.3.2020.09.29.07.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 07:08:47 -0700 (PDT)
Subject: Re: possible deadlock in io_uring_show_fdinfo
To:     syzbot <syzbot+d8076141c9af9baf6304@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <0000000000000a315605b06fb13c@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d21299c5-674b-6e0e-bcd7-2b0113b3efa4@kernel.dk>
Date:   Tue, 29 Sep 2020 08:08:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0000000000000a315605b06fb13c@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz dup: possible deadlock in io_write

-- 
Jens Axboe

