Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5E475AFB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 15:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjGTN0b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 09:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjGTN03 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:26:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDA5E60;
        Thu, 20 Jul 2023 06:26:28 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DEB1C68AA6; Thu, 20 Jul 2023 15:26:25 +0200 (CEST)
Date:   Thu, 20 Jul 2023 15:26:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 19/23] btrfs: don't redirty pages in compress_file_range
Message-ID: <20230720132625.GB14692@lst.de>
References: <20230628153144.22834-1-hch@lst.de> <20230628153144.22834-20-hch@lst.de> <20230720114111.GX20457@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720114111.GX20457@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 20, 2023 at 01:41:11PM +0200, David Sterba wrote:
> > Note that compress_file_range was even redirtying the locked_page twice
> > given that extent_range_clear_dirty_for_io already redirties all pages
> > in the range, which must include locked_page if there is one.
> 
> This is probably the only scary patch in the series. I don't see
> anything obviously wrong, the reditrying logic added due to the mmap
> case is preserved.

You'll be even more scared when I finally get to clearing the dirty
patch and setting the writeback bit in the proper place so that
the BTRFS_INODE_HAS_ASYNC_EXTENT can go away :)  But that's still
dozends of patches down the patch stack..
