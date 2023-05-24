Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE0670EA5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 02:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbjEXAkp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 20:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbjEXAkn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 20:40:43 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4E1192
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 17:40:39 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae4c5e12edso2416015ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 17:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1684888838; x=1687480838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g/2lRTEp2+vzgxmK+Q6yLfn+3h/GnU4pORxpfbfgDDM=;
        b=M4T7nRITXVRVPWSECm2MZuuj/39O1pG79+CPgDMcoHpAPTk+nOrKUXBdS6mwdfi5Zy
         FpAFL7qejpiCfMukxvsLKx6y/MjDBg7KGigJn7D1Mp/b0gXWv/AnUaZ6XaAHzCJvU65a
         Uz7gtkK1VyQVWplU3E6PU+qtoIlkbJSsvvKBoEwoPqWGq2MmcqjCLXtejR6B8YgA6oVX
         I7oPKtZ3Hd269QUFiPe2hy4vLjp7a6b6/fQnQ/TVgnc1f3mvMOF8Ow5EOfsXLPuioK0d
         lBlM8miHZXaPtDEN5JO68p7bRmLmb2VauZvwGjqHA5CnuxZlHvDL0MrvpCz/mg09ErDP
         0cQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684888838; x=1687480838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/2lRTEp2+vzgxmK+Q6yLfn+3h/GnU4pORxpfbfgDDM=;
        b=KDMyESe8UJ1bVsJGiqs6gO9xfSX4j4DMa2xV3+0CWZJA/AY709Evr7BiQREEvdkZFy
         Uo4aXA72RtDCbkNE9z8usbEfOo2wJdSAO0tY0VAXYHzgx4JMmAuq12xr3ZydYEVPCJLV
         aW1zAHSop90lmjIIR1gyZxhDWkfWY+BtRAU5e9DYc0E7A6jfS05oCp/MtNhqtZ4MAgQZ
         UM4LLhlFFnV/M4S0ddD7v3V2R5nqhcGQ0eIf2/B1ZEJmjTXS4GOinfgZ4QSdEeApBfHL
         6MdJi1jHJOpnQqqiCXmVxsho0hisjFKbW0kikoEoKAszm1LGiPz++6yyJkG9MWxD1E4H
         V2bw==
X-Gm-Message-State: AC+VfDz/X+v8IQKmNcANFwqnhpws64f4OgyMx6fxbehYv+1zc1cgC29y
        1l1cjt6AFT5edFkr+yb2UQKkzQ==
X-Google-Smtp-Source: ACHHUZ4ELvS95kgltWKKI0sQaRwhfv49xLXoR0zfldqDVRDWfmH/jNA6qFVcem5euAQDD7dhRn3rkg==
X-Received: by 2002:a17:903:32c7:b0:1ae:513a:9439 with SMTP id i7-20020a17090332c700b001ae513a9439mr20480732plr.23.1684888838637;
        Tue, 23 May 2023 17:40:38 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090282cc00b001a212a93295sm7370900plz.189.2023.05.23.17.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 17:40:37 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q1cYM-0038PM-19;
        Wed, 24 May 2023 10:40:34 +1000
Date:   Wed, 24 May 2023 10:40:34 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Brian Foster <bfoster@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        dm-devel@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Joe Thornber <ejt@redhat.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZG1dAtHmbQ53aOhA@dread.disaster.area>
References: <20230518223326.18744-1-sarthakkukreti@chromium.org>
 <ZGb2Xi6O3i2pLam8@infradead.org>
 <ZGeKm+jcBxzkMXQs@redhat.com>
 <ZGgBQhsbU9b0RiT1@dread.disaster.area>
 <ZGu0LaQfREvOQO4h@redhat.com>
 <ZGzIJlCE2pcqQRFJ@bfoster>
 <ZGzbGg35SqMrWfpr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGzbGg35SqMrWfpr@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 11:26:18AM -0400, Mike Snitzer wrote:
> On Tue, May 23 2023 at 10:05P -0400, Brian Foster <bfoster@redhat.com> wrote:
> > On Mon, May 22, 2023 at 02:27:57PM -0400, Mike Snitzer wrote:
> > ... since I also happen to think there is a potentially interesting
> > development path to make this sort of reserve pool configurable in terms
> > of size and active/inactive state, which would allow the fs to use an
> > emergency pool scheme for managing metadata provisioning and not have to
> > track and provision individual metadata buffers at all (dealing with
> > user data is much easier to provision explicitly). So the space
> > inefficiency thing is potentially just a tradeoff for simplicity, and
> > filesystems that want more granularity for better behavior could achieve
> > that with more work. Filesystems that don't would be free to rely on the
> > simple/basic mechanism provided by dm-thin and still have basic -ENOSPC
> > protection with very minimal changes.
> > 
> > That's getting too far into the weeds on the future bits, though. This
> > is essentially 99% a dm-thin approach, so I'm mainly curious if there's
> > sufficient interest in this sort of "reserve mode" approach to try and
> > clean it up further and have dm guys look at it, or if you guys see any
> > obvious issues in what it does that makes it potentially problematic, or
> > if you would just prefer to go down the path described above...
> 
> The model that Dave detailed, which builds on REQ_PROVISION and is
> sticky (by provisioning same blocks for snapshot) seems more useful to
> me because it is quite precise.  That said, it doesn't account for
> hard requirements that _all_ blocks will always succeed.

Hmmm. Maybe I'm misunderstanding the "reserve pool" context here,
but I don't think we'd ever need a hard guarantee from the block
device that every write bio issued from the filesystem will succeed
without ENOSPC.

If the block device can provide a guarantee that a provisioned LBA
range is always writable, then everything else is a filesystem level
optimisation problem and we don't have to involve the block device
in any way. All we need is a flag we can ready out of the bdev at
mount time to determine if the filesystem should be operating with
LBA provisioning enabled...

e.g. If we need to "pre-provision" a chunk of the LBA space for
filesystem metadata, we can do that ahead of time and track the
pre-provisioned range(s) in the filesystem itself.

In XFS, That could be as simple as having small chunks of each AG
reserved to metadata (e.g. start with the first 100MB) and limiting
all metadata allocation free space searches to that specific block
range. When we run low on that space, we pre-provision another 100MB
chunk and then allocate all metadata out of that new range. If we
start getting ENOSPC to pre-provisioning, then we reduce the size of
the regions and log low space warnings to userspace. If we can't
pre-provision any space at all and we've completely run out, we
simply declare ENOSPC for all incoming operations that require
metadata allocation until pre-provisioning succeeds again.

This is built entirely on the premise that once proactive backing
device provisioning fails, the backing device is at ENOSPC and we
have to wait for that situation to go away before allowing new data
to be ingested. Hence the block device really doesn't need to know
anything about what the filesystem is doing and vice versa - The
block dev just says "yes" or "no" and the filesystem handles
everything else.

It's worth noting that XFS already has a coarse-grained
implementation of preferred regions for metadata storage. It will
currently not use those metadata-preferred regions for user data
unless all the remaining user data space is full.  Hence I'm pretty
sure that a pre-provisioning enhancment like this can be done
entirely in-memory without requiring any new on-disk state to be
added.

Sure, if we crash and remount, then we might chose a different LBA
region for pre-provisioning. But that's not really a huge deal as we
could also run an internal background post-mount fstrim operation to
remove any unused pre-provisioning that was left over from when the
system went down.

Further, managing shared pool exhaustion doesn't require a
reservation pool in the backing device and for the filesystems to
request space from it. Filesystems already have their own reserve
pools via pre-provisioning. If we want the filesystems to be able to
release that space back to the shared pool (e.g. because the shared
backing pool is critically short on space) then all we need is an
extension to FITRIM to tell the filesystem to also release internal
pre-provisioned reserves.

Then the backing pool admin (person or automated daemon!) can simply
issue a trim on all the filesystems in the pool and spce will be
returned. Then filesystems will ask for new pre-provisioned space
when they next need to ingest modifications, and the backing pool
can manage the new pre-provisioning space requests directly....

Hence I think if we get the basic REQ_PROVISION overwrite-in-place
guarantees defined and implemented as previously outlined, then we
don't need any special coordination between the fs and block devices
to avoid fatal ENOSPC issues with sparse and/or snapshot capable
block devices...

As a bonus, if we can implement the guarantees in dm-thin/-snapshot
and have a filesystem make use of it, then we also have a reference
implementation to point at device vendors and standards
associations....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
