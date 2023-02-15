Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324E0697398
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 02:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjBOB0p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 20:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbjBOB0m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:26:42 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730413608A
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 17:26:16 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id r17so11539417pff.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 17:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LDrdQ2Xe20rCSkHl5+p5pSWzmP0oHlxz9S7NwWjyk8I=;
        b=8KQ0tq1oZemkYqZLXQTk07cdTAkiScJp0+GGzfHt+OeIqQTxXQ2vjcRc19ZwfOXtk8
         PcX8k8GKiN1PJEmROtd7FaFtpjjmEIl9gvWRVFBlJPCytQAh4LNfm9RvKmDWG+h+68b2
         JTqKFrx/KHN1Dw34mnFxPRSbflPZv/nHIVTa1PdaGdmp3IOcZw/1xzZxEexNrbEc9vSw
         RN7aRVp7sjlK5tHXtJjU8OwRWhyBoRR8Tzs8pDzVIF9GqAhgj7P9GPeihTqXfUqbAyvw
         eBoFFMpVl6GrLuZbqd7euDjSrIDinZSCn09HRfeTiNeyyfk/t3U7jdJiTbEl0IhELHpC
         pcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDrdQ2Xe20rCSkHl5+p5pSWzmP0oHlxz9S7NwWjyk8I=;
        b=FMlk9Wg/WcujkdhZyp1BnXEQJXPci3RSkZpkPLwkzmbpObwkIy8CjnAfUp2Cqw8Ox/
         ShxrSiH/TLJwqnkNTE2GRgeE5wfO3bFiiMbLG9loYUAt3T2cHhNrOnCzb+uLsmiiCiK5
         70O8YgjP4RsR+pBCZoVU7gZVusl8ToriD01IGGE9a3tHmbBiX0U0H4bpRrwGk9eu/Dn+
         rxinY4hnbarS/+KdrbrwGYVASGQk1oYLlEmLQt3j25ydt0YK0DnN0W8WCn2yR0sSn+Ir
         jJqf3adVfm9SaJt7kqzKTTJZV83HggjkaYVsC5WPTHq2pOgVMZqqRJxsQQU2m8XgMGU8
         Cc5Q==
X-Gm-Message-State: AO0yUKVmBvq4ieicSAShX5MKnF5SpQFWFa4VZcXC3rJBAgijo40b+M6q
        uo4IMjkHj2RjrziGQqfl7SNxEA==
X-Google-Smtp-Source: AK7set+njk6NILwpCp1aNK3/X4otcqXEiyFqVur6lwcwGauDsJIsHd4F8UhHhpKV8f1HGFNOMhSjVQ==
X-Received: by 2002:a62:1bd1:0:b0:5a8:aa04:364a with SMTP id b200-20020a621bd1000000b005a8aa04364amr132393pfb.23.1676424375783;
        Tue, 14 Feb 2023 17:26:15 -0800 (PST)
Received: from dread.disaster.area (pa49-181-4-128.pa.nsw.optusnet.com.au. [49.181.4.128])
        by smtp.gmail.com with ESMTPSA id f18-20020aa78b12000000b0059312530b54sm10342820pfd.180.2023.02.14.17.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 17:26:15 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pS6Ym-00FQBU-Lt; Wed, 15 Feb 2023 12:26:12 +1100
Date:   Wed, 15 Feb 2023 12:26:12 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs, iomap: ->discard_folio() is broken so remove it
Message-ID: <20230215012612.GE2825702@dread.disaster.area>
References: <20230214055114.4141947-1-david@fromorbit.com>
 <20230214055114.4141947-4-david@fromorbit.com>
 <Y+vOfaxIWX1c/yy9@bfoster>
 <20230214222000.GL360264@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214222000.GL360264@dread.disaster.area>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 15, 2023 at 09:20:00AM +1100, Dave Chinner wrote:
> On Tue, Feb 14, 2023 at 01:10:05PM -0500, Brian Foster wrote:
> > On Tue, Feb 14, 2023 at 04:51:14PM +1100, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > Ever since commit e9c3a8e820ed ("iomap: don't invalidate folios
> > > after writeback errors") XFS and iomap have been retaining dirty
> > > folios in memory after a writeback error. XFS no longer invalidates
> > > the folio, and iomap no longer clears the folio uptodate state.
> > > 
> > > However, iomap is still been calling ->discard_folio on error, and
> > > XFS is still punching the delayed allocation range backing the dirty
> > > folio.
> > > 
> > > This is incorrect behaviour. The folio remains dirty and up to date,
> > > meaning that another writeback will be attempted in the near future.
> > > THis means that XFS is still going to have to allocate space for it
> > > during writeback, and that means it still needs to have a delayed
> > > allocation reservation and extent backing the dirty folio.
> > > 
> > 
> > Hmm.. I don't think that is correct. It looks like the previous patch
> > removes the invalidation, but writeback clears the dirty bit before
> > calling into the fs and we're not doing anything to redirty the folio,
> > so there's no guarantee of subsequent writeback.
> 
> Ah, right, I got confused with iomap_do_writepage() which redirties
> folios it performs no action on. The case that is being tripped here
> is "count == 0" which means no action has actually been taken on the
> folio and it is not submitted for writeback. We don't mark the folio
> with an error on submission failure like we do for errors reported
> to IO completion, so the folio is just left in it's current state
> in the cache.

OK, so after thinking on this for a little while, and then asking
the question on #xfs:

[15/2/23 09:39] <dchinner> so, if we don't start writeback on a page
on mapping failure, should we be redirtying it?

I think the direction this patchset is heading towards is the
correct direction. The discussion that followed pretty much leads to
needing to redirty the folio on any submission failure so that the
VFS infrastructure will try to write the data again in future. I've
included the full log of the discussion below so there is a record
of in the lore archives.

I also think that redirtying the page is the right thing to do when
we consider that we are going to be trying to fix corruptions
online, without users even needing to know a corruption was
encountered. In this case, we need to keep the folio dirty so that
once we've repaired the metadata corruption the user data will be
written back.

This also points out another aspect where health status should be
taken into account. When we select an AG for allocation, we should
check first that it is healthy before trying to allocate from it.
This would allow writeback to fail the first time because the AG
selected was corrupt, but on the second VFS attempt to write it back
it won't select the AG we already know is corrupt and hence may well
succeed in allocating the space needed to perform writeback.

It's these sorts of conditions that lead me to think that this
patchset is going in the right direction for XFS - we just need to
ensure that the folio we failed to submit bios for (even on mixed
folio writeback submission success/failure) is redirtied so that
future writeback attempts will be made.

Hence I think all this patchset needs is an additional patch that
adds a call to folio_redirty_for_writeback() when mapping failures
occur. We may need some additional fixes to ensure these dirty pages
are discarded at unmount if they are persistent/unrecoverable
failures, but this seems to be the right approach for the failure
handling behaviour we are trying to acheive now and into the
future...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

[15/2/23 09:39] <dchinner> so, if we don't start writeback on a page on mapping failure, should we be redirtying it?
[15/2/23 09:43] <willy> i think so.  otherwise we're pretending to the pagecache that we wrote it
[15/2/23 09:54] <djwong> (this was the subject a UEK5 bug 3 months ago)
[15/2/23 09:54] <djwong> (albeit with buffer heads mixed in for insanity maximization)
[15/2/23 10:20] <dchinner> willy: ok, so what happens if we have multiple blocks per page, and we map some blocks to a bio bio before we get a mapping failure?
[15/2/23 10:20] <dchinner> we currently mark the folio and under writeback and submit the folio
[15/2/23 10:20] <dchinner> *submit the bio
[15/2/23 10:21] <dchinner> so after the IO the folio ends up clean even though there is some data on it that was not written back
[15/2/23 10:21] <willy> i think you still need to redirty it because some of it hasn't been written back
[15/2/23 10:23] <dchinner> ok, so we'd need to do teh redirtying before we set the page for writeback?
[15/2/23 10:23] <dchinner> *folio
[15/2/23 10:24] <dchinner> because folio_start_writeback() will clear the PAGECACHE_TAG_DIRTY if the folio is clean when it is moved to writeback state?
[15/2/23 10:24] <willy> i don't think so.  the folio can be both dirty and writeback at the same time, and i think you want that, because you don't want to restart the writeback until the bio you submitted has finished
[15/2/23 10:25] <dchinner> write_cache_pages() handles trying to write pages currently under writeback
[15/2/23 10:26] <dchinner> (it either waits on it or skips it depending on wbc->sync_mode)
[15/2/23 10:26] <willy> makes sense
[15/2/23 10:27] <willy> yes, you should call folio_redirty_for_writepage, no matter whether you've called folio_start_writeback() or not
[15/2/23 10:29] <dchinner> ok
[15/2/23 10:30] <dchinner> that then means we really do need to get rid of ->discard_folio, because we need to keep the delalloc mappings behind the folio so that the next attempt to write the page will still have space reserved for it
[15/2/23 10:30] <willy> I'm pretty sure I would agree with you if I understood XFS well enough to have an opinion
[15/2/23 10:31] <dchinner> heh
[15/2/23 10:38] <djwong> uhhh :)
[15/2/23 10:38] <djwong> if we're going to redirty the folios, then yes, i generally think we should leave the delalloc extents
[15/2/23 10:39] <djwong> this redirtying -- this is only for the case that getting writeback mappings to construct bios fails, right?
[15/2/23 10:39] <willy> if we _don't_ redirty the folios, then the VM thinks they're clean and will drop them under memory pressure instead of trying to write them out again
[15/2/23 10:39] <djwong> or is it for handling the bios coming back with errors set?
[15/2/23 10:39] <willy> this is submission path errors
[15/2/23 10:54] <dchinner> submission path (iomap_writepage_map())
