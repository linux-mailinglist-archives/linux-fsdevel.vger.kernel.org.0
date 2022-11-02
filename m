Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203FA616F56
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 22:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiKBVEj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 17:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiKBVEi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:04:38 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7662DF2F
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Nov 2022 14:04:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o7so14196411pjj.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Nov 2022 14:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9EzKgUySexRc8B4dWjvuyru+IgiYQVy6x5BFH+NfB0U=;
        b=CUvk02ACFKAjQ5YP7NUk0hpyFYAaIfFOZxI3cOc6HqfCh0IHuyF6A8S8mB9NCJ7+sM
         MwkgRQA5BToL0cZ2dxn4e/LG+NPp65ar+BKkxu8QFlXlsXh9LLXInKC9fjDx6ssUd5bb
         PIh0an1ALHUnnhFQfgsoinUIsiK86g4gzFqhAabG5KFjenrjqhcxZj5Q/LmneIkvG+ZV
         84lr90zW6D9hCgjyGtZpPKvUtidofVFqKZ7psEPj+G8dQIRbHCoeEEeD1QalpE/403JG
         F4p8tUzuMQlMNNHmn2DC4o+uOy3u2+HUusHgM2Adf1uWxBm2qExpjd+V+lpxzFGKoOre
         PRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EzKgUySexRc8B4dWjvuyru+IgiYQVy6x5BFH+NfB0U=;
        b=G4i9TzdOCAwzHORi78cYhU+um+os+vixQ/bof7SnimSCJC+J6Fi0LPtvz6/FM4O/qv
         MZgKI8vMa/1/c2IY6jltQIE0Fpn48O+oi0bb0wfW9aZ4Nbxlojj/wNRBc/1jC0WLaroK
         lIu5IKxuw0c2GO1atcEjMWvVt5VuETr7K18BytO6kqAJQ/KBOJA4sVivh5g8aZ9TUodA
         R5KOGyKBGONjxOzBZ2TDZk9TMZ/KNaUA/oCqbY2YyHsjQuA4kbbVE8q5YUJC438dypBP
         Er99aBwoaIs66iF3TT/Dco+JBRoEdUdW7MILp7PXJArrHIhMkIg7e+qdsAibk79RSyjQ
         QCQA==
X-Gm-Message-State: ACrzQf38bWDB6JdpaqQ2XS2aTolbMaeYyRW1hjZqM8OgpTXvAQ/KXUfc
        MVMvUlP8oDptqIOfV6Z7GnArjg==
X-Google-Smtp-Source: AMsMyM6eFFzqPTmzFZk873+lwNSIMVE1QK7cxtTyFKHmfB/kDYySoGrx6/Ittlgmd7NNiMI/+nU9KA==
X-Received: by 2002:a17:902:e54f:b0:187:2e45:e191 with SMTP id n15-20020a170902e54f00b001872e45e191mr13867750plf.91.1667423077348;
        Wed, 02 Nov 2022 14:04:37 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b0016cf3f124e1sm8727488plg.234.2022.11.02.14.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 14:04:36 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oqKuX-009WMK-SQ; Thu, 03 Nov 2022 08:04:33 +1100
Date:   Thu, 3 Nov 2022 08:04:33 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/7] xfs: buffered write failure should not truncate the
 page cache
Message-ID: <20221102210433.GZ3600936@dread.disaster.area>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <20221101003412.3842572-5-david@fromorbit.com>
 <Y2KdumAbAF0mV0sh@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2KdumAbAF0mV0sh@magnolia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 02, 2022 at 09:41:30AM -0700, Darrick J. Wong wrote:
> On Tue, Nov 01, 2022 at 11:34:09AM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > xfs_buffered_write_iomap_end() currently invalidates the page cache
> > over the unused range of the delalloc extent it allocated. While the
> > write allocated the delalloc extent, it does not own it exclusively
> > as the write does not hold any locks that prevent either writeback
> > or mmap page faults from changing the state of either the page cache
> > or the extent state backing this range.
> > 
> > Whilst xfs_bmap_punch_delalloc_range() already handles races in
> > extent conversion - it will only punch out delalloc extents and it
> > ignores any other type of extent - the page cache truncate does not
> > discriminate between data written by this write or some other task.
> > As a result, truncating the page cache can result in data corruption
> > if the write races with mmap modifications to the file over the same
> > range.
> > 
> > generic/346 exercises this workload, and if we randomly fail writes
> > (as will happen when iomap gets stale iomap detection later in the
> > patchset), it will randomly corrupt the file data because it removes
> > data written by mmap() in the same page as the write() that failed.
> > 
> > Hence we do not want to punch out the page cache over the range of
> > the extent we failed to write to - what we actually need to do is
> > detect the ranges that have dirty data in cache over them and *not
> > punch them out*.
> 
> Same dumb question as hch -- why do we need to punch out the nondirty
> pagecache after a failed write?  If the folios are uptodate then we're
> evicting cache unnecessarily, and if they're !uptodate can't we let
> reclaim do the dirty work for us?

Sorry, we don't punch out the page cache  - this was badly worded. I
meant:

"[...] - what we actually need to do is
detect the ranges that have dirty data in cache over the delalloc
extent and retain those regions of the delalloc extent."

i.e. we never punch the page cache anymore, and we only selectively
punch the delalloc extent that back the clean regions of thw write
range...

> I don't know if there are hysterical raisins for this or if the goal is
> to undo memory consumption after a write failure?  If we're stale-ing
> the write because the iomapping changed, why not leave the folio where
> it is, refresh the iomapping, and come back to (possibly?) the same
> folio?

I can't say for certain - I haven't gone an looked at the history.
I suspect it goes back to the days where write() could write zeroes
into the page cache for eof zeroing or zeroing for file extension
before the write() started writing data. Maybe that was part of what
it was trying to undo?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
