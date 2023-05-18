Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072F370828C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 15:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjERNXt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 09:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjERNXt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 09:23:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53CCBB;
        Thu, 18 May 2023 06:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p7WPAiiP1+l/v91wtZxt/kJMNO4614hppLHqWWBhGMg=; b=mYRVJ5Hm7wgyOY1ODfHa4Gtojp
        LSm3WoxxhzA/S883B5Ml+6XvAJT2goAasC86GQoFuCqwyxwPaqM7PQ85bRtfihnc8muIzzp3QAAXq
        XtOzc+o9jAc/YcaPaz9W5ojCfjkvDs24uTWdwG1EFQGi7tr8Rp71JOUAWo9DPGgHaSrm8Ep33b8f4
        1xzywl0LgXC/VpJePKMiZxz3ioh758EhGjUxcEoTKMNC34kPFaZb0+maEXCLvvP7s7LaCgI/kvv02
        Z7Zxk2V74/r43SxK1bxmAPqCaO7EfbdkfzLLUV8FYtNfdct8g3VvDpIiRfk/S71LvccwjUHsIUT+X
        h7WGe8GQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzdbc-00D4Yg-34;
        Thu, 18 May 2023 13:23:44 +0000
Date:   Thu, 18 May 2023 06:23:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv5 5/5] iomap: Add per-block dirty state tracking to improve
 performance
Message-ID: <ZGYm4BeVFz94zzy+@infradead.org>
References: <ZGPZhMr0ZiPDxVkw@bfoster>
 <87bkij3ry0.fsf@doe.com>
 <ZGUhbM9uSk9loUPH@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGUhbM9uSk9loUPH@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 02:48:12PM -0400, Brian Foster wrote:
> But I also wonder.. if we can skip the iop alloc on full folio buffered
> overwrites, isn't that also true of mapped writes to folios that don't
> already have an iop?

Yes.

> I.e., I think what I was trying to do in the
> previous diff was actually something like this:
> 
> bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
> {
>         iop_set_range_dirty(mapping->host, folio, 0, folio_size(folio));
>         return filemap_dirty_folio(mapping, folio);
> }
> 
> ... which would only dirty the full iop if it already exists. Thoughts?

That does sound pretty good to me, and I can't think of any obvious
pitfall.
