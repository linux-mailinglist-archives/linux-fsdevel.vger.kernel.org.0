Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8588B74CACB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 05:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjGJDpR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jul 2023 23:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjGJDpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jul 2023 23:45:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078ECC3;
        Sun,  9 Jul 2023 20:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MyBw3qPFBVUJngMbpYtaVZ58lnbEWQd/Zkvilzd8c80=; b=dD9s2dB6bRn+rI0PuvHq8LurHY
        ZGjyHrRC3iRlNS8qTXeViIwK50G08EG2HusZcOoqWtnpFJpZQ0ET64KRSSTFAyXAs5AlzhASbxUIg
        3OkP52kyxl+nqxDXprrMczjB9O7jty0Usdf78QsXcG564wqz3WRc1D88uUVRKC6pDLHsv+oU5eWYd
        yvv+bddQwzKtBuUbTeeweHu0ei85tZiRXisOLRRQ4kFecovQVuW645ZpAwgFpUpONqt74EBNEFPmw
        2NTaRiktViktBwIlfMpX0/jTBqsnh3PAh/s5Q8BtoO8jSVhm4wJAi0J/P24I1AU4zQSGAv2ulLQw2
        fA6/roqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIhpf-00EFMv-Ul; Mon, 10 Jul 2023 03:45:03 +0000
Date:   Mon, 10 Jul 2023 04:45:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 8/8] iomap: Copy larger chunks from userspace
Message-ID: <ZKt+v+Hcs08q2uBw@casper.infradead.org>
References: <20230612203910.724378-1-willy@infradead.org>
 <20230612203910.724378-9-willy@infradead.org>
 <ZIf3jom4xteSmj5/@infradead.org>
 <ZIjG9Rc7s89oUbxF@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIjG9Rc7s89oUbxF@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 08:43:49PM +0100, Matthew Wilcox wrote:
> > > -		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
> > > +		copied = copy_page_from_iter_atomic(&folio->page, offset, bytes, i);
> > 
> > Would be nice t avoid the overly long line here
> 
> The plan is to turn that into:
> 
> 		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
> 
> in the fairly near future.

Kent bugged me to add copy_folio_from_iter_atomic() now, and he's right,
so "the near future" is v4.
