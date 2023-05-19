Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46EC709BB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 17:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjESPxo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 11:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjESPxn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 11:53:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61000B2;
        Fri, 19 May 2023 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=USlAGqydtnLM3TYHWN6L8pKx67GkcR3rUcBpLI3d92s=; b=G/ydLPvEq3QNDQSGLbVpkoPsd8
        i3AjboE9lWpFNQxzRYZ7AssvFe7g4D6JXMP5pXRIs5YmKrt0kOB+8P0sYAcJzlG7obOQ69lYNwmH1
        DfsYTD2AZB5jm16Q/SdZVPMQqBpUik//d8s8sFtveSWTbCJGoRk713TVux7kNCOFe2TDybWdp9dGg
        92Nr0+busVJh8lmT6Dw+5pp8mvvW5naYEz+NyFLDTfM1llhnEMq5Xd/Z+btwQKhwmMWiJYJ5HuBE4
        C6NPjKZCV1KcvoUT0Ut1brnAp7COVvFa37m27HJlIGzmuNnrN6CXcUrh9xipGceSnxy+i+D2eaZiG
        TFcjlosw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q02QD-006eus-GU; Fri, 19 May 2023 15:53:37 +0000
Date:   Fri, 19 May 2023 16:53:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv5 4/5] iomap: Allocate iop in ->write_begin() early
Message-ID: <ZGebgckh3oSvQSEt@casper.infradead.org>
References: <ZGXD8T1Kv4NafQmO@infradead.org>
 <875y8owdrm.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875y8owdrm.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 08:48:37PM +0530, Ritesh Harjani wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> 
> > On Mon, May 08, 2023 at 12:57:59AM +0530, Ritesh Harjani (IBM) wrote:
> >> Earlier when the folio is uptodate, we only allocate iop at writeback
> >
> > s/Earlier/Currently/ ?
> >
> >> time (in iomap_writepage_map()). This is ok until now, but when we are
> >> going to add support for per-block dirty state bitmap in iop, this
> >> could cause some performance degradation. The reason is that if we don't
> >> allocate iop during ->write_begin(), then we will never mark the
> >> necessary dirty bits in ->write_end() call. And we will have to mark all
> >> the bits as dirty at the writeback time, that could cause the same write
> >> amplification and performance problems as it is now.
> >>
> >> However, for all the writes with (pos, len) which completely overlaps
> >> the given folio, there is no need to allocate an iop during
> >> ->write_begin(). So skip those cases.
> >
> > This reads a bit backwards, I'd suggest to mention early
> > allocation only happens for sub-page writes before going into the
> > details.
> >
> 
> sub-page is a bit confusing here. Because we can have a large folio too
> with blocks within that folio. So we decided to go with per-block
> terminology [1].
> 
> [1]: https://lore.kernel.org/linux-xfs/ZFR%2FGuVca5nFlLYF@casper.infradead.org/
> 
> I am guessing you would like to me to re-write the above para. Is this better?
> 
> "We dont need to allocate an iop in ->write_begin() for writes where the
> position and length completely overlap with the given folio.
> Therefore, such cases are skipped."

... and reorder that paragraph to be first.
