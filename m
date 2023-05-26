Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D773C7121D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 10:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242141AbjEZIKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 04:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjEZIKs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 04:10:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF85A3;
        Fri, 26 May 2023 01:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=suhlTCSdjkwwCawJJF8xodaRhqnhkhv/03FtDn0nrOI=; b=tCeXdpnjIrisiE5m4fviMykCZM
        emIGqDMnuraL69ZBQClwz9W5TwOdaRmgfR3TYzCi0uVuuJEylosRLO2SvcUrkXpvuO9oqw+a0g3OT
        bAoqVzgmHhqAjOpBj3sjh6tt1ZFBzmPKiDvqzAH+lBJDcjJJ002eMMGJhFrsQksoEhM/uk0BYn3Il
        pgC1Vtgei1mUfCtfs49VBDMl+gfz08PWuZKP+2hjCQSbvl1uWsieaxq7tYicHez+vLZnxiSvVxgHw
        7vYznUgGpMrWgtblFEOVASqAocMzPkZbbGE6mxSRdJED5Xjq02c8pmS0OGxm5fGsTWQG9pd1tbEbH
        jNjOnkZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2SX5-001YtL-2n;
        Fri, 26 May 2023 08:10:43 +0000
Date:   Fri, 26 May 2023 01:10:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        cluster-devel@redhat.com, "Darrick J . Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [Cluster-devel] [PATCH 06/32] sched: Add
 task_struct->faults_disabled_mapping
Message-ID: <ZHBpg4ndZ2CLP7mi@infradead.org>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-7-kent.overstreet@linux.dev>
 <20230510010737.heniyuxazlprrbd6@quack3>
 <ZFs3RYgdCeKjxYCw@moria.home.lan>
 <20230523133431.wwrkjtptu6vqqh5e@quack3>
 <ZGzoJLCRLk+pCKAk@infradead.org>
 <CAHpGcML0CZ1RGkOf26iYt_tK0Ux=cfdW8d3bjMVbjXLr91cs+g@mail.gmail.com>
 <ZG/tTorh8G2919Jz@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG/tTorh8G2919Jz@moria.home.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 07:20:46PM -0400, Kent Overstreet wrote:
> > > I'm absolutely not in favour to add workarounds for thes kind of locking
> > > problems to the core kernel.  I already feel bad for allowing the
> > > small workaround in iomap for btrfs, as just fixing the locking back
> > > then would have avoid massive ratholing.
> > 
> > Please let me know when those btrfs changes are in a presentable shape ...
> 
> I would also be curious to know what btrfs needs and what the approach
> is there.

btrfs has the extent locked, where "extent locked" is a somewhat magic
range lock that actually includes different lock bits.  It does so
because it clears the page writeback bit when the data made it to the
media, but before the metadata required to find it is commited, and
the extent lock prevents it from trying to do a readpage on something
that has actually very recently been written back but not fully
commited.  Once btrfs is changed to only clear the page writeback bit
once the write is fully commited like in other file systems this extra
level of locking can go away, and there are no more locks in the
readpage path that are also taken by the direct I/O code.  With that
a lot of code in btrfs working around this can go away, including the
no fault direct I/O code.
