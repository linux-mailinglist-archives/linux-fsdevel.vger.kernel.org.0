Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B0A563EB9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Jul 2022 08:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiGBGFN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Jul 2022 02:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBGFM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Jul 2022 02:05:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B941903F
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 23:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2M2oliHcbueqRqvb4nphogSYWC7wLzGz10oRk1IKx7M=; b=dvulDgK2cGLqU7AhgYZ45DqgwV
        FInN9rVTLTJKtW03tZtDoBZnfCxEdpWJHJrOa5N/W9Tj/RtqDd1/D1GrXvV024uXgUw+y1x7kFUtB
        JolWbqdZv74EpT2SN+uEwjYoaODh+3czKP3mV4B6fy547MplJCbEHb/958qIbZuoqsoe7ALDLDs1i
        dNDRoNrpCKnid2RT6x/dDVXniyUHYopl4sttp3WIGIINjBNOk7DgR0xaweYBaHw/eUk0uPfHu0Qzw
        ErHFH65cVSet/4tfJ4GDAbprx/foCt4vL+bhEJh74ZkAZOqdjY6cnsl8V/mkQqgsd+RUaWndP132d
        6fWtYAoQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7WFg-008HC6-E6; Sat, 02 Jul 2022 06:05:08 +0000
Date:   Fri, 1 Jul 2022 23:05:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stefan Roesch <shr@fb.com>
Subject: Re: [PATCH] fs: allow inode time modification with IOCB_NOWAIT
Message-ID: <Yr/gFLRLBE76enwG@infradead.org>
References: <39f8b446-dce3-373f-eb86-e3333b31122c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39f8b446-dce3-373f-eb86-e3333b31122c@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 01, 2022 at 02:09:32PM -0600, Jens Axboe wrote:
> generic/471 complains because it expects any write done with RWF_NOWAIT
> to succeed as long as the blocks for the write are already instantiated.
> This isn't necessarily a correct assumption, as there are other conditions
> that can cause an RWF_NOWAIT write to fail with -EAGAIN even if the range
> is already there.
> 
> Since the risk of blocking off this path is minor, just allow inode
> time updates with IOCB_NOWAIT set. Then we can later decide if we should
> catch this further down the stack.

I think this is broken.  Please just drop the test, the non-blocking
behavior here makes a lot of sense.  At least for XFS, the update
will end up allocating and commit a transaction which involves memory
allocation, a blocking lock and possibly waiting for lock space.
