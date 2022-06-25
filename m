Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E43755A87F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jun 2022 11:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiFYJLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jun 2022 05:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiFYJLr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:11:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB653BF83;
        Sat, 25 Jun 2022 02:11:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 99A4768AA6; Sat, 25 Jun 2022 11:11:43 +0200 (CEST)
Date:   Sat, 25 Jun 2022 11:11:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
Message-ID: <20220625091143.GA23118@lst.de>
References: <20220624122334.80603-1-hch@lst.de> <7c30b6a4-e628-baea-be83-6557750f995a@gmx.com> <20220624125118.GA789@lst.de> <20220624130750.cu26nnm6hjrru4zd@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624130750.cu26nnm6hjrru4zd@quack3.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 24, 2022 at 03:07:50PM +0200, Jan Kara wrote:
> I'm not sure I get the context 100% right but pages getting randomly dirty
> behind filesystem's back can still happen - most commonly with RDMA and
> similar stuff which calls set_page_dirty() on pages it has got from
> pin_user_pages() once the transfer is done. page_maybe_dma_pinned() should
> be usable within filesystems to detect such cases and protect the
> filesystem but so far neither me nor John Hubbart has got to implement this
> in the generic writeback infrastructure + some filesystem as a sample case
> others could copy...

Well, so far the strategy elsewhere seems to be to just ignore pages
only dirtied through get_user_pages.  E.g. iomap skips over pages
reported as holes, and ext4_writepage complains about pages without
buffers and then clears the dirty bit and continues.

I'm kinda surprised that btrfs wants to treat this so special
especially as more of the btrfs page and sub-page status will be out
of date as well.
