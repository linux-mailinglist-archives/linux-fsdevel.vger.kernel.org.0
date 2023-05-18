Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A437085BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 18:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjERQPp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 12:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjERQPn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 12:15:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C25E19A;
        Thu, 18 May 2023 09:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mTak6AGiyUTvTdKeC3xye0+anln3Ikl/IAoHTMbjKes=; b=RV6O7fLuxb7+oXUDAGGi/Ytx+t
        eQT/3QB2XIjThURpcOlO7Q7JDq4pbTOGocnYlKbx89jToEoxzbTqoWDm/wmiM51UI3IH6qlU84oxG
        S1cUdKbnoBHz3iFfpLLGHAC6afSNE4nNSocXCeRdPD6+B9gyDCxMaPVL0qODYuR+quFd6Hfj3fgSC
        Ygg93yx8/9a86wXMqOYoAywkR+sI8JHC25uTqyz1ZpzgKv/061+kcevgVpQgM8DxMnwvwGYX2cMlW
        ePphmEXVi7yc6ys/TbDTCNbgp0xD/gA4BQq3z/Hu6d4Ytw8mcKJwyI5yT1kG1dpLN83aE8dpo71DA
        EgJRWqIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pzgHt-005srm-HG; Thu, 18 May 2023 16:15:33 +0000
Date:   Thu, 18 May 2023 17:15:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Brian Foster <bfoster@redhat.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv5 5/5] iomap: Add per-block dirty state tracking to improve
 performance
Message-ID: <ZGZPJWOybo+hQVLy@casper.infradead.org>
References: <ZGPZhMr0ZiPDxVkw@bfoster>
 <87bkij3ry0.fsf@doe.com>
 <ZGUhbM9uSk9loUPH@bfoster>
 <ZGYm4BeVFz94zzy+@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGYm4BeVFz94zzy+@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 06:23:44AM -0700, Christoph Hellwig wrote:
> On Wed, May 17, 2023 at 02:48:12PM -0400, Brian Foster wrote:
> > But I also wonder.. if we can skip the iop alloc on full folio buffered
> > overwrites, isn't that also true of mapped writes to folios that don't
> > already have an iop?
> 
> Yes.

Hm, well, maybe?  If somebody stores to a page, we obviously set the
dirty flag on the folio, but depending on the architecture, we may
or may not have independent dirty bits on the PTEs (eg if it's a PMD,
we have one dirty bit for the entire folio; similarly if ARM uses the
contiguous PTE bit).  If we do have independent dirty bits, we could
dirty only the blocks corresponding to a single page at a time.

This has potential for causing some nasty bugs, so I'm inclined to
rule that if a folio is mmaped, then it's all dirty from any writable
page fault.  The fact is that applications generally do not perform
writes through mmap because the error handling story is so poor.

There may be a different answer for anonymous memory, but that doesn't
feel like my problem and shouldn't feel like any FS developer's problem.
