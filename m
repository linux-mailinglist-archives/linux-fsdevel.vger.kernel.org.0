Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B2F37C35F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 17:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhELPS1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 11:18:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:32853 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbhELPOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 11:14:51 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lgqYO-0007lr-Rg; Wed, 12 May 2021 15:13:40 +0000
Subject: Re: splice() from /dev/zero to a pipe does not work (5.9+)
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <2add1129-d42e-176d-353d-3aca21280ead@canonical.com>
 <202105071116.638258236E@keescook>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <61a548af-840a-1418-4cb6-644db6c9ba26@canonical.com>
Date:   Wed, 12 May 2021 16:13:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <202105071116.638258236E@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/05/2021 19:21, Kees Cook wrote:
> On Fri, May 07, 2021 at 07:05:51PM +0100, Colin Ian King wrote:
>> Hi,
>>
>> While doing some micro benchmarking with stress-ng I discovered that
>> since linux 5.9 the splicing from /dev/zero to a pipe now fails with
>> -EINVAL.
>>
>> I bisected this down to the following commit:
>>
>> 36e2c7421f02a22f71c9283e55fdb672a9eb58e7 is the first bad commit
>> commit 36e2c7421f02a22f71c9283e55fdb672a9eb58e7
>> Author: Christoph Hellwig <hch@lst.de>
>> Date:   Thu Sep 3 16:22:34 2020 +0200
>>
>>     fs: don't allow splice read/write without explicit ops
>>
>> I'm not sure if this has been reported before, or if it's intentional
>> behavior or not. As it stands, it's a regression in the stress-ng splice
>> test case.
> 
> The general loss of generic splice read/write is known. Here's some
> early conversations I was involved in:
> 
> https://lore.kernel.org/lkml/20200818200725.GA1081@lst.de/
> https://lore.kernel.org/lkml/202009181443.C2179FB@keescook/
> https://lore.kernel.org/lkml/20201005204517.2652730-1-keescook@chromium.org/
> 
> And it's been getting re-implemented in individual places:
> 
> $ git log --oneline --no-merges --grep 36e2c742
> 42984af09afc jffs2: Hook up splice_write callback
> a35d8f016e0b nilfs2: make splice write available again
> f8ad8187c3b5 fs/pipe: allow sendfile() to pipe again
> f2d6c2708bd8 kernfs: wire up ->splice_read and ->splice_write
> 9bb48c82aced tty: implement write_iter
> dd78b0c483e3 tty: implement read_iter
> 14e3e989f6a5 proc mountinfo: make splice available again
> c1048828c3db orangefs: add splice file operations
> 960f4f8a4e60 fs: 9p: add generic splice_write file operation
> cf03f316ad20 fs: 9p: add generic splice_read file operations
> 06a17bbe1d47 afs: Fix copy_file_range()

Ah..so this explains why copy_file_range() also returns -EINVAL now on
some file systems, such a minix since that uses splicing too via
do_splice_direct().  :-/

> 
> So the question is likely, "do we want this for /dev/zero?"
> 

