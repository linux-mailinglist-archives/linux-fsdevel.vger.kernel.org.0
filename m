Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCC455FACD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 10:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiF2IkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 04:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiF2IkM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:40:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023053BBC8;
        Wed, 29 Jun 2022 01:40:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1360F67373; Wed, 29 Jun 2022 10:40:09 +0200 (CEST)
Date:   Wed, 29 Jun 2022 10:40:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Mason <clm@fb.com>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
Message-ID: <20220629084008.GA25536@lst.de>
References: <20220624122334.80603-1-hch@lst.de> <7c30b6a4-e628-baea-be83-6557750f995a@gmx.com> <20220624125118.GA789@lst.de> <20220624130750.cu26nnm6hjrru4zd@quack3.lan> <20220625091143.GA23118@lst.de> <c4af4c49-c537-bd6d-c27e-fe9ed71b9a8e@fb.com> <b29ee79c-e0d9-7ebe-a563-ca7f33130fc9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b29ee79c-e0d9-7ebe-a563-ca7f33130fc9@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 09:20:59AM +0800, Qu Wenruo wrote:
> In fact, COW is not that special, even before btrfs or all the other
> fses supporting COW, all those old fses has to do something like COW,
> when they are writing into holes.
>
> What makes btrfs special is its csum, and in fact csum requires more
> stable page status.
>
> If someone can modify a page without waiting for its writeback to
> finish, btrfs csum can easily be stale and cause -EIO for future read.

And the writepage time fixup does not help with this at all, as it
just allocates the ordered extent at writepage time, long after the
data has been modified.
