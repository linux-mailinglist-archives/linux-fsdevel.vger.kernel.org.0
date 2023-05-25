Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91ED711A86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 01:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjEYXU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 19:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjEYXU4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 19:20:56 -0400
Received: from out-63.mta1.migadu.com (out-63.mta1.migadu.com [95.215.58.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1662510F
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 16:20:53 -0700 (PDT)
Date:   Thu, 25 May 2023 19:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685056851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awHDGDbBCgCx605l2nM3DZRvWVnQwgXG0c2+8QFPH08=;
        b=afc/C9pQwn3XtiqPNBF4cA1bN259A/OGSakqaqaneKEyfT/qZ+IzTmhTll1eoRS53CjktS
        5yqEL3omabBC56nM3oxDuPubjFnNq+nkFI2DfCbHeaFdHwyl4jfKNaGWZTmSpROCDL8ACY
        XxFqe+nKoVuyVihmB1LuNcS+2j/FL10=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        cluster-devel@redhat.com, "Darrick J . Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [Cluster-devel] [PATCH 06/32] sched: Add
 task_struct->faults_disabled_mapping
Message-ID: <ZG/tTorh8G2919Jz@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-7-kent.overstreet@linux.dev>
 <20230510010737.heniyuxazlprrbd6@quack3>
 <ZFs3RYgdCeKjxYCw@moria.home.lan>
 <20230523133431.wwrkjtptu6vqqh5e@quack3>
 <ZGzoJLCRLk+pCKAk@infradead.org>
 <CAHpGcML0CZ1RGkOf26iYt_tK0Ux=cfdW8d3bjMVbjXLr91cs+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcML0CZ1RGkOf26iYt_tK0Ux=cfdW8d3bjMVbjXLr91cs+g@mail.gmail.com>
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

On Fri, May 26, 2023 at 12:25:31AM +0200, Andreas Grünbacher wrote:
> Am Di., 23. Mai 2023 um 18:28 Uhr schrieb Christoph Hellwig <hch@infradead.org>:
> > On Tue, May 23, 2023 at 03:34:31PM +0200, Jan Kara wrote:
> > > I've checked the code and AFAICT it is all indeed handled. BTW, I've now
> > > remembered that GFS2 has dealt with the same deadlocks - b01b2d72da25
> > > ("gfs2: Fix mmap + page fault deadlocks for direct I/O") - in a different
> > > way (by prefaulting pages from the iter before grabbing the problematic
> > > lock and then disabling page faults for the iomap_dio_rw() call). I guess
> > > we should somehow unify these schemes so that we don't have two mechanisms
> > > for avoiding exactly the same deadlock. Adding GFS2 guys to CC.
> > >
> > > Also good that you've written a fstest for this, that is definitely a useful
> > > addition, although I suspect GFS2 guys added a test for this not so long
> > > ago when testing their stuff. Maybe they have a pointer handy?
> >
> > generic/708 is the btrfs version of this.
> >
> > But I think all of the file systems that have this deadlock are actually
> > fundamentally broken because they have a mess up locking hierarchy
> > where page faults take the same lock that is held over the the direct I/
> > operation.  And the right thing is to fix this.  I have work in progress
> > for btrfs, and something similar should apply to gfs2, with the added
> > complication that it probably means a revision to their network
> > protocol.
> 
> We do disable page faults, and there can be deadlocks in page fault
> handlers while no page faults are allowed.
> 
> I'm roughly aware of the locking hierarchy that other filesystems use,
> and that's something we want to avoid because of two reasons: (1) it
> would be an incompatible change, and (2) we want to avoid cluster-wide
> locking operations as much as possible because they are very slow.
> 
> These kinds of locking conflicts are so rare in practice that the
> theoretical inefficiency of having to retry the operation doesn't
> matter.

Would you be willing to expand on that? I'm wondering if this would
simplify things for gfs2, but you mention locking heirarchy being an
incompatible change - how does that work?

> 
> > I'm absolutely not in favour to add workarounds for thes kind of locking
> > problems to the core kernel.  I already feel bad for allowing the
> > small workaround in iomap for btrfs, as just fixing the locking back
> > then would have avoid massive ratholing.
> 
> Please let me know when those btrfs changes are in a presentable shape ...

I would also be curious to know what btrfs needs and what the approach
is there.
