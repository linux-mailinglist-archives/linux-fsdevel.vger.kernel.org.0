Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3CA4E4C8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 07:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241514AbiCWGMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 02:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiCWGMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:12:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AAA7004C;
        Tue, 22 Mar 2022 23:11:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9BF5768AFE; Wed, 23 Mar 2022 07:11:03 +0100 (CET)
Date:   Wed, 23 Mar 2022 07:11:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 23/40] btrfs: store an inode pointer in struct btrfs_bio
Message-ID: <20220323061103.GG24302@lst.de>
References: <20220322155606.1267165-1-hch@lst.de> <20220322155606.1267165-24-hch@lst.de> <35f1ef04-53b4-83ec-2f2f-be8893ffd258@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35f1ef04-53b4-83ec-2f2f-be8893ffd258@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 08:54:21AM +0800, Qu Wenruo wrote:
> Something I want to avoid is to futher increasing the size of btrfs_bio.
>
> For buffered uncompressed IO, we can grab the inode from the first page.
> For direct IO we have bio->bi_private (btrfs_dio_private).
> For compressed IO, it's bio->bi_private again (compressed_bio).
>
> Do the saved code lines really validate the memory usage for all bios?

This isn't about the saved lines.  It allows to remove the async submit
and completion container structures that both point to an inode, and
later on the dio_private structure.  So overall it actually is a major
memory saving.
