Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A2C55F9DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 10:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiF2H6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 03:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiF2H6o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:58:44 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC2C2A725;
        Wed, 29 Jun 2022 00:58:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0D32867373; Wed, 29 Jun 2022 09:58:38 +0200 (CEST)
Date:   Wed, 29 Jun 2022 09:58:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
Message-ID: <20220629075837.GA22346@lst.de>
References: <20220624122334.80603-1-hch@lst.de> <7c30b6a4-e628-baea-be83-6557750f995a@gmx.com> <20220624125118.GA789@lst.de> <20220624130750.cu26nnm6hjrru4zd@quack3.lan> <20220625091143.GA23118@lst.de> <20220627101914.gpoz7f6riezkolad@quack3.lan> <e73be42e-fce5-733a-310d-db9dc5011796@gmx.com> <20220628115356.GB20633@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628115356.GB20633@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 01:53:56PM +0200, David Sterba wrote:
> This would work only for the higher level API where eg. RDMA notifies
> the filesystem, but there's still the s390 case that is part of the
> hardware architecture. The fixup worker is there as a safety for all
> other cases, I'm not fine removing or ignoring it.

I'd really like to have a confirmation of this whole s390 theory.
s390 does treat some dirtying different than the other architectures,
but none of that should leak into the file system API if any way that
bypasses ->page_mkwrite.

Because if it did most file systems would be completely broken on
s390.
