Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96C621557C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 12:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgGFK0j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 06:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728738AbgGFK0j (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:26:39 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1F3D20739;
        Mon,  6 Jul 2020 10:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594031199;
        bh=3UkBTcF9Tehoe2mDSXobxqfXr5AsItcGVVRC3ivdOfw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=kw+CkA2bSTGqZQ7G/T3nvcN7r791b7gkyjkAa8jXISQIr0SBYGJxKHvDp8IUPKJAi
         lJCFOrBYuVfCjZdhhftE6WozJ8gNACHw9PABi1+po3twTE7SpMoDzWaLsCqq3gLe2e
         drtrlpRiURzZAFQdiW+Xmtx7y2WY7olzeGSM6oVE=
Received: by mail-ot1-f41.google.com with SMTP id e90so729139ote.1;
        Mon, 06 Jul 2020 03:26:38 -0700 (PDT)
X-Gm-Message-State: AOAM532rsOL+pkD8lL1M8+6DiokdIgU7XZxRfeXDzJblRS5Ske2Auh0U
        4tLyeDdWPl3XGdbaKO0VnRsUs6jB4eCD9FjeA1g=
X-Google-Smtp-Source: ABdhPJzdm/HZCHIZZpKIgxdIeRbYrhGSdZL2d4hqDTPAhaNmOO7vR9qopK/9HPPUDd16Phbe7SoptsZrjGlFr7rrs1Y=
X-Received: by 2002:a05:6830:1617:: with SMTP id g23mr13867668otr.282.1594031198288;
 Mon, 06 Jul 2020 03:26:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:134b:0:0:0:0:0 with HTTP; Mon, 6 Jul 2020 03:26:37 -0700 (PDT)
In-Reply-To: <CAD14+f0QUgXbDY8vK4HHKcWAh90Jp8DCMb-SRoFmmGrZ3cBhdw@mail.gmail.com>
References: <CGME20200627125605epcas1p175ba4ecfbdea3426cc7b0a8fc1750cd0@epcas1p1.samsung.com>
 <20200627125509.142393-1-qkrwngud825@gmail.com> <003801d6502f$f40101c0$dc030540$@samsung.com>
 <CAD14+f0QUgXbDY8vK4HHKcWAh90Jp8DCMb-SRoFmmGrZ3cBhdw@mail.gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 6 Jul 2020 19:26:37 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-49hN3CVzeQBa6MqiY36yc7mmn4FkVHABeBvakWYyU8Q@mail.gmail.com>
Message-ID: <CAKYAXd-49hN3CVzeQBa6MqiY36yc7mmn4FkVHABeBvakWYyU8Q@mail.gmail.com>
Subject: Re: [PATCH] exfat: implement "quiet" option for setattr
To:     Ju Hyung Park <qkrwngud825@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-07-06 17:22 GMT+09:00, Ju Hyung Park <qkrwngud825@gmail.com>:
> Hi Namjae.
Hi Juhyung,
>
> Looks like I ported this incorrectly from the previous sdFAT base.
>
> I'll fix, test again and send v2.
Okay:) Thanks!
>
> Thanks.
>
> On Thu, Jul 2, 2020 at 2:16 PM Namjae Jeon <namjae.jeon@samsung.com> wrote:
>>
>> >
>> >       if (((attr->ia_valid & ATTR_UID) &&
>> >            !uid_eq(attr->ia_uid, sbi->options.fs_uid)) || @@ -322,6
>> > +325,12 @@ int
>> > exfat_setattr(struct dentry *dentry, struct iattr *attr)
>> >               goto out;
>> You should remove goto statement and curly braces here to reach if error
>> condition.
>> >       }
>> >
>> > +     if (error) {
>> > +             if (sbi->options.quiet)
>> > +                     error = 0;
>> > +             goto out;
>> > +     }
>>
>
