Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7386FCFE1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 22:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbjEIUtS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 16:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjEIUtN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 16:49:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472574EDD
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 13:49:07 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8CD1F6732A; Tue,  9 May 2023 22:49:02 +0200 (CEST)
Date:   Tue, 9 May 2023 22:49:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH] filemap: Handle error return from __filemap_get_folio()
Message-ID: <20230509204902.GA2047@lst.de>
References: <20230506160415.2992089-1-willy@infradead.org> <CAHk-=winrN4jsysShx0kWKVzmSMu7Pp3nz_6+aps9CP+v-qHWQ@mail.gmail.com> <CAHk-=winai-5i6E1oMk7hXPfbP+SCssk5+TOLCJ3koaDrn7Bzg@mail.gmail.com> <CAHk-=wiZ0GaAdqyke-egjBRaqP-QdLcX=8gNk7m6Hx7rXjcXVQ@mail.gmail.com> <CAHk-=whfNqsZVjy1EWAA=h7D0K2o4D8MSdnK8Qytj2BBhhFrSQ@mail.gmail.com> <CAHk-=wjzs7jHyp_SmT6h1Hnwu39Vuc0DuUxndwf2kL3zhyiCcw@mail.gmail.com> <20230506104122.e9ab27f59fd3d8294cb1356d@linux-foundation.org> <7bd22265-f46c-4347-a856-eecd1429dcce@kili.mountain> <d98acf2e-04bd-4824-81e4-64e91a26537c@kili.mountain> <CAHk-=whD=py2eMXFNOEQyDUobAXBJ3O0eFAG6yjC=EN4iZrhKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whD=py2eMXFNOEQyDUobAXBJ3O0eFAG6yjC=EN4iZrhKw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 09, 2023 at 10:37:12AM -0700, Linus Torvalds wrote:
> In fs/btrfs/extent_io.c, we have
> 
>     while (index <= end_index) {
>         folio = filemap_get_folio(mapping, index);
>         filemap_dirty_folio(mapping, folio);
> 
> and in fs/gfs2/lops.c we have a similar case of filemap_get_folio ->
> folio_wait_locked use without checking for any errors.
> 
> I assume it's probably hard to trigger errors in those paths, but it
> does look dodgy.

The pages are pinned at the point.  That being said this code is
absolutely for many other reasons and needs to go away.  I've been
looking into it, but it will probably take several more months to
unpile the onion to get to the hear of the btrfs writeback code
problems..
