Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C541697A76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 15:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfHUNOV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 09:14:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43668 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfHUNOU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:14:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id v12so1412605pfn.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2019 06:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+FTVPQJIElgo/eBaJWXuUPChwGI7d5OiYHXZ+WGlwrs=;
        b=pv7Lv0nkvGtPx9sY7uJXRk6DeNkxZVidTa9axqCI8TsPkpGAtyBqFeZh1Y5Qt76QVO
         LE7EHSmgpSIYkVC0X+TBiYBVx6/m3GNkXY4HLlSbORfeZ5i2FF/R2gSdPyLnYYGsLMgO
         Z+bfz916hUGJEkJWQmoWsw6oIVLRtEc70MpSNpYRytxK1bMYr5BD1dP2uxlWWuWgOHpm
         b8XRyA3rbpx1UBrsWpl9YY5E3tsPYovOIHmTg+bc8CPO91doAzsg2kvIi1b30LbqhNst
         ritcgFBSQp6bc+fXkljxq7SweSg816s85RHdMbrlBbgq3fTQtyUmHcWhi2v4ZbHOBRrn
         ustw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+FTVPQJIElgo/eBaJWXuUPChwGI7d5OiYHXZ+WGlwrs=;
        b=JRtAjKiaQTLqOmo9C9ZSPeZ8s2LTJcMz4vankuzv7w5XAMCtXOYwdo8sfkchfkSwTY
         WyyFI/EHONbphCBVM2Tr7j/pkR1u7wWDtMxK2XURwSQG0R4VstGaDbYWKCTrd9TUATAK
         5IB7Ar60kXa99Qp2qvacPBhOvZqatBN5AWQaJlR+DamJlMO+WtFWQEcyWiasnYUUCk7Y
         AEQGq5LpVPXklE4zpXIc1DqbxnK4LhlrU2oJVJBxYm6dS/J3U4zvWErLRPsUEd7w751g
         Bm0egJZiltxXkVRvtB4RH+x+XC5kUfbrVQnoJOme7rt6DEKefs5jdFjifSRenThAGCak
         MQnA==
X-Gm-Message-State: APjAAAV/xYCpe4fILV235pWpKCg1vV2RRypDzA22VuA4emJUpF9U0YYN
        0CtA6RNKXEF+0z519Z0owFU7
X-Google-Smtp-Source: APXvYqwZ/Xvx9LRlZAbkj23YMsaZG5qg7YOKwwQOOxXq+WsRQdwDZ6RlykITgRt5djzDQzKTqsXE3Q==
X-Received: by 2002:a63:4b02:: with SMTP id y2mr28565129pga.135.1566393254090;
        Wed, 21 Aug 2019 06:14:14 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id g2sm44391425pfq.88.2019.08.21.06.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 06:14:13 -0700 (PDT)
Date:   Wed, 21 Aug 2019 23:14:07 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        riteshh@linux.ibm.com, hch@infradead.org
Subject: Re: [PATCH 0/5] ext4: direct IO via iomap infrastructure
Message-ID: <20190821131405.GC24417@poseidon.bobrowski.net>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <20190812173150.AF04F5204F@d06av21.portsmouth.uk.ibm.com>
 <20190813111004.GA12682@poseidon.bobrowski.net>
 <20190813122723.AE6264C040@d06av22.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813122723.AE6264C040@d06av22.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 13, 2019 at 05:57:22PM +0530, RITESH HARJANI wrote:
> But what I meant was this (I may be wrong here since I haven't really looked
> into it), but for my understanding I would like to discuss this -
> 
> So earlier with this flag(EXT4_STATE_DIO_UNWRITTEN) we were determining on
> whether a newextent can be merged with ex1 in function
> ext4_extents_can_be_merged. But now since we have removed that flag we have
> no way of knowing that whether this inode has any unwritten extents or not
> from any DIO path.
> 
> What I meant is isn't this removal of setting/unsetting of
> flag(EXT4_STATE_DIO_UNWRITTEN) changing the behavior of this func -
> ext4_extents_can_be_merged?

OK, I'm stuck and looking for either clarity, revalidation of my
thought process, or any input on how to solve this problem for that
matter.

In the current ext4 direct IO implementation, the dynamic state flag
EXT4_STATE_DIO_UNWRITTEN is set/unset for synchronous direct IO
writes. On the other hand, the flag EXT4_IO_END_UNWRITTEN is set/unset
for ext4_io_end->flag, and the value of i_unwritten is
incremented/decremented for asynchronous direct IO writes. All
mechanisms by which are used to track and determine whether the inode,
or an IO in flight against a particular inode have any pending
unwritten extents that need to be converted after the IO has
completed. In addition to this, we have ext4_can_extents_be_merged()
performing explicit checks against both EXT4_STATE_DIO_UNWRITTEN and
i_unwritten and using them to determine whether it can or cannot merge
a requested extent into an existing extent.

This is all fine for the current direct IO implementation. However,
while switching the direct IO code paths over to make use of the iomap
infrastructure, I believe that we can no longer simply track whether
an inode has unwritten extents needing to be converted by simply
setting and checking the EXT4_STATE_DIO_UNWRITTEN flag on the
inode. The reason being is that there can be multiple direct IO
operations to unwritten extents running against the inode and we don't
particularly distinguish synchronous from asynchronous writes within
ext4_iomap_begin() as there's really no need. So, the only way to
accurately determine whether extent conversion is deemed necessary for
an IO operation whether it'd be synchronous or asynchronous is by
checking the IOMAP_DIO_UNWRITTEN flag within the ->end_io()
callback. I'm certain that this portion of the logic is correct, but
we're still left with some issues when it comes to the checks that I
previously mentioned in ext4_can_extents_be_merged(), which is the
part I need some input on.

I was doing some thinking and I don't believe that making use of the
EXT4_STATE_DIO_UNWRITTEN flag is the solution at all here. This is not
only for reasons that I've briefly mentioned above, but also because
of the fact that it'll probably lead to a lot of inaccurate judgements
while taking particular code paths and some really ugly code that
creeps close to the definition of insanity. Rather, what if we solve
this problem by continuing to just use i_unwritten to keep track of
all the direct IOs to unwritten against running against an inode?
Within ext4_iomap_begin() post successful creation of unwritten
extents we'd call atomic_inc(&EXT4_I(inode)->i_unwritten) and
subsequently within the ->end_io() callback whether we take the
success or error path we'd call
atomic_dec(&EXT4_I(inode)->i_unwritten) accordingly? This way we can
still rely on this value to be used in the check within
ext4_can_extents_be_merged(). Open for alternate suggestions if anyone
has any...

--M
