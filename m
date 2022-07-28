Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3671B5848AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jul 2022 01:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbiG1X0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 19:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiG1X0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 19:26:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD736664D6;
        Thu, 28 Jul 2022 16:26:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f7so3408413pjp.0;
        Thu, 28 Jul 2022 16:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=FThKBW22ogMZ47y3LqB8ynEnI2mNCgS8VuEq+ywlvPw=;
        b=BtvUVSDMSmGoe5Tpq0s9nciuzr4DV9IgWQwcbWUwB+o5DnCjMhZvM8IrzrwdpxSsz6
         jmFxISC4xWyfQKr3p1gD+UoUpQILzUpXc4axZs15WUA2UybUGHjqmrIZKtjFZ2gNlv8h
         1ZbrhuKANt9KtqHTnTxSWuaaVXz+OVAA6NWEq2MOm8P/5+hA2lBSVbmt/sABfgxE9s5l
         HkLaH9IqtkUZN2uX7wW9po6s5ffiR/M7vrQjqf1Izidn82dSreyFB4+7X1dOQK+Qx38R
         cEO8S4EOeMiIR2jZeBS20aCpNe80BSTO7gouJFHkSk3+FdbEiDhLzI7NKcobwqM2wg8m
         p1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FThKBW22ogMZ47y3LqB8ynEnI2mNCgS8VuEq+ywlvPw=;
        b=woLUCBy1XUdfYwqdtt9W1DSvNOerxptPM0Bf58mu46YU1FzlbRqAx02EnE7aInw7TE
         Mn0NkMGTzLWB76FOWPy2m5PmVZ9ZY9x/MTfNOEwFXmET1Gurn6eXYXA/uQVAYpyBX35e
         KavpyjNOmpupRbjhoflb0Eak8XWKoEhSFDgEQChagKgL6/ingitbzxTx7Id/PiFFcRBz
         HuRZituotFGJZpLAvuiOVe+fABpf+uCpBujxctA+05r5BD4kpZJXOMdwTCwLYTz6dkYp
         a5hN+E47IIqg/NTytgdDQeBoZlG3FBcohSJvvF/jpWsLhNvENvcb2EPV0dbcJDttzOD8
         HWaQ==
X-Gm-Message-State: ACgBeo2eYgDT2VGikHugI8Eaas1R/yEImqL0dITM/lGkaAZhkgL0/DYJ
        mMHzDalK8NnRveYEVz2cHcJOsMzyRlxmPFHXTB4=
X-Google-Smtp-Source: AA6agR5nvgMY86Y4sS/smtiWS4Mu1pYIFaY23gz00YkgOpJys8r91kVGv4QlE6/ujnAEXKtFvGqA+lRvB4hNhgDPpjs=
X-Received: by 2002:a17:902:a516:b0:16d:4379:f34a with SMTP id
 s22-20020a170902a51600b0016d4379f34amr1176999plq.26.1659050793250; Thu, 28
 Jul 2022 16:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220719041311.709250-1-hch@lst.de> <20220728111016.uwbaywprzkzne7ib@quack3>
 <YuKam52dkTGycay2@casper.infradead.org> <20220728224803.GZ3861211@dread.disaster.area>
In-Reply-To: <20220728224803.GZ3861211@dread.disaster.area>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 28 Jul 2022 16:26:20 -0700
Message-ID: <CAHbLzkptH+U9DP4yfGUfyOex47OQgYd2fOZYtCOxOr1S2ZTEeQ@mail.gmail.com>
Subject: Re: remove iomap_writepage v2
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 28, 2022 at 3:48 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, Jul 28, 2022 at 03:18:03PM +0100, Matthew Wilcox wrote:
> > On Thu, Jul 28, 2022 at 01:10:16PM +0200, Jan Kara wrote:
> > > Hi Christoph!
> > >
> > > On Tue 19-07-22 06:13:07, Christoph Hellwig wrote:
> > > > this series removes iomap_writepage and it's callers, following what xfs
> > > > has been doing for a long time.
> > >
> > > So this effectively means "no writeback from page reclaim for these
> > > filesystems" AFAICT (page migration of dirty pages seems to be handled by
> > > iomap_migrate_page()) which is going to make life somewhat harder for
> > > memory reclaim when memory pressure is high enough that dirty pages are
> > > reaching end of the LRU list. I don't expect this to be a problem on big
> > > machines but it could have some undesirable effects for small ones
> > > (embedded, small VMs). I agree per-page writeback has been a bad idea for
> > > efficiency reasons for at least last 10-15 years and most filesystems
> > > stopped dealing with more complex situations (like block allocation) from
> > > ->writepage() already quite a few years ago without any bug reports AFAIK.
> > > So it all seems like a sensible idea from FS POV but are MM people on board
> > > or at least aware of this movement in the fs land?
> >
> > I mentioned it during my folio session at LSFMM, but didn't put a huge
> > emphasis on it.
> >
> > For XFS, writeback should already be in progress on other pages if
> > we're getting to the point of trying to call ->writepage() in vmscan.
> > Surely this is also true for other filesystems?
>
> Yes.
>
> It's definitely true for btrfs, too, because btrfs_writepage does:
>
> static int btrfs_writepage(struct page *page, struct writeback_control *wbc)
> {
>         struct inode *inode = page->mapping->host;
>         int ret;
>
>         if (current->flags & PF_MEMALLOC) {
>                 redirty_page_for_writepage(wbc, page);
>                 unlock_page(page);
>                 return 0;
>         }
> ....
>
> It also rejects all calls to write dirty pages from memory reclaim
> contexts.

Aha, it seems even kswapd (it has PF_MEMALLOC set) is rejected too.

>
> ext4 will also reject writepage calls from memory allocation if
> block allocation is required (due to delayed allocation) or
> unwritten extents need converting to written. i.e. if it has to run
> blocking transactions.
>
> So all three major filesystems will either partially or wholly
> reject ->writepage calls from memory reclaim context.
>
> IOWs, if memory reclaim is depending on ->writepage() to make
> reclaim progress, it's not working as advertised on the vast
> majority of production Linux systems....
>
> The reality is that ->writepage is a relic of a bygone era of OS and
> filesystem design. It was useful in the days where writing a dirty
> page just involved looking up the bufferhead attached to the page to
> get the disk mapping and then submitting it for IO.
>
> Those days are long gone - filesystems have complex IO submission
> paths now that have to handle delayed allocation, copy-on-write,
> unwritten extents, have unbound memory demand, etc. All the
> filesystems that support these 1990s era filesystem technologies
> simply turn off ->writepage in memory reclaim contexts.
>
> Hence for the vast majority of linux users (i.e. everyone using
> ext4, btrfs and XFS), ->writepage no longer plays any part in memory
> reclaim on their systems.
>
> So why should we try to maintain the fiction that ->writepage is
> required functionality in a filesystem when it clearly isn't?
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
>
