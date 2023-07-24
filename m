Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856B5760203
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 00:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjGXWIb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 18:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjGXWIa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:08:30 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36E619A1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 15:08:28 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b890e2b9b7so24549455ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 15:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1690236508; x=1690841308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YiVLpoqRBSUKN+9FWsFBB1zWbxDt+GF5JFvfD+9xwvQ=;
        b=IsnQRu4gLa6XZH4i8mAcdMuH1PvZahVQhG7uaMFWzE5NQYY7cYwBovrK2ePjpSBFg6
         AWEENSUJUVg6nzQug4aLpnOuOkrvfMhLacHxR4qXAHXAxqa5dFINgbN5Ttg/1f82p3H5
         FyK86rylKoC3btv2Zxs0nyvwCT68Fg3fXrQEFP8z2PY/53JvNhUv5mM7ZSnJDBk9sAXf
         JwstgMaugLMuQ0LY2yjKwz7l+o4ItdLPddsBJbalVTkkUc4/Z7gWdcd23R1rWeFZBriN
         jo8AciZUR0I3rqJoXf5UMmfog7GJGSAyy8AIspX4a3ikNsX1aHCrLIPksEpIS7jWG0tK
         HuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690236508; x=1690841308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiVLpoqRBSUKN+9FWsFBB1zWbxDt+GF5JFvfD+9xwvQ=;
        b=hOrkc4Yf+Em2ddsT462VS/c7AkW4p7bErVEAVaQhR5qQIoVwKlLTvWSBA96MWCRuzV
         6h2MMCYZ/DjN8HKRVpJOB3otRTHTDRCoRM6YX8pHpZqn2okNPMTRgEy3n/C/0LPzTC82
         tGDfFztbZtlLjkRp8VS/M4Yh+9alzMiERQzI266FDTip1jKOVmhoCoFuY7iFeNg8jyUM
         vKwQ/EAt8+qw7Lr2HuUhnmA1HTD3CSLNFEnxFj9/HooEFuQ/cfEq0U8qUMrO1Q3AkXIX
         PG6DNBAtTW35QO/FpYuZd6fYak+xf5zhPFX8h2CRm0eE7HTYupJpWIBdmSD2AoNDK0i5
         oKfw==
X-Gm-Message-State: ABy/qLYy5QeGAjrK2fIDBmqThoOvt6ZJlnp+2nZuozbGpVUaTdMV7shY
        WKIyhsotqhpC+ISQI77LVTcApgo4QFrwHXQrk4U=
X-Google-Smtp-Source: APBJJlFL7IL5vlAW4dKgeOmKmmNUCeLrE4HqWcCSK+s5M0r3YESnNOQX7pVoll5fhQI/4j0tYoOEGA==
X-Received: by 2002:a17:902:a58b:b0:1bb:bb70:c23e with SMTP id az11-20020a170902a58b00b001bbbb70c23emr241901plb.18.1690236507746;
        Mon, 24 Jul 2023 15:08:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-119-116.pa.vic.optusnet.com.au. [49.186.119.116])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170903279600b001b9da42cd7dsm9427325plb.279.2023.07.24.15.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 15:08:27 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qO3j6-00A72u-2Y;
        Tue, 25 Jul 2023 08:08:24 +1000
Date:   Tue, 25 Jul 2023 08:08:24 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nitesh Shetty <nj.shetty@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, gost.dev@samsung.com,
        Anuj Gupta <anuj20.g@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/read_write: Enable copy_file_range for block device.
Message-ID: <ZL72WJ31DtAjgcFd@dread.disaster.area>
References: <CGME20230724060655epcas5p24f21ce77480885c746b9b86d27585492@epcas5p2.samsung.com>
 <20230724060336.8939-1-nj.shetty@samsung.com>
 <ZL4cpDxr450zomJ0@dread.disaster.area>
 <20230724163838.GB26430@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724163838.GB26430@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 06:38:38PM +0200, Christoph Hellwig wrote:
> > > Change generic_copy_file_checks to use ->f_mapping->host for both inode_in
> > > and inode_out. Allow block device in generic_file_rw_checks.
> > 
> > Why? copy_file_range() is for copying a range of a regular file to
> > another regular file - why do we want to support block devices for
> > somethign that is clearly intended for copying data files?
> 
> Nitesh has a series to add block layer copy offload,

Yes, I know.

> and uses that to
> implement copy_file_range on block device nodes,

Yes, I know.

> which seems like a
> sensible use case for copy_file_range on block device nodes,

Except for the fact it's documented and implemented as for copying
data ranges of *regular files*. Block devices are not regular
files...

There is nothing in this patchset that explains why this syscall
feature creep is desired, why it is the best solution, what benefits
it provides, how this new feature is discoverable, etc. It also does
not mention that user facing documentation needs to change, etc

> and that
> series was hiding a change like this deep down in a "block" title
> patch,

I know.

> so I asked for it to be split out.  It still really should
> be in that series, as there's very little point in changing this
> check without an actual implementation making use of it.

And that's because it's the wrong way to be implementing block
device copy offloads.

That patchset originally added ioctls to issue block copy offloads
to block devices from userspace - that's the way block device
specific functionality is generally added and I have no problems
with that.

However, when I originally suggested that the generic
copy_file_range() fallback path that filesystems use (i.e.
generic_copy_file_range()) should try to use the block copy offload
path before falling back to using splice to copy the data through
host memory, things went off the rails.

That has turned into "copy_file_range() should support block devices
directly" and the ioctl interfaces were removed. The block copy
offload patchset still doesn't have a generic path for filesystems
to use this block copy offload. This is *not* what I originally
suggested, and provides none of the benefit to users that would come
from what I originally suggested.  Block device copy offload is
largely useless to users if file data copies within a filesystem
don't make use of it - very few applications ever copy data directly
to/from block devices directly...

So from a system level point of view, expanding copy_file_range() to
do direct block device data copies doesn't make any sense. Expanding
the existing copy_file_range() generic fallback to attempt block
copy offload (i.e. hardware accel) makes much more sense, and will
make copy_file_range() much more useful to users on filesystem like
ext4 that don't have reflink support...

So, yeah, this patch, regardless of how it is presented, needs to a
whole lot more justification that "we want to do this" in the commit
message...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
