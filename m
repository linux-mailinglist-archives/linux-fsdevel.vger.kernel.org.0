Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526024CF21C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 07:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiCGGpe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 01:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiCGGpd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 01:45:33 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED633443F9;
        Sun,  6 Mar 2022 22:44:38 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4130168AA6; Mon,  7 Mar 2022 07:44:34 +0100 (CET)
Date:   Mon, 7 Mar 2022 07:44:34 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Borislav Petkov <bp@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mmotm v2] tmpfs: do not allocate pages on read
Message-ID: <20220307064434.GA31680@lst.de>
References: <f9c2f38f-5eb8-5d30-40fa-93e88b5fbc51@google.com> <20220306092709.GA22883@lst.de> <90bc5e69-9984-b5fa-a685-be55f2b64b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90bc5e69-9984-b5fa-a685-be55f2b64b@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 06, 2022 at 02:59:05PM -0800, Hugh Dickins wrote:
> Mikulas asked in
> https://lore.kernel.org/linux-mm/alpine.LRH.2.02.2007210510230.6959@file01.intranet.prod.int.rdu2.redhat.com/
> Do we still need a0ee5ec520ed ("tmpfs: allocate on read when stacked")?
> 
> Lukas noticed this unusual behavior of loop device backed by tmpfs in
> https://lore.kernel.org/linux-mm/20211126075100.gd64odg2bcptiqeb@work/
> 
> Normally, shmem_file_read_iter() copies the ZERO_PAGE when reading holes;
> but if it looks like it might be a read for "a stacking filesystem", it
> allocates actual pages to the page cache, and even marks them as dirty.
> And reads from the loop device do satisfy the test that is used.
> 
> This oddity was added for an old version of unionfs, to help to limit
> its usage to the limited size of the tmpfs mount involved; but about
> the same time as the tmpfs mod went in (2.6.25), unionfs was reworked
> to proceed differently; and the mod kept just in case others needed it.
> 
> Do we still need it? I cannot answer with more certainty than "Probably
> not". It's nasty enough that we really should try to delete it; but if
> a regression is reported somewhere, then we might have to revert later.
> 
> It's not quite as simple as just removing the test (as Mikulas did):
> xfstests generic/013 hung because splice from tmpfs failed on page not
> up-to-date and page mapping unset.  That can be fixed just by marking
> the ZERO_PAGE as Uptodate, which of course it is: do so in
> pagecache_init() - it might be useful to others than tmpfs.
> 
> My intention, though, was to stop using the ZERO_PAGE here altogether:
> surely iov_iter_zero() is better for this case?  Sadly not: it relies
> on clear_user(), and the x86 clear_user() is slower than its copy_user():
> https://lore.kernel.org/lkml/2f5ca5e4-e250-a41c-11fb-a7f4ebc7e1c9@google.com/
> 
> But while we are still using the ZERO_PAGE, let's stop dirtying its
> struct page cacheline with unnecessary get_page() and put_page().
> 
> Reported-by: Mikulas Patocka <mpatocka@redhat.com>
> Reported-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Hugh Dickins <hughd@google.com>

I would have split the uptodate setting of ZERO_PAGE into a separate,
clearly documented patch, but otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
