Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB948262D74
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 12:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgIIKxa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 06:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIIKww (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:52:52 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA76C061573;
        Wed,  9 Sep 2020 03:52:51 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s12so2404102wrw.11;
        Wed, 09 Sep 2020 03:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZZyuyJezz8SHcGWFoZpWJ+xq6FPT7TkCyePzeDBOWr0=;
        b=vBbs7HuiLAvD8E5es20v1RXv+wAAalrdyb3Rl0H37Ynte3jgtZlCKMoDAfoD9aigmu
         ZNw3EncBPicyc7VyjrA4G7Ex6zKag02fSkP4Ewf1yY7BWDW3/B3g4CEpfmcPMUAM2peN
         74cPifQ5HCVMfa++lejg/SnW5MKU2VP6wO8eXZtUbtc/ncrYXnVBazDOSYiyd71hr0s6
         DlvqFKjQobgAQEfMEeCn0Gdw1av2u0LMNHN2lOlN6ptazuyuhyI/mQADIZpN+brtVuCD
         00ub3h2T7+x3iP15OQcXj/c6NSokN3VPrLxDVmxUefH2nrxNgQMiY4OIy4h98BZfc2Bn
         qPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZZyuyJezz8SHcGWFoZpWJ+xq6FPT7TkCyePzeDBOWr0=;
        b=QoG/EAuKhMAApuzikr0JJ64hlh4Nbhplch/tDcWjoJ5ceIhVVt6sD637JLWfqINdzL
         pzM8t8RF8aHBCDUii8ZZqKOdR4jkqOvgEdS8rsc8/44cL+n/RGCSsVrccJ+PEJgfpw11
         Eo9rFXOoP6BN7WVWYV//FxKcpXkW966ueQv0fMin9sBapnxe/q6qNJbwcXm+XPbGWlKf
         pd41MyPh/HsY32mDupVihGgl+M61yCJNJ+9x0ctxVFMoJOABuWA4stSaygpJcbcRE7qY
         Shk1LXD/mAP9p2SSI3+aXh/d4XrrFlPxwyLuIrk0o4xWqRddsUVoS+ybvDgvVkH56LWA
         UFGA==
X-Gm-Message-State: AOAM532qh5yUs5CBKC5UjVVuCRvVmt2I3EKwrEEyI3SLxmfX5Nsq+I9b
        zqc/UGs6ljThi+D/bs9GK4U=
X-Google-Smtp-Source: ABdhPJwU3re1YrbF1YxxXcMCtzQ2EknmMTuJq0QtTA9wLqviZ1sLi7sgSIezuhzlw3wOInbI/W8r3Q==
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr3601916wru.180.1599648770131;
        Wed, 09 Sep 2020 03:52:50 -0700 (PDT)
Received: from ?IPv6:2001:a61:2479:6801:d8fe:4132:9f23:7e8f? ([2001:a61:2479:6801:d8fe:4132:9f23:7e8f])
        by smtp.gmail.com with ESMTPSA id o16sm3364278wrp.52.2020.09.09.03.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 03:52:49 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, milan.opensource@gmail.com,
        lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] fsync.2: ERRORS: add EIO and ENOSPC
To:     Jan Kara <jack@suse.cz>
References: <1598685186-27499-1-git-send-email-milan.opensource@gmail.com>
 <CAKgNAkiTjtdaQxbCYS67+SdqSPaGzJnfLEEMFgcoXjHLDxgemw@mail.gmail.com>
 <20200908112742.GA2956@quack2.suse.cz>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <7be61144-0e77-3c31-d720-f2cbe56bc81e@gmail.com>
Date:   Wed, 9 Sep 2020 12:52:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908112742.GA2956@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Jan,

Thank you for jumping in on this thread.

On 9/8/20 1:27 PM, Jan Kara wrote:
> Added Jeff to CC since he has written the code...
> 
> On Mon 07-09-20 09:11:06, Michael Kerrisk (man-pages) wrote:
>> [Widening the CC to include Andrew and linux-fsdevel@]
>> [Milan: thanks for the patch, but it's unclear to me from your commit
>> message how/if you verified the details.]
>>
>> Andrew, maybe you (or someone else) can comment, since long ago your
>>
>>     commit f79e2abb9bd452d97295f34376dedbec9686b986
>>     Author: Andrew Morton <akpm@osdl.org>
>>     Date:   Fri Mar 31 02:30:42 2006 -0800
>>
>> included a comment that is referred to in  stackoverflow discussion
>> about this topic (that SO discussion is in turn referred to by
>> https://bugzilla.kernel.org/show_bug.cgi?id=194757).
>>
>> The essence as I understand it, is this:
>> (1) fsync() (and similar) may fail EIO or ENOSPC, at which point data
>> has not been synced.
>> (2) In this case, the EIO/ENOSPC setting is cleared so that...
>> (3) A subsequent fsync() might return success, but...
>> (4) That doesn't mean that the data in (1) landed on the disk.
> 
> Correct.

Thanks for the confirmation!

>> The proposed manual page patch below wants to document this, but I'd
>> be happy to have an FS-knowledgeable person comment before I apply.
> 
> Just a small comment below:
> 
>> On Sat, 29 Aug 2020 at 09:13, <milan.opensource@gmail.com> wrote:
>>>
>>> From: Milan Shah <milan.opensource@gmail.com>
>>>
>>> This Fix addresses Bug 194757.
>>> Ref: https://bugzilla.kernel.org/show_bug.cgi?id=194757
>>> ---
>>>  man2/fsync.2 | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/man2/fsync.2 b/man2/fsync.2
>>> index 96401cd..f38b3e4 100644
>>> --- a/man2/fsync.2
>>> +++ b/man2/fsync.2
>>> @@ -186,6 +186,19 @@ In these cases disk caches need to be disabled using
>>>  or
>>>  .BR sdparm (8)
>>>  to guarantee safe operation.
>>> +
>>> +When
>>> +.BR fsync ()
>>> +or
>>> +.BR fdatasync ()
>>> +returns
>>> +.B EIO
>>> +or
>>> +.B ENOSPC
>>> +any error flags on pages in the file mapping are cleared, so subsequent synchronisation attempts
>>> +will return without error. It is
>>> +.I not
>>> +safe to retry synchronisation and assume that a non-error return means prior writes are now on disk.
>>>  .SH SEE ALSO
>>>  .BR sync (1),
>>>  .BR bdflush (2),
> 
> So the error state isn't really stored "on pages in the file mapping".
> Current implementation (since 4.14) is that error state is stored in struct
> file (I think this tends to be called "file description" in manpages) and

(Yes, "open file description" is the POSIX terminology for the thing that
sits between the FD and the inode--struct file in kernel parlance--and I
try to follow POSIX terminology in the manual pages where possible.

> so EIO / ENOSPC is reported once for each file description of the file that
> was open before the error happened. Not sure if we want to be so precise in
> the manpages or if it just confuses people. 

Well, people are confused now, so I think more detail would be good.

> Anyway your takeway that no
> error on subsequent fsync() does not mean data was written is correct.

Thanks. (See also my rply to Jeff.)

By the way, a question related to your comments above. In the 
errors section, there is this:

       EIO    An  error  occurred during synchronization.  This error may
              relate to data written to some other file descriptor on the
*             same  file.   Since Linux 4.13, errors from write-back will
              be reported to all file descriptors that might have written
              the  data  which  triggered  the  error.   Some filesystems
              (e.g., NFS) keep close track of  which  data  came  through
              which  file  descriptor,  and  give more precise reporting.
              Other  filesystems  (e.g.,  most  local  filesystems)  will
              report errors to all file descriptors that were open on the
*             file when the error was recorded.

In the marked (*) lines, we have the word "file". Is this accurate? I mean, I
would normally take "file" in this context to mean the inode ('struct inode').
But I wonder if really what is meant here is "open file description"
('struct file'). In other words, is the EIO being generated for all FDs 
connected to the same open file description, or for all FDs for all of the
open file descriptions connected to the inode? Your thoughts?

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
