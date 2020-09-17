Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8675B26D414
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 09:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgIQHBe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 03:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgIQHBQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:01:16 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3190EC06174A;
        Thu, 17 Sep 2020 00:01:16 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so840906wmh.4;
        Thu, 17 Sep 2020 00:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tfD26LMyhgpotnYrwG+fpASFKdva0Ki40Uu2hWWrybc=;
        b=s67WhDDWl7+mVfYvSBsuyAP2t007InxSyYECBYeGO9wlN8ganVhA2E8WHP49036kos
         iXbXRW89EYgHP3MeXXXssQt5pv+nmr6Sa+Lr+nQTE/N9d54DQp1PS30QcngflAYBK/vq
         46iFl3M8cbNOBr9yPIa9x/IzcOBXJo16CaVkvBKQROynrvusrJHyZJYitX3IZcYr41ra
         dbOzqJp+367ZEwwZsWJxep2YnoSpuv0RKToYAZOqBIfupmZzrbkC4f0YCFEGj69E0l6X
         50StUQ28PZCVwSrME5Odu/X8/ZEXP1aPLZYU/hH42jxzb2gi1ZROwBKVC2FTu6sNzYHt
         7n8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tfD26LMyhgpotnYrwG+fpASFKdva0Ki40Uu2hWWrybc=;
        b=g+32DBdV7nuGZscoJLbvXKkfbEz9rpcdJMm+tf20Tz0vijXtZroLIioXwbhLafzb2o
         kf4By5YcaBtv+gcfsh707jK7q7qcmHJGHp9xtfDHSpwMXdcFIJL4cjEq5+heMaVkGbp/
         67z+eGE1+GuT2sWTCfAI1MXcvhVmmwsF48XFhI8QNGHRUX/5l7FEZI8+6rMVTfVM6a3K
         /U/nxsG1yvDZVn4oYLko2MobQk4iipk6+oZxbL7vkehBcxZ7RenQkmHo7hFG78C7NrY1
         dMRhr2vxDGCKXTDHozSDsJTkUBgHJc8Rr2HnfDFBB99OTz9ru7daDLf1chEx5sx9Lv33
         /LeQ==
X-Gm-Message-State: AOAM530ebJb3Z4xmNyOKc5hs/Qq0MdeQxUsxV3WTRNq5y1Vxu2elINhQ
        HGIjBPyFaSviF7v8lBgsjSZyKKrlKhU=
X-Google-Smtp-Source: ABdhPJyKAmmGh8jPCDGDtftWtnxw52J7lkM+btm9a7fla/NV2Fui/UL+Qn+adUSFuXmnE4cp5ISg3w==
X-Received: by 2002:a1c:4303:: with SMTP id q3mr8341691wma.158.1600326074533;
        Thu, 17 Sep 2020 00:01:14 -0700 (PDT)
Received: from ?IPv6:2001:a61:2479:6801:d8fe:4132:9f23:7e8f? ([2001:a61:2479:6801:d8fe:4132:9f23:7e8f])
        by smtp.gmail.com with ESMTPSA id c25sm9177701wml.31.2020.09.17.00.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 00:01:13 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, milan.opensource@gmail.com,
        lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fsync.2: ERRORS: add EIO and ENOSPC
To:     NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Jan Kara <jack@suse.cz>
References: <1598685186-27499-1-git-send-email-milan.opensource@gmail.com>
 <CAKgNAkiTjtdaQxbCYS67+SdqSPaGzJnfLEEMFgcoXjHLDxgemw@mail.gmail.com>
 <20200908112742.GA2956@quack2.suse.cz>
 <e4f5ccb298170357ba16ae2870fde6a90ca2aa81.camel@kernel.org>
 <87k0x2k0wn.fsf@notabene.neil.brown.name>
 <8842543f4c929f7004cf356224230516a7fe2fb7.camel@kernel.org>
 <87sgbhi9sf.fsf@notabene.neil.brown.name>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <20f8c520-49e2-142b-df75-4980a76f3c38@gmail.com>
Date:   Thu, 17 Sep 2020 09:01:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87sgbhi9sf.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/17/20 1:25 AM, NeilBrown wrote:
> On Thu, Sep 10 2020, Jeff Layton wrote:
>>
>>> Regarding your "NOTES" addition, I don't feel comfortable with the
>>> "clean" language.  I would prefer something like:
>>>
>>>  When fsync() reports a failure (EIO, ENOSPC, EDQUOT) it must be assumed
>>>  that any write requests initiated since the previous successful fsync
>>>  was initiated may have failed, and that any cached data may have been
>>>  lost.  A future fsync() will not attempt to write out the same data
>>>  again.  If recovery is possible and desired, the application must
>>>  repeat all the writes that may have failed.
>>>
>>>  If the regions of a file that were written to prior to a failed fsync()
>>>  are read, the content reported may not reflect the stored content, and
>>>  subsequent reads may revert to the stored content at any time.
>>>
>>
>> Much nicer.
> 
> I guess someone should turn it into a patch....

That woud be great.

>> Should we make a distinction between usage and functional classes of
>> errors in this? The "usage" errors will probably not result in the pages
>> being tossed out, but the functional ones almost certainly will...
> 
> Maybe.  I think it is a useful distinction, but to be consistent it
> would be best to make it in all (section 2) man pages.  Maybe not all at
> once though.  It is really up to Michael if that is a direction he is
> interesting in following.

I think it's useful, and I'd accept patches that make such
distinctions. Of course, if we said *everything* should get fixed
at the same time, nothing would get fixed :-). So, I think
I'd just take individual patches that made such changes on an
ad hoc basis.

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
