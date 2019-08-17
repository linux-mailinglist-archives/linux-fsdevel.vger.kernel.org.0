Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 548F5913AE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 01:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfHQX0C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Aug 2019 19:26:02 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:43534 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfHQX0C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Aug 2019 19:26:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 70CEF6083139;
        Sun, 18 Aug 2019 01:25:59 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cO1ZOsJcBe06; Sun, 18 Aug 2019 01:25:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 094F3608311C;
        Sun, 18 Aug 2019 01:25:59 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lRtR3EyXAiKz; Sun, 18 Aug 2019 01:25:58 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 63195621FCC8;
        Sun, 18 Aug 2019 01:25:58 +0200 (CEST)
Date:   Sun, 18 Aug 2019 01:25:58 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        devel <devel@driverdev.osuosl.org>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, tytso <tytso@mit.edu>,
        Pavel Machek <pavel@denx.de>, David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Darrick <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        torvalds <torvalds@linux-foundation.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <1163995781.68824.1566084358245.JavaMail.zimbra@nod.at>
In-Reply-To: <20190817220706.GA11443@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190817082313.21040-1-hsiangkao@aol.com> <1746679415.68815.1566076790942.JavaMail.zimbra@nod.at> <20190817220706.GA11443@hsiangkao-HP-ZHAN-66-Pro-G1>
Subject: Re: [PATCH] erofs: move erofs out of staging
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: erofs: move erofs out of staging
Thread-Index: iW3vMR6GAc7F9NKtTVkkNSt0c7Y/uQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
>> How does erofs compare to squashfs?
>> IIUC it is designed to be faster. Do you have numbers?
>> Feel free to point me older mails if you already showed numbers,
>> I have to admit I didn't follow the development very closely.
> 
> You can see the following related material which has microbenchmark
> tested on my laptop:
> https://static.sched.com/hosted_files/kccncosschn19eng/19/EROFS%20file%20system_OSS2019_Final.pdf
> 
> which was mentioned in the related topic as well:
> https://lore.kernel.org/r/20190815044155.88483-1-gaoxiang25@huawei.com/

Thanks!
Will read into.

While digging a little into the code I noticed that you have very few
checks of the on-disk data.
For example ->u.i_blkaddr. I gave it a try and created a
malformed filesystem where u.i_blkaddr is 0xdeadbeef, it causes the kernel
to loop forever around erofs_read_raw_page().

Thanks,
//richard
