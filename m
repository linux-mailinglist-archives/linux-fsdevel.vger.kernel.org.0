Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04486F2E89
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 06:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjEAEru (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 00:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEAErt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 00:47:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A58BDE;
        Sun, 30 Apr 2023 21:47:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D5EBC68B05; Mon,  1 May 2023 06:47:44 +0200 (CEST)
Date:   Mon, 1 May 2023 06:47:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>,
        Baokun Li <libaokun1@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Zhang Yi <yi.zhang@redhat.com>,
        yangerkun <yangerkun@huawei.com>
Subject: Re: [ext4 io hang] buffered write io hang in balance_dirty_pages
Message-ID: <20230501044744.GA20056@lst.de>
References: <dbb8d8a7-3a80-34cc-5033-18d25e545ed1@huawei.com> <ZEpH+GEj33aUGoAD@ovpn-8-26.pek2.redhat.com> <663b10eb-4b61-c445-c07c-90c99f629c74@huawei.com> <ZEpcCOCNDhdMHQyY@ovpn-8-26.pek2.redhat.com> <ZEskO8md8FjFqQhv@ovpn-8-24.pek2.redhat.com> <fb127775-bbe4-eb50-4b9d-45a8e0e26ae7@huawei.com> <ZEtd6qZOgRxYnNq9@mit.edu> <ZEyL/sjVeW88XpIn@ovpn-8-24.pek2.redhat.com> <20230429044038.GA7561@lst.de> <ZEym2Yf1Ud1p+L3R@ovpn-8-24.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEym2Yf1Ud1p+L3R@ovpn-8-24.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 29, 2023 at 01:10:49PM +0800, Ming Lei wrote:
> Not sure if it is needed for non s_bdev

So you don't want to work this at all for btrfs?  Or the XFS log device,
or ..

> , because FS is over stackable device
> directly. Stackable device has its own logic for handling underlying disks dead
> or deleted, then decide if its own disk needs to be deleted, such as, it is
> fine for raid1 to work from user viewpoint if one underlying disk is deleted.

We still need to propagate the even that device has been removed upwards.
Right now some file systems (especially XFS) are good at just propagating
it from an I/O error.  And explicity call would be much better.
