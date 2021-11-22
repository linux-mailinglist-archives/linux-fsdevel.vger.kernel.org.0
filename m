Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B45458802
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 03:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhKVCgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Nov 2021 21:36:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhKVCgJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Nov 2021 21:36:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAD8960E9C
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 02:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637548383;
        bh=/EUcTRn86pfASgiIIYS6FnMzBcjQiO61t8fF6H/p9BY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=iaSlgHMa1vvY/mug1ZZEzAV8Gwr0hW3PkpGBK4AVEC1VnTK9GYOd3ADdq5LAiBLP5
         +a9Nn3+DDH/r/6Bsp/xccU6ZMD+fNbBCvGZEGO7iKrfgescRWfg5+xOS6LRJkE95s+
         PYo6B2tgu5rKJNOe6uyWH9uf4NQEXAncYyujXS6eFcDrjbRTyOHrLE9IhPxeXc8j2b
         +NON2eR/fyTulMD9vl8mJD9r1lsI7hU0cOMNEzK2ozMZ8U0Qt2kmE48aBWx18Zg+nr
         ZerggNhXT+tugb7cuh2pwwj/vALoGBjawfp7y+kEPnJ73oxo2hsKfZX0N5VRnNxgmv
         4h13ZptyCyVRA==
Received: by mail-oi1-f175.google.com with SMTP id m6so34978521oim.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Nov 2021 18:33:03 -0800 (PST)
X-Gm-Message-State: AOAM530BVUBAxHg0gYW+nAIGjess630qmaAQV5zkdlNHHsDzFHWDilyt
        vdajttvFAzv06gKY5YyANBHjpNAuz+hRo5q1K6o=
X-Google-Smtp-Source: ABdhPJyMqdxg4pTLyDeaJt4bLHR/AM6YyXzIke9BQ+8hADuNJ44GFEXklGfl2MReK3nMIYvA1zX8ptpwWHOiYyKZT0k=
X-Received: by 2002:a05:6808:1202:: with SMTP id a2mr15818496oil.8.1637548382993;
 Sun, 21 Nov 2021 18:33:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:4448:0:0:0:0:0 with HTTP; Sun, 21 Nov 2021 18:33:02
 -0800 (PST)
In-Reply-To: <e9d301d7df46$1441f290$3cc5d7b0$@samsung.com>
References: <YZbKobiUUt6eG6zQ@casper.infradead.org> <CGME20211119173750epcas1p4bb84dea1dae163e67caaa306be2c1dcf@epcas1p4.samsung.com>
 <20211119173734.2545-1-cvubrugier@fastmail.fm> <e9d301d7df46$1441f290$3cc5d7b0$@samsung.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 22 Nov 2021 11:33:02 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-YaS1o+jAyyUU_65qnnPqeYVsxszvOyRX1Py8+hEFNJg@mail.gmail.com>
Message-ID: <CAKYAXd-YaS1o+jAyyUU_65qnnPqeYVsxszvOyRX1Py8+hEFNJg@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: fix i_blocks for files truncated over 4 GiB
To:     Christophe Vu-Brugier <cvubrugier@fastmail.fm>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2021-11-22 11:10 GMT+09:00, Sungjong Seo <sj1557.seo@samsung.com>:
>> From: Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>
>>
>> In exfat_truncate(), the computation of inode->i_blocks is wrong if the
>> file is larger than 4 GiB because a 32-bit variable is used as a mask.
>> This is fixed and simplified by using round_up().
>>
>> Also fix the same buggy computation in exfat_read_root() and another
>> (correct) one in exfat_fill_inode(). The latter was fixed another way
>> last
>> month but can be simplified by using round_up() as well. See:
>>
>>   commit 0c336d6e33f4 ("exfat: fix incorrect loading of i_blocks for
>>                         large files")
>>
>> Signed-off-by: Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>
>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>
> Thanks for your patch!
> Please update your patch again with below tags.
There is no need to send a patch again.
I will directly update and apply it.

Thanks!
>
> Fixes: 719c1e1829166 ("exfat: add super block operations")
> Fixes: 98d917047e8b7 ("exfat: add file operations")
> Cc: stable@vger.kernel.org # v5.7+
>
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
>
>
