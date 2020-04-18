Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC22B1AF5A8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 00:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgDRWu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 18:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgDRWu6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 18:50:58 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E682121974
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 22:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587250258;
        bh=ke3QdPRjv2pHC7W2L1z9dWaJDygdaZQjOtQln2AFjbU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=yaVrgzfRRwdXSw4XDBw7M6nsqMvc2M1q0JKl5GU2sBr4Mp54h7tYeIT/SXQzef9lJ
         ijSC0LUT3MOmtbDyM1mePGyea27TSB5bPtgMrdhMpvPivw/6qO0O8lNCNWenQ/X8Ay
         peFLhjbeYp3+bk4kU1KZ97dcUP8Vbobk1ENyxb7c=
Received: by mail-ot1-f54.google.com with SMTP id g14so4730076otg.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 15:50:57 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ4ck78NatQoDqbx43tSh0PgJPUy4TYXhv+lkMq44QSa9lRZTvq
        x/5uZZA6tIQ8/3tOf+iMYbKriZ0ZjVF3a5YNBKc=
X-Google-Smtp-Source: APiQypJIdy/tZHtS6pu4EaEEXZ6hP3Emb2miI9zVURM7l9CNFqEwl5uGpwKNhPuvNCHs06d/8rkxMnH+6Z/mKlRMqAU=
X-Received: by 2002:a9d:740d:: with SMTP id n13mr4273876otk.114.1587250257198;
 Sat, 18 Apr 2020 15:50:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5744:0:0:0:0:0 with HTTP; Sat, 18 Apr 2020 15:50:56
 -0700 (PDT)
In-Reply-To: <9d3c760c-9b1d-b8e7-a24b-2d6f11975cf7@sandeen.net>
References: <ef3cdac4-9967-a225-fb04-4dbb4c7037a9@sandeen.net>
 <abfc2cdf-0ff1-3334-da03-8fbcc6eda328@sandeen.net> <381e5327-618b-13ab-ebe5-175f99abf7db@sandeen.net>
 <CAKYAXd8f_4nodeTf8OHQvXCwzDSfGciw9FSd42dygeYK7A+5qw@mail.gmail.com> <9d3c760c-9b1d-b8e7-a24b-2d6f11975cf7@sandeen.net>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 19 Apr 2020 07:50:56 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8gsrO=LL0D3nf+Ly6t8_iwBWfb99KnZHwxnCKgN3hiwA@mail.gmail.com>
Message-ID: <CAKYAXd8gsrO=LL0D3nf+Ly6t8_iwBWfb99KnZHwxnCKgN3hiwA@mail.gmail.com>
Subject: Re: [PATCH 2/2 V2] exfat: truncate atimes to 2s granularity
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-04-19 1:04 GMT+09:00, Eric Sandeen <sandeen@sandeen.net>:
> On 4/18/20 8:03 AM, Namjae Jeon wrote:
>> 2020-04-16 13:11 GMT+09:00, Eric Sandeen <sandeen@sandeen.net>:
>> Hi Eric,
>>
>>> exfat atimes are restricted to only 2s granularity so after
>>> we set an atime, round it down to the nearest 2s and set the
>>> sub-second component of the timestamp to 0.
>> Is there any reason why only atime is truncated with 2s granularity ?
>
> You're the expert, so I might be wrong! :)
>
> My reading of the spec & code is that every timestamp has 2s granularity, in
> the
> main time field, and some timestamps also have another field with 10ms
> granularity,
> which can range from 0 to 199, i.e. 0 to 1990 ms, i.e. 0 to 1.99 seconds in
> the _ms
> field.  i.e. the _ms fields can add more than 1 second to the timestamp,
> right?
Right.
>
>                 struct {
>                         __u8 num_ext;
>                         __le16 checksum;
>                         __le16 attr;
>                         __le16 reserved1;
>                         __le16 create_time;
>                         __le16 create_date;
>                         __le16 modify_time;
>                         __le16 modify_date;
>                         __le16 access_time;
>                         __le16 access_date;
>                         __u8 create_time_ms;
>                         __u8 modify_time_ms;
>                         __u8 create_tz;
>                         __u8 modify_tz;
>                         __u8 access_tz;
>                         __u8 reserved2[7];
>                 } __packed file; /* file directory entry */
>
> and per the publiished spec,
>
> 7.4.8.1 DoubleSeconds Field
>
> The DoubleSeconds field shall describe the seconds portion of the Timestamp
> field, in two-second multiples.
>
> The valid range of values for this field shall be:
>
>     0, which represents 0 seconds
>
>     29, which represents 58 seconds
>
> 7.4.9 10msIncrement Fields
>
> 10msIncrement fields shall provide additional time resolution to their
> corresponding Timestamp fields in ten-millisecond multiples.
>
> The valid range of values for these fields shall be:
>
>     At least 0, which represents 0 milliseconds
>
>     At most 199, which represents 1990 milliseconds
>
>
> since access_time has no corresponding 10msIncrement field, my understanding
> was that it could only have a 2s granularity.
Right.
>
> Happy to have the patch dropped or corrected if I read this wrong, though.
Thanks for your detail explanation:)

I just wanted to update the patch's descirption and function's
comments to make it easier for others to understand this patch and
code.
>
> -Eric
>
