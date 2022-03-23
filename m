Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDDD4E4CA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 07:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiCWGTb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 02:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbiCWGTa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:19:30 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91634D96;
        Tue, 22 Mar 2022 23:18:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CCED568AFE; Wed, 23 Mar 2022 07:17:56 +0100 (CET)
Date:   Wed, 23 Mar 2022 07:17:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 40/40] btrfs: use the iomap direct I/O bio directly
Message-ID: <20220323061756.GA24589@lst.de>
References: <20220322155606.1267165-1-hch@lst.de> <20220322155606.1267165-41-hch@lst.de> <37a6e06f-c8ac-37dc-2f3b-b469e2410a97@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37a6e06f-c8ac-37dc-2f3b-b469e2410a97@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 09:39:24AM +0800, Qu Wenruo wrote:
> Not familar with iomap thus I can be totally wrong, but isn't the idea
> of iomap to separate more code from fs?

Well, to share more code, which requires a certain abstraction, yes.

> I'm really not sure if it's a good idea to expose btrfs internal bio_set
> just for iomap.

We don't.  iomap still purely operates on the generic bio.  It just
allocates additional space for btrfs to use after ->submit_io is called.
Just like how e.g. VFS inodes can come with extra space for file
system use.

> Personally speaking I didn't see much problem of cloning an iomap bio,
> it only causes extra memory of btrfs_bio, which is pretty small previously.

It is yet another pointless memory allocation in something considered very
much a fast path.
