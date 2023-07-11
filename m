Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5AD74E279
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 02:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjGKANz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 20:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjGKANy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:13:54 -0400
Received: from out-17.mta0.migadu.com (out-17.mta0.migadu.com [IPv6:2001:41d0:1004:224b::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5268FB
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 17:13:52 -0700 (PDT)
Date:   Mon, 10 Jul 2023 20:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689034430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EnNFGZHfV5N5ZNTEHBuqL1ViZwIfvECr+nHwgjFpWZ4=;
        b=ljOCg06rtqxxmv9ANo8RSvG3XkmzKHDB1c11HOlO0KxzxItkQHFOie2+h5Q+zOfgq2EyqD
        gCTIfnrV1sxsx9Z/1ytY1TGismJEmWuHjZmyTZEYSq+OJvTq+TO861+L8ys0o/LCkgtZnw
        dXZQnYdMwWFcuokDCXG38Il9iulKbJE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 7/9] filemap: Allow __filemap_get_folio to allocate
 large folios
Message-ID: <20230711001346.nupvyrb3hbrpmjww@moria.home.lan>
References: <20230710130253.3484695-1-willy@infradead.org>
 <20230710130253.3484695-8-willy@infradead.org>
 <ZKybP22DRs1w4G3a@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKybP22DRs1w4G3a@bombadil.infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 04:58:55PM -0700, Luis Chamberlain wrote:
> Curious how this ended up being the heuristic used to shoot for the
> MAX_PAGECACHE_ORDER sky first, and then go down 1/2 each time. I don't
> see it explained on the commit log but I'm sure there's has to be
> some reasonable rationale. From the cover letter, I could guess that
> it means the gains of always using the largest folio possible means
> an implied latency savings through other means, so the small latencies
> spent looking seem to no where compare to the saving in using. But
> I rather understand a bit more for the rationale.
> 
> Are there situations where perhaps limitting this initial max preferred
> high order folio might be smaller than MAX_PAGECACHE_ORDER? How if not,
> how do we know?

It's the exact same situation as when filesystems all switched from
blocks to extents 10-20 years ago. We _always_ want our allocations to
be as big as possible - it reduces metadata overhead, preserves
locality, reduces fragmentation - IOW, this is clearly the right thing
to do.
