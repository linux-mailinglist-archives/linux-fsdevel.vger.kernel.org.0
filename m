Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D55025AB45
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 14:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIBMmi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 08:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBMm3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 08:42:29 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C84CC061245
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2020 05:42:29 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w12so4028252qki.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2020 05:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ibS/trvmC9+9z41eWyWgg2wUkahI11F2KxUqHfU5fN8=;
        b=vAIRifnPiRLEH4hbbfTd/VNrRD+Ba03/ZvylItURpRkshtvM0QV4AehL6rdfAH4fDG
         spF+V+mw1LjOk1Ty0jMna2ja0l2izuUznd71aDUHTnFzO3qWfIqWOHcbwLoSiRUVBEqn
         1nMDWh5jR2I+g22wmCElQV3NPLk4uYtQTvwSaFWY164hWBzuJ2UoKJ7FwCPd3k7Pnq7X
         5su21JN7mIBOdVQKEYXweK6IQva3/voVaNOrvYZrv+EJ+P0ePkISLLTYNdFDCyau7dBd
         qxl5Madme/sI8v7MpgPu+TTqm48Fb8AWMq7k9gK1FRwTuHJtkG1TqnDYSewkYDN5p3O+
         nnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ibS/trvmC9+9z41eWyWgg2wUkahI11F2KxUqHfU5fN8=;
        b=pa9zf19fqJsbKJ7tezSB6VO2MIOdblweKPcya1bQbs5sRrnXMnis7rVRwAD1qHjfdk
         cMVQM/1cQvoq6LZGZIT+3E0saN4SeOdN3XrtrNKTyk/9QwN6XO1UrBPspXdTbJIfrNes
         ezxL509piuuAwlB/YMJHnPfy/hLxmPGU61/YqWK6D0Wvp3E5cb33tUPcUJ54FHTVNU0q
         I9y6AcaUWz86qIMlIO8eZuYr5aCS3PngmoEgVdkPzjsmi2nsR7xpL3fzOstDfIJlr+1I
         lX30h4KmQq/W0h1qnxfFxv/Z0p0e5pYhFtLR7ENChtPBd7AnwtuiM/lJoyRjetcs6Org
         huxA==
X-Gm-Message-State: AOAM532yazjBNiwFQE5uqe07jOyyIoeP411YDliFmzu5/eNf9PSXdoR3
        SmcrPKUQtL0MBBvbWSFtsok2JE8WTyRIrXRx9fk=
X-Google-Smtp-Source: ABdhPJztD0GguTkCleL+u4i36XrmkUuYV88LRV89HcyMzhBiWP6G/m4krTK7g5QjpNs5f3Sin2RZAg==
X-Received: by 2002:a05:620a:2015:: with SMTP id c21mr2213209qka.277.1599050548083;
        Wed, 02 Sep 2020 05:42:28 -0700 (PDT)
Received: from [192.168.1.210] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k6sm3934515qti.23.2020.09.02.05.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 05:42:27 -0700 (PDT)
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
To:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com>
 <42efa646-73cd-d884-1c9c-dd889294bde2@toxicpanda.com>
 <20200901214613.GH12096@dread.disaster.area>
 <551b2801-d626-9bd7-7cb2-9d20674c06bf@toxicpanda.com>
 <20200901235830.GI12096@dread.disaster.area>
 <20200902114414.GX14765@casper.infradead.org>
 <20200902122008.GK12096@dread.disaster.area>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <424119cd-08ca-8621-5e50-d52e0349a1f5@toxicpanda.com>
Date:   Wed, 2 Sep 2020 08:42:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902122008.GK12096@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/2/20 8:20 AM, Dave Chinner wrote:
> On Wed, Sep 02, 2020 at 12:44:14PM +0100, Matthew Wilcox wrote:
>> On Wed, Sep 02, 2020 at 09:58:30AM +1000, Dave Chinner wrote:
>>> Put simply: converting a filesystem to use iomap is not a "change
>>> the filesystem interfacing code and it will work" modification.  We
>>> ask that filesystems are modified to conform to the iomap IO
>>> exclusion model; adding special cases for every potential
>>> locking and mapping quirk every different filesystem has is part of
>>> what turned the old direct IO code into an unmaintainable nightmare.
>>>
>>>> That's fine, but this is kind of a bad way to find
>>>> out.  We really shouldn't have generic helper's that have different generic
>>>> locking rules based on which file system uses them.
>>>
>>> We certainly can change the rules for new infrastructure. Indeed, we
>>> had to change the rules to support DAX.  The whole point of the
>>> iomap infrastructure was that it enabled us to use code that already
>>> worked for DAX (the XFS code) in multiple filesystems. And as people
>>> have realised that the DIO via iomap is much faster than the old DIO
>>> code and is a much more efficient way of doing large buffered IO,
>>> other filesystems have started to use it.
>>>
>>> However....
>>>
>>>> Because then we end up
>>>> with situations like this, where suddenly we're having to come up with some
>>>> weird solution because the generic thing only works for a subset of file
>>>> systems.  Thanks,
>>>
>>> .... we've always said "you need to change the filesystem code to
>>> use iomap". This is simply a reflection on the fact that iomap has
>>> different rules and constraints to the old code and so it's not a
>>> direct plug in replacement. There are no short cuts here...
>>
>> Can you point me (and I suspect Josef!) towards the documentation of the
>> locking model?  I was hoping to find Documentation/filesystems/iomap.rst
>> but all the 'iomap' strings in Documentation/ refer to pci_iomap and
>> similar, except for this in the DAX documentation:
> 
> There's no locking model documentation because there is no locking
> in the iomap direct IO code. The filesystem defines and does all the
> locking, so there's pretty much nothing to document for iomap.
> 
> IOWs, the only thing iomap_dio_rw requires is that the IO completion
> paths do not take same locks that the IO submission path
> requires. And that's because:
> 
> /*
>   * iomap_dio_rw() always completes O_[D]SYNC writes regardless of whether the IO
>   * is being issued as AIO or not. [...]
> 
> So you obviously can't sit waiting for dio completion in
> iomap_dio_rw() while holding the submission lock if completion
> requires the submission lock to make progress.
> 
> FWIW, iomap_dio_rw() originally required the inode_lock() to be held
> and contained a lockdep assert to verify this, but....
> 
> commit 3ad99bec6e82e32fa9faf2f84e74b134586b46f7
> Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Date:   Sat Nov 30 09:59:25 2019 -0600
> 
>      iomap: remove lockdep_assert_held()
>      
>      Filesystems such as btrfs can perform direct I/O without holding the
>      inode->i_rwsem in some of the cases like writing within i_size.  So,
>      remove the check for lockdep_assert_held() in iomap_dio_rw().
>      
>      Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
>      Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
>      Signed-off-by: David Sterba <dsterba@suse.com>
> 
> ... btrfs has special corner cases for direct IO locking and hence
> we removed the lockdep assert....
> 
> IOWs, iomap_dio_rw() really does not care what strategy filesystems
> use to serialise DIO against other operations.  Filesystems can use
> whatever IO serialisation mechanism they want (mutex, rwsem, range
> locks, etc) as long as they obey the one simple requirement: do not
> take the DIO submission lock in the DIO completion path.
> 

Goldwyn has been working on these patches for a long time, and is 
actually familiar with this code, and he missed that these two 
interfaces are being mixed.  This is a problem that I want to solve.  He 
didn't notice it in any of his testing, which IIRC was like 6 months to 
get this stuff actually into the btrfs tree.  If we're going to mix 
interfaces then it should be blatantly obvious to developers that's 
what's happening so the find out during development, not after the 
patches have landed, and certainly not after they've made it out to 
users.  Thanks,

Josef
