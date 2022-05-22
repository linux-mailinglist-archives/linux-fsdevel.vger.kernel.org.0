Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E31530329
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 14:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344663AbiEVMwE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 08:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245208AbiEVMwD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 08:52:03 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662CC1C110
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 05:52:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B4B7068AFE; Sun, 22 May 2022 14:51:57 +0200 (CEST)
Date:   Sun, 22 May 2022 14:51:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <20220522125157.GA24032@lst.de>
References: <20210621135958.GA1013@lst.de> <YNCcG97WwRlSZpoL@casper.infradead.org> <20210621140956.GA1887@lst.de> <YNCfUoaTNyi4xiF+@casper.infradead.org> <20210621142235.GA2391@lst.de> <YNCjDmqeomXagKIe@zeniv-ca.linux.org.uk> <20210621143501.GA3789@lst.de> <Yokl+uHTVWFxoQGn@zeniv-ca.linux.org.uk> <20220522074327.GA15562@lst.de> <YoovgBe6MZPtemlI@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoovgBe6MZPtemlI@zeniv-ca.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 22, 2022 at 12:41:36PM +0000, Al Viro wrote:
> Add
> #define IOMAP_DIO_NOSYNC (1 << 3)
> in iomap.h, pass IOMAP_DIO_PARTIAL | IOMAP_DIO_NOSYNC in btrfs and do
>                 if (iocb_is_dsync(iocb) && !(dio->flags & IOMAP_DIO_NOSYNC)) {
> in __iomap_dio_rw(), you mean?

Roughly, yes.

> I wonder if we want something of that sort in another user of IOMAP_DIO_PARTIAL
> (gfs2, that is)...

I don't think gfs2 needs it, but it might be worth to take another look
at how it handles sync writes.
