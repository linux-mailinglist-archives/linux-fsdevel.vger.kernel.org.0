Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242F269709E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 23:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBNWUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 17:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBNWUF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:20:05 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7564BFB
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 14:20:04 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id be8so18479239plb.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 14:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4GF0yPrnR6GTAKmA93IjzKA1dA8iyePWIJbKTTcKCM=;
        b=C0vLkXK828SkA5AiDWRza2lsbfr+eRSBdqaEMQpAERe18d4DnABbC0Zbz3RkTuiFKf
         hn4rq2rwUbllic80MzVkdeIEiEqETyXUcfmriwOaUs6wcHxJVbhzAwI9SFCR/e2DDgCh
         O4+6psf6B6U4l/Q0hGIWbG86nCcqoaLBYi+sKZSLzRsbzTnaPcJtDF/4ouJjSwl6epuQ
         MYllmNi5mmbzFUSHM4EGwI4mJuteynQ4temEuX8sop/kCvz21Fl0cV7E5pNioHRNhkwz
         wse1/QFIQXawc0f6IEnng5R3zcRa3MnIYnMRvYcpVwM0Ao2Qjcez2r042MePR/HkAVu8
         4B0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4GF0yPrnR6GTAKmA93IjzKA1dA8iyePWIJbKTTcKCM=;
        b=BkGZJAjPEDSYeV3tRwAv/IiKccb/WpmXokukJ8BFuq52bxKiXYwOEZ3eNhBE6LVHJ8
         qq7YyCzdZmzOa5Q7h3RHG2rJBHzwFOdk6peYFofVFDh7B1mxJyowimnRsfq8whT4K39b
         BikKjkl2AFRY+D6AJ4V5IKblHB0uC8CSmHPWUjs7qLkKzv3WGWyvTW6B733VVNN13RNQ
         VXMn02xI7yKOEKn3uV2hNnbfgrdbNx9jBXu2HF/RbZNhnLuFzMIV29gfr4BrxQfERYy9
         EGR0PW0ZDRYN9gjiAZnORWdfQAMRug/Y3q4pj7zajSvjSp8BR8yQgLMXjS3LbVkHSlQ9
         5PSw==
X-Gm-Message-State: AO0yUKWe46zVmZurRYII6h3U1Di8DXSshoFPp742DiBfbk9ZYePEyfms
        MXkJjqNIw8I2dt/I+Di1vJi4gA==
X-Google-Smtp-Source: AK7set9cvs7WBLhrrRXxE9EhupXKVe+X2BeTcsjfLl393Ul0WgaaXhG1Hasx8EoqwHJsx/NleZJyzQ==
X-Received: by 2002:a17:902:e803:b0:19a:972a:7cb3 with SMTP id u3-20020a170902e80300b0019a972a7cb3mr156543plg.60.1676413203864;
        Tue, 14 Feb 2023 14:20:03 -0800 (PST)
Received: from dread.disaster.area (pa49-181-4-128.pa.nsw.optusnet.com.au. [49.181.4.128])
        by smtp.gmail.com with ESMTPSA id jk21-20020a170903331500b00199563fff0fsm5509698plb.190.2023.02.14.14.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 14:20:03 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pS3ea-00FMqi-Kp; Wed, 15 Feb 2023 09:20:00 +1100
Date:   Wed, 15 Feb 2023 09:20:00 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs, iomap: ->discard_folio() is broken so remove it
Message-ID: <20230214222000.GL360264@dread.disaster.area>
References: <20230214055114.4141947-1-david@fromorbit.com>
 <20230214055114.4141947-4-david@fromorbit.com>
 <Y+vOfaxIWX1c/yy9@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+vOfaxIWX1c/yy9@bfoster>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 14, 2023 at 01:10:05PM -0500, Brian Foster wrote:
> On Tue, Feb 14, 2023 at 04:51:14PM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Ever since commit e9c3a8e820ed ("iomap: don't invalidate folios
> > after writeback errors") XFS and iomap have been retaining dirty
> > folios in memory after a writeback error. XFS no longer invalidates
> > the folio, and iomap no longer clears the folio uptodate state.
> > 
> > However, iomap is still been calling ->discard_folio on error, and
> > XFS is still punching the delayed allocation range backing the dirty
> > folio.
> > 
> > This is incorrect behaviour. The folio remains dirty and up to date,
> > meaning that another writeback will be attempted in the near future.
> > THis means that XFS is still going to have to allocate space for it
> > during writeback, and that means it still needs to have a delayed
> > allocation reservation and extent backing the dirty folio.
> > 
> 
> Hmm.. I don't think that is correct. It looks like the previous patch
> removes the invalidation, but writeback clears the dirty bit before
> calling into the fs and we're not doing anything to redirty the folio,
> so there's no guarantee of subsequent writeback.

Ah, right, I got confused with iomap_do_writepage() which redirties
folios it performs no action on. The case that is being tripped here
is "count == 0" which means no action has actually been taken on the
folio and it is not submitted for writeback. We don't mark the folio
with an error on submission failure like we do for errors reported
to IO completion, so the folio is just left in it's current state
in the cache.

> Regardless, I can see how this prevents this sort of error in the
> scenario where writeback fails due to corruption, but I don't see how it
> doesn't just break error handling of writeback failures not associated
> with corruption.

What other cases in XFS do we have that cause mapping failure? We
can't get ENOSPC here because of delalloc reservations. We can't get
ENOMEM because all the memory allocations are blocking. That just
leaves IO errors reading metadata, or structure corruption when
parsing and modifying on-disk metadata.  I can't think (off the top
of my head) of any other type of error we can get returned from
allocation - what sort of non-corruption errors were you thinking
of here?

> fails due to some random/transient error, delalloc is left around on a
> !dirty page (i.e. stale), and reclaim eventually comes around and
> results in the usual block accounting corruption associated with stale
> delalloc blocks.

The first patches in the series fix those issues. If we get stray
delalloc extents on a healthy inode, then it will still trigger all
the warnings/asserts that we have now. But if the inode has been
marked sick by a corruption based allocation failure, it will clean
up in reclaim without leaking anything or throwing any new warnings.

> This is easy enough to test/reproduce (just tried it
> via error injection to delalloc conversion) that I'm kind of surprised
> fstests doesn't uncover it. :/

> > Failure to retain the delalloc extent (because xfs_discard_folio()
> > punched it out) means that the next writeback attempt does not find
> > an extent over the range of the write in ->map_blocks(), and
> > xfs_map_blocks() triggers a WARN_ON() because it should never land
> > in a hole for a data fork writeback request. This looks like:
> > 
> 
> I'm not sure this warning makes a lot of sense either given most of this
> should occur around the folio lock. Looking back at the code and the
> error report for this, the same error injection used above on a 5k write
> to a bsize=1k fs actually shows the punch remove fsb offsets 0-5 on a
> writeback failure, so it does appear to be punching too much out.  The
> cause appears to be that the end offset is calculated in
> xfs_discard_folio() by rounding up the start offset to 4k (folio size).
> If pos == 0, this results in passing end_fsb == 0 to the punch code,
> which xfs_iext_lookup_extent_before() then changes to fsb == 5 because
> that's the last block of the delalloc extent that covers fsb 0.

And that is the bug I could not see in commit 7348b322332d ("xfs:
xfs_bmap_punch_delalloc_range() should take a byte range") which is
what this warning was bisected down to. Thank you for identifying
the reason the bisect landed on that commit. Have you written a
fix to test out you reasoning that you can post?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
