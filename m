Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321F86CF77C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 01:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjC2Xgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 19:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjC2Xgo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:36:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9235251
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WcXAXYvm6Tc9/O2kVJi/u7CmOyhXguY1LxrFFNUvwXQ=; b=iJgFUCreWR1Nh+2+qFvszA3EW3
        HkRIfqHlhi3Z5CDM7aZ5LJwxyYARce13lSwY3WhCxLhz02QSjz9wPhGP0TtJH98K6XRWz+46ovxrI
        zV1d+BRk6F16oSV+BVsKc64zLgnyqwhOmO6fjmV+bmsZH4DPRqncFuzqrMG36Ssgfn8FW7L6fLwHy
        DM7nfcv8vWyOmmEirGZy8nmrGn2YkzIVDavuXP/b17Wo9MAxrlaTQ4vOGZI+yGxSZbvHq4NHRHw2O
        xWwx8g4m6CQuNI2cOioazkyxhuPgpVktT2nHSTJdRvxR8mtK4becpqhGhGrwzP1U6669uysF+5bXb
        a92GkSqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phfLP-0024mc-1Y;
        Wed, 29 Mar 2023 23:36:43 +0000
Date:   Wed, 29 Mar 2023 16:36:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hans Holmberg <hans.holmberg@wdc.com>
Subject: Re: [PATCH] zonefs: Always invalidate last cache page on append write
Message-ID: <ZCTLi+TByEjPIGg5@infradead.org>
References: <20230329055823.1677193-1-damien.lemoal@opensource.wdc.com>
 <ZCPzbFzjFyiOVDdl@infradead.org>
 <46acc134-3f38-2a2d-c2aa-11d2fbee2abc@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46acc134-3f38-2a2d-c2aa-11d2fbee2abc@opensource.wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 29, 2023 at 05:27:43PM +0900, Damien Le Moal wrote:
> > But why does this not follow the logic in __iomap_dio_rw to to return
> > -ENOTBLK for any error so that the write falls back to buffered I/O.
> 
> This is a write to sequential zones so we cannot use buffered writes. We have to
> do a direct write to ensure ordering between writes.
> 
> Note that this is the special blocking write case where we issue a zone append.
> For async regular writes, we use iomap so this bug does not exist. But then I
> now realize that __iomap_dio_rw() falling back to buffered IOs could also create
> an issue with write ordering.

Can we add a comment please on why this is different?  And maybe bundle
the iomap-using path fix into the series while you're at it.

> > Also as far as I can tell from reading the code, -1 is not a valid
> > end special case for invalidate_inode_pages2_range, so you'll actually
> > have to pass a valid end here.
> 
> I wondered about that but then saw:
> 
> int invalidate_inode_pages2(struct address_space *mapping)
> {
> 	return invalidate_inode_pages2_range(mapping, 0, -1);
> }
> EXPORT_SYMBOL_GPL(invalidate_inode_pages2);
> 
> which tend to indicate that "-1" is fine. The end is passed to
> find_get_entries() -> find_get_entry() where it becomes a "max" pgoff_t, so
> using -1 seems fine.

Oh, indeed.  There's a little magic involved.  Still, any reason not to
pass the real end like iomap?
