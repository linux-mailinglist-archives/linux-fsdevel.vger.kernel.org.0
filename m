Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98ACEE12EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 09:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389459AbfJWHOp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 03:14:45 -0400
Received: from mx-out.tlen.pl ([193.222.135.140]:28656 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388218AbfJWHOp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:14:45 -0400
Received: (wp-smtpd smtp.tlen.pl 3618 invoked from network); 23 Oct 2019 09:14:36 +0200
Received: from unknown (HELO localhost.localdomain) (p.sarna@o2.pl@[31.179.144.84])
          (envelope-sender <p.sarna@tlen.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-fsdevel@vger.kernel.org>; 23 Oct 2019 09:14:36 +0200
Subject: Re: [PATCH] hugetlbfs: add O_TMPFILE support
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
References: <22c29acf9c51dae17802e1b05c9e5e4051448c5c.1571129593.git.p.sarna@tlen.pl>
 <20191015105055.GA24932@dhcp22.suse.cz>
 <766b4370-ba71-85a2-5a57-ca9ed7dc7870@oracle.com>
 <eb6206ee-eb2e-ffbc-3963-d80eec04119c@oracle.com>
 <c0415816-2682-7bf5-2c82-43c3a8941a54@tlen.pl>
 <d29bc957-a074-22f6-51d7-e043719d5f98@oracle.com>
From:   Piotr Sarna <p.sarna@tlen.pl>
Message-ID: <36c17999-caf6-9f0a-d63a-cc6e4b5fabb8@tlen.pl>
Date:   Wed, 23 Oct 2019 09:14:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d29bc957-a074-22f6-51d7-e043719d5f98@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-WP-MailID: 424e793a204962c7684229931db4e0c3
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [IXNk]                               
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/23/19 4:55 AM, Mike Kravetz wrote:
> On 10/22/19 12:09 AM, Piotr Sarna wrote:
>> On 10/21/19 7:17 PM, Mike Kravetz wrote:
>>> On 10/15/19 4:37 PM, Mike Kravetz wrote:
>>>> On 10/15/19 3:50 AM, Michal Hocko wrote:
>>>>> On Tue 15-10-19 11:01:12, Piotr Sarna wrote:
>>>>>> With hugetlbfs, a common pattern for mapping anonymous huge pages
>>>>>> is to create a temporary file first.
>>>>>
>>>>> Really? I though that this is normally done by shmget(SHM_HUGETLB) or
>>>>> mmap(MAP_HUGETLB). Or maybe I misunderstood your definition on anonymous
>>>>> huge pages.
>>>>>
>>>>>> Currently libraries like
>>>>>> libhugetlbfs and seastar create these with a standard mkstemp+unlink
>>>>>> trick,
>>>>
>>>> I would guess that much of libhugetlbfs was writen before MAP_HUGETLB
>>>> was implemented.  So, that is why it does not make (more) use of that
>>>> option.
>>>>
>>>> The implementation looks to be straight forward.  However, I really do
>>>> not want to add more functionality to hugetlbfs unless there is specific
>>>> use case that needs it.
>>>
>>> It was not my intention to shut down discussion on this patch.  I was just
>>> asking if there was a (new) use case for such a change.  I am checking with
>>> our DB team as I seem to remember them using the create/unlink approach for
>>> hugetlbfs in one of their upcoming models.
>>>
>>> Is there a new use case you were thinking about?
>>>
>>
>> Oh, I indeed thought it was a shutdown. The use case I was thinking about was in Seastar, where the create+unlink trick is used for creating temporary files (in a generic way, not only for hugetlbfs). I simply intended to migrate it to a newer approach - O_TMPFILE. However,
>> for the specific case of hugetlbfs it indeed makes more sense to skip it and use mmap's MAP_HUGETLB, so perhaps it's not worth it to patch a perfectly good and stable file system just to provide a semi-useful flag support. My implementation of tmpfile for hugetlbfs is straightforward indeed, but the MAP_HUGETLB argument made me realize that it may not be worth the trouble - especially that MAP_HUGETLB is here since 2.6 and O_TMPFILE was introduced around v3.11, so the mmap way looks more portable.
>>
>> tldr: I'd be very happy to get my patch accepted, but the use case I had in mind can be easily solved with MAP_HUGETLB, so I don't insist.
> 
> If you really are after something like 'anonymous memory' for Seastar,
> then MAP_HUGETLB would be the better approach.

Just to clarify - my original goal was to migrate Seastar's temporary 
file implementation (which is fs-agnostic, based on descriptors) from 
the current create+unlink to O_TMPFILE, for robustness. One of the 
internal usages of this generic mechanism was to create a tmpfile on 
hugetlbfs and that's why I sent this patch. However, this particular 
internal usage can be easily switched to more portable MAP_HUGETLB, 
which will also mean that the generic tmpfile implementation will not be 
used internally for hugetlbfs anymore.

There *may* still be value in being able to support hugetlbfs once 
Seastar's tmpfile implementation migrates to O_TMPFILE, since the 
library offers creating temporary files in its public API, but there's 
no immediate use case I can apply it to.

> 
> I'm still checking with Oracle DB team as they may have a use for O_TMPFILE
> in an upcoming release.  In their use case, they want an open fd to work with.
> If it looks like they will proceed in this direction, we can work to get
> your patch moved forward.
> 
> Thanks,

Great, if it turns out that my patch helps anyone with their O_TMPFILE 
usage, I'd be very glad to see it merged.

