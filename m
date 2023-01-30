Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAD368185E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 19:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbjA3SKM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 13:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbjA3SKL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:10:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535252131;
        Mon, 30 Jan 2023 10:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Aw1B0SJB41Kn/RO5TPgT3eau1lDRPOPOl45ouvHACUw=; b=uhdazshlsy3HBJ5cLPji2ttMUR
        DWAk8xuEDysEhUWTrlS4779U6Lb/1QsM1FlLSeStv33p11xhmoMwkxuqiBWU95PiILQq3rNiv+lld
        PWyPNkAduT7k+umvVsPH74WvLBIjs5JUmK+9l6ODYBSPgy6Cc0KbU5Awm2Cgj+tX+msnon7j+gBUr
        rYRPbZIQH4zLgzwmyVztdvxOjSCXjXpkTTJ2cpStKhETRhjlINgoi7bI9nuusqaaz559cji+dU5M6
        YD9qG9KPIu8QEJWZguJFsW8LyiHeeQnSyOvKbRCBIQ0+oUd41aVjajKYvWj/wppJ+AtWYoxIodoJ7
        yH7OpMIg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMYbY-00AZZi-1X; Mon, 30 Jan 2023 18:10:08 +0000
Date:   Mon, 30 Jan 2023 18:10:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv2 0/3] iomap: Add support for subpage dirty state tracking
 to improve write performance
Message-ID: <Y9gIAKOVAsM2tTZ5@casper.infradead.org>
References: <cover.1675093524.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675093524.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 30, 2023 at 09:44:10PM +0530, Ritesh Harjani (IBM) wrote:
> TODOs
> ======
> 1. I still need to work on macros which we could declare and use for easy
>    reference to uptodate/dirty bits in iop->state[] bitmap (based on previous
>    review comments).

I'm not sure it was worth posting this series without doing this, tbh.

> 5. To address one of the other review comments like what happens with a large
>    folio. Can we limit the size of bitmaps if the folio is too large e.g. > 2MB.
> 
>    [RH] - I can start looking into this area too, if we think these patches
>    are looking good. My preference would be to work on todos 1-4 as part of this
>    patch series and take up bitmap optimization as a follow-up work for next
>    part. Please do let me know your thoughts and suggestions on this.

I was hoping to push you towards investigating a better data structure
than a bitmap.  I know a bitmap solves your immediate problem since
there are only 16 4kB blocks in a 64kB page, but in a linear-read
scenario, XFS is going to create large folios on POWER machines, all
the way up to 16MB IIUC.  Whatever your PMD page size is.  So you're
going to be exposed to this in some scenarios, even if you're not seeing
them in your current testing.
