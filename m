Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA1120FDE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 22:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbgF3Uog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 16:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbgF3Uog (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:44:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DE2C061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2020 13:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=kcuGVu3dWRulN2Ruib0VL7Gzj1OWqUiXn1HW3UNZi4c=; b=cYNHBB3ynDSnCOv1FdIYqJwIWR
        tBIXxNso2zMMvJsTi35L1OJlnixO2sqtzENpgeU131wNq+Apt0kKFx6BdUvasGIS29digHv51BzS9
        rACTN4hCtS2yyLyH0+Y6aU7zipOXLrhKm7bDDFnGeBtXoW6tCIR0+NAHm+GguJywAFcPCVCE2IccQ
        33EnFl1A0qxgL9IP02N15Vn5nvKh2RpF5R4t3c7e8iGI94BCC0i8KBFsDoMY41xb1eWomtshX71E6
        Kdu4BavDQj1LNiWdxcOVbKpadALrGiaqEqlhcseSoqgdefp5Rm0pkXmubxhoqLIRyX4dcphr6EKsz
        ya3enmPg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqN7C-0006QA-8w; Tue, 30 Jun 2020 20:44:26 +0000
Subject: Re: [PATCH] f2fs: always expose label 'next_page'
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
References: <020937f3-2947-ca41-c18a-026782216711@infradead.org>
 <20200630202357.GA1396584@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1be18397-7fc6-703e-121b-e210e101357f@infradead.org>
Date:   Tue, 30 Jun 2020 13:44:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630202357.GA1396584@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/30/20 1:23 PM, Jaegeuk Kim wrote:
> On 06/30, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix build error when F2FS_FS_COMPRESSION is not set/enabled.
>> This label is needed in either case.
>>
>> ../fs/f2fs/data.c: In function ‘f2fs_mpage_readpages’:
>> ../fs/f2fs/data.c:2327:5: error: label ‘next_page’ used but not defined
>>      goto next_page;
> 
> Thank you for the fix. This was actually introduced by the recent testing patch.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=ff963ad2bf54460431f517b5cae473997a29bf2a
> 
> If you don't mind, please let me integrate this into the original patch.
> Let me know.

Sure, no problem.

> Thanks,
> 
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Cc: Chao Yu <yuchao0@huawei.com>
>> Cc: linux-f2fs-devel@lists.sourceforge.net
>> ---
>>  fs/f2fs/data.c |    2 --
>>  1 file changed, 2 deletions(-)
>>
>> --- linux-next-20200630.orig/fs/f2fs/data.c
>> +++ linux-next-20200630/fs/f2fs/data.c
>> @@ -2366,9 +2366,7 @@ set_error_page:
>>  			zero_user_segment(page, 0, PAGE_SIZE);
>>  			unlock_page(page);
>>  		}
>> -#ifdef CONFIG_F2FS_FS_COMPRESSION
>>  next_page:
>> -#endif
>>  		if (rac)
>>  			put_page(page);
>>  


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
