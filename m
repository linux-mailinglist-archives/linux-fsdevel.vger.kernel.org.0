Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B622DFDFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 09:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387771AbfJVHJS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 03:09:18 -0400
Received: from mx-out.tlen.pl ([193.222.135.175]:38664 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387739AbfJVHJS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 03:09:18 -0400
Received: (wp-smtpd smtp.tlen.pl 17107 invoked from network); 22 Oct 2019 09:09:14 +0200
Received: from unknown (HELO localhost.localdomain) (p.sarna@o2.pl@[31.179.144.84])
          (envelope-sender <p.sarna@tlen.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-fsdevel@vger.kernel.org>; 22 Oct 2019 09:09:14 +0200
Subject: Re: [PATCH] hugetlbfs: add O_TMPFILE support
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
References: <22c29acf9c51dae17802e1b05c9e5e4051448c5c.1571129593.git.p.sarna@tlen.pl>
 <20191015105055.GA24932@dhcp22.suse.cz>
 <766b4370-ba71-85a2-5a57-ca9ed7dc7870@oracle.com>
 <eb6206ee-eb2e-ffbc-3963-d80eec04119c@oracle.com>
From:   Piotr Sarna <p.sarna@tlen.pl>
Message-ID: <c0415816-2682-7bf5-2c82-43c3a8941a54@tlen.pl>
Date:   Tue, 22 Oct 2019 09:09:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <eb6206ee-eb2e-ffbc-3963-d80eec04119c@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-WP-MailID: 8456cf0fa81a268f78de0931459eaf0a
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [kZNs]                               
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/21/19 7:17 PM, Mike Kravetz wrote:
> On 10/15/19 4:37 PM, Mike Kravetz wrote:
>> On 10/15/19 3:50 AM, Michal Hocko wrote:
>>> On Tue 15-10-19 11:01:12, Piotr Sarna wrote:
>>>> With hugetlbfs, a common pattern for mapping anonymous huge pages
>>>> is to create a temporary file first.
>>>
>>> Really? I though that this is normally done by shmget(SHM_HUGETLB) or
>>> mmap(MAP_HUGETLB). Or maybe I misunderstood your definition on anonymous
>>> huge pages.
>>>
>>>> Currently libraries like
>>>> libhugetlbfs and seastar create these with a standard mkstemp+unlink
>>>> trick,
>>
>> I would guess that much of libhugetlbfs was writen before MAP_HUGETLB
>> was implemented.  So, that is why it does not make (more) use of that
>> option.
>>
>> The implementation looks to be straight forward.  However, I really do
>> not want to add more functionality to hugetlbfs unless there is specific
>> use case that needs it.
> 
> It was not my intention to shut down discussion on this patch.  I was just
> asking if there was a (new) use case for such a change.  I am checking with
> our DB team as I seem to remember them using the create/unlink approach for
> hugetlbfs in one of their upcoming models.
> 
> Is there a new use case you were thinking about?
> 

Oh, I indeed thought it was a shutdown. The use case I was thinking 
about was in Seastar, where the create+unlink trick is used for creating 
temporary files (in a generic way, not only for hugetlbfs). I simply 
intended to migrate it to a newer approach - O_TMPFILE. However,
for the specific case of hugetlbfs it indeed makes more sense to skip it 
and use mmap's MAP_HUGETLB, so perhaps it's not worth it to patch a 
perfectly good and stable file system just to provide a semi-useful flag 
support. My implementation of tmpfile for hugetlbfs is straightforward 
indeed, but the MAP_HUGETLB argument made me realize that it may not be 
worth the trouble - especially that MAP_HUGETLB is here since 2.6 and 
O_TMPFILE was introduced around v3.11, so the mmap way looks more portable.

tldr: I'd be very happy to get my patch accepted, but the use case I had 
in mind can be easily solved with MAP_HUGETLB, so I don't insist.
