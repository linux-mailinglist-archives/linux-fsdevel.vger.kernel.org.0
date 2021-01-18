Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DC12F9AB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 08:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732980AbhARHmm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 02:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730272AbhARHme (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 02:42:34 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53FEC061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Jan 2021 23:41:53 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id u14so8688589wmq.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Jan 2021 23:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=84dQpBdUvbIU1uNKQMOyaKOFiyJs/52YsIkFh9uvJ+Y=;
        b=O5BFpyPzwQd7fsJtJNdf2tQRv/ZVUh/UBwqTnQAv3z6TZHvO5vA+fZfmOapJzhyn7t
         cXUL0RoPzEEKD+gh0AQ9QcnkU5Spk+Gmgny/9qv0KbZ+rc+NI8XEJb1IH/1wEIWnvIzH
         EaHIe4Mvn2lPczFbod3V+WmyT/z/GHK0PNkBYjIXXXBcZnEShmSMHiCA3iS1Mb4+U9uM
         s6msVYYfzwQZq/CEGcRxWwuu2Rmi7dRIHAMv9zorZkzXxl9i+rHCcTssKJoHAdM5mXyz
         EKgMgl66cBuhKs0nVHZv5E0hVwsUhF97NBbORZcpFX2DuwbSAF/ade0VmzPSJnlpfjHY
         IFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=84dQpBdUvbIU1uNKQMOyaKOFiyJs/52YsIkFh9uvJ+Y=;
        b=Yf0H/uqDQRTddmrU2wgGlJj/ZDNLsOrhGAeNj9HdFXmnm3NglioFfyhw5leP8cD0xB
         BbXQiDpB1PxLKHTTeRYRy9Oswt0URgl9QCUj1wlUTZ8n+QPIm+LCPTz8Nub7zHAM7tJv
         bN3pCcgcrarCxc33rPr7IPtSkAnnhcCDXPjqmqn302aqJVTABQwPIEa1qP+1xyZRGR8w
         R/DvE/ds8JkiQ/B3Tv3F2NNOVS1kKmgIhc41dvb7pl7uJJMItf3AlaD/q0Ys27ixwjJb
         M04680/X0nJQCXRO6Hu2qd0pqc2QeC6HLE1cKs3VzQhw+cn0DNULXbliDzpeWyOt4jVi
         CHCw==
X-Gm-Message-State: AOAM5311LfgALyPmqZX5/9ok1ySxDzv9ed8IQb/uIRE3WBz2oyLqzDyK
        mKTrngBr0sS1yBf7UxxUdWOqaktryS8cxg==
X-Google-Smtp-Source: ABdhPJz4WbmpfxQu29FsmDFc4bQeHOvi1sibHHrLgyfJ3N5TghOxZtvsv3pOyjJRpCr80KVyt/UbZw==
X-Received: by 2002:a7b:c5d6:: with SMTP id n22mr18784934wmk.70.1610955712600;
        Sun, 17 Jan 2021 23:41:52 -0800 (PST)
Received: from tmp.scylladb.com (bzq-79-182-3-66.red.bezeqint.net. [79.182.3.66])
        by smtp.googlemail.com with ESMTPSA id w4sm23953270wmc.13.2021.01.17.23.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jan 2021 23:41:51 -0800 (PST)
Subject: Re: [RFC] xfs: reduce sub-block DIO serialisation
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        andres@anarazel.de
References: <20210112010746.1154363-1-david@fromorbit.com>
 <32f99253-fe56-9198-e47c-7eb0e24fdf73@scylladb.com>
 <20210112221324.GU331610@dread.disaster.area>
 <0f0706f9-92ab-6b38-f3ab-b91aaf4343d1@scylladb.com>
 <20210113203809.GF331610@dread.disaster.area>
 <50362fc8-3d5e-cd93-4e55-f3ecddc21780@scylladb.com>
 <20210117213401.GB78941@dread.disaster.area>
From:   Avi Kivity <avi@scylladb.com>
Message-ID: <c6f25213-233e-3f0e-a6c9-f5e2d5122c34@scylladb.com>
Date:   Mon, 18 Jan 2021 09:41:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210117213401.GB78941@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/17/21 11:34 PM, Dave Chinner wrote:
> On Thu, Jan 14, 2021 at 08:48:36AM +0200, Avi Kivity wrote:
>> On 1/13/21 10:38 PM, Dave Chinner wrote:
>>> On Wed, Jan 13, 2021 at 10:00:37AM +0200, Avi Kivity wrote:
>>>> On 1/13/21 12:13 AM, Dave Chinner wrote:
>>>>> On Tue, Jan 12, 2021 at 10:01:35AM +0200, Avi Kivity wrote:
>>>>>> On 1/12/21 3:07 AM, Dave Chinner wrote:
>>>>>>> Hi folks,
>>>>>>>
>>>>>>> This is the XFS implementation on the sub-block DIO optimisations
>>>>>>> for written extents that I've mentioned on #xfs and a couple of
>>>>>>> times now on the XFS mailing list.
>>>>>>>
>>>>>>> It takes the approach of using the IOMAP_NOWAIT non-blocking
>>>>>>> IO submission infrastructure to optimistically dispatch sub-block
>>>>>>> DIO without exclusive locking. If the extent mapping callback
>>>>>>> decides that it can't do the unaligned IO without extent
>>>>>>> manipulation, sub-block zeroing, blocking or splitting the IO into
>>>>>>> multiple parts, it aborts the IO with -EAGAIN. This allows the high
>>>>>>> level filesystem code to then take exclusive locks and resubmit the
>>>>>>> IO once it has guaranteed no other IO is in progress on the inode
>>>>>>> (the current implementation).
>>>>>> Can you expand on the no-splitting requirement? Does it involve only
>>>>>> splitting by XFS (IO spans >1 extents) or lower layers (RAID)?
>>>>> XFS only.
>>>> Ok, that is somewhat under control as I can provide an extent hint, and wish
>>>> really hard that the filesystem isn't fragmented.
>>>>
>>>>
>>>>>> The reason I'm concerned is that it's the constraint that the application
>>>>>> has least control over. I guess I could use RWF_NOWAIT to avoid blocking my
>>>>>> main thread (but last time I tried I'd get occasional EIOs that frightened
>>>>>> me off that).
>>>>> Spurious EIO from RWF_NOWAIT is a bug that needs to be fixed. DO you
>>>>> have any details?
>>>>>
>>>> I reported it in [1]. It's long since gone since I disabled RWF_NOWAIT. It
>>>> was relatively rare, sometimes happening in continuous integration runs that
>>>> take hours, and sometimes not.
>>>>
>>>>
>>>> I expect it's fixed by now since io_uring relies on it. Maybe I should turn
>>>> it on for kernels > some_random_version.
>>>>
>>>>
>>>> [1] https://lore.kernel.org/lkml/9bab0f40-5748-f147-efeb-5aac4fd44533@scylladb.com/t/#u
>>> Yeah, as I thought. Usage of REQ_NOWAIT with filesystem based IO is
>>> simply broken - it causes spurious IO failures to be reported to IO
>>> completion callbacks and so are very difficult to track and/or
>>> retry. iomap does not use REQ_NOWAIT at all, so you should not ever
>>> see this from XFS or ext4 DIO anymore...
>> What kernel version would be good?
> For ext4? >= 5.5 was when it was converted to the iomap DIO path
> should be safe.  Before taht it would use the old DIO path which
> sets REQ_NOWAIT when IOCB_NOWAIT (i.e. RWF_NOWAIT) was set for the
> IO.
>
> Btrfs is an even more recent convert to iomap-based dio (5.9?).
>
> The REQ_NOWAIT behaviour was introduced into the old DIO path back
> in 4.13 by commit 03a07c92a9ed ("block: return on congested block
> device") and was intended to support RWF_NOWAIT on raw block
> devices.  Hence it was not added to the iomap path as block devices
> don't use that path.
>
> Other examples of how REQ_NOWAIT breaks filesystems was a io_uring
> hack to force REQ_NOWAIT IO behaviour through filesystems via
> "nowait block plugs" resulted in XFS filesystem shutdowns because
> of unexpected IO errors during journal writes:
>
> https://lore.kernel.org/linux-xfs/20200915113327.GA1554921@bfoster/
>
> There have been patches proposed to add REQ_NOWAIT to the iomap DIO
> code proporsed, but they've all been NACKed because of the fact it
> will break filesystem-based RWF_NOWAIT DIO.
>
> So, long story short: On XFS you are fine on all kernels. On all
> other block based filesystems you need <4.13, except for ext4 where
>> = 5.5 and btrfs where >=5.9 will work correctly.


My report mentions XFS though it was so long ago I'm willing to treat it 
as measurement error. I'll incorporate these numbers into the code, and 
we'll see. Luckily I was already forced to have filesystem specific code 
so the ugliness is already there.



