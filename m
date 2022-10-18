Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AF36023BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 07:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJRF0P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 01:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJRF0M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:26:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB51726A5
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 22:26:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BEE2D68C4E; Tue, 18 Oct 2022 07:26:06 +0200 (CEST)
Date:   Tue, 18 Oct 2022 07:26:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, david@fromorbit.com,
        nvdimm@lists.linux.dev, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 07/25] fsdax: Hold dax lock over mapping insertion
Message-ID: <20221018052606.GA18887@lst.de>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com> <166579185727.2236710.8711235794537270051.stgit@dwillia2-xfh.jf.intel.com> <Y02tnrZXxm+NzWVK@nvidia.com> <634db85363e2c_4da329489@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <634db85363e2c_4da329489@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 01:17:23PM -0700, Dan Williams wrote:
> Historically, no. The block-device is allowed to disappear while inodes
> are still live.

Btw, while I agree with what you wrote below this sentence is at least
a bit confusing.  Struct block_device/gendisk/request_queue will always
be valid as long as a file system is mounted and inodes are live due
to refcounting.  It's just as you correctly pointed out del_gendisk
might have aready been called and they are dead.
