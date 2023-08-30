Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F6F78D184
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 03:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241470AbjH3BDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 21:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240114AbjH3BDY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 21:03:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C065ACC4;
        Tue, 29 Aug 2023 18:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693357401; x=1724893401;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mw/bAch6QBQQaanheaukxf/nWwu/Y+wxeNu7/mJwudA=;
  b=ig1ZIh/diVhiD/5LkG49KL1jeOWcESI52qvm19EpjL13HXmb6WeCUC4Y
   PHGw4qqcRKYA06LFv6wSuDU+mIO634Xo0DbWFCdeZGbtoQUx1J3jYQZB4
   EEoARrHlnQNuFVraeLymcdI5YKH8XIqk1GHVwHi5KueVIA6k7oQTUoxx4
   dWzKhFrfXwN8ORQh+LbGxbeQwBhqF+iJfEYJQkBtIOIjBrCJxVkDMMljC
   8QzMYXqQlj4jIdn/5XFZWpvHG7WX3oGqC0ypYM6OKq28gR9P8k6QUf7jD
   9ZYdmnlBI6cIXiqipsgCVJ7n9qrdtaUkHITSjaXwoJfgn5W4u7byiRjSy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="406515474"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="406515474"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 18:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="742038613"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="742038613"
Received: from leihuan1-mobl.amr.corp.intel.com (HELO [10.0.2.15]) ([10.92.27.231])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 18:03:18 -0700
Message-ID: <5eedd8a6-02d9-bc85-df43-6aa5f7497288@linux.intel.com>
Date:   Tue, 29 Aug 2023 21:03:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] fs/fuse: Fix missing FOLL_PIN for direct-io
Content-Language: en-US
To:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        linux-kernel@vger.kernel.org
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
References: <1693334193-7733-1-git-send-email-lei.huang@linux.intel.com>
 <572dcce8-f70c-2d24-f844-a3e8abbd4bd8@fastmail.fm>
From:   Lei Huang <lei.huang@linux.intel.com>
In-Reply-To: <572dcce8-f70c-2d24-f844-a3e8abbd4bd8@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Bernd,

Thank you very much for your reply!

 > Hmm, iov_iter_extract_pages does not exists for a long time and the code
 > in fuse_get_user_pages didn't change much. So if you are right, there
 > would be a long term data corruption for page migrations? And a back
 > port to old kernels would not be obvious?

Right. The issue has been reproduced under various versions of kernels, 
ranging from 3.10.0 to 6.3.6 in my tests. It would be different to make 
a patch under older kernels like 3.10.0. One way I tested, one can query
the physical pages associated with read buffer after data is ready 
(right before writing the data into read buffer). This seems resolving 
the issue in my tests.


 > What confuses me further is that
 > commit 85dd2c8ff368 does not mention migration or corruption, although
 > lists several other advantages for iov_iter_extract_pages. Other commits
 > using iov_iter_extract_pages point to fork - i.e. would your data
 > corruption be possibly related that?

As I mentioned above, the issue seems resolved if we query the physical 
pages as late as right before writing data into read buffer. I think the 
root cause is page migration.

Best Regards,
-lei

On 8/29/23 17:57, Bernd Schubert wrote:
> 
> 
> On 8/29/23 20:36, Lei Huang wrote:
>> Our user space filesystem relies on fuse to provide POSIX interface.
>> In our test, a known string is written into a file and the content
>> is read back later to verify correct data returned. We observed wrong
>> data returned in read buffer in rare cases although correct data are
>> stored in our filesystem.
>>
>> Fuse kernel module calls iov_iter_get_pages2() to get the physical
>> pages of the user-space read buffer passed in read(). The pages are
>> not pinned to avoid page migration. When page migration occurs, the
>> consequence are two-folds.
>>
>> 1) Applications do not receive correct data in read buffer.
>> 2) fuse kernel writes data into a wrong place.
>>
>> Using iov_iter_extract_pages() to pin pages fixes the issue in our
>> test.
> 
> Hmm, iov_iter_extract_pages does not exists for a long time and the code 
> in fuse_get_user_pages didn't change much. So if you are right, there 
> would be a long term data corruption for page migrations? And a back 
> port to old kernels would not be obvious?
> 
> What confuses me further is that
> commit 85dd2c8ff368 does not mention migration or corruption, although 
> lists several other advantages for iov_iter_extract_pages. Other commits 
> using iov_iter_extract_pages point to fork - i.e. would your data 
> corruption be possibly related that?
> 
> 
> Thanks,
> Bernd
> 
> 
>>
>> An auxiliary variable "struct page **pt_pages" is used in the patch
>> to prepare the 2nd parameter for iov_iter_extract_pages() since
>> iov_iter_get_pages2() uses a different type for the 2nd parameter.
>>
>> Signed-off-by: Lei Huang <lei.huang@linux.intel.com>
>> ---
>>   fs/fuse/file.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index bc41152..715de3b 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -670,7 +670,7 @@ static void fuse_release_user_pages(struct 
>> fuse_args_pages *ap,
>>       for (i = 0; i < ap->num_pages; i++) {
>>           if (should_dirty)
>>               set_page_dirty_lock(ap->pages[i]);
>> -        put_page(ap->pages[i]);
>> +        unpin_user_page(ap->pages[i]);
>>       }
>>   }
>> @@ -1428,10 +1428,13 @@ static int fuse_get_user_pages(struct 
>> fuse_args_pages *ap, struct iov_iter *ii,
>>       while (nbytes < *nbytesp && ap->num_pages < max_pages) {
>>           unsigned npages;
>>           size_t start;
>> -        ret = iov_iter_get_pages2(ii, &ap->pages[ap->num_pages],
>> -                    *nbytesp - nbytes,
>> -                    max_pages - ap->num_pages,
>> -                    &start);
>> +        struct page **pt_pages;
>> +
>> +        pt_pages = &ap->pages[ap->num_pages];
>> +        ret = iov_iter_extract_pages(ii, &pt_pages,
>> +                         *nbytesp - nbytes,
>> +                         max_pages - ap->num_pages,
>> +                         0, &start);
>>           if (ret < 0)
>>               break;
