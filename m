Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A44712265
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 10:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242271AbjEZIi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 04:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242622AbjEZIi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 04:38:56 -0400
Received: from out-58.mta1.migadu.com (out-58.mta1.migadu.com [IPv6:2001:41d0:203:375::3a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8C6189
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 01:38:51 -0700 (PDT)
Date:   Fri, 26 May 2023 04:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685090329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yHu4Pz64nDZSjcqDec3QpKXS1/Ocd0ra+J22ys59U50=;
        b=Dt1IiiWg0fUjae2EuGVoz9gw9KLrFZ4KGWIBr2jlc7uTvzwpUT6ITWY2wRLaXZrGAQJKZZ
        BFBJqnkSYYmR83YZhe9VpxaGZImQK8VN/Q3ryMG8CqcsZmkq+Kp8Eq6xCl1n+f5+48lgXH
        D+SnRTiyC5GWq+bYGDli1ocUPAm32Dw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>, Jan Kara <jack@suse.cz>,
        cluster-devel@redhat.com, "Darrick J . Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [Cluster-devel] [PATCH 06/32] sched: Add
 task_struct->faults_disabled_mapping
Message-ID: <ZHBwEYupK2gxLOjn@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-7-kent.overstreet@linux.dev>
 <20230510010737.heniyuxazlprrbd6@quack3>
 <ZFs3RYgdCeKjxYCw@moria.home.lan>
 <20230523133431.wwrkjtptu6vqqh5e@quack3>
 <ZGzoJLCRLk+pCKAk@infradead.org>
 <CAHpGcML0CZ1RGkOf26iYt_tK0Ux=cfdW8d3bjMVbjXLr91cs+g@mail.gmail.com>
 <ZG/tTorh8G2919Jz@moria.home.lan>
 <ZHBpg4ndZ2CLP7mi@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHBpg4ndZ2CLP7mi@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 01:10:43AM -0700, Christoph Hellwig wrote:
> On Thu, May 25, 2023 at 07:20:46PM -0400, Kent Overstreet wrote:
> > > > I'm absolutely not in favour to add workarounds for thes kind of locking
> > > > problems to the core kernel.  I already feel bad for allowing the
> > > > small workaround in iomap for btrfs, as just fixing the locking back
> > > > then would have avoid massive ratholing.
> > > 
> > > Please let me know when those btrfs changes are in a presentable shape ...
> > 
> > I would also be curious to know what btrfs needs and what the approach
> > is there.
> 
> btrfs has the extent locked, where "extent locked" is a somewhat magic
> range lock that actually includes different lock bits.  It does so
> because it clears the page writeback bit when the data made it to the
> media, but before the metadata required to find it is commited, and
> the extent lock prevents it from trying to do a readpage on something
> that has actually very recently been written back but not fully
> commited.  Once btrfs is changed to only clear the page writeback bit
> once the write is fully commited like in other file systems this extra
> level of locking can go away, and there are no more locks in the
> readpage path that are also taken by the direct I/O code.  With that
> a lot of code in btrfs working around this can go away, including the
> no fault direct I/O code.

wow, yeah, that is not how that is supposed to work...
