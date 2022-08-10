Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A9E58F4C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 01:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbiHJXRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 19:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbiHJXRl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 19:17:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C911C79EFD;
        Wed, 10 Aug 2022 16:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Mf4ac8fVspvGcWxrOWEut1SK8rLHEYFOaT0I3ndebsw=; b=r8Qym12JFF1vTWy+OxxpowZKqG
        cUI2jR9JvF5dzHgWiQCX5ryLuRYAfMmM7Hg78la9ARHn3JV2SPzM8OTdx2wkTbBgBBHaNuVOquOJF
        3iQMAaU++310TWi52sNy+hx14cZjxzaiZFqVqcihkvcnRjOywnc0C1w2vKiKC8Z5Xdklfqdlyopak
        J7RJM8ig/pHce8N5tiRPnqQq8TZlk8kDt3nk7wFIDKqDD+dGomwLM/GFMd9mdIynioViWHDhrekhN
        +c+k9iuFCKf5xFEjpAP20cZJbfzBO5NuCHUqfukaMaMK/7l2rc1MyL5suK7pBByJI0FhnKrRITjQ+
        YPY7HzBA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oLux1-00HOHQ-P6; Wed, 10 Aug 2022 23:17:23 +0000
Date:   Thu, 11 Aug 2022 00:17:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Hellwig <hch@lst.de>, Mel Gorman <mgorman@suse.de>,
        Jan Kara <jack@suse.cz>, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Thumshirn <jth@kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: remove iomap_writepage v2
Message-ID: <YvQ8gwsKZlOH6mlP@casper.infradead.org>
References: <20220719041311.709250-1-hch@lst.de>
 <20220728111016.uwbaywprzkzne7ib@quack3>
 <20220729092216.GE3493@suse.de>
 <20220729141145.GA31605@lst.de>
 <Yufx5jpyJ+zcSJ4e@cmpxchg.org>
 <YvQYjpDHH5KckCrw@casper.infradead.org>
 <CAHpGcMLNKrOFxktaH9Wxq0M9O-m+DPrdbB7FQt7qwkzQdm-a-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMLNKrOFxktaH9Wxq0M9O-m+DPrdbB7FQt7qwkzQdm-a-w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 10, 2022 at 11:32:06PM +0200, Andreas Grünbacher wrote:
> Am Mi., 10. Aug. 2022 um 22:57 Uhr schrieb Matthew Wilcox <willy@infradead.org>:
> > On Mon, Aug 01, 2022 at 11:31:50AM -0400, Johannes Weiner wrote:
> > > XFS hasn't had a ->writepage call for a while. After LSF I internally
> > > tested dropping btrfs' callback, and the results looked good: no OOM
> > > kills with dirty/writeback pages remaining, performance parity. Then I
> > > went on vacation and Christoph beat me to the patch :)
> >
> > To avoid duplicating work with you or Christoph ... it seems like the
> > plan is to kill ->writepage entirely soon, so there's no point in me
> > doing a sweep of all the filesystems to convert ->writepage to
> > ->write_folio, correct?
> >
> > I assume the plan for filesystems which have a writepage but don't have
> > a ->writepages (9p, adfs, affs, bfs, ecryptfs, gfs2, hostfs, jfs, minix,
> > nilfs2, ntfs, ocfs2, reiserfs, sysv, ubifs, udf, ufs, vboxsf) is to give
> > them a writepages, modelled on iomap_writepages().  Seems that adding
> > a block_writepages() might be a useful thing for me to do?
> 
> Hmm, gfs2 does have gfs2_writepages() and gfs2_jdata_writepages()
> functions, so it should probably be fine.

Ah, it's gfs2_aspace_writepage which doesn't have a writepages
counterpart.  I haven't looked at it to understand why it's needed.
(gfs2_meta_aops and gfs2_rgrp_aops)
