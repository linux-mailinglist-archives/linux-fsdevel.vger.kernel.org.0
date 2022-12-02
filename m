Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04A9640481
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 11:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbiLBKWw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 05:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiLBKWv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:22:51 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B1125C6A;
        Fri,  2 Dec 2022 02:22:50 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D937167373; Fri,  2 Dec 2022 11:22:45 +0100 (CET)
Date:   Fri, 2 Dec 2022 11:22:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Dave Kleikamp <shaggy@kernel.org>,
        Bob Copeland <me@bobcopeland.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
Subject: Re: start removing writepage instances
Message-ID: <20221202102245.GA17715@lst.de>
References: <20221113162902.883850-1-hch@lst.de> <20221116183900.yzpcymelnnwppoh7@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116183900.yzpcymelnnwppoh7@riteshh-domain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 17, 2022 at 12:09:00AM +0530, Ritesh Harjani (IBM) wrote:
>    reclaim. Now IIUC from previous discussions [1][2][3], reclaims happens from
>    the tail end of the LRU list which could do an I/O of a single page while 
>    an ongoing writeback was in progress of multiple pages. This disrupts the I/O 
>    pattern to become more random in nature, compared to, if we would have let 
>    writeback/flusher do it's job of writing back dirty pages.

Yes.

>    Also many filesystems behave very differently within their ->writepage calls,
>    e.g. ext4 doesn't actually write in ->writepage for DELAYED blocks.

I don't think it's many file systems.  As far as I can tell only ext4
actually is significantly different.

> 2. Now the other place from where ->writepage can be called from is, writeout()
>    function, which is a fallback function for migration (fallback_migrate_folio()).
>    fallback_migrate_folio() is called from move_to_new_folio() if ->migrate_folio 
>    is not defined for the FS.

Also there is generic_writepages and folio_write_one/write_one_page.

> Is above a correct understanding?

Yes.
