Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C0F5B8E41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 19:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiINRjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 13:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiINRju (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:39:50 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210AC1CFFF;
        Wed, 14 Sep 2022 10:39:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 52F95CE16CF;
        Wed, 14 Sep 2022 17:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4513C433D6;
        Wed, 14 Sep 2022 17:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663177185;
        bh=jAoe8rod4miBlbOtF7K50ewWnbNqgqXI3Yje7HLHh+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mzldVwPEZfcuVCDzLrIdyphRXNOD7zQBlXZkE2k2TWCpO/cNRm5tjDOee42OVONnu
         lMMAG4PdkfJdBcaUp5PxvrrJ3D17CHBheNWIREv7ixEdYSC5JCjei/WdCHxmV8UpxW
         2vKvzktwyH/RQIXifZWUO7CNMxiSGq1ct4VbRauIhUkuAbjbK7gU6Liyo8ciRVCgEN
         hD7ooMrJE1CnU+94JdCM1MHD1uyL0qG5IvTpwRqEw750w06njtqVWMeLrQGQWzik1A
         n1h9X7Q/mum5bjtq5+yjIHthLMyvHzv2PmI6jGaUHut4IB83rqdPk1JeSpgkFZySm+
         68VOE4e2Rv7AQ==
Date:   Wed, 14 Sep 2022 10:39:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [POC][PATCH] xfs: reduce ilock contention on buffered randrw
 workload
Message-ID: <YyIR4XmDYkYIK2ad@magnolia>
References: <CAOQ4uxgu4uKJp5t+RoumMneR6bw_k0CRhGhU-SLAky4VHSg9MQ@mail.gmail.com>
 <20220617151135.yc6vytge6hjabsuz@quack3>
 <CAOQ4uxjvx33KRSm-HX2AjL=aB5yO=FeWokZ1usDKW7+R4Ednhg@mail.gmail.com>
 <20220620091136.4uosazpwkmt65a5d@quack3.lan>
 <CAOQ4uxg+uY5PdcU1=RyDWCxbP4gJB3jH1zkAj=RpfndH9czXbg@mail.gmail.com>
 <20220621085956.y5wyopfgzmqkaeiw@quack3.lan>
 <CAOQ4uxheatf+GCHxbUDQ4s4YSQib3qeYVeXZwEicR9fURrEFBA@mail.gmail.com>
 <CAOQ4uxguwnx4AxXqp_zjg39ZUaTGJEM2wNUPnNdtiqV2Q9woqA@mail.gmail.com>
 <YyH61deSiW1TnY//@magnolia>
 <CAOQ4uxhFJWW-ykyzomHCUWfWvbJNEmetw0G5mUYjFGoYJBb7NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhFJWW-ykyzomHCUWfWvbJNEmetw0G5mUYjFGoYJBb7NA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 14, 2022 at 07:29:15PM +0300, Amir Goldstein wrote:
> > > Dave, Christoph,
> > >
> > > I know that you said that changing the atomic buffered read semantics
> > > is out of the question and that you also objected to a mount option
> > > (which nobody will know how to use) and I accept that.
> > >
> > > Given that a performant range locks implementation is not something
> > > trivial to accomplish (Dave please correct me if I am wrong),
> > > and given the massive performance impact of XFS_IOLOCK_SHARED
> > > on this workload,
> > > what do you think about POSIX_FADV_TORN_RW that a specific
> > > application can use to opt-out of atomic buffer read semantics?
> > >
> > > The specific application that I want to modify to use this hint is Samba.
> > > Samba uses IO threads by default to issue pread/pwrite on the server
> > > for IO requested by the SMB client. The IO size is normally larger than
> > > xfs block size and the range may not be block aligned.
> > >
> > > The SMB protocol has explicit byte range locks and the server implements
> > > them, so it is pretty safe to assume that a client that did not request
> > > range locks does not need xfs to do the implicit range locking for it.
> > >
> > > For this reason and because of the huge performance win,
> > > I would like to implement POSIX_FADV_TORN_RW in xfs and
> > > have Samba try to set this hint when supported.
> > >
> > > It is very much possible that NFSv4 servers (user and kennel)
> > > would also want to set this hint for very similar reasons.
> > >
> > > Thoughts?
> >
> > How about range locks for i_rwsem and invalidate_lock?  That could
> > reduce contention on VM farms, though I can only assume that, given that
> > I don't have a reference implementation to play with...
> >
> 
> If you are asking if I have the bandwidth to work on range lock
> then the answer is that I do not.
> 
> IIRC, Dave had a WIP and ran some benchmarks with range locks,
> but I do not know at which state that work is.

Yeah, that's what I was getting at -- I really wish Dave would post that
as an RFC.  The last time I talked to him about it, he was worried that
the extra complexity of the range lock structure would lead to more
memory traffic and overhead.

I /know/ there are a lot of cloud vendors that would appreciate the
speedup that range locking might provide.  I'm also fairly sure there
are also people who want maximum single threaded iops and will /not/
like range locks, but I think we ought to let kernel distributors choose
which one they want.

Recently I've been playing around with static keys, because certain
parts of xfs online fsck need to hook into libxfs.  The hooks have some
overhead, so I'd want to reduce the cost of that to making the
instruction prefetcher skip over a nop sled when fsck isn't running.
I sorta suspect this is a way out -- the distributor selects a default
locking implementation at kbuild time, and we allow a kernel command
line parameter to switch (if desired) during early boot.  That only
works if the compiler supports asm goto (iirc) but that's not /so/
uncommon.

I'll try to prod Dave about this later today, maybe we can find someone
to work on it if he'd post the prototype.

--D

> The question is, if application developers know (or believe)
> that their application does not care about torn reads, are we
> insisting not to allow them to opt out of atomic buffered reads
> (which they do not need) because noone has the time to
> work on range locks?
> 
> If that is the final decision then if customers come to me to
> complain about this workload, my response will be:
> 
> If this workload is important for your application, either
> - contribute developer resource to work on range locks
> - carry a patch in your kernel
> or
> - switch to another filesystem for this workload
> 
> Thanks,
> Amir.
