Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE406F8D06
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 02:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjEFAI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 20:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjEFAI0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 20:08:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CD419B0;
        Fri,  5 May 2023 17:08:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFD6563C72;
        Sat,  6 May 2023 00:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD13C433EF;
        Sat,  6 May 2023 00:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683331704;
        bh=7+4RZ/Snpwvb0zzhi2RjjXRKKk3ABC6o+jcKXRjDTg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uJ4CUV1iru3AnzNtA79biymZMjwlHUzSgyfnsWmqGPjDok6TGCQSj9uC7b3O3oPJJ
         7hYekNdQmu7P41mSRVxUZKoW7l4b2DBxXauxvQJ5VcutuHeMtpvZQrN2ZvYFBY8C0w
         cFwasIhIocEciWso+pgv0fKmhODCmMTdicFt3Zbm+IEEHYWZteSMzg5HUaEWh1wYsS
         n6woXHFNKHnn6crfiO3t2IWj/U18s5SnVAkRwJYqfkT4yzROMYiHzuA22rvffXunMJ
         gSApl7UVcU5tNNRz9aag+tq4sRGFtmNYW7vA1PrXzNDpkEpBxiGadFRA0LlgL6wbC/
         NAGXWNH4WT4Sw==
Date:   Sat, 6 May 2023 00:08:22 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH RFC 01/16] block: Add atomic write operations to
 request_queue limits
Message-ID: <ZFWadsMT0xck9lYQ@gmail.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-2-john.g.garry@oracle.com>
 <20230503213925.GD3223426@dread.disaster.area>
 <fc91aa12-1707-9825-a77e-9d5a41d97808@oracle.com>
 <20230504222623.GI3223426@dread.disaster.area>
 <ZFWHdxgWie/C02OA@gmail.com>
 <20230505233152.GN3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505233152.GN3223426@dread.disaster.area>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 06, 2023 at 09:31:52AM +1000, Dave Chinner wrote:
> On Fri, May 05, 2023 at 10:47:19PM +0000, Eric Biggers wrote:
> > On Fri, May 05, 2023 at 08:26:23AM +1000, Dave Chinner wrote:
> > > > ok, we can do that but would also then make statx field 64b. I'm fine with
> > > > that if it is wise to do so - I don't don't want to wastefully use up an
> > > > extra 2 x 32b in struct statx.
> > > 
> > > Why do we need specific varibles for DIO atomic write alignment
> > > limits? We already have direct IO alignment and size constraints in statx(),
> > > so why wouldn't we just reuse those variables when the user requests
> > > atomic limits for DIO?
> > > 
> > > i.e. if STATX_DIOALIGN is set, we return normal DIO alignment
> > > constraints. If STATX_DIOALIGN_ATOMIC is set, we return the atomic
> > > DIO alignment requirements in those variables.....
> > > 
> > > Yes, we probably need the dio max size to be added to statx for
> > > this. Historically speaking, I wanted statx to support this in the
> > > first place because that's what we were already giving userspace
> > > with XFS_IOC_DIOINFO and we already knew that atomic IO when it came
> > > along would require a bound maximum IO size much smaller than normal
> > > DIO limits.  i.e.:
> > > 
> > > struct dioattr {
> > >         __u32           d_mem;          /* data buffer memory alignment */
> > >         __u32           d_miniosz;      /* min xfer size                */
> > >         __u32           d_maxiosz;      /* max xfer size                */
> > > };
> > > 
> > > where d_miniosz defined the alignment and size constraints for DIOs.
> > > 
> > > If we simply document that STATX_DIOALIGN_ATOMIC returns minimum
> > > (unit) atomic IO size and alignment in statx->dio_offset_align (as
> > > per STATX_DIOALIGN) and the maximum atomic IO size in
> > > statx->dio_max_iosize, then we don't burn up anywhere near as much
> > > space in the statx structure....
> > 
> > I don't think that's how statx() is meant to work.  The request mask is a bitmask, and the user can
> > request an arbitrary combination of different items.  For example, the user could request both
> > STATX_DIOALIGN and STATX_WRITE_ATOMIC at the same time.  That doesn't work if different items share
> > the same fields.
> 
> Sure it does - what is contained in the field on return is defined
> by the result mask. In this case, whatever the filesystem puts in
> the DIO fields will match which flag it asserts in the result mask.
> 
> i.e. if the application wants RWF_ATOMIC and so asks for STATX_DIOALIGN |
> STATX_DIOALIGN_ATOMIC in the request mask then:
> 
> - if the filesystem does not support RWF_ATOMIC it fills in the
>   normal DIO alingment values and puts STATX_DIOALIGN in the result
>   mask.
> 
>   Now the application knows that it can't use RWF_ATOMIC, and it
>   doesn't need to do another statx() call to get the dio alignment
>   values it needs.
> 
> - if the filesystem supports RWF_ATOMIC, it fills in the values with
>   the atomic DIO constraints and puts STATX_DIOALIGN_ATOMIC in the
>   result mask.
> 
>   Now the application knows it can use RWF_ATOMIC and has the atomic
>   DIO constraints in the dio alignment fields returned.
> 
> This uses the request/result masks exactly as intended, yes?
> 

We could certainly implement some scheme like that, but I don't think that was
how statx() was intended to work.  I think that each bit in the mask was
intended to correspond to an independent piece of information.

- Eric
