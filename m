Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5894D414F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 07:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbiCJGr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 01:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiCJGr4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 01:47:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D34212F16B;
        Wed,  9 Mar 2022 22:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QYoybJRryYmwPgaJ9ZMJlhq3VSC3EaI4oWd0Salhzq8=; b=sDQewlcmFcu36Plc0ssMjwdcu6
        xABG21CxjYWaSekz0olxZSfCTlCmo8Mhvq0wjUyF61q3WYWn4mJO5jJ+YRNV2FgmHgdHvlvEKS10J
        Kw9ofVwcAnLSjRiv2hiP8WUV8vDzoO7gvCa8aCC61A1gWW3gvhKFjgXhiY4AIH33exK5udpJC6+WQ
        LMBSDr7eKStarZPgyLBpw7R5/DJ15UN1G17udcx52OuQOj/GdrvmLlBmPysvBU/hyvE99GuH50u+N
        LaTQasVqJnNogROVUyJfNCsIdbVDDDlXGMsRWTtLk9VCLznBg5V3CitLMY0ESGKauhy8PdKGxTqkS
        rmiKZVDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSCZY-00BePO-KI; Thu, 10 Mar 2022 06:46:52 +0000
Date:   Wed, 9 Mar 2022 22:46:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgel.zte@gmail.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] block/psi: remove PSI annotations from submit_bio
Message-ID: <Yime3HdbEqFgRVtO@infradead.org>
References: <20220309094323.2082884-1-yang.yang29@zte.com.cn>
 <Yij9eygSYy5MSIA0@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yij9eygSYy5MSIA0@cmpxchg.org>
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

On Wed, Mar 09, 2022 at 02:18:19PM -0500, Johannes Weiner wrote:
> On Wed, Mar 09, 2022 at 09:43:24AM +0000, cgel.zte@gmail.com wrote:
> > From: Yang Yang <yang.yang29@zte.com.cn>
> > 
> > psi tracks the time spent submitting the IO of refaulting pages[1].
> > But after we tracks refault stalls from swap_readpage[2][3], there
> > is no need to do so anymore. Since swap_readpage already includes
> > IO submitting time.
> > 
> > [1] commit b8e24a9300b0 ("block: annotate refault stalls from IO submission")
> > [2] commit 937790699be9 ("mm/page_io.c: annotate refault stalls from swap_readpage")
> > [3] commit 2b413a1a728f ("mm: page_io: fix psi memory pressure error on cold swapins")
> > 
> > Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> > Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> It's still needed by file cache refaults!

Can we get proper annotations for those please?  These bio-level hooks are
horrible and a maintainance nightmware.
