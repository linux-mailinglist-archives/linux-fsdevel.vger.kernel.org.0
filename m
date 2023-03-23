Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127886C5D3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 04:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCWD34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 23:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjCWD3k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:29:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A332F07E;
        Wed, 22 Mar 2023 20:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3swr9uOuonCYschB+/pOWIFUqX6a9xK8BK3ZWmDabl0=; b=kRu4PHmcLUSg+iU9PT5AfuzmMh
        u3zy6ZdPLp7KY+MT1QQXUdsA4kOod4RRsHWV1Czb/4LXWxOApx+PLdTYvpvq3k32fGpQIhTk0Hcc9
        AnqgBWs/auu2su0xc3Hx4Eo/z15o6KhiXTX4Su38NB/K+1xMoq7f6S007L70vDcryC5h5AEpbivJ1
        qBCoAMQ/kTjR/Xaklp/hk3w54iPfTqZaA8Gb6T2O9gPAcNj1+NaBcZxy3PT+4ge635YOn1SRa2IuG
        GkuEGTKIi0QN+1RlpBJNygBqOYcOJusHsYssButsGqa3c4MdkmuLcokbWJbuUsUMbGyfWhYgk8/BX
        0P/0F+Kw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfBdw-003ddR-E0; Thu, 23 Mar 2023 03:29:36 +0000
Date:   Thu, 23 Mar 2023 03:29:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/31] ext4: Convert ext4_writepage() to use a folio
Message-ID: <ZBvHoGLwxDoBL6XM@casper.infradead.org>
References: <20230126202415.1682629-6-willy@infradead.org>
 <87y1o9vhvq.fsf@doe.com>
 <20230314222646.GT860405@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314222646.GT860405@mit.edu>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 14, 2023 at 06:26:46PM -0400, Theodore Ts'o wrote:
> On Tue, Mar 07, 2023 at 12:15:13AM +0530, Ritesh Harjani wrote:
> > "Matthew Wilcox (Oracle)" <willy@infradead.org> writes:
> > 
> > > Prepare for multi-page folios and save some instructions by converting
> > > to the folio API.
> > 
> > Mostly a straight forward change. The changes looks good to me.
> > Please feel free to add -
> > 
> > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > 
> > In later few patches I see ext4_readpage converted to ext4_read_folio().
> > I think the reason why we have not changed ext4_writepage() to
> > ext4_write_folio() is because we anyway would like to get rid of
> > ->writepage ops eventually in future, so no point.
> > I think there is even patch series from Jan which tries to kill
> > ext4_writepage() completely.
> 
> Indeed, Jan's patch series[1] is about to land in the ext4 tree, and
> that's going to remove ext4_writepages.  The main reason why this
> hadn't landed yet was due to some conflicts with some other folio
> changes, so you should be able to drop this patch when you rebase this
> patch series.

Correct; in the rebase, I ended up just dropping this patch.
