Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5191887C5B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2019 16:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407024AbfHIOK1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 10:10:27 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39947 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfHIOK0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:10:26 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so75826876oth.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2019 07:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=sFzEgBCgJT493SaxnOb117IOl77QcgyD2XDCyFZJhjM=;
        b=XfAUru9PE7Is30K0L/F7RDQ/2lo9HY1lcGomf3bYb+tYQF1MnoxK0WWcV4qeTJRiHZ
         YzROcaOQuFgPhPLwGwsmlQrlrubUPvCGkgya2AsvNImaXRjffwE3l9m78Nw+3jObHV6X
         3komzoYtyhuUH1iWS7BuVndopr+AVKiEZej6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sFzEgBCgJT493SaxnOb117IOl77QcgyD2XDCyFZJhjM=;
        b=WGG2reYomJftc+2/7XnzsNwNDqm8uJwk6t9s969JAlK/MTadrWGwjI5LoyteJbQdGL
         SLV3tZ++8vmTbNzIyDLDBvuZGAvGXPHSZ1AmIoQUv+CFuXx16qle8z+258w0XMlP8cKA
         D4VR9kcGLOguAOZIAmR0qs0qt9jxQubRHdqtfso8Ospq97r5uEl6y9dY2EDtg8JfqGe0
         bhzvsqCPoyTMILQVtwio3aBgPte/noln7R84SWsMLfmr8w72V4PSutf8OTiVMBwNK+Fe
         8IdE1lmnIbvKHvcAXB9Tdtv3H5C1UQquifrxQfTzV3cnwaXK6+eX8ZtNtp5Re/fqJ9nl
         vAxA==
X-Gm-Message-State: APjAAAXDr1SlwBJ/KT25QE9FuwxMgCIG7lW8vJeax+rd0fEcrHt3nudd
        cyscGMkBXgvu45m3u53hB3KFjg==
X-Google-Smtp-Source: APXvYqwgq5ySQefqy4F02sXLhlwpuB89tEADOxixbbzYOUubknvpumY9VDJXBYwgGALGCSJdhYTNWg==
X-Received: by 2002:a5d:80cd:: with SMTP id h13mr21732104ior.259.1565359825460;
        Fri, 09 Aug 2019 07:10:25 -0700 (PDT)
Received: from [10.10.6.59] ([50.73.98.161])
        by smtp.googlemail.com with ESMTPSA id y5sm101732845ioc.86.2019.08.09.07.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 07:10:25 -0700 (PDT)
Subject: Re: [PATCH] udf: reduce leakage of blocks related to named streams
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, Steve Magnani <steve@digidescorp.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190807133258.12432-1-steve@digidescorp.com>
 <20190809130527.GD17568@quack2.suse.cz>
From:   Steve Magnani <steve.magnani@digidescorp.com>
Message-ID: <83cf0e5e-2695-8748-9269-6e4d01114285@digidescorp.com>
Date:   Fri, 9 Aug 2019 09:10:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190809130527.GD17568@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan -

Thanks for the feedback.

On 8/9/19 8:05 AM, Jan Kara wrote:
> On Wed 07-08-19 08:32:58,  Steven J. Magnani  wrote:
>> From: Steve Magnani <steve@digidescorp.com>
>>
>> Windows is capable of creating UDF files having named streams.
>> One example is the "Zone.Identifier" stream attached automatically
>> to files downloaded from a network. See:
>>    https://msdn.microsoft.com/en-us/library/dn392609.aspx
>>
>> Modification of a file having one or more named streams in Linux causes
>> the stream directory to become detached from the file, essentially leaking
>> all blocks pertaining to the file's streams. Worse, an attempt to delete
>> the file causes its directory entry (FID) to be deleted, but because the
>> driver believes that a hard link to the file remains, the Extended File
>> Entry (EFE) and all extents of the file itself remain allocated. Since
>> there is no hard link, after the FID has been deleted all of these blocks
>> are unreachable (leaked).
>>
>> ...
>>
>> For this case, this partial solution reduces the number of blocks leaked
>> during file deletion to just one (the EFE containing the stream data).
>>
>>
> Thanks for the patch! I was thinking about this and rather than this
> partial fix, I'd prefer to fail the last unlink of an inode with
> a named-stream directory with EOPNOTSUPP. Later we can properly handle this
> and walk the named-stream directory and remove all associated EFEs for the
> named streams. After all named-stream directories are restricted to not
> have any subdirectories, hardlinks, or anything similarly fancy so the walk
> should not be *that* hard to implement.
>
Maybe not but it's more work than I am able to take on anytime soon.
Absent a complete solution, how to handle this is a judgement call.
Since Windows seems to attach a Zone.Identifier stream to _all_ files
downloaded from a network, and since interchange between Windows and Linux
via USB Mass Storage is a somewhat common (or at least desirable) use case
for UDF, this issue seemed fairly serious from a user perspective. Leaking
all the blocks of a file on delete is pretty bad. Leaking a single block is
still bad, but much less so. One could argue that prohibiting deletion of
files with named streams is nearly as bad as leaking all the blocks - in
both cases, within Linux, none of the file's blocks can be reused.
That's pretty limiting for users. It's too limiting for my use cases.

------------------------------------------------------------------------
Steven J. Magnani               "I claim this network for MARS!
www.digidescorp.com              Earthling, return my space modulator!"

#include <standard.disclaimer>

