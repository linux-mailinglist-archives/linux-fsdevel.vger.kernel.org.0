Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA62E8ABA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 15:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389024AbfJ2OZh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 10:25:37 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:42410 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728306AbfJ2OZh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:25:37 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id C01D82E1519;
        Tue, 29 Oct 2019 17:25:33 +0300 (MSK)
Received: from iva4-c987840161f8.qloud-c.yandex.net (iva4-c987840161f8.qloud-c.yandex.net [2a02:6b8:c0c:3da5:0:640:c987:8401])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id k4OaEZrLEs-PW9K6jN5;
        Tue, 29 Oct 2019 17:25:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572359133; bh=kIwUyXR7LgBl9um7BtroesKEgDforbsjtA4cvjy2EaU=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=kBbbNspQ8dCoThI+PybXLSgQ176sm7Z+eKaEXWqy1B0+EU7umkCtVUjkP3zEvwtue
         T1uqg9AYAwWiNQg9CQIaTBCFw6xNAeWTf2aYVAcqruPn7u8pk9Ezua17H+QLx0YF4W
         FYg+COEp5VbV26jJ6t1VTi8pJwOaADIjOXLiCnaI=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:148a:8f3:5b61:9f4])
        by iva4-c987840161f8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id iezr0jZMY7-PRWCqN9i;
        Tue, 29 Oct 2019 17:25:27 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Steven Whitehouse <swhiteho@redhat.com>
References: <157225677483.3442.4227193290486305330.stgit@buzz>
 <20191028124222.ld6u3dhhujfqcn7w@box>
 <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
 <20191028125702.xdfbs7rqhm3wer5t@box>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <ac83fee6-9bcd-8c66-3596-2c0fbe6bcf96@yandex-team.ru>
Date:   Tue, 29 Oct 2019 17:25:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191028125702.xdfbs7rqhm3wer5t@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28/10/2019 15.57, Kirill A. Shutemov wrote:
> On Mon, Oct 28, 2019 at 01:47:16PM +0100, Linus Torvalds wrote:
>> On Mon, Oct 28, 2019 at 1:42 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>>>
>>> I've tried something of this sort back in 2013:
>>>
>>> http://lore.kernel.org/r/1377099441-2224-1-git-send-email-kirill.shutemov@linux.intel.com
>>>
>>> and I've got push back.
>>>
>>> Apparently, some filesystems may not have valid i_size before >readpage().
>>> Not sure if it's still the case...
>>
>> Well, I agree that there might be some network filesystem that might
>> have inode sizes that are stale, but if that's the case then I don't
>> think your previous patch works either.
>>
>> It too will avoid the readpage() if the read position is beyond i_size.
>>
>> No?
> 
> Yes. That's the reason the patch was rejected back then.
> 
> My point is that we need to make sure that this patch not break anything.
> 

I think all network filesystems which synchronize metadata lazily should be
marked. For example as "SB_VOLATILE". And vfs could handle them specially.

For this case generic_file_buffered_read() could call for them readpages
for single page (rather than readpage) to let filesystem revalidate
metadata and drop unneeded page without inserting it into inode and lru.
