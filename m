Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB2955E05A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbiF0KTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 06:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiF0KTS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:19:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E3DFF9;
        Mon, 27 Jun 2022 03:19:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A226B21DB6;
        Mon, 27 Jun 2022 10:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656325155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UdpPYyPEsq917JWKtpl+IGzv/nLDJ04sz9TJdrZmucw=;
        b=rHWnAFdzUb/t0TLrisexxUvYb5p/DmcyALGXZKH4OrD9ZXA8xl/fQ1u0tmlulPss1p1RQa
        aOYMRbvAuJKoXOhDTKfP2eB4HNCXO9LfVqGnRLcSHy+kP6ME/EeLjz6TncOT/wjwPy/3WL
        aBt+Q1VSGpKCwP17ozratNxhWtAEf/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656325155;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UdpPYyPEsq917JWKtpl+IGzv/nLDJ04sz9TJdrZmucw=;
        b=cUxKlWZR5H9ZqhEM+qWRusSxFhxGolWrUSMGGChvLr9+Ot+j+izwHebUaYOfZh2knlFbaK
        dcI84y7jXcUrXuAw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 909572C141;
        Mon, 27 Jun 2022 10:19:15 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 51745A062F; Mon, 27 Jun 2022 12:19:14 +0200 (CEST)
Date:   Mon, 27 Jun 2022 12:19:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
Message-ID: <20220627101914.gpoz7f6riezkolad@quack3.lan>
References: <20220624122334.80603-1-hch@lst.de>
 <7c30b6a4-e628-baea-be83-6557750f995a@gmx.com>
 <20220624125118.GA789@lst.de>
 <20220624130750.cu26nnm6hjrru4zd@quack3.lan>
 <20220625091143.GA23118@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625091143.GA23118@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 25-06-22 11:11:43, Christoph Hellwig wrote:
> On Fri, Jun 24, 2022 at 03:07:50PM +0200, Jan Kara wrote:
> > I'm not sure I get the context 100% right but pages getting randomly dirty
> > behind filesystem's back can still happen - most commonly with RDMA and
> > similar stuff which calls set_page_dirty() on pages it has got from
> > pin_user_pages() once the transfer is done. page_maybe_dma_pinned() should
> > be usable within filesystems to detect such cases and protect the
> > filesystem but so far neither me nor John Hubbart has got to implement this
> > in the generic writeback infrastructure + some filesystem as a sample case
> > others could copy...
> 
> Well, so far the strategy elsewhere seems to be to just ignore pages
> only dirtied through get_user_pages.  E.g. iomap skips over pages
> reported as holes, and ext4_writepage complains about pages without
> buffers and then clears the dirty bit and continues.
> 
> I'm kinda surprised that btrfs wants to treat this so special
> especially as more of the btrfs page and sub-page status will be out
> of date as well.

I agree btrfs probably needs a different solution than what it is currently
doing if they want to get things right. I just wanted to make it clear that
the code you are ripping out may be a wrong solution but to a real problem.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
