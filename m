Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A91C2F5F25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 11:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbhANKoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jan 2021 05:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbhANKoW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:44:22 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80712C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jan 2021 02:43:41 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 190so4104701wmz.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jan 2021 02:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EY/OBeJen7sdgCW1BZgBQtPwEY/HgrmWptbvaLexLNI=;
        b=ljRJP4KqAApPR4HSu8r4oFmFSwyLGkMy5UZ896nNaRgzci+1TvF6+2tuDYX26a5ff2
         oqJCw4HXaVjUK9oo6O6SR3Deqba+vJV35y1nx4mQXMBo04WydEKP1EniQ9bB65EAIMu0
         OvFexBS/TPpOKvB6Ei1vH889X3Ai1bqamjy2jz5Y2LvGYmBRynQztBnC/LH3yc5Sq6+I
         UClRZ9IuMWG6qJjVEcqNHOOZK1ehCJCZALm5hhitUML80apZPx4izhpajWH+1581+q+j
         8eFBioCHPAEXpE4GUH27cRS1JDpcOYMKIvfVQbaPWkvG1DhHxtxuqFWkQJvCW88yeHzB
         MX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EY/OBeJen7sdgCW1BZgBQtPwEY/HgrmWptbvaLexLNI=;
        b=XeqpkDqpaF29p/1BwVDQSk7CeVLS21tpf32pjmcvMyg+LjIPhbLjfgle8oCDLWd7W9
         btb6nFz2exQUWUWw2X33BCyolrmLj51uNt3SWpcbyaAbrVBHQ5KPprV77MP5/lIhGnHR
         gsx5jkJp+PvawKioyqrrdzaeKG0jO0HLrCS9/i8ENtTw3vPLT0z96UAaaFPXy4USyLAe
         VTFgsw+MrwFwV7U6n3Gfay8Pmfj4c/Wi4HMTNo0Cam1TN4ps7O20OrML8/NIyy/E6LFz
         5tYDg1YFuGm7ywHJXAoCMv2RjSjdU69cDosaRy38ZPsMHt6y1+Mp880QixN9OcFTg089
         eGyg==
X-Gm-Message-State: AOAM532zZOV1HkepJa0PRubB6pYwABX/ZFjZ8oHrWTGS5UIKPboYKbTa
        LvuvxgZ+3R0v35Hp4dwC7DRC1g==
X-Google-Smtp-Source: ABdhPJyzyXFqFrH6mL1HYTp2X0sHFK6uOtvOrwN12p732Z1aOSYGSuYZMXgT7lB0JekGUYfdVqagdg==
X-Received: by 2002:a7b:c415:: with SMTP id k21mr1239903wmi.96.1610621020123;
        Thu, 14 Jan 2021 02:43:40 -0800 (PST)
Received: from tmp.scylladb.com (bzq-79-182-3-66.red.bezeqint.net. [79.182.3.66])
        by smtp.googlemail.com with ESMTPSA id l11sm8467243wrt.23.2021.01.14.02.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 02:43:39 -0800 (PST)
Subject: Re: [PATCH 09/10] iomap: add a IOMAP_DIO_NOALLOC flag
To:     Brian Foster <bfoster@redhat.com>,
        Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210112162616.2003366-1-hch@lst.de>
 <20210112162616.2003366-10-hch@lst.de>
 <20210112232923.GD331610@dread.disaster.area>
 <20210113153215.GA1284163@bfoster>
 <20210113224935.GJ331610@dread.disaster.area>
 <20210114102347.GD1333929@bfoster>
From:   Avi Kivity <avi@scylladb.com>
Message-ID: <8ed44546-e5bd-dd60-a16b-ab185de3d5b9@scylladb.com>
Date:   Thu, 14 Jan 2021 12:43:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210114102347.GD1333929@bfoster>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/14/21 12:23 PM, Brian Foster wrote:
> On Thu, Jan 14, 2021 at 09:49:35AM +1100, Dave Chinner wrote:
>> On Wed, Jan 13, 2021 at 10:32:15AM -0500, Brian Foster wrote:
>>> On Wed, Jan 13, 2021 at 10:29:23AM +1100, Dave Chinner wrote:
>>>> On Tue, Jan 12, 2021 at 05:26:15PM +0100, Christoph Hellwig wrote:
>>>>> Add a flag to request that the iomap instances do not allocate blocks
>>>>> by translating it to another new IOMAP_NOALLOC flag.
>>>> Except "no allocation" that is not what XFS needs for concurrent
>>>> sub-block DIO.
>>>>
>>>> We are trying to avoid external sub-block IO outside the range of
>>>> the user data IO (COW, sub-block zeroing, etc) so that we don't
>>>> trash adjacent sub-block IO in flight. This means we can't do
>>>> sub-block zeroing and that then means we can't map unwritten extents
>>>> or allocate new extents for the sub-block IO.  It also means the IO
>>>> range cannot span EOF because that triggers unconditional sub-block
>>>> zeroing in iomap_dio_rw_actor().
>>>>
>>>> And because we may have to map multiple extents to fully span an IO
>>>> range, we have to guarantee that subsequent extents for the IO are
>>>> also written otherwise we have a partial write abort case. Hence we
>>>> have single extent limitations as well.
>>>>
>>>> So "no allocation" really doesn't describe what we want this flag to
>>>> at all.
>>>>
>>>> If we're going to use a flag for this specific functionality, let's
>>>> call it what it is: IOMAP_DIO_UNALIGNED/IOMAP_UNALIGNED and do two
>>>> things with it.
>>>>
>>>> 	1. Make unaligned IO a formal part of the iomap_dio_rw()
>>>> 	behaviour so it can do the common checks to for things that
>>>> 	need exclusive serialisation for unaligned IO (i.e. avoid IO
>>>> 	spanning EOF, abort if there are cached pages over the
>>>> 	range, etc).
>>>>
>>>> 	2. require the filesystem mapping callback do only allow
>>>> 	unaligned IO into ranges that are contiguous and don't
>>>> 	require mapping state changes or sub-block zeroing to be
>>>> 	performed during the sub-block IO.
>>>>
>>>>
>>> Something I hadn't thought about before is whether applications might
>>> depend on current unaligned dio serialization for coherency and thus
>>> break if the kernel suddenly allows concurrent unaligned dio to pass
>>> through. Should this be something that is explicitly requested by
>>> userspace?
>> If applications are relying on an undocumented, implementation
>> specific behaviour of a filesystem that only occurs for IOs of a
>> certain size for implicit data coherency between independent,
>> non-overlapping DIOs and/or page cache IO, then they are already
>> broken and need fixing because that behaviour is not guaranteed to
>> occur. e.g. 512 byte block size filesystem does not provide such
>> serialisation, so if the app depends on 512 byte DIOs being
>> serialised completely by the filesytem then it already fails on 512
>> byte block size filesystems.
>>
> I'm not sure how the block size relates beyond just changing the
> alignment requirements..?
>
>> So, no, we simply don't care about breaking broken applications that
>> are already broken.
>>
> I agree in general, but I'm not sure that helps us on the "don't break
> userspace" front. We can call userspace broken all we want, but if some
> application has such a workload that historically functions correctly
> due to this serialization and all of a sudden starts to cause data
> corruption because we decide to remove it, I fear we'd end up taking the
> blame regardless. :/


I think it's unlikely. Application writers rarely know about such 
issues, so they can't knowingly depend on them. The sub-sub-genre of 
application writers who rely on dio/aio will be a lot more careful and 
wary of the filesystem.


In this particular case, triggering serialization also triggers blocking 
in io_submit, which is the aio/dio user's worst nightmare, by several 
orders of magnitude than the runner up. I have code to detect these 
cases and try to prevent serialization, or, when serialization is 
inevitable, do the serialization in userspace so my io_submits don't get 
blocked.



