Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B88539F423
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 12:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhFHKwC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 06:52:02 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:47053 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhFHKv6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:51:58 -0400
Received: from [192.168.1.155] ([77.7.0.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mn2iP-1l6ou72jjT-00k7Qq; Tue, 08 Jun 2021 12:50:00 +0200
Subject: Re: [PATCH RFC] fuse: add generic file store
To:     Peng Tao <bergwolf@gmail.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
References: <1622537906-54361-1-git-send-email-tao.peng@linux.alibaba.com>
 <YLeoucLiMOSPwn4U@google.com>
 <244309bf-4f2e-342e-dd98-755862c643b8@metux.net>
 <CA+a=Yy5moy0Bv=mhsrC9FrY+cEYt8+YJL8TvXQ=N7pNyktccRQ@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <429fc51b-ece0-b5cb-9540-2e7f5b472d73@metux.net>
Date:   Tue, 8 Jun 2021 12:49:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CA+a=Yy5moy0Bv=mhsrC9FrY+cEYt8+YJL8TvXQ=N7pNyktccRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+iX9SxgmDWlSCJa3FT3ntRx0FN0dur6biN9j/XF0iY+NVrxfvHm
 1PSon1AqTAxfp33U3isDabq56uY4/9v3YuHy3CEnniiOdOAYNZDOJ/q9n5j9kTFIrKZEm/l
 Fu/H+nEo4+SH3nna7q1Xi57Xe6PPovfC5vQNG49Y/VLoc4yyE0Ltbhea+IQzUpGozocKQCV
 pvlASDPf1hk24We1g+G7Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5V3wurUshAM=:GGRA3dsVkMGU0N9FP5XpYv
 jfpNHQ02cS4udUJ/G2JdnvgaWcl3ZRtlkb9588KNPsPtc9pnLC2TjpAWD5AP7+Zk/6zYFnNWN
 PV9J3rdMsPg4i1dzaK+2rfITVcePRSJxLSHlQA1MRJClC6DYmGOsoioO0nrFvNkqXSX/S6hQV
 +4vHKjhbiUlqoe1xoQkhrGIVmp04CSqtXMbt5JwJhRURe7FUBiZWC2ptJSW4VSmAbtmZ6C+4k
 4yQs7W6mLdGzfpm5L8oe4iCu5FVJb/Nq4UrlcJfcg21xpwi0qlbsO0Ty+bv4KVEYI2dKzb5nW
 3sFzGQh9nJB4ethF4CfLY4T9RgA3boQuY+3rWPfUmDgUsH+cKsEFqGy/5Z0FIet6homf//ZpM
 fo9T1RC5q+nGAFqDLOMLXKAKsBKRk9nqAXKRiS4t3g7shmJpWHd8ex1kRNbJ72DeM/hr+wvsa
 NkDZ6w4JLgYUDU/Ipvy3p25TJYd2wj4LkzV0bhyf6hMSi3FBjCQGOCTWDtGopzRZLUQhgY8pR
 526eaXiTjnG0Y0v/nIdXo4=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.06.21 04:58, Peng Tao wrote:

>> oh, this could be quite what I'm currently intending do implement
>> (just considered 9p instead of fuse as it looks simpler to me):
>>
>> I'd like the server being able to directly send an already opened fd to
>> the client (in response to it calling open()), quite like we can send
>> fd's via unix sockets.
>>
>> The primary use case of that is sending already prepared fd's (eg. an
>> active network connection, locked-down file fd, a device that the client
>> can't open himself, etc).
>>
>> Is that what you're working on ?
> If the server and client run on the same kernel, then yes, the current
> RFC supports your use case as well, E.g.,
> 1. the server opens a file, saves the FD to the kernel, and passes the
> IDR to the client.
> 2. the client retrieves the FD from the kernel
> 
> Does it match your use case?

Seems that's exactly what I'm looking for :)

Could you perhaps give a little example code how it looks in userland ?


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
