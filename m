Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A1C6F8C81
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 00:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjEEWrY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 18:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjEEWrX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 18:47:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FF74EC0;
        Fri,  5 May 2023 15:47:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F19136412D;
        Fri,  5 May 2023 22:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4B0C433D2;
        Fri,  5 May 2023 22:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683326841;
        bh=D0qbriAJbRPAwi0B8rnE/70zyZxx/MoRWZ/NxcKY3o4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DYLwKlKdOz6DTtddRRpzE/g5GUU5YeP9nw5j3gbN5Oz8o/mRC/Tq3TL4r8inm1/5v
         zCQxxwI42ekZKTzyB4UpzNeEHV8K12BxmOw3f/930wcqHv3deUCbnP/y6LoW3L0xzX
         tw4sbrAehxrxSzE3UA9ERBQjlnAQMcJcQ0ueaneOY4ffcP/7P8CORy9MiNBmPtCKiT
         QVlfg70i8qpYpGRLOP1VuVwqBo4hFm+BKzhtU/KyHNOcWRSUUR8Z5lmZs2GavGCrBR
         NCH4Ig18O2PysnslWZU0MjaS8vFR6Rlwh85P1WfQXTluAmwcLcbicIbNC4DMbbVoui
         YQltmUUIC6f6A==
Date:   Fri, 5 May 2023 22:47:19 +0000
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
Message-ID: <ZFWHdxgWie/C02OA@gmail.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-2-john.g.garry@oracle.com>
 <20230503213925.GD3223426@dread.disaster.area>
 <fc91aa12-1707-9825-a77e-9d5a41d97808@oracle.com>
 <20230504222623.GI3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504222623.GI3223426@dread.disaster.area>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 08:26:23AM +1000, Dave Chinner wrote:
> > ok, we can do that but would also then make statx field 64b. I'm fine with
> > that if it is wise to do so - I don't don't want to wastefully use up an
> > extra 2 x 32b in struct statx.
> 
> Why do we need specific varibles for DIO atomic write alignment
> limits? We already have direct IO alignment and size constraints in statx(),
> so why wouldn't we just reuse those variables when the user requests
> atomic limits for DIO?
> 
> i.e. if STATX_DIOALIGN is set, we return normal DIO alignment
> constraints. If STATX_DIOALIGN_ATOMIC is set, we return the atomic
> DIO alignment requirements in those variables.....
> 
> Yes, we probably need the dio max size to be added to statx for
> this. Historically speaking, I wanted statx to support this in the
> first place because that's what we were already giving userspace
> with XFS_IOC_DIOINFO and we already knew that atomic IO when it came
> along would require a bound maximum IO size much smaller than normal
> DIO limits.  i.e.:
> 
> struct dioattr {
>         __u32           d_mem;          /* data buffer memory alignment */
>         __u32           d_miniosz;      /* min xfer size                */
>         __u32           d_maxiosz;      /* max xfer size                */
> };
> 
> where d_miniosz defined the alignment and size constraints for DIOs.
> 
> If we simply document that STATX_DIOALIGN_ATOMIC returns minimum
> (unit) atomic IO size and alignment in statx->dio_offset_align (as
> per STATX_DIOALIGN) and the maximum atomic IO size in
> statx->dio_max_iosize, then we don't burn up anywhere near as much
> space in the statx structure....

I don't think that's how statx() is meant to work.  The request mask is a bitmask, and the user can
request an arbitrary combination of different items.  For example, the user could request both
STATX_DIOALIGN and STATX_WRITE_ATOMIC at the same time.  That doesn't work if different items share
the same fields.

- Eric
