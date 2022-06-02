Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD65453BE14
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 20:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbiFBSaz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 14:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbiFBSax (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:30:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F410228ABF3;
        Thu,  2 Jun 2022 11:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=szmXLXEXgQOPuLalg0aYhE0tI19hGUcMHnWH4EuhWQQ=; b=XK+ihUFSjVewy3Wqvp7T2ae/pU
        zNMW5BLtsVutVxZTw7Qws/rOQgCUXjg9HPZizeEmSi27XFzVw2w6iqHZ7PS+1Nq9FkWwwP4HJNAZA
        QhWsq3tDhP1FpiQzhby90/OC2WRgWLXFKXbyy9onFdbfadXe5orf7Vuy0nDwli9YqWwlyxLug0/NQ
        MkomceVyqgn1OoLysggFDxFMrIr/4DNTUa2SqzanbBgO+4jzF4kuVbImokwMWZh9NKr6bBE3O1fxP
        AQ+o3KoXGiHgM23P1C1vUwI0rEkBkfl20eBGD130fxM43Kj0z1GIC5XY5x3BwyeJbOEIsWbVy0tMl
        tsX7cREg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwpap-007LM4-2H; Thu, 02 Jun 2022 18:30:47 +0000
Date:   Thu, 2 Jun 2022 19:30:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     akpm@linux-foundation.org, kent.overstreet@gmail.com,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH -next] mm/filemap: fix that first page is not mark
 accessed in filemap_read()
Message-ID: <YpkB1+PwIZ3AKUqg@casper.infradead.org>
References: <20220602082129.2805890-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602082129.2805890-1-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 02, 2022 at 04:21:29PM +0800, Yu Kuai wrote:
> In filemap_read(), 'ra->prev_pos' is set to 'iocb->ki_pos + copied',
> while it should be 'iocb->ki_ops'.

Can you walk me through your reasoning which leads you to believe that
it should be ki_pos instead of ki_pos + copied?  As I understand it,
prev_pos is the end of the previous read, not the beginning of the
previous read.

For consequence,
> folio_mark_accessed() will not be called for 'fbatch.folios[0]' since
> 'iocb->ki_pos' is always equal to 'ra->prev_pos'.

I don't follow this, but maybe I'm just being slow.
