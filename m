Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781D3688F17
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 06:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjBCFtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 00:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjBCFtm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 00:49:42 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A83F885D4;
        Thu,  2 Feb 2023 21:49:28 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2931068C4E; Fri,  3 Feb 2023 06:49:25 +0100 (CET)
Date:   Fri, 3 Feb 2023 06:49:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>, P J P <ppandit@redhat.com>
Subject: Re: [PATCH v3] fs/buffer.c: update per-CPU bh_lru cache via RCU
Message-ID: <20230203054924.GA22730@lst.de>
References: <Y9qM68F+nDSYfrJ1@tpad> <20230202223653.GF937597@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202223653.GF937597@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 03, 2023 at 09:36:53AM +1100, Dave Chinner wrote:
> Rather than adding more complexity to the legacy bufferhead code,
> wouldn't it be better to switch the block device mapping to use
> iomap+folios and get rid of the use of bufferheads altogether?

It's not that simple unfortunately :(  All file systems that use
buffer heads also use them on the block device for metadata.  I have
a WIP block device iomap conversion, but it still has to offer
buffer_heads similar to the legacy path in iomap to make all that
work.
