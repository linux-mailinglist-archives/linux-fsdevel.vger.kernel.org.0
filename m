Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C878969888F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 00:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjBOXEF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 18:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjBOXEC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 18:04:02 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95267457DB
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 15:03:50 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id n2so142579pgb.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 15:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xVtTvqbwAg88jCPwlTtCkUIS1OKpRNgVadlt8olh1Ew=;
        b=tQHptBT9539hpEgNxe7kkJVAXGkCIikNA+YWUw+gcNPb5YH9urjiPJ90V0f4FjHKNP
         qCAHkUfi+Y7A+wEl8Kdcb8VSQCMVkHJnUXjVEe661H6NFbCq81FPD8PNTKromHQzHu5j
         FiPR2Roxw+8T3jZRn/cBJBmINYcyJhZvdNT62mMxi0Nde8LR2EcbDU2Xk/Fsdvh9OtDG
         eAgwTVZi/HcGgGkn2pFSpAqHfJgDW54ZydEQrFnyc+3nb9AjmSkIlcAoKIKlH+1W7Mi1
         EcNaocuk6+XIhEuNKRv+ClfuCD/dqL3JZcLTpkWGhbcvAiVlSH8hvUZrhyJ+v8rXO74b
         dSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVtTvqbwAg88jCPwlTtCkUIS1OKpRNgVadlt8olh1Ew=;
        b=iOIfMLFR27dZniYqCsyk9LqJ2zk4OmWNotmivBLJZ4YUGAMLpD4bHSDWeygbniKApo
         fwHpguGpq/htosibF46kbOZ0CWqsMVnBWRkxJuX1SHP5hvJWv0n+Gn+t5ZRpQrU+qAMl
         yIJlUd7Zyfh94t1+LRuQX1n7J2P4XLXTURjmTf1GnVh75tTAMdNW2nG2Kv7+6m98n9FR
         uPVKuP9PdciJmH/biSwRI50KSeXL2LB3xChZB2xjAfbe6X2HVdw5D1LVmgp7y1GNQktI
         FNOofFeTX5ggj3L6ZdsJlTVJZbdux50z1EXVlw7yEsrp8X2yoXwuZTjcJq0ZG57t2u1t
         QREA==
X-Gm-Message-State: AO0yUKVJwJuecjvxZIsm4OfCf/mAcSOpLJKGc2+LZX2sNC9IidIkOQPM
        ilmn02mp9HuBhOHRYWYRZ4LWWw==
X-Google-Smtp-Source: AK7set9d8E5pGgNEE3LtNcri62eLHazlgRov06Iy+BzhVVUs8sewOhIFm4hOEWkO2f2Kga811oNCsg==
X-Received: by 2002:a62:5fc5:0:b0:593:2289:f01c with SMTP id t188-20020a625fc5000000b005932289f01cmr2834667pfb.25.1676502229667;
        Wed, 15 Feb 2023 15:03:49 -0800 (PST)
Received: from dread.disaster.area (pa49-181-4-128.pa.nsw.optusnet.com.au. [49.181.4.128])
        by smtp.gmail.com with ESMTPSA id 15-20020aa7924f000000b0059435689e36sm12582215pfp.170.2023.02.15.15.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 15:03:49 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pSQoU-00FmEl-Ht; Thu, 16 Feb 2023 10:03:46 +1100
Date:   Thu, 16 Feb 2023 10:03:46 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs, iomap: ->discard_folio() is broken so remove it
Message-ID: <20230215230346.GP360264@dread.disaster.area>
References: <20230214055114.4141947-1-david@fromorbit.com>
 <20230214055114.4141947-4-david@fromorbit.com>
 <Y+vOfaxIWX1c/yy9@bfoster>
 <20230214222000.GL360264@dread.disaster.area>
 <Y+z5d5QBeRg3dHVL@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+z5d5QBeRg3dHVL@bfoster>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 15, 2023 at 10:25:43AM -0500, Brian Foster wrote:
> On Wed, Feb 15, 2023 at 09:20:00AM +1100, Dave Chinner wrote:
> > On Tue, Feb 14, 2023 at 01:10:05PM -0500, Brian Foster wrote:
> > > On Tue, Feb 14, 2023 at 04:51:14PM +1100, Dave Chinner wrote:
> > > > From: Dave Chinner <dchinner@redhat.com>
> > > > 
> > > > Ever since commit e9c3a8e820ed ("iomap: don't invalidate folios
> > > > after writeback errors") XFS and iomap have been retaining dirty
> > > > folios in memory after a writeback error. XFS no longer invalidates
> > > > the folio, and iomap no longer clears the folio uptodate state.
> > > > 
> > > > However, iomap is still been calling ->discard_folio on error, and
> > > > XFS is still punching the delayed allocation range backing the dirty
> > > > folio.
> > > > 
> > > > This is incorrect behaviour. The folio remains dirty and up to date,
> > > > meaning that another writeback will be attempted in the near future.
> > > > THis means that XFS is still going to have to allocate space for it
> > > > during writeback, and that means it still needs to have a delayed
> > > > allocation reservation and extent backing the dirty folio.
> > > > 
> > > 
> > > Hmm.. I don't think that is correct. It looks like the previous patch
> > > removes the invalidation, but writeback clears the dirty bit before
> > > calling into the fs and we're not doing anything to redirty the folio,
> > > so there's no guarantee of subsequent writeback.
> > 
> > Ah, right, I got confused with iomap_do_writepage() which redirties
> > folios it performs no action on. The case that is being tripped here
> > is "count == 0" which means no action has actually been taken on the
> > folio and it is not submitted for writeback. We don't mark the folio
> > with an error on submission failure like we do for errors reported
> > to IO completion, so the folio is just left in it's current state
> > in the cache.
> > 
> > > Regardless, I can see how this prevents this sort of error in the
> > > scenario where writeback fails due to corruption, but I don't see how it
> > > doesn't just break error handling of writeback failures not associated
> > > with corruption.
> > 
> > What other cases in XFS do we have that cause mapping failure? We
> > can't get ENOSPC here because of delalloc reservations. We can't get
> > ENOMEM because all the memory allocations are blocking. That just
> > leaves IO errors reading metadata, or structure corruption when
> > parsing and modifying on-disk metadata.  I can't think (off the top
> > of my head) of any other type of error we can get returned from
> > allocation - what sort of non-corruption errors were you thinking
> > of here?
> > 
> > > fails due to some random/transient error, delalloc is left around on a
> > > !dirty page (i.e. stale), and reclaim eventually comes around and
> > > results in the usual block accounting corruption associated with stale
> > > delalloc blocks.
> > 
> > The first patches in the series fix those issues. If we get stray
> > delalloc extents on a healthy inode, then it will still trigger all
> > the warnings/asserts that we have now. But if the inode has been
> > marked sick by a corruption based allocation failure, it will clean
> > up in reclaim without leaking anything or throwing any new warnings.
> > 
> 
> Those warnings/asserts that exist now indicate something is wrong and
> that free space accounting is likely about to become corrupted, because
> an otherwise clean inode is being reclaimed with stale delalloc blocks.

Well, yes.

> I see there's an error injection knob (XFS_ERRTAG_REDUCE_MAX_IEXTENTS)
> tied to the max extent count checking stuff in the delalloc conversion
> path. You should be able to add some (10+) extents to a file and then
> turn that thing all the way up to induce a (delalloc conversion)
> writeback failure and see exactly what I'm talking about [1].
> 
> Brian
> 
> [1] The following occurs with this patch, but not on mainline because the
> purpose of ->discard_folio() is to prevent it.

A non-corruption related writeback error has resulted in those debug
checks triggering correctly. This demonstrates the debug checks are
still working as intended. :)

Hence this isn't an argument against removing ->discard_folio(), this is
merely a demonstration that the current patch series needs more work.

Indeed, if the folio gets redirtied here instead of left clean as
we've already talked about, a future writeback may, in fact, succeed
and this specific problem goes away. We know how this retry
mechanism works - it's exactly what we do with metadata write
failures. Further, changing the behaviour of failure handling here
is exactly what we have the configurable error handling
infrastructure for. It's also why the "fail on unmount"
functionality exists, too.

That is, if we get to the point that "fail on unmount" triggers for
metadata we cannot write back due to persistent errors, we should
also perform the same trigger for data we cannot write back due to
persistent writeback allocation failures. In which case, any
allocation error should mark the inode sick and the unconverted
delalloc extents get cleaned up correctly by the final inode reclaim
pass.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
