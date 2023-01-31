Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E306836AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 20:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjAaThn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 14:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjAaThm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:37:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EB33CE0E;
        Tue, 31 Jan 2023 11:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1u+SZDMkJ1vFn+QDbFq5kiRMcjf/G7pulRBSuzHb0xQ=; b=G4xQru/g+xE4Axp6Bs7R6La6Xl
        v/tCMhhtfCCDQj5EkTyIx6RobnvZpsWRQdqU+NAxnh6q9xI4VpOxu1U3ZrJ+Ciplz0YpSczmJ/zar
        C/KzhlVVP0HHi7V/e2eH3HMoyaoRTuO4IkkOkKOvRasCogyQbCKufGqVT5Izdfm7djap3bPxxKEEB
        drrHw1xQqwNgEEv1VTX44gmuQyorDPVGRuxyGtBK+3EvaNFycbrE65oTZmsRmlj/EEzkPm/YgPIOi
        6adv28/TGsInE9+uEJK1N0eZ37One6xMJsgICt4lNZmJI7OpmeLYmgvRgJkZLuqveoqi6N2Tz6Ydr
        QUyHGaow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMwRj-00Bboe-Ck; Tue, 31 Jan 2023 19:37:35 +0000
Date:   Tue, 31 Jan 2023 19:37:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v6 05/10] iomap/gfs2: Get page in page_prepare handler
Message-ID: <Y9lt/95kN6kwp+A1@casper.infradead.org>
References: <20230108194034.1444764-1-agruenba@redhat.com>
 <20230108194034.1444764-6-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108194034.1444764-6-agruenba@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 08, 2023 at 08:40:29PM +0100, Andreas Gruenbacher wrote:
> +static struct folio *
> +gfs2_iomap_page_prepare(struct iomap_iter *iter, loff_t pos, unsigned len)
>  {
> +	struct inode *inode = iter->inode;
>  	unsigned int blockmask = i_blocksize(inode) - 1;
>  	struct gfs2_sbd *sdp = GFS2_SB(inode);
>  	unsigned int blocks;
> +	struct folio *folio;
> +	int status;
>  
>  	blocks = ((pos & blockmask) + len + blockmask) >> inode->i_blkbits;
> -	return gfs2_trans_begin(sdp, RES_DINODE + blocks, 0);
> +	status = gfs2_trans_begin(sdp, RES_DINODE + blocks, 0);
> +	if (status)
> +		return ERR_PTR(status);
> +
> +	folio = iomap_get_folio(iter, pos);
> +	if (IS_ERR(folio))
> +		gfs2_trans_end(sdp);
> +	return folio;
>  }

Hi Andreas,

I didn't think to mention this at the time, but I was reading through
buffered-io.c and this jumped out at me.  For filesystems which support
folios, we pass the entire length of the write (or at least the length
of the remaining iomap length).  That's intended to allow us to decide
how large a folio to allocate at some point in the future.

For GFS2, we do this:

        if (!mapping_large_folio_support(iter->inode->i_mapping))
                len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));

I'd like to drop that and pass the full length of the write to
->get_folio().  It looks like you'll have to clamp it yourself at this
point.  I am kind of curious why you do one transaction per page --
I would have thought you'd rather do one transaction for the entire write.
