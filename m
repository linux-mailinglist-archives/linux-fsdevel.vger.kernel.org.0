Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2D5262D75
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 12:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgIIKxr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 06:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgIIKxF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:53:05 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A25C061755;
        Wed,  9 Sep 2020 03:53:04 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e11so1566675wme.0;
        Wed, 09 Sep 2020 03:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dfzFNem1qjKFzwseXYy/N8oZsL5BSxf30wJagpVmz4I=;
        b=oxtvpQGcbdT0iWWLRVAmPlsnXNq8qwt4b31KURzs3l9dM3ScjImvQ6e9PS3KtrTMex
         +lUvIrYJSIqRzp5OM6IBc2DUxYnsH2yjd5gE4CtuZ+lsSiaqTKEbVGjBvpvvJOiG+1qy
         EoWn4yulrtxOtC6p75H6ojz2O9vGxg5pNwuQh8eToEELfuGqyJo5MiyZ6/ZLV1PiT6o7
         j2vNEzvRjs7GsTAFzGT2m4TKMRL4w4dcoCNZ9eRdP9RuN1zxTESrAuCRYYlWMmLX/biG
         oloLt3gi5nU2pHK1fjvhvU9J6mKMloAsTdnjkUL+7QgahxjYDO+pazuc6WbFHjLrNlSi
         6llA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dfzFNem1qjKFzwseXYy/N8oZsL5BSxf30wJagpVmz4I=;
        b=TVsGcBKg5ogc2+NBIhl/lEDW+aHjMumXnwZ3C/iz2hmNSFtkQ2KHu2N8r9qqARA/eN
         d7/OwwtUEuaPEuHNGTqt6M3vVxfq88VovbnHa0JpTPAtzkGG52oIFcjf40iaTXyXSWzK
         BpZeryONEtrshSaxnkSbWnkQSy7tyXBrxRmr1iCWVTZ+MPWm8vq/wX6Ara7W1y3Nn5d3
         UFnkfVFpeYJ60/RDq7a1AzOzlIa5TZwF2jyYrTunx1ctohOXL/R9sa4b+bW9Qp8Vn3Fu
         TpRhk5dddZ/+9qwlnF9cIGQ6r/KmjcHb2SUTf7GDQklAiBxQcZNLiBwX8vA2M5hDhXok
         8NZw==
X-Gm-Message-State: AOAM532EkwVSOapD6SAVe+Kfo5mGlCVCpeKL/lwTw3XNG7BROC0nsKdi
        wVTBu7mZuWZ6ikkZyYCBjgLE/Bq8QpE=
X-Google-Smtp-Source: ABdhPJyuLKz3S9bi/LWMlUTEEvMyeXdfv3neRGRP37fcULclorpAV7dtY859/xLpUGcnn9wOmI0ypA==
X-Received: by 2002:a1c:a385:: with SMTP id m127mr3125974wme.189.1599648783051;
        Wed, 09 Sep 2020 03:53:03 -0700 (PDT)
Received: from ?IPv6:2001:a61:2479:6801:d8fe:4132:9f23:7e8f? ([2001:a61:2479:6801:d8fe:4132:9f23:7e8f])
        by smtp.gmail.com with ESMTPSA id a15sm4039457wrn.3.2020.09.09.03.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 03:53:02 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, milan.opensource@gmail.com,
        lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fsync.2: ERRORS: add EIO and ENOSPC
To:     Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>
References: <1598685186-27499-1-git-send-email-milan.opensource@gmail.com>
 <CAKgNAkiTjtdaQxbCYS67+SdqSPaGzJnfLEEMFgcoXjHLDxgemw@mail.gmail.com>
 <20200908112742.GA2956@quack2.suse.cz>
 <e4f5ccb298170357ba16ae2870fde6a90ca2aa81.camel@kernel.org>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <42e29436-9efd-d864-9e95-d080d4a68cd6@gmail.com>
Date:   Wed, 9 Sep 2020 12:53:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e4f5ccb298170357ba16ae2870fde6a90ca2aa81.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Jeff,

On 9/8/20 9:44 PM, Jeff Layton wrote:
> On Tue, 2020-09-08 at 13:27 +0200, Jan Kara wrote:
>> Added Jeff to CC since he has written the code...
>>
>> On Mon 07-09-20 09:11:06, Michael Kerrisk (man-pages) wrote:
>>> [Widening the CC to include Andrew and linux-fsdevel@]
>>> [Milan: thanks for the patch, but it's unclear to me from your commit
>>> message how/if you verified the details.]
>>>
>>> Andrew, maybe you (or someone else) can comment, since long ago your
>>>
>>>     commit f79e2abb9bd452d97295f34376dedbec9686b986
>>>     Author: Andrew Morton <akpm@osdl.org>
>>>     Date:   Fri Mar 31 02:30:42 2006 -0800
>>>
>>> included a comment that is referred to in  stackoverflow discussion
>>> about this topic (that SO discussion is in turn referred to by
>>> https://bugzilla.kernel.org/show_bug.cgi?id=194757).
>>>
>>> The essence as I understand it, is this:
>>> (1) fsync() (and similar) may fail EIO or ENOSPC, at which point data
>>> has not been synced.
>>> (2) In this case, the EIO/ENOSPC setting is cleared so that...
>>> (3) A subsequent fsync() might return success, but...
>>> (4) That doesn't mean that the data in (1) landed on the disk.
>>
>> Correct.
>>
>>> The proposed manual page patch below wants to document this, but I'd
>>> be happy to have an FS-knowledgeable person comment before I apply.
>>
>> Just a small comment below:
>>
>>> On Sat, 29 Aug 2020 at 09:13, <milan.opensource@gmail.com> wrote:
>>>> From: Milan Shah <milan.opensource@gmail.com>
>>>>
>>>> This Fix addresses Bug 194757.
>>>> Ref: https://bugzilla.kernel.org/show_bug.cgi?id=194757
>>>> ---
>>>>  man2/fsync.2 | 13 +++++++++++++
>>>>  1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/man2/fsync.2 b/man2/fsync.2
>>>> index 96401cd..f38b3e4 100644
>>>> --- a/man2/fsync.2
>>>> +++ b/man2/fsync.2
>>>> @@ -186,6 +186,19 @@ In these cases disk caches need to be disabled using
>>>>  or
>>>>  .BR sdparm (8)
>>>>  to guarantee safe operation.
>>>> +
>>>> +When
>>>> +.BR fsync ()
>>>> +or
>>>> +.BR fdatasync ()
>>>> +returns
>>>> +.B EIO
>>>> +or
>>>> +.B ENOSPC
>>>> +any error flags on pages in the file mapping are cleared, so subsequent synchronisation attempts
>>>> +will return without error. It is
>>>> +.I not
>>>> +safe to retry synchronisation and assume that a non-error return means prior writes are now on disk.
>>>>  .SH SEE ALSO
>>>>  .BR sync (1),
>>>>  .BR bdflush (2),
>>
>> So the error state isn't really stored "on pages in the file mapping".
>> Current implementation (since 4.14) is that error state is stored in struct
>> file (I think this tends to be called "file description" in manpages) and
>> so EIO / ENOSPC is reported once for each file description of the file that
>> was open before the error happened. Not sure if we want to be so precise in
>> the manpages or if it just confuses people. Anyway your takeway that no
>> error on subsequent fsync() does not mean data was written is correct.
>>
>>
> 
> Thinking about it more, I think we ought to spell this out explicitly as
> we can in the manpage. This is a point of confusion for a lot of people
> and not understanding this can lead to data integrity bugs. Maybe
> something like this in the NOTES section?
> 
> '''
> When fsync returns an error, the file is considered to be "clean". A
> subsequent call to fsync will not result in a reattempt to write out the
> data, unless that data has been rewritten. Applications that want to
> reattempt writing to the file after a transient error must re-write
> their data.
> '''

Thanks. It's incredibly helpful when someone with the needed 
domain-specific knowledge suggest a wording!

> To be clear:
> 
> In practice, you'd only have to write enough to redirty each page in
> most cases.

Presumably, this could be accomplished by write(2)-ing exactly the
same user space buffers again?

So, I'd like to expand your text a little. How would the following 
be:

[[
When fsync() or fdatasync() returns an error, the file is considered
to be "clean", even though the corresponding modified ("dirty") buffer
cache pages may not have been flushed to the storage device. A
subsequent call to fsync() will not result in a reattempt to write out
the data, unless that data has in the meantime been rewritten.
Applications that want to reattempt writing to the file after a
transient error--for example, EIO and ENOSPC can occur because of
transient conditions--must rewrite their data.
]]

How is that text?

> Also, it is hard to claim that the above behavior is universally true. A
> filesystem could opt to keep the pages dirty for some errors, but the
> vast majority just toss out the data whenever there is a writeback
> problem.

I think I won't worry about trying to discuss such variations
in the manual page.

BTW, I added a loosely related question in a reply that I just 
sent to Jan. Maybe you have some thoughts there also.

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
