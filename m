Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF0F421D6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 06:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhJEEcP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 00:32:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229659AbhJEEcP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 00:32:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3368D611C5;
        Tue,  5 Oct 2021 04:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633408225;
        bh=mwtLlNGveq30btzEOHDXQtBFRIVY1CXFp5WcbtYwSiA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Iguk8LBgCPt73EUPiPAtU5RnMaIgAdPFTSloae6afkaFqQNHxJ2TyvSj3r/AiLUPA
         OlM8p2S/NG+Xa3KBL2Tyvk07LB1TlVuEQqzrzsUF9ZTGHG58ebjW9OQBka6H6Y8zSv
         J4dKdTAvAy5Fc6vVoEsfgqdmYlxT8B60WQcX2xzfmcKeOh8mZk66bLI0xqI6ZfICEs
         eKJmlItq1fFrq8H1sTLfiEp8s0tRrNFYEyD7NoNYves6iIAwsdoU2OFp/rPCnnZaZA
         JwnOMwesCayRzoJLYLuVuRb6GoK+X2KsnqVcqlWhACg1D4YMUIXRVKnkHXvBMxP2i3
         5kWVkUeheILaQ==
Received: by mail-ot1-f51.google.com with SMTP id c6-20020a9d2786000000b005471981d559so24310449otb.5;
        Mon, 04 Oct 2021 21:30:25 -0700 (PDT)
X-Gm-Message-State: AOAM5329LqoQE6/R+DVa3VPT0i1dJHyha4pY+xzKLucW2bERgCA10em7
        brOMl/nWmD7OBiOQFE/T6ZI9V8Ep6vpbflOzEcw=
X-Google-Smtp-Source: ABdhPJwc17nyFy1jKaSEyhnnRbq1wlsup111LLUDb+pD6/MI+un5hpI0gLDhCKb+MYffFLg2ic1evHZsc+7xAmtzqsU=
X-Received: by 2002:a05:6830:1147:: with SMTP id x7mr12574781otq.18.1633408224429;
 Mon, 04 Oct 2021 21:30:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:31e7:0:0:0:0:0 with HTTP; Mon, 4 Oct 2021 21:30:23 -0700 (PDT)
In-Reply-To: <c28301d7b99e$37fb5af0$a7f210d0$@samsung.com>
References: <20210909065543.164329-1-cccheng@synology.com> <CGME20210910010035epcas1p496dd515369b9f2481ccd1c0de5904bbd@epcas1p4.samsung.com>
 <CAKYAXd_1ys-xQ9HusgqSr5GHaP6R2pK4JswfZzoqZ=wTnwSiOw@mail.gmail.com>
 <997a01d7b6c6$ea0c3f50$be24bdf0$@samsung.com> <CAKYAXd9COEWU_QF3p0mnEnH4nHMrHQ5ujwBZ6rt4ZBjEFBnB=w@mail.gmail.com>
 <c28301d7b99e$37fb5af0$a7f210d0$@samsung.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 5 Oct 2021 13:30:23 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_vFjVcHJxn5xau5hFNHBXc2K7o1wFHbkhz9TcCteG2Rw@mail.gmail.com>
Message-ID: <CAKYAXd_vFjVcHJxn5xau5hFNHBXc2K7o1wFHbkhz9TcCteG2Rw@mail.gmail.com>
Subject: Re: [PATCH] exfat: use local UTC offset when EXFAT_TZ_VALID isn't set
To:     Sungjong Seo <sj1557.seo@samsung.com>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shepjeng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2021-10-05 13:05 GMT+09:00, Sungjong Seo <sj1557.seo@samsung.com>:
>> 2021-10-01 22:19 GMT+09:00, Sungjong Seo <sj1557.seo@samsung.com>:
>> > Hello, Namjae,
>> Hi Sungjong,
>> >
>> > I found an important difference between the code we first wrote and
>> > the code that has changed since our initial patch review. This
>> > difference seems to cause compatibility issues when reading saved
>> timestamps without timezone.
>> > (In our initial patch review, there were concerns about possible
>> > compatibility issues.) I think the code that reads timestamps without
>> > timezone should go back to the concept we wrote in the first place
>> > like reported patch.
>> Are you talking about using sys_tz?
> Yes, exactly, a part like below.
Have you read discussion about this before ?
Let me know what I am missing something.

>
> +static inline int exfat_tz_offset(struct exfat_sb_info *sbi) {
> +	return (sbi->options.tz_set ? -sbi->options.time_offset :
> +			sys_tz.tz_minuteswest) * SECS_PER_MIN; }
> +
>
>>
>> > It could be an answer of another timestamp issue.
>> What is another timestamp issue ?
>
> What I'm saying is "timestamp incompatibilities in exfat-fs" from Reiner
> <reinerstallknecht@gmail.com>
> I think it might be the same issue with this.
Have you checked fuse-exfat patch he shared ? It was exfat timezone support.
I am not sure how it is related to sys_tz...

Thanks!
>
>>
>> >
>> > Could you please let me know what you think?
>> >
>> > Thanks.
>> >> -----Original Message-----
>> >> From: Namjae Jeon [mailto:linkinjeon@kernel.org]
>> >> Sent: Friday, September 10, 2021 10:01 AM
>> >> To: Chung-Chiang Cheng <cccheng@synology.com>
>> >> Cc: sj1557.seo@samsung.com; linux-fsdevel@vger.kernel.org; linux-
>> >> kernel@vger.kernel.org; shepjeng@gmail.com
>> >> Subject: Re: [PATCH] exfat: use local UTC offset when EXFAT_TZ_VALID
>> >> isn't set
>> >>
>> >> 2021-09-09 15:55 GMT+09:00, Chung-Chiang Cheng <cccheng@synology.com>:
>> >> > EXFAT_TZ_VALID is corresponding to OffsetValid field in exfat
>> >> > specification [1]. If this bit isn't set, timestamps should be
>> >> > treated as having the same UTC offset as the current local time.
>> >> >
>> >> > This patch uses the existing mount option 'time_offset' as fat does.
>> >> > If time_offset isn't set, local UTC offset in sys_tz will be used
>> >> > as the default value.
>> >> >
>> >> > Link: [1]
>> >> > https://protect2.fireeye.com/v1/url?k=cba4edf5-943fd4c8-cba566ba-0c
>> >> > c47
>> >> > a31309a-e70aa065be678729&q=1&e=225feff2-841f-404c-9a2e-c12064b232d0
>> >> > &u=
>> >> > https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fwindows%2Fwin32%2Ffileio
>> >> > %2F exfat-specification%2374102-offsetvalid-field
>> >> > Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
>> >> Please read this discussion:
>> >>  https://patchwork.kernel.org/project/linux-
>> >> fsdevel/patch/20200115082447.19520-10-namjae.jeon@samsung.com/
>> >>
>> >> Thanks!
>> >
>> >
>
>
